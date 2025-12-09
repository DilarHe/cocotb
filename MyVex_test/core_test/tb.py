import random
import math
import cocotb
import numpy as np
from numfi import numfi
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge, Timer, Edge
from cocotb.handle import Force
import matplotlib.pyplot as plt
import sys

# 添加自定义组件
sys.path.append("/home/zyy/coco_work/cocoTest/common_lib")
sys.path.append("/home/zyy/coco_work/cocoTest/MyVex_test/core_test/zemu")
sys.path.append("/home/zyy/coco_work/cocoTest/MyVex_test/core_test/vex_utils")

from common_drivers import *
from VirtPeriph import * 
# 导入ZEMU
from ZemuISA import *
from ZemuDec import *
from ZemuFetch import *
from ZemuEX import *
from ZemuCLINT import *
# 导入cocotb-AXI component
from cocotbext.axi import AxiReadBus,AxiRamRead,AxiBus,AxiRam
from vex_utils import get_dut_gpr, get_dut_fpr, decoder_illegal_instr_monitor, pipeline_stall_monitor

async def Zemu_monitor( fetcher, decoder, executor, clint, dut, dut_clk, dut_instr_retire, axi_dram, dram_base, verbose=False):
    """
    启动ZEMU监听 Core 行为，推进ZEMU执行
    Args:
        dut: Cocotb的DUT对象
        dut_clk: DUT时钟信号
        dut_instr_retire: DUT指令退休信号
        iram: 指令内存
        dram: 数据内存
    """
    
    while True:
        await RisingEdge(dut_clk)  # 等待时钟上升沿
        # 等待DUT完成指令
        if dut_instr_retire.value :
            instr,instr_type = fetcher.fetch()
            curr_pc = fetcher.pc
            next_pc = fetcher.npc
            
            instr_info = decoder.decode(instr,instr_type,verbose=False) 

            executor.execute(curr_pc,next_pc,instr_info,verbose=False)
            
            executor.ops.mtime_value = dut.biu.mtime_1.mtime_1.value.integer  # 更新ZEMU中的mtime值

            clint.check_and_handle_irq(dut.core.clint_clint2iu_irq_execu_req.value,
                                       curr_pc,next_pc , 
                                       executor.csrs,
                                       executor.branch_taken,
                                       executor.new_pc) # 更新CLINT的timer中断状态

            #判断是否发生跳转，若跳转条件成立则更新fetcher的NPC
            if executor.is_exception:
                fetcher.npc = executor.new_pc  # 异常时更新NPC
            elif clint.irq_occurred:
                fetcher.npc = clint.irq_new_pc  # 中断时更新NPC
            elif executor.branch_taken:
                fetcher.npc = executor.new_pc
                
            # 提取ZEMU中的GPR
            zemu_gpr = executor.regs  # ZEMU中的GPR
            zemu_fpr = executor.fregs  # ZEMU中的FPR
            # 提取DUT中的GPR
            dut_gpr = get_dut_gpr(dut)  # 使用封装的方法批量提取DUT的GPR
            dut_fpr = get_dut_fpr(dut)  # 使用封装的方法批量提取DUT的FPR
            # 对比ZEMU和DUT的GPR
            for i in range(32):
                if zemu_gpr[i] != dut_gpr[i]:
                    dut._log.error(f'GPR mismatch at x{i}: ZEMU={zemu_gpr[i]:08x}, DUT={dut_gpr[i]:08x}')
                    # 抛出异常，停止仿真
                    raise AssertionError(f"GPR mismatch at x{i}: ZEMU={zemu_gpr[i]:08x}, DUT={dut_gpr[i]:08x}")
                elif verbose:
                    dut._log.info(f'GPR match at x{i}: {zemu_gpr[i]:08x}')
            # 对比ZEMU和DUT的FPR
            for i in range(32):
                if zemu_fpr[i] != dut_fpr[i]:
                    dut._log.error(f'FPR mismatch at f{i}: ZEMU={zemu_fpr[i]:08x}, DUT={dut_fpr[i]:08x}')
                    # 抛出异常，停止仿真
                    raise AssertionError(f"FPR mismatch at f{i}: ZEMU={zemu_fpr[i]:08x}, DUT={dut_fpr[i]:08x}")
                elif verbose:
                    dut._log.info(f'FPR match at f{i}: {zemu_fpr[i]:08x}')
            # 如果发生存储操作（store_taken有效），则对比内存内容
            if executor.store_taken:
                # axi_dram.mem.hexdump(0x8fffc, 16, prefix="AXI_MEM ")
                # 对比ZEMU DRAM和DUT DRAM
                for word_addr in range(0, len(executor.dram)):  # 
                    zemu_word = executor.dram[word_addr]  # ZEMU 中的对应数据
                    axi_addr = dram_base + word_addr*4
                    dut_word = int.from_bytes(axi_dram.mem[axi_addr:axi_addr+4], 'little')
                    if zemu_word != dut_word:
                        dut._log.error(f'DRAM mismatch at 0x{word_addr:08x}: ZEMU={zemu_word:08x}, DUT={dut_word:08x}')
                        # 抛出异常，停止仿真
                        raise AssertionError(f"DRAM mismatch at 0x{word_addr:08x}: ZEMU={zemu_word:08x}, DUT={dut_word:08x}")
                    elif verbose:
                        dut._log.info(f'DRAM match at 0x{word_addr:08x}: {zemu_word:08x}')       

async def terminal_monitor(dut, dut_lsu_if_we, dut_lsu_if_resp, dut_lsu_if_addr, dut_lsu_if_wdata, terminal_base, virtual_terminal):
    """
    监听 Terminal 地址的写操作。
    Args:
        dut: Cocotb 的 DUT 对象。
        terminal_base (int): Terminal 的基地址。
        virtual_terminal (VirtualTerminal): Terminal 模拟器实例。
    """
    while True:
        await RisingEdge(dut.clk)  # 等待时钟上升沿
        if dut_lsu_if_addr.value.integer == terminal_base and dut_lsu_if_we.value and dut_lsu_if_resp.value:  # 检测写使能信号
            char = dut_lsu_if_wdata.value.integer & 0xFF  # 获取写入的数据（低 8 位）
            virtual_terminal.write_char(char)                        
                                 
async def uart_monitor(dut, dut_lsu_if_we, dut_lsu_if_resp, dut_lsu_if_addr, dut_lsu_if_wdata, uart_base, virtual_uart):
    """
    监听 UART 地址的写操作。
    Args:
        dut: Cocotb 的 DUT 对象。
        uart_base (int): 串口的基地址。
        virtual_uart (VirtualUART): UART 模拟器实例。
    """
    while True:
        await RisingEdge(dut.clk)  # 等待时钟上升沿
        if dut_lsu_if_addr.value.integer == uart_base and dut_lsu_if_we.value and dut_lsu_if_resp.value :  # 检测写使能信号
            char = dut_lsu_if_wdata.value.integer & 0xFF  # 获取写入的数据（低 8 位）
            virtual_uart.write_char(char)
            
async def reset_dut(reset_n, duration_ns):
    reset_n.value = 0
    await Timer(duration_ns, units="ns")
    reset_n.value = 1
    reset_n._log.info("Reset complete.")     

CLK_NS = 5
SIM_TIME_OUT = 50000           
@cocotb.test()
async def tb(dut):

    
    iram_base = 0x00000  
    dram_base = 0x80000 
    word_size = 4
    
    # 加载 HEX 文件
    iram_memory_size = 64*1024 #64KByte
    # 将 iram 初始化为 numpy 数组
    iram_hex_file_path = "my_riscv_project/build/my_riscv_executable.iram.hex"
    iram_memory = load_hex_to_mem(iram_hex_file_path,total_size=iram_memory_size)
    dut._log.info('Load text to iram_memory , total size : {} '
                  .format(iram_memory_size))
    
    dram_memory_size = 64*1024
    # 将 dram 初始化为 numpy 数组
    dram_hex_file_path = "my_riscv_project/build/my_riscv_executable.dram.hex"
    dram_memory = load_hex_to_mem(dram_hex_file_path,total_size=dram_memory_size,base_addr=dram_base)
    dut._log.info('Load data to dram_memory , total size : {} '
                  .format(dram_memory_size))

    """
    *** 创建ZEMU实例
        需要创建DRAM备份，来分离DUT与ZEMU的DRAM MODEL
    """    
    dut._log.info('init ZEMU')
    
    fetcher  = ZEMUFetcher(iram_memory)
    decoder  = ZEMUDecoder()
    executor = ZEMUExecutor(dram_base,dram_memory) 
    clint = ZemuCLINT()  # 创建 CLINT 实例
    # 实例化 AxiRam
    axi_iram = AxiRamRead(AxiReadBus.from_prefix(dut, "im_axi"), dut.clk, dut.resetn, reset_active_level = False, size=2**32)
    axi_dram = AxiRam(AxiBus.from_prefix(dut, "dm_axi"), dut.clk, dut.resetn, reset_active_level = False, size=2**32)
    load_hex_to_mem_axi(iram_hex_file_path, total_size=iram_memory_size, axi_ram=axi_iram)
    load_hex_to_mem_axi(dram_hex_file_path, total_size=dram_memory_size, axi_ram=axi_dram, ram_base=dram_base)
    
    dut.clk.value = 0
    dut.resetn.value = 0
    dut.halt_req = 0
    dut.resume_req = 0
    """
    !!! 注意：
        ZEMU在cocotb中的协程启动必须早于ram_driver的协程，
        避免DUT对于虚拟RAM的操作生效早于ZEMU，从而导致ZEMU和DUT虚拟RAM错误报出mismatch。
    """
    cocotb.start_soon(
        Zemu_monitor( fetcher, decoder, executor, clint, dut=dut,dut_clk=dut.clk,dut_instr_retire=dut.core.instr_retire, axi_dram = axi_dram, dram_base = dram_base )
        )

    # "Clock" is a built in class for toggling a clock signal
    cocotb.start_soon(Clock(dut.clk, CLK_NS, units='ns').start())
    # run reset_dut immediately before continuing
    await cocotb.start(reset_dut(dut.resetn, 3))
    # detect decoder illegal instr
    await cocotb.start(decoder_illegal_instr_monitor(dut,dut.core.idu_illegal_instr))
    # pipeline_stall_monitor 对流水线停顿的检测。
    stall_fail_clk_cycle = 40  # 最大允许停顿时钟周期
    cocotb.start_soon(pipeline_stall_monitor(dut,dut.core.idu_stall, stall_fail_clk_cycle))
    # 启动虚拟 UART
    uart_base = 0x10000000  # UART 的基地址
    virtual_uart = VirtualUART(uart_base, buffer_size=256)
    cocotb.start_soon(uart_monitor(dut, dut.core.lsu2dram_wr_req, dut.core.lsu2dram_resp_ready, dut.core.lsu2dram_addr, dut.core.lsu2dram_wr_data, uart_base, virtual_uart))
    # 启动虚拟 Terminal
    # 测试Terminal 打印，注意testbench仿真时间需要根据输出内容增加，不然会导致看不到输出！
    terminal_base = 0xf0000000  # Terminal 的基地址
    virtual_terminal = VirtualTerminal(terminal_base, buffer_size=256)
    cocotb.start_soon(uart_monitor(dut, dut.core.lsu2dram_wr_req, dut.core.lsu2dram_resp_ready, dut.core.lsu2dram_addr, dut.core.lsu2dram_wr_data, terminal_base, virtual_terminal))
    # cocotb.start_soon(core_halt_test_driver(dut)) 
        
    np.random.seed(2023)

    await RisingEdge(dut.resetn)
    await Timer(10, units="ns")
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    
    await Timer(SIM_TIME_OUT, units="ns")
    executor.log_instr_stats()

if __name__ == '__main__':
    print('test')

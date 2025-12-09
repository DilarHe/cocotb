import random
import math
import cocotb
import numpy as np
import sys
import csv
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge, Timer, Edge ,ClockCycles 
# 导入cocotb-AXI component
from cocotbext.ahb import AHBBus, AHBLiteMaster, AHBLiteSlaveRAM, AHBMonitor
from cocotbext.ahb.memory import Memory


# this is selfdegine package
sys.path.append("/home/zyy/coco_work/cocoTest/common_lib")
from common_drivers import *
from Binary import *


async def reset_dut(reset_n, duration_ns):
    reset_n.value = 0
    await Timer(duration_ns, units="ns")
    reset_n.value = 1
    reset_n._log.info("Reset complete.")

def rnd_val(bit: int = 0, zero: bool = True):
    if zero is True:
        return random.randint(0, (2**bit) - 1)
    else:
        return random.randint(1, (2**bit) - 1)

def pick_random_value(input_list):
    if input_list:
        return random.choice(input_list)
    else:
        return None  # Return None if the list is empty
    
"""
  single port sram driver
  support both binary string and integer assignment
"""
async def mocram_driver(dut, mem_name, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata, is_classic, use_str = False):
    while True:
        await RisingEdge(dut.clk)
        if is_classic:
            wr = io_wr.value.integer & io_rd.value.integer
            rd = ~io_wr.value.integer & io_rd.value.integer
        else:
            wr = io_wr.value.integer
            rd = io_rd.value.integer
        if wr:  # write
            membank[io_addr.value.integer] = BinaryValue(io_wdata.value.integer).binstr if use_str else io_wdata.value.integer
            dut._log.info('SPRAM {} write in to address: {}, data: {}'.format(mem_name, io_addr.value.integer,
                                                                            io_wdata.value.integer))
        elif rd:
            rddata = membank[io_addr.value.integer]
            io_rdata.value = BinaryValue(rddata, bigEndian=False) if type(rddata)==str else rddata
            dut._log.info('SPRAM {} read out from address: {}, data: {}'.format(
                mem_name, io_addr.value.integer, rddata))


@cocotb.test()
async def testbench(dut):   
    # 在测试中设置固定的种子 
    random.seed(2023)    # Python的标准随机数生成器 
    np.random.seed(2023)  # 设置种子为42
    
    # 示例变量，实际数值请根据实际情况设定
    RAM_SIZE = 1024              # 以32位字为单位的RAM大小，即总字数为1024
    rg_src_addr = 0              # puchbuf 数据的起始字节地址（假设为128）
    n = 64                       # puchbuf 数据有 64 个8位数据

    # 初始化 RAM：创建一个 uint32 数组，所有位先置 0
    ram = np.zeros(RAM_SIZE, dtype=np.uint32)

    # 将 RAM 视作 uint8 数组（注意，每个 32 位字对应4个字节）
    ram_bytes = ram.view(np.uint8)

    # 1. 初始化 puchbuf 数据：在起始地址 rg_puchbuf_addr 后写入 n 个8位数据
    # 例如，这里简单填充一个递增序列作为示例（你可以换成任意数据）
    ram_bytes[rg_src_addr : rg_src_addr + n] = np.arange(n, dtype=np.uint8)
    
    RAM =array2mem(ram)
    
    cocotb.start_soon(mocram_driver(dut, "mem_master", RAM, 
                                    dut.mem_master_rd, 
                                    dut.mem_master_wr, 
                                    dut.mem_master_addr, 
                                    dut.mem_master_wdata,
                                    dut.mem_master_rdata, 
                                    is_classic=False))
    # initial dut 
    dut.clk.value = 0
    dut.resetn.value = 0
    dut.start.value = 0
    dut.rg_dest_addr.value = 10
    dut.rg_src_addr.value = 0
    dut.rg_width.value = 2
    dut.rg_height.value = 2
    dut.rg_dest_stride.value = 2
    dut.rg_src_stride.value = 2
    
    # "Clock" is a built in class for toggling a clock signal
    cocotb.start_soon(Clock(dut.clk, 5, units='ns').start())
    
    await cocotb.start(reset_dut(dut.resetn, 5 ))

    await RisingEdge(dut.clk)
    await Timer(6, units="ns")
    await RisingEdge(dut.clk)
    dut.start.value = 1
    await RisingEdge(dut.clk)
    dut.start.value = 0
    
    await Timer(10000, units="ns")

if __name__ == '__main__':
    print('test')
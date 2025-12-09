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
    # Step 1: 创建数据类型映射表
    dtype_mapping = {
        # 映射关系需要根据实际BoxDType()定义调整
        "CHAR":    (np.int8,   1),
        "SHORT":   (np.int16,  2),
        "USHORT":  (np.uint16, 2),
        "WORD":    (np.int32,  4),
        "UWORD":   (np.uint32, 4)
    }
    
    rg_input_addr = 0
    width = 3
    height = 3
    size = width * height
    # Step 2: 获取当前数据类型配置
    dtype_str = str(dut.rg_dtype_string.value)   
    np_dtype, bytes_per_element = dtype_mapping.get(dtype_str, (np.uint8, 1))
    # Step 3: 计算实际内存需求
    total_bytes = 2048 #2KByte
    required_ram_size = total_bytes // 4 + 1 # 按32bit字扩展
    # Step 4: 创建带有动态大小的RAM
    ram = np.zeros(required_ram_size, dtype=np.uint32)
    ram_bytes = ram.view(np.uint8)
    # Step 5: 生成符合当前数据类型的测试数据
    try:
        test_data = np.arange(size, dtype=np_dtype)
    except OverflowError:
        test_data = np.arange(size, dtype=np.uint16) % np.iinfo(np_dtype).max  # 处理数值溢出
    # # Step 6: 考虑字节序处理（假设目标系统使用小端）
    # if np.dtype(np_dtype).itemsize > 1:
    #     test_data = test_data.byteswap()  # 如果DUT使用大端序则需要此操作
    # Step 7: 数据写入内存
    start = rg_input_addr
    end = start + test_data.nbytes
    ram_bytes[start:end] = test_data.view(np.uint8).reshape(-1)
    # 使用 cocotb 的 array2mem 函数将 numpy 数组转换为 RAM 内存映像
    RAM = array2mem(ram)
    
    print("img size: ", size)
    print("np_dtype: ", np_dtype , " bytes_per_element: ", bytes_per_element)
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

    dut.rg_dtype.value = 0 #char 
    dut.rg_input_addr.value = rg_input_addr 
    dut.rg_output_addr.value = 100 
    dut.rg_psum_addr.value = 50 
    dut.rg_width.value = width 
    dut.rg_height.value = height 
    dut.rg_rx.value = 1 
    dut.rg_ry.value = 1 
    
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
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
    # 假设 RAM_SIZE 表示 32 位字的总数，根据实际需求调整
    RAM_SIZE = 64

    # 示例：每种梯度包含多个梯度值（这里举例使用4个梯度）
    gxx_gradients = np.array([0x0000000100, 0x00010001, 0x00010002, 0x00010003], dtype=np.uint32)
    gxy_gradients = np.array([0x00000001, 0x00020001, 0x00020002, 0x00020003], dtype=np.uint32)
    gyy_gradients = np.array([0x00000000, 0x00030001, 0x00030002, 0x00030003], dtype=np.uint32)

    # 初始化整个 RAM 数据（全部置 0）
    ram_data = np.zeros(int(RAM_SIZE), dtype=np.uint32)

    # 指定各梯度数据的起始地址（以 32 位字为单位）
    addr_gxx = 0    # Gxx 从地址 0 开始
    addr_gxy = 8    # Gxy 从地址 8 开始
    addr_gyy = 16   # Gyy 从地址 16 开始

    # 将每组梯度数据依次填入 RAM 中，确保不越界 RAM_SIZE
    ram_data[addr_gxx:addr_gxx + len(gxx_gradients)] = gxx_gradients
    ram_data[addr_gxy:addr_gxy + len(gxy_gradients)] = gxy_gradients
    ram_data[addr_gyy:addr_gyy + len(gyy_gradients)] = gyy_gradients

    # 将填充好的数据用 array2mem 装入 RAM
    RAM = array2mem(ram_data)
    
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
    dut.rg_pnGxx_addr.value = 0
    dut.rg_pnGxy_addr.value = 8
    dut.rg_pnGyy_addr.value = 16
    dut.rg_puchOriPtr_Base.value = 32
    dut.rg_nWidth.value = 2
    dut.rg_nHeight.value = 2
    dut.rg_nRadius.value = 2
    
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
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
sys.path.append("/home/zhangyiyao/coco_work/cocoTest/common_lib")
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
            
def pack_data(a, b, c, d):
    """
    根据 a, b, c, d (均为 12 位数据) 生成三个 16 位数据:
      x = [ d[3:0], a ]
      y = [ d[7:4], b ]
      z = [ d[11:8], c ]
    """
    x = ((d & 0xF) << 12) | (a & 0xFFF)
    y = (((d >> 4) & 0xF) << 12) | (b & 0xFFF)
    z = (((d >> 8) & 0xF) << 12) | (c & 0xFFF)
    return x, y, z

def pack_uint16_to_uint32_stream(uint16_array):
    """
    将任意长度的 uint16 数组紧凑地打包成 32 位数据。
    思路：将所有 16 位数据当作连续的位流，然后每 32 位分为一个 32 位单元。
    如果最后不足 32 位，则低位填充有效数据，高位补零。
    """
    total_bits = len(uint16_array) * 16
    num_words = (total_bits + 31) // 32  # 计算需要多少个 32 位单元
    result = np.zeros(num_words, dtype=np.uint32)
    
    current_bit_index = 0  # 当前已填充的位数
    for value in uint16_array:
        # 对于每个 16 位数据，确定要放入 result 中的哪个 32 位单元及其起始位偏移
        word_index = current_bit_index // 32
        bit_offset = current_bit_index % 32

        # 如果从当前偏移位置放入 16 位数据不会超出当前 32 位单元
        if bit_offset <= 16:
            result[word_index] |= np.uint32(value) << bit_offset
        else:
            # 当前 32 位单元剩余位数不足 16 位，需要分两部分存放
            low_bits = 32 - bit_offset  # 当前单元可以放的位数
            # 先在当前单元放低位部分
            result[word_index] |= (np.uint32(value) & ((1 << low_bits) - 1)) << bit_offset
            # 剩余的高位部分放入下一个 32 位单元
            result[word_index + 1] |= np.uint32(value) >> low_bits
        
        current_bit_index += 16

    return result

def pack_uint12_to_uint32(data_list):
    """
    data_list 为 [(a, b, c, d), ...] 的列表，其中 a, b, c, d 均为 12 位数据。
    处理流程：
      1. 每个 (a, b, c, d) 通过 pack_data 得到 3 个 uint16 数据；
      2. 将所有 uint16 数据看作一个连续的位流，通过 pack_uint16_to_uint32_stream 紧凑打包成 uint32 数组。
    """
    uint16_words = []
    for a, b, c, d in data_list:
        x, y, z = pack_data(a, b, c, d)
        uint16_words.extend([x, y, z])
    
    # 转换为 numpy 数组，确保数据类型为 uint16
    uint16_array = np.array(uint16_words, dtype=np.uint16)
    # 紧凑打包为 uint32 流
    uint32_array = pack_uint16_to_uint32_stream(uint16_array)
    return uint32_array

@cocotb.test()
async def testbench(dut):   
    # 在测试中设置固定的种子 
    random.seed(2023)    # Python的标准随机数生成器 
    np.random.seed(2023)  # 设置种子为42
    # 假设 RAM_SIZE 表示 32 位单元的个数，为确保数据完全填充RAM，
    # 我们需要计算生成多少组 (a,b,c,d)。每组产生 3 个 uint16 数据，共 48 位，
    # 紧凑打包后约占 1.5 个 32 位单元。为简便起见，这里直接定义组数，例如：
    num_groups = 10
    # 随机生成每组 (a,b,c,d)，注意每个值都是 12 位（范围 0~0xFFF）
    random_groups = np.random.randint(0, 2**12, size=(num_groups, 4), dtype=np.uint16)
    data_list = [tuple(row) for row in random_groups]
    print(data_list)
    # 打包为 uint32 数据流
    packed_data = pack_uint12_to_uint32(data_list)
    RAM = array2mem(packed_data)
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
    dut.rg_pdst_addr.value = 30
    dut.rg_img_size.value = 8
    dut.rg_ch_num.value = 1
    
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
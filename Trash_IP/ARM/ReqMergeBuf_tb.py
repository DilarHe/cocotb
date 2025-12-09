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

def get_sv_vec(sig, n_ports, w):
    val = int(sig.value)
    return [(val >> (w*i)) & ((1<<w)-1) for i in range(n_ports)]

@cocotb.test()
async def ReqMergeBuf_tb(dut):   
    PORT_NUM = 4
    # 在测试中设置固定的种子 
    random.seed(2023)    # Python的标准随机数生成器 
    np.random.seed(2023)  # 设置种子为42

    # initial dut 
    dut.clk.value = 0
    dut.rst_n.value = 0
    # 初始化输入
    dut.req_in_valid.value = 0
    dut.req_in_addr.value = 0
    dut.response_in_valid.value = 0
    dut.release_entry.value = 0
    dut.release_valid.value = 0
    # 启动时钟和复位
    cocotb.start_soon(Clock(dut.clk, 5, units='ns').start())
    await reset_dut(dut.rst_n, 5)
    dut._log.info("Reset complete")
    await RisingEdge(dut.clk)

    # ----------- 场景1: 不同地址分配 -----------
    dut._log.info("Reset complete")
    await RisingEdge(dut.clk)
    addr_list = [0x10, 0x20, 0x30, 0x40]
    packed_value = 0
    for i in range(PORT_NUM):
        packed_value |= int(addr_list[i]) << (32 * i)
    dut.req_in_valid.value = 0b1111
    dut.req_in_addr.value = packed_value
    await RisingEdge(dut.clk)
    ack = int(dut.req_out_ack.value)
    entry_idx = get_sv_vec(dut.req_out_entry, PORT_NUM, 5)
    dut._log.info(f"分配ack={bin(ack)}, entry={entry_idx}")

    # ----------- 场景2: 合并请求（所有端口发同一地址） -----------
    await RisingEdge(dut.clk)
    addr_same = [0x55]*PORT_NUM
    packed_value = 0
    for i in range(PORT_NUM):
        packed_value |= int(addr_same[i]) << (32 * i)
    dut.req_in_valid.value = 0b1111
    dut.req_in_addr.value = packed_value
    await RisingEdge(dut.clk)
    ack2 = int(dut.req_out_ack.value)
    entry_idx2 = get_sv_vec(dut.req_out_entry, PORT_NUM, 5)
    dut._log.info(f"合并ack={bin(ack2)}, entry={entry_idx2}")
    assert len(set(entry_idx2)) == 1 or ack2 == 0, "所有端口merge时应返回同一entry编号"

    
    await Timer(5000, units="ns")

if __name__ == '__main__':
    print('test')
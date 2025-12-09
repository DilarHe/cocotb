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
    

@cocotb.test()
async def testbench(dut):   
    # 在测试中设置固定的种子 
    random.seed(2023)    # Python的标准随机数生成器 
    np.random.seed(2023)  # 设置种子为42
    RAM_SIZE = 120
    
    RAM = array2mem(np.arange(1, int(RAM_SIZE) + 1, dtype=np.uint32))
    
    cocotb.start_soon(spram_driver(dut, "ram0", RAM, dut.ram_cen0, dut.ram_wen0, dut.ram_addr_inter0, dut.ram_wdata_inter0,dut.ram_rdata_inter0, is_classic=True))
    cocotb.start_soon(spram_driver(dut, "ram1", RAM, dut.ram_cen1, dut.ram_wen1, dut.ram_addr_inter1, dut.ram_wdata_inter1,dut.ram_rdata_inter1, is_classic=True))
    cocotb.start_soon(spram_driver(dut, "ram2", RAM, dut.ram_cen2, dut.ram_wen2, dut.ram_addr_inter2, dut.ram_wdata_inter2,dut.ram_rdata_inter2, is_classic=True))
    cocotb.start_soon(spram_driver(dut, "ram3", RAM, dut.ram_cen3, dut.ram_wen3, dut.ram_addr_inter3, dut.ram_wdata_inter3,dut.ram_rdata_inter3, is_classic=True))
    dut_ahbs = AHBBus.from_prefix(
        dut, 
        prefix = "",
        signals = {
            "haddr" : "HADDR",
            "hsize" : "HSIZE",
            "htrans" : "HTRANS",
            "hwdata" : "HWDATA",
            "hrdata" : "HRDATA",
            "hwrite" : "HWRITE",
            "hready" : "HREADYOUT",
            "hresp" : "HRESP"
        },
        optional_signals = {
            # "hsel" : "HSEL",
            # "hready_in" : "HREADY",
        }
    )
    ahb_lite_master = AHBLiteMaster(
        dut_ahbs, dut.HCLK, dut.HRESETn,timeout= 100 ,def_val="Z"
    )
    
    # Create a lit of non-repeated addresses spaces by 8 from 0->2*current RAM size
    address = [0x0, 0x4, 0x8]
    value = [0x11, 0x22, 0x33]
    size = [2,2,2]
    txn_type = [1,0,1]
    # initial dut 
    dut.HCLK.value = 0
    dut.HRESETn.value = 0
    
    # "Clock" is a built in class for toggling a clock signal
    cocotb.start_soon(Clock(dut.HCLK, 5, units='ns').start())
    
    await cocotb.start(reset_dut(dut.HRESETn, 5 ))

    await RisingEdge(dut.HCLK)
    await Timer(6, units="ns")
    await RisingEdge(dut.HCLK)
    # dut.start.value = 1
    await RisingEdge(dut.HCLK)
    # dut.start.value = 0
    resp = await ahb_lite_master.custom(address, value, txn_type, size, False)
    await Timer(10000, units="ns")

if __name__ == '__main__':
    print('test')
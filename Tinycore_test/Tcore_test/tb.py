import random
import math
import cocotb
import numpy as np
from numfi import numfi
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge, Timer, Edge
import matplotlib.pyplot as plt
import sys
from utils import *


CLK_NS = 1

async def reset_dut(reset_n, duration_ns):
    reset_n.value = 0
    await Timer(duration_ns, units="ns")
    reset_n.value = 1
    reset_n._log.info("Reset complete.")

@cocotb.test()
async def tb(dut):
    # "Clock" is a built in class for toggling a clock signal
    cocotb.start_soon(Clock(dut.clk, CLK_NS, units='ns').start())
    # run reset_dut immediately before continuing
    await cocotb.start(reset_dut(dut.resetn, CLK_NS * 10))

    np.random.seed(2023)

    await RisingEdge(dut.resetn)
    await Timer(10, units="ns")
    await RisingEdge(dut.clk)
    dut.core_start.value = 1
    await RisingEdge(dut.clk)
    dut.core_start.value = 0
    
    
    await Timer(10000, units="ns")


if __name__ == '__main__':
    print('test')

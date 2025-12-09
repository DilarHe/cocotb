import random
import math
import cocotb
import numpy as np
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge, Timer, Edge
import sys
sys.path.append("/home/zyy/coco_work/cocoTest/common_lib")
from common_drivers import *

CLK_NS = 1

async def reset_dut(reset_n, duration_ns):
    reset_n.value = 0
    await Timer(duration_ns, units="ns")
    reset_n.value = 1
    reset_n._log.info("Reset complete.")


async def matmul_monitor(dut, dut_result, ref_result, gather_ratio, n_bits):
    while (1):  
        await FallingEdge(dut.done)
        print(dut_result[4:4+int(8/(4/2))])
        cal_result = split_mem_element(dut_result[4:4+int(8/(4/2))], gather_ratio, n_bits = n_bits, signed = True)
        print(np.array(cal_result)-ref_result.flatten())
        print(f"dut result: {cal_result}")
        print(f"ref result: {ref_result.flatten()}")

@cocotb.test()
async def tb(dut):
    # "Clock" is a built in class for toggling a clock signal
    cocotb.start_soon(Clock(dut.clk, CLK_NS, units='ns').start())
    # run reset_dut immediately before continuing
    await cocotb.start(reset_dut(dut.resetn, CLK_NS * 10))

    np.random.seed(2)
    THREAD = 8
    INSIZE = 64
    OUTSIZE = 32
    coef = array2mem(np.zeros([int(132)], dtype=np.int32))
    cache = array2mem(np.zeros([int(16)], dtype=np.int32))
    print("coef",len(coef))

    matW = np.random.randint(-128,127,[INSIZE,OUTSIZE], dtype=np.int16)# (64,16) = 1024
    matI = np.random.randint(-128,127,[1,INSIZE], dtype=np.int16)# (1,64)
    bias = np.random.randint(-2**(12), 2**12-1, [OUTSIZE], dtype=np.int16)# (16,)
    matW_int32 = matW.astype(np.int32)
    matI_int32 = matI.astype(np.int32)
    # result = np.matmul(matI ,matW)+bias
    result_int32 = np.matmul(matI_int32, matW_int32) + bias.astype(np.int32)
    # 切片大小
    slice_size = 8
    # 使用迭代方式生成切片
    matW_slices = []
    matI_slices = []
    for i in range(INSIZE // slice_size):
        start = i * slice_size
        end = start + slice_size
        matW_slices.append(matW[start:end, 0])
        matI_slices.append(matI[0, start:end])
    # 打印结果
    for i in range(len(matW_slices)):
        print(f"matW_sli_{i}:", matW_slices[i])
        print(f"matI_sli_{i}:", matI_slices[i])
    # print("matI*matW :",np.matmul(matI[0,0:32],matW[0:32,0]))
    # print("matI*matW :",np.matmul(matI[0,32:64],matW[32:64,0]))
    print("matI",matI)
    print("bias",bias)
    print("Result:", result_int32)
    matW_trans = matW.transpose() # (16,64)
    # 将(16,64)的matW_trans，打平为【64个w，64个w，...，64个w】的list，这是为了符合矩阵乘的 行（输入）X 列（权重）的计算方式
    # 并且根据线程数（8）切分 list，并将每8个w组成的64bits数据组成新的list
    matW_gather = gather_array_element(matW_trans, THREAD, n_bits = 8, signed = True)
    bias_gather = gather_array_element(bias, int(THREAD/2), n_bits = 16, signed = True)
    param_list = bias_gather + matW_gather
    coef[:len(param_list)] = param_list
    matI_gather = gather_array_element(matI, THREAD, n_bits = 8, signed = True)
    cache[:len(matI_gather)] = matI_gather
    weight_base = len(bias_gather)
    ofmap_base = len(matI_gather)
    print("matW_gather",len(matW_gather))
    print("param_list",len(param_list))
    print("matI_gather",len(matI_gather))
    print("coef",len(coef))
    print("cache",len(cache))


    # Drivers
    # initial
    dut.start.value = 0
    # dut.need_relu.value = 0
    # dut.need_scale.value = 0
    # dut.rg_rnn_data_ratio.value = 6
    dut.input_loop_num.value = int(INSIZE/THREAD)-1
    dut.output_loop_num.value = int(OUTSIZE/THREAD)-1
    dut.psum_come_from_coef.value = 1
    # dut.cache_rdata.value = 0
    # dut.coef_rdata.value = 0
    dut.weight_base_addr.value = weight_base
    dut.psum_base_addr.value = 0
    dut.input_base_addr.value = 0
    dut.output_base_addr.value = ofmap_base

    await RisingEdge(dut.resetn)
    await RisingEdge(dut.clk)
    dut.start.value = 1
    await RisingEdge(dut.clk)
    dut.start.value = 0

    cocotb.start_soon(spram_driver(dut, "coef_ram", coef, dut.coef_ena, dut.coef_wena, dut.coef_addr, dut.coef_wdata,dut.coef_rdata, is_classic=True))
    cocotb.start_soon(spram_driver(dut, "cache_ram", cache, dut.cache_ena, dut.cache_wena, dut.cache_addr, dut.cache_wdata,dut.cache_rdata, is_classic=True))

    # Monitors
    # cocotb.start_soon()
    # cocotb.start_soon(matmul_monitor(dut, cache, result, gather_ratio=int(THREAD/2), n_bits=16))


    await Timer(10, units="ns")
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)


    await Timer(1000, units="ns")
    # print(bias)
    # print(matW)
    # print(matI)

    # print(result)
    # print(ofmap_base)
    # print(cache)

    # print(bias)
    # print(matI)
    # print(matW_trans)
    # print(np.matmul(matI ,matW))
if __name__ == '__main__':
    print('test')
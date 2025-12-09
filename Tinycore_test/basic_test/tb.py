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
from simd_model import *
from macro_gen import *

CLK_NS = 1

# def bias_in_mem2int(membank):
#     out_bias = np.zeros([membank.shape[0], int(membank.shape[1]/4)], dtype= np.int32)
#     line_num = int(membank.shape[1]/4)
#     for i in range(membank.shape[0]):
#         for j in range(line_num):
#             tmp = membank[i][j*4]
#             for k in range(4 - 1):
#                 tmp += membank[i][j*4+k+1] * 256
#             sign_tmp = (tmp >> 31) & 1
#             print(bin(tmp))
#             if sign_tmp == 1:
#                 print(tmp)
#                 tmp = tmp ^ ((1<<32)-1) + 1
#             out_bias[i][j] = tmp 

#     return out_bias

async def reset_dut(reset_n, duration_ns):
    reset_n.value = 0
    await Timer(duration_ns, units="ns")
    reset_n.value = 1
    reset_n._log.info("Reset complete.")


async def mem_driver(dut, mem_name, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata):
    while True:
        await RisingEdge(dut.clk)
        if io_wr.value.integer:  # write
            membank[io_addr.value.integer] = io_wdata.value.integer
            dut._log.info('Mem {} write in to address: {}, data: {}'.format(mem_name, io_addr.value.integer,
                                                                            io_wdata.value.integer))
            dut._log.info('Mem Contents : {}'.format(membank))
        elif io_rd.value.integer:
            rddata = int(membank[io_addr.value.integer])
            io_rdata.value = rddata
            dut._log.info('Mem {} read out from address: {}, data: {}'.format(
                mem_name, io_addr.value.integer, rddata))


async def highbendwidth_fbank_mem_driver(dut, mem_name, ele_width, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata):
    while True:
        await RisingEdge(dut.clk)
        if io_wr.value.integer:  # write
            for i in range(membank.shape[1]):
                membank[io_addr.value.integer][membank.shape[1] - 1 - i] = \
                    int('0b' +
                        io_wdata.value.binstr[ele_width * i:ele_width * (i + 1)], 2)
            dut._log.info('Mem {} write in to address: {}, data: {}'.format(mem_name, io_addr.value.integer,
                                                                            io_wdata.value.integer))
        elif io_rd.value.integer:
            rddata_str = ''
            for i in range(membank.shape[1]):
                rddata_str += dec2bin_ext_clip(
                    int(membank[io_addr.value.integer][membank.shape[1] - 1 - i]), ele_width)
            io_rdata.value = int('0b' + rddata_str, 2)
            dut._log.info('Mem {} read out from address: {}, data: {}, rawH:{}'.format(mem_name, io_addr.value.integer,
                                                                                       membank[io_addr.value.integer], int('0b' + rddata_str, 2)))
            
async def highbendwidth_act_mem_driver(dut, mem_name, ele_width, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata):
    while True:
        await RisingEdge(dut.clk)
        if io_wr.value.integer:  # write
            for i in range(membank.shape[1]):
                membank[io_addr.value.integer][membank.shape[1] - 1 - i] = \
                    int('0b' +
                        io_wdata.value.binstr[ele_width * i:ele_width * (i + 1)], 2)
            dut._log.info('Mem {} write in to address: {}, data: {}'.format(mem_name, io_addr.value.integer,
                                                                            io_wdata.value.integer))
        elif io_rd.value.integer:
            rddata_str = ''
            for i in range(membank.shape[1]):
                rddata_str += dec2bin_ext_clip(
                    int(membank[io_addr.value.integer][membank.shape[1] - 1 - i]), ele_width)
            io_rdata.value = int('0b' + rddata_str, 2)
            dut._log.info('Mem {} read out from address: {}, data: {}, rawH:{}'.format(mem_name, io_addr.value.integer,
                                                                                       membank[io_addr.value.integer], int('0b' + rddata_str, 2)))

async def highbendwidth_mem_driver_weight(dut, mem_name, ele_width, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata):
    while True:
        await RisingEdge(dut.clk)
        if io_wr.value.integer:  # write
            for i in range(membank.shape[1]):
                membank[io_addr.value.integer][membank.shape[1] - 1 - i] = \
                    int('0b' +
                        io_wdata.value.binstr[ele_width * i:ele_width * (i + 1)], 2)
            dut._log.info('Mem {} write in to address: {}, data: {}'.format(mem_name, io_addr.value.integer,
                                                                            io_wdata.value.integer))
        elif io_rd.value.integer:
            rddata_str = ''
            for i in range(membank.shape[1]):
                rddata_str += dec2bin_ext_clip(
                    int(membank[io_addr.value.integer][membank.shape[1] - 1 - i]), ele_width)
            io_rdata.value = int('0b' + rddata_str, 2)
            dut._log.info('Mem {} read out from address: {}, data: {}, rawH:{}'.format(mem_name, io_addr.value.integer,
                                                                                       membank[io_addr.value.integer], int('0b' + rddata_str, 2)))


async def driver(dut, datain, qin, SR, spar_ratio):
    pcm_iter = 0
    pcm_ns = int((1 / SR * (10 ** 9)) / spar_ratio)
    max_iter = datain.shape[0]
    while (pcm_iter != max_iter):
        await RisingEdge(dut.clk)
        pcm_data = datain[pcm_iter]
        pcm_iter += 1
        dut.pcm_in <= int(pcm_data * (2 ** qin[2]))
        dut._log.info('pcm in {}'.format(int(pcm_data * (2 ** qin[2]))))
        dut.pcm_vld <= 1
        await RisingEdge(dut.clk)
        dut.pcm_vld <= 0
        await Timer(pcm_ns - CLK_NS, units="ns")


async def monitor_layer1(dut, highbandwidth_a, ifmap, weight, bias, quant):
    while True:
        await RisingEdge(dut.clk)

        if (dut.x_1.value.integer == 1):  # layer conv1 finished
            conv_1D_result = np.loadtxt('runtime_data/conv00.txt')
            out_num = int((conv_1D_result.shape[0]*conv_1D_result.shape[1])/16)

            dut_result = highbandwidth_a[0:0 +
                                         out_num, :].reshape(conv_1D_result.shape)

            distance = conv_1D_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'Conv1 data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, conv_1D_result))
                dut._log.error('Where not equal index: {}'.format(
                    np.where(distance != 0)))
                raise ('!')
            else:
                dut._log.info('Conv1 data right! ')
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,conv_1D_result))

async def monitor_ibb1_c1(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb1_c1_start = macros['IBB1_C1_ofmapBase'] - act_start
    ibb1c1_true_conv_index = 0
    ibb1c1dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 2):  # layer ibb1 conv1 finished
            dut_result = highbandwidth_a[ibb1_c1_start +(ibb1c1dut_conv_index)*3 : ibb1_c1_start + (ibb1c1dut_conv_index+1)*3 , :].flatten()
            ref_result = true_conv_result[ibb1c1_true_conv_index]
            
            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB1 Conv1 data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1c1dut_conv_index, ibb1c1_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB1 Conv1 data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1c1dut_conv_index, ibb1c1_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb1c1_true_conv_index += 1
            ibb1c1dut_conv_index += 1
            if ibb1c1dut_conv_index >= 9:
                ibb1c1dut_conv_index = 0

async def monitor_ibb1_cskip(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb1_cskip_start = macros['IBB1_C1_ifmapBase'] - act_start
    ibb1cskip_true_conv_index = 0
    ibb1cskip_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 3):  # layer ibb1 skip finished
            dut_result = highbandwidth_a[ibb1_cskip_start +(ibb1cskip_dut_conv_index)*1 : ibb1_cskip_start + (ibb1cskip_dut_conv_index+1)*1 , :].flatten()
            ref_result = true_conv_result[ibb1cskip_true_conv_index]
            
            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB1 Conv_skip data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1cskip_dut_conv_index, ibb1cskip_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB1 Conv_skip data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1cskip_dut_conv_index, ibb1cskip_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb1cskip_true_conv_index += 1
            ibb1cskip_dut_conv_index += 1

async def monitor_ibb1_dw(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb1_dw_start = macros['IBB1_DW_ofmapBase'] - act_start
    ibb1dw_true_conv_index = 0
    ibb1dw_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 4):  # layer ibb1 dw finished
            dut_result = highbandwidth_a[ibb1_dw_start : ibb1_dw_start + 3 , :].flatten()
            ref_result = true_conv_result[ibb1dw_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB1 DWconv data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1dw_dut_conv_index, ibb1dw_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB1 DWconv data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1dw_dut_conv_index, ibb1dw_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb1dw_true_conv_index += 1
            ibb1dw_dut_conv_index += 1

async def monitor_ibb1_c2(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb1_c2_start = macros['IBB1_C2_ofmapBase'] - act_start
    ibb1c2_true_conv_index = 0
    ibb1c2_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 5):  # layer ibb1 skip finished
            dut_result = highbandwidth_a[ibb1_c2_start : ibb1_c2_start + 1 , :].flatten()
            ref_result = true_conv_result[ibb1c2_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB1 Conv2 data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1c2_dut_conv_index, ibb1c2_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB1 Conv2 data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1c2_dut_conv_index, ibb1c2_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb1c2_true_conv_index += 1
            ibb1c2_dut_conv_index += 1

async def monitor_ibb1_skipadd(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb1_skipadd_start = macros['IBB1_C1_ifmapBase'] - act_start
    ibb1skipadd_true_conv_index = 0
    ibb1skipadd_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 6):  # layer ibb1 skip add finished
            dut_result = highbandwidth_a[ibb1_skipadd_start + ibb1skipadd_dut_conv_index : ibb1_skipadd_start + ibb1skipadd_dut_conv_index + 1 , :].flatten()
            ref_result = true_conv_result[ibb1skipadd_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB1 Skip Add data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1skipadd_dut_conv_index, ibb1skipadd_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB1 Skip Add data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb1skipadd_dut_conv_index, ibb1skipadd_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb1skipadd_true_conv_index += 1
            ibb1skipadd_dut_conv_index += 1

# ibb2

async def monitor_ibb2_c1(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb2_c1_start = macros['IBB1_C1_ofmapBase'] - act_start
    ibb2c1_true_conv_index = 0
    ibb2c1dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 8):  # layer ibb1 conv1 finished
            dut_result = highbandwidth_a[ibb2_c1_start +(ibb2c1dut_conv_index)*3 : ibb2_c1_start + (ibb2c1dut_conv_index+1)*3 , :].flatten()
            ref_result = true_conv_result[ibb2c1_true_conv_index]
            
            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB2 Conv1 data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb2c1dut_conv_index, ibb2c1_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB2 Conv1 data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb2c1dut_conv_index, ibb2c1_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb2c1_true_conv_index += 1
            ibb2c1dut_conv_index += 1
            if ibb2c1dut_conv_index >= 9:
                ibb2c1dut_conv_index = 0

async def monitor_ibb2_dw(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb2_dw_start = macros['IBB1_DW_ofmapBase'] - act_start
    ibb2dw_true_conv_index = 0
    ibb2dw_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 9):  # layer ibb2 dw finished
            dut_result = highbandwidth_a[ibb2_dw_start : ibb2_dw_start + 3 , :].flatten()
            ref_result = true_conv_result[ibb2dw_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB2 DWconv data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb2dw_dut_conv_index, ibb2dw_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB2 DWconv data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb2dw_dut_conv_index, ibb2dw_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb2dw_true_conv_index += 1
            ibb2dw_dut_conv_index += 1

async def monitor_ibb2_c2(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb2_c2_start = macros['IBB1_C2_ofmapBase'] - act_start
    ibb2c2_true_conv_index = 0
    ibb2c2_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 10):  # layer ibb2 c2 finished
            dut_result = highbandwidth_a[ibb2_c2_start : ibb2_c2_start + 1 , :].flatten()
            ref_result = true_conv_result[ibb2c2_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB2 Conv2 data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb2c2_dut_conv_index, ibb2c2_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB2 Conv2 data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb2c2_dut_conv_index, ibb2c2_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb2c2_true_conv_index += 1
            ibb2c2_dut_conv_index += 1

async def monitor_ibb2_skipadd(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb2_skipadd_start = macros['IBB1_C1_ifmapBase'] - act_start
    ibb2skipadd_true_conv_index = 0
    ibb2skipadd_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 11):  # layer ibb1 skip add finished
            dut_result = highbandwidth_a[ibb2_skipadd_start + ibb2skipadd_dut_conv_index : ibb2_skipadd_start + ibb2skipadd_dut_conv_index + 1 , :].flatten()
            ref_result = true_conv_result[ibb2skipadd_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB2 Skip Add data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb2skipadd_dut_conv_index, ibb2skipadd_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB2 Skip Add data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb2skipadd_dut_conv_index, ibb2skipadd_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb2skipadd_true_conv_index += 1
            ibb2skipadd_dut_conv_index += 1

async def monitor_ibb2_all(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb2_skipadd_start = macros['IBB1_C1_ifmapBase'] - act_start
    ibb2_skipadd_len = int(30*16/16)
    full_shape = true_conv_result.shape
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 12):  # layer ibb2 finished
            dut_result = highbandwidth_a[ibb2_skipadd_start : ibb2_skipadd_start + ibb2_skipadd_len , :].reshape(full_shape)
            ref_result = true_conv_result

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB2 Skip Add data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                raise ('!')
            else:
                dut._log.info('IBB2 Skip Add data all right!')
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))

# ibb3

async def monitor_ibb3_c1(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb3_c1_start = macros['IBB1_C1_ofmapBase'] - act_start
    ibb3c1_true_conv_index = 0
    ibb3c1dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 13):  # layer ibb1 conv1 finished
            dut_result = highbandwidth_a[ibb3_c1_start +(ibb3c1dut_conv_index)*3 : ibb3_c1_start + (ibb3c1dut_conv_index+1)*3 , :].flatten()
            ref_result = true_conv_result[ibb3c1_true_conv_index]
            
            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB3 Conv1 data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3c1dut_conv_index, ibb3c1_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB3 Conv1 data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3c1dut_conv_index, ibb3c1_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb3c1_true_conv_index += 1
            ibb3c1dut_conv_index += 1
            if ibb3c1dut_conv_index >= 9:
                ibb3c1dut_conv_index = 0

async def monitor_ibb3_cskip(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb3_cskip_start = macros['IBB1_C1_ifmapBase'] - act_start
    ibb3cskip_true_conv_index = 0
    ibb3cskip_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 14):  # layer ibb1 skip finished
            dut_result = highbandwidth_a[ibb3_cskip_start +(ibb3cskip_dut_conv_index)*1 : ibb3_cskip_start + (ibb3cskip_dut_conv_index+1)*1 , :].flatten()
            ref_result = true_conv_result[ibb3cskip_true_conv_index]
            
            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB3 Conv_skip data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3cskip_dut_conv_index, ibb3cskip_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB3 Conv_skip data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3cskip_dut_conv_index, ibb3cskip_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb3cskip_true_conv_index += 1
            ibb3cskip_dut_conv_index += 1

async def monitor_ibb3_dw(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb3_dw_start = macros['IBB1_DW_ofmapBase'] - act_start
    ibb3dw_true_conv_index = 0
    ibb3dw_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 15):  # layer ibb3 dw finished
            dut_result = highbandwidth_a[ibb3_dw_start : ibb3_dw_start + 3 , :].flatten()
            ref_result = true_conv_result[ibb3dw_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB1 DWconv data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3dw_dut_conv_index, ibb3dw_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB1 DWconv data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3dw_dut_conv_index, ibb3dw_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb3dw_true_conv_index += 1
            ibb3dw_dut_conv_index += 1

async def monitor_ibb3_c2(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb3_c2_start = macros['IBB1_C2_ofmapBase'] - act_start
    ibb3c2_true_conv_index = 0
    ibb3c2_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 16):  # layer ibb1 skip finished
            dut_result = highbandwidth_a[ibb3_c2_start : ibb3_c2_start + 1 , :].flatten()
            ref_result = true_conv_result[ibb3c2_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB3 Conv2 data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3c2_dut_conv_index, ibb3c2_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB3 Conv2 data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3c2_dut_conv_index, ibb3c2_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb3c2_true_conv_index += 1
            ibb3c2_dut_conv_index += 1

async def monitor_ibb3_skipadd(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb3_skipadd_start = macros['IBB1_C1_ifmapBase'] - act_start
    ibb3skipadd_true_conv_index = 0
    ibb3skipadd_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 17):  # layer ibb1 skip add finished
            dut_result = highbandwidth_a[ibb3_skipadd_start + ibb3skipadd_dut_conv_index : ibb3_skipadd_start + ibb3skipadd_dut_conv_index + 1 , :].flatten()
            ref_result = true_conv_result[ibb3skipadd_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB1 Skip Add data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3skipadd_dut_conv_index, ibb3skipadd_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB1 Skip Add data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb3skipadd_dut_conv_index, ibb3skipadd_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb3skipadd_true_conv_index += 1
            ibb3skipadd_dut_conv_index += 1

# ibb4

async def monitor_ibb4_c1(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb4_c1_start = macros['IBB1_C1_ofmapBase'] - act_start
    ibb4c1_true_conv_index = 0
    ibb4c1dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 19):  # layer ibb1 conv1 finished
            dut_result = highbandwidth_a[ibb4_c1_start +(ibb4c1dut_conv_index)*3 : ibb4_c1_start + (ibb4c1dut_conv_index+1)*3 , :].flatten()
            ref_result = true_conv_result[ibb4c1_true_conv_index]
            
            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB4 Conv1 data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb4c1dut_conv_index, ibb4c1_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB4 Conv1 data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb4c1dut_conv_index, ibb4c1_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb4c1_true_conv_index += 1
            ibb4c1dut_conv_index += 1
            if ibb4c1dut_conv_index >= 9:
                ibb4c1dut_conv_index = 0

async def monitor_ibb4_dw(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb4_dw_start = macros['IBB1_DW_ofmapBase'] - act_start
    ibb4dw_true_conv_index = 0
    ibb4dw_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 20):  # layer ibb2 dw finished
            dut_result = highbandwidth_a[ibb4_dw_start : ibb4_dw_start + 3 , :].flatten()
            ref_result = true_conv_result[ibb4dw_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB4 DWconv data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb4dw_dut_conv_index, ibb4dw_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB4 DWconv data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb4dw_dut_conv_index, ibb4dw_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb4dw_true_conv_index += 1
            ibb4dw_dut_conv_index += 1

async def monitor_ibb4_c2(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb4_c2_start = macros['IBB1_C2_ofmapBase'] - act_start
    ibb4c2_true_conv_index = 0
    ibb4c2_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 21):  # layer ibb2 c2 finished
            dut_result = highbandwidth_a[ibb4_c2_start : ibb4_c2_start + 1 , :].flatten()
            ref_result = true_conv_result[ibb4c2_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB4 Conv2 data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb4c2_dut_conv_index, ibb4c2_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB4 Conv2 data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb4c2_dut_conv_index, ibb4c2_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb4c2_true_conv_index += 1
            ibb4c2_dut_conv_index += 1

async def monitor_ibb4_skipadd(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb4_skipadd_start = macros['IBB1_C1_ifmapBase'] - act_start
    ibb4skipadd_true_conv_index = 0
    ibb4skipadd_dut_conv_index = 0
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 22):  # layer ibb1 skip add finished
            dut_result = highbandwidth_a[ibb4_skipadd_start + ibb4skipadd_dut_conv_index : ibb4_skipadd_start + ibb4skipadd_dut_conv_index + 1 , :].flatten()
            ref_result = true_conv_result[ibb4skipadd_true_conv_index]

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB4 Skip Add data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                dut._log.error('Current dut conv fifo index: {}, true conv index: {}.'.format(ibb4skipadd_dut_conv_index, ibb4skipadd_true_conv_index))
                raise ('!')
            else:
                dut._log.info('IBB4 Skip Add data right! Current dut conv fifo index: {}, true conv index: {}.'.format(ibb4skipadd_dut_conv_index, ibb4skipadd_true_conv_index))
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
            ibb4skipadd_true_conv_index += 1
            ibb4skipadd_dut_conv_index += 1

async def monitor_ibb4_all(dut, highbandwidth_a , macros, act_start, true_conv_result):
    ibb4_skipadd_start = macros['IBB1_C1_ifmapBase'] - act_start
    ibb4_skipadd_len = int(15*16/16)
    full_shape = true_conv_result.shape
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 23):  # layer ibb2 finished
            dut_result = highbandwidth_a[ibb4_skipadd_start : ibb4_skipadd_start + ibb4_skipadd_len , :].reshape(full_shape)
            ref_result = true_conv_result

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'IBB4 Skip Add data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                raise ('!')
            else:
                dut._log.info('IBB4 Skip Add data all right!')
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))

async def monitor_avgpool(dut, highbandwidth_a , macros, act_start, true_conv_result):
    avg_skipadd_start = macros['AVGPOOL_ofmapBase']-act_start
    avg_len = int(1*16/16)
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 24):  # layer avgpool finished
            dut_result = highbandwidth_a[avg_skipadd_start : avg_skipadd_start + avg_len , :]
            ref_result = true_conv_result

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'Avgpool data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                raise ('!')
            else:
                dut._log.info('Avgpool Add data all right!')
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))

async def monitor_linear(dut, highbandwidth_a , macros, act_start, true_conv_result):
    linear_skipadd_start = macros['LINEAR_ofmapBase']-act_start
    linear_len = 1
    ref_shape = true_conv_result.shape
    while True:
        await RisingEdge(dut.clk)
        if (dut.x_1.value.integer == 25):  # layer avgpool finished
            dut_result = highbandwidth_a[linear_skipadd_start : linear_skipadd_start + linear_len , :ref_shape[0]]
            ref_result = true_conv_result

            distance = ref_result - dut_result

            if (np.sum(distance) != 0):
                dut._log.error(
                    'linear data wrong! \n distance = {}, \n dut = {}, \n ture = {}.'.format(distance,
                                                                                            dut_result, ref_result))
                dut._log.error('Where not equal index:\n {}'.format(
                    np.where(distance != 0)))
                raise ('!')
            else:
                dut._log.info('linear Add data all right!')
                dut._log.info('dut:\n{}\nref:\n{}'.format(dut_result,ref_result))
@cocotb.test()
async def tb(dut):
    # "Clock" is a built in class for toggling a clock signal
    cocotb.start_soon(Clock(dut.clk, CLK_NS, units='ns').start())
    # run reset_dut immediately before continuing
    await cocotb.start(reset_dut(dut.resetn, CLK_NS * 10))

    np.random.seed(2023)

    # Parameters
    # config = load_json_config("../../../hw_config.json") #### 
    # macros,fbank_start,act_start,weight_start = macro_gen('../../../hw_config.json', 'macro.asm') #### 
    # 从json中加载配置参数
    config = load_json_config("./hw_config.json") 
    macros,fbank_start,act_start,weight_start = macro_gen('./hw_config.json', 'macro.asm') #### 
    asm2bin("basic_test.asm") ####

    IRAM_LEN = 11 # 2KB的irom 
    PC_INIT = 115
    INSTR_LEN = 16
    VMEM_WIDTH = 128
    SMEM_WIDTH = 32
    VECTOR_LEN = 128 # 向量长度 128bits
    SIMD_FACTOR = 16 # SIMD并行系数

    BIAS_WIDTH = 32
    LINE_BIAS_NUM = int(VMEM_WIDTH / BIAS_WIDTH)

    FBANK_MEM_KB = int(config["mem"]["fbank"])  #1920 byte
    ACT_MEM_KB = int(config["mem"]["act"])  #2048 byte
    WEIGHT_MEM_KB = int(config["mem"]["weight"]) #13000 byte
    STACK_MEM_KB = int(config["mem"]["stack"]) #256 byte

    "mem中line的word都是 16 byte = 128 bits"
    FBANK_MEM_LEN = int(FBANK_MEM_KB / SIMD_FACTOR)  
    ACT_MEM_LEN = int(ACT_MEM_KB / SIMD_FACTOR)
    WEIGHT_MEM_LEN = int(WEIGHT_MEM_KB / SIMD_FACTOR)
    irom = np.zeros(2 ** IRAM_LEN)
    highbandwidth_fb = np.zeros(shape=[FBANK_MEM_LEN, SIMD_FACTOR], dtype=np.int32)
    highbandwidth_a = np.zeros(shape=[ACT_MEM_LEN, SIMD_FACTOR], dtype=np.int32)
    highbandwidth_w = np.zeros(shape=[WEIGHT_MEM_LEN, SIMD_FACTOR], dtype=np.int32)
    lowbandwidth = np.zeros(shape=256, dtype=np.int32)
    
    "加载二进制指令文件到irom中"
    irom = load_bin2np(irom, 'testbin.bin') ####
    store_bin2int('testbin.bin', './rom_data/testbin.txt') ####
    # fbank gen
    fbank_size = [60, 32]  # 定义特征图的原始大小（60行，32列）
    fbank_size_fix = [fbank_size[0], fbank_size[1] // SIMD_FACTOR, SIMD_FACTOR]  # 调整特征图的大小
    fbank_0_raw = load_act('data/conv00_fmapin.txt')  # 从文件中加载原始数据
    fbank_0_raw = np.array(fbank_0_raw).reshape(fbank_size)  # 将原始数据转换为 NumPy 数组，并调整形状为 fbank_size
    fbank_0_flatten = fbank_0_raw.reshape(fbank_size_fix)  # 调整形状为 fbank_size_fix
    fbank_0_flatten = fbank_0_flatten.reshape([-1, SIMD_FACTOR])  # 扁平化特征图，第二维大小为 SIMD_FACTOR
    highbandwidth_fb[:fbank_0_flatten.shape[0], :] = fbank_0_flatten  # 将处理后的数据存储到 highbandwidth_fb 中
    
    "加载nn网络形态配置"
    nn_layers = config["nn"].items()
    "初始化了四个字典用于存储不同类型的层数据：权重、偏置、量化参数和跳过连接。"
    weight_all = {}
    bias_all = {}
    quant_all = {}
    skipadd_all = {}
    tmp_mem_cnt = 0 # tmp_mem_cnt 用于跟踪存储在 highbandwidth_w 数组中的数据位置。
    # 遍历 nn_layers 列表，其中每个元素是一个包含层名称和形状的元组。
    for i, item in enumerate(nn_layers):
        item_name = item[0]
        item_shape = item[1]
        print(item_name)
        # 匹配层名称：使用正则表达式 conv\d+_w 匹配卷积层的权重。
        if re.match(r"conv\d+_w", item_name) is not None:
            weight_data_raw = load_weight('data/{}.txt'.format(item_name)) # load_weight 函数加载权重数据。
            weight_data_raw = np.array(weight_data_raw).reshape(item_shape) # 将数据转换为 NumPy 数组并调整形状。
            weight_flatten = Teconv_weight_reorder(weight_data_raw) # 使用 Teconv_weight_reorder 函数重新排序权重数据（假设这是一个自定义的处理函数）。
            weight_flatten = weight_flatten.reshape([-1, SIMD_FACTOR]) # 将权重数据进一步调整为形状 [-1, SIMD_FACTOR]。
            weight_num = weight_flatten.shape[0]
            # 计算在 highbandwidth_w 数组中的起始和结束位置，并将处理后的权重数据存储在指定位置。
            start_point = tmp_mem_cnt
            end_point = tmp_mem_cnt + weight_num
            highbandwidth_w[start_point : end_point, :] = weight_flatten
            tmp_mem_cnt += weight_num # 更新 tmp_mem_cnt 以指向下一个存储位置。
            weight_all[item_name] = weight_data_raw #将原始权重数据存储在 weight_all 字典中。
        # 匹配层名称：使用正则表达式 conv\d+_b 匹配卷积层的bias。
        elif re.match(r"conv\d+_b", item_name) is not None:
            bias_data_raw = load_bias('data/{}.txt'.format(item_name))
            bias_data_raw = np.array(bias_data_raw).reshape(item_shape)
            bias_size_fix = [item_shape[0], int(item_shape[1] / LINE_BIAS_NUM), LINE_BIAS_NUM]
            bias_flatten = bias_data_raw.reshape(bias_size_fix)
            bias_flatten = bias_flatten.reshape([-1, LINE_BIAS_NUM])
            bias_flatten = bias_enlarge_dim(bias_flatten, SIMD_FACTOR)
            bias_num = bias_flatten.shape[0]
            start_point = tmp_mem_cnt
            end_point = tmp_mem_cnt + bias_num
            highbandwidth_w[start_point : end_point, :] = bias_flatten
            tmp_mem_cnt += bias_num
            bias_all[item_name] = bias_data_raw
        # 匹配层名称：使用正则表达式 conv\d+_q 匹配卷积层的量化参数。
        elif re.match(r"conv\d+_q", item_name) is not None:
            quant_data_raw = load_quant('data/{}.txt'.format(item_name))
            quant_data_raw = np.array(quant_data_raw).reshape(item_shape)
            quant_flatten = np.array([[quant_data_raw[0][0], quant_data_raw[0][1], quant_data_raw[0][2], 0]])
            quant_flatten = bias_enlarge_dim(quant_flatten, SIMD_FACTOR)
            quant_num = quant_flatten.shape[0]
            start_point = tmp_mem_cnt
            end_point = tmp_mem_cnt + quant_num
            highbandwidth_w[start_point : end_point, :] = quant_flatten
            tmp_mem_cnt += quant_num
            quant_all[item_name] = quant_data_raw
        # 跳过添加层
        elif re.match(r"ibb\d+_skipadd", item_name) is not None:
            offset1, scale1, offset2, scale2, offset, shift = load_skipadd('data/{}.txt'.format(item_name))
            first32b = (offset2 << 16) + (offset1 << 8) + shift
            second32b = scale1
            third32b = scale2
            forth32b = offset
            skipadd_data_raw = np.array([first32b, second32b, third32b ,forth32b]).reshape([1,4])
            skipadd_flatten = bias_enlarge_dim(skipadd_data_raw, SIMD_FACTOR)
            skipadd_num = skipadd_flatten.shape[0]
            start_point = tmp_mem_cnt
            end_point = tmp_mem_cnt + skipadd_num
            highbandwidth_w[start_point : end_point, :] = skipadd_flatten
            tmp_mem_cnt += skipadd_num
            skipadd_all[item_name] = np.array([offset1, scale1, offset2, scale2, offset, shift],dtype=np.int32)
        # 线性层
        elif re.match(r"linear_w", item_name) is not None:
            weight_data_raw = load_weight('data/{}.txt'.format(item_name))
            weight_data_raw = np.array(weight_data_raw).reshape(item_shape)
            weight_flatten = weight_data_raw.flatten().reshape([-1, SIMD_FACTOR])
            weight_num = weight_flatten.shape[0]
            start_point = tmp_mem_cnt
            end_point = tmp_mem_cnt + weight_num
            highbandwidth_w[start_point : end_point, :] = weight_flatten
            tmp_mem_cnt += weight_num
            weight_all[item_name] = weight_data_raw

        elif re.match(r"linear_b", item_name) is not None:
            bias_data_raw = load_bias('data/{}.txt'.format(item_name))
            bias_data_raw = np.array(bias_data_raw).reshape(item_shape).flatten()
            if item_shape[1] % LINE_BIAS_NUM == 0:
                linenum = int(item_shape[1] / LINE_BIAS_NUM)
            else:
                pad_num = LINE_BIAS_NUM - (item_shape[1] % LINE_BIAS_NUM)
                bias_data_raw = np.pad(bias_data_raw,(0,pad_num),'constant', constant_values=(0,0)) 
                linenum = int(item_shape[1] / LINE_BIAS_NUM) + 1
            bias_size_fix = [linenum, LINE_BIAS_NUM]
            bias_flatten = np.array(bias_data_raw,dtype=np.int32).reshape(bias_size_fix)
            bias_flatten = bias_flatten.reshape([-1, LINE_BIAS_NUM])
            bias_flatten = bias_enlarge_dim(bias_flatten, SIMD_FACTOR)
            bias_num = bias_flatten.shape[0]
            start_point = tmp_mem_cnt
            end_point = tmp_mem_cnt + bias_num
            highbandwidth_w[start_point : end_point, :] = bias_flatten
            tmp_mem_cnt += bias_num
            bias_all[item_name] = bias_data_raw

        elif re.match(r"linear_q", item_name) is not None:
            quant_data_raw = load_quant('data/{}.txt'.format(item_name))
            quant_data_raw = np.array(quant_data_raw).reshape(item_shape)
            quant_flatten = np.array([[quant_data_raw[0][0], quant_data_raw[0][1], quant_data_raw[0][2], 0]])
            quant_flatten = bias_enlarge_dim(quant_flatten, SIMD_FACTOR)
            quant_num = quant_flatten.shape[0]
            start_point = tmp_mem_cnt
            end_point = tmp_mem_cnt + quant_num
            highbandwidth_w[start_point : end_point, :] = quant_flatten
            tmp_mem_cnt += quant_num
            quant_all[item_name] = quant_data_raw    
        # 池化
        elif re.match(r"avgpool_q", item_name) is not None:
            quant_data_raw = load_quant('data/{}.txt'.format(item_name))
            quant_data_raw = np.array(quant_data_raw).reshape(item_shape)
            quant_flatten = np.array([[quant_data_raw[0][0], quant_data_raw[0][1], quant_data_raw[0][2], 0]])
            quant_flatten = bias_enlarge_dim(quant_flatten, SIMD_FACTOR)
            quant_num = quant_flatten.shape[0]
            start_point = tmp_mem_cnt
            end_point = tmp_mem_cnt + quant_num
            highbandwidth_w[start_point : end_point, :] = quant_flatten
            tmp_mem_cnt += quant_num
            quant_all[item_name] = quant_data_raw    
        elif re.match(r"softmax_q", item_name) is not None:
            quant_data_raw = load_softmax('data/{}.txt'.format(item_name))
            quant_data_raw = np.array(quant_data_raw).reshape(item_shape)
            quant_flatten = np.array([[quant_data_raw[0][0], quant_data_raw[0][1], quant_data_raw[0][2], quant_data_raw[0][3]],
                                      [quant_data_raw[0][4], quant_data_raw[0][5], quant_data_raw[0][6], quant_data_raw[0][7]]])
            quant_flatten = bias_enlarge_dim(quant_flatten, SIMD_FACTOR)
            quant_num = quant_flatten.shape[0]
            start_point = tmp_mem_cnt
            end_point = tmp_mem_cnt + quant_num
            highbandwidth_w[start_point : end_point, :] = quant_flatten
            tmp_mem_cnt += quant_num
            quant_all[item_name] = quant_data_raw        
        else:
            print(item)
            raise("Unrecognized params!")
        
    # runtime reference gen
    print(weight_all.keys())
    runtime_data_gen(weight_all, bias_all, quant_all, skipadd_all)

    # ibb1 debug
    ibb1_debug = 0
    if ibb1_debug:
        ibb1_ifmap_flatten = debug_ifmap_load('runtime_data/conv00.txt', SIMD_FACTOR)
        highbandwidth_a[0:ibb1_ifmap_flatten.shape[0], :] = ibb1_ifmap_flatten
    # ibb2 debug
    ibb2_debug = 0
    if ibb2_debug:
        ibb2_ifmap_flatten = debug_ifmap_load('runtime_data/ibb0_skipadd.txt', SIMD_FACTOR)
        highbandwidth_a[0:ibb2_ifmap_flatten.shape[0], :] = ibb2_ifmap_flatten
    # ibb3 debug
    ibb3_debug = 0
    if ibb3_debug:
        ibb3_ifmap_flatten = debug_ifmap_load('runtime_data/ibb1_skipadd.txt', SIMD_FACTOR)
        highbandwidth_a[0:ibb3_ifmap_flatten.shape[0], :] = ibb3_ifmap_flatten
    # ibb4 debug
    ibb4_debug = 0
    if ibb4_debug:
        ibb4_ifmap_flatten = debug_ifmap_load('runtime_data/ibb2_skipadd.txt', SIMD_FACTOR)
        highbandwidth_a[0:ibb4_ifmap_flatten.shape[0], :] = ibb4_ifmap_flatten
    # avgpool and linear debug
    avg_linear_debug = 0
    if avg_linear_debug:
        avg_ifmap_flatten = debug_ifmap_load('runtime_data/ibb3_skipadd.txt', SIMD_FACTOR)
        highbandwidth_a[0:avg_ifmap_flatten.shape[0], :] = avg_ifmap_flatten
    # softmax and postprocess
    softmax_debug = 0
    if softmax_debug:
        linear_flatten = debug_ifmap_load('runtime_data/linear_out.txt', SIMD_FACTOR)
        highbandwidth_a[0:linear_flatten.shape[0], :] = linear_flatten

    cocotb.start_soon(
        mem_driver(dut, "instr_rom", irom, dut.iram_mem_rd, dut.iram_mem_wr, dut.iram_mem_addr, dut.iram_mem_wdata,
                   dut.iram_mem_rdata))
    cocotb.start_soon(
        highbendwidth_fbank_mem_driver(dut, "fbank_ram", int(VECTOR_LEN / SIMD_FACTOR), highbandwidth_fb,
                                dut.highBandWidth_fb_mem_rd, dut.highBandWidth_fb_mem_wr,
                                dut.highBandWidth_fb_mem_addr, dut.highBandWidth_fb_mem_wdata,
                                dut.highBandWidth_fb_mem_rdata))
    cocotb.start_soon(
        highbendwidth_act_mem_driver(dut, "act_ram", int(VECTOR_LEN / SIMD_FACTOR), highbandwidth_a,
                                 dut.highBandWidth_a_mem_rd, dut.highBandWidth_a_mem_wr,
                                 dut.highBandWidth_a_mem_addr, dut.highBandWidth_a_mem_wdata,
                                 dut.highBandWidth_a_mem_rdata))
    cocotb.start_soon(
        highbendwidth_mem_driver_weight(dut, "weight_ram", int(VECTOR_LEN / SIMD_FACTOR), highbandwidth_w,
                                        dut.highBandWidth_w_mem_rd, dut.highBandWidth_w_mem_wr,
                                        dut.highBandWidth_w_mem_addr, dut.highBandWidth_w_mem_wdata,
                                        dut.highBandWidth_w_mem_rdata))
    cocotb.start_soon(mem_driver(dut, "config", lowbandwidth, dut.lowBandWidth_mem_rd, dut.lowBandWidth_mem_wr,
                                 dut.lowBandWidth_mem_addr, dut.lowBandWidth_mem_wdata,
                                 dut.lowBandWidth_mem_rdata))
    
    # monitor
    cocotb.start_soon(monitor_layer1(dut, highbandwidth_a, fbank_0_raw, weight_all['conv00_w'], bias_all['conv00_b'], quant_all['conv00_q']))

    ibb1_c1_ofmap = np.loadtxt('runtime_data/conv10.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb1_c1(dut, highbandwidth_a , macros, act_start, ibb1_c1_ofmap))
    ibb1_cskip_ofmap = np.loadtxt('runtime_data/conv13.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb1_cskip(dut, highbandwidth_a , macros, act_start, ibb1_cskip_ofmap))
    ibb1_dw_ofmap = np.loadtxt('runtime_data/conv11.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb1_dw(dut, highbandwidth_a , macros, act_start, ibb1_dw_ofmap))
    ibb1_c2_ofmap = np.loadtxt('runtime_data/conv12.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb1_c2(dut, highbandwidth_a , macros, act_start, ibb1_c2_ofmap))
    ibb1_skip_add = np.loadtxt('runtime_data/ibb0_skipadd.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb1_skipadd(dut, highbandwidth_a , macros, act_start, ibb1_skip_add))

    ibb2_c1_ofmap = np.loadtxt('runtime_data/conv20.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb2_c1(dut, highbandwidth_a , macros, act_start, ibb2_c1_ofmap))
    ibb2_dw_ofmap = np.loadtxt('runtime_data/conv21.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb2_dw(dut, highbandwidth_a , macros, act_start, ibb2_dw_ofmap))
    ibb2_c2_ofmap = np.loadtxt('runtime_data/conv22.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb2_c2(dut, highbandwidth_a , macros, act_start, ibb2_c2_ofmap))
    ibb2_skip_add = np.loadtxt('runtime_data/ibb1_skipadd.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb2_skipadd(dut, highbandwidth_a , macros, act_start, ibb2_skip_add))

    cocotb.start_soon(monitor_ibb2_all(dut, highbandwidth_a , macros, act_start, ibb2_skip_add))

    ibb3_c1_ofmap = np.loadtxt('runtime_data/conv30.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb3_c1(dut, highbandwidth_a , macros, act_start, ibb3_c1_ofmap))
    ibb3_cskip_ofmap = np.loadtxt('runtime_data/conv33.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb3_cskip(dut, highbandwidth_a , macros, act_start, ibb3_cskip_ofmap))
    ibb3_dw_ofmap = np.loadtxt('runtime_data/conv31.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb3_dw(dut, highbandwidth_a , macros, act_start, ibb3_dw_ofmap))
    ibb3_c2_ofmap = np.loadtxt('runtime_data/conv32.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb3_c2(dut, highbandwidth_a , macros, act_start, ibb3_c2_ofmap))
    ibb3_skip_add = np.loadtxt('runtime_data/ibb2_skipadd.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb3_skipadd(dut, highbandwidth_a , macros, act_start, ibb3_skip_add))
    
    ibb4_c1_ofmap = np.loadtxt('runtime_data/conv40.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb4_c1(dut, highbandwidth_a , macros, act_start, ibb4_c1_ofmap))
    ibb4_dw_ofmap = np.loadtxt('runtime_data/conv41.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb4_dw(dut, highbandwidth_a , macros, act_start, ibb4_dw_ofmap))
    ibb4_c2_ofmap = np.loadtxt('runtime_data/conv42.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb4_c2(dut, highbandwidth_a , macros, act_start, ibb4_c2_ofmap))
    ibb4_skip_add = np.loadtxt('runtime_data/ibb3_skipadd.txt', dtype=np.int32)
    cocotb.start_soon(monitor_ibb4_skipadd(dut, highbandwidth_a , macros, act_start, ibb4_skip_add))

    cocotb.start_soon(monitor_ibb4_all(dut, highbandwidth_a , macros, act_start, ibb4_skip_add))

    avgpool_out = np.loadtxt('runtime_data/avgpool_out.txt', dtype=np.int32)
    cocotb.start_soon(monitor_avgpool(dut, highbandwidth_a , macros, act_start, avgpool_out))

    linear_out = np.loadtxt('runtime_data/linear_out.txt', dtype=np.int32)
    cocotb.start_soon(monitor_linear(dut, highbandwidth_a , macros, act_start, linear_out))

    await RisingEdge(dut.resetn)
    await Timer(10, units="ns")
    await RisingEdge(dut.clk)
    dut.core_start.value = 1
    await RisingEdge(dut.clk)
    dut.core_start.value = 0
    #
    #await Timer(80000, units="ns")

    # print(Teconv_weight_reorder(weight_0_raw))
    # print('TEST PASS !')
    # print(simd_mul_and_sum(
    #     fbank_0_raw[0, :16], weight_0_raw[0, 1, :16]))
    # print(simd_mul_sum_add_bias(
    #     fbank_0_raw[0, :16], weight_0_raw[0, 1, :16], bias_0_raw[0, 0]))
    # print(conv_16x16x1(fbank_0_raw[0, :16],
    #       weight_0_raw[:, 1, :16], bias_0_raw[0, :]))
    # print(fbank_0_raw[0, :16])
    # print(weight_0_raw[0, 1, :16])
    # print(Teconv_weight_reorder(weight_0_raw)[0, 1, 0, 0, :])
    # print(highbandwidth_w[32, :])

    # first_conv = conv_16xWxC(ibb1_ifmap_flatten[0:1, :], weight_all['conv10_w'][:16, :, :], bias_all['conv10_b'][0,:])
    # print("First Conv ifmap:\n {},\n  weight:\n  {},\n  bias:\n {},\n  result:\n{}\n ".format(ibb1_ifmap_flatten[0, :],weight_all['conv10_w'][:16, :, :], bias_all['conv10_b'][0,:],first_conv))
    # acc_mul_scale_result = acc_mul_scale_add_shift(quant_all['conv10_q'][0,1], quant_all['conv10_q'][0,0], quant_all['conv10_q'][0,2], first_conv)
    # print("First Conv acc mul scale add bias result:\n {}".format(acc_mul_scale_result))
    # acc_relu = fmsr(quant_all['conv10_q'][0,1], quant_all['conv10_q'][0,0], quant_all['conv10_q'][0,2], first_conv)
    # print("First Conv relu result:\n {}".format(acc_relu))

    # sec_conv = conv_16xWxC(ibb1_ifmap_flatten[3:4, :], weight_all['conv13_w'][:16, :, :], bias_all['conv13_b'][0,:])
    # print("Sec Conv ifmap:\n {},\n  weight:\n {},\n  bias:\n {},\n  result:\n{}\n ".format(ibb1_ifmap_flatten[3:4, :],weight_all['conv13_w'][:16, :, :], bias_all['conv13_b'][0,:],sec_conv))
    # acc_mul_scale_result = acc_mul_scale_add_shift(quant_all['conv13_q'][0,1], quant_all['conv13_q'][0,0], quant_all['conv13_q'][0,2], sec_conv)
    # print("Sec Conv acc mul scale add bias result:\n {}".format(acc_mul_scale_result))
    # acc_relu = fmsr(quant_all['conv13_q'][0,1], quant_all['conv13_q'][0,0],quant_all['conv13_q'][0,2],  sec_conv)
    # print("Sec Conv relu result:\n {}".format(acc_relu))


    # conv_1D_result = conv_1D(ibb1_ifmap_flatten[0:5, :], weight_all['conv10_w'][:, :, :],
    #                          bias_all['conv10_b'][:,:], quant_all['conv10_q'][:,:], 1)
    # print(conv_1D_result.reshape(15,16))

    # conv_skip_result = conv_1D(ibb1_ifmap_flatten[0:5, :], weight_all['conv13_w'][:, :, :],
    #                          bias_all['conv13_b'][:,:], quant_all['conv13_q'][:,:], 2)
    # print(conv_skip_result.reshape(3,16))

    # ifmap_dw_start = macros['IBB1_DW_ifmapBase'] - act_start
    # ifmap = ibb1_c1_ofmap[52:60, :]
    # print(ifmap.shape)
    # weight = weight_all['conv11_w'][0, 0:8, :]
    # bias = bias_all['conv11_b'][0, :]
    # quant = quant_all['conv11_q']
    # dw1 = dwconv_mxn(ifmap, weight, bias)
    # print(dw1.reshape(3, 16))
    # dw1 = dwconv_mxn_relu(ifmap, weight, bias, quant)
    # print(dw1.reshape(3, 16))
    # print('------------------')
    # print(weight)
    # print('------------------')
    # print(bias_all['conv40_b'])
    # print('------------------')
    # print(highbandwidth_w[macros['IBB4_C1_BiasBase']-weight_start:macros['IBB4_C1_BiasBase']-weight_start+12])
    # print('------------------')
    # bias_data_raw = load_bias('data/conv40_b.txt')
    # bias_data_raw = np.array(bias_data_raw).reshape([1,48])
    # bias_size_fix = [1, int(48 / LINE_BIAS_NUM), LINE_BIAS_NUM]
    # bias_flatten = bias_data_raw.reshape(bias_size_fix)
    # bias_flatten = bias_flatten.reshape([-1, LINE_BIAS_NUM])
    # bias_flatten = bias_enlarge_dim(bias_flatten, SIMD_FACTOR)
    # print(bias_flatten)

    # await Timer(100000*10, units="ns")
    await Timer(10000, units="ns")
    print("Total weight mem len = {} * 128bit.".format(tmp_mem_cnt))


if __name__ == '__main__':
    print('test')

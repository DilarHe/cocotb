import random
import math
import cocotb
import numpy as np
import sys
import csv
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge, Timer, Edge ,ClockCycles 

# this is selfdegine package
sys.path.append("/home/zyy/coco_work/cocoTest/common_lib")
from common_drivers import *
from Binary import *


async def reset_dut(reset_n, duration_ns):
    reset_n.value = 0
    await Timer(duration_ns, units="ns")
    reset_n.value = 1
    reset_n._log.info("Reset complete.")

async def driver(dut, raw_data):
    cnt = 0
    await RisingEdge(dut.rstn_80m)
    await RisingEdge(dut.clk_80m)
    
    for timer_trigger in range(80):
        dut.fdt_sampling.value = 1
        for phase in range(4): #4 phase
            for x in range(180): #2.8ms
                await RisingEdge(dut.clk_80m)
            for row in range(9): #9 row
                if(dut.fdt_adc_in_mode==1):
                    for col in range(4): # 4 col
                        for x in range(31): #400ns
                            await RisingEdge(dut.clk_80m)
                        dut.fdt_adc_in_vld.value = 1
                        dut.fdt_adc_in_0.value = int(raw_data[cnt])
                        cnt += 1
                        await RisingEdge(dut.clk_80m)
                        dut.fdt_adc_in_vld.value = 0
                    for x in range(12): #150ns
                        await RisingEdge(dut.clk_80m)
                else:
                    for col in range(2): # 4 col / 2 adc 
                        for x in range(31): #400ns
                            await RisingEdge(dut.clk_80m)
                        dut.fdt_adc_in_vld.value = 1
                        dut.fdt_adc_in_0.value = int(raw_data[cnt])
                        dut.fdt_adc_in_1.value = int(raw_data[cnt+1])
                        cnt += 2
                        await RisingEdge(dut.clk_80m)
                        dut.fdt_adc_in_vld.value = 0
                    for x in range(12): #150ns
                        await RisingEdge(dut.clk_80m)
        dut.fdt_sampling.value = 0
        for x in range(4000):
            await RisingEdge(dut.clk_80m)

def Relu(x):
    x = np.where(x<0,0,x)
    return x

def smpQ_sel(area_num,num,dut):
    match area_num:
        case 0:
            match num:
                case 0:
                    return dut.amp_cal_unit.smpArrayQ_0_0.value
                case 1:
                    return dut.amp_cal_unit.smpArrayQ_0_1.value
                case 2:
                    return dut.amp_cal_unit.smpArrayQ_0_2.value
                case 3:
                    return dut.amp_cal_unit.smpArrayQ_0_3.value
                case 4:
                    return dut.amp_cal_unit.smpArrayQ_0_4.value
                case 5:
                    return dut.amp_cal_unit.smpArrayQ_0_5.value
                case 6:
                    return dut.amp_cal_unit.smpArrayQ_0_6.value
                case 7:
                    return dut.amp_cal_unit.smpArrayQ_0_7.value
                case 8:
                    return dut.amp_cal_unit.smpArrayQ_0_8.value
                case 9:
                    return dut.amp_cal_unit.smpArrayQ_0_9.value
                case 10:
                    return dut.amp_cal_unit.smpArrayQ_0_10.value
                case 11:
                    return dut.amp_cal_unit.smpArrayQ_0_11.value
                case _:
                    return 0
        case 1:
            match num:
                case 0:
                    return dut.amp_cal_unit.smpArrayQ_1_0.value
                case 1:
                    return dut.amp_cal_unit.smpArrayQ_1_1.value
                case 2:
                    return dut.amp_cal_unit.smpArrayQ_1_2.value
                case 3:
                    return dut.amp_cal_unit.smpArrayQ_1_3.value
                case 4:
                    return dut.amp_cal_unit.smpArrayQ_1_4.value
                case 5:
                    return dut.amp_cal_unit.smpArrayQ_1_5.value
                case 6:
                    return dut.amp_cal_unit.smpArrayQ_1_6.value
                case 7:
                    return dut.amp_cal_unit.smpArrayQ_1_7.value
                case 8:
                    return dut.amp_cal_unit.smpArrayQ_1_8.value
                case 9:
                    return dut.amp_cal_unit.smpArrayQ_1_9.value
                case 10:
                    return dut.amp_cal_unit.smpArrayQ_1_10.value
                case 11:
                    return dut.amp_cal_unit.smpArrayQ_1_11.value
                case _:
                    return 0
        case 2:
            match num:
                case 0:
                    return dut.amp_cal_unit.smpArrayQ_2_0.value
                case 1:
                    return dut.amp_cal_unit.smpArrayQ_2_1.value
                case 2:
                    return dut.amp_cal_unit.smpArrayQ_2_2.value
                case 3:
                    return dut.amp_cal_unit.smpArrayQ_2_3.value
                case 4:
                    return dut.amp_cal_unit.smpArrayQ_2_4.value
                case 5:
                    return dut.amp_cal_unit.smpArrayQ_2_5.value
                case 6:
                    return dut.amp_cal_unit.smpArrayQ_2_6.value
                case 7:
                    return dut.amp_cal_unit.smpArrayQ_2_7.value
                case 8:
                    return dut.amp_cal_unit.smpArrayQ_2_8.value
                case 9:
                    return dut.amp_cal_unit.smpArrayQ_2_9.value
                case 10:
                    return dut.amp_cal_unit.smpArrayQ_2_10.value
                case 11:
                    return dut.amp_cal_unit.smpArrayQ_2_11.value
                case _:
                    return 0
        case _:
            return 0
        
async def amp_monitor(dut,ref_result):
    fdt_smp_num = 0
    while (1):  
        for area_num in range(3):
            await FallingEdge(dut.amp_cal_unit.amp_cal_end)
            await RisingEdge(dut.clk_80m)
            for amp_num in range(12):
                dut_result_num = smpQ_sel(area_num,amp_num, dut).integer
                ref_result_num = ref_result[fdt_smp_num,area_num,amp_num]
            if not dut_result_num == ref_result_num:
                print(f"dut result: {dut_result_num}")
                print(f"ref result: {ref_result_num}")
                raise("!")
        fdt_smp_num +=1

async def amp_mean_monitor(dut,ref_result):
    amp_meam_samp_num = 0
    while (1): 
        await FallingEdge(dut.norm_unit.amp_mean_vld_0)
        await RisingEdge(dut.clk_80m)
        dut_result_num = dut.norm_unit.amp_mean_0.value.integer
        ref_result_num = ref_result[amp_meam_samp_num,0]
        if not dut_result_num == ref_result_num:
            print(f"dut result: {dut_result_num}")
            print(f"ref result: {ref_result_num}")
            raise("!")
        await FallingEdge(dut.norm_unit.amp_mean_vld_1)
        await RisingEdge(dut.clk_80m)
        dut_result_num = dut.norm_unit.amp_mean_1.value.integer
        ref_result_num = ref_result[amp_meam_samp_num,1]
        if not dut_result_num == ref_result_num :
            print(f"dut result: {dut_result_num}")
            print(f"ref result: {ref_result_num}")
            raise("!")    
        await FallingEdge(dut.norm_unit.amp_mean_vld_2)
        await RisingEdge(dut.clk_80m)
        dut_result_num = dut.norm_unit.amp_mean_2.value.integer
        ref_result_num = ref_result[amp_meam_samp_num,2]
        if not dut_result_num == ref_result_num :
            print(f"dut result: {dut_result_num}")
            print(f"ref result: {ref_result_num}")
            raise("!")    
        amp_meam_samp_num +=1
    
async def norm_monitor(dut,ref_result):
    norm_samp_num = 0
    area_point_num = 0
    while (1): 
        await RisingEdge(dut.clk_80m)
        if dut.norm_unit.cal_norm_inc.value==1 and dut.norm_unit.cal_norm_done.value==0 :
            # print(f'cal_norm_Value_0 : {dut.norm_unit.cal_norm_Value_0.value.integer}')
            # print(f'norm ref Value 0 : {ref_result[norm_samp_num,dut.norm_unit.search_area_num.value,area_point_num]}')
            if dut.norm_unit.search_area_num.value==0:
                dut_result_num = dut.norm_unit.cal_norm_Value_0.value.integer
            elif dut.norm_unit.search_area_num.value==1:
                dut_result_num = dut.norm_unit.cal_norm_Value_1.value.integer
            else :
                dut_result_num = dut.norm_unit.cal_norm_Value_2.value.integer
            ref_result_num = ref_result[norm_samp_num,dut.norm_unit.search_area_num.value,area_point_num]
            if not dut_result_num == ref_result_num :
                print(f'norm_samp_num : {norm_samp_num}')
                print(f'search_area_num : {dut.norm_unit.search_area_num.value}')
                print(f'area_point_num : {area_point_num}')
                print(f"dut result: {dut_result_num}")
                print(f"ref result: {ref_result_num}")
                await RisingEdge(dut.clk_80m)
                await RisingEdge(dut.clk_80m)
                raise("!")
            if area_point_num >= 63:
                area_point_num = 0
            else:
                area_point_num += 1
        if dut.norm_unit.cal_norm_done.value==1 :
            norm_samp_num += 1

async def rnn_monitor(dut,cache,params,input_size,hidden_size,output_size,thread,data_rato,output_cache_base):
    seq_cnt = 0
    
    input_base_area0 = 0
    input_base_area1 = input_base_area0 + 20 + 8 #28  
    input_base_area2 = input_base_area1 + 20 #48
    output_base_area0 = output_cache_base #8
    output_base_area1 = output_base_area0 + 20 + 8 #36
    output_base_area2 = output_base_area1 + 20 #56 

    # for next seq hh calculate
    if_matmul_cal_result_relu_area0 = 0
    if_matmul_cal_result_relu_area1 = 0
    if_matmul_cal_result_relu_area2 = 0
    hi_matmul_cal_result_relu_area0 = 0
    hi_matmul_cal_result_relu_area1 = 0
    hi_matmul_cal_result_relu_area2 = 0
    
    while (1): 
        # await FallingEdge(dut.NN_layer_unit.start_once)
        await RisingEdge(dut.clk)
        if dut.NN_layer_unit.start_once == 1:
            dut._log.info('=================== monitor NN area number :{} ================='.format(dut.area_cnt.value.integer))
            #================ base on area cnt switch base & result store var 
            if dut.area_cnt.value == 0 :
                intput_base = input_base_area0
                output_base = output_base_area0
                if_matmul_cal_result_relu = if_matmul_cal_result_relu_area0
                hi_matmul_cal_result_relu = hi_matmul_cal_result_relu_area0
            elif dut.area_cnt.value == 1 :
                intput_base = input_base_area1
                output_base = output_base_area1
                if_matmul_cal_result_relu = if_matmul_cal_result_relu_area1
                hi_matmul_cal_result_relu = hi_matmul_cal_result_relu_area1
            else :
                intput_base = input_base_area2
                output_base = output_base_area2
                if_matmul_cal_result_relu = if_matmul_cal_result_relu_area2
                hi_matmul_cal_result_relu = hi_matmul_cal_result_relu_area2
            #================ base on seq_cnt switch matmul cnt end point
            if seq_cnt != 0:
                matmul_num = 10
            else:
                matmul_num = 8
            # if dut.area_cnt.value == 0 :
            for layer_num in range(matmul_num):
                await FallingEdge(dut.NN_layer_unit.matmul_start_once)
                dut._log.info('=================== monitor seq_cnt : {}'.format(seq_cnt))
                if  dut.NN_layer_unit.NN_cur_state.value == 1 and \
                    seq_cnt != 0 and \
                    dut.NN_layer_unit.LY_cur_state.value == 1:
                    dut._log.info('=================== monitor area : {} seq start input layer HH ================='.format(dut.area_cnt.value.integer))
                    dut._log.info('if_bias : {} '.format(params.if_bias))
                    dut._log.info('h0 result: {} '.format(if_matmul_cal_result_relu))
                    if_matmul_hh_cal_result = np.matmul(if_matmul_cal_result_relu, params.if_matW_H_int32) + params.if_bias.astype(np.int32)
                if dut.NN_layer_unit.NN_cur_state.value == 1   :
                    dut._log.info('=================== monitor area : {} start input layer HI ================='.format(dut.area_cnt.value.integer))
                    get_norm_cal_result = split_mem_element(cache[intput_base:intput_base+int(input_size/thread)], gather_ratio = 8, n_bits = 8, signed = True)
                    norm_cal_result = np.array(get_norm_cal_result).reshape(1, input_size).astype(np.int32)
                    if seq_cnt != 0:
                        if_matmul_hi_cal_result = np.matmul(norm_cal_result, params.if_matW_I_int32) + if_matmul_hh_cal_result
                    else:
                        if_matmul_hi_cal_result = np.matmul(norm_cal_result, params.if_matW_I_int32) + params.if_bias.astype(np.int32)
                    if_matmul_cal_result_scale = if_matmul_hi_cal_result // data_rato
                    if_matmul_cal_result_sat = np.clip(if_matmul_cal_result_scale,np.iinfo(np.int8).min,np.iinfo(np.int8).max)
                    if_matmul_cal_result_relu = Relu(if_matmul_cal_result_sat)
                    dut._log.info('if_bias : {} '.format(params.if_bias))
                    dut._log.info('norm_cal_result : {} '.format(norm_cal_result))
                    dut._log.info('if_matmul_hi_cal_result : {} '.format(if_matmul_hi_cal_result))
                    dut._log.info('if_matmul_cal_result_scale : {} '.format(if_matmul_cal_result_scale))
                    dut._log.info('if_matmul_cal_result_sat : {} '.format(if_matmul_cal_result_sat))
                    dut._log.info('if_matmul_cal_result_relu : {} '.format(if_matmul_cal_result_relu))
                elif dut.NN_layer_unit.NN_cur_state.value == 2 and\
                        seq_cnt != 0 and\
                        dut.NN_layer_unit.LY_cur_state.value == 1 :     
                    dut._log.info('=================== monitor area : {} seq start hidden layer HH ================='.format(dut.area_cnt.value.integer))
                    dut._log.info('h1 result: {} '.format(hi_matmul_cal_result_relu))
                    hi_matmul_hh_cal_result = np.matmul(hi_matmul_cal_result_relu, params.hi_matW_H_int32) + params.hi_bias.astype(np.int32)
                elif dut.NN_layer_unit.NN_cur_state.value == 2 :  
                    dut._log.info('=================== monitor area : {} start hidden layer HI ================='.format(dut.area_cnt.value.integer))
                    get_input_layer_cal_result = split_mem_element(cache[output_base:output_base+int(hidden_size/thread)], gather_ratio = 8, n_bits = 8, signed = True)
                    input_layer_cal_result = np.array(get_input_layer_cal_result).reshape(1, hidden_size).astype(np.int32)
                    if not np.array_equal(input_layer_cal_result,if_matmul_cal_result_relu) :
                        dut._log.info('!input_layer_cal_result mismatch!')
                        dut._log.info('dut cache input_layer_cal_result : {} '.format(input_layer_cal_result))
                        dut._log.info('ref if_matmul_cal_result_relu : {} '.format(if_matmul_cal_result_relu))
                        raise('!')
                    if seq_cnt != 0:
                        hi_matmul_hi_cal_result = np.matmul(input_layer_cal_result, params.hi_matW_I_int32) + hi_matmul_hh_cal_result
                    else:
                        hi_matmul_hi_cal_result = np.matmul(input_layer_cal_result, params.hi_matW_I_int32) + params.hi_bias.astype(np.int32)
                    hi_matmul_cal_result_scale = hi_matmul_hi_cal_result // data_rato
                    hi_matmul_cal_result_sat = np.clip(hi_matmul_cal_result_scale,np.iinfo(np.int8).min,np.iinfo(np.int8).max)
                    hi_matmul_cal_result_relu = Relu(hi_matmul_cal_result_sat)
                    dut._log.info('input_layer_cal_result : {} '.format(input_layer_cal_result))
                    dut._log.info('hidden layer result ,hi_matmul_hi_cal_result : {} '.format(hi_matmul_hi_cal_result))
                    dut._log.info('hidden layer result ,hi_matmul_cal_result_scale : {} '.format(hi_matmul_cal_result_scale))
                    dut._log.info('hidden layer result ,hi_matmul_cal_result_sat : {} '.format(hi_matmul_cal_result_sat))
                    dut._log.info('hidden layer result ,hi_matmul_cal_result_relu : {} '.format(hi_matmul_cal_result_relu))      
                elif dut.NN_layer_unit.NN_cur_state.value == 3 :  
                    dut._log.info('=================== monitor area : {} start fc up down layer ================='.format(dut.area_cnt.value.integer))
                    hidden_layer_cal_result_base = output_base+10
                    get_hidden_layer_cal_result = split_mem_element(cache[hidden_layer_cal_result_base:hidden_layer_cal_result_base+int(hidden_size/thread)], gather_ratio = 8, n_bits = 8, signed = True)
                    hidden_layer_cal_result = np.array(get_hidden_layer_cal_result).reshape(1, hidden_size).astype(np.int32)
                    if not np.array_equal(hidden_layer_cal_result,hi_matmul_cal_result_relu) :
                        dut._log.info('!hidden_layer_cal_result mismatch!')
                        dut._log.info('dut cache hidden_layer_cal_result : {} '.format(hidden_layer_cal_result))
                        dut._log.info('ref hi_matmul_cal_result_relu : {} '.format(hi_matmul_cal_result_relu))
                        raise('!')
                    fc_ud_matmul_cal_result = np.matmul(hidden_layer_cal_result, params.fc_ud_matW_int32) + params.fc_ud_bias.astype(np.int32)
                    fc_ud_matmul_cal_result_scale = fc_ud_matmul_cal_result // data_rato
                    fc_ud_matmul_cal_result_sat = np.clip(fc_ud_matmul_cal_result_scale,np.iinfo(np.int8).min,np.iinfo(np.int8).max)
                    fc_ud_matmul_cal_3_label_result = fc_ud_matmul_cal_result_sat[:,0:3]
                    fc_ud_matmul_cal_max_label = np.argmax(fc_ud_matmul_cal_result_sat[:,0:3])
                    dut._log.info('hidden_layer_cal_result : {} '.format(hidden_layer_cal_result))
                    dut._log.info('fc up down layer result ,fc_ud_bias : {} '.format(params.fc_ud_bias))
                    dut._log.info('fc up down layer result ,fc_ud_matmul_cal_result : {} '.format(fc_ud_matmul_cal_result))
                    dut._log.info('fc up down layer result ,fc_ud_matmul_cal_result_scale : {} '.format(fc_ud_matmul_cal_result_scale))
                    dut._log.info('fc up down layer result ,fc_ud_matmul_cal_result_sat : {} '.format(fc_ud_matmul_cal_result_sat))
                    dut._log.info('fc up down layer result ,fc_ud_matmul_cal_3_label_result : {} '.format(fc_ud_matmul_cal_3_label_result))
                    dut._log.info('fc up down layer result ,fc_ud_matmul_cal_max_label : {} '.format(fc_ud_matmul_cal_max_label))         
                elif dut.NN_layer_unit.NN_cur_state.value == 4 :
                    dut._log.info('=================== monitor area : {} start gateW layer ================='.format(dut.area_cnt.value.integer))
                    fc_ud_layer_cal_result_base = output_base+int(hidden_size/thread)
                    get_fc_ud_layer_cal_result = split_mem_element(cache[fc_ud_layer_cal_result_base:fc_ud_layer_cal_result_base+int(thread/thread)], gather_ratio = 8, n_bits = 8, signed = True)
                    dut._log.info('fc_ud_layer_cal_result_base : {} '.format(fc_ud_layer_cal_result_base))
                    dut._log.info('get_fc_ud_layer_cal_result : {} '.format(get_fc_ud_layer_cal_result))
                    fc_ud_layer_cal_reduced = get_fc_ud_layer_cal_result[:3]
                    fc_ud_layer_cal_result = np.array(fc_ud_layer_cal_reduced).reshape(1, output_size).astype(np.int32)
                    if not np.array_equal(fc_ud_layer_cal_result,fc_ud_matmul_cal_3_label_result) :
                        dut._log.info('!fc_ud_layer_cal_result mismatch!')
                        dut._log.info('dut cache fc_ud_layer_cal_result : {} '.format(fc_ud_layer_cal_result))
                        dut._log.info('ref fc_ud_matmul_cal_3_label_result : {} '.format(fc_ud_matmul_cal_3_label_result))
                        raise('!')
                    gateW_matmul_cal_result = np.matmul(hidden_layer_cal_result, params.gateW_matW_int32) + params.gateW_bias.astype(np.int32)
                    gateW_matmul_cal_result_scale = gateW_matmul_cal_result // data_rato
                    gateW_matmul_cal_result_sat = np.clip(gateW_matmul_cal_result_scale,np.iinfo(np.int8).min,np.iinfo(np.int8).max)
                    dut._log.info('fc_ud_layer_cal_result : {} '.format(fc_ud_layer_cal_result))
                    dut._log.info('hidden_layer_cal_result : {} '.format(hidden_layer_cal_result))
                    dut._log.info('gateW layer result ,gateW_matmul_cal_result : {} '.format(gateW_matmul_cal_result))
                    dut._log.info('gateW layer result ,gateW_matmul_cal_result_scale : {} '.format(gateW_matmul_cal_result_scale))
                    dut._log.info('gateW layer result ,gateW_matmul_cal_result_sat : {} '.format(gateW_matmul_cal_result_sat))    
                elif dut.NN_layer_unit.NN_cur_state.value == 5 :
                    dut._log.info('=================== monitor area : {} start scalar mult1 layer ================='.format(dut.area_cnt.value.integer))
                    gateW_layer_cal_result_base = fc_ud_layer_cal_result_base + int(thread/thread)
                    get_gateW_layer_cal_result = split_mem_element(cache[gateW_layer_cal_result_base:gateW_layer_cal_result_base+int(hidden_size/thread)], gather_ratio = 8, n_bits = 8, signed = True)
                    gateW_layer_cal_result = np.array(get_gateW_layer_cal_result).reshape(1, hidden_size).astype(np.int32)
                    if not np.array_equal(gateW_layer_cal_result,gateW_matmul_cal_result_sat) :
                        dut._log.info('!gateW_layer_cal_result mismatch!')
                        dut._log.info('dut cache gateW_layer_cal_result : {} '.format(gateW_layer_cal_result))
                        dut._log.info('ref gateW_matmul_cal_result_sat : {} '.format(gateW_matmul_cal_result_sat))
                        raise('!')
                    scala1_matmul_cal_result =  hidden_layer_cal_result * gateW_layer_cal_result 
                    scala1_matmul_cal_result_scale =  scala1_matmul_cal_result // data_rato 
                    scala1_matmul_cal_result_sat =  np.clip(scala1_matmul_cal_result_scale,np.iinfo(np.int8).min,np.iinfo(np.int8).max) 
                    dut._log.info('gateW_layer_cal_result : {} '.format(gateW_layer_cal_result))
                    dut._log.info('hidden_layer_cal_result : {} '.format(hidden_layer_cal_result))
                    dut._log.info('scala1 layer result ,scala1_matmul_cal_result : {} '.format(scala1_matmul_cal_result))
                    dut._log.info('scala1 layer result ,scala1_matmul_cal_result_scale : {} '.format(scala1_matmul_cal_result_scale))
                    dut._log.info('scala1 layer result ,scala1_matmul_cal_result_sat : {} '.format(scala1_matmul_cal_result_sat))    
                elif dut.NN_layer_unit.NN_cur_state.value == 6 :
                    dut._log.info('=================== monitor area : {} start fcn1 layer ================='.format(dut.area_cnt.value.integer))
                    scala1_layer_cal_result_base = gateW_layer_cal_result_base + int(hidden_size/thread)
                    get_scala1_layer_cal_result = split_mem_element(cache[scala1_layer_cal_result_base:scala1_layer_cal_result_base+int(hidden_size/thread)], gather_ratio = 8, n_bits = 8, signed = True)
                    scala1_layer_cal_result = np.array(get_scala1_layer_cal_result).reshape(1, hidden_size).astype(np.int32)
                    if not np.array_equal(scala1_layer_cal_result,scala1_matmul_cal_result_sat) :
                        dut._log.info('!scala1_layer_cal_result mismatch!')
                        dut._log.info('dut cache scala1_layer_cal_result : {} '.format(scala1_layer_cal_result))
                        dut._log.info('ref scala1_matmul_cal_result_sat : {} '.format(scala1_matmul_cal_result_sat))
                        raise('!')
                    fcn1_matmul_cal_result = np.matmul(scala1_layer_cal_result, params.fcn1_matW_int32) + params.fcn1_bias.astype(np.int32)
                    fcn1_matmul_cal_result_scale = fcn1_matmul_cal_result // data_rato
                    fcn1_matmul_cal_result_sat =  np.clip(fcn1_matmul_cal_result_scale,np.iinfo(np.int8).min,np.iinfo(np.int8).max) 
                    dut._log.info('scala1_layer_cal_result : {} '.format(scala1_layer_cal_result))
                    dut._log.info('fcn1 layer result ,fcn1_bias : {} '.format(params.fcn1_bias))
                    dut._log.info('fcn1 layer result ,fcn1_matmul_cal_result : {} '.format(fcn1_matmul_cal_result))
                    dut._log.info('fcn1 layer result ,fcn1_matmul_cal_result_scale : {} '.format(fcn1_matmul_cal_result_scale))
                    dut._log.info('fcn1 layer result ,fcn1_matmul_cal_result_sat : {} '.format(fcn1_matmul_cal_result_sat))          
                elif dut.NN_layer_unit.NN_cur_state.value == 7 :
                    dut._log.info('=================== monitor area : {} start fcn2 layer ================='.format(dut.area_cnt.value.integer))
                    fcn1_layer_cal_result_base = scala1_layer_cal_result_base + int(hidden_size/thread)
                    get_fcn1_layer_cal_result = split_mem_element(cache[fcn1_layer_cal_result_base:fcn1_layer_cal_result_base+int((hidden_size/2)/thread)], gather_ratio = 8, n_bits = 8, signed = True)
                    fcn1_layer_cal_result = np.array(get_fcn1_layer_cal_result).reshape(1, int(hidden_size/2)).astype(np.int32)
                    if not np.array_equal(fcn1_layer_cal_result,fcn1_matmul_cal_result_sat) :
                        dut._log.info('!fcn1_layer_cal_result mismatch!')
                        dut._log.info('dut cache fcn1_layer_cal_result : {} '.format(fcn1_layer_cal_result))
                        dut._log.info('ref fcn1_matmul_cal_result_sat : {} '.format(fcn1_matmul_cal_result_sat))
                        raise('!')
                    fcn2_matmul_cal_result = np.matmul(fcn1_layer_cal_result, params.fcn2_matW_int32) + params.fcn2_bias.astype(np.int32)
                    fcn2_matmul_cal_result_scale = fcn2_matmul_cal_result // data_rato
                    fcn2_matmul_cal_result_sat =  np.clip(fcn2_matmul_cal_result_scale,np.iinfo(np.int8).min,np.iinfo(np.int8).max) 
                    dut._log.info('fcn1_layer_cal_result : {} '.format(fcn1_layer_cal_result))
                    dut._log.info('fcn2 layer result ,fcn2_matmul_cal_result : {} '.format(fcn2_matmul_cal_result))
                    dut._log.info('fcn2 layer result ,fcn2_matmul_cal_result_scale : {} '.format(fcn2_matmul_cal_result_scale))
                    dut._log.info('fcn2 layer result ,fcn2_matmul_cal_result_sat : {} '.format(fcn2_matmul_cal_result_sat)) 
                elif dut.NN_layer_unit.NN_cur_state.value == 8 :
                    dut._log.info('=================== monitor area : {} start scalar mult2 layer ================='.format(dut.area_cnt.value.integer))
                    fcn2_layer_cal_result_base = fcn1_layer_cal_result_base + int((hidden_size/2)/thread)
                    get_fcn2_layer_cal_result = split_mem_element(cache[fcn2_layer_cal_result_base:fcn2_layer_cal_result_base+int(thread/thread)], gather_ratio = 8, n_bits = 8, signed = True)
                    fcn2_layer_cal_reduce = get_fcn2_layer_cal_result[:3]
                    fcn2_layer_cal_result = np.array(fcn2_layer_cal_reduce).reshape(1, output_size).astype(np.int32)
                    if not np.array_equal(fcn2_layer_cal_result,fcn2_matmul_cal_result_sat) :
                        dut._log.info('!fcn2_layer_cal_result mismatch!')
                        dut._log.info('dut cache fcn2_layer_cal_result : {} '.format(fcn2_layer_cal_result))
                        dut._log.info('ref fcn2_matmul_cal_result_sat : {} '.format(fcn2_matmul_cal_result_sat))
                        raise('!')
                    scala2_matmul_cal_result =  fcn2_layer_cal_result * fc_ud_layer_cal_result 
                    scala2_matmul_cal_3_label_result = scala2_matmul_cal_result[:,0:3]
                    scala2_matmul_cal_max_label = np.argmax(scala2_matmul_cal_3_label_result[:,0:3])
                    dut._log.info('fcn2_layer_cal_result : {} '.format(fcn2_layer_cal_result))
                    dut._log.info('scala2 layer result ,scala2_matmul_cal_result : {} '.format(scala2_matmul_cal_result))
                    dut._log.info('scala2 layer result ,scala2_matmul_cal_3_label_result : {} '.format(scala2_matmul_cal_3_label_result))
                    dut._log.info('scala2 layer result ,scala2_matmul_cal_max_label : {} '.format(scala2_matmul_cal_max_label))
                    #============ store cur RNN result for next seq
                    if dut.area_cnt.value == 0 :
                        if_matmul_cal_result_relu_area0 = if_matmul_cal_result_relu
                        hi_matmul_cal_result_relu_area0 = hi_matmul_cal_result_relu
                    elif dut.area_cnt.value == 1 :
                        if_matmul_cal_result_relu_area1 = if_matmul_cal_result_relu
                        hi_matmul_cal_result_relu_area1 = hi_matmul_cal_result_relu
                    else :
                        if_matmul_cal_result_relu_area2 = if_matmul_cal_result_relu
                        hi_matmul_cal_result_relu_area2 = hi_matmul_cal_result_relu
                        seq_cnt += 1
                    
                        
# 定义一个包含所有pre proc ref data的类
class pre_proc_ref_data:
    def __init__(self,raw_data,downsamp_row_onehot,amp_smp_num,area_num,samp_size,input_size,data_rato):
        # 将二进制数转换为字符串，不带前缀 '0b'
        binary_str = bin(downsamp_row_onehot)[2:]
        # 按照3位进行切分
        split_length = 3
        split_binary = [binary_str[i:i+split_length] for i in range(0, len(binary_str), split_length)]
        # 将每一段转换回二进制数
        split_binary_values = [int(bits, 2) for bits in split_binary]
        # 创建一个新的列表
        samp_line_list = []
        # 遍历 split_binary_values 并将其值赋给新列表
        for value in split_binary_values:
            bit_length = value.bit_length()  # 获取比特长度
            samp_line_list.append(bit_length)  # 将值和比特长度作为元组加入新列表
        # print(samp_line_list)  # 输出: [3, 3, 3]
        amp_samp_number = []
        for line in samp_line_list:
            amp_samp_number.append(line * 4)
        # print(amp_samp_number) # 输出: [12, 12, 12]
        #================ generate amp golden data ================# 
        #按照samp_size切分数据为多个frame
        raw_array = raw_data.reshape([-1,samp_size]) 
        #每个frame中实际降采样的数据
        frame_num = raw_array.shape[0]
        frame_array = np.zeros(shape=[frame_num,area_num,amp_samp_number[0]], dtype=int)
        #每4个frame完成一次amp计算，amp的个数与实际降采样的个数一致
        amp_cal_num = frame_num//4
        self.amp = np.zeros([amp_cal_num,area_num,amp_samp_number[0]], dtype=int)
        #每12个amp计算均值 
        self.amp_mean = np.zeros([amp_cal_num,area_num], dtype=int)
        self.amp_mean_ptp = np.zeros([amp_cal_num,area_num], dtype=int)
        self.amp_mean_ptp_power_of_2 = np.zeros([amp_cal_num,area_num], dtype=int)
        self.norm = np.zeros([amp_cal_num,area_num,input_size], dtype=int)
        # print("amp_cal_num : ",amp_cal_num)
        # print("each area amp_samp_number",amp_samp_number[0])
        #IQ的数据也是与amp的个数一致
        arrayI = np.zeros(shape=[amp_cal_num,area_num,amp_samp_number[0]], dtype=int)
        arrayQ = np.zeros(shape=[amp_cal_num,area_num,amp_samp_number[0]], dtype=int)
            #每个frame中实际降采样的数据
        for i in range(frame_num):
            row = 0
            area1_line_num = 0
            area2_line_num = 0
            area3_line_num = 0
            for row_n in range(9): #9 row
                if  0 <= row <= 2:
                    # 右移i位，然后与1进行按位与操作
                    bit = (downsamp_row_onehot >> row_n) & 1
                    if bit == 1:
                        # print(f"row {row_n} is sample in area 0")
                        for k in range(4):
                            frame_array[i,0,k+area1_line_num*4] = raw_array[i,row_n*4+k]
                    area1_line_num = area1_line_num + 1
                elif 3 <= row <= 5:
                    # 右移i位，然后与1进行按位与操作
                    bit = (downsamp_row_onehot >> row_n) & 1
                    if bit == 1:
                        # print(f"row {row_n} is sample in area 1")
                        for k in range(4):
                            frame_array[i,1,k+area2_line_num*4] = raw_array[i,row_n*4+k]
                    area2_line_num = area2_line_num + 1
                else:
                    # 右移i位，然后与1进行按位与操作
                    bit = (downsamp_row_onehot >> row_n) & 1
                    if bit == 1:
                        # print(f"row {row_n} is sample in area 2")
                        for k in range(4):
                            # print(f'phase {i} number {i,row_n*4+k} k {k} raw {raw_array[i,row_n*4+k]}')
                            # print(f'frame {i} number {k+area3_line_num*4}')
                            frame_array[i,2,k+area3_line_num*4] = raw_array[i,row_n*4+k]
                    area3_line_num = area3_line_num + 1
                row = row + 1
        # print('frame_array[0,0,:]',frame_array[0,0,:])
        # print('frame_array[0,1,:]',frame_array[0,1,:])
        # print('frame_array[0,2,:]',frame_array[0,2,:])
        # 计算IQ，计算amp（注意：此时没有考虑 温度档位 调整的逻辑）
        for i in range(amp_cal_num):
            for j in range(area_num):
                arrayI[i,j,:] = (frame_array[i*4,j,:]>>1) - (frame_array[i*4+1,j,:]>>1)
                arrayQ[i,j,:] = (frame_array[i*4+2,j,:]>>1) - (frame_array[i*4+3,j,:]>>1)
                for k in range(amp_samp_number[j]):
                    tmp = arrayI[i,j,k] * arrayI[i,j,k] + arrayQ[i,j,k] * arrayQ[i,j,k]
                    self.amp[i,j,k] = int(np.sqrt(tmp))
                self.amp_mean[i,j] = np.sum(self.amp[i,j,:])/amp_smp_num
                # self.amp_mean[i,j] = np.mean(self.amp[i,j,:])  
        for i in range(amp_cal_num-input_size):
            for j in range(area_num):
                test_set = self.amp_mean[i:input_size+i,j]
                self.amp_mean_ptp[i,j] =  np.ptp(test_set)    
                #计算小于等于 ptp_value 的最大 2 的 N 次方
                if self.amp_mean_ptp[i,j] > 0:
                    N = math.floor(math.log2(self.amp_mean_ptp[i,j]))
                    self.amp_mean_ptp_power_of_2[i,j] = 2**N
                else:
                    self.amp_mean_ptp_power_of_2[i,j] = 0
                diff = test_set - np.min(test_set) 
                # scale = np.clip(diff * data_rato,np.iinfo(np.int16).min,np.iinfo(np.int16).max)
                scale = diff * data_rato
                print(f' np.min(test_set) :{ np.min(test_set) }')
                print(f' diff:{diff}')
                print(f' scale:{scale}')
                self.norm[i,j,:] = np.clip(scale // self.amp_mean_ptp_power_of_2[i,j],np.iinfo(np.int8).min,np.iinfo(np.int8).max)
                # print(f'test_set length {len(test_set)}')
            # print(f'amp{i,j,0} {amp[i,j,:]}')
            # print(f'amp_mean{i,0} {amp_mean[i:INPUT_SIZE+i,0]}')
            # print(f'amp_mean{i,1} {amp_mean[i:INPUT_SIZE+i,1]}')
            # print(f'amp_mean{i,2} {amp_mean[i:INPUT_SIZE+i,2]}')
            # print(f'amp_mean_ptp_power_of_2{i,1} {amp_mean_ptp_power_of_2[i,1]}')
            # print(f'amp_mean_ptp{i,2} {amp_mean_ptp[i,2]}')
            # print(f'norm{i,0} {norm[i,0,:]} ')
            # print(f'norm{i,1} {norm[i,1,:]} ')
        
# 定义一个包含所有参数的类
class NeuralNetworkParams:
    def __init__(self, input_size, hidden_size, output_size):
        #================ generate NN reference data ================# 
        #+++++ if map
        self.if_matW_I = np.random.randint(-128,127,[input_size,hidden_size], dtype=np.int16)# (64,16)  
        self.if_matW_H = np.random.randint(-128,127,[hidden_size,hidden_size], dtype=np.int16)# (16,16)    
        self.if_bias = np.random.randint(-2**(12), 2**12-1, [hidden_size], dtype=np.int16)# (16,)
        self.if_matW_I_int32 = self.if_matW_I.astype(np.int32)
        self.if_matW_H_int32 = self.if_matW_H.astype(np.int32)
        # if_result_int32 = np.matmul(matI_int32, if_matW_I_int32) + np.matmul(matH_int32, if_matW_H_int32) + if_bias.astype(np.int32) # (1,32)
        #+++++ hidden 
        # hi_matI_int32 = if_result_int32
        # hi_matH_int32 = if_result_int32
        self.hi_matW_I = np.random.randint(-128,127,[hidden_size,hidden_size], dtype=np.int16)# (16,16)  
        self.hi_matW_H = np.random.randint(-128,127,[hidden_size,hidden_size], dtype=np.int16)# (16,16)    
        self.hi_bias = np.random.randint(-2**(12), 2**12-1, [hidden_size], dtype=np.int16)# (16,)
        self.hi_matW_I_int32 = self.hi_matW_I.astype(np.int32)
        self.hi_matW_H_int32 = self.hi_matW_H.astype(np.int32)
        # hi_result_int32 = np.matmul(hi_matI_int32, hi_matW_I_int32) + np.matmul(hi_matH_int32, hi_matW_H_int32) + hi_bias.astype(np.int32) # (1,32)
        #+++++ fc up down
        self.fc_ud_matW = np.random.randint(-128,127,[hidden_size,output_size], dtype=np.int16)# (16,8)  
        self.fc_ud_bias = np.random.randint(-2**(12), 2**12-1, [output_size], dtype=np.int16)# (8,)
        self.fc_ud_matW_int32 = self.fc_ud_matW.astype(np.int32)
        #+++++ gateW 
        self.gateW_matW = np.random.randint(-128,127,[hidden_size,hidden_size], dtype=np.int16)# (16,16)  
        self.gateW_bias = np.random.randint(-2**(12), 2**12-1, [hidden_size], dtype=np.int16)# (16,)
        self.gateW_matW_int32 = self.gateW_matW.astype(np.int32)
        self.fcn1_matW = np.random.randint(-128, 127, [hidden_size, int(hidden_size / 2)], dtype=np.int16)
        self.fcn1_bias = np.random.randint(-2**12, 2**12 - 1, [int(hidden_size / 2)], dtype=np.int16)
        self.fcn1_matW_int32 = self.fcn1_matW.astype(np.int32)
        
        self.fcn2_matW = np.random.randint(-128, 127, [int(hidden_size / 2), output_size], dtype=np.int16)
        self.fcn2_bias = np.random.randint(-2**12, 2**12 - 1, [output_size], dtype=np.int16)
        self.fcn2_matW_int32 = self.fcn2_matW.astype(np.int32)

def coef_cache_loader(dut,coef,params,THREAD):
    paramater_len = 0
    if_bias_base = 0
    #+++++ if map coef cache loading 
    if_matW_I_trans = params.if_matW_I.transpose() # (32,64)
    if_matW_H_trans = params.if_matW_H.transpose() # (32,32)
    # 将(16,64)的matW_trans，打平为【64个w，64个w，...，64个w】的list，这是为了符合矩阵乘的 行（输入）X 列（权重）的计算方式
    # 并且根据线程数（8）切分 list，并将每8个w组成的64bits数据组成新的list
    if_matW_I_gather = gather_array_element(if_matW_I_trans, THREAD, n_bits = 8, signed = True)
    if_matW_H_gather = gather_array_element(if_matW_H_trans, THREAD, n_bits = 8, signed = True)
    if_bias_gather = gather_array_element(params.if_bias, int(THREAD/2), n_bits = 16, signed = True)
    if_param_list = if_bias_gather + if_matW_I_gather + if_matW_H_gather
    coef[:len(if_param_list)] = if_param_list
    paramater_len += len(if_param_list)
    dut._log.info('loading if map coef done ,use word: {} ,Remaining word : {} '.format(len(if_param_list),len(coef)-paramater_len))
    # cache[:len(matI_gather)] = matI_gather
    if_weight_I_base = len(if_bias_gather)
    if_weight_H_base = if_weight_I_base + len(if_matW_I_gather)
    dut._log.info('if_bias_base : {} \nif_weight_I_base : {} \nif_weight_H_base : {} \n'.format(if_bias_base,if_weight_I_base,if_weight_H_base))
    #+++++ hidden coef cache loading 
    hi_bias_base = paramater_len
    hi_matW_I_trans = params.hi_matW_I.transpose() # (32,32)
    hi_matW_H_trans = params.hi_matW_H.transpose() # (32,32)
    hi_matW_I_gather = gather_array_element(hi_matW_I_trans, THREAD, n_bits = 8, signed = True)
    hi_matW_H_gather = gather_array_element(hi_matW_H_trans, THREAD, n_bits = 8, signed = True)
    hi_bias_gather = gather_array_element(params.hi_bias, int(THREAD/2), n_bits = 16, signed = True)
    hi_param_list = hi_bias_gather + hi_matW_I_gather + hi_matW_H_gather
    coef[paramater_len:paramater_len+len(hi_param_list)] = hi_param_list
    paramater_len += len(hi_param_list)
    dut._log.info('loading hidden coef done ,use word: {} ,Remaining word : {} '.format(len(hi_param_list),len(coef)-paramater_len))
    hi_weight_I_base = hi_bias_base + len(hi_bias_gather)
    hi_weight_H_base = hi_weight_I_base + len(hi_matW_I_gather)
    dut._log.info('hi_bias_base : {} \nif_weight_I_base : {} \nif_weight_H_base : {} \n'.format(hi_bias_base,hi_weight_I_base,hi_weight_H_base))
    #+++++ fc up down coef cache loading 
    fc_bias_base = paramater_len
    fc_matW_trans = params.fc_ud_matW.transpose() # (8,32)
    fc_matW_gather = gather_array_element(fc_matW_trans, THREAD, n_bits = 8, signed = True)
    fc_bias_expanded = np.pad(params.fc_ud_bias, (0, 1), mode='constant', constant_values=0)
    fc_bias_gather = gather_array_element(fc_bias_expanded, int(THREAD/2), n_bits = 16, signed = True)
    fc_param_list = fc_bias_gather + fc_matW_gather
    coef[paramater_len:paramater_len+len(fc_param_list)] = fc_param_list
    paramater_len += len(fc_param_list)
    dut._log.info('loading fc up down coef done ,use word: {} ,Remaining word : {} '.format(len(fc_param_list),len(coef)-paramater_len))
    fc_weight_base = fc_bias_base + len(fc_bias_gather)
    dut._log.info('fc_bias_base : {} \nfc_weight_base : {} \n'.format(fc_bias_base,fc_weight_base))    
    #+++++ gateW coef cache loading 
    gateW_bias_base = paramater_len
    gateW_matW_trans = params.gateW_matW.transpose() # (8,32)
    gateW_matW_gather = gather_array_element(gateW_matW_trans, THREAD, n_bits = 8, signed = True)
    gateW_bias_gather = gather_array_element(params.gateW_bias, int(THREAD/2), n_bits = 16, signed = True)
    gateW_param_list = gateW_bias_gather + gateW_matW_gather
    coef[paramater_len:paramater_len+len(gateW_param_list)] = gateW_param_list
    paramater_len += len(gateW_param_list)
    dut._log.info('loading gateW coef done ,use word: {} ,Remaining word : {} '.format(len(gateW_param_list),len(coef)-paramater_len))
    gateW_weight_base = gateW_bias_base + len(gateW_bias_gather)
    dut._log.info('gateW_bias_base : {} \n gateW_weight_base : {} \n'.format(gateW_bias_base,gateW_weight_base))    
    #+++++ fcn1 coef cache loading 
    fcn1_bias_base = paramater_len
    fcn1_matW_trans = params.fcn1_matW.transpose() # (8,32)
    fcn1_matW_gather = gather_array_element(fcn1_matW_trans, THREAD, n_bits = 8, signed = True)
    fcn1_bias_gather = gather_array_element(params.fcn1_bias, int(THREAD/2), n_bits = 16, signed = True)
    fcn1_param_list = fcn1_bias_gather + fcn1_matW_gather
    coef[paramater_len:paramater_len+len(fcn1_param_list)] = fcn1_param_list
    paramater_len += len(fcn1_param_list)
    dut._log.info('loading fcn1 coef done ,use word: {} ,Remaining word : {} '.format(len(fcn1_param_list),len(coef)-paramater_len))
    fcn1_weight_base = fcn1_bias_base + len(fcn1_bias_gather)
    dut._log.info('fcn1_bias_base : {} \nfcn1_weight_base : {} \n'.format(fcn1_bias_base,fcn1_weight_base))    
    #+++++ fcn2 coef cache loading 
    fcn2_bias_base = paramater_len
    fcn2_matW_trans = params.fcn2_matW.transpose()  
    fcn2_matW_gather = gather_array_element(fcn2_matW_trans, THREAD, n_bits = 8, signed = True)
    fcn2_bias_expanded = np.pad(params.fcn2_bias, (0, 1), mode='constant', constant_values=0)
    fcn2_bias_gather = gather_array_element(fcn2_bias_expanded, int(THREAD/2), n_bits = 16, signed = True)
    fcn2_param_list = fcn2_bias_gather + fcn2_matW_gather
    coef[paramater_len:paramater_len+len(fcn2_param_list)] = fcn2_param_list
    paramater_len += len(fcn2_param_list)
    dut._log.info('loading fcn2 coef done ,use word: {} ,Remaining word : {} '.format(len(fcn2_param_list),len(coef)-paramater_len))
    fcn2_weight_base = fcn2_bias_base + len(fcn2_bias_gather)
    dut._log.info('fcn2_bias_base : {} \nfcn2_weight_base : {} \n'.format(fcn2_bias_base,fcn2_weight_base))    
    dut._log.info('area 0 use total word : {} \n'.format(paramater_len))    
    #+++++ area 1 if map coef cache loading     
    # paramater_len = 0
    if1_bias_base = paramater_len
    if1_weight_I_base = if1_bias_base+ len(if_bias_gather)
    if1_weight_H_base = if1_weight_I_base + len(if_matW_I_gather)
    coef[paramater_len:paramater_len+len(if_param_list)] = if_param_list
    paramater_len += len(if_param_list)
    dut._log.info('loading area1 if map coef done ,use word: {} ,Remaining word : {} '.format(len(if_param_list),len(coef)-paramater_len))
    dut._log.info('if1_bias_base : {} \nif1_weight_I_base : {} \nif1_weight_H_base : {} \n'.format(if1_bias_base,if1_weight_I_base,if1_weight_H_base))
    #+++++ area1 hidden coef cache loading 
    hi1_bias_base = paramater_len
    hi1_weight_I_base = hi1_bias_base + len(hi_bias_gather)
    hi1_weight_H_base = hi1_weight_I_base + len(hi_matW_I_gather)
    coef[paramater_len:paramater_len+len(hi_param_list)] = hi_param_list
    paramater_len += len(hi_param_list)
    dut._log.info('loading area1 hidden coef done ,use word: {} ,Remaining word : {} '.format(len(hi_param_list),len(coef)-paramater_len))
    dut._log.info('hi1_bias_base : {} \nhi1_weight_I_base : {} \nhi1_weight_H_base : {} \n'.format(hi1_bias_base,hi1_weight_I_base,hi1_weight_H_base))
    #+++++ area1 fc up down coef cache loading 
    fc1_bias_base = paramater_len
    fc1_weight_base = fc1_bias_base + len(fc_bias_gather)
    coef[paramater_len:paramater_len+len(fc_param_list)] = fc_param_list
    paramater_len += len(fc_param_list)
    dut._log.info('loading area1 fc up down coef done ,use word: {} ,Remaining word : {} '.format(len(fc_param_list),len(coef)-paramater_len))
    dut._log.info('fc_bias_base : {} \nfc_weight_base : {} \n'.format(fc1_bias_base,fc1_weight_base))    
    #+++++ area1 gateW coef cache loading 
    gateW1_bias_base = paramater_len
    gateW1_weight_base = gateW1_bias_base + len(gateW_bias_gather)
    coef[paramater_len:paramater_len+len(gateW_param_list)] = gateW_param_list
    paramater_len += len(gateW_param_list)
    dut._log.info('loading area1 gateW coef done ,use word: {} ,Remaining word : {} '.format(len(gateW_param_list),len(coef)-paramater_len))
    dut._log.info('gateW1_bias_base : {} \n gateW1_weight_base : {} \n'.format(gateW1_bias_base,gateW1_weight_base))    
    #+++++ area1 fcn1 coef cache loading 
    fcn11_bias_base = paramater_len
    fcn11_weight_base = fcn11_bias_base + len(fcn1_bias_gather)
    coef[paramater_len:paramater_len+len(fcn1_param_list)] = fcn1_param_list
    paramater_len += len(fcn1_param_list)
    dut._log.info('loading area1 fcn1 coef done ,use word: {} ,Remaining word : {} '.format(len(fcn1_param_list),len(coef)-paramater_len))
    dut._log.info('fcn11_bias_base : {} \nfcn11_weight_base : {} \n'.format(fcn11_bias_base,fcn11_weight_base))    
    #+++++ area1 fcn2 coef cache loading 
    fcn21_bias_base = paramater_len
    fcn21_weight_base = fcn21_bias_base + len(fcn2_bias_gather)
    coef[paramater_len:paramater_len+len(fcn2_param_list)] = fcn2_param_list
    paramater_len += len(fcn2_param_list)
    dut._log.info('loading area1 fcn2 coef done ,use word: {} ,Remaining word : {} '.format(len(fcn2_param_list),len(coef)-paramater_len))
    dut._log.info('fcn21_bias_base : {} \nfcn21_weight_base : {} \n'.format(fcn21_bias_base,fcn21_weight_base))    
    #+++++ area 2 if map coef cache loading     
    if2_bias_base = paramater_len
    if2_weight_I_base = if2_bias_base+ len(if_bias_gather)
    if2_weight_H_base = if2_weight_I_base + len(if_matW_I_gather)
    coef[paramater_len:paramater_len+len(if_param_list)] = if_param_list
    paramater_len += len(if_param_list)
    dut._log.info('loading area2 if map coef done ,use word: {} ,Remaining word : {} '.format(len(if_param_list),len(coef)-paramater_len))
    dut._log.info('if2_bias_base : {} \nif2_weight_I_base : {} \nif2_weight_H_base : {} \n'.format(if2_bias_base,if2_weight_I_base,if2_weight_H_base))
    #+++++ area2 hidden coef cache loading 
    hi2_bias_base = paramater_len
    hi2_weight_I_base = hi2_bias_base + len(hi_bias_gather)
    hi2_weight_H_base = hi2_weight_I_base + len(hi_matW_I_gather)
    coef[paramater_len:paramater_len+len(hi_param_list)] = hi_param_list
    paramater_len += len(hi_param_list)
    dut._log.info('loading area2 hidden coef done ,use word: {} ,Remaining word : {} '.format(len(hi_param_list),len(coef)-paramater_len))
    dut._log.info('hi2_bias_base : {} \nhi2_weight_I_base : {} \nhi2_weight_H_base : {} \n'.format(hi2_bias_base,hi2_weight_I_base,hi2_weight_H_base))
    #+++++ area2 fc up down coef cache loading 
    fc2_bias_base = paramater_len
    fc2_weight_base = fc2_bias_base + len(fc_bias_gather)
    coef[paramater_len:paramater_len+len(fc_param_list)] = fc_param_list
    paramater_len += len(fc_param_list)
    dut._log.info('loading area2 fc up down coef done ,use word: {} ,Remaining word : {} '.format(len(fc_param_list),len(coef)-paramater_len))
    dut._log.info('fc2_bias_base : {} \n fc2_weight_base : {} \n'.format(fc2_bias_base,fc2_weight_base))    
    #+++++ area2 gateW coef cache loading 
    gateW2_bias_base = paramater_len
    gateW2_weight_base = gateW2_bias_base + len(gateW_bias_gather)
    coef[paramater_len:paramater_len+len(gateW_param_list)] = gateW_param_list
    paramater_len += len(gateW_param_list)
    dut._log.info('loading area2 gateW coef done ,use word: {} ,Remaining word : {} '.format(len(gateW_param_list),len(coef)-paramater_len))
    dut._log.info('gateW2_bias_base : {} \n gateW2_weight_base : {} \n'.format(gateW2_bias_base,gateW2_weight_base))    
    #+++++ area2 fcn1 coef cache loading 
    fcn12_bias_base = paramater_len
    fcn12_weight_base = fcn12_bias_base + len(fcn1_bias_gather)
    coef[paramater_len:paramater_len+len(fcn1_param_list)] = fcn1_param_list
    paramater_len += len(fcn1_param_list)
    dut._log.info('loading area2 fcn1 coef done ,use word: {} ,Remaining word : {} '.format(len(fcn1_param_list),len(coef)-paramater_len))
    dut._log.info('fcn12_bias_base : {} \n fcn12_weight_base : {} \n'.format(fcn12_bias_base,fcn12_weight_base))    
    #+++++ area2 fcn2 coef cache loading 
    fcn22_bias_base = paramater_len
    fcn22_weight_base = fcn22_bias_base + len(fcn2_bias_gather)
    coef[paramater_len:paramater_len+len(fcn2_param_list)] = fcn2_param_list
    paramater_len += len(fcn2_param_list)
    dut._log.info('loading area2 fcn2 coef done ,use word: {} ,Remaining word : {} '.format(len(fcn2_param_list),len(coef)-paramater_len))
    dut._log.info('fcn22_bias_base : {} \n fcn22_weight_base : {} \n'.format(fcn22_bias_base,fcn22_weight_base))    
    return {'if_bias_base': if_bias_base, 
            'if_weight_I_base': if_weight_I_base, 
            'if_weight_H_base': if_weight_H_base ,
            'hi_bias_base': hi_bias_base ,
            'hi_weight_I_base' : hi_weight_I_base,
            'hi_weight_H_base' : hi_weight_H_base,
            'fc_bias_base' : fc_bias_base,
            'fc_weight_base' : fc_weight_base,
            'gateW_bias_base' : gateW_bias_base,
            'gateW_weight_base' : gateW_weight_base,
            'fcn1_bias_base' : fcn1_bias_base,
            'fcn1_weight_base' : fcn1_weight_base,
            'fcn2_bias_base': fcn2_bias_base,
            'fcn2_weight_base' : fcn2_weight_base
            }

CLK_80M_period = 12.5
CLK_20M_period = 50
CLK_5M_period = 200

@cocotb.test()
async def tb(dut):    
    # "Clock" is a built in class for toggling a clock signal
    cocotb.start_soon(Clock(dut.clk, CLK_20M_period, units='ns').start())
    cocotb.start_soon(Clock(dut.clk_80m, CLK_80M_period, units='ns').start())
    cocotb.start_soon(Clock(dut.clk_sys, CLK_5M_period, units='ns').start())
    await cocotb.start(reset_dut(dut.resetn, CLK_20M_period * 2))
    await cocotb.start(reset_dut(dut.rstn_80m, CLK_80M_period * 2))
    await cocotb.start(reset_dut(dut.rstn_sys, CLK_5M_period * 2))
    # 提供种子，确保随机数可重现
    np.random.seed(2023)
    # 生成包含 33120 个随机整数的
    # 数组，每个整数在 0 到 4095 之间
    raw_data = np.random.randint(0, 2**12 -1, size=66240)
    #================ test config data ================# 
    AEAR_NUM = 3
    ADC_IN_MODE = 0
    SAMP_SIZE = 4*9
    AMP_DATA_RATO = 0 
    DATA_RATO = 32
    DATA_RATO_LOG2 = int(np.log2(DATA_RATO))
    # amp_ratio_log2 = 7
    INPUT_SIZE = 64
    HIDDEN_SIZE = 16
    OUTPUT_SIZE = 3
    CACHE_SIZE = 120
    COEF_CACHE_SIZE = 896
    THREAD = 8
    OUTPUT_CACHE_BASE = int((INPUT_SIZE*8)/64)
    # DOWNSAMP_ROW_ONEHOT = 0b111111111
    # AMP_SMP_NUM = 12
    DOWNSAMP_ROW_ONEHOT = 0b001001001
    AMP_SMP_NUM = 4
    dut._log.info('=================== instantial coef & cache model =================')
    cache = array2mem(np.zeros([int(CACHE_SIZE)], dtype=np.int64))
    coef = array2mem(np.zeros([int(COEF_CACHE_SIZE)], dtype=np.int32))
    dut._log.info('create coef cache model ,cache word space: {} '.format(len(coef)))
    dut._log.info('create cache model ,cache word space: {} '.format(len(cache)))
    dut._log.info('=================== generate random coef params =================')
    params = NeuralNetworkParams(input_size=INPUT_SIZE,hidden_size=HIDDEN_SIZE, output_size=OUTPUT_SIZE)
    dut._log.info('=================== generate amp golden data =================')
    pre_ref_data = pre_proc_ref_data(raw_data=raw_data,
                                     downsamp_row_onehot=DOWNSAMP_ROW_ONEHOT,
                                     amp_smp_num=AMP_SMP_NUM,
                                     area_num=AEAR_NUM,
                                     samp_size=SAMP_SIZE,
                                     input_size=INPUT_SIZE,
                                     data_rato=DATA_RATO) 
    print(f'pre_ref_data amp : {pre_ref_data.amp[0,0,:]}')
    print(f'pre_ref_data amp : {pre_ref_data.amp[0,1,:]}')
    print(f'pre_ref_data amp : {pre_ref_data.amp[0,2,:]}')
    print(f'pre_ref_data amp_mean : {pre_ref_data.amp_mean[0:64,0]}')
    # print(f'pre_ref_data amp_mean : {np.min(pre_ref_data.amp_mean[4:64+4,0])}')
    # print(f'pre_ref_data ptp : {pre_ref_data.amp_mean_ptp[4,0]}')
    print(f'pre_ref_data ptp power of 2 : {pre_ref_data.amp_mean_ptp_power_of_2[0,0]}')
    print(f'pre_ref_data ptp power of 2 : {pre_ref_data.norm[0,0,:]}')
    dut._log.info('=================== loading NN coef data =================')
    coef_base = coef_cache_loader(dut=dut,coef=coef,params=params,THREAD=THREAD)
    dut._log.info('=================== initial dut =================')
    dut.scan_mode.value = 0
    dut.rg_fdt_init_seq.value = 0
    dut.rg_fdt_en.value = 1
    dut.fdt_sampling.value = 0
    dut.rg_fdt_detect_mode.value = 1
    dut.rg_label_seq_en.value = 1
    dut.rg_label_seq_length.value = 5
    dut.rg_fdt_wait_up.value = 1
    dut.rg_fdt_wait_down.value = 1
    dut.rg_fdt_wait_heavy.value = 1
    dut.rg_fdt_auto_exit_en.value = 1
    dut.rg_fdt_heavy_auto_exit_en.value = 1
    
    # dut.rg_fdt_area_en_one_hot.value = 1
    # dut.rg_fdt_area_en_one_hot.value = 2
    # dut.rg_fdt_area_en_one_hot.value = 3
    # dut.rg_fdt_area_en_one_hot.value = 4
    # dut.rg_fdt_area_en_one_hot.value = 5
    # dut.rg_fdt_area_en_one_hot.value = 6
    dut.rg_fdt_area_en_one_hot.value = 7
    dut.fdt_adc_in_mode.value = ADC_IN_MODE
    dut.fdt_therm_comp_one_hot.value = 16
    dut.rg_amp_downsamp_row_onehot.value = DOWNSAMP_ROW_ONEHOT #
    dut.rg_amp_therm_comp_amp_ratio_0.value = 2
    dut.rg_amp_data_ratio.value = AMP_DATA_RATO
    dut.rg_amp_sample_num.value = AMP_SMP_NUM
    dut.rg_norm_mean_pad_smp_num_log2.value = 0
    # dut.rg_norm_mean_pad_smp_num_log2.value = 4
    dut.rg_norm_mean_num_log2.value = 6
    dut.rg_norm_mean_base_addr.value = 72
    dut.rg_nn_input_base_addr.value = 0
    dut.rg_nn_data_ratio.value = DATA_RATO_LOG2
    dut.rg_nn_layer_num.value = 1
    dut.rg_nn_label_num.value = 2
    dut.rg_nn_ifmap_groupnum.value = int(INPUT_SIZE/THREAD)-1
    dut.rg_nn_hidden_groupnum_layer_0.value = int(HIDDEN_SIZE/THREAD)-1
    dut.rg_nn_hidden_groupnum_layer_1.value = int(HIDDEN_SIZE/THREAD)-1
    dut.rg_nn_cache_ofmap_base_addr.value = OUTPUT_CACHE_BASE
    dut.rg_nn_bias_addr_layer_0.value = coef_base['if_bias_base']
    dut.rg_nn_whi_addr_layer_0.value = coef_base['if_weight_I_base']
    dut.rg_nn_whh_addr_layer_0.value = coef_base['if_weight_H_base']
    dut.rg_nn_bias_addr_layer_1.value = coef_base['hi_bias_base']
    dut.rg_nn_whi_addr_layer_1.value = coef_base['hi_weight_I_base']
    dut.rg_nn_whh_addr_layer_1.value = coef_base['hi_weight_H_base']
    dut.rg_nn_fc_bias_addr.value = coef_base['fc_bias_base']
    dut.rg_nn_fc_weight_addr.value = coef_base['fc_weight_base']
    dut.rg_nn_gate_w_bias_addr.value = coef_base['gateW_bias_base']
    dut.rg_nn_gate_w_weight_addr.value = coef_base['gateW_weight_base']
    dut.rg_nn_fcn1_bias_addr.value = coef_base['fcn1_bias_base']
    dut.rg_nn_fcn1_weight_addr.value = coef_base['fcn1_weight_base']
    dut.rg_nn_fcn2_bias_addr.value = coef_base['fcn2_bias_base']
    dut.rg_nn_fcn2_weight_addr.value = coef_base['fcn2_weight_base']
    dut._log.info('=================== driving start =================')
    cocotb.start_soon(driver(dut=dut, raw_data=raw_data))
    cocotb.start_soon(Dualclk_spram_driver(dut, "cache_ram", cache, dut.cache_ena, dut.cache_wena, dut.cache_addr, dut.cache_wdata,dut.cache_rdata, is_classic=True))
    cocotb.start_soon(spram_driver(dut, "coef_ram", coef, dut.coef_ena, dut.coef_wena, dut.coef_addr, dut.coef_wdata,dut.coef_rdata, is_classic=True))
    
    # Monitors
    cocotb.start_soon(amp_monitor(dut, pre_ref_data.amp))
    cocotb.start_soon(amp_mean_monitor(dut,pre_ref_data.amp_mean))
    cocotb.start_soon(norm_monitor(dut,pre_ref_data.norm))
    cocotb.start_soon(rnn_monitor(dut,cache,params,INPUT_SIZE,HIDDEN_SIZE,OUTPUT_SIZE,THREAD,DATA_RATO,OUTPUT_CACHE_BASE))
    
    await Timer(100000, units="ns")
    
    await RisingEdge(dut.clk_sys)
    dut.rg_fdt_init_seq.value = 1
    await RisingEdge(dut.clk_sys)
    dut.rg_fdt_init_seq.value = 0
    
    await FallingEdge(dut.norm_unit.norm_done_20M)
    dut._log.info('=================== pre_proc_done =================')
    # await FallingEdge(dut.norm_unit.norm_done_20M)
    # await RisingEdge(dut.clk)
    # await RisingEdge(dut.clk)
    await Timer(1000000, units="ns")
    # await Timer(5000000, units="ns")

if __name__ == '__main__':
    print('test')
import random
import math
import cocotb
import numpy as np
import sys
import csv
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge, Timer, Edge
sys.path.append("/home/lyc/projects/Easonlib//src/main/scala/EasonLib/CocoSim/templates/")
# this is selfdegine package
from common_drivers import *
from Binary import *

CLK_NS = 16

async def reset_dut(reset_n, duration_ns):
    reset_n.value = 0
    await Timer(duration_ns, units="ns")
    reset_n.value = 1
    reset_n._log.info("Reset complete.")


async def driver(dut, raw_data):
    cnt = 0
    await RisingEdge(dut.rstn_80m)
    await RisingEdge(dut.clk_80m)
    
    for jj in range(32):
        dut.fdt_sampling.value = 1
        for ii in range(4):
            for x in range(300): #400
                await RisingEdge(dut.clk_80m)
            for i in range(4):
                for j in range(8):
                    for x in range(31):
                        await RisingEdge(dut.clk_80m)
                    dut.fdt_adc_in_vld.value = 1
                    dut.fdt_adc_in.value = int(raw_data[cnt])
                    cnt += 1
                    await RisingEdge(dut.clk_80m)
                    dut.fdt_adc_in_vld.value = 0
                for x in range(120):
                    await RisingEdge(dut.clk_80m)
        dut.fdt_sampling.value = 0
        for x in range(10000):
            await RisingEdge(dut.clk_80m)

def smpQ_sel(num, dut):
    match num:
        case 0:
            return dut.post_process_unit.smpArrayQ_0.value
        case 1:
            return dut.post_process_unit.smpArrayQ_1.value
        case 2:
            return dut.post_process_unit.smpArrayQ_2.value
        case 3:
            return dut.post_process_unit.smpArrayQ_3.value
        case 4:
            return dut.post_process_unit.smpArrayQ_4.value
        case 5:
            return dut.post_process_unit.smpArrayQ_5.value
        case 6:
            return dut.post_process_unit.smpArrayQ_6.value
        case 7:
            return dut.post_process_unit.smpArrayQ_7.value
        case 8:
            return dut.post_process_unit.smpArrayQ_8.value
        case 9:
            return dut.post_process_unit.smpArrayQ_9.value
        case 10:
            return dut.post_process_unit.smpArrayQ_10.value
        case 11:
            return dut.post_process_unit.smpArrayQ_11.value
        case 12:
            return dut.post_process_unit.smpArrayQ_12.value
        case 13:
            return dut.post_process_unit.smpArrayQ_13.value
        case 14:
            return dut.post_process_unit.smpArrayQ_14.value
        case 15:
            return dut.post_process_unit.smpArrayQ_15.value
        case _:
            return 0
def smpI_sel(num, dut):
    match num:
        case 0:
            return dut.post_process_unit.smpArrayI_0.value
        case 1:
            return dut.post_process_unit.smpArrayI_1.value
        case 2:
            return dut.post_process_unit.smpArrayI_2.value
        case 3:
            return dut.post_process_unit.smpArrayI_3.value
        case 4:
            return dut.post_process_unit.smpArrayI_4.value
        case 5:
            return dut.post_process_unit.smpArrayI_5.value
        case 6:
            return dut.post_process_unit.smpArrayI_6.value
        case 7:
            return dut.post_process_unit.smpArrayI_7.value
        case 8:
            return dut.post_process_unit.smpArrayI_8.value
        case 9:
            return dut.post_process_unit.smpArrayI_9.value
        case 10:
            return dut.post_process_unit.smpArrayI_10.value
        case 11:
            return dut.post_process_unit.smpArrayI_11.value
        case 12:
            return dut.post_process_unit.smpArrayI_12.value
        case 13:
            return dut.post_process_unit.smpArrayI_13.value
        case 14:
            return dut.post_process_unit.smpArrayI_14.value
        case 15:
            return dut.post_process_unit.smpArrayI_15.value
        case _:
            return 0
        
async def amp_monitor(dut, ref_result, sampnum):
    amp_cnt = 0
    while (1):  
        await FallingEdge(dut.post_process_unit.sqrt_dout_vld)
        await RisingEdge(dut.clk_80m)
        dut_result_num = smpQ_sel(amp_cnt%sampnum, dut).integer
        ref_result_num = ref_result[amp_cnt]

        if not dut_result_num == ref_result_num:
            print(f"dut result: {dut_result_num}")
            print(f"ref result: {ref_result_num}")
            raise("!")
        amp_cnt += 1

async def norm_monitor(dut, ref_result, max_minus_min, sum, sampnum):
    norm_cnt = 0
    seq_cnt = 0
    binary_func = Binary(n_bits=8)
    while (1):  
        await FallingEdge(dut.post_process_unit.amp_cal_end)
        await RisingEdge(dut.clk_80m)
        dut_max_min = dut.post_process_unit.max_minux_min.value.integer
        ref_max_min = max_minus_min[seq_cnt]
        dut_sum = dut.post_process_unit.mean_buffer.value.integer
        ref_sum = sum[seq_cnt]
        if not dut_max_min == ref_max_min:
            print(f"dut max-min result: {dut_max_min}")
            print(f"ref max-min result: {ref_max_min}")
            raise("!")
        if not dut_sum == ref_sum:
            print(f"dut sum result: {dut_sum}")
            print(f"ref sum result: {ref_sum}")
            raise("!")
        await FallingEdge(dut.post_process_unit.norm_cal_end_pulse)
        for i in range(sampnum):
            dut_result_num = smpI_sel(norm_cnt%sampnum, dut).integer
            dut_result_num = binary_func.signed_trunc(dut_result_num)
            ref_result_num = ref_result[norm_cnt]

            if not dut_result_num == ref_result_num:
                print(f"dut result: {dut_result_num}")
                print(f"ref result: {ref_result_num}")
                raise("!")
            norm_cnt += 1
        seq_cnt += 1

async def single_step_en_drive(dut, single_step_mode, single_step_start_index, single_step_end_index):
    inf_cnt = 0
    while (1):  
        if single_step_mode:
            await FallingEdge(dut.rnn.start_once)
            if inf_cnt >= single_step_start_index-1 and inf_cnt < single_step_end_index-1:
                dut.rg_rnn_single_step_mode.value = 1
            else:
                dut.rg_rnn_single_step_mode.value = 0
        else:
            dut.rg_rnn_single_step_mode.value = 0

        await FallingEdge(dut.fdt_once_done)
        inf_cnt += 1

async def rnn_monitor(dut, cache_mem, norm, m_weight_ih_l0, m_weight_hh_l0, m_weight_ih_l1, m_weight_hh_l1, m_bias_l0, m_bias_l1,
                      debug_hh_l0, debug_hh_l1, m_h_output, m_output, m_label_out,
                      thread, seq_num, layer_num, layer_hidden_num, label_num,
                      ifmap_cache_base, ifmap_line_num, rg_ifmap_cache_base_th):
    inf_cnt = 0
    seq_cnt = 0
    layer_cnt = 0
    while (1):  
        await FallingEdge(dut.rnn.start_once)
        seq_cnt = 0
        for i in range(seq_num):
            layer_cnt = 0
            ofmap_cache_start = rg_ifmap_cache_base_th
            for j in range(layer_num):
                await FallingEdge(dut.rnn.matmul_start_once)

                if dut.rnn.layerCnt.value.integer  == 0 and dut.rnn.curr_state.value.integer == 2:  # is MatmulI
                    # if ifmap_cache_base + seq_cnt*ifmap_line_num >= rg_ifmap_cache_base_th:
                    #     ifmap_cache_base_addr = ifmap_cache_base + seq_cnt*ifmap_line_num - rg_ifmap_cache_base_th
                    # else:
                    #     ifmap_cache_base_addr = ifmap_cache_base + seq_cnt*ifmap_line_num
                    ifmap_cache_base_addr = dut.read_ifmap_base_pointer.value.integer
                    ifmap_content = cache_mem[ifmap_cache_base_addr : ifmap_cache_base_addr + ifmap_line_num]
                    dut_ifmap_array = split_mem_element(ifmap_content, thread, n_bits = 8, signed = True)
                    ref_ifmap_array = norm[inf_cnt + seq_cnt, :].tolist()

                    if not dut_ifmap_array == ref_ifmap_array:
                        print(f"dut ifmap_array result: {dut_ifmap_array}")
                        print(f"ref ifmap_array result: {ref_ifmap_array}")
                        raise("!")
                    
                if not seq_cnt == 0:
                    await FallingEdge(dut.rnn.matmul_done_once)
                    if(layer_cnt == 0):
                        ref_ofmap_array = debug_hh_l0[inf_cnt,seq_cnt,:].tolist()
                    elif layer_cnt == 1 :
                        ref_ofmap_array = debug_hh_l1[inf_cnt,seq_cnt,:].tolist()  
                    dut_ofmap_array = cache_mem[ofmap_cache_start+int(layer_hidden_num[j]/thread):
                                                ofmap_cache_start+int(layer_hidden_num[j]/thread) + int(layer_hidden_num[j] / (thread/2))]
                    dut_ofmap_array = split_mem_element(dut_ofmap_array, int(thread/2), n_bits = 8*2, signed = True) 
                    print(inf_cnt,seq_cnt,layer_cnt)  
                    print(f"Matmul <H> dut ofmap_array result: {dut_ofmap_array}")
                    print(f"Matmul <H> ref ofmap_array result: {ref_ofmap_array}")                
                    if not dut_ofmap_array == ref_ofmap_array:
                        print(f"Matmul <H> dut ofmap_array result: {dut_ofmap_array}")
                        print(f"Matmul <H> ref ofmap_array result: {ref_ofmap_array}")
                        raise("!")
                    await FallingEdge(dut.rnn.matmul_start_once)

                await FallingEdge(dut.rnn.stateout_matmulI)
                # check matmul output

                if(layer_cnt == 0):
                    ref_ofmap_array_MI = m_h_output[inf_cnt,seq_cnt,:].tolist()
                elif layer_cnt == 1 :
                    ref_ofmap_array_MI = m_output[inf_cnt,seq_cnt,:].tolist()    
                print(cache_mem)
                dut_ofmap_array_MI = cache_mem[ofmap_cache_start:ofmap_cache_start+ int(layer_hidden_num[j] / thread)]
                dut_ofmap_array_MI = split_mem_element(dut_ofmap_array_MI, thread, n_bits = 8, signed = True) 

                print(f"Matmul <I> dut ofmap_array result: {dut_ofmap_array_MI}")
                print(f"Matmul <I> ref ofmap_array result: {ref_ofmap_array_MI}")      
                print(norm[inf_cnt + seq_cnt, :].tolist())          
                if not dut_ofmap_array_MI == ref_ofmap_array_MI:
                    print(f"Matmul <I> dut ofmap_array result: {dut_ofmap_array_MI}")
                    print(f"Matmul <I> ref ofmap_array result: {ref_ofmap_array_MI}")

                    print(seq_cnt,layer_cnt)
                    print(ref_ifmap_array)
                    print(m_weight_ih_l0)
                    print(m_bias_l0*64)
                    print(ref_ofmap_array)
                    raise("!")
                    
                ofmap_cache_start += int(layer_hidden_num[j] / (thread) * 3) 
                layer_cnt += 1
            if seq_cnt == seq_num - 1:
                await FallingEdge(dut.rnn.matmul_start_once)
                await FallingEdge(dut.rnn.matmul_done_once)

                ref_ofmap_array = m_label_out[inf_cnt,:].tolist()  

                dut_ofmap_array = cache_mem[rg_ifmap_cache_base_th+int(layer_hidden_num[0]/thread):
                                            rg_ifmap_cache_base_th+int(layer_hidden_num[0]/thread) + int(np.ceil(label_num / (thread/2)))]
                dut_ofmap_array = split_mem_element(dut_ofmap_array, int(thread/2), n_bits = 8*2, signed = True)   
                print(f"Matmul <OUT> dut ofmap_array result: {dut_ofmap_array}")
                print(f"Matmul <OUT> ref ofmap_array result: {ref_ofmap_array}")                
                if not dut_ofmap_array == ref_ofmap_array:
                    print(f"Matmul <OUT> dut ofmap_array result: {dut_ofmap_array}")
                    print(f"Matmul <OUT> ref ofmap_array result: {ref_ofmap_array}")
                    raise("!")

            seq_cnt += 1
        inf_cnt += 1


@cocotb.test()
async def tb(dut):
    # "Clock" is a built in class for toggling a clock signal
    cocotb.start_soon(Clock(dut.clk, CLK_NS, units='ns').start())
    cocotb.start_soon(Clock(dut.clk_80m, int(CLK_NS/16), units='ns').start())

    # run reset_dut immediately before continuing
    await cocotb.start(reset_dut(dut.resetn, CLK_NS * 10))
    await cocotb.start(reset_dut(dut.rstn_80m, CLK_NS * 10))
    # 提供种子，确保随机数可重现
    np.random.seed(2023)
    # 生成包含 4096 个随机整数的数组，每个整数在 0 到 4095 之间
    raw_data = np.random.randint(0, 2**12 -1, size=4096)
    # work mode select
    single_step_mode = 1
    global_norm_mode = 0
    multi_seq_norm_mode = 1
    label_seq_en = 1
    label_seq_len = 7
    single_step_start_index = 3
    single_step_end_index = 5
    m_seq_num = 1
    m_label_size = 3
    m_hidden_size = 7

    Ovbits = 0
    COEF_SIZE = 104*32
    CACHE_SIZE = 104*32 #48*32
    DATAWD = 8
    m_layer_num = 2
    THREAD = 4
    HALF_THREAD = THREAD // 2

    samp_size = 4*8
    data_rato_log2 = 6
    amp_ratio_log2 = 7
    start_num = 0
    gap_num = 1
    ifmap_in_size = int(np.ceil((samp_size - start_num) / (gap_num + 1)))
    ifmap_in_size_log2 = int(np.log2(ifmap_in_size))
    # ifmap_in_size = 2**ifmap_in_size_log2
    ofmap_cache_start_base = int(m_seq_num * ifmap_in_size / THREAD)
    ifmap_group_num = int(np.ceil(ifmap_in_size / THREAD))
    hidden_group_num = int(np.ceil(m_hidden_size / THREAD))

    true_label_size = int(np.ceil(m_label_size/THREAD) * THREAD)
    true_hidden_size = hidden_group_num * THREAD
    m_weight_ih_l0 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_hidden_size,ifmap_in_size])
    m_weight_hh_l0 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_hidden_size,true_hidden_size])
    m_weight_ih_l1 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_hidden_size,true_hidden_size])
    m_weight_hh_l1 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_hidden_size,true_hidden_size])
    m_V = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_label_size,true_hidden_size])
    m_bias_l0_1 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_hidden_size]) 
    m_bias_l0_2 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_hidden_size]) 
    m_bias_l1_1 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_hidden_size]) 
    m_bias_l1_2 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_hidden_size]) 
    m_C_1 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_label_size])
    m_C_2 = np.random.randint(- 2**(DATAWD-1), 2**(DATAWD-1) -1, size=[true_label_size])

    # correct weight and bias with zero
    # label size correct
    label_size_remain = true_label_size - m_label_size
    for i in range(label_size_remain):
        m_V[true_label_size-1-i, :] = np.zeros(m_V[0].shape, dtype=np.int32)
        m_C_1[true_label_size-1-i] = int(0)
        m_C_2[true_label_size-1-i] = int(0)
    # hidden size correct
    hidden_size_remain = true_hidden_size - m_hidden_size
    for i in range(hidden_size_remain):
        m_weight_ih_l0[true_hidden_size-1-i, :] = np.zeros(m_weight_ih_l0[0,:].shape, dtype=np.int32)

        m_weight_hh_l0[: , true_hidden_size-1-i] = np.zeros(m_weight_hh_l0[:,0].shape, dtype=np.int32)
        m_weight_hh_l0[true_hidden_size-1-i, :] = np.zeros(m_weight_hh_l0[0,:].shape, dtype=np.int32)

        m_weight_ih_l1[: , true_hidden_size-1-i] = np.zeros(m_weight_ih_l1[:,0].shape, dtype=np.int32)
        m_weight_ih_l1[true_hidden_size-1-i, :] = np.zeros(m_weight_ih_l1[0,:].shape, dtype=np.int32)

        m_weight_hh_l1[: , true_hidden_size-1-i] = np.zeros(m_weight_hh_l1[:,0].shape, dtype=np.int32)
        m_weight_hh_l1[true_hidden_size-1-i, :] = np.zeros(m_weight_hh_l1[0,:].shape, dtype=np.int32)

        m_V[: , true_hidden_size-1-i] = np.zeros(m_V[:,0].shape, dtype=np.int32)

        m_bias_l0_1[true_hidden_size-1-i] = int(0)
        m_bias_l0_2[true_hidden_size-1-i] = int(0)
        m_bias_l1_1[true_hidden_size-1-i] = int(0)
        m_bias_l1_2[true_hidden_size-1-i] = int(0)

    m_bias_l0 = m_bias_l0_1 + m_bias_l0_2
    m_bias_l1 = m_bias_l1_1 + m_bias_l1_2
    m_C = m_C_1 + m_C_2

    def csv_write_coef(name,index, array):
        if len(array.shape) == 1:
            coef_array = np.reshape(array,[1,-1])
        else:
            coef_array = array
        row_num = coef_array.shape[0]
        col_num = coef_array.shape[1]

        title=[name,index,row_num, col_num]
        csv_writer.writerow(title)
        # 4. 写入csv文件内容
        for line in coef_array:
            csv_writer.writerow(line)

    with open("cmodel_coefs.csv", "w", encoding="utf-8", newline="") as f:
        # 2. 基于文件对象构建 csv写入对象
        csv_writer = csv.writer(f)
        # 3. 构建列表头
        all_coef_list = [
            ['weight_ih_l0', m_weight_ih_l0],
            ['weight_hh_l0', m_weight_hh_l0],
            ['bias_ih_l0', m_bias_l0_1],
            ['bias_hh_l0', m_bias_l0_2],
            ['weight_ih_l1', m_weight_ih_l1],
            ['weight_hh_l1', m_weight_hh_l1],
            ['bias_ih_l1', m_bias_l1_1], 
            ['bias_hh_l1', m_bias_l1_2], 
            ['V', m_V],
            ['C', m_C]
        ]
        for i, coef in enumerate(all_coef_list):
            csv_write_coef(coef[0],i+1,coef[1])
        print("写入数据成功")
        # 5. 关闭文件
        f.close()
    with open("comb_coefs.csv", "w", encoding="utf-8", newline="") as f:
        # 2. 基于文件对象构建 csv写入对象
        csv_writer = csv.writer(f)
        # 3. 构建列表头
        all_coef_list = [
            ['bias_ih_l0', m_bias_l0],
            ['weight_ih_l0', m_weight_ih_l0],
            ['weight_hh_l0', m_weight_hh_l0],
            ['bias_ih_l1', m_bias_l1], 
            ['weight_ih_l1', m_weight_ih_l1],
            ['weight_hh_l1', m_weight_hh_l1],
            ['C', m_C],
            ['V', m_V]
        ]
        for i, coef in enumerate(all_coef_list):
            csv_write_coef(coef[0],i+1,coef[1])
        print("写入数据成功")
        # 5. 关闭文件
        f.close()
    print(m_C)

    coef = array2mem(np.zeros([int(COEF_SIZE/32)], dtype=np.int32))
    cache = array2mem(np.zeros([int(CACHE_SIZE/32)], dtype=np.int32))

    m_weight_ih_l0_gather = gather_array_element(m_weight_ih_l0, THREAD, n_bits = 8, signed = True)
    m_weight_hh_l0_gather = gather_array_element(m_weight_hh_l0, THREAD, n_bits = 8, signed = True)
    m_weight_ih_l1_gather = gather_array_element(m_weight_ih_l1, THREAD, n_bits = 8, signed = True)
    m_weight_hh_l1_gather = gather_array_element(m_weight_hh_l1, THREAD, n_bits = 8, signed = True)
    m_V_gather = gather_array_element(m_V, THREAD, n_bits = 8, signed = True)

    m_bias_l0_gather = gather_array_element(m_bias_l0, int(THREAD/2), n_bits = 16, signed = True)
    m_bias_l1_gather = gather_array_element(m_bias_l1, int(THREAD/2), n_bits = 16, signed = True)
    m_C_gather = gather_array_element(m_C, int(THREAD/2), n_bits = 16, signed = True)

    param_list = m_bias_l0_gather + m_weight_ih_l0_gather + m_weight_hh_l0_gather
    param_list += m_bias_l1_gather + m_weight_ih_l1_gather + m_weight_hh_l1_gather
    param_list += m_C_gather + m_V_gather

    coef[:len(param_list)] = param_list
    print(f"*** COEF MEM Total line num = {len(param_list)}. ***")
    print(m_weight_ih_l0)
    print(m_weight_ih_l1)

    print(m_bias_l0)
    print(m_bias_l1)
    print(m_C)

    print(m_weight_hh_l0)
    print(m_weight_hh_l1)

    rg_rnn_bias_addr_layer_0 = 0
    rg_rnn_whi_addr_layer_0 = rg_rnn_bias_addr_layer_0 + int(true_hidden_size / HALF_THREAD)
    rg_rnn_whh_addr_layer_0 = rg_rnn_whi_addr_layer_0 + int(ifmap_group_num*THREAD * hidden_group_num*THREAD / THREAD)
    rg_rnn_bias_addr_layer_1 = 0
    rg_rnn_whi_addr_layer_1 = 0
    rg_rnn_whh_addr_layer_1 = 0
    rg_rnn_bias_addr_layer_2 = 0
    rg_rnn_whi_addr_layer_2 = 0
    rg_rnn_whh_addr_layer_2 = 0
    rg_rnn_bias_addr_layer_3 = 0
    rg_rnn_whi_addr_layer_3 = 0
    rg_rnn_whh_addr_layer_3 = 0

    if m_layer_num == 1:
        rg_rnn_fc_bias_addr = rg_rnn_whh_addr_layer_0 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_fc_weight_addr = rg_rnn_fc_bias_addr + int(true_label_size / HALF_THREAD)
    elif m_layer_num == 2:
        rg_rnn_bias_addr_layer_1 = rg_rnn_whh_addr_layer_0 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_whi_addr_layer_1 = rg_rnn_bias_addr_layer_1 + int(true_hidden_size / HALF_THREAD)
        rg_rnn_whh_addr_layer_1 = rg_rnn_whi_addr_layer_1 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)

        rg_rnn_fc_bias_addr = rg_rnn_whh_addr_layer_1 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_fc_weight_addr = rg_rnn_fc_bias_addr + int(true_label_size / HALF_THREAD)
    elif m_layer_num == 3:
        rg_rnn_bias_addr_layer_1 = rg_rnn_whh_addr_layer_0 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_whi_addr_layer_1 = rg_rnn_bias_addr_layer_1 + int(true_hidden_size / HALF_THREAD)
        rg_rnn_whh_addr_layer_1 = rg_rnn_whi_addr_layer_1 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)

        rg_rnn_bias_addr_layer_2 = rg_rnn_whh_addr_layer_1 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_whi_addr_layer_2 = rg_rnn_bias_addr_layer_2 + int(true_hidden_size / HALF_THREAD)
        rg_rnn_whh_addr_layer_2 = rg_rnn_whi_addr_layer_2 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)

        rg_rnn_fc_bias_addr = rg_rnn_whh_addr_layer_2 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_fc_weight_addr = rg_rnn_fc_bias_addr + int(true_label_size / HALF_THREAD)
    elif m_layer_num == 4:
        rg_rnn_bias_addr_layer_1 = rg_rnn_whh_addr_layer_0 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_whi_addr_layer_1 = rg_rnn_bias_addr_layer_1 + int(true_hidden_size / HALF_THREAD)
        rg_rnn_whh_addr_layer_1 = rg_rnn_whi_addr_layer_1 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)

        rg_rnn_bias_addr_layer_2 = rg_rnn_whh_addr_layer_1 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_whi_addr_layer_2 = rg_rnn_bias_addr_layer_2 + int(true_hidden_size / HALF_THREAD)
        rg_rnn_whh_addr_layer_2 = rg_rnn_whi_addr_layer_2 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)

        rg_rnn_bias_addr_layer_3 = rg_rnn_whh_addr_layer_2 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_whi_addr_layer_3 = rg_rnn_bias_addr_layer_3 + int(true_hidden_size / HALF_THREAD)
        rg_rnn_whh_addr_layer_3 = rg_rnn_whi_addr_layer_3 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)

        rg_rnn_fc_bias_addr = rg_rnn_whh_addr_layer_3 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
        rg_rnn_fc_weight_addr = rg_rnn_fc_bias_addr + int(true_label_size / HALF_THREAD)

    # Drivers
    
    dut.cache_rdata.value = 0
    dut.coef_rdata.value = 0
    dut.fdtmem_wr.value = 0
    dut.fdtmem_rd.value = 0
    dut.fdtmem_wdata.value = 0
    dut.fdtmem_addr.value = 0
    dut.scan_mode.value = 0
    dut.fdt_sampling.value = 0

    dut.rg_fdt_en.value = 1
    dut.rg_rnn_single_step_mode.value = single_step_mode
    dut.rg_rnn_single_step_init.value = 0
    dut.rg_fdt_label_seq_en.value = label_seq_en
    dut.rg_fdt_label_seq_length.value = label_seq_len

    dut.rg_amp_data_ratio.value = amp_ratio_log2
    dut.rg_amp_global_norm_mode.value = global_norm_mode
    dut.rg_amp_multi_seq_norm_mode.value = multi_seq_norm_mode

    dut.rg_amp_samp_start_num.value = start_num
    dut.rg_amp_samp_gap_num.value = gap_num
    dut.rg_amp_sample_num_log2.value = ifmap_in_size_log2

    dut.rg_rnn_whi_addr_layer_3.value = rg_rnn_whi_addr_layer_3
    dut.rg_rnn_whi_addr_layer_2.value = rg_rnn_whi_addr_layer_2
    dut.rg_rnn_whi_addr_layer_1.value = rg_rnn_whi_addr_layer_1 #56
    dut.rg_rnn_whi_addr_layer_0.value = rg_rnn_whi_addr_layer_0 #4

    dut.rg_rnn_whh_addr_layer_3.value = rg_rnn_whh_addr_layer_3
    dut.rg_rnn_whh_addr_layer_2.value = rg_rnn_whh_addr_layer_2
    dut.rg_rnn_whh_addr_layer_1.value = rg_rnn_whh_addr_layer_1 #72
    dut.rg_rnn_whh_addr_layer_0.value = rg_rnn_whh_addr_layer_0 #36

    dut.rg_rnn_hidden_groupnum_layer_3.value = hidden_group_num-1
    dut.rg_rnn_hidden_groupnum_layer_2.value = hidden_group_num-1
    dut.rg_rnn_hidden_groupnum_layer_1.value = hidden_group_num-1
    dut.rg_rnn_hidden_groupnum_layer_0.value = hidden_group_num-1
    dut.rg_rnn_bias_addr_layer_3.value = rg_rnn_bias_addr_layer_3
    dut.rg_rnn_bias_addr_layer_2.value = rg_rnn_bias_addr_layer_2
    dut.rg_rnn_bias_addr_layer_1.value = rg_rnn_bias_addr_layer_1 #52
    dut.rg_rnn_bias_addr_layer_0.value = rg_rnn_bias_addr_layer_0 #0

    dut.rg_rnn_fc_bias_addr.value = rg_rnn_fc_bias_addr #88
    dut.rg_rnn_fc_weight_addr.value = rg_rnn_fc_weight_addr #89

    dut.rg_rnn_ifmap_groupnum.value = ifmap_group_num-1

    dut.rg_rnn_data_ratio.value = data_rato_log2
    dut.rg_rnn_fc_label_num.value = m_label_size - 1
    dut.rg_rnn_seq_num.value = m_seq_num - 1
    dut.rg_cache_ofmap_base_addr.value = ofmap_cache_start_base

    dut.rg_rnn_layer_num.value = m_layer_num-1
    dut.fdt_adc_in.value = 0
    dut.fdt_adc_in_vld.value = 0

    raw_array = raw_data.reshape([-1,samp_size])
    frame_array = np.zeros(shape=[raw_array.shape[0],ifmap_in_size], dtype=int)
    frame_num = raw_array.shape[0]//4
    
    for i in range(raw_array.shape[0]):
        for j in range(ifmap_in_size):
            frame_array[i,j] = raw_array[i,start_num+j*(gap_num+1)]
    print(frame_num)
    arrayI = np.zeros(shape=[frame_num,ifmap_in_size], dtype=int)
    arrayQ = np.zeros(shape=[frame_num,ifmap_in_size], dtype=int)
    amp = np.zeros([frame_num,ifmap_in_size], dtype=int)
    for i in range(frame_num):
        arrayI[i,:] = frame_array[i*4,:] - frame_array[i*4+2,:]
        arrayQ[i,:] = frame_array[i*4+1,:] - frame_array[i*4+3,:]
        for j in range(ifmap_in_size):
            tmp = arrayI[i,j] * arrayI[i,j] + arrayQ[i,j] * arrayQ[i,j]
            amp[i,j] = (int(int(np.sqrt(tmp))/2) >> amp_ratio_log2) & 255
    # print(frame_array[:4,:])
    # print(arrayI[:1,:])
    # print(arrayQ[:1,:])
    # print(amp[:1,:])

    binary_func = Binary(n_bits=8)
    sum = np.sum(amp, axis=1) 
    max = np.max(amp, axis=1)
    min = np.min(amp, axis=1)
    max_minus_min = max - min
    norm = np.zeros([frame_num,ifmap_in_size], dtype=int)
    for i in range(frame_num):
        for j in range(ifmap_in_size):
            scale = max_minus_min[i]
            div_index = len(bin(scale)[2:])
            if not div_index == 0:
                div_index -= 1
            norm[i,j] = ((amp[i,j] - (sum[i] >> ifmap_in_size_log2)) *  2**data_rato_log2) >> div_index
            norm[i,j] = binary_func.signed_trunc(norm[i,j])

    def relu(x):
        if x > 0:
            return x
        else:
            return 0

    # print(f"max, min:{max}, {min}")
    # print(sum)
    # print(norm[:1,:])
    binary_func_16 = Binary(n_bits=16+Ovbits)
    inference_num = frame_num-(m_seq_num-1)
    m_h_prev = np.zeros([inference_num, m_seq_num, true_hidden_size], dtype=int)
    m_out_prev = np.zeros([inference_num, m_seq_num, true_hidden_size], dtype=int)
    m_h_output = np.zeros([inference_num, m_seq_num, true_hidden_size], dtype=int)
    m_output = np.zeros([inference_num, m_seq_num, true_hidden_size], dtype=int)
    m_label_out = np.zeros([inference_num, true_label_size], dtype=int)
    m_label_max = 0

    debug_hh_l0 = np.zeros([inference_num, m_seq_num, true_hidden_size], dtype=int)
    debug_hh_l1 = np.zeros([inference_num, m_seq_num, true_hidden_size], dtype=int)

    for inf_cnt in range(inference_num):
        for i in range(m_seq_num):
            # 第一层hidden
            for j in range(true_hidden_size):
                tmp = m_bias_l0[j] << data_rato_log2
                for k in range(true_hidden_size // THREAD):
                    if i == 0 and single_step_mode == 0:
                        tmp += 0
                    elif i == 0 and single_step_mode == 1 and (inf_cnt < single_step_start_index or inf_cnt >= single_step_end_index):
                        tmp += 0
                    elif i == 0 and single_step_mode == 1 and inf_cnt >= single_step_start_index:
                        product = 0
                        for tt in range(THREAD):
                            product += m_h_prev[inf_cnt-1, 0, k*THREAD+tt] * m_weight_hh_l0[j,k*THREAD+tt] # prev = i - 1 !
                            # product = binary_func_16.signed_trunc(product)  
                        tmp += product
                    else: 
                        product = 0
                        for tt in range(THREAD):
                            product += m_h_prev[inf_cnt, i-1, k*THREAD+tt] * m_weight_hh_l0[j,k*THREAD+tt] # prev = i - 1 !
                            # product = binary_func_16.signed_trunc(product)  
                        tmp += product
                        # tmp = binary_func_16.signed_trunc(tmp)  
                tmp = binary_func_16.signed_sat(tmp, 16)  


                debug_hh_l0[inf_cnt, i, j] = tmp  # add debug hh l0

                for k in range(ifmap_in_size // THREAD):
                    product = 0
                    for tt in range(THREAD):
                        product +=  norm[inf_cnt + i, k*THREAD+tt] * m_weight_ih_l0[j,k*THREAD+tt] # # slide
                        # product = binary_func_16.signed_trunc(product)  
                    if inf_cnt == 0:
                        if i == 8:
                            print("product"+str(product))
                            print("norm"+ str(norm[inf_cnt + i, k*THREAD:k*THREAD+4]))
                            print("m_weight_ih_l0"+ str(m_weight_ih_l0[j, k*THREAD:k*THREAD+4]))

                    tmp += product
                    # tmp = binary_func_16.signed_trunc(tmp)  
                tmp = binary_func_16.signed_sat(tmp, 16)  
                # if inf_cnt == 0:
                #     if i == 8:
                #         print("test"+str(tmp))

                tmp = tmp >> data_rato_log2
                # tmp += m_bias_l0[j] 


                if tmp > 127:
                    tmp = 127
                elif tmp < -128:
                    tmp = -128
                
                m_h_output[inf_cnt, i, j] = relu(tmp)
            
            m_h_prev[inf_cnt,i, :] = m_h_output[inf_cnt, i, :]
            # 第二层hidden
            for j in range(true_hidden_size):
                tmp = m_bias_l1[j] << data_rato_log2

                for k in range(true_hidden_size // THREAD):
                    if i == 0 and single_step_mode == 0:
                        tmp += 0
                    elif i == 0 and single_step_mode == 1 and (inf_cnt < single_step_start_index or inf_cnt >= single_step_end_index):
                        tmp += 0
                    elif i == 0 and single_step_mode == 1 and inf_cnt >= single_step_start_index:
                        product = 0
                        for tt in range(THREAD):
                            product += m_out_prev[inf_cnt-1, 0, k*THREAD+tt] * m_weight_hh_l1[j,k*THREAD+tt] # prev = i - 1 !
                            # product = binary_func_16.signed_trunc(product)  
                        tmp += product
                    else:
                        product = 0
                        for tt in range(THREAD):
                            product += m_out_prev[inf_cnt, i-1, k*THREAD+tt] * m_weight_hh_l1[j,k*THREAD+tt] # prev = i - 1 !
                            # product = binary_func_16.signed_trunc(product)  
                        tmp += product
                        # tmp = binary_func_16.signed_trunc(tmp)  
                tmp = binary_func_16.signed_sat(tmp, 16)  

                debug_hh_l1[inf_cnt, i, j] = tmp  # add debug hh l1

                for k in range(true_hidden_size //THREAD):
                    product = 0
                    for tt in range(THREAD):
                        product +=  m_h_output[inf_cnt , i, k*THREAD+tt] * m_weight_ih_l1[j,k*THREAD+tt] # # slide
                        # product = binary_func_16.signed_trunc(product)  
                    tmp += product
                    # tmp = binary_func_16.signed_trunc(tmp)  
                tmp = binary_func_16.signed_sat(tmp, 16)  

                tmp = tmp >> data_rato_log2
                # tmp += m_bias_l1[j]
                if tmp > 127:
                    tmp = 127
                elif tmp < -128:
                    tmp = -128

                m_output[inf_cnt, i, j] = relu(tmp)

            m_out_prev[inf_cnt,i, :] = m_output[inf_cnt, i, :]

        for j in range(true_label_size):
            tmp = m_C[j] << data_rato_log2
            for k in range(true_hidden_size // THREAD):
                product = 0
                for tt in range(THREAD):
                    product +=  m_output[inf_cnt, m_seq_num - 1, k*THREAD+tt] * m_V[j,k*THREAD+tt]
                    # product = binary_func_16.signed_trunc(product)  
                tmp += product
                # tmp = binary_func_16.signed_trunc(tmp) 

            tmp = binary_func_16.signed_sat(tmp, 16)  

            tmp = tmp >> data_rato_log2
            # tmp += m_C[j]
            m_label_out[inf_cnt, j] = tmp

            if j == 0:
                max_label_result = m_label_out[inf_cnt, 0]
                m_label_max = 0
            else:
                if m_label_out[inf_cnt, j] > max_label_result:
                    max_label_result = m_label_out[inf_cnt, j]
                    m_label_max = j

    # print(m_h_output[:1,:,:])
    # print(m_output[:1,:,:])

    # raise("!")
    print(m_h_prev[0,0,:])
    print(m_out_prev[0,0,:])
    print(debug_hh_l0[1,0,:])
    print(norm[1,:] )
    print(m_C)
    print(m_V)


    cocotb.start_soon(driver(dut=dut, raw_data=raw_data))

    # cocotb.start_soon(spram_driver(dut, "ram", ramblock, dut.mem_rd, dut.mem_wr, dut.mem_addr, dut.mem_wdata,dut.mem_rdata))

    cocotb.start_soon(spram_driver(dut, "coef_ram", coef, dut.coef_ena, dut.coef_wena, dut.coef_addr, dut.coef_wdata,dut.coef_rdata, is_classic=True))
    cocotb.start_soon(spram_driver(dut, "cache_ram", cache, dut.cache_ena, dut.cache_wena, dut.cache_addr, dut.cache_wdata,dut.cache_rdata, is_classic=True))
    # cocotb.start_soon(single_step_en_drive(dut, single_step_mode, single_step_start_index, single_step_end_index))

    # Monitors
    cocotb.start_soon(amp_monitor(dut, amp.flatten(), ifmap_in_size))
    # cocotb.start_soon(norm_monitor(dut, norm.flatten(), max_minus_min, sum, ifmap_in_size))
    # cocotb.start_soon(rnn_monitor(dut, cache, norm, m_weight_ih_l0, m_weight_hh_l0, m_weight_ih_l1, m_weight_hh_l1,m_bias_l0, m_bias_l1,
    #                   debug_hh_l0, debug_hh_l1, m_h_output, m_output, m_label_out,
    #                   thread = THREAD, seq_num = m_seq_num, layer_num = m_layer_num, layer_hidden_num = [true_hidden_size] * m_layer_num,
    #                   ifmap_cache_base = ofmap_cache_start_base, ifmap_line_num = int(ifmap_in_size / THREAD), label_num=true_label_size,
    #                     rg_ifmap_cache_base_th = ofmap_cache_start_base))

    await Timer(10, units="ns")
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)


    await Timer(300000, units="ns")


if __name__ == '__main__':
    print('test')
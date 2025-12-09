#!/usr/bin/python3
import numpy as np
import csv
#------- 只需修改这些参数 ---------------
# RNN结构参数
######################################
ifmap_in_size = 16  # 4,8,16
m_seq_num = 5       # 1-16
m_hidden_size = 8   # 1-8
m_label_size = 3    # 1-4
######################################
# AMP 相关参数
start_num = 0
gap_num = 1
######################################
#-------------------------------------

DATAWD = 8
THREAD = 4
HALF_THREAD = THREAD // 2

samp_size = 4*8
if not (ifmap_in_size == 16 or ifmap_in_size == 8 or ifmap_in_size == 4):
    raise("ERROR: ifmap_in_size should be 4,8 or 16 !")
if not (m_seq_num > 0 and m_seq_num <= 16):
    raise("ERROR: seq num should be in range 1-16!")
if not (m_hidden_size > 0 and m_hidden_size <= 8):
    raise("ERROR: m_hidden_size should be in range 1-8!")
if not (m_label_size > 0 and m_label_size <= 4):
    raise("ERROR: m_label_size should be in range 1-4!")
if not ifmap_in_size == int(np.ceil((samp_size - start_num) / (gap_num + 1))):
    raise("ERROR: Ifmap size is not match with start_num and gap_num ! ")

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
    print("写入cmodel所需coef数据成功")
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
    print("写入rtl所需coef数据成功")
    # 5. 关闭文件
    f.close()




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

    rg_rnn_bias_addr_layer_1 = rg_rnn_whh_addr_layer_0 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
    rg_rnn_whi_addr_layer_1 = rg_rnn_bias_addr_layer_1 + int(true_hidden_size / HALF_THREAD)
    rg_rnn_whh_addr_layer_1 = rg_rnn_whi_addr_layer_1 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)

    rg_rnn_fc_bias_addr = rg_rnn_whh_addr_layer_1 + int(hidden_group_num*THREAD * hidden_group_num*THREAD / THREAD)
    rg_rnn_fc_weight_addr = rg_rnn_fc_bias_addr + int(true_label_size / HALF_THREAD)

print("---------- AMP 结构参数 ----------")

print(f"rg_amp_samp_start_num = {start_num}")
print(f"rg_amp_samp_gap_num = {gap_num}")
print(f"rg_amp_sample_num_log2 = {ifmap_in_size_log2}")

print("---------- RNN 结构参数 ----------")
print(f"rg_rnn_seq_num = {m_seq_num - 1}")

print(f"rg_rnn_ifmap_groupnum = {ifmap_group_num-1}")

print(f"rg_rnn_hidden_groupnum_layer_0 = {hidden_group_num-1}")
print(f"rg_rnn_hidden_groupnum_layer_1 = {hidden_group_num-1}")
print(f"rg_cache_ofmap_base_addr = {ofmap_cache_start_base}")
print(f"rg_rnn_fc_label_num = {m_label_size - 1}")
print(f"rg_rnn_bias_addr_layer_0 = {rg_rnn_bias_addr_layer_0}")
print(f"rg_rnn_bias_addr_layer_1 = {rg_rnn_bias_addr_layer_1}")

print(f"rg_rnn_whi_addr_layer_0 = {rg_rnn_whi_addr_layer_0}")
print(f"rg_rnn_whi_addr_layer_1 = {rg_rnn_whi_addr_layer_1}")

print(f"rg_rnn_whh_addr_layer_0 = {rg_rnn_whh_addr_layer_0}")
print(f"rg_rnn_whh_addr_layer_1 = {rg_rnn_whh_addr_layer_1}")

print(f"rg_rnn_fc_bias_addr = {rg_rnn_fc_bias_addr}")
print(f"rg_rnn_fc_weight_addr = {rg_rnn_fc_weight_addr}")

with open("rnn_layer_regs.csv", "w", encoding="utf-8", newline="") as f:
    csv_writer = csv.writer(f)
        
    csv_writer.writerow(["rg_rnn_ifmap_groupnum", ifmap_group_num-1])
    csv_writer.writerow(["rg_rnn_hidden_groupnum_layer_0", hidden_group_num-1])
    csv_writer.writerow(["rg_rnn_hidden_groupnum_layer_1", hidden_group_num-1])
    csv_writer.writerow(["rg_cache_ofmap_base_addr", ofmap_cache_start_base])
    csv_writer.writerow(["rg_rnn_fc_label_num", m_label_size - 1])
    csv_writer.writerow(["rg_rnn_bias_addr_layer_0", rg_rnn_bias_addr_layer_0])
    csv_writer.writerow(["rg_rnn_bias_addr_layer_1", rg_rnn_bias_addr_layer_1])
    csv_writer.writerow(["rg_rnn_whi_addr_layer_0", rg_rnn_whi_addr_layer_0])
    csv_writer.writerow(["rg_rnn_whi_addr_layer_1", rg_rnn_whi_addr_layer_1])
    csv_writer.writerow(["rg_rnn_whh_addr_layer_0", rg_rnn_whh_addr_layer_0])
    csv_writer.writerow(["rg_rnn_whh_addr_layer_1", rg_rnn_whh_addr_layer_1])
    csv_writer.writerow(["rg_rnn_fc_bias_addr", rg_rnn_fc_bias_addr])
    csv_writer.writerow(["rg_rnn_fc_weight_addr", rg_rnn_fc_weight_addr])

    f.close()
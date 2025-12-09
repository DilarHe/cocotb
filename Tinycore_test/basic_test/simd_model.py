import re
import numpy as np
from utils import Uint2Sint, NpUint2Sint, load_bin2np, asm2bin, dec2bin_ext_clip


def cast_intn(x, n):
    if x >= 0:
        return x & ((1 << n)-1)
    else:
        absx = -x
        if absx > ((1 << (n-1))):  # overflow
            clip_value = x & ((1 << n)-1)
            bin_str = bin(clip_value)[2:]
            neg_str = '0b'
            if bin_str[0] == '1':  # after clip is negetive value
                for l in bin_str:
                    if l == '1':
                        neg_str += '0'
                    else:
                        neg_str += '1'
                true_value = -(int(neg_str, 2) + 1)

            else:
                true_value = clip_value

            raise('recheck!')
            return true_value
        else:
            return x


def Teconv_weight_reorder(weight):
    """
    Reorder the weight matrix to be in the same order as the input.
    For example:
    weight: [out_channels= 16, kernel_width = 3, in_channels= 32]
    output weight: [1,3,2,16,16]

    """
    out_channels, kernel_width, in_channels = weight.shape

    assert in_channels % 16 == 0, "inchannel should be 16*n!"
    assert out_channels % 16 == 0 or out_channels == 1, "outchannel should be 16*n!"
    if out_channels % 16 == 0:
        new_weight = np.zeros(
            [out_channels//16, kernel_width, in_channels//16, 16, 16], dtype=np.int32)
        for oc in range(out_channels//16):
            for kw in range(kernel_width):
                for ic in range(in_channels//16):
                    for oci in range(16):
                        for icj in range(16):
                            new_weight[oc, kw, ic, oci, icj] \
                                = weight[oc*16+oci, kw, ic*16+icj]
    elif out_channels == 1:
        new_weight = np.zeros(
            [1, kernel_width, in_channels//16, 16], dtype=np.int32)
        for kw in range(kernel_width):
            for ic in range(in_channels//16):
                for icj in range(16):
                    new_weight[0, kw, ic, icj] \
                            = weight[0, kw, ic*16+icj]

    return new_weight


def simd_mul_and_sum(array0, array1):
    mul_result = np.array(array0) * np.array(array1)
    sum_result = np.sum(mul_result)
    return sum_result


def simd_mul_sum_add_bias(array0, array1, bias):
    mul_result = np.array(array0) * np.array(array1)
    sum_result = np.sum(mul_result)
    sum_result += bias
    return sum_result


def conv_16x16x1(ifmap, weight, bias):
    '''
    ifmap:  [in_channel=16]
    weight: [out_channel=16, in_channel=16]
    bias:    [out_channel=16]
    '''
    ofmap = np.zeros((16), dtype=np.int32)
    for i in range(16):
        ofmap[i] = simd_mul_sum_add_bias(ifmap, weight[i, :], bias[i])
    return ofmap


def conv_16xWxC(ifmap, weight, bias):
    '''
    ifmap:  [width=n, in_channel=?]
    weight: [out_channel=16, width=n, in_channel=?]
    bias:    [out_channel=16]
    '''
    first = 1
    ofmap = np.zeros((16), dtype=np.int32)

    for w in range(ifmap.shape[0]):
        for ic in range(weight.shape[2]//16):

            if first:
                first = 0
                ofmap = conv_16x16x1(
                    ifmap[w, 16*ic:16*(ic+1)], weight[:, w, 16*ic:16*(ic+1)], bias)
            else:
                ofmap += conv_16x16x1(ifmap[w, 16*ic:16*(ic+1)], weight[:,
                                      w, 16*ic:16*(ic+1)], np.zeros([16], dtype=np.int32))
                
            # print("Inner Loop: width {}, inchannel {}, conv result: \n {}".format(w, ic, ofmap))
    return ofmap

def dwconv_16xn(ifmap, weight, bias):
    '''
    ifmap:  [width = n, in_channel=16]
    weight: [width = n, in/out_channel=16]
    bias:   [out_channel=16]
    '''
    ofmap = np.zeros((16), dtype=np.int32)
    mul_result = np.array(ifmap) * np.array(weight)
    ofmap = np.sum(mul_result,axis=0)
    ofmap += bias
    return ofmap

def bias_enlarge_dim(bias_buffer, dim):
    old_shape = bias_buffer.shape
    old_dim = old_shape[-1]
    new_shape = [x for x in old_shape[:-1]]
    new_shape.append(dim)
    split_num = int(dim/old_dim)
    bias_new = np.zeros(new_shape)
    for line in range(old_shape[0]):
        for i in range(old_dim):
            for j in range(split_num):
                raw_data = bias_buffer[line][i]
                bin_data = dec2bin_ext_clip(raw_data, 8*split_num)[8*j:8*(j+1)]
                bias_new[line, split_num*i+split_num -
                         1-j] = int('0b'+bin_data, 2)
    return bias_new


def load_bias(file_path):
    with open(file_path, 'r') as f:
        cont = f.readlines()
    bias = np.zeros([len(cont)], dtype=np.int32)
    for i in range(len(cont)):
        line = re.sub('\n', '', cont[i])
        bias[i] = int(line)
    return bias


def load_weight(file_path):
    with open(file_path, 'r') as f:
        cont = f.readlines()
    weight = np.zeros([len(cont)], dtype=np.int32)
    for i in range(len(cont)):
        line = re.sub('\n', '', cont[i])
        weight[i] = int(line)
    return weight

def load_act(file_path):
    with open(file_path, 'r') as f:
        cont = f.readlines()
    act = np.zeros([len(cont)], dtype=np.int32)
    for i in range(len(cont)):
        line = re.sub('\n', '', cont[i])
        act[i] = int(line)
    return act

def load_quant(file_path):
    with open(file_path, 'r') as f:
        cont = f.readlines()
    quant = np.zeros([3], dtype=np.int32)
    quant[0] = int(re.sub('\n', '', cont[0]))  # offset
    quant[1] = int(re.sub('\n', '', cont[1]))  # scale
    quant[2] = int(re.sub('\n', '', cont[2]))  # shift

    # shift = 31
    return quant

def load_skipadd(file_path):
    with open(file_path, 'r') as f:
        cont = f.readlines()
    offset1 = int(re.sub('\n', '', cont[0]))  # offset1
    scale1 = int(re.sub('\n', '', cont[1]))  # scale1
    offset2 = int(re.sub('\n', '', cont[2]))  # offset2
    scale2 = int(re.sub('\n', '', cont[3]))  # scale2
    offset = int(re.sub('\n', '', cont[4]))  # offset
    shift = int(re.sub('\n', '', cont[5]))  # shift

    # shift = 22
    return offset1, scale1, offset2, scale2, offset, shift

def load_softmax(file_path):
    with open(file_path, 'r') as f:
        cont = f.readlines()
    scale = int(re.sub('\n', '', cont[0]))
    zp = int(re.sub('\n', '', cont[1]))
    qln2 = int(re.sub('\n', '', cont[2]))  # 
    q31ln2 = int(re.sub('\n', '', cont[3]))  # 
    q1 = int(re.sub('\n', '', cont[4]))  # 
    q2 = int(re.sub('\n', '', cont[5]))  # 
    q6 = int(re.sub('\n', '', cont[6]))  # 
    q24 = int(re.sub('\n', '', cont[7]))  # 

    return scale, zp, qln2, q31ln2, q1, q2, q6, q24

def round_divide_positive(x, shift):
    if (x & ((1 << (shift+1))-1)) == (1 << (shift-1)):
        cond = 0
    else:
        cond = 1
    result = (x >> shift) + ((x >> (shift-1)) & cond)
    return result


def mul_round_half_to_even(a, b, shift):
    ab = int(a) * int(b)
    if(ab >= 0):
        return round_divide_positive(ab, shift)
    else:
        return -round_divide_positive(-ab, shift)


def relu(acc, KWS_MIN_VAL=0, KWS_MAX_VAL=255):
    acc = max(acc, KWS_MIN_VAL)
    acc = min(acc, KWS_MAX_VAL)
    return cast_intn(acc, 8)


def fmsr(scale, offset, shift, acc_array):
    result = np.zeros(acc_array.shape, dtype=np.int32)

    for i in range(acc_array.shape[0]):
        mul_scale = mul_round_half_to_even(acc_array[i], scale, shift)
        acc = cast_intn(mul_scale, 32)
        acc = acc + offset
        # print(acc)
        result[i] = relu(acc)
    return result


def acc_mul_scale_add_shift(scale, offset, shift, acc_array):
    result = np.zeros(acc_array.shape, dtype=np.int32)

    for i in range(acc_array.shape[0]):
        mul_scale = mul_round_half_to_even(acc_array[i], scale, shift)
        acc = cast_intn(mul_scale, 32)
        acc = acc + offset
        result[i] = acc
    return result


def conv_1D(ifmap, weight, bias, quant, stride):
    '''
    ifmap:  [width=n, in_channel=16m]
    weight: [out_channel= 16i, width=n, in_channel=16m]
    bias:    [out_channel= 16i]
    '''
    ifmap_width, in_channel = ifmap.shape
    out_channel, weight_width, in_channel = weight.shape
    padding = int((weight_width-1) / 2)
    ofmap_width = int((ifmap_width + 2*padding -weight_width) / stride) + 1
    ofmap = np.zeros([ofmap_width, out_channel], dtype=np.int32)
    for out_x in range(ofmap_width):
        for outer_i in range(out_channel//16):
            in_x = out_x * stride - padding
            if in_x < 0:
                in_x = 0

            if padding == 0:
                    width_conv = weight_width
                    bias_conv = bias[0,:]
                    weight_x = 0
            else:
                if out_x == 0:
                    width_conv = weight_width - padding
                    bias_conv = bias[0,:]
                    weight_x = 1
                elif out_x == ofmap_width - 1:
                    width_conv = weight_width - padding
                    bias_conv = bias[2,:]
                    weight_x = 0
                else :
                    width_conv = weight_width
                    bias_conv = bias[1,:]
                    weight_x = 0


            conv = conv_16xWxC(ifmap[in_x:in_x+width_conv, :], weight[outer_i*16:(outer_i+1)*16, weight_x:weight_x+width_conv, :], bias_conv[outer_i*16:(outer_i+1)*16])
            # print("Conv result:\n{}".format(conv))
            acc_mul_scale_result = acc_mul_scale_add_shift(quant[0,1], quant[0,0],quant[0,2], conv)
            # print("Conv acc mul scale add bias result:\n {}".format(acc_mul_scale_result))
            acc_relu = fmsr(quant[0,1], quant[0,0], quant[0,2], conv)
            # print("Conv relu result:\n {}".format(acc_relu))
            ofmap[out_x, outer_i*16:(outer_i+1)*16] = acc_relu

    return ofmap

def linear(ifmap, weight, bias, quant):
    '''
    ifmap:  [in_channel=16m]
    weight: [out_channel= n,1, in_channel=16m]
    bias:   [out_channel= n]
    '''
    indepth = ifmap.shape[0]
    outdepth = weight.shape[0]
    ofmap = np.zeros([outdepth], dtype=np.int32)
    for i in range(outdepth):
        mul_result = np.array(ifmap) * np.array(weight[i,0,:])
        sum_result = np.sum(mul_result)
        sum_result += bias[i]
        ofmap[i] = sum_result
    ofmap = fmsr(quant[0,1], quant[0,0], quant[0,2], ofmap)
    return ofmap

def avgpool(ifmap, quant):
    '''
    ifmap:  [in_channel=16m]
    quant:  
    '''
    avgnu = ifmap.shape[0]
    outdepth = ifmap.shape[1]
    ofmap = np.zeros([outdepth], dtype=np.int32)
    sum_result = np.sum(ifmap, axis=0)
    ofmap = fmsr(quant[0,1], quant[0,0], quant[0,2], sum_result)
    return ofmap

def dwconv_mxn(ifmap, weight, bias):
    '''
    ifmap:  [width = n, in_channel=16m]
    weight: [width = n, in/out_channel=16m]
    bias:   [out_channel=16m]
    '''
    inchannel = ifmap.shape[1]
    ofmap = np.zeros((inchannel), dtype=np.int32)
    mul_result = np.array(ifmap) * np.array(weight)
    ofmap = np.sum(mul_result,axis=0)
    ofmap += bias
    return ofmap

def dwconv_mxn_relu(ifmap, weight, bias, quant):
    '''
    ifmap:  [width = n, in_channel=16m]
    weight: [width = n, in/out_channel=16m]
    bias:   [out_channel=16m]
    '''
    ofmap = dwconv_mxn(ifmap, weight, bias)
    acc_mul_scale_result = acc_mul_scale_add_shift(quant[0,1], quant[0,0],quant[0,2], ofmap)
    # print("Conv acc mul scale add bias result:\n {}".format(acc_mul_scale_result))
    acc_relu = fmsr(quant[0,1], quant[0,0], quant[0,2], ofmap)
    # print("Conv relu result:\n {}".format(acc_relu))
    return acc_relu

def dwconv_1D(ifmap, weight, bias, quant, stride):
    '''
    ifmap:  [width=n, in_channel=16m]
    weight: [out_channel= 16i, width=n, in_channel=16m]
    bias:    [out_channel= 16i]
    '''
    ifmap_width, in_channel = ifmap.shape
    out_channel, weight_width, in_channel = weight.shape
    assert out_channel == 1, "Dw conv out channel should be 1!"
    padding = int((weight_width-1) / 2)
    ofmap_width = int((ifmap_width + 2*padding -weight_width) / stride) + 1
    ofmap = np.zeros([ofmap_width, in_channel], dtype=np.int32)
    for out_x in range(ofmap_width):
        for outer_i in range(in_channel//16):
            in_x = out_x * stride - padding
            if in_x < 0:
                ifmap_start = 0
                ifmap_end = weight_width + in_x
                weight_start = - in_x
                weight_end = weight_width
            elif in_x + weight_width >= ifmap_width:
                ifmap_start = in_x
                ifmap_end = ifmap_width
                weight_start = 0
                weight_end = weight_width - (in_x + weight_width - ifmap_width)
            else:
                ifmap_start = in_x
                ifmap_end = weight_width + in_x
                weight_start = 0
                weight_end = weight_width

            ifmap_in = ifmap[ifmap_start:ifmap_end, outer_i*16:(outer_i+1)*16]
            weight_in = weight[0, weight_start:weight_end, outer_i*16:(outer_i+1)*16]
            bias_in = bias[0, outer_i*16:(outer_i+1)*16]
            #print(ifmap_in.shape, weight_in.shape, bias_in.shape)   
            ofmap[out_x, outer_i*16:(outer_i+1)*16] = dwconv_mxn_relu(ifmap_in, weight_in, bias_in, quant)
    return ofmap

def skipadd_relu(ifmap1, ifmap2, skip_param):
    '''
    ifmap1: [width = n, in_channel=16m]
    ifmap2: [width = n, in_channel=16m]
    skip_param:   [offset1, scale1, offset2, scale2, offset, shift]
    '''
    offset1, scale1, offset2, scale2, offset, shift = skip_param.tolist()
    ofmap = np.zeros(ifmap1.shape, dtype=np.int32)
    ofmap1 = (np.array(ifmap1, dtype=np.int32) - np.array([offset1], dtype=np.int32)) * np.array([scale1], dtype=np.int32)
    ofmap2 = (np.array(ifmap2, dtype=np.int32) - np.array([offset2], dtype=np.int32)) * np.array([scale2], dtype=np.int32)
    ofmap = ofmap1 + ofmap2
    for i in range(ofmap.shape[0]):
        for j in range(ofmap.shape[1]):
            mul_scale = mul_round_half_to_even(ofmap[i,j], 1, shift)
            acc = cast_intn(mul_scale, 32)
            acc = acc + offset
            ofmap[i,j] = relu(acc)
            # print("Conv relu result:\n {}".format(acc_relu))
    return ofmap

def generate_random_weight(weight_size, weight_save_path, min_value = -128, max_value = 127):
    weight_raw = np.random.randint(min_value, max_value, weight_size)
    weight_flatten = weight_raw.flatten()
    with open(weight_save_path, 'w') as f:
        for i in range(weight_flatten.shape[0]):
            if i < weight_flatten.shape[0]-1:
                f.write(str(weight_flatten[i]) + '\n')
            else:
                f.write(str(weight_flatten[i]))

def generate_random_ifmap(ifmap_size, ifmap_save_path, min_value = 0, max_value = 255):
    weight_raw = np.random.randint(min_value, max_value, ifmap_size)
    weight_flatten = weight_raw.flatten()
    with open(ifmap_save_path, 'w') as f:
        for i in range(weight_flatten.shape[0]):
            if i < weight_flatten.shape[0]-1:
                f.write(str(weight_flatten[i]) + '\n')
            else:
                f.write(str(weight_flatten[i]))

def debug_ifmap_load(ifmap_path, SIMD_FACTOR):
    ibb1_ifmap = np.loadtxt(ifmap_path)
    print(ibb1_ifmap.shape)
    ibb1_ifmap_size_fix = [ibb1_ifmap.shape[0], ibb1_ifmap.shape[1] // SIMD_FACTOR, SIMD_FACTOR]
    ibb1_ifmap_flatten = ibb1_ifmap.reshape(ibb1_ifmap_size_fix)
    ibb1_ifmap_flatten = ibb1_ifmap_flatten.reshape([-1, SIMD_FACTOR])
    ifmap_len = ibb1_ifmap_flatten.shape[0]
    return ibb1_ifmap_flatten 

def runtime_data_gen(weight_all, bias_all, quant_all, skipadd_all):
    fbank_raw = load_act('data/conv00_fmapin.txt')
    fbank_raw = np.array(fbank_raw).reshape([60,32])

    conv00 = conv_1D(fbank_raw, weight_all['conv00_w'], bias_all['conv00_b'], quant_all['conv00_q'], 1)
    np.savetxt('runtime_data/conv00.txt',conv00,fmt='%d')
    skip = conv00
    # IBB1
    conv10 = conv_1D(conv00, weight_all['conv10_w'], bias_all['conv10_b'], quant_all['conv10_q'], 1)
    np.savetxt('runtime_data/conv10.txt',conv10,fmt='%d')
    conv11 = dwconv_1D(conv10, weight_all['conv11_w'], bias_all['conv11_b'], quant_all['conv11_q'], 2)
    np.savetxt('runtime_data/conv11.txt',conv11,fmt='%d')

    conv12 = conv_1D(conv11, weight_all['conv12_w'], bias_all['conv12_b'], quant_all['conv12_q'], 1)
    np.savetxt('runtime_data/conv12.txt',conv12,fmt='%d')
    # skip conv
    conv13 = conv_1D(skip, weight_all['conv13_w'], bias_all['conv13_b'], quant_all['conv13_q'], 2)
    np.savetxt('runtime_data/conv13.txt',conv13,fmt='%d')

    ibb0_skipadd = skipadd_relu(conv12, conv13, skipadd_all['ibb0_skipadd'])
    np.savetxt('runtime_data/ibb0_skipadd.txt',ibb0_skipadd,fmt='%d')

   # IBB2
    conv20 = conv_1D(ibb0_skipadd, weight_all['conv20_w'], bias_all['conv20_b'], quant_all['conv20_q'], 1)
    np.savetxt('runtime_data/conv20.txt',conv20,fmt='%d')
    skip = ibb0_skipadd
    conv21 = dwconv_1D(conv20, weight_all['conv21_w'], bias_all['conv21_b'], quant_all['conv21_q'], 1)
    np.savetxt('runtime_data/conv21.txt',conv21,fmt='%d')

    conv22 = conv_1D(conv21, weight_all['conv22_w'], bias_all['conv22_b'], quant_all['conv22_q'], 1)
    np.savetxt('runtime_data/conv22.txt',conv22,fmt='%d')

    ibb1_skipadd = skipadd_relu(conv22, skip, skipadd_all['ibb1_skipadd'])
    np.savetxt('runtime_data/ibb1_skipadd.txt',ibb1_skipadd,fmt='%d')

   # IBB3
    skip = ibb1_skipadd
    conv30 = conv_1D(ibb1_skipadd, weight_all['conv30_w'], bias_all['conv30_b'], quant_all['conv30_q'], 1)
    np.savetxt('runtime_data/conv30.txt',conv30,fmt='%d')
    conv31 = dwconv_1D(conv30, weight_all['conv31_w'], bias_all['conv31_b'], quant_all['conv31_q'], 2)
    np.savetxt('runtime_data/conv31.txt',conv31,fmt='%d')

    conv32 = conv_1D(conv31, weight_all['conv32_w'], bias_all['conv32_b'], quant_all['conv32_q'], 1)
    np.savetxt('runtime_data/conv32.txt',conv32,fmt='%d')
    # skip conv
    conv33 = conv_1D(skip, weight_all['conv33_w'], bias_all['conv33_b'], quant_all['conv33_q'], 2)
    np.savetxt('runtime_data/conv33.txt',conv33,fmt='%d')

    ibb2_skipadd = skipadd_relu(conv32, conv33, skipadd_all['ibb2_skipadd'])
    np.savetxt('runtime_data/ibb2_skipadd.txt',ibb2_skipadd,fmt='%d')

    # IBB4
    conv40 = conv_1D(ibb2_skipadd, weight_all['conv40_w'], bias_all['conv40_b'], quant_all['conv40_q'], 1)
    np.savetxt('runtime_data/conv40.txt',conv40,fmt='%d')
    skip = ibb2_skipadd
    conv41 = dwconv_1D(conv40, weight_all['conv41_w'], bias_all['conv41_b'], quant_all['conv41_q'], 1)
    np.savetxt('runtime_data/conv41.txt',conv41,fmt='%d')

    conv42 = conv_1D(conv41, weight_all['conv42_w'], bias_all['conv42_b'], quant_all['conv42_q'], 1)
    np.savetxt('runtime_data/conv42.txt',conv42,fmt='%d')

    ibb3_skipadd = skipadd_relu(conv42, skip, skipadd_all['ibb3_skipadd'])
    np.savetxt('runtime_data/ibb3_skipadd.txt',ibb3_skipadd,fmt='%d')

    avgpool_out = avgpool(ibb3_skipadd, quant_all['avgpool_q'])
    np.savetxt('runtime_data/avgpool_out.txt',avgpool_out,fmt='%d')

    fc_out = linear(avgpool_out, weight_all['linear_w'], bias_all['linear_b'], quant_all['linear_q'])
    np.savetxt('runtime_data/linear_out.txt',fc_out,fmt='%d')

if __name__ == "__main__":
    # a0 = np.array([[1, 2, 3, 255], [1, 1, 1, 1]])
    # print(simd_mul_and_sum(a0, a0))
    # print(bias_enlarge_dim(a0, 16))
    np.random.seed(2023)
    act_0_size = [60, 32]
    weight_0_size = [16, 3, 32]  # Co, W, Ci
    bias_0_size = [3, 16]
    quant_0_size = [1, 3]
    generate_random_weight(weight_0_size, 'data/conv00_w.txt')
    generate_random_ifmap(act_0_size, 'data/conv00_fmapin.txt')

    generate_random_weight([48,1,16], 'data/conv10_w.txt')
    generate_random_weight([48,9], 'data/conv11_w.txt')
    generate_random_weight([16,1,48], 'data/conv12_w.txt')
    generate_random_weight([16,1,16], 'data/conv13_w.txt')

    generate_random_weight([48,1,16], 'data/conv20_w.txt')
    generate_random_weight([48,9], 'data/conv21_w.txt')
    generate_random_weight([16,1,48], 'data/conv22_w.txt')

    generate_random_weight([48,1,16], 'data/conv30_w.txt')
    generate_random_weight([48,9], 'data/conv31_w.txt')
    generate_random_weight([16,1,48], 'data/conv32_w.txt')
    generate_random_weight([16,1,16], 'data/conv33_w.txt')

    generate_random_weight([48,1,16], 'data/conv40_w.txt')
    generate_random_weight([48,9], 'data/conv41_w.txt')
    generate_random_weight([16,1,48], 'data/conv42_w.txt')

    generate_random_weight([7+2,1,16], 'data/linear_w.txt')
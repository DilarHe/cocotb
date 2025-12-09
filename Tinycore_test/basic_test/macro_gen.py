import re
from utils import *
import math
def toMemBias(array_shape, factor=16):
    x = 1
    for i in range(len(array_shape)):
        x = x * array_shape[i] 
    return math.ceil(x / factor)

def macro_gen(json_path, out_path):
    config = load_json_config(json_path)
    FBANK_MEM_NUM = int(config["mem"]["fbank"])  # 1920
    ACT_MEM_NUM = int(config["mem"]["act"])  # 2048
    WEIGHT_MEM_NUM = int(config["mem"]["weight"])  # 13000
    STACK_MEM_NUM = int(config["mem"]["stack"])  # 256

    SIMD_FACTOR = 16
    stack_line_len = STACK_MEM_NUM
    fbank_line_len = int(FBANK_MEM_NUM / SIMD_FACTOR)
    act_line_len = int(ACT_MEM_NUM / SIMD_FACTOR)
    weight_line_len = int(WEIGHT_MEM_NUM / SIMD_FACTOR)

    stack_start = 0
    fbank_start = stack_line_len
    act_start = stack_line_len + fbank_line_len
    weight_start = stack_line_len + fbank_line_len + act_line_len

    macros = {}
    macros['KWS_MAX_VAL'] = 255
    macros['KWS_MIN_VAL'] = 0
    # stack
    macros['C1_StackBase'] = 0
    macros['DW_StackBase'] = 8
    macros['Skipadd_StackBase'] = 17    
    macros['IBB1C1_StackBase'] = 21
    macros['SOFTMAX_StackBase'] = 26
    macros['TOPCTRL_StackBase'] = 37
    macros['KWSCONFIG_StackBase'] = 43

    # c1 weight
    macros['C1_WeightBase'] = weight_start
    macros['C1_WeightBaseFirst'] = weight_start + 32  # 16*2 , for padding = 1
    macros['C1_BiasBase'] = weight_start + toMemBias([16,3,32])  # 3*32*16 /16=96
    macros['C1_BiasBaseADD16'] = macros['C1_BiasBase'] + 4  # 每行mem可以存128/32=4个bias, 16个bias需要4行
    macros['C1_BiasBaseADD32'] = macros['C1_BiasBaseADD16'] + 4
    macros['C1_QuantBase'] = macros['C1_BiasBaseADD32'] + 4 
    # IBB1 C1 weight
    macros['IBB1_C1_WeightBase'] = macros['C1_QuantBase'] + 1
    macros['IBB1_C1_BiasBase'] = macros['IBB1_C1_WeightBase'] + toMemBias([48,1,16]) # 16*48/16 = 48
    macros['IBB1_C1_QuantBase'] = macros['IBB1_C1_BiasBase'] + toMemBias([48],factor=4)
    # IBB1 DW weight
    macros['IBB1_DW_WeightBase'] = macros['IBB1_C1_QuantBase'] + 1
    macros['IBB1_DW_BiasBase'] = macros['IBB1_DW_WeightBase'] + toMemBias([1,9,48]) 
    macros['IBB1_DW_QuantBase'] = macros['IBB1_DW_BiasBase'] + toMemBias([48],factor=4)
    # IBB1 C2 weight
    macros['IBB1_C2_WeightBase'] = macros['IBB1_DW_QuantBase'] + 1
    macros['IBB1_C2_BiasBase'] = macros['IBB1_C2_WeightBase'] + toMemBias([16,1,48]) 
    macros['IBB1_C2_QuantBase'] = macros['IBB1_C2_BiasBase'] + toMemBias([16],factor=4)
    # IBB1 Cskip weight
    macros['IBB1_Cskip_WeightBase'] = macros['IBB1_C2_QuantBase'] + 1
    macros['IBB1_Cskip_BiasBase'] = macros['IBB1_Cskip_WeightBase'] + toMemBias([16,1,16]) 
    macros['IBB1_Cskip_QuantBase'] = macros['IBB1_Cskip_BiasBase'] + toMemBias([16],factor=4)
    # IBB1 skipadd params
    macros['IBB1_skipadd_paramBase'] = macros['IBB1_Cskip_QuantBase'] + 1

    # IBB2 C1 weight
    macros['IBB2_C1_WeightBase'] = macros['IBB1_skipadd_paramBase'] + 1
    macros['IBB2_C1_BiasBase'] = macros['IBB2_C1_WeightBase'] + toMemBias([48,1,16]) # 16*48/16 = 48
    macros['IBB2_C1_QuantBase'] = macros['IBB2_C1_BiasBase'] + toMemBias([48],factor=4)
    # IBB2 DW weight
    macros['IBB2_DW_WeightBase'] = macros['IBB2_C1_QuantBase'] + 1
    macros['IBB2_DW_BiasBase'] = macros['IBB2_DW_WeightBase'] + toMemBias([1,9,48]) 
    macros['IBB2_DW_QuantBase'] = macros['IBB2_DW_BiasBase'] + toMemBias([48],factor=4)
    # IBB2 C2 weight
    macros['IBB2_C2_WeightBase'] = macros['IBB2_DW_QuantBase'] + 1
    macros['IBB2_C2_BiasBase'] = macros['IBB2_C2_WeightBase'] + toMemBias([16,1,48]) 
    macros['IBB2_C2_QuantBase'] = macros['IBB2_C2_BiasBase'] + toMemBias([16],factor=4)
    # IBB2 skipadd params
    macros['IBB2_skipadd_paramBase'] = macros['IBB2_C2_QuantBase'] + 1

    # IBB3 C1 weight
    macros['IBB3_C1_WeightBase'] = macros['IBB2_skipadd_paramBase'] + 1
    macros['IBB3_C1_BiasBase'] = macros['IBB3_C1_WeightBase'] + toMemBias([48,1,16]) # 16*48/16 = 48
    macros['IBB3_C1_QuantBase'] = macros['IBB3_C1_BiasBase'] + toMemBias([48],factor=4)
    # IBB3 DW weight
    macros['IBB3_DW_WeightBase'] = macros['IBB3_C1_QuantBase'] + 1
    macros['IBB3_DW_BiasBase'] = macros['IBB3_DW_WeightBase'] + toMemBias([1,9,48]) 
    macros['IBB3_DW_QuantBase'] = macros['IBB3_DW_BiasBase'] + toMemBias([48],factor=4)
    # IBB3 C2 weight
    macros['IBB3_C2_WeightBase'] = macros['IBB3_DW_QuantBase'] + 1
    macros['IBB3_C2_BiasBase'] = macros['IBB3_C2_WeightBase'] + toMemBias([16,1,48]) 
    macros['IBB3_C2_QuantBase'] = macros['IBB3_C2_BiasBase'] + toMemBias([16],factor=4)
    # IBB3 Cskip weight
    macros['IBB3_Cskip_WeightBase'] = macros['IBB3_C2_QuantBase'] + 1
    macros['IBB3_Cskip_BiasBase'] = macros['IBB3_Cskip_WeightBase'] + toMemBias([16,1,16]) 
    macros['IBB3_Cskip_QuantBase'] = macros['IBB3_Cskip_BiasBase'] + toMemBias([16],factor=4)
    # IBB3 skipadd params
    macros['IBB3_skipadd_paramBase'] = macros['IBB3_Cskip_QuantBase'] + 1

    # IBB4 C1 weight
    macros['IBB4_C1_WeightBase'] = macros['IBB3_skipadd_paramBase'] + 1
    macros['IBB4_C1_BiasBase'] = macros['IBB4_C1_WeightBase'] + toMemBias([48,1,16]) # 16*48/16 = 48
    macros['IBB4_C1_QuantBase'] = macros['IBB4_C1_BiasBase'] + toMemBias([48],factor=4)
    # IBB4 DW weight
    macros['IBB4_DW_WeightBase'] = macros['IBB4_C1_QuantBase'] + 1
    macros['IBB4_DW_BiasBase'] = macros['IBB4_DW_WeightBase'] + toMemBias([1,9,48]) 
    macros['IBB4_DW_QuantBase'] = macros['IBB4_DW_BiasBase'] + toMemBias([48],factor=4)
    # IBB4 C2 weight
    macros['IBB4_C2_WeightBase'] = macros['IBB4_DW_QuantBase'] + 1
    macros['IBB4_C2_BiasBase'] = macros['IBB4_C2_WeightBase'] + toMemBias([16,1,48]) 
    macros['IBB4_C2_QuantBase'] = macros['IBB4_C2_BiasBase'] + toMemBias([16],factor=4)
    # IBB4 skipadd params
    macros['IBB4_skipadd_paramBase'] = macros['IBB4_C2_QuantBase'] + 1

    # AVGPOOL
    macros['AvgPool_QuantBase'] = macros['IBB4_skipadd_paramBase'] + 1
    # Linear weight
    macros['LINEAR_WeightBase'] = macros['AvgPool_QuantBase'] + 1
    macros['LINEAR_BiasBase'] = macros['LINEAR_WeightBase'] + toMemBias([9,1,16]) # 16*9/16 = 9
    macros['LINEAR_QuantBase'] = macros['LINEAR_BiasBase'] + toMemBias([9],factor=4)
    # Softmax Params
    macros['SOFTMAX_PARAM'] = macros['LINEAR_QuantBase'] + 1


    # c1 paras
    macros['C1_IfmapWidth'] = 59
    macros['C1_IfmapDepth'] = 32
    macros['C1_OfmapDepth'] = 16
    macros['C1_FilterWidth'] = 3
    macros['C1_Stride'] = 1
    macros['C1_Padding'] = 1
    macros['C1_InnerLoop'] = 6
    macros['C1_InnerLoopFirst'] = 4
    macros['C1_OuterLoop'] = 1
    # IBB1 c1 paras
    macros['IBB_C1_OuterLoop'] = 3
    macros['IBB_Skip_OuterLoop'] = 1
    macros['IBB_DW_OuterLoop'] = 3
    macros['IBB_C2_OuterLoop'] = 1


    # c1 fmap
    macros['C1_IfmapBase'] = fbank_start
    macros['C1_OfmapBase'] = act_start
    # IBB1 C1 fmap
    macros['IBB1_C1_ifmapBase'] = act_start
    macros['IBB1_C1_ofmapBase'] = act_start + toMemBias([60,16]) 
    macros['IBB1_C1_ofmapBound1'] = macros['IBB1_C1_ofmapBase']  + toMemBias([1,9,48]) - 6
    macros['IBB1_C1_ofmapBound2'] = macros['IBB1_C1_ofmapBase']  + toMemBias([1,9,48]) - 3
    macros['IBB1_C1_ofmapBound'] = macros['IBB1_C1_ofmapBase']  + toMemBias([1,9,48])

    # IBB1 DW fmap
    macros['IBB1_DW_ifmapBase'] = macros['IBB1_C1_ofmapBase']
    macros['IBB1_DW_ofmapBase'] = macros['IBB1_DW_ifmapBase'] + toMemBias([1,9,48])
    macros['IBB1_DW_ifmap_fifo_end'] = macros['IBB1_DW_ofmapBase'] - 3
    macros['IBB1_DW_ifmapBaseAdd3'] = macros['IBB1_DW_ifmapBase'] + 3

    # IBB1 C2 fmap
    macros['IBB1_C2_ifmapBase'] = macros['IBB1_DW_ofmapBase']
    macros['IBB1_C2_ofmapBase'] = macros['IBB1_C2_ifmapBase']       # 原地计算

    # avgpool
    macros['AVGPOOL_ifmapBase'] = act_start
    macros['AVGPOOL_ofmapBase'] = act_start
    # fc
    macros['LINEAR_ifmapBase'] = act_start
    macros['LINEAR_ofmapBase'] = act_start



    macros_list = macros.items()
    max_len = 0
    for key, value in macros_list:
        if len(key) > max_len:
            max_len = len(key)
    with open(out_path, 'w') as f:
        for items in (macros_list):
            align = max_len - len(items[0])
            f.write(items[0] + ' '*align + '     '+ str(items[1])+ '\n')

    return macros,fbank_start,act_start,weight_start

if __name__ == '__main__':
    macro_gen('../../../hw_config.json', 'macro.asm')
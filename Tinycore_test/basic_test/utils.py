import re
import json
import numpy as np

def load_json_config(json_path):
    with open(json_path, 'r') as f:
        config = json.load(f)
    return config


def tobin(a):
    return bin(a)[2:]


def dec2bin_ext_clip(a, width):
    assert (width <= 32)
    return zero_extend(signed_dec2bin(a))[32 - width:32]


def signed_dec2bin(a):
    if a < 0:
        absa = abs(a)
        nega = np.array(~absa + 1).astype('uint32')
        return (bin(nega)[2:])
    else:
        return (bin(a)[2:])


def zero_extend(s, width=32):
    if len(s) < width:
        return (width - len(s)) * '0' + s
    else:
        return s


def Uint2Sint(num, bits):
    sign_mask = 1 << (bits - 1)
    inv_mask = (1 << (bits)) - 1
    if ((num & sign_mask) == 0):
        return num
    else:
        num = num ^ inv_mask
        num = num + 1
        return -num


def NpUint2Sint(x, bits):
    """
    Change a signed/unsigned np.array to unsigned/signed
    :param x: np.array
    :param bits: max bit width of data in x
    :return: signed/unsigned array of x
    """
    sign_mask = 1 << (bits - 1)
    inv_mask = (1 << (bits)) - 1
    x = x.astype(np.int32)
    pos_mask = (x & sign_mask) == 0
    return np.where(pos_mask, x, -((x ^ inv_mask) + 1))


def toggle_element2memline(ele_array, ele_width=8):
    ele_num = ele_array.shape[0]
    line_width = int(ele_width * ele_num)
    line = ''
    for e in ele_array:
        line += dec2bin_ext_clip(e, ele_width)
    return ('0b' + line, line_width)


def rm_enter(string):
    return re.sub(r'\n', '', string)


def rm_lead_blank(string):
    return re.sub(r'^\s*', '', string)

def rm_blank(string):
    return re.sub(r'\s*','',string)

def rm_dot_and_long_blank(string):
    string = re.sub(r'[,;]', ' ', string)
    return re.sub(r'\s+', ' ', string)


def rm_zhushi(string):
    return re.sub(r'//.*', '', string)


def ld_st_fmt(code, funct3, op, width1, width2, imm_width):
    r2 = int(code[1][1:])  # remove 'x'
    imm, r1 = re.sub(r'[\)]', '', code[2]).split('(')
    r2 = dec2bin_ext_clip(r2, width2)
    imm = dec2bin_ext_clip(int(imm), imm_width)
    r1 = dec2bin_ext_clip(int(r1[1:]), width1)
    return funct3 + imm[:3] + r1 + imm[3:] + r2 + op, r1, r2, imm


def arithmetic_fmt(code, funct3, funct6, funct2, op, width1, width2, r3_width, imm_width):
    r1 = int(code[1][1:])  # remove 'x'
    r2 = int(code[2][1:])
    r1 = dec2bin_ext_clip(r1, width1)
    r2 = dec2bin_ext_clip(r2, width2)
    if len(funct2) == 0 and op == '01':
        imm = int(code[3])  # imm
        imm = dec2bin_ext_clip(imm, imm_width)
        return funct3 + imm[0] + funct6 + r1 + imm[1:] + op, r1, r2, imm
    elif len(funct2) == 0 and op == '10' and len(funct6) == 0:
        imm = int(code[3])  # imm
        imm = dec2bin_ext_clip(imm, imm_width)
        return funct3 + imm[0] + funct6 + r1 + imm[1:] + op, r1, r2, imm
    else:
        r3 = int(code[3][1:])  # rs2
        r3 = dec2bin_ext_clip(r3, r3_width)
        return funct3 + funct6 + r1 + funct2 + r3 + op, r1, r2, r3


def j_fmt(code, funct3, funct6, funct2, op, width1, width2, imm_width):
    if op == '00':   #mvimmx4
        imm = int(code[2])
        imm = dec2bin_ext_clip(imm, imm_width)
        return funct3 + imm + op, imm, 0
    elif len(funct6) == 0 and width1 == 0:  # J
        imm = int(code[1])
        imm = dec2bin_ext_clip(imm, imm_width)
        return funct3 + imm + op, imm, 0
    elif len(funct6) == 0 and width1 == 1:  # JAL
        r1 = int(code[1][1:])
        r1 = dec2bin_ext_clip(r1, 1)
        assert r1 == '1', "link register should be x1!"
        imm = int(code[2])
        imm = dec2bin_ext_clip(imm, imm_width)
        return funct3 + imm + op, imm, r1
    elif funct6 == '0' and width2 == 0:  # JR
        r1 = int(code[1][1:])
        r1 = dec2bin_ext_clip(r1, width1)
        return funct3 + funct6 + r1 + '00000' + op, r1, 0
    elif funct6 == '0' and width2 != 0:  # MV
        r1 = int(code[1][1:])  # remove 'x'
        r2 = int(code[2][1:])
        r1 = dec2bin_ext_clip(r1, width1)
        r2 = dec2bin_ext_clip(r2, width2)
        return funct3 + funct6 + r1 + r2 + op, r1, r2
    elif funct6 == '1' and width1 == 0 and width2 == 0:  # EBREAK
        return funct3 + funct6 + '00000' * 2 + op, 0, 0


def branch_fmt(code, funct3, op, width1, imm_width):
    r1 = int(code[1][1:])
    r1 = dec2bin_ext_clip(r1, width1)
    imm = int(code[2])
    imm = dec2bin_ext_clip(imm, imm_width)
    return funct3 + imm[:3] + r1 + imm[3:] + op, r1, imm


def addi4spn(code, funct3, op, width1, imm_width):
    r1 = int(code[1][1:])
    r1 = dec2bin_ext_clip(r1, width1)
    imm = int(code[2])
    imm = dec2bin_ext_clip(imm, imm_width)
    return funct3 + imm + r1 + op, r1, imm


def vector_fmt(code, funct3, funct6,funct7, op, rd_width, rs1_width, rs2_width):
    if funct3 == '000':
        if funct7 == '1000': #mvx
            rd = int(code[1][1:])  # remove 'x'
            r2 = int(code[2][1:])
            rd = dec2bin_ext_clip(rd, rd_width)
            r2 = dec2bin_ext_clip(r2, rs2_width)
            return funct3 + rd + r2 + funct7 + op, rd, r2, 0
        else: 
            rd = int(code[1][1:])  # remove 'x'
            r2 = int(code[3][1:])
            r1 = int(code[2][1:])
            rd = dec2bin_ext_clip(rd, rd_width)
            r2 = dec2bin_ext_clip(r2, rs2_width)
            r1 = dec2bin_ext_clip(r1, rs1_width)
            return funct3 + rd + r2 + funct7 + op, rd, r2, r1
    elif funct3 == '001' and funct6 == '0':
        rd = int(code[1][1:])
        r1 = int(code[2][1:])
        r2 = int(code[3][1:])
        assert r1 == rd, "the rd must equal to rs1!"
        r1 = dec2bin_ext_clip(r1, rs1_width)
        r2 = dec2bin_ext_clip(r2, rs2_width)
        return funct3 + funct6 + r1 + r2 + op, r1, r2
    elif funct3 == '001' and funct6 == '1':
        rd = int(code[1][1:])
        r1 = int(code[2][1:])
        r2 = int(code[3][1:])
        assert r1 == rd, "the rd must equal to rs1!"
        r1 = dec2bin_ext_clip(r1, rs1_width)
        r2 = dec2bin_ext_clip(r2, rs2_width)
        return funct3 + funct6 + r1 + r2 + op, r1, r2


def load_bin2np(array, bin_path):
    with open(bin_path, 'r') as f:
        bins = f.readlines()
    assert len(array.shape) == 1, "The dim of memory array must be 1!"
    assert len(bins) <= array.shape[0], "The bin is out of memory!"
    for i in range(len(bins)):
        array[i] = int('0b' + bins[i], 2)
    return array

def store_bin2int(bin_path, txt_path):
    with open(bin_path, 'r') as f:
        bins = f.readlines()
    with open(txt_path, 'w') as f:
        for i in range(len(bins)):
            line = int('0b' + bins[i], 2)
            if i == len(bins)-1:
                f.write(str(line))
            else:
                f.write(str(line)+'\n')

def solve_label(filter_code_list):
    label_dict = {}
    no_label_code = []
    line_num = 0
    for i in range(len(filter_code_list)):
        line_num += 1
        curr_line_code = filter_code_list[i]
        if curr_line_code[0] == '.':
            line_num -= 1
            label_line = rm_blank(curr_line_code)
            if label_dict.get(label_line) is None:
                label_dict[label_line] = line_num
            else:
                raise('LABEL is coflict!')
        else:
            no_label_code.append(curr_line_code)
    print(label_dict)
    for i in range(len(no_label_code)):
        curr_line = no_label_code[i]
        label_search = re.search('\.\S+',curr_line)
        if label_search is not None:
            label = label_search.group()
            # curr_split = curr_line.split(' ')
            # if curr_split[0] == 'j' or curr_split[0]=='jal':
            #     distance = label_dict[label]
            # else:
            distance = label_dict[label] - i
            no_label_code[i] = re.sub('\.\S+',str(distance),curr_line)
    with open('nolable.asm','w') as f:
        for i in range(len(no_label_code) - 1):
            f.write(no_label_code[i] + '\n')
        f.write(no_label_code[-1])
    print("MAIN Function in Address : {}".format(label_dict['.MAIN']))
    return no_label_code, label_dict

def solve_define(code_list, macro_file):
    with open(macro_file,'r') as f:
        macros = f.readlines()
    macro_dict = {}
    for i in range(len(macros)):
        raw_line = rm_lead_blank(rm_zhushi(rm_enter(macros[i])))
        if len(raw_line) != 0:
            raw_line = rm_dot_and_long_blank(raw_line)
            splits = raw_line.split(' ')
            macro_name = splits[0]
            macro_data = int(splits[1])
            macro_dict[macro_name] = macro_data
    for i in range(len(code_list)):
        code_line = code_list[i]
        macro_search = re.search('`\S+',code_line)
        if macro_search is not None:
            macro = macro_search.group()[1:]
            code_list[i] = re.sub('`\S+',str(macro_dict[macro]),code_line)
    with open('nodefine.asm','w') as f:
        for i in range(len(code_list) - 1):
            f.write(code_list[i] + '\n')
        f.write(code_list[-1])
    return code_list

def solve_stackframe(code_list, stack_file):
    with open(stack_file,'r') as f:
        stackframes = f.readlines()
    var_dict = {}

    for i in range(len(stackframes)):
        raw_line = rm_lead_blank(rm_zhushi(rm_enter(stackframes[i])))
        if len(raw_line) != 0:
            raw_line = rm_dot_and_long_blank(raw_line)
            stack_base = re.search(r'^__\S+',raw_line)
            if stack_base is not None:
                line_num = 0
                stack_name = stack_base.group()
                var_dict[stack_name] = {}
            else:
                var_name = raw_line
                var_dict[stack_name][var_name] = line_num
                line_num += 1
    # print(var_dict)
    for i in range(len(code_list)):
        raw_line = code_list[i]
        stack_base = re.search(r'(__\w+)\.(_\w+)', raw_line)
        if stack_base is not None:
            stack_name = stack_base.group(1)
            var_name = stack_base.group(2)
            # print('test')
            # print(stack_name)
            # print(var_name)
            var_data = var_dict[stack_name][var_name]
            code_list[i] = re.sub(r'__\w+\._\w+', str(var_data), code_list[i])
            # print(code_list[i])
    with open('nostack.asm','w') as f:
        for i in range(len(code_list) - 1):
            f.write(code_list[i] + '\n')
        f.write(code_list[-1])
    return code_list


def asm2bin(asm_path, isdebug=1):
    with open(asm_path, "r") as f:
        code = f.readlines()
    filter_code = []
    for i in range(len(code)):
        true_code = rm_lead_blank(rm_zhushi(rm_enter(code[i])))
        if len(true_code) != 0:
            true_code = rm_dot_and_long_blank(true_code)
            filter_code.append(true_code)
# remove the labels
    filter_code = solve_define(filter_code, 'macro.asm')
    filter_code = solve_stackframe(filter_code, 'stack_frame.asm')
    filter_code, label_dict = solve_label(filter_code)
# split the op and operands
    for i in range(len(filter_code)):
        filter_code[i] = (filter_code[i].split(' '))

    decode_code = []
    for i in range(len(filter_code)):
        opname = filter_code[i][0]
        match opname:

            case 'lw':
                op = '00'
                funct3 = '010'
                imm_width = 5;
                rd_width = 3;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, r2, imm = ld_st_fmt(filter_code[i], funct3, op, rs1_width, rd_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r2, imm, r1, '-'))
            case 'sw':
                op = '00'
                funct3 = '110'
                imm_width = 5;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 3;
                decode, r1, r2, imm = ld_st_fmt(filter_code[i], funct3, op, rs1_width, rs2_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, r1, r2))
            case 'lv':
                op = '11'
                funct3 = '01'
                imm_width = 4;
                rd_width = 5;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, r2, imm = ld_st_fmt(filter_code[i], funct3, op, rs1_width, rd_width, imm_width)
                r2 = int('0b' + r2, 2)
                assert r2 <= 20 , "Load Vector rd index should in range 0~20!"
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r2, imm, r1, '-'))
            case 'sv1':
                op = '11'
                funct3 = '1'
                imm_width = 5;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 5;
                decode, r1, r2, imm = ld_st_fmt(filter_code[i], funct3, op, rs1_width, rs2_width, imm_width)
                assert int(r2) == 0, "sv1 instr must have a zero rs2!"
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, r1, r2))
            case 'sv2':
                op = '11'
                funct3 = '1'
                imm_width = 5;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 5;
                decode, r1, r2, imm = ld_st_fmt(filter_code[i], funct3, op, rs1_width, rs2_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, r1, r2))
            case 'nop':
                op = '01'
                funct3 = '000'
                decode_code.append(funct3 + '1' + '00000' + '11111' + op)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', '-', '-', '-'))

            case 'addi':
                op = '01'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                imm_width = 6;
                rd_width = 0;
                rs1_width = 5;
                rs2_width = 0;
                decode, r1, r2, imm = arithmetic_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs1_width,
                                                     0, imm_width)
                assert r1 == r2, "the rd must equal to rs1!"
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, imm, r1, '-'))
            case 'srli':
                op = '01'
                funct3 = '100'
                funct6 = '00'
                funct2 = ''
                imm_width = 6;
                rd_width = 3;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, r2, imm = arithmetic_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs1_width,
                                                     0, imm_width)
                assert r1 == r2, "the rd must equal to rs1!"
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, imm, r1, '-'))
            
            case 'srai':
                op = '01'
                funct3 = '100'
                funct6 = '01'
                funct2 = ''
                imm_width = 6;
                rd_width = 3;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, r2, imm = arithmetic_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs1_width,
                                                     0, imm_width)
                assert r1 == r2, "the rd must equal to rs1!"
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, imm, r1, '-'))
            case 'slli':
                op = '10'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                imm_width = 6;
                rd_width = 0;
                rs1_width = 5;
                rs2_width = 0;
                decode, r1, r2, imm = arithmetic_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs1_width,
                                                     0, imm_width)
                assert r1 == r2, "the rd must equal to rs1!"
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, imm, r1, '-'))
            case 'sub':
                op = '01'
                funct3 = '100'
                funct6 = '011'
                funct2 = '00'
                imm_width = 0;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 3;
                decode, r1, r2, r3 = arithmetic_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs1_width,
                                                    rs2_width, imm_width)
                assert r1 == r2, "the rd must equal to rs1!"
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, '-', r2, r3))
            case 'srl':
                op = '01'
                funct3 = '100'
                funct6 = '111'
                funct2 = '10'
                imm_width = 0;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 3;
                decode, r1, r2, r3 = arithmetic_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs1_width,
                                                     rs2_width, imm_width)
                assert r1 == r2, "the rd must equal to rs1!"
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, imm, r1, '-'))

            case 'add':
                op = '10'
                funct3 = '100'
                funct6 = '1'
                funct2 = ''
                imm_width = 0;
                rd_width = 0;
                rs1_width = 5;
                rs2_width = 5;
                decode, r1, r2, r3 = arithmetic_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs1_width,
                                                    rs2_width, imm_width)
                assert r1 == r2, "the rd must equal to rs1!"
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, '-', r2, r3))
            case 'j':
                op = '01'
                funct3 = '101'
                funct6 = ''
                funct2 = ''
                imm_width = 11;
                rd_width = 0;
                rs1_width = 0;
                rs2_width = 0;
                decode, imm, _ = j_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs2_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, '-', '-'))
            case 'jal':
                op = '01'
                funct3 = '001'
                funct6 = ''
                funct2 = ''
                imm_width = 11;
                rd_width = 0;
                rs1_width = 1;
                rs2_width = 0;
                decode, imm, r1 = j_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs2_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, imm, '-', '-'))
            case 'jr':
                op = '10'
                funct3 = '100'
                funct6 = '0'
                funct2 = ''
                imm_width = 0;
                rd_width = 0;
                rs1_width = 5;
                rs2_width = 0;
                decode, r1, _ = j_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs2_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', '-', r1, '-'))
            case 'mv':
                op = '10'
                funct3 = '100'
                funct6 = '0'
                funct2 = ''
                imm_width = 0;
                rd_width = 0;
                rs1_width = 5;
                rs2_width = 5;
                decode, r1, r2 = j_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs2_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, '-', '-', r2))
            case 'ebreak':
                op = '10'
                funct3 = '100'
                funct6 = '1'
                funct2 = ''
                imm_width = 0;
                rd_width = 0;
                rs1_width = 0;
                rs2_width = 0;
                decode, _, _ = j_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs2_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', '-', '-', '-'))
            case 'beqz':
                op = '01'
                funct3 = '110'
                funct6 = ''
                funct2 = ''
                imm_width = 8;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, imm = branch_fmt(filter_code[i], funct3, op, rs1_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, r1, '-'))
            case 'bnez':
                op = '01'
                funct3 = '111'
                funct6 = ''
                funct2 = ''
                imm_width = 8;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, imm = branch_fmt(filter_code[i], funct3, op, rs1_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, r1, '-'))
            case 'bltz':
                op = '10'
                funct3 = '010'
                funct6 = ''
                funct2 = ''
                imm_width = 8;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, imm = branch_fmt(filter_code[i], funct3, op, rs1_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, r1, '-'))
            case 'addi4spn':
                op = '00'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                imm_width = 8;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, imm = addi4spn(filter_code[i], funct3, op, rs1_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, r1, '-'))
            case 'luih8':
                op = '01'
                funct3 = '010'
                funct6 = ''
                funct2 = ''
                imm_width = 8;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, imm = addi4spn(filter_code[i], funct3, op, rs1_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, r1, '-'))
            case 'luil8':
                op = '01'
                funct3 = '011'
                funct6 = ''
                funct2 = ''
                imm_width = 8;
                rd_width = 0;
                rs1_width = 3;
                rs2_width = 0;
                decode, r1, imm = addi4spn(filter_code[i], funct3, op, rs1_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, r1, '-'))
            case 'vmulsum':
                op = '11'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                funct7 = '0000'
                imm_width = 0;
                rd_width = 4;
                rs1_width = 4;
                rs2_width = 3;
                decode, rd, r2, r1 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, rd, '-', r1, r2))
            case 'fmsr':
                op = '11'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                funct7 = '0001'
                imm_width = 0;
                rd_width = 3;
                rs1_width = 3;
                rs2_width = 4;
                decode, rd, r2, r1 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, rd, '-', r1, r2))
            case 'vmac8':
                op = '11'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                funct7 = '0010'
                imm_width = 0;
                rd_width = 4;
                rs1_width = 4;
                rs2_width = 3;
                decode, rd, r2, r1 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, rd, '-', r1, r2))
            case 'max':
                op = '11'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                funct7 = '0011'
                imm_width = 0;
                rd_width = 4;
                rs1_width = 4;
                rs2_width = 3;
                decode, rd, r2, r1 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, rd, '-', r1, r2))
            case 'min':
                op = '11'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                funct7 = '0100'
                imm_width = 0;
                rd_width = 4;
                rs1_width = 4;
                rs2_width = 3;
                decode, rd, r2, r1 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, rd, '-', r1, r2))
            case 'addx':
                op = '11'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                funct7 = '0101'
                imm_width = 0;
                rd_width = 3;
                rs1_width = 3;
                rs2_width = 4;
                decode, rd, r2, r1 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, rd, '-', r1, r2))
            case 'subx':
                op = '11'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                funct7 = '0110'
                imm_width = 0;
                rd_width = 3;
                rs1_width = 3;
                rs2_width = 4;
                decode, rd, r2, r1 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, rd, '-', r1, r2))
            case 'skipadd':
                op = '11'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                funct7 = '0111'
                imm_width = 0;
                rd_width = 3;
                rs1_width = 3;
                rs2_width = 4;
                decode, rd, r2, r1 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, rd, '-', r1, r2))
            case 'mvx':
                op = '11'
                funct3 = '000'
                funct6 = ''
                funct2 = ''
                funct7 = '1000'
                imm_width = 0;
                rd_width = 4;
                rs1_width = 4;  #这里没错，rs2实际上表示的是rs1, 因为rs2没有多重索引
                rs2_width = 3;
                decode, rd, r2, r1 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, rd, '-', r1, r2))
            case 'fxmul':
                op = '11'
                funct3 = '001'
                funct6 = '0'
                funct2 = ''
                imm_width = 0;
                rd_width = 0;
                rs1_width = 5;
                rs2_width = 5;
                decode, r1, r2 = vector_fmt(filter_code[i], funct3, funct6, funct7, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, '-', r1, r2))
            case 'div':
                op = '11'
                funct3 = '001'
                funct6 = '1'
                funct2 = ''
                imm_width = 0;
                rd_width = 0;
                rs1_width = 5;
                rs2_width = 5;
                decode, r1, r2 = vector_fmt(filter_code[i], funct3, funct6, op, rd_width, rs1_width, rs2_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, r1, '-', r1, r2))
            case 'mvimmx4':
                op = '00'
                funct3 = '001'
                funct6 = ''
                funct2 = ''
                imm_width = 11;
                rd_width = 0;
                rs1_width = 0;
                rs2_width = 0;
                decode, imm, _ = j_fmt(filter_code[i], funct3, funct6, funct2, op, rs1_width, rs2_width, imm_width)
                decode_code.append(decode)
                if isdebug: print("{}, rd: {}, imm: {}, rs1: {}, rs2: {}".format(opname, '-', imm, '-', '-'))
            
            case default:
                print("Illegal instr! {}".format(filter_code[i]))
                raise('!')
    print(filter_code)
    print(decode_code)
    with open('testbin.bin', 'w') as f:
        for i in range(len(decode_code) - 1):
            f.write(decode_code[i] + '\n')
        f.write(decode_code[-1])

    print('Main irom start addr = {}'.format(label_dict['.MAIN']))
    print('IBB1 irom start addr = {}'.format(label_dict['.IBB1']))
    print('IBB2 irom start addr = {}'.format(label_dict['.IBB2']))
    print('IBB3 irom start addr = {}'.format(label_dict['.IBB3']))
    print('IBB4 irom start addr = {}'.format(label_dict['.IBB4']))
    print('AVGPOOL irom start addr = {}'.format(label_dict['.AVGPOOL']))
    print('LINEAR irom start addr = {}'.format(label_dict['.LINEAR']))

if __name__ == "__main__":
    a = 0xffff
    print(Uint2Sint(a, 16))
    asm2bin("basic_test.asm")
    print(int('0b10', 2))
    print(int('0b' + 128 * '1', 2))
    print(bin(int('0b' + 128 * '1', 2)))
    a = np.array([int('0b' + 128 * '1', 2)])
    print(a)

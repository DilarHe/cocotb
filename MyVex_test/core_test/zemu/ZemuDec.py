import logging

from ZemuISA import *

class ZEMUDecoder:
    def __init__(self):
        # 初始化日志器
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.INFO)  # 设置日志级别
        ch = logging.StreamHandler()  # 设置控制台输出
        ch.setLevel(logging.INFO)  # 设置日志级别
        formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')  # 日志格式
        ch.setFormatter(formatter)
        self.logger.addHandler(ch)
        
        # 预解析指令集的掩码和模式
        self.instructions = {
            name: pattern
            for name, pattern in BASE_INSTRUCTIONS.items()
        }
        self.imm_extractors = {
            "U": self.extract_imm_u,
            "I": self.extract_imm_i,
            "S": self.extract_imm_s,
            "B": self.extract_imm_b,
            "J": self.extract_imm_j,
            "Zicsr": self.extract_imm_zicsr,  # 如果需要 Zicsr-Type 立即数
        }
        self.dec_pool = {name: False for name in self.instructions}  # 初始化字典为 False
    def decode(self, instr, is_compressed,verbose=False):
        """解码指令并提取字段信息"""
        if is_compressed:
            instr = self.decompress(instr,verbose)  # 还原压缩指令
        if verbose : print('decode instr : {:08x}:'.format(instr))    
        for name, pattern in self.instructions.items():
            if self.match(instr,pattern) :
                
                self.dec_pool[name] = True  # 匹配的指令填为 True
                # 识别指令类型
                r_type_instr = {"ADD", "SUB" , "XOR"  , "OR", "AND", "SLL", "SRL", "SRA", "SLT", "SLTU",
                                "MUL", "MULH", "MULHSU", "MULHU", "DIV", "DIVU", "REM", "REMU",
                                "MRET",
                                "FMV.S.X", "FMV.X.S", "FADD.S", "FSUB.S", "FMUL.S", "FDIV.S", "FSQRT.S",
                                "FEQ.S", "FLT.S", "FLE.S", "FMIN.S", "FMAX.S",
                                "FCVT.W.S", "FCVT.WU.S", "FCVT.S.W", "FCVT.S.WU",
                                "FSGNJ.S" , "FSGNJN.S", "FSGNJX.S" , "FCLASS.S",
                                "FMADD.S", "FMSUB.S", "FNMSUB.S", "FNMADD.S"}
                i_type_instr = {  "ADDI", "XORI", "ORI" , "ANDI" , "SLLI", "SRLI", "SRAI", "SLTI", "SLTIU",
                                  "LB"  , "LH"  , "LW"  , "LBU"  ,  "LHU",
                                  "JALR", 
                                  "EBREAK", "ECALL" ,
                                  "FLW"}
                s_type_instr = { "SB", "SH", "SW", "FSW"}
                b_type_instr = { "BEQ", "BNE", "BLT", "BGE", "BLTU", "BGEU"}
                u_type_instr = { "LUI", "AUIPC"}
                csr_type_instr = { "CSRRW", "CSRRS", "CSRRC", "CSRRWI", "CSRRSI", "CSRRCI"}

                is_r_type = name in r_type_instr
                is_i_type = name in i_type_instr
                is_s_type = name in s_type_instr
                is_b_type = name in b_type_instr
                is_u_type = name in u_type_instr
                is_j_type = name == "JAL"
                is_csr_type = name in csr_type_instr
                # 设置默认值
                imm_type = None
                if is_u_type :
                    imm_type = "U"
                elif is_b_type :
                    imm_type = "B"
                elif is_i_type :
                    imm_type = "I"
                elif is_j_type :
                    imm_type = "J"
                elif is_s_type :
                    imm_type = "S"
                elif is_csr_type :
                    imm_type = "Zicsr"
                imm = None
                if not is_r_type :
                    if verbose : print('decode imm_type : ',imm_type)
                    imm = self.extract_imm(instr,imm_type)
                
                csr_addr = None
                if is_csr_type:
                    csr_addr = (instr >> 20) & 0xFFF

                instr_info = {
                    "name": name,
                    "compressed_instr": is_compressed ,  # 指令长度
                    "rd": (instr >> 7) & 0x1F,
                    "funct3": (instr >> 12) & 0x7,
                    "rs1": (instr >> 15) & 0x1F,
                    "rs2": (instr >> 20) & 0x1F,
                    "rs3": (instr >> 27) & 0x1F,
                    "funct7": (instr >> 25) & 0x7F,
                    "imm": imm,  # 立即数
                    "csr_addr": csr_addr,  # CSR 地址
                }
                self.logger.info(f'Decoder, instr_info : {instr_info}')
                return instr_info
        raise Exception(f"Unsupported instruction: {instr:08x}")
    
    def decompress(self,instr,verbose=False):
        """
        将压缩指令还原为标准 32 位指令。
        Args:
            instr (int): 16 位压缩指令。

        Returns:
            int: 还原后的 32 位指令。
        """
        instr_type = None
        for name, pattern in COMPRESS_INSTRUCTIONS.items():
            if self.match(instr,pattern) :
                # 返回instr name
                instr_type = name
                if verbose : print('match instr_type:',name)
                break
            
        rvc_dec_instr = 0
        rd = self.extract_bits(instr,11,7)
        c_rs1 = self.extract_bits(instr,9,7)
        c_rd = self.extract_bits(instr,4,2)
        match instr_type:
            case "ADDI4SPN":
                imm_5_4 = self.extract_bits(instr,12,11)
                imm_9_6 = self.extract_bits(instr,10,7)
                imm_2 = self.extract_bits(instr,6,6)
                imm_3 = self.extract_bits(instr,5,5)
                imm = (imm_9_6 << 6)|(imm_5_4 << 4)|(imm_3 << 3)|(imm_2 << 2)
                opcode = 0b0010011
                funct3 = 0b000
                rd = (0b01 << 3) | c_rd
                rvc_dec_instr = (imm << 20)|(2 << 15)|(rd << 7)|(funct3 << 12)|opcode
                return rvc_dec_instr
            case "LW":
                imm_6   = self.extract_bits(instr,5,5)
                imm_5_3 = self.extract_bits(instr,12,10)
                imm_2   = self.extract_bits(instr,6,6)
                imm     = (imm_6<<6)|(imm_5_3<<3)|(imm_2<<2) 
                opcode = 0b0000011
                funct3 = 0b010  
                rd = (0b01 << 3) | c_rd
                rs1 = (0b01 << 3) | c_rs1
                rvc_dec_instr = (imm << 20)|(rs1 << 15)|(rd << 7)|(funct3 << 12)|opcode
                return rvc_dec_instr
            case "SW":
                imm_11_5 = (self.extract_bits(instr,5,5)<<1)|self.extract_bits(instr,12,12)
                imm_4_0 = (self.extract_bits(instr,11,10)<<3)|(self.extract_bits(instr,6,6)<<2)
                rd = (0b01 << 3) | c_rd
                rs1 = (0b01 << 3) | c_rs1
                opcode = 0b0100011
                funct3 = 0b010  
                rvc_dec_instr = (imm_11_5 << 25)|(rd<<20)|(rs1 << 15)|(imm_4_0 << 7)|(funct3 << 12)|opcode
                return rvc_dec_instr
            case "NOP_ADDI":
                if self.extract_bits(instr,12,2) == 0b0: # c.nop
                    opcode = 0b0010011
                    rvc_dec_instr = opcode
                    return rvc_dec_instr
                elif self.extract_bits(instr,11,7) != 0b0:
                    imm_5_extended = self.sign_extend(self.extract_bits(instr,12,12), from_bits=1)
                    imm =(imm_5_extended<<5)|self.extract_bits(instr,6,2)
                    opcode = 0b0010011
                    funct3 = 0b000
                    rvc_dec_instr = (imm << 20)|(rd << 15)|(rd << 7)|(funct3 << 12)|opcode
                    return rvc_dec_instr
            case "JAL":
                imm_5 = self.extract_bits(instr,2,2)
                imm_3_1 = self.extract_bits(instr,5,3)
                imm_7 = self.extract_bits(instr,6,6)
                imm_6 = self.extract_bits(instr,7,7)
                imm_10 = self.extract_bits(instr,8,8)
                imm_9_8 = self.extract_bits(instr,10,9)
                imm_4 = self.extract_bits(instr,11,11)
                imm_11 = self.extract_bits(instr,12,12)
                imm_11_ext = self.sign_extend(imm_11,from_bits=1)
                imm = (imm_11_ext<<11)|(imm_10<<10)|(imm_9_8<<8)|(imm_7<<7)|(imm_6<<6)|(imm_5<<5)|(imm_4<<4)|(imm_3_1<<1)
                imm_19_12 = self.extract_bits(imm,19,12)
                imm_10_1 = self.extract_bits(imm,11,1)
                imm_20 = self.extract_bits(imm,20,20)
                opcode = 0b1101111
                rvc_dec_instr = (imm_20<<31)|(imm_10_1<<21)|(imm_11<<20)|(imm_19_12 << 12)|(0b1 << 7)|opcode
                return rvc_dec_instr
            case "LI":
                if rd != 0b0 :
                    imm_5 = self.extract_bits(instr,12,12)
                    imm_4_0 = self.extract_bits(instr,6,2)
                    # 符号扩展 imm[5]
                    imm_5_extended = self.sign_extend(imm_5, from_bits=1)
                    imm = (imm_5_extended<<5)|imm_4_0
                    opcode = 0b0010011
                    funct3 = 0b000
                    rvc_dec_instr = (imm << 20) | (rd << 7) | (funct3 << 12) | opcode
                    return rvc_dec_instr
            case "ADDI16SP_LUI":
                if rd != 0b0:
                    if rd == 0b10: # ADDI16SP
                        imm_5 = self.extract_bits(instr,2,2)
                        imm_8_7 = self.extract_bits(instr,4,3)
                        imm_6 = self.extract_bits(instr,5,5)
                        imm_4 = self.extract_bits(instr,6,6)
                        imm_9 = self.extract_bits(instr,12,12)
                        imm_9_ext = self.sign_extend(imm_9,from_bits=1)
                        imm = (imm_9_ext<<9)|(imm_8_7<<7)|(imm_6<<6)|(imm_5<<5)|(imm_4<<4)
                        opcode = 0b0010011
                        funct3 = 0b000
                        rvc_dec_instr = (imm << 20)|(rd << 15)|(rd << 7)|(funct3 << 12)|opcode
                        return rvc_dec_instr
                    else: # LUI
                        imm_16_12 = self.extract_bits(instr,6,2)
                        imm_17 = self.extract_bits(instr,12,12)
                        imm_17_ext = self.sign_extend(imm_17,from_bits=1)
                        opcode = 0b0110111
                        rvc_dec_instr = (self.extract_bits(imm_17_ext,15,0) << 17)|(imm_16_12 << 12)|(rd << 7)|opcode
                        return rvc_dec_instr
            case "SRLI":
                imm_4_0 = self.extract_bits(instr,6,2)
                imm = imm_4_0
                rs1 = (0b01 << 3) | c_rs1
                opcode = 0b0010011
                funct3 = 0b101
                rvc_dec_instr = (imm<<20)|(rs1<<15)|(rs1<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case "SRAI":
                imm_4_0 = self.extract_bits(instr,6,2)
                imm_11_5 = 0b0100000
                imm = (imm_11_5<<5)|imm_4_0
                rs1 = (0b01 << 3) | c_rs1
                opcode = 0b0010011
                funct3 = 0b101
                rvc_dec_instr = (imm<<20)|(rs1<<15)|(rs1<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case "ANDI":
                imm_4_0 = self.extract_bits(instr,6,2) 
                imm_11_5 = self.sign_extend(self.extract_bits(instr,12,12),from_bits=1) 
                imm = (imm_11_5<<5)|imm_4_0
                rs1 = (0b01 << 3) | c_rs1
                opcode = 0b0010011
                funct3 = 0b111
                rvc_dec_instr = (imm<<20)|(rs1<<15)|(rs1<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case "SUB":
                rs1 = (0b01 << 3) | c_rs1
                rd = (0b01 << 3) | c_rd
                opcode = 0b0110011
                funct3 = 0b000
                funct7 = 0b0100000
                rvc_dec_instr =  (funct7<<25)|(rd<<20)|(rs1<<15)|(rs1<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case "XOR":
                rs1 = (0b01 << 3) | c_rs1
                rd = (0b01 << 3) | c_rd
                opcode = 0b0110011
                funct3 = 0b100
                funct7 = 0b0000000
                rvc_dec_instr =  (funct7<<25)|(rd<<20)|(rs1<<15)|(rs1<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case "OR":
                rs1 = (0b01 << 3) | c_rs1
                rd = (0b01 << 3) | c_rd
                opcode = 0b0110011
                funct3 = 0b110
                funct7 = 0b0000000
                rvc_dec_instr =  (funct7<<25)|(rd<<20)|(rs1<<15)|(rs1<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case "AND":
                rs1 = (0b01 << 3) | c_rs1
                rd = (0b01 << 3) | c_rd
                opcode = 0b0110011
                funct3 = 0b111
                funct7 = 0b0000000
                rvc_dec_instr =  (funct7<<25)|(rd<<20)|(rs1<<15)|(rs1<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case "J":
                imm_5 = self.extract_bits(instr,2,2)
                imm_3_1 = self.extract_bits(instr,5,3)
                imm_7 = self.extract_bits(instr,6,6)
                imm_6 = self.extract_bits(instr,7,7)
                imm_10 = self.extract_bits(instr,8,8)
                imm_9_8 = self.extract_bits(instr,10,9)
                imm_4 = self.extract_bits(instr,11,11)
                imm_11 = self.extract_bits(instr,12,12)
                imm_11_ext = self.sign_extend(imm_11,from_bits=1)
                imm = (imm_11_ext<<11)|(imm_10<<10)|(imm_9_8<<8)|(imm_7<<7)|(imm_6<<6)|(imm_5<<5)|(imm_4<<4)|(imm_3_1<<1)
                imm_19_12 = self.extract_bits(imm,19,12)
                imm_10_1 = self.extract_bits(imm,11,1)
                imm_20 = self.extract_bits(imm,20,20)
                opcode = 0b1101111
                rvc_dec_instr = (imm_20<<31)|(imm_10_1<<21)|(imm_11<<20)|(imm_19_12 << 12)|(0b0 << 7)|opcode
                return rvc_dec_instr
            case "BEQZ":
                imm_5 = self.extract_bits(instr,2,2)
                imm_2_1 = self.extract_bits(instr,4,3)
                imm_7_6 = self.extract_bits(instr,6,5)
                imm_8 = self.extract_bits(instr,12,12)
                imm_8_ext = self.sign_extend(imm_8,from_bits=1)
                imm_4_3 = self.extract_bits(instr,11,10)
                imm = (imm_8_ext<<8)|(imm_7_6<<6)|(imm_5<<5)|(imm_4_3<<3)|(imm_2_1<<1)
                imm_11 = self.extract_bits(imm,11,11)
                imm_4_1 = self.extract_bits(imm,4,1)
                imm_10_5 = self.extract_bits(imm,10,5)
                imm_12 = self.extract_bits(imm,12,12)
                imm_4_1_11 = (imm_4_1<<1)|imm_11
                imm_12_10_5 = (imm_12<<6)|imm_10_5
                rs1 = (0b01 << 3) | c_rs1
                opcode = 0b1100011
                funct3 = 0b000
                rvc_dec_instr =  (imm_12_10_5<<25)|(0b0<<20)|(rs1<<15)|(imm_4_1_11<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case "BNEZ":
                imm_5 = self.extract_bits(instr,2,2)
                imm_2_1 = self.extract_bits(instr,4,3)
                imm_7_6 = self.extract_bits(instr,6,5)
                imm_8 = self.extract_bits(instr,12,12)
                imm_8_ext = self.sign_extend(imm_8,from_bits=1)
                imm_4_3 = self.extract_bits(instr,11,10)
                imm = (imm_8_ext<<8)|(imm_7_6<<6)|(imm_5<<5)|(imm_4_3<<3)|(imm_2_1<<1)
                imm_11 = self.extract_bits(imm,11,11)
                imm_4_1 = self.extract_bits(imm,4,1)
                imm_10_5 = self.extract_bits(imm,10,5)
                imm_12 = self.extract_bits(imm,12,12)
                imm_4_1_11 = (imm_4_1<<1)|imm_11
                imm_12_10_5 = (imm_12<<6)|imm_10_5
                rs1 = (0b01 << 3) | c_rs1
                opcode = 0b1100011
                funct3 = 0b001
                rvc_dec_instr =  (imm_12_10_5<<25)|(0b0<<20)|(rs1<<15)|(imm_4_1_11<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case "SLLI":
                if rd != 0 :
                    imm_4_0 = self.extract_bits(instr,6,2)
                    imm = imm_4_0
                    opcode = 0b0010011
                    funct3 = 0b001
                    rvc_dec_instr =  (imm<<20)|(rd<<15)|(rd<<7)|(funct3<<12)|opcode
                    return rvc_dec_instr
            case "LWSP":
                if rd != 0 :
                    imm_7_6 = self.extract_bits(instr,3,2)
                    imm_4_2 = self.extract_bits(instr,6,4)
                    imm_5 = self.extract_bits(instr,12,12)
                    imm = (imm_7_6<<6)|(imm_5<<5)|(imm_4_2<<2)
                    opcode = 0b0000011
                    funct3 = 0b010
                    rvc_dec_instr =  (imm<<20)|(0b10<<15)|(rd<<7)|(funct3<<12)|opcode
                    return rvc_dec_instr
                return rvc_dec_instr
            case "JR_MV":
                rs2 = self.extract_bits(instr,6,2)
                if rd != 0 :
                    if rs2 == 0 : # JR
                        opcode = 0b1100111
                        funct3 = 0b000 
                        rvc_dec_instr = (rd<<15)|(rs2<<7)|(funct3<<12)|opcode                
                        return rvc_dec_instr
                    else : # MV
                        opcode = 0b0110011
                        funct3 = 0b000 
                        rvc_dec_instr = (rs2<<20)|(0b0<<15)|(rd<<7)|(funct3<<12)|opcode 
                        return rvc_dec_instr
            case "EBREAK_JALR_ADD":
                rs2 = self.extract_bits(instr,6,2)
                if rd != 0 : # JALR | ADD
                    if rs2 == 0 : # JALR
                        opcode = 0b1100111
                        funct3 = 0b000 
                        rvc_dec_instr = (rd<<15)|(0b1<<7)|(funct3<<12)|opcode 
                        return rvc_dec_instr
                    else : # ADD
                        opcode = 0b0110011
                        funct3 = 0b000 
                        rvc_dec_instr = (rs2<<20)|(rd<<15)|(rd<<7)|(funct3<<12)|opcode 
                        return rvc_dec_instr
                else : # EBREAK
                    opcode = 0b1110011
                    rvc_dec_instr = (0b1<<20)|opcode 
                    return rvc_dec_instr
            case "SWSP":
                rs2 = self.extract_bits(instr,6,2)
                imm_5_2 = self.extract_bits(instr,12,9)
                imm_7_6 = self.extract_bits(instr,8,7)
                imm = (imm_7_6<<6)|(imm_5_2<<2)
                imm_4_0 = self.extract_bits(imm,4,0)
                imm_11_5 = self.extract_bits(imm,11,5)
                opcode = 0b0100011
                funct3 = 0b010  
                rvc_dec_instr =  (imm_11_5<<25)|(rs2<<20)|(0b10<<15)|(imm_4_0<<7)|(funct3<<12)|opcode
                return rvc_dec_instr
            case _:
                return 0
        return 0  # 默认返回无效指令
    
    # 立即数解析方法
    def extract_imm(self, instruction, imm_type):
        """
        统一立即数解析方法
        Args:
            instruction (int): 32 位指令
            imm_type (str): 立即数类型（"U", "I", "S", "B", "J", "Zicsr"）

        Returns:
            int: 解析后的立即数
        """
        if imm_type not in self.imm_extractors:
            raise ValueError(f"Unsupported immediate type: {imm_type}")
        return self.imm_extractors[imm_type](instruction)
    
    # 具体的立即数解析方法
    def extract_imm_u(self, instruction):
        """U-Type 立即数"""
        return (instruction & 0xFFFFF000)

    def extract_imm_i(self, instruction):
        """I-Type 立即数"""
        imm = (instruction >> 20) & 0xFFF
        return self.sign_extend(imm, 12)

    def extract_imm_s(self, instruction):
        """S-Type 立即数"""
        imm_11_5 = (instruction >> 25) & 0x7F
        imm_4_0 = (instruction >> 7) & 0x1F
        imm = (imm_11_5 << 5) | imm_4_0
        return self.sign_extend(imm, 12)

    def extract_imm_b(self, instruction):
        """B-Type 立即数"""
        imm_12 = (instruction >> 31) & 0x1
        imm_11 = (instruction >> 7) & 0x1
        imm_10_5 = (instruction >> 25) & 0x3F
        imm_4_1 = (instruction >> 8) & 0xF
        imm = (imm_12 << 12) | (imm_11 << 11) | (imm_10_5 << 5) | (imm_4_1 << 1)
        return self.sign_extend(imm, 13)

    def extract_imm_j(self, instruction):
        """J-Type 立即数"""
        imm_20 = (instruction >> 31) & 0x1
        imm_10_1 = (instruction >> 21) & 0x3FF
        imm_11 = (instruction >> 20) & 0x1
        imm_19_12 = (instruction >> 12) & 0xFF
        imm = (imm_20 << 20) | (imm_19_12 << 12) | (imm_11 << 11) | (imm_10_1 << 1)
        return self.sign_extend(imm, 21)

    def extract_imm_zicsr(self, instruction):
        """Zicsr-Type 立即数"""
        return (instruction >> 15) & 0x1F
    
    @staticmethod
    def match(instr, pattern):
        """
        使用直接位操作实现模糊匹配。
        Args:
            instr (int): 32 位指令（整数）。
            pattern (str): 模糊匹配字符串，例如 "0000000----------000-----0110011"。

        Returns:
            bool: 如果匹配则返回 True，否则返回 False。
        """
        mask = int(pattern.replace('0', '1').replace('-', '0').replace('1', '1'), 2)
        value = int(pattern.replace('-', '0'), 2)
        return (instr & mask) == value
    
    @staticmethod
    def extract_bits(instr, high, low):
        """
        提取指定位范围的值。
        Args:
            instr (int): 输入指令（整数）。
            high (int): 高位索引（包含）。
            low (int): 低位索引（包含）。

        Returns:
            int: 提取的位值。
        """
        mask = (1 << (high - low + 1)) - 1  # 创建掩码
        return (instr >> low) & mask  # 提取并返回位值
    
    @staticmethod
    def sign_extend(value, from_bits):
        """
        对值进行符号扩展。
        Args:
            value (int): 要扩展的值。
            from_bits (int): 原始值的位数。

        Returns:
            int: 符号扩展后的值。
        """
        sign_bit = 1 << (from_bits - 1)  # 符号位掩码
        return (value & (sign_bit - 1)) - (value & sign_bit)
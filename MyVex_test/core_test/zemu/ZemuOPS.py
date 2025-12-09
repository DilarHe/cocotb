import logging
from zemu.ZemuUOPS.arithmetic_ops import ArithmeticOps
from zemu.ZemuUOPS.load_store_ops import LoadStoreOps
from zemu.ZemuUOPS.branch_ops import BranchOps
from zemu.ZemuUOPS.multidiv_ops import MultiDivOps
from zemu.ZemuUOPS.zicsr_ops import ZicsrOps
from ZemuUOPS.fpu_ops import FPUOps

BASE_OPERATIONS_MAP = {
    "ADD"    : {"operation": "add",    "uses_imm": False},
    "SUB"    : {"operation": "sub",    "uses_imm": False},
    "XOR"    : {"operation": "xor",    "uses_imm": False},
    "OR"     : {"operation": "do_or",  "uses_imm": False},
    "AND"    : {"operation": "do_and", "uses_imm": False},
    "SLL"    : {"operation": "sll",    "uses_imm": False},
    "SRL"    : {"operation": "srl",    "uses_imm": False},
    "SRA"    : {"operation": "sra",    "uses_imm": False},
    "SLT"    : {"operation": "slt",    "uses_imm": False},
    "SLTU"   : {"operation": "sltu",   "uses_imm": False},
    "ADDI"   : {"operation": "add",    "uses_imm": True },
    "XORI"   : {"operation": "xor",    "uses_imm": True },
    "ORI"    : {"operation": "do_or",  "uses_imm": True },
    "ANDI"   : {"operation": "do_and", "uses_imm": True },
    "SLLI"   : {"operation": "sll",    "uses_imm": True },
    "SRLI"   : {"operation": "srl",    "uses_imm": True },
    "SRAI"   : {"operation": "sra",    "uses_imm": True },
    "SLTI"   : {"operation": "slt",    "uses_imm": True },
    "SLTIU"  : {"operation": "sltu",   "uses_imm": True },
    "LB"     : {"operation": "lb",     "uses_imm": True , "is_ldst": True},
    "LH"     : {"operation": "lh",     "uses_imm": True , "is_ldst": True},
    "LW"     : {"operation": "lw",     "uses_imm": True , "is_ldst": True},
    "LBU"    : {"operation": "lbu",    "uses_imm": True , "is_ldst": True},
    "LHU"    : {"operation": "lhu",    "uses_imm": True , "is_ldst": True},
    "SB"     : {"operation": "sb",     "uses_imm": True , "is_ldst": True},
    "SH"     : {"operation": "sh",     "uses_imm": True , "is_ldst": True},
    "SW"     : {"operation": "sw",     "uses_imm": True , "is_ldst": True},
    "BEQ"    : {"operation": "beq",    "uses_imm": True , "is_branch": True},
    "BNE"    : {"operation": "bne",    "uses_imm": True , "is_branch": True},
    "BLT"    : {"operation": "blt",    "uses_imm": True , "is_branch": True},
    "BGE"    : {"operation": "bge",    "uses_imm": True , "is_branch": True},
    "BLTU"   : {"operation": "bltu",    "uses_imm": True , "is_branch": True},
    "BGEU"   : {"operation": "bgeu",    "uses_imm": True , "is_branch": True},
    "JAL"    : {"operation": "jal",    "uses_imm": True , "is_branch": True},
    "JALR"   : {"operation": "jalr",   "uses_imm": True , "is_branch": True},
    "LUI"    : {"operation": "lui",    "uses_imm": True },
    "AUIPC"  : {"operation": "auipc",  "uses_imm": True },
}
SYSTEM_OPERATIONS_MAP = {
    "ECALL"  : {"operation": "ecall",  "uses_imm": False, "is_csr":True , "is_exception": True},
    "EBREAK" : {"operation": "ebreak", "uses_imm": False, "is_csr":True , "is_exception": True},
    "MRET"   : {"operation": "mret",   "uses_imm": False, "is_csr":True , "is_exception": True}
}
M_OPERATIONS_MAP = {
    # MULTI
    "MUL"    : {"operation": "mul",    "uses_imm": False},
    "MULH"   : {"operation": "mulh",   "uses_imm": False},
    "MULHSU" : {"operation": "mulhsu", "uses_imm": False},
    "MULHU"  : {"operation": "mulhu",  "uses_imm": False},
    "DIV"    : {"operation": "div",    "uses_imm": False},
    "DIVU"   : {"operation": "divu",   "uses_imm": False},
    "REM"    : {"operation": "rem",    "uses_imm": False},
    "REMU"   : {"operation": "remu",   "uses_imm": False}
}

ZICSR_OPERATIONS_MAP = {
    # ZICSR
    "CSRRW"  : {"operation": "csrrw",  "uses_imm": False , "is_csr":True },
    "CSRRS"  : {"operation": "csrrs",  "uses_imm": False , "is_csr":True },
    "CSRRC"  : {"operation": "csrrc",  "uses_imm": False , "is_csr":True },
    "CSRRWI" : {"operation": "csrrwi", "uses_imm": True  , "is_csr":True },
    "CSRRSI" : {"operation": "csrrsi", "uses_imm": True  , "is_csr":True },
    "CSRRCI" : {"operation": "csrrci", "uses_imm": True  , "is_csr":True }
}

F_OPERATIONS_MAP = {
    # 单精度运算
    "FADD.S"  : {"operation": "fadd_s",  "uses_imm": False , "is_freg" : True},
    "FSUB.S"  : {"operation": "fsub_s",  "uses_imm": False , "is_freg" : True},
    "FMUL.S"  : {"operation": "fmul_s",  "uses_imm": False , "is_freg" : True},
    "FDIV.S"  : {"operation": "fdiv_s",  "uses_imm": False , "is_freg" : True},
    "FSQRT.S" : {"operation": "fsqrt_s", "uses_imm": False , "is_freg" : True},

    # 浮点符号注入指令
    "FSGNJ.S" : {"operation": "fsgnj_s", "uses_imm": False , "is_freg" : True},
    "FSGNJN.S": {"operation": "fsgnjn_s", "uses_imm": False , "is_freg" : True},
    "FSGNJX.S": {"operation": "fsgnjx_s", "uses_imm": False , "is_freg" : True},
    
    # 浮点数据搬移
    "FMV.S.X" : {"operation": "fmv_s_x", "uses_imm": False , "is_freg" : True},
    "FMV.X.S" : {"operation": "fmv_x_s", "uses_imm": False , "is_freg" : True},

    # 单精度Load/Store
    "FLW"     : {"operation": "flw", "uses_imm": True, "is_freg": True, "is_ldst": True},
    "FSW"     : {"operation": "fsw", "uses_imm": True, "is_freg": True, "is_ldst": True},

    # 单精度比较
    "FEQ.S"   : {"operation": "feq_s",   "uses_imm": False, "is_freg": True},
    "FLT.S"   : {"operation": "flt_s",   "uses_imm": False, "is_freg": True},
    "FLE.S"   : {"operation": "fle_s",   "uses_imm": False, "is_freg": True},
    "FMIN.S"  : {"operation": "fmin_s",  "uses_imm": False, "is_freg": True},
    "FMAX.S"  : {"operation": "fmax_s",  "uses_imm": False, "is_freg": True},

    # 浮点和整数转换
    "FCVT.S.W"   : {"operation": "fcvt_s_w",   "uses_imm": False , "is_freg": True},
    "FCVT.S.WU"  : {"operation": "fcvt_s_wu",  "uses_imm": False , "is_freg": True},
    "FCVT.W.S"   : {"operation": "fcvt_w_s",   "uses_imm": False , "is_freg": True},
    "FCVT.WU.S"  : {"operation": "fcvt_wu_s",  "uses_imm": False , "is_freg": True},

    # 浮点融合乘加/乘减指令
    "FMADD.S" : {"operation": "fmadd_s", "uses_imm": False , "is_freg": True},
    "FMSUB.S" : {"operation": "fmsub_s", "uses_imm": False , "is_freg": True},
    "FNMSUB.S": {"operation": "fnmsub_s", "uses_imm": False , "is_freg": True},
    "FNMADD.S": {"operation": "fnmadd_s", "uses_imm": False , "is_freg": True},

    # 浮点分类
    "FCLASS.S" : {"operation": "fclass_s", "uses_imm": False , "is_freg": True}
}

BASE_OPERATIONS_MAP.update(SYSTEM_OPERATIONS_MAP)
BASE_OPERATIONS_MAP.update(M_OPERATIONS_MAP)
BASE_OPERATIONS_MAP.update(ZICSR_OPERATIONS_MAP)
BASE_OPERATIONS_MAP.update(F_OPERATIONS_MAP)

# ZYY RISC-V Emulator
class ZEMUOperators(ArithmeticOps, 
                    LoadStoreOps, 
                    BranchOps, 
                    MultiDivOps, 
                    ZicsrOps,
                    FPUOps): #表明继承
    def __init__(self):
        # 创建日志器
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.WARNING)
        ch = logging.StreamHandler()
        ch.setLevel(logging.WARNING)
        formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
        ch.setFormatter(formatter)
        self.logger.addHandler(ch)
        # 初始化外设地址检测
        self.mtime_value = 0x12345678  # 示例值
        self.mtimecmp_value = 0x87654321  # 示例值
        # 注册每种指令的操作方法
        ArithmeticOps.__init__(self)
        LoadStoreOps.__init__(self)
        BranchOps.__init__(self)
        MultiDivOps.__init__(self)
        ZicsrOps.__init__(self)
        
    # 定义每种指令的操作方法
    def sign_resize(self, value, bit_size=32):
        """
        执行符号位宽调整，将值扩展到指定的位数。    

        Args:
            value (int): 待扩展的值
            bit_size (int): 扩展后的目标位数（默认32位）    

        Returns:
            int: 扩展后的值
        """
        max_value = 2 ** (bit_size - 1)  # 最大值的正数部分 

        # 符号扩展
        if value >= max_value:
            value -= 2 ** bit_size  # 如果原值超出了正数范围，进行符号扩展  

        # 位宽截断：确保值符合指定的位宽
        mask = 2 ** bit_size - 1  # 动态生成位宽掩码
        return value & mask  # 确保返回的值符合 bit_size 位宽的限制

    def sign_extend(self, value, from_bits):
        """
        对值进行符号扩展。

        Args:
            value (int): 要扩展的值。
            from_bits (int): 原始值的位数。

        Returns:
            int: 符号扩展后的值，确保返回32位。
        """
        sign_bit = 1 << (from_bits - 1)  # 符号位掩码
        extended_value = (value & (sign_bit - 1)) - (value & sign_bit)

        return extended_value 
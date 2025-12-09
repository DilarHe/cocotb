import struct
import math
import ctypes

libm = ctypes.CDLL("libm.so.6")  # 可能路径不一样
libm.fma.restype = ctypes.c_double
libm.fma.argtypes = [ctypes.c_double, ctypes.c_double, ctypes.c_double]

def c_fma(a, b, c):
    return libm.fma(a, b, c)

class FPUOps:
    def fadd_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        # 将 f寄存器中的二进制内容转为float
        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        # 进行浮点加法
        result = f1 + f2
        # 再转回uint32的二进制存储到f寄存器
        fregs[rd] = self.float32_to_bits(result)
        return fregs , regs
    
    def fsub_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        # 将 f寄存器中的二进制内容转为float
        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        # 进行浮点减法
        result = f1 - f2
        # 再转回uint32的二进制存储到f寄存器
        fregs[rd] = self.float32_to_bits(result)
        return fregs, regs

    def fmul_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        # 将 f寄存器中的二进制内容转为float
        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        # 进行浮点乘法
        result = f1 * f2
        # 再转回uint32的二进制存储到f寄存器
        fregs[rd] = self.float32_to_bits(result)
        return fregs, regs
    
    def fdiv_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        # 将 f 寄存器中的二进制内容转为 float
        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        # 进行浮点除法
        result = f1 / f2
        # 再转回 uint32 的二进制存储到 f 寄存器
        fregs[rd] = self.float32_to_bits(result)
        return fregs, regs

    def fsqrt_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        # rs2 = instr_info["rs2"]  # 通常不用

        # 将 f 寄存器中的二进制内容转为 float
        f1 = self.bits_to_float32(fregs[rs1])
        # 进行浮点平方根运算
        result = math.sqrt(f1)
        # 再转回 uint32 的二进制存储到 f 寄存器
        fregs[rd] = self.float32_to_bits(result)
        return fregs, regs
    
    def feq_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        # 按IEEE754比较：等于且都不是NaN
        regs[rd] = int(f1 == f2 and not (math.isnan(f1) or math.isnan(f2)))
        return fregs, regs

    def flt_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        # 小于且都不是NaN
        regs[rd] = int(f1 < f2 and not (math.isnan(f1) or math.isnan(f2)))
        return fregs, regs

    def fle_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        # 小于等于且都不是NaN
        regs[rd] = int(f1 <= f2 and not (math.isnan(f1) or math.isnan(f2)))
        return fregs, regs
    
    def fmin_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])

        # 遇到NaN按RISC-V标准优先返回非NaN，两个都是NaN才返回NaN
        if math.isnan(f1) and math.isnan(f2):
            result = self.float32_to_bits(float('nan'))
        elif math.isnan(f1):
            result = fregs[rs2]
        elif math.isnan(f2):
            result = fregs[rs1]
        else:
            result = fregs[rs1] if f1 < f2 or (f1 == f2 and math.copysign(1.0, f1) < 0) else fregs[rs2]
            # copysign保证-0小于+0
        fregs[rd] = result
        return fregs, regs

    def fmax_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])

        # 遇到NaN按RISC-V标准优先返回非NaN，两个都是NaN才返回NaN
        if math.isnan(f1) and math.isnan(f2):
            result = self.float32_to_bits(float('nan'))
        elif math.isnan(f1):
            result = fregs[rs2]
        elif math.isnan(f2):
            result = fregs[rs1]
        else:
            result = fregs[rs1] if f1 > f2 or (f1 == f2 and math.copysign(1.0, f1) > 0) else fregs[rs2]
            # copysign保证+0大于-0
        fregs[rd] = result
        return fregs, regs

    # int32_t -> float (FCVT.S.W)
    def fcvt_s_w(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        # 从整数寄存器读取有符号int32
        i_val = self.sign_extend(regs[rs1], 32)
        f_val = float(i_val)
        fregs[rd] = self.float32_to_bits(f_val)
        return fregs, regs
    
    # uint32_t -> float (FCVT.S.WU)
    def fcvt_s_wu(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        # 直接无符号
        u_val = regs[rs1] & 0xFFFFFFFF
        f_val = float(u_val)
        fregs[rd] = self.float32_to_bits(f_val)
        return fregs, regs
    
    # float -> int32_t (FCVT.W.S)
    def fcvt_w_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        f_val = self.bits_to_float32(fregs[rs1])
        # RISC-V默认向零舍入
        int_val = int(f_val)
        regs[rd] = int_val & 0xFFFFFFFF
        return fregs, regs
    
    # float -> uint32_t (FCVT.WU.S)
    def fcvt_wu_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        f_val = self.bits_to_float32(fregs[rs1])
        if f_val < 0.0:
            uint_val = 0
        elif f_val > 0xFFFFFFFF:
            uint_val = 0xFFFFFFFF
        else:
            # RISC-V要求向零舍入（trunc），Python的int(f_val)就是trunc towards zero
            uint_val = int(f_val)
        regs[rd] = uint_val & 0xFFFFFFFF
        return fregs, regs

    def fsgnj_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        # rs1：保留数值部分（低31位），rs2：提供符号位（最高位）
        result = (fregs[rs1] & 0x7FFFFFFF) | (fregs[rs2] & 0x80000000)
        fregs[rd] = result
        return fregs, regs

    def fsgnjn_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        # rs2的符号位取反后作为新符号，其余按rs1数值
        result = (fregs[rs1] & 0x7FFFFFFF) | ((~fregs[rs2]) & 0x80000000)
        fregs[rd] = result
        return fregs, regs

    def fsgnjx_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        # 新符号位为 rs1和rs2的符号位异或
        sign = ((fregs[rs1] ^ fregs[rs2]) & 0x80000000)
        result = (fregs[rs1] & 0x7FFFFFFF) | sign
        fregs[rd] = result
        return fregs, regs

    def flw(self, pc, instr_info, uses_imm, regs, mem_base, mem, fregs):
        # 从指令信息中提取寄存器和立即数
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        imm = instr_info["imm"]

        # 计算目标地址
        byte_addr = regs[rs1] + imm
        word_addr = (byte_addr - mem_base) // 4  # 将字节地址转换为字地址

        # 边界检查，确保访问的内存地址在有效范围内
        if word_addr < 0 or word_addr >= mem.shape[0]:
            # 超出内存范围，打印警告，而不是抛出异常
            self.logger.warning(f"Memory access out of bounds: address {word_addr} (byte address {byte_addr})")
            # 可以选择不继续执行存储操作，或者将 `store_taken` 设置为 False 等
            return fregs, mem, byte_addr, word_addr, None

        # 访存地址正常开启保存标记
        store_taken = False
        # 将值存储到内存
        fregs[rd] = mem[word_addr] # 从内存加载到目标寄存器

        # 返回更新后的内存状态，byte_addr 和 word_addr
        return fregs, mem, byte_addr, word_addr , store_taken
    
    def fsw(self, pc, instr_info, uses_imm, regs, mem_base, mem, fregs):
        # 从指令信息中提取寄存器和立即数
        rs1 = instr_info["rs1"]      # 基址寄存器
        rs2 = instr_info["rs2"]      # 要存的浮点寄存器
        imm = instr_info["imm"]

        # 计算目标地址
        byte_addr = regs[rs1] + imm
        word_addr = (byte_addr - mem_base) // 4  # 字节转word地址（假设mem按word排列）

        # 边界检查
        if word_addr < 0 or word_addr >= mem.shape[0]:
            self.logger.warning(f"Memory store out of bounds: address {word_addr} (byte address {byte_addr})")
            store_taken = False
            return fregs, mem, byte_addr, word_addr, store_taken

        # 内存存储操作（将浮点寄存器内容存到内存）
        mem[word_addr] = fregs[rs2] & 0xFFFFFFFF   # 只存32位，防止意外高位污染
        store_taken = True

        return fregs, mem, byte_addr, word_addr, store_taken

    def fmv_s_x(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        # 将整数寄存器内容（原样32位）直接存到浮点寄存器
        fregs[rd] = regs[rs1] & 0xFFFFFFFF
        return fregs , regs

    def fmv_x_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        # 取f寄存器原始32位内容，存到整数寄存器
        regs[rd] = fregs[rs1] & 0xFFFFFFFF
        return fregs, regs

    def fclass_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        val = fregs[rs1] & 0xFFFFFFFF

        # 解析IEEE754格式
        sign     = (val >> 31) & 0x1
        exponent = (val >> 23) & 0xFF
        fraction = val & 0x7FFFFF

        result = 0

        if exponent == 0xFF:
            if fraction == 0:
                # Infinity
                if sign:
                    result |= 0x1   # bit 0: negative infinity
                else:
                    result |= 0x80  # bit 7: positive infinity
            else:
                if (fraction & (1 << 22)):
                    result |= 0x200   # bit 9: quiet NaN
                else:
                    result |= 0x100   # bit 8: signaling NaN
        elif exponent == 0x00:
            if fraction == 0:
                # Zero
                if sign:
                    result |= 0x8   # bit 3: negative zero
                else:
                    result |= 0x10  # bit 4: positive zero
            else:
                # Subnormal
                if sign:
                    result |= 0x4   # bit 2: negative subnormal
                else:
                    result |= 0x20  # bit 5: positive subnormal
        else:
            # Normal
            if sign:
                result |= 0x2   # bit 1: negative normal
            else:
                result |= 0x40  # bit 6: positive normal

        regs[rd] = result
        return fregs, regs

    def fmadd_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd  = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        rs3 = instr_info["rs3"]
        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        f3 = self.bits_to_float32(fregs[rs3])
        # 融合乘加
        # print(dir(math))
        result = c_fma(f1, f2, f3)  # 融合一次舍入
        fregs[rd] = self.float32_to_bits(result)
        return fregs, regs
    
    def fmsub_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd  = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        rs3 = instr_info["rs3"]
        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        f3 = self.bits_to_float32(fregs[rs3])
        # 融合乘减
        result = c_fma(f1, f2, -f3)
        fregs[rd] = self.float32_to_bits(result)
        return fregs, regs

    def fnmadd_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd  = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        rs3 = instr_info["rs3"]
        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        f3 = self.bits_to_float32(fregs[rs3])
        # 融合负乘加
        result = -c_fma(f1, f2, f3)
        fregs[rd] = self.float32_to_bits(result)
        return fregs, regs

    def fnmsub_s(self, pc, instr_info, uses_imm, regs, mem, fregs):
        rd  = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        rs3 = instr_info["rs3"]
        f1 = self.bits_to_float32(fregs[rs1])
        f2 = self.bits_to_float32(fregs[rs2])
        f3 = self.bits_to_float32(fregs[rs3])
        # 融合负乘减
        result = -c_fma(f1, f2, -f3)
        fregs[rd] = self.float32_to_bits(result)
        return fregs, regs

    @staticmethod
    def bits_to_float32(bits):
        """将32位int转为IEEE754 float"""
        return struct.unpack('!f', struct.pack('!I', bits & 0xFFFFFFFF))[0]

    @staticmethod
    def float32_to_bits(fval):
        """将IEEE754 float转为32位int"""
        return struct.unpack('!I', struct.pack('!f', fval))[0]

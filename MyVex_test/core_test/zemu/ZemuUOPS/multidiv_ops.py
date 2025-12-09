class MultiDivOps:
    def mul(self, pc, instr_info, uses_imm, regs, mem):
        
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        
        # 计算乘积
        product = regs[rs1] * regs[rs2]
        # 截取乘积的低32位并保存到 rd
        regs[rd] = product & 0xFFFFFFFF  # 只保留低32位
        return regs
    
    def mulh(self, pc, instr_info, uses_imm, regs, mem):
        
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        
        # 计算乘积
        product = self.sign_extend(regs[rs1],from_bits=32) * self.sign_extend(regs[rs2],from_bits=32)  
        # 截取乘积的高32位并保存到 rd
        regs[rd] = (product >> 32) & 0xFFFFFFFF
        
        return regs

    def mulhsu(self, pc, instr_info, uses_imm, regs, mem):
        
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        
        # 计算乘积
        product = self.sign_extend(regs[rs1],from_bits=32) * regs[rs2]

        # 截取乘积的高32位并保存到 rd
        regs[rd] = (product >> 32) & 0xFFFFFFFF
        
        return regs

    def mulhu(self, pc, instr_info, uses_imm, regs, mem):
        
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        
        # 确保 rs1 和 rs2 是无符号 32 位整数
        rs1_value = regs[rs1] & 0xFFFFFFFF
        rs2_value = regs[rs2] & 0xFFFFFFFF
        
        # 计算乘积
        product = rs1_value * rs2_value
        
        # 截取乘积的高32位并保存到 rd
        regs[rd] = (product >> 32) & 0xFFFFFFFF
        
        return regs
            
    def div(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        
        # 获取寄存器值
        dividend = regs[rs1]
        divisor = regs[rs2]
    
        # 处理除数为零的情况，通常返回最大值或进行特殊处理
        if divisor == 0:
            # 设定除数为0时的行为，可以设置为一个特殊值，或者根据需求进行其他处理
            regs[rd] = 0xFFFFFFFF  # 一般是返回-1，或者设置一个特殊值
        else:
            # 对有符号整数进行除法运算
            if (dividend == 0x80000000 and divisor == -1):
                # 处理溢出：RISC-V中-2^31 / -1 结果应该是溢出
                regs[rd] = 0x7FFFFFFF  # 对应于最大有符号值 (2^31 - 1)
            else:
                # 普通的符号除法
                regs[rd] = int(self.sign_extend(dividend,from_bits=32) / self.sign_extend(divisor,from_bits=32)) & 0xFFFFFFFF  # 除法运算（符号除法）
        return regs
    
    def divu(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        
        # 获取寄存器值
        dividend = regs[rs1]
        divisor = regs[rs2]
    
        # 无符号除法 (除数和被除数视为无符号整数)
        # 使用 & 0xFFFFFFFFFFFFFFFF 来模拟 64 位无符号整数，Python 本身不区分有符号和无符号整数
        if divisor == 0:
            # 除数为0，通常应该返回异常或处理（例如返回最大值）
            regs[rd] = 0xFFFFFFFF  # 这里假设为无符号最大值
        else:
            regs[rd] = (dividend & 0xFFFFFFFF) // (divisor & 0xFFFFFFFF)
    
        return regs
    
    def rem(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        # 获取 rs1 和 rs2 的值（有符号整数）
        dividend = self.sign_extend(regs[rs1], from_bits=32)
        divisor = self.sign_extend(regs[rs2], from_bits=32)

        # 计算余数
        if divisor == 0:
            # 如果除数为零，结果为被除数
            result = dividend
        else:
            # 手动计算截断商
            truncated_quotient = dividend // divisor
            if (dividend < 0) != (divisor < 0):  # 如果符号不同，结果需要调整
                truncated_quotient += 1

            # 计算余数
            result = dividend - truncated_quotient * divisor

        # 确保结果是有符号 32 位
        regs[rd] = result & 0xFFFFFFFF  # 32 位

        return regs

    def remu(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"] 

        # 获取 rs1 和 rs2 的值（无符号整数）
        dividend = regs[rs1] & 0xFFFFFFFF  # 无符号 32 位
        divisor = regs[rs2] & 0xFFFFFFFF  # 无符号 32 位    

        # 计算余数
        if divisor == 0:
            # 如果除数为零，结果为被除数
            result = dividend
        else:
            # 计算无符号余数
            result = dividend % divisor   

        # 确保结果是无符号 32 位
        regs[rd] = result & 0xFFFFFFFF    

        return regs
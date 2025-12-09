class ArithmeticOps:
    def add(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]
        # 执行 ADD 操作
        # rd = rs1 + rs2
        if uses_imm :
            result = regs[rs1] + imm
        else :
            result = regs[rs1] + regs[rs2]

        regs[rd] = self.sign_resize(result, 32)  # 对结果进行符号位宽调整
        
        return regs
            
    def sub(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]

        result = regs[rs1] - regs[rs2]
        regs[rd] = self.sign_resize(result, 32)  # 对结果进行符号位宽调整
        
        return regs
    
    def xor(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]

        if uses_imm :
            regs[rd] = regs[rs1] ^ (imm&0xFFFFFFFF) # 限制imm的位宽
        else :
            regs[rd] = regs[rs1] ^ regs[rs2]
        return regs

    def sll(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"] 
        
        # 确保立即数或 rs2 只取最低的5位
        shift_amount = imm & 0x1F if uses_imm else regs[rs2] & 0x1F

        regs[rd] = (regs[rs1] << shift_amount) & 0xFFFFFFFF # 只保留低32位 

        return regs 

    def srl(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]

        # 确保立即数或 rs2 只取最低的5位
        shift_amount = imm & 0x1F if uses_imm else regs[rs2] & 0x1F
        
        # 执行 SRLI 操作：将 rs1 逻辑右移立即数 imm 位
        # 对于负数，需要手动清除符号位并保证逻辑右移
        regs[rd] = (regs[rs1] & 0xFFFFFFFF) >> shift_amount  # 只保留低32位，避免符号扩展

        return regs

    def sra(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]

        # 确保立即数或 rs2 只取最低的5位
        shift_amount = imm & 0x1F if uses_imm else regs[rs2] & 0x1F
        
        # 检查符号位并执行算术右移
        if regs[rs1] & 0x80000000:  # 如果是负数（符号位为1）
            # 符号扩展：填充高位为 1
            regs[rd] = (regs[rs1] >> shift_amount) | (0xFFFFFFFF << (32 - shift_amount))
        else:
            # 正数：普通的算术右移
            regs[rd] = regs[rs1] >> shift_amount
            
        regs[rd] &= 0xFFFFFFFF
        
        return regs

    def slt(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]
    
        if uses_imm:
            # 有符号比较：rs1 和 imm
            regs[rd] = 1 if regs[rs1] < imm else 0
        else:
            # 有符号比较：rs1 和 rs2
            regs[rd] = 1 if regs[rs1] < regs[rs2] else 0
    
        return regs
    
    def sltu(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]
    
        if uses_imm:
            # 无符号比较：rs1 和 imm
            regs[rd] = 1 if (regs[rs1] & 0xFFFFFFFF) < (imm & 0xFFFFFFFF) else 0
        else:
            # 无符号比较：rs1 和 rs2
            regs[rd] = 1 if (regs[rs1] & 0xFFFFFFFF) < (regs[rs2] & 0xFFFFFFFF) else 0
    
        return regs
    
    
    def do_or(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]

        if uses_imm :
            regs[rd] = regs[rs1] | imm
        else :
            regs[rd] = regs[rs1] | regs[rs2]
        return regs

    def do_and(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]

        if uses_imm :
            regs[rd] = regs[rs1] & imm
        else :
            regs[rd] = regs[rs1] & regs[rs2]
        return regs

    def lui(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        # rs1 = instr_info["rs1"]
        imm = instr_info["imm"]
        result = imm
        regs[rd] = result  # 对结果进行符号位宽调整
        return regs
    
    def auipc(self, pc, instr_info, uses_imm, regs, mem):
        rd = instr_info["rd"]
        imm = instr_info["imm"]
        regs[rd] = pc + imm
        return regs

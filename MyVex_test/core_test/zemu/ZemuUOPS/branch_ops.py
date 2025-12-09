class BranchOps:
    def beq(self, pc, npc, instr_info, regs):
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]
        
        if regs[rs1] == regs[rs2] :
            new_pc = pc + imm    
            branch_taken = True
        else :
            new_pc = None
            branch_taken = False
            
        return branch_taken, new_pc, regs
    
    def bne(self, pc, npc, instr_info, regs):
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]
        
        if regs[rs1] != regs[rs2] :
            new_pc = pc + imm    
            branch_taken = True
        else :
            new_pc = None
            branch_taken = False
            
        return branch_taken, new_pc, regs
    
    def blt(self, pc, npc, instr_info, regs):
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]
        
        if self.sign_extend(regs[rs1],from_bits=32) < self.sign_extend(regs[rs2],from_bits=32) :
            new_pc = pc + imm    
            branch_taken = True
        else :
            new_pc = None
            branch_taken = False
            
        return branch_taken, new_pc, regs
    
    def bge(self, pc, npc, instr_info, regs):
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]
        
        if self.sign_extend(regs[rs1],from_bits=32) >= self.sign_extend(regs[rs2],from_bits=32) :
            new_pc = pc + imm    
            branch_taken = True
        else :
            new_pc = None
            branch_taken = False
            
        return branch_taken, new_pc, regs
    
    def bltu(self, pc, npc, instr_info, regs):
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]
        
        if regs[rs1] < regs[rs2] :
            new_pc = pc + imm    
            branch_taken = True
        else :
            new_pc = None
            branch_taken = False
            
        return branch_taken, new_pc, regs    

    def bgeu(self, pc, npc, instr_info, regs):
        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]
        
        if regs[rs1] >= regs[rs2] :
            new_pc = pc + imm    
            branch_taken = True
        else :
            new_pc = None
            branch_taken = False
            
        return branch_taken, new_pc, regs
        
    def jal(self, pc, npc, instr_info, regs):
        rd = instr_info["rd"]
        imm = instr_info["imm"]

        new_pc = pc + imm    
        branch_taken = True
        regs[rd] = npc
        
        return branch_taken, new_pc, regs
    
    def jalr(self, pc, npc, instr_info, regs):
        rs1 = instr_info["rs1"]
        rd = instr_info["rd"]
        imm = instr_info["imm"]

        new_pc = regs[rs1] + imm    
        branch_taken = True
        regs[rd] = npc
        
        return branch_taken, new_pc, regs

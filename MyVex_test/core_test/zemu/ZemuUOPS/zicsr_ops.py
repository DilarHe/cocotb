import logging
from ZemuISA import *  # 导入RISC-V相关常量

class ZicsrOps:
    def csrrw(self, pc, instr_info, regs, csrs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        csr_addr = instr_info["csr_addr"]   

        t = csrs[csr_addr]  # 先读出CSR原值 

        # 先把rs1写入CSR
        csrs[csr_addr] = regs[rs1]  

        # 把原CSR写回rd寄存器
        if rd != 0:
            regs[rd] = t    

        return regs, csrs, csr_addr

    def csrrs(self, pc, instr_info, regs, csrs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        csr_addr = instr_info["csr_addr"]
    
        t = csrs[csr_addr]   # 原始CSR值
        # 先把rs1写入CSR
        # if (rs1 != 0): CSR[csr] = t | x[rs1]
        if rs1 != 0:
            csrs[csr_addr] = t | regs[rs1]

        # x[rd] = t
        if rd != 0:
            regs[rd] = t

        return regs, csrs, csr_addr

    def csrrc(self, pc, instr_info, regs, csrs):
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        csr_addr = instr_info["csr_addr"]   

        t = csrs[csr_addr]
        # 先把rs1写入CSR
        if rs1 != 0:
            csrs[csr_addr] = t & (~regs[rs1])

        # 把原CSR写回rd寄存器
        if rd != 0:
            regs[rd] = t

        return regs, csrs, csr_addr


    def csrrwi(self, pc, instr_info, regs, csrs):
        rd = instr_info["rd"]
        imm = instr_info["imm"]
        csr_addr = instr_info["csr_addr"]

        t = csrs[csr_addr]
        csrs[csr_addr] = imm
        if rd != 0:
            regs[rd] = t
        return regs, csrs, csr_addr

    def csrrsi(self, pc, instr_info, regs, csrs):
        rd = instr_info["rd"]
        imm = instr_info["imm"]
        csr_addr = instr_info["csr_addr"]

        t = csrs[csr_addr]
        if rd != 0:
            regs[rd] = t
        if imm != 0:
            csrs[csr_addr] = t | imm
        return regs, csrs, csr_addr

    def csrrci(self, pc, instr_info, regs, csrs):
        rd = instr_info["rd"]
        imm = instr_info["imm"]
        csr_addr = instr_info["csr_addr"]

        t = csrs[csr_addr]
        if rd != 0:
            regs[rd] = t
        if imm != 0:
            csrs[csr_addr] = t & (~imm)
        return regs, csrs, csr_addr
    
    def ecall(self, pc, instr_info, regs, csrs):
        # 1. 保存pc到 mepc
        csrs[MEPC_ADDR] = pc          # mepc

        # 2. mcause = 11 (ecall from M-mode)
        csrs[MCAUSE_ADDR] = 11          # mcause

        # 3. mtval最低位标记是否压缩指令
        mtval = 0 if instr_info["compressed_instr"] else 1
        csrs[MTVAL_ADDR] = mtval

        # 4. mstatus 更新
        mstatus = csrs[MSTATUS_ADDR]
        # MPP = 3 (M-mode)
        mstatus = (mstatus & ~(0x3 << 11)) | (0x3 << 11)
        # MPIE = 当前MIE
        mie = (mstatus >> 3) & 1
        mstatus = (mstatus & ~(1 << 7)) | (mie << 7)
        # 关闭MIE
        mstatus = mstatus & ~(1 << 3)
        csrs[MSTATUS_ADDR] = mstatus

        # 5. 跳转到 mtvec handler（清零最低1位）
        new_pc = csrs[MTVEC_ADDR] & ~0x1

        print(f"ECALL trap: pc={pc:08x}, new_pc={new_pc:08x}, mstatus={mstatus:08x}")

        return regs, csrs, new_pc

    
    def ebreak(self, pc, instr_info, regs, csrs):
        # 1. 保存pc到 mepc
        csrs[MEPC_ADDR] = pc          # mepc

        # 2. mcause = 3
        csrs[MCAUSE_ADDR] = 3           # mcause, 3=breakpoint

        # 3. mtval最低位标记是否压缩指令
        mtval = 0 if instr_info["compressed_instr"] else 1
        csrs[MTVAL_ADDR] = mtval

        # 4. mstatus 更新
        mstatus = csrs[MSTATUS_ADDR]
        # 按RISC-V规范（简化，假设只有M特权级）:
        # MPP = 当前特权级（通常0=U, 1=S, 3=M），这里只处理M模式，设置为3
        mstatus = (mstatus & ~(0x3 << 11)) | (0x3 << 11)  # MPP[12:11]=11 (M-mode)
        # MPIE = 当前MIE（第3位）转存到7位
        mie = (mstatus >> 3) & 1
        mstatus = (mstatus & ~(1 << 7)) | (mie << 7)
        # 关闭MIE（置0）
        mstatus = mstatus & ~(1 << 3)
        csrs[MSTATUS_ADDR] = mstatus

        # 5. 跳转到 mtvec handler
        new_pc = csrs[MTVEC_ADDR] & ~0x1

        print(f"EBREAK trap: pc={pc:08x}, new_pc={new_pc:08x}, mstatus={mstatus:08x}")

        # 返回下一个PC/状态
        return regs, csrs, new_pc

    def mret(self, pc, instr_info, regs, csrs):
        # 1. 恢复 mstatus
        mstatus = csrs[MSTATUS_ADDR]
        # 恢复MIE: MIE = MPIE
        mpie = (mstatus >> 7) & 1
        mstatus = (mstatus & ~(1 << 3)) | (mpie << 3)
        # 恢复MPP为U-mode(0)，一般只支持M-mode可保留为3
        mstatus = mstatus & ~(0x3 << 11)  # MPP清零
        # MPIE 置1
        mstatus = mstatus | (1 << 7)
        csrs[MSTATUS_ADDR] = mstatus

        # 2. 跳转到 mepc
        new_pc = csrs[MEPC_ADDR] & ~0x1  # mepc，最低1位对齐清零

        print(f"MRET: return to pc={new_pc:08x}, mstatus={mstatus:08x}")
    
        return regs, csrs, new_pc

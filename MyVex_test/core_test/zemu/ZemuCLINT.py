import logging
from ZemuISA import *  # 导入RISC-V相关常量
from ZemuEX import ZEMUCSR  # 导入ZEMU执行器

def set_bit(val, bit, on=True):
        if on:
            return val | (1 << bit)
        else:
            return val & ~(1 << bit)
        
def get_bit(val, bit):
    return (val >> bit) & 1

# ZemuCLINT.py
class ZemuCLINT:
    def __init__(self):
        self.irq_occurred = False
        self.irq_new_pc = None

    # 主检测函数（带参数钩子，可扩展更多参数）
    def check_and_handle_irq(self, dut_timer_irq, 
                             curr_pc, next_pc, 
                             csrs,
                             branch_taken,
                             branch_pc):
        # 更新 mip.mtip
        mip_val = csrs[MIP_ADDR]
        mip_val = set_bit(mip_val, MTIP_BIT, dut_timer_irq)
        csrs[MIP_ADDR] = mip_val

        # 检查各状态
        mstatus = csrs[MSTATUS_ADDR]
        mie_bit = get_bit(mstatus, MIE_BIT)
        mie     = csrs[MIE_ADDR]
        mtie    = get_bit(mie, MTIE_BIT)
        mtip    = dut_timer_irq

        # 满足RISC-V触发Timer Interrupt的条件
        # 检查是否允许（可扩展 mie、mstatus 检查）
        self.irq_occurred = mtip and mie_bit and mtie
        # 这里只做简单demo
        if self.irq_occurred:
            # 可扩展做CSR自动写入/触发
            csrs[MCAUSE_ADDR] = (1 << 31) | 7  # 假设是mtime中断
            csrs[MSTATUS_ADDR] = set_bit(mstatus, MPIE_BIT, mie_bit)  # 保存当前MIE
            csrs[MSTATUS_ADDR] = set_bit(mstatus, MIE_BIT, False)  # 禁止中断
            if branch_taken:
                csrs[MEPC_ADDR] = branch_pc  # 设置异常PC为新PC地址
            else:
                csrs[MEPC_ADDR] = next_pc  # 设置异常PC为下一条指令地址
            mtvec_base = csrs[MTVEC_ADDR] & ~0x1  # 清除最低位，确保对齐
            # 设置新的PC地址为MTVEC地址加上偏移
            self.irq_new_pc = mtvec_base + 4 * 7  # 假设MTVEC指向的处理程序是第7个
            print(
                f'IRQ occur: TIMER={mtip}, mtvec_base={mtvec_base:#x}, IRQ_NEW_PC={self.irq_new_pc:#x}, curr_pc={curr_pc:#x}, next_pc={next_pc:#x}'
            )



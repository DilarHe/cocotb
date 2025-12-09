// File: MyVex_test/core_test/my_riscv_project/clib/tiny_system.c
#include "tiny_system.h"
#include "riscv_arch.h"
#include "sc_print.h"
#include <stdint.h>

// 读mtimectrl
uint32_t mtimectrl_read(void) {
    volatile uint32_t* mtime = (volatile uint32_t*)MTIMECTRL_BASE;
    return *mtime;
}

// 写mtimectrl
void mtimectrl_write(uint32_t enable, uint32_t div) {
    uint32_t val = (enable & MTIMECTRL_ENABLE_MASK) | ((div & MTIMECTRL_DIV_MASK) << MTIMECTRL_DIV_SHIFT);
    volatile uint32_t* mtime = (volatile uint32_t*)MTIMECTRL_BASE;
    *mtime = val;
}

// 读mtime
uint32_t mtime_read(void) {
    volatile uint32_t* mtime = (volatile uint32_t*)MTIME_BASE;
    return *mtime;
}

// 写mtime
void mtime_write(uint32_t val) {
    volatile uint32_t* mtime = (volatile uint32_t*)MTIME_BASE;
    *mtime = val;
}

// 读mtimecmp
uint32_t mtimecmp_read(void) {
    volatile uint32_t* mtimecmp = (volatile uint32_t*)MTIMECMP_BASE;
    return *mtimecmp;
}

// 写mtimecmp
void mtimecmp_write(uint32_t val) {
    volatile uint32_t* mtimecmp = (volatile uint32_t*)MTIMECMP_BASE;
    *mtimecmp = val;
}

void halt() {
    // 通过无限循环来模拟 halt
    while (1) {
        __asm__ volatile ("nop");  // 等待处理器循环
    }
}

// ====== 中断初始化及使能 ======

void interrupt_init(void) {
    // 全局使能 machine 中断
    set_csr(mstatus, MSTATUS_MIE); // MSTATUS_MIE
}

void enable_timer_interrupt(void) {
    set_csr(mie, MIE_MTIE);     // MIE_MTIE
}
void disable_timer_interrupt(void) {
    clear_csr(mie, MIE_MTIE);
}
void enable_software_interrupt(void) {
    set_csr(mie, MIE_MSIE);
}
void disable_software_interrupt(void) {
    clear_csr(mie, MIE_MSIE);
}


// ---- 系统调用 ----

void sys_ecall(int sys_id, int arg) {
    register int a7 __asm__("a7") = sys_id;
    register int a0 __asm__("a0") = arg;
    __asm__ volatile (
        "ecall"
        : "+r"(a0)
        : "r"(a7)
    );
}

void sys_ebreak(void) {
    __asm__ volatile ("ebreak");
}

void trap_handler_c(unsigned long mcause, unsigned long mepc, unsigned long mtval) {
    sc_printf("TRAP: mcause=0x%lx\n", mcause);
    if ((mcause & (1UL << (sizeof(long)*8-1))) == 0) {
        unsigned long code = mcause & 0xFFF;
        if (code == 11) {
            // ecall
            unsigned int instr_info = (unsigned int)mtval;
            if ((instr_info & 0x1) == 0x1) // instr_info 的最低位表示指令长度
                mepc += 4; // 32-bit
            else
                mepc += 2; // 16-bit
            __asm__ volatile ("csrw mepc, %0" :: "r"(mepc));
        } else if (code == 3) {
            // ebreak
            unsigned int instr_info = (unsigned int)mtval;
            if ((instr_info & 0x1) == 0x1) // instr_info 的最低位表示指令长度
                mepc += 4; // 32-bit
            else
                mepc += 2; // 16-bit
            __asm__ volatile ("csrw mepc, %0" :: "r"(mepc));
        }
        // 其它异常处理
    }
    // ...
}


void msoft_handler_c(void) {
    sc_printf("Machine Software Interrupt!\n");
    // 清pending等
}
void mtimer_handler_c(void) {
    sc_printf("Machine Timer Interrupt!\n");
    // 清pending: 软件通常只需要重新设置mtimecmp到下一个时间点
    uint32_t now = mtime_read();
    mtimecmp_write(now + 10000); // 举例：下一个定时周期
}
void mext_handler_c(void) {
    sc_printf("Machine External Interrupt!\n");
    // 读取外部中断源、清除等
}
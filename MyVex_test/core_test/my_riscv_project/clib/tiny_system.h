#include <stdint.h>
#ifndef TINY_SYSTEM_H
#define TINY_SYSTEM_H

#define MTIMECTRL_BASE         0x02000000 // 需要和VEC中MTIME_BASE一致
#define MTIMECTRL_SIZE         0x4
#define MTIMECTRL_ENABLE_MASK  0x1U
#define MTIMECTRL_DIV_SHIFT    1U
#define MTIMECTRL_DIV_MASK     (0x7FFFFFFFU) // 31位
#define MTIME_BASE          (MTIMECTRL_BASE + MTIMECTRL_SIZE)
#define MTIME_SIZE          0x4
#define MTIMECMP_BASE       (MTIME_BASE + MTIME_SIZE)
#define MTIMECMP_SIZE       0x4

uint32_t mtimectrl_read(void);
void     mtimectrl_write(uint32_t enable, uint32_t div);
uint32_t mtime_read(void);
void     mtime_write(uint32_t val);
uint32_t mtimecmp_read(void);
void     mtimecmp_write(uint32_t val);

void halt();
void interrupt_init(void);
void enable_timer_interrupt(void);
void disable_timer_interrupt(void);
void enable_software_interrupt(void);
void disable_software_interrupt(void);

void sys_ecall(int sys_id, int arg);
void sys_ebreak(void);

void trap_handler_c(unsigned long mcause, unsigned long mepc, unsigned long mtval);
void msoft_handler_c(void);
void mtimer_handler_c(void);
void mext_handler_c(void);

#endif // TINY_SYSTEM_H
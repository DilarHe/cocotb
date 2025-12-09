.globl _start
.globl main

.text
_start:
    # GPR复位：清零通用寄存器（x1 到 x31，x0 永远为 0）
    li t0, 0                  # 加载常数 0 到 t0
    mv ra, t0                 # x1: 返回地址寄存器（ra）
    mv s0, t0                 # x8: 帧指针（fp）
    mv s1, t0
    mv s2, t0
    mv s3, t0
    mv s4, t0
    mv s5, t0
    mv s6, t0
    mv s7, t0
    mv s8, t0
    mv s9, t0
    mv s10, t0
    mv s11, t0
    mv a0, t0
    mv a1, t0
    mv a2, t0
    mv a3, t0
    mv a4, t0
    mv a5, t0
    mv a6, t0
    mv a7, t0
    mv t1, t0
    mv t2, t0
    mv t3, t0
    mv t4, t0
    mv t5, t0
    mv t6, t0
    # 初始化堆栈指针 SP
    la sp, __stack_top        # 将堆栈顶部地址加载到 sp 寄存器中
    # 初始化 .bss 段
    la t0, _sbss              # t0 = .bss 段起始地址
    la t1, _ebss              # t1 = .bss 段结束地址
    bge t0, t1, .bss_done     # 如果 t0 >= t1，跳过清零
.bss_clear:
    sw zero, 0(t0)            # 将零存储到 .bss 的当前地址
    addi t0, t0, 4            # 移动到下一个 4 字节地址
    blt t0, t1, .bss_clear    # 如果 t0 < t1，继续清零
.bss_done:

    # ========【新增：设置mtvec为向量模式并指向向量表】========
    la   t0, vector_table             # vector_table为中断向量表基址
    li   t1, 1                        # 1 = vectored mode
    slli t1, t1, 0                    # MODE=1 (最低位)
    or   t0, t0, t1                   # base | 1
    csrw mtvec, t0

    # 跳转到 main 函数
    call main

.Lhalt:
    j .Lhalt

# ===================== 向量表及各中断Handler =====================

    .section .vectors, "ax"
    .balign 64                        # RISC-V推荐每槽64字节对齐
#为了使每个入口之间间隔为4B，这里直接使用jal x0
vector_table:
    jal x0, trap_entry             # 0: 所有异常（Exception）统一入口
    jal x0, default_handler        # 1: User Software Interrupt
    jal x0, default_handler        # 2: Supervisor Software Interrupt
    jal x0, msoft_handler          # 3: Machine Software Interrupt
    jal x0, default_handler        # 4: User Timer Interrupt
    jal x0, default_handler        # 5: Supervisor Timer Interrupt
    jal x0, default_handler        # 6: Reserved
    jal x0, mtimer_handler         # 7: Machine Timer Interrupt
    jal x0, default_handler        # 8: User External Interrupt
    jal x0, default_handler        # 9: Supervisor External Interrupt
    jal x0, default_handler        # 10: Reserved
    jal x0, mext_handler           # 11: Machine External Interrupt
    # 可以继续扩展 cause 12~N，通常只填default_handler或按需添加
    .balign 64

# =========== handler代码可以写在同文件或其它文件 ==========

    .globl trap_entry
trap_entry:
    addi sp, sp, -16         # 简单保护栈（如有C调用建议保存更多寄存器）
    sw ra, 0(sp)
    sw a0, 4(sp)
    csrr a0, mcause
    csrr a1, mepc
    csrr a2, mtval
    # 调用C trap处理函数，a0=mcause, a1=mepc, a2=mtval
    call trap_handler_c
    lw ra, 0(sp)
    lw a0, 4(sp)
    addi sp, sp, 16
    mret

    .globl msoft_handler
msoft_handler:
    addi sp, sp, -8
    sw ra, 0(sp)
    call msoft_handler_c
    lw ra, 0(sp)
    addi sp, sp, 8
    mret

    .globl mtimer_handler
mtimer_handler:
    addi sp, sp, -8
    sw ra, 0(sp)
    call mtimer_handler_c
    lw ra, 0(sp)
    addi sp, sp, 8
    mret

    .globl mext_handler
mext_handler:
    addi sp, sp, -8
    sw ra, 0(sp)
    call mext_handler_c
    lw ra, 0(sp)
    addi sp, sp, 8
    mret

default_handler:
    j default_handler

    
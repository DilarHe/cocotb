#include <stdint.h>
#include "virt_uart.h"
#include "sc_print.h"
#include "math.h"
#include "arch_test_util.h"
#include "tiny_system.h"
#include "riscv_arch.h"


// rodata: 定义只读数据
const char *hello = "Hello, RISC-V!\n";  // 这会放在 .rodata 段

// data: 定义已初始化的全局变量
uint32_t AA = 10;  // 这会放在 .data 段

// bss: 定义未初始化的全局变量
uint32_t my_bss_var0; // 未初始化的全局变量
uint32_t my_bss_var1; // 未初始化的全局变量


int main() {
    // 检查 bss 初始化
    if (my_bss_var0 != 0 || my_bss_var1 != 0) {
        // 如果变量未清零，说明 .bss 初始化失败
        while (1);
    }
    // 开始实行 AND、SUB、XOR、OR、AND 测试
    // test_arith(AA);
    // 开始实行 SLL SRL SRA SLT SLTU测试
    test_shift();
    // 开始实行 MUL、DIV 测试
    test_muldiv();
    // 立即数运算测试
    // test_imm();
    // 测试内存访问
    test_memory();
    // 测试分支指令
    test_branch();
    // zicsr 指令测试 
    // test_csr();
    // sysbreak 测试
    // sys_ebreak();
    // syscall 测试
    // sys_ecall(2, 3); // 这里的 sys_id 和 arg 可以根据需要修改
    // mtime 测试
    // test_mtime_interrupt();
    // 测试浮点加法
    // test_float_ops();
    // ========== end ==========
    // 插入一条 NOP 指令
    __asm__ volatile ("nop");
    // 测试UART
    uart_puts(hello);
    // 测试Terminal 打印，注意testbench仿真时间需要根据输出内容增加，不然会导致看不到输出！
    sc_printf("Hello world\n");
    // int sqrt_result = sqrt(9);
    // sc_printf("sqrt(%d) = %d\n", 9, sqrt_result);
    // sc_printf("value = %f\n", 3.1415926);
    // 模拟 halt
    halt();

    return 0;  // 这个返回值不会被使用，因为程序已 halt
}

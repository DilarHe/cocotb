#include "arch_test_util.h"
#include "tiny_system.h"
#include "riscv_arch.h"
#include "sc_print.h"

void test_arith(uint32_t AA) {
    int32_t a = 10, b = 20, add_result, sub_result, xor_result, or_result, and_result;
    add_result = a + b + AA; // 40 
    sub_result = add_result - b; // 20
    xor_result = a ^ sub_result; // 30
    or_result  = xor_result | sub_result; // 30
    and_result = or_result & add_result; // 8
    if (add_result != 40 || sub_result != 20 || xor_result != 30 || or_result != 30 || and_result != 8) {
        halt(); // 如果结果不符合预期，则调用 halt 函数
    }
}

void test_shift() {
    int32_t a = 8, b = 4, sub_result, xor_result, or_result, and_result, mul_result, div_result;
    uint32_t ua = 8, ub = 4;
    asm("sll %0, %1, %2" : "=r" (sub_result) : "r" (a), "r" (b));
    asm("srl %0, %1, %2" : "=r" (xor_result) : "r" (a), "r" (b));
    asm("sra %0, %1, %2" : "=r" (or_result)  : "r" (a), "r" (b));
    asm("slt %0, %1, %2" : "=r" (and_result): "r" (a), "r" (b));
    asm("sltu %0, %1, %2": "=r" (mul_result): "r" (ua), "r" (ub));
    asm("sltu %0, %1, %2": "=r" (div_result): "r" (ub), "r" (ua));
    // 可以根据需要添加校验
}

void test_imm() {
    int32_t a = 8, c = 15, add_result, xor_result, or_result, mul_result, and_result, div_result;
    uint32_t ua = 8;
    asm("xori %0, %1, %2" : "=r" (add_result) : "r" (a), "i" (4));
    asm("ori %0, %1, %2"  : "=r" (xor_result): "r" (a), "i" (4));
    asm("andi %0, %1, %2" : "=r" (or_result) : "r" (a), "i" (4));
    asm("xori %0, %1, %2" : "=r" (or_result) : "r" (ua), "i" (4));
    asm("ori %0, %1, %2"  : "=r" (and_result): "r" (ua), "i" (4));
    asm("andi %0, %1, %2" : "=r" (mul_result): "r" (ua), "i" (4));
    asm("xori %0, %1, %2" : "=r" (div_result): "r" (c), "i" (255));
    asm("slli %0, %1, %2" : "=r" (add_result): "r" (a), "i" (2));
    asm("srli %0, %1, %2" : "=r" (and_result): "r" (a), "i" (2));
    a = -8;
    asm("srai %0, %1, %2" : "=r" (mul_result): "r" (a), "i" (2));
    a = 8;
    asm("slti %0, %1, %2" : "=r" (add_result): "r" (a), "i" (15));
    asm("sltiu %0, %1, %2": "=r" (add_result): "r" (ua), "i" (15));
    // 可以根据需要添加校验
}

void test_memory() {
    char memory[32] = {0xFF, 0xF7, 0x01, 0x02, 0x00};
    short memory_half[16] = {0xFFFF, 0x7FFF, 0x0001, 0xFF00};
    int lb_result, lh_result, lhu_result;

    asm("lb %0, 0(%1)" : "=r" (lb_result) : "r" (&memory[0]));
    asm("lb %0, 1(%1)" : "=r" (lb_result) : "r" (&memory[1]));
    asm("lh %0, 0(%1)" : "=r" (lh_result) : "r" (&memory[0]));
    asm("lh %0, 2(%1)" : "=r" (lh_result) : "r" (&memory[2]));
    asm("lhu %0, 0(%1)": "=r" (lhu_result): "r" (&memory[0]));
    asm("lhu %0, 2(%1)": "=r" (lhu_result): "r" (&memory[2]));
    // 可以根据需要添加校验
}

void test_muldiv() {
    // 1. 基本 MULH/MULHSU/MULHU 测试（128位结果高32位）
    int32_t a = 0x12345678, b = 0x87654321;
    uint32_t ua = 0x12345678, ub = 0x87654321;

    int32_t mulh_result, mulhsu_result, mulhu_result;
    asm("mulh %0, %1, %2"   : "=r"(mulh_result)   : "r"(a), "r"(b));
    asm("mulhsu %0, %1, %2" : "=r"(mulhsu_result) : "r"(a), "r"(ub));
    asm("mulhu %0, %1, %2"  : "=r"(mulhu_result)  : "r"(ua), "r"(ub));
    // 这里只做调用，数值校验可用 printf 打印后人工或自动比对

    // 2. MUL 指令测试（低32位结果），简单数据校验
    a = -11; b = 7;
    int32_t mul_result;
    asm("mul %0, %1, %2" : "=r"(mul_result) : "r"(a), "r"(b));
    if (mul_result != a * b) halt();  // 简单断言
    a = 0x7fffffff; b = 2;
    asm("mul %0, %1, %2" : "=r"(mul_result) : "r"(a), "r"(b));
    if (mul_result != (a * b)) halt();

    // 3. DIV/DIVU 测试
    a = -10; b = 3;
    ua = 10; ub = 3;
    int32_t div_result, divu_result;
    asm("div %0, %1, %2"  : "=r"(div_result)  : "r"(a), "r"(b));
    asm("divu %0, %1, %2" : "=r"(divu_result) : "r"(ua), "r"(ub));
    if (div_result != (a / b)) halt();   // -10 / 3 == -3
    if (divu_result != (ua / ub)) halt(); // 10 / 3 == 3

    // 4. REM/REMU 测试
    int32_t rem_result, remu_result;
    asm("rem %0, %1, %2"  : "=r"(rem_result)  : "r"(a), "r"(b));
    asm("remu %0, %1, %2" : "=r"(remu_result) : "r"(ua), "r"(ub));
    if (rem_result != (a % b)) halt();   // -10 % 3 == -1
    if (remu_result != (ua % ub)) halt(); // 10 % 3 == 1

    // 5. 边界/特殊情况测试
    // 除数为0时，结果未定义（不同实现结果不同），这里不判断，只做调用
    a = 123; b = 0;
    asm("div %0, %1, %2"  : "=r"(div_result) : "r"(a), "r"(b));
    asm("rem %0, %1, %2"  : "=r"(rem_result) : "r"(a), "r"(b));

    ua = 123; ub = 0;
    asm("divu %0, %1, %2" : "=r"(divu_result) : "r"(ua), "r"(ub));
    asm("remu %0, %1, %2" : "=r"(remu_result) : "r"(ua), "r"(ub));

    // INT32_MIN / -1 溢出情况
    a = (int32_t)0x80000000; b = -1;
    asm("div %0, %1, %2"  : "=r"(div_result) : "r"(a), "r"(b));
    asm("rem %0, %1, %2"  : "=r"(rem_result) : "r"(a), "r"(b));
    // 结果未定义，不做断言

    // 6. 大数无符号乘除
    ua = 0xFFFFFFFE; ub = 2;
    asm("mul %0, %1, %2" : "=r"(mul_result) : "r"(ua), "r"(ub));
    if (mul_result != (int32_t)(ua * ub)) halt();

    asm("divu %0, %1, %2" : "=r"(divu_result) : "r"(ua), "r"(ub));
    asm("remu %0, %1, %2" : "=r"(remu_result) : "r"(ua), "r"(ub));
    if (divu_result != (ua / ub)) halt();
    if (remu_result != (ua % ub)) halt();

    // 7. 可选：打印测试结果用于人工核对
    // sc_printf("MUL/DIV/REM 指令测试通过\n");
}


void test_branch() {
    uint32_t ua = 10, ub = 20;
    asm(
        "bltu %0, %1, label_bltu\n"
        : : "r" (ua), "r" (ub)
    );
    asm(
        ".global label_bltu\n"
        "label_bltu:\n"
        "nop\n"
    );
    asm(
        "bgeu %0, %1, label_bgeu\n"
        : : "r" (ua), "r" (ub)
    );
    asm(
        ".global label_bgeu\n"
        "label_bgeu:\n"
        "nop\n"
    );
}

void test_csr() {
    // 1. 读 mstatus,请忽略报错 csrrs
    uint32_t old_mstatus = read_csr(mstatus); 
    // 2. 设置 MIE (Machine Interrupt Enable) 位 csrrsi
    set_csr(mstatus, MSTATUS_MIE);
    // 3. 清除 MIE 位 csrrci
    clear_csr(mstatus, MSTATUS_MIE);
    // 4. 原子交换 mstatus（写新值，返回旧值）csrrw
    uint32_t new_val = 0xA5A5A5A5;
    uint32_t swapped_val = swap_csr(mstatus, new_val);
    // 5. 恢复原始 mstatus
    write_csr(mstatus, old_mstatus);
    // 可加 sc_printf 打印
}

void test_float_ops() {
    uint32_t a = 0x40000000; // 2.0f (IEEE754)
    uint32_t b = 0x3f800000; // 1.0f (IEEE754)
    uint32_t res_add, res_sub, res_mul, res_div, res_sqrt, res_feq, res_flt, res_fle;

    // fadd.s: 2.0 + 1.0 = 3.0 (0x40400000)
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fadd.s f3, f1, f2\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_add], t2\n"
        : [res_add] "=r" (res_add)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t2", "f1", "f2", "f3"
    );

    // fsub.s: 2.0 - 1.0 = 1.0 (0x3f800000)
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fsub.s f3, f1, f2\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_sub], t2\n"
        : [res_sub] "=r" (res_sub)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t2", "f1", "f2", "f3"
    );

    // fmul.s: 2.0 * 1.0 = 2.0 (0x40000000)
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fmul.s f3, f1, f2\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_mul], t2\n"
        : [res_mul] "=r" (res_mul)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t2", "f1", "f2", "f3"
    );

    // fdiv.s: 2.0 / 1.0 = 2.0 (0x40000000)
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fdiv.s f3, f1, f2\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_div], t2\n"
        : [res_div] "=r" (res_div)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t2", "f1", "f2", "f3"
    );

    // fsqrt.s: sqrt(2.0) = 1.4142135... (0x3fb504f3)
    asm volatile (
        "mv t0, %[a]\n"
        "fmv.s.x f1, t0\n"
        "fsqrt.s f3, f1\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_sqrt], t2\n"
        : [res_sqrt] "=r" (res_sqrt)
        : [a] "r" (a)
        : "t0", "t2", "f1", "f3"
    );

    // FEQ.S: 2.0 == 1.0 ? 结果应为0
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "feq.s t3, f1, f2\n"    // t3 = (f1==f2)?1:0
        "mv %[res_feq], t3\n"
        : [res_feq] "=r" (res_feq)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t3", "f1", "f2"
    );

    // FLT.S: 2.0 < 1.0 ? 结果应为0
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "flt.s t3, f1, f2\n"    // t3 = (f1<f2)?1:0
        "mv %[res_flt], t3\n"
        : [res_flt] "=r" (res_flt)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t3", "f1", "f2"
    );

    // FLE.S: 2.0 <= 1.0 ? 结果应为0
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fle.s t3, f1, f2\n"    // t3 = (f1<=f2)?1:0
        "mv %[res_fle], t3\n"
        : [res_fle] "=r" (res_fle)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t3", "f1", "f2"
    );

    // FCVT.W.S: float → int32_t
    uint32_t float_ival = 0xc2f60000; // -123.0f in IEEE754
    int32_t res_fcvt_w_s;
    asm volatile (
        "mv t0, %[float_ival]\n"
        "fmv.s.x f1, t0\n"
        "fcvt.w.s t1, f1\n"
        "mv %[res_fcvt_w_s], t1\n"
        : [res_fcvt_w_s] "=r" (res_fcvt_w_s)
        : [float_ival] "r" (float_ival)
        : "t0", "t1", "f1"
    );

    // FCVT.WU.S: float → uint32_t
    // uint32_t float_uval = 0x42f60000; // 123.0f in IEEE754
    uint32_t float_uval = 0xc2f60000; // -123.0f in IEEE754
    uint32_t res_fcvt_wu_s;
    asm volatile (
        "mv t0, %[float_uval]\n"
        "fmv.s.x f1, t0\n"
        "fcvt.wu.s t1, f1\n"
        "mv %[res_fcvt_wu_s], t1\n"
        : [res_fcvt_wu_s] "=r" (res_fcvt_wu_s)
        : [float_uval] "r" (float_uval)
        : "t0", "t1", "f1"
    );

    float af = 1.5e9f;
    float bf = 5.0f;
    uint32_t res_ovf;

    asm volatile (
        "flw f1, %[a_addr]\n"
        "flw f2, %[b_addr]\n"
        "fmul.s f3, f1, f2\n"
        "fcvt.wu.s t1, f3\n"
        "mv %[res], t1\n"
        : [res] "=r" (res_ovf)
        : [a_addr] "m" (af), [b_addr] "m" (bf)
        : "t1", "f1", "f2", "f3"
    );
    
    // FCVT.S.W: int32_t → float
    int32_t val_w = -123;
    uint32_t res_fcvt_s_w;
    asm volatile (
        "mv t0, %[val_w]\n"
        "fcvt.s.w f1, t0\n"
        "fmv.x.s t1, f1\n"
        "mv %[res_fcvt_s_w], t1\n"
        : [res_fcvt_s_w] "=r" (res_fcvt_s_w)
        : [val_w] "r" (val_w)
        : "t0", "t1", "f1"
    );

    // FCVT.S.WU: uint32_t → float
    uint32_t val_wu = 123u;
    uint32_t res_fcvt_s_wu;
    asm volatile (
        "mv t0, %[val_wu]\n"
        "fcvt.s.wu f1, t0\n"
        "fmv.x.s t1, f1\n"
        "mv %[res_fcvt_s_wu], t1\n"
        : [res_fcvt_s_wu] "=r" (res_fcvt_s_wu)
        : [val_wu] "r" (val_wu)
        : "t0", "t1", "f1"
    );
    uint32_t res_sgnj, res_sgnjn, res_sgnjx;
    // FSGNJ.S: 结果应等于a本身（2.0f），因为b为正数
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fsgnj.s f3, f1, f2\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_sgnj], t2\n"
        : [res_sgnj] "=r" (res_sgnj)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t2", "f1", "f2", "f3"
    );

    // FSGNJN.S: 结果应等于a取负（-2.0f, 0xC0000000），因为b为正
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fsgnjn.s f3, f1, f2\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_sgnjn], t2\n"
        : [res_sgnjn] "=r" (res_sgnjn)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t2", "f1", "f2", "f3"
    );

    // FSGNJX.S: 结果等于a本身（2.0f），因同号符号异或为0
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fsgnjx.s f3, f1, f2\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_sgnjx], t2\n"
        : [res_sgnjx] "=r" (res_sgnjx)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t2", "f1", "f2", "f3"
    );

    uint32_t res_fmin, res_fmax;

    // FMIN.S: min(2.0f, 1.0f) = 1.0f (0x3f800000)
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fmin.s f3, f1, f2\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_fmin], t2\n"
        : [res_fmin] "=r" (res_fmin)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t2", "f1", "f2", "f3"
    );

    // FMAX.S: max(2.0f, 1.0f) = 2.0f (0x40000000)
    asm volatile (
        "mv t0, %[a]\n"
        "mv t1, %[b]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fmax.s f3, f1, f2\n"
        "fmv.x.s t2, f3\n"
        "mv %[res_fmax], t2\n"
        : [res_fmax] "=r" (res_fmax)
        : [a] "r" (a), [b] "r" (b)
        : "t0", "t1", "t2", "f1", "f2", "f3"
    );

    uint32_t nan_bits = 0x7fc00001; // canonical quiet NaN
    uint32_t res_fclass_nan;
    asm volatile (
        "mv t0, %[nan_bits]\n"
        "fmv.s.x f1, t0\n"
        "fclass.s t1, f1\n"
        "mv %[res_fclass_nan], t1\n"
        : [res_fclass_nan] "=r" (res_fclass_nan)
        : [nan_bits] "r" (nan_bits)
        : "t0", "t1", "f1"
    );
    uint32_t inf_bits = 0x7f800000;
    uint32_t res_fclass_inf;
    asm volatile (
        "mv t0, %[inf_bits]\n"
        "fmv.s.x f1, t0\n"
        "fclass.s t1, f1\n"
        "mv %[res_fclass_inf], t1\n"
        : [res_fclass_inf] "=r" (res_fclass_inf)
        : [inf_bits] "r" (inf_bits)
        : "t0", "t1", "f1"
    );

    uint32_t ma = 0x40000000;     // 2.0f
    uint32_t mb = 0x3f800000;     // 1.0f
    uint32_t mc = 0xc0800000;     // -4.0f
    uint32_t res_fmadd, res_fmsub, res_fnmadd, res_fnmsub;

    // FMADD.S: (2.0 * 1.0) + (-4.0) = -2.0 (0xc0000000)
    asm volatile (
        "mv t0, %[ma]\n"
        "mv t1, %[mb]\n"
        "mv t2, %[mc]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fmv.s.x f3, t2\n"
        "fmadd.s f4, f1, f2, f3\n"
        "fmv.x.s t3, f4\n"
        "mv %[res_fmadd], t3\n"
        : [res_fmadd] "=r" (res_fmadd)
        : [ma] "r" (ma), [mb] "r" (mb), [mc] "r" (mc)
        : "t0", "t1", "t2", "t3", "f1", "f2", "f3", "f4"
    );

    // FMSUB.S: (2.0 * 1.0) - (-4.0) = 6.0 (0x40c00000)
    asm volatile (
        "mv t0, %[ma]\n"
        "mv t1, %[mb]\n"
        "mv t2, %[mc]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fmv.s.x f3, t2\n"
        "fmsub.s f4, f1, f2, f3\n"
        "fmv.x.s t3, f4\n"
        "mv %[res_fmsub], t3\n"
        : [res_fmsub] "=r" (res_fmsub)
        : [ma] "r" (ma), [mb] "r" (mb), [mc] "r" (mc)
        : "t0", "t1", "t2", "t3", "f1", "f2", "f3", "f4"
    );

    // FNMADD.S: -(2.0 * 1.0 + (-4.0)) = 2.0 (0x40000000)
    asm volatile (
        "mv t0, %[ma]\n"
        "mv t1, %[mb]\n"
        "mv t2, %[mc]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fmv.s.x f3, t2\n"
        "fnmadd.s f4, f1, f2, f3\n"
        "fmv.x.s t3, f4\n"
        "mv %[res_fnmadd], t3\n"
        : [res_fnmadd] "=r" (res_fnmadd)
        : [ma] "r" (ma), [mb] "r" (mb), [mc] "r" (mc)
        : "t0", "t1", "t2", "t3", "f1", "f2", "f3", "f4"
    );

    // FNMSUB.S: -(2.0 * 1.0 - (-4.0)) = -6.0 (0xc0c00000)
    asm volatile (
        "mv t0, %[ma]\n"
        "mv t1, %[mb]\n"
        "mv t2, %[mc]\n"
        "fmv.s.x f1, t0\n"
        "fmv.s.x f2, t1\n"
        "fmv.s.x f3, t2\n"
        "fnmsub.s f4, f1, f2, f3\n"
        "fmv.x.s t3, f4\n"
        "mv %[res_fnmsub], t3\n"
        : [res_fnmsub] "=r" (res_fnmsub)
        : [ma] "r" (ma), [mb] "r" (mb), [mc] "r" (mc)
        : "t0", "t1", "t2", "t3", "f1", "f2", "f3", "f4"
    );

    // 为了节省时间先注释掉打印语句
    // union { uint32_t u; float f; } u_add = { .u = res_add };
    // union { uint32_t u; float f; } u_sub = { .u = res_sub };
    // union { uint32_t u; float f; } u_mul = { .u = res_mul };
    // union { uint32_t u; float f; } u_div = { .u = res_div };
    // union { uint32_t u; float f; } u_sqrt = { .u = res_sqrt };
    // sc_printf("fadd.s result(bits) = 0x%08x, result(float) = %f\n", res_add, u_add.f);
    // sc_printf("fsub.s result(bits) = 0x%08x, result(float) = %f\n", res_sub, u_sub.f);
    // sc_printf("fmul.s result(bits) = 0x%08x, result(float) = %f\n", res_mul, u_mul.f);
    // sc_printf("fdiv.s result(bits) = 0x%08x, result(float) = %f\n", res_div, u_div.f);
    // sc_printf("fsqrt.s result(bits) = 0x%08x, result(float) = %f\n", res_sqrt, u_sqrt.f);
}


void test_mtime_interrupt() {
    // mtime 测试
    interrupt_init(); // 初始化中断
    enable_timer_interrupt(); // 使能定时器中断
    mtimecmp_write(1000); // 设置 mtimecmp 为 1000
    mtimectrl_write(1,2); // 使能 mtime , 设置分频为4
}
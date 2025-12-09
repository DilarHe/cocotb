#include <stdint.h>
#ifndef ARCH_TEST_UTIL_H
#define ARCH_TEST_UTIL_H

extern void test_arith(uint32_t AA);
extern void test_shift();
extern void test_imm();
extern void test_memory();
extern void test_muldiv();
extern void test_branch();
extern void test_csr();
extern void test_mtime_interrupt();
extern void test_float_ops();

#endif // ARCH_TEST_UTIL_H
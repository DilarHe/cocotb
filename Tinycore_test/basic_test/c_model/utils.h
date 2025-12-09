
#include <stdint.h>

typedef union{
    int num;
    float fnum;
} S32F32;

int offset2(int s0, int i0, int i1);
int offset3(int s0, int s1, int i0, int i1, int i2);
int32_t round_divide(int32_t a, int32_t b, int right_shift);
int32_t round_divide_int64(int64_t x, int right_shift);

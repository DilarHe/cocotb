
#include "utils.h"
#include <math.h>

int offset2(int s0, int i0, int i1) { return i0 * s0 + i1; }

int offset3(int s0, int s1, int i0, int i1, int i2) { return i0 * s0 + i1 * s1 + i2; }

int is_even(double d)
{
    double int_part;
    modf(d / 2.0f, &int_part);
    return 2.0f * int_part == d;
}

int32_t round_divide_positive(int64_t x, int right_shift)
{
    int cond = (x & ((1ll << (right_shift + 1)) - 1)) == (1ll << (right_shift - 1)) ? 0 : 1;
    int32_t result = (x >> right_shift) + ((x >> (right_shift - 1) & 0x1) && cond);
    return result;
}

int32_t round_divide(int32_t a, int32_t b, int right_shift){
    int64_t ab = (int64_t)a * (int64_t)b;
    if(ab >= 0){
        return round_divide_positive(ab, right_shift);
    }
    else{
        return -round_divide_positive(-ab, right_shift);
    }
}

int32_t round_divide_int64(int64_t x, int right_shift){
    if(x > 0){
        return round_divide_positive(x, right_shift);
    }
    else{
        return -round_divide_positive(-x, right_shift);
    }
}



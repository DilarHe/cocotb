#include <stdint.h>
typedef struct{
    const int input_width;
    const int input_depth;
    const int8_t *filter_data;
    const int output_depth;
    const int filter_width;
    const int32_t *bias_data;
    const int stride_width;
    const int32_t output_offset;
    const int32_t output_multiplier;
    const int32_t output_shift;


} Qconv1d;

void conv1d_uint8(const uint8_t *input_data, const Qconv1d *layer, uint8_t *output_data);
void pointwiseconv1d_uint8(const uint8_t *input_data, int out_x_start, int out_x_end, const Qconv1d *layer, uint8_t *output_data);


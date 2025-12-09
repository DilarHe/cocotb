#include <stdint.h>

typedef struct{
    const int input_width;
    const int depth;
    const int8_t *filter_data;
    const int filter_width;
    const int32_t *bias_data;
    const int stride_width;
    const int32_t output_multiplier;
    const int output_shift;

} QDepthwiseConv1d;

void kws_depthwiseconv1d_uint8(const uint8_t *input_data,
                               const QDepthwiseConv1d *layer,
                               uint8_t *output_data);
void kws_depthwiseconv1d_partial_uint8(const uint8_t *input_data,
                                       const QDepthwiseConv1d *layer,
                                       uint8_t *output_data);
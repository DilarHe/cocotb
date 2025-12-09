#include "macro_def.h"
#include "qconv1d.h"
#include "utils.h"

void conv1d_uint8(const uint8_t *input_data, const Qconv1d *layer, uint8_t *output_data)
{
    const int input_depth = layer->input_depth;
    const int input_width = layer->input_width;
    const int output_depth = layer->output_depth;
    const int filter_width = layer->filter_width;
    const int pad_width = (filter_width - 1) / 2;
    const int stride_width = layer->stride_width;
    const int output_width = (input_width + pad_width - filter_width) / stride_width + 1;
    const int filter_s0 = filter_width * input_depth;
    const int32_t output_multiplier = layer->output_multiplier;
    const int output_shift = layer->output_shift;

    int filter_x, in_channel, in_x, in_x_origin, out_channel, out_x;
    int32_t acc, filter_val, input_val;

    for (out_x = 0; out_x < output_width; ++out_x)
    {
        for (out_channel = 0; out_channel < output_depth; ++out_channel)
        {
            in_x_origin = out_x * stride_width - pad_width;
            acc = 0;
            for (filter_x = 0; filter_x < filter_width; ++filter_x)
            {
                for (in_channel = 0; in_channel < input_depth; ++in_channel)
                {
                    in_x =
                        in_x_origin + filter_x;
                    if (in_x >= 0 && in_x < input_width)
                    {
                        input_val = input_data[offset2(input_depth, in_x, in_channel)];
                        filter_val = layer->filter_data[offset3(filter_s0, input_depth, out_channel, filter_x, in_channel)];
                        acc += input_val * filter_val;
                    }
                }
            }

            if (pad_width == 1)
            {
                if (in_x_origin < 0)
                {
                    acc += layer->bias_data[out_channel];
                }
                else if (in_x_origin + filter_width - 1 == input_width)
                {
                    acc += layer->bias_data[2 * output_depth + out_channel];
                }
                else
                {
                    acc += layer->bias_data[output_depth + out_channel];
                }
            }
            else
            {
                acc += layer->bias_data[out_channel];
            }
            acc = round_divide(acc, output_multiplier, output_shift);
            acc += layer->output_offset;
            acc = kws_max(acc, KWS_MIN_VAL);
            acc = kws_min(acc, KWS_MAX_VAL);
            output_data[offset2(output_depth, out_x, out_channel)] = (uint8_t)acc;
        }
    }
}
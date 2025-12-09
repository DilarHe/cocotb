#include "qdepthwiseconv1d.h"
#include "macro_def.h"
#include "utils.h"

void kws_depthwiseconv1d_uint8(const uint8_t *input_data,
                               const QDepthwiseConv1d *layer,
                               uint8_t *output_data){
    const int depth = layer->depth;
    const int input_width = layer->input_width;
    const int filter_width = layer->filter_width;
    const int stride_width = layer->stride_width;
    const int pad_width = (filter_width - 1) / 2;
    const int output_width = (input_width + 2*pad_width - filter_width) / stride_width + 1;
    const int filter_s0 = filter_width * depth;
    const int32_t output_multiplier = layer->output_multiplier;
    const int output_shift = layer->output_shift;

    int out_x, ic, in_x_origin, filter_x, in_x;
    int32_t acc, input_val, filter_val;

    for(out_x = 0; out_x < output_width; ++out_x){
        for(ic=0; ic < depth; ++ic){
            in_x_origin = out_x * stride_width - pad_width;
            acc = 0;
            for(filter_x = 0; filter_x < filter_width; ++filter_x){
                in_x = in_x_origin + filter_width;
                if(in_x >= 0 && in_x < input_width){
                    input_val = input_data[offset2(depth, in_x, ic)];
                    filter_val = layer->filter_data[offset3(filter_s0, depth, 0, filter_x, ic)];   
                    acc += input_val * filter_val;               
                }
            }
            acc += layer->bias_data[ic];
            acc = round_divide(acc, output_multiplier, output_shift);
            acc = kws_max(acc, KWS_MIN_VAL);
            acc = kws_min(acc, KWS_MAX_VAL);
            output_data[offset2(depth, out_x, ic)] = (uint8_t)acc;
        }
    }
}


void kws_depthwiseconv1d_partial_uint8(const uint8_t *input_data,
                                       const QDepthwiseConv1d *layer,
                                       uint8_t *output_data)
{
    const int depth = layer->depth;
    const int filter_width = layer->filter_width;
    const int32_t output_multiplier = layer->output_multiplier;
    const int output_shift = layer->output_shift;

    int ic, filter_x;
    int32_t acc, input_val, filter_val;
    for(ic=0; ic<depth; ++ic){
        acc = 0;
        for(filter_x=0; filter_x<filter_width; ++filter_x){ 
            input_val = input_data[offset2(depth, filter_x, ic)];
            filter_val = layer->filter_data[offset2(depth, filter_x, ic)];
            acc += filter_val * input_val;
        }
        acc += layer->bias_data[ic];
        acc = round_divide(acc, output_multiplier, output_shift);
        acc = kws_max(acc, KWS_MIN_VAL);
        acc = kws_min(acc, KWS_MAX_VAL);
        output_data[ic] =  (uint8_t)acc;
        }
}
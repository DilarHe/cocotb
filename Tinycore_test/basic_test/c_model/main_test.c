#include <stdio.h>
#include "macro_def.h"
#include <stdlib.h>
#include "qconv1d.h"

void load_fmap( char *path, uint8_t *f, int data_num){
    FILE *fin;
	int i;
    if((fin=fopen(path,"r"))==NULL) 
	{
		printf("can not open data file\n");
		exit(0);
	}
//读入
    uint32_t tmp;
 	for (i=0;i<data_num;i++)
    {
        fscanf(fin,"%u",&tmp);
        f[i]=(uint8_t)tmp;
    }
}
void load_weight( char *path, int8_t *w, int data_num){
    FILE *fin;
	int i;
    if((fin=fopen(path,"r"))==NULL) 
	{
		printf("can not open data file\n");
		exit(0);
	}
    int32_t tmp;
 	for (i=0;i<data_num;i++)
    {
        fscanf(fin,"%d",&tmp);
        w[i]=(int8_t)tmp;
    }
}
void load_bias( char *path, int32_t *b, int data_num){
    FILE *fin;
	int i;
    if((fin=fopen(path,"r"))==NULL) 
	{
		printf("can not open data file\n");
		exit(0);
	}
 	for (i=0;i<data_num;i++)
    {
        fscanf(fin,"%d",&b[i]);
    }
}
void load_quant( char *path, int32_t *q, int data_num){
    FILE *fin;
	int i;
    if((fin=fopen(path,"r"))==NULL) 
	{
		printf("can not open data file\n");
		exit(0);
	}
 	for (i=0;i<data_num;i++)
    {
        fscanf(fin,"%d",&q[i]);
    }
}
int main() {
    // Write C code here
    printf("Hello world\n");

    
    uint8_t fbank[FBANK_WIDTH*FBANK_CHANNEL];
    uint8_t conv00_out[60*16];

    int8_t conv00_w[16*3*32];
    int32_t conv00_b[16];
    int32_t conv00_q[3];
	
    load_fmap("../data/conv00_fmapin.txt", fbank, FBANK_WIDTH*FBANK_CHANNEL);
    load_weight("../data/conv00_w.txt", conv00_w, 16*3*32);
    load_bias( "../data/conv00_b.txt", conv00_b, 16);
    load_quant( "../data/conv00_q.txt", conv00_q, 3);
    int i;

    for (i=0;i<FBANK_WIDTH*FBANK_CHANNEL;i++)
    {
	    printf("%u\n",fbank[i]); 
    }
    Qconv1d conv00_layer = {.input_width=60, .input_depth=32, .filter_data=conv00_w, .output_depth=16, .filter_width=3, 
                            .bias_data=conv00_b, .stride_width=1, .output_offset=conv00_q[0], .output_multiplier=conv00_q[1], .output_shift=conv00_q[2]};
    // const int input_width;
    // const int input_depth;
    // const int8_t *filter_data;
    // const int output_depth;
    // const int filter_width;
    // const int32_t *bias_data;
    // const int stride_width;
    // const int32_t output_offset;
    // const int32_t output_multiplier;
    // const int32_t output_shift;

    conv1d_uint8( fbank , &conv00_layer, conv00_out);



    return 0;

}
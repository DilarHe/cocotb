// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : core_stack_regfile
// Git hash  : 64a8a01180c8b78a22afff4458f6a364a04ce1c3

`timescale 1ns/1ps

module core_stack_regfile (
  input               lowBandWidth_mem_rd,
  input               lowBandWidth_mem_wr,
  input      [6:0]    lowBandWidth_mem_addr,
  input      [31:0]   lowBandWidth_mem_wdata,
  output     [31:0]   lowBandWidth_mem_rdata,
  input               rg_kws_nn_nn_en,
  input      [7:0]    rg_kws_nn_score_thre_0,
  input      [7:0]    rg_kws_nn_score_thre_1,
  input      [7:0]    rg_kws_nn_score_thre_2,
  input      [7:0]    rg_kws_nn_score_thre_3,
  input      [7:0]    rg_kws_nn_score_thre_4,
  input      [7:0]    rg_kws_nn_score_thre_5,
  input      [7:0]    rg_kws_nn_score_thre_6,
  input      [7:0]    rg_kws_nn_block_num_0,
  input      [7:0]    rg_kws_nn_block_num_1,
  input      [7:0]    rg_kws_nn_eva_num_0,
  input      [7:0]    rg_kws_nn_eva_num_1,
  input               rg_kws_nn_debug_en,
  input      [10:0]   rg_kws_nn_nn_break_point,
  output     [31:0]   ro_stack_0,
  output     [31:0]   ro_stack_1,
  output     [31:0]   ro_stack_2,
  output     [31:0]   ro_stack_3,
  output     [31:0]   ro_stack_4,
  output     [31:0]   ro_stack_5,
  output     [31:0]   ro_stack_6,
  output     [31:0]   ro_stack_7,
  output     [31:0]   ro_stack_8,
  output     [31:0]   ro_stack_9,
  output     [31:0]   ro_stack_10,
  output     [31:0]   ro_stack_11,
  output     [31:0]   ro_stack_12,
  output     [31:0]   ro_stack_13,
  output     [31:0]   ro_stack_14,
  output     [31:0]   ro_stack_15,
  output     [31:0]   ro_stack_16,
  output     [31:0]   ro_stack_17,
  output     [31:0]   ro_stack_18,
  output     [31:0]   ro_stack_19,
  output     [31:0]   ro_stack_20,
  output     [31:0]   ro_stack_21,
  output     [31:0]   ro_stack_22,
  output     [31:0]   ro_stack_23,
  output     [31:0]   ro_stack_24,
  output     [31:0]   ro_stack_25,
  output     [31:0]   ro_stack_26,
  output     [31:0]   ro_stack_27,
  output     [31:0]   ro_stack_28,
  output     [31:0]   ro_stack_29,
  output     [31:0]   ro_stack_30,
  output     [31:0]   ro_stack_31,
  output     [31:0]   ro_stack_32,
  output     [31:0]   ro_stack_33,
  output     [31:0]   ro_stack_34,
  output     [31:0]   ro_stack_35,
  output     [31:0]   ro_stack_36,
  output     [31:0]   ro_stack_37,
  output     [31:0]   ro_stack_38,
  output     [31:0]   ro_stack_39,
  output     [31:0]   ro_stack_40,
  output     [31:0]   ro_stack_41,
  output     [31:0]   ro_stack_42,
  output     [31:0]   ro_stack_43,
  output     [31:0]   ro_stack_44,
  output     [31:0]   ro_stack_45,
  output     [31:0]   ro_stack_46,
  output     [31:0]   ro_stack_47,
  output     [31:0]   ro_stack_48,
  output     [31:0]   ro_stack_49,
  output     [31:0]   ro_stack_50,
  output     [31:0]   ro_stack_51,
  output     [31:0]   ro_stack_52,
  output     [31:0]   ro_stack_53,
  input               clk,
  input               resetn
);

  wire       [3:0]    tmp_kws_output;
  wire       [7:0]    tmp_rdata;
  wire       [7:0]    tmp_rdata_1;
  wire       [7:0]    tmp_rdata_2;
  wire       [7:0]    tmp_rdata_3;
  wire       [7:0]    tmp_rdata_4;
  wire       [7:0]    tmp_rdata_5;
  wire       [7:0]    tmp_rdata_6;
  wire       [7:0]    tmp_rdata_7;
  wire       [7:0]    tmp_rdata_8;
  wire       [7:0]    tmp_rdata_9;
  wire       [7:0]    tmp_rdata_10;
  wire       [7:0]    tmp_ro_stack_43;
  wire       [7:0]    tmp_ro_stack_44;
  wire       [7:0]    tmp_ro_stack_45;
  wire       [7:0]    tmp_ro_stack_46;
  wire       [7:0]    tmp_ro_stack_47;
  wire       [7:0]    tmp_ro_stack_48;
  wire       [7:0]    tmp_ro_stack_49;
  wire       [7:0]    tmp_ro_stack_50;
  wire       [7:0]    tmp_ro_stack_51;
  wire       [7:0]    tmp_ro_stack_52;
  wire       [7:0]    tmp_ro_stack_53;
  reg        [10:0]   conv1_ifmap_p;
  reg        [10:0]   conv1_ofmap_p;
  reg        [10:0]   conv1_filter_p;
  reg        [10:0]   conv1_bias_p;
  reg        [10:0]   conv1_quant_p;
  reg        [7:0]    conv1_inner_cnt;
  reg        [7:0]    conv1_outer_cnt;
  reg        [7:0]    conv1_out_x;
  reg        [10:0]   dpconv_ifmap_start_p;
  reg        [10:0]   dpconv_filter_start_p;
  reg        [7:0]    dpconv_conv_width;
  reg        [10:0]   dpconv_bias_p;
  reg        [10:0]   dpconv_quant_p;
  reg        [10:0]   dpconv_ofmap_p;
  reg        [10:0]   dpconv_fmap_fifo_start_p;
  reg        [10:0]   dpconv_fmap_fifo_end_p;
  reg        [7:0]    dpconv_outer_cnt;
  reg        [10:0]   sk_ifmap1_p;
  reg        [10:0]   sk_ifmap2_p;
  reg        [10:0]   sk_params_p;
  reg        [10:0]   sk_ofmap_p;
  reg        [10:0]   ibb_c1_ifmap_p;
  reg        [10:0]   ibb_c1_ofmap_p;
  reg        [7:0]    ibb_c1_out_x;
  reg        [10:0]   ibb_dw_ifmap_p;
  reg        [7:0]    ibb_conv_cnt;
  reg        [31:0]   sm_ln2_p;
  reg        [31:0]   sm_numerator_0;
  reg        [31:0]   sm_numerator_1;
  reg        [31:0]   sm_numerator_2;
  reg        [31:0]   sm_numerator_3;
  reg        [31:0]   sm_numerator_4;
  reg        [31:0]   sm_numerator_5;
  reg        [31:0]   sm_numerator_6;
  reg        [31:0]   sm_numerator_7;
  reg        [31:0]   sm_numerator_8;
  reg        [31:0]   sm_denominator;
  reg        [3:0]    max_index_now;
  reg        [31:0]   max_value_now;
  reg        [3:0]    max_index_last;
  reg        [7:0]    wake_count;
  reg        [7:0]    block_count;
  reg        [3:0]    kws_output;
  reg        [31:0]   rdata;

  assign tmp_kws_output = 4'b1111;
  assign tmp_rdata = rg_kws_nn_score_thre_0;
  assign tmp_rdata_1 = rg_kws_nn_score_thre_1;
  assign tmp_rdata_2 = rg_kws_nn_score_thre_2;
  assign tmp_rdata_3 = rg_kws_nn_score_thre_3;
  assign tmp_rdata_4 = rg_kws_nn_score_thre_4;
  assign tmp_rdata_5 = rg_kws_nn_score_thre_5;
  assign tmp_rdata_6 = rg_kws_nn_score_thre_6;
  assign tmp_rdata_7 = rg_kws_nn_block_num_0;
  assign tmp_rdata_8 = rg_kws_nn_block_num_1;
  assign tmp_rdata_9 = rg_kws_nn_eva_num_0;
  assign tmp_rdata_10 = rg_kws_nn_eva_num_1;
  assign tmp_ro_stack_43 = rg_kws_nn_score_thre_0;
  assign tmp_ro_stack_44 = rg_kws_nn_score_thre_1;
  assign tmp_ro_stack_45 = rg_kws_nn_score_thre_2;
  assign tmp_ro_stack_46 = rg_kws_nn_score_thre_3;
  assign tmp_ro_stack_47 = rg_kws_nn_score_thre_4;
  assign tmp_ro_stack_48 = rg_kws_nn_score_thre_5;
  assign tmp_ro_stack_49 = rg_kws_nn_score_thre_6;
  assign tmp_ro_stack_50 = rg_kws_nn_block_num_0;
  assign tmp_ro_stack_51 = rg_kws_nn_block_num_1;
  assign tmp_ro_stack_52 = rg_kws_nn_eva_num_0;
  assign tmp_ro_stack_53 = rg_kws_nn_eva_num_1;
  assign lowBandWidth_mem_rdata = rdata; // @[core_stack_regfile.scala 161:29]
  assign ro_stack_0 = {21'd0, conv1_ifmap_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_1 = {21'd0, conv1_ofmap_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_2 = {21'd0, conv1_filter_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_3 = {21'd0, conv1_bias_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_4 = {21'd0, conv1_quant_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_5 = {24'd0, conv1_inner_cnt}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_6 = {24'd0, conv1_outer_cnt}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_7 = {24'd0, conv1_out_x}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_8 = {21'd0, dpconv_ifmap_start_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_9 = {21'd0, dpconv_filter_start_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_10 = {24'd0, dpconv_conv_width}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_11 = {21'd0, dpconv_bias_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_12 = {21'd0, dpconv_quant_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_13 = {21'd0, dpconv_ofmap_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_14 = {21'd0, dpconv_fmap_fifo_start_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_15 = {21'd0, dpconv_fmap_fifo_end_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_16 = {24'd0, dpconv_outer_cnt}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_17 = {21'd0, sk_ifmap1_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_18 = {21'd0, sk_ifmap2_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_19 = {21'd0, sk_params_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_20 = {21'd0, sk_ofmap_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_21 = {21'd0, ibb_c1_ifmap_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_22 = {21'd0, ibb_c1_ofmap_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_23 = {24'd0, ibb_c1_out_x}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_24 = {21'd0, ibb_dw_ifmap_p}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_25 = {24'd0, ibb_conv_cnt}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_26 = sm_ln2_p; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_27 = sm_numerator_0; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_28 = sm_numerator_1; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_29 = sm_numerator_2; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_30 = sm_numerator_3; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_31 = sm_numerator_4; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_32 = sm_numerator_5; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_33 = sm_numerator_6; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_34 = sm_numerator_7; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_35 = sm_numerator_8; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_36 = sm_denominator; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_37 = {28'd0, max_index_now}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_38 = max_value_now; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_39 = {28'd0, max_index_last}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_40 = {24'd0, wake_count}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_41 = {24'd0, block_count}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_42 = {28'd0, kws_output}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_43 = {24'd0, tmp_ro_stack_43}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_44 = {24'd0, tmp_ro_stack_44}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_45 = {24'd0, tmp_ro_stack_45}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_46 = {24'd0, tmp_ro_stack_46}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_47 = {24'd0, tmp_ro_stack_47}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_48 = {24'd0, tmp_ro_stack_48}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_49 = {24'd0, tmp_ro_stack_49}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_50 = {24'd0, tmp_ro_stack_50}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_51 = {24'd0, tmp_ro_stack_51}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_52 = {24'd0, tmp_ro_stack_52}; // @[core_stack_regfile.scala 193:17]
  assign ro_stack_53 = {24'd0, tmp_ro_stack_53}; // @[core_stack_regfile.scala 193:17]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      conv1_ifmap_p <= 11'h0; // @[Data.scala 400:33]
      conv1_ofmap_p <= 11'h0; // @[Data.scala 400:33]
      conv1_filter_p <= 11'h0; // @[Data.scala 400:33]
      conv1_bias_p <= 11'h0; // @[Data.scala 400:33]
      conv1_quant_p <= 11'h0; // @[Data.scala 400:33]
      conv1_inner_cnt <= 8'h0; // @[Data.scala 400:33]
      conv1_outer_cnt <= 8'h0; // @[Data.scala 400:33]
      conv1_out_x <= 8'h0; // @[Data.scala 400:33]
      dpconv_ifmap_start_p <= 11'h0; // @[Data.scala 400:33]
      dpconv_filter_start_p <= 11'h0; // @[Data.scala 400:33]
      dpconv_conv_width <= 8'h0; // @[Data.scala 400:33]
      dpconv_bias_p <= 11'h0; // @[Data.scala 400:33]
      dpconv_quant_p <= 11'h0; // @[Data.scala 400:33]
      dpconv_ofmap_p <= 11'h0; // @[Data.scala 400:33]
      dpconv_fmap_fifo_start_p <= 11'h0; // @[Data.scala 400:33]
      dpconv_fmap_fifo_end_p <= 11'h0; // @[Data.scala 400:33]
      dpconv_outer_cnt <= 8'h0; // @[Data.scala 400:33]
      sk_ifmap1_p <= 11'h0; // @[Data.scala 400:33]
      sk_ifmap2_p <= 11'h0; // @[Data.scala 400:33]
      sk_params_p <= 11'h0; // @[Data.scala 400:33]
      sk_ofmap_p <= 11'h0; // @[Data.scala 400:33]
      ibb_c1_ifmap_p <= 11'h0; // @[Data.scala 400:33]
      ibb_c1_ofmap_p <= 11'h0; // @[Data.scala 400:33]
      ibb_c1_out_x <= 8'h0; // @[Data.scala 400:33]
      ibb_dw_ifmap_p <= 11'h0; // @[Data.scala 400:33]
      ibb_conv_cnt <= 8'h0; // @[Data.scala 400:33]
      sm_ln2_p <= 32'h0; // @[Data.scala 400:33]
      sm_numerator_0 <= 32'h0; // @[Data.scala 400:33]
      sm_numerator_1 <= 32'h0; // @[Data.scala 400:33]
      sm_numerator_2 <= 32'h0; // @[Data.scala 400:33]
      sm_numerator_3 <= 32'h0; // @[Data.scala 400:33]
      sm_numerator_4 <= 32'h0; // @[Data.scala 400:33]
      sm_numerator_5 <= 32'h0; // @[Data.scala 400:33]
      sm_numerator_6 <= 32'h0; // @[Data.scala 400:33]
      sm_numerator_7 <= 32'h0; // @[Data.scala 400:33]
      sm_numerator_8 <= 32'h0; // @[Data.scala 400:33]
      sm_denominator <= 32'h0; // @[Data.scala 400:33]
      max_index_now <= 4'b0000; // @[Data.scala 400:33]
      max_value_now <= 32'h0; // @[Data.scala 400:33]
      max_index_last <= 4'b0000; // @[Data.scala 400:33]
      wake_count <= 8'h0; // @[Data.scala 400:33]
      block_count <= 8'h0; // @[Data.scala 400:33]
      kws_output <= tmp_kws_output; // @[Data.scala 400:33]
      rdata <= 32'h0; // @[Data.scala 400:33]
    end else begin
      if(lowBandWidth_mem_wr) begin
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0)) begin
          conv1_ifmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h01)) begin
          conv1_ofmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h02)) begin
          conv1_filter_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h03)) begin
          conv1_bias_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h04)) begin
          conv1_quant_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h05)) begin
          conv1_inner_cnt <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h06)) begin
          conv1_outer_cnt <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h07)) begin
          conv1_out_x <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h08)) begin
          dpconv_ifmap_start_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h09)) begin
          dpconv_filter_start_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0a)) begin
          dpconv_conv_width <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0b)) begin
          dpconv_bias_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0c)) begin
          dpconv_quant_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0d)) begin
          dpconv_ofmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0e)) begin
          dpconv_fmap_fifo_start_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0f)) begin
          dpconv_fmap_fifo_end_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h10)) begin
          dpconv_outer_cnt <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h11)) begin
          sk_ifmap1_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h12)) begin
          sk_ifmap2_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h13)) begin
          sk_params_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h14)) begin
          sk_ofmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h15)) begin
          ibb_c1_ifmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h16)) begin
          ibb_c1_ofmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h17)) begin
          ibb_c1_out_x <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h18)) begin
          ibb_dw_ifmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h19)) begin
          ibb_conv_cnt <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1a)) begin
          sm_ln2_p <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1b)) begin
          sm_numerator_0 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1c)) begin
          sm_numerator_1 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1d)) begin
          sm_numerator_2 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1e)) begin
          sm_numerator_3 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1f)) begin
          sm_numerator_4 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h20)) begin
          sm_numerator_5 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h21)) begin
          sm_numerator_6 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h22)) begin
          sm_numerator_7 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h23)) begin
          sm_numerator_8 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h24)) begin
          sm_denominator <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h25)) begin
          max_index_now <= lowBandWidth_mem_wdata[3 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h26)) begin
          max_value_now <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h27)) begin
          max_index_last <= lowBandWidth_mem_wdata[3 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h28)) begin
          wake_count <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h29)) begin
          block_count <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 144:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2a)) begin
          kws_output <= lowBandWidth_mem_wdata[3 : 0]; // @[core_stack_regfile.scala 144:18]
        end
      end
      if(lowBandWidth_mem_rd) begin
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0)) begin
          rdata <= {21'd0, conv1_ifmap_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h01)) begin
          rdata <= {21'd0, conv1_ofmap_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h02)) begin
          rdata <= {21'd0, conv1_filter_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h03)) begin
          rdata <= {21'd0, conv1_bias_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h04)) begin
          rdata <= {21'd0, conv1_quant_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h05)) begin
          rdata <= {24'd0, conv1_inner_cnt}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h06)) begin
          rdata <= {24'd0, conv1_outer_cnt}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h07)) begin
          rdata <= {24'd0, conv1_out_x}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h08)) begin
          rdata <= {21'd0, dpconv_ifmap_start_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h09)) begin
          rdata <= {21'd0, dpconv_filter_start_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0a)) begin
          rdata <= {24'd0, dpconv_conv_width}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0b)) begin
          rdata <= {21'd0, dpconv_bias_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0c)) begin
          rdata <= {21'd0, dpconv_quant_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0d)) begin
          rdata <= {21'd0, dpconv_ofmap_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0e)) begin
          rdata <= {21'd0, dpconv_fmap_fifo_start_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0f)) begin
          rdata <= {21'd0, dpconv_fmap_fifo_end_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h10)) begin
          rdata <= {24'd0, dpconv_outer_cnt}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h11)) begin
          rdata <= {21'd0, sk_ifmap1_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h12)) begin
          rdata <= {21'd0, sk_ifmap2_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h13)) begin
          rdata <= {21'd0, sk_params_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h14)) begin
          rdata <= {21'd0, sk_ofmap_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h15)) begin
          rdata <= {21'd0, ibb_c1_ifmap_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h16)) begin
          rdata <= {21'd0, ibb_c1_ofmap_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h17)) begin
          rdata <= {24'd0, ibb_c1_out_x}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h18)) begin
          rdata <= {21'd0, ibb_dw_ifmap_p}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h19)) begin
          rdata <= {24'd0, ibb_conv_cnt}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1a)) begin
          rdata <= sm_ln2_p; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1b)) begin
          rdata <= sm_numerator_0; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1c)) begin
          rdata <= sm_numerator_1; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1d)) begin
          rdata <= sm_numerator_2; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1e)) begin
          rdata <= sm_numerator_3; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1f)) begin
          rdata <= sm_numerator_4; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h20)) begin
          rdata <= sm_numerator_5; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h21)) begin
          rdata <= sm_numerator_6; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h22)) begin
          rdata <= sm_numerator_7; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h23)) begin
          rdata <= sm_numerator_8; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h24)) begin
          rdata <= sm_denominator; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h25)) begin
          rdata <= {28'd0, max_index_now}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h26)) begin
          rdata <= max_value_now; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h27)) begin
          rdata <= {28'd0, max_index_last}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h28)) begin
          rdata <= {24'd0, wake_count}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h29)) begin
          rdata <= {24'd0, block_count}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2a)) begin
          rdata <= {28'd0, kws_output}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2b)) begin
          rdata <= {24'd0, tmp_rdata}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2c)) begin
          rdata <= {24'd0, tmp_rdata_1}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2d)) begin
          rdata <= {24'd0, tmp_rdata_2}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2e)) begin
          rdata <= {24'd0, tmp_rdata_3}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2f)) begin
          rdata <= {24'd0, tmp_rdata_4}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h30)) begin
          rdata <= {24'd0, tmp_rdata_5}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h31)) begin
          rdata <= {24'd0, tmp_rdata_6}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h32)) begin
          rdata <= {24'd0, tmp_rdata_7}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h33)) begin
          rdata <= {24'd0, tmp_rdata_8}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h34)) begin
          rdata <= {24'd0, tmp_rdata_9}; // @[core_stack_regfile.scala 165:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h35)) begin
          rdata <= {24'd0, tmp_rdata_10}; // @[core_stack_regfile.scala 165:15]
        end
      end
    end
  end


endmodule

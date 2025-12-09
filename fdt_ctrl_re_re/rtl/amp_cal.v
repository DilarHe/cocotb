// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : amp_cal

`timescale 1ns/1ps 
module amp_cal (
  input  wire          fdt_start_pulse,
  input  wire          fdt_adc_in_mode,
  input  wire          fdt_adc_in_vld,
  input  wire [11:0]   fdt_adc_in_0,
  input  wire [11:0]   fdt_adc_in_1,
  input  wire [4:0]    fdt_therm_comp_one_hot,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_0,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_1,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_2,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_3,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_4,
  input  wire [2:0]    rg_amp_data_ratio,
  input  wire [8:0]    rg_amp_downsamp_row_onehot,
  input  wire [3:0]    rg_amp_sample_num,
  output wire          iq_ready_pulse,
  output wire          amp_cal_end,
  output reg  [10:0]   amp_mean_0,
  output reg  [10:0]   amp_mean_1,
  output reg  [10:0]   amp_mean_2,
  output reg           amp_mean_vld_0,
  output reg           amp_mean_vld_1,
  output reg           amp_mean_vld_2,
  output reg  [11:0]   smpArrayI_0_0,
  output reg  [11:0]   smpArrayI_0_1,
  output reg  [11:0]   smpArrayI_0_2,
  output reg  [11:0]   smpArrayI_0_3,
  output reg  [11:0]   smpArrayI_0_4,
  output reg  [11:0]   smpArrayI_0_5,
  output reg  [11:0]   smpArrayI_0_6,
  output reg  [11:0]   smpArrayI_0_7,
  output reg  [11:0]   smpArrayI_0_8,
  output reg  [11:0]   smpArrayI_0_9,
  output reg  [11:0]   smpArrayI_0_10,
  output reg  [11:0]   smpArrayI_0_11,
  output reg  [11:0]   smpArrayI_1_0,
  output reg  [11:0]   smpArrayI_1_1,
  output reg  [11:0]   smpArrayI_1_2,
  output reg  [11:0]   smpArrayI_1_3,
  output reg  [11:0]   smpArrayI_1_4,
  output reg  [11:0]   smpArrayI_1_5,
  output reg  [11:0]   smpArrayI_1_6,
  output reg  [11:0]   smpArrayI_1_7,
  output reg  [11:0]   smpArrayI_1_8,
  output reg  [11:0]   smpArrayI_1_9,
  output reg  [11:0]   smpArrayI_1_10,
  output reg  [11:0]   smpArrayI_1_11,
  output reg  [11:0]   smpArrayI_2_0,
  output reg  [11:0]   smpArrayI_2_1,
  output reg  [11:0]   smpArrayI_2_2,
  output reg  [11:0]   smpArrayI_2_3,
  output reg  [11:0]   smpArrayI_2_4,
  output reg  [11:0]   smpArrayI_2_5,
  output reg  [11:0]   smpArrayI_2_6,
  output reg  [11:0]   smpArrayI_2_7,
  output reg  [11:0]   smpArrayI_2_8,
  output reg  [11:0]   smpArrayI_2_9,
  output reg  [11:0]   smpArrayI_2_10,
  output reg  [11:0]   smpArrayI_2_11,
  output reg  [11:0]   smpArrayQ_0_0,
  output reg  [11:0]   smpArrayQ_0_1,
  output reg  [11:0]   smpArrayQ_0_2,
  output reg  [11:0]   smpArrayQ_0_3,
  output reg  [11:0]   smpArrayQ_0_4,
  output reg  [11:0]   smpArrayQ_0_5,
  output reg  [11:0]   smpArrayQ_0_6,
  output reg  [11:0]   smpArrayQ_0_7,
  output reg  [11:0]   smpArrayQ_0_8,
  output reg  [11:0]   smpArrayQ_0_9,
  output reg  [11:0]   smpArrayQ_0_10,
  output reg  [11:0]   smpArrayQ_0_11,
  output reg  [11:0]   smpArrayQ_1_0,
  output reg  [11:0]   smpArrayQ_1_1,
  output reg  [11:0]   smpArrayQ_1_2,
  output reg  [11:0]   smpArrayQ_1_3,
  output reg  [11:0]   smpArrayQ_1_4,
  output reg  [11:0]   smpArrayQ_1_5,
  output reg  [11:0]   smpArrayQ_1_6,
  output reg  [11:0]   smpArrayQ_1_7,
  output reg  [11:0]   smpArrayQ_1_8,
  output reg  [11:0]   smpArrayQ_1_9,
  output reg  [11:0]   smpArrayQ_1_10,
  output reg  [11:0]   smpArrayQ_1_11,
  output reg  [11:0]   smpArrayQ_2_0,
  output reg  [11:0]   smpArrayQ_2_1,
  output reg  [11:0]   smpArrayQ_2_2,
  output reg  [11:0]   smpArrayQ_2_3,
  output reg  [11:0]   smpArrayQ_2_4,
  output reg  [11:0]   smpArrayQ_2_5,
  output reg  [11:0]   smpArrayQ_2_6,
  output reg  [11:0]   smpArrayQ_2_7,
  output reg  [11:0]   smpArrayQ_2_8,
  output reg  [11:0]   smpArrayQ_2_9,
  output reg  [11:0]   smpArrayQ_2_10,
  output reg  [11:0]   smpArrayQ_2_11,
  input  wire          clkout,
  input  wire          rstn_80m
);
  localparam Proc_STATE_WAIT_IQ_READY = 2'd0;
  localparam Proc_STATE_WAIT_SQUARE_Q = 2'd1;
  localparam Proc_STATE_SQUARE_I = 2'd2;
  localparam Proc_STATE_SQRT = 2'd3;

  wire       [11:0]   squarer_dinA;
  wire                squarer_din_vld;
  wire       [31:0]   sqrt_e_din;
  wire       [31:0]   sqrt_o_din;
  wire       [15:0]   divider_dinA;
  wire       [3:0]    divider_dinB;
  wire       [23:0]   squarer_dout;
  wire                squarer_dout_vld;
  wire                sqrt_e_dout_vld;
  wire       [15:0]   sqrt_e_dout;
  wire                sqrt_o_dout_vld;
  wire       [15:0]   sqrt_o_dout;
  wire                divider_dout_vld;
  wire       [15:0]   divider_quot;
  wire       [3:0]    divider_remainder;
  wire       [3:0]    tmp_row_cnt_valueNext;
  wire       [0:0]    tmp_row_cnt_valueNext_1;
  wire       [1:0]    tmp_PhaseCnt_valueNext;
  wire       [0:0]    tmp_PhaseCnt_valueNext_1;
  wire       [3:0]    tmp_storeCnt_ov;
  reg        [11:0]   tmp_tmp_squarer_Din_o;
  reg        [11:0]   tmp_tmp_squarer_Din_o_1;
  reg        [11:0]   tmp_tmp_squarer_Din_o_2;
  reg        [11:0]   tmp_tmp_squarer_Din_o_3;
  reg        [11:0]   tmp_tmp_squarer_Din_o_4;
  reg        [11:0]   tmp_tmp_squarer_Din_o_5;
  reg        [11:0]   tmp_tmp_squarer_Din_o_6;
  reg        [11:0]   tmp_tmp_squarer_Din_o_7;
  reg        [11:0]   tmp_tmp_squarer_Din_o_8;
  reg        [11:0]   tmp_tmp_squarer_Din_o_9;
  reg        [11:0]   tmp_tmp_squarer_Din_o_10;
  reg        [11:0]   tmp_tmp_squarer_Din_o_11;
  reg        [11:0]   tmp_tmp_I_raw0_raw180;
  wire       [11:0]   tmp_I_raw0_raw180_1;
  wire       [11:0]   tmp_I_raw0_raw180_2;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_1;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_2;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_3;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_4;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_5;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_6;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_7;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_8;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_9;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_10;
  reg        [11:0]   tmp_tmp_Q_raw90_raw270_e_11;
  reg        [11:0]   tmp_Q_raw90_raw270_e_12;
  wire       [11:0]   tmp_Q_raw90_raw270_e_13;
  wire       [11:0]   tmp_Q_raw90_raw270_e_14;
  reg        [11:0]   tmp_Q_raw90_raw270_o;
  wire       [3:0]    tmp_Q_raw90_raw270_o_1;
  wire       [11:0]   tmp_Q_raw90_raw270_o_2;
  wire       [11:0]   tmp_Q_raw90_raw270_o_3;
  reg        [11:0]   tmp_squarer_Din_o_12;
  wire       [3:0]    tmp_squarer_Din_o_13;
  wire       [10:0]   tmp_tmp_amp_mean_0;
  wire       [1:0]    tmp_area_num_next;
  wire       [23:0]   tmp_IQ_sum_buffer;
  wire       [22:0]   tmp_IQ_sum_buffer_1;
  wire       [23:0]   tmp_IQ_sum_buffer_2;
  wire       [15:0]   tmp_amp_dout_e;
  wire       [15:0]   tmp_amp_dout_o;
  wire       [15:0]   tmp_sigma_amp_buffer;
  wire       [11:0]   tmp_tmp_smpArrayI_0_0;
  wire       [11:0]   tmp_tmp_smpArrayQ_0_0_2;
  wire       [10:0]   fdt_adc_in_cut_0;
  wire       [10:0]   fdt_adc_in_cut_1;
  reg                 fdt_adc_in_vld_dly;
  reg        [1:0]    curr_state;
  reg        [1:0]    next_state;
  wire                state_in_SQUARE_I;
  wire                state_is_cal_amp;
  wire                col_cnt_incr;
  reg        [1:0]    col_cnt;
  wire                col_cnt_ov;
  reg                 row_cnt_willIncrement;
  reg                 row_cnt_willClear;
  reg        [3:0]    row_cnt_valueNext;
  reg        [3:0]    row_cnt_value;
  wire                row_cnt_willOverflowIfInc;
  wire                row_cnt_willOverflow;
  reg        [1:0]    area_num;
  wire       [1:0]    area_num_next;
  wire                area_num_ov;
  reg                 PhaseCnt_willIncrement;
  reg                 PhaseCnt_willClear;
  reg        [1:0]    PhaseCnt_valueNext;
  reg        [1:0]    PhaseCnt_value;
  wire                PhaseCnt_willOverflowIfInc;
  wire                PhaseCnt_willOverflow;
  wire                PhaseCnt_Inc;
  wire                store_vld_e;
  wire                store_vld_o;
  reg        [3:0]    storeCnt;
  wire                storeCnt_ov;
  wire       [10:0]   fdt_adc_in;
  wire       [11:0]   tmp_squarer_Din_o;
  wire       [11:0]   tmp_squarer_Din_o_1;
  wire       [11:0]   tmp_squarer_Din_o_2;
  wire       [11:0]   tmp_squarer_Din_o_3;
  wire       [11:0]   tmp_squarer_Din_o_4;
  wire       [11:0]   tmp_squarer_Din_o_5;
  wire       [11:0]   tmp_squarer_Din_o_6;
  wire       [11:0]   tmp_squarer_Din_o_7;
  wire       [11:0]   tmp_squarer_Din_o_8;
  wire       [11:0]   tmp_squarer_Din_o_9;
  wire       [11:0]   tmp_squarer_Din_o_10;
  wire       [11:0]   tmp_squarer_Din_o_11;
  wire       [3:0]    tmp_1;
  wire                tmp_2;
  wire                tmp_3;
  wire                tmp_4;
  wire       [11:0]   tmp_I_raw0_raw180;
  wire       [15:0]   tmp_5;
  wire                tmp_6;
  wire                tmp_7;
  wire                tmp_8;
  wire                tmp_9;
  wire                tmp_10;
  wire                tmp_11;
  wire                tmp_12;
  wire                tmp_13;
  wire                tmp_14;
  wire                tmp_15;
  wire                tmp_16;
  wire                tmp_17;
  wire       [11:0]   I_raw0_raw180;
  wire       [11:0]   tmp_Q_raw90_raw270_e;
  wire       [11:0]   tmp_Q_raw90_raw270_e_1;
  wire       [11:0]   tmp_Q_raw90_raw270_e_2;
  wire       [11:0]   tmp_Q_raw90_raw270_e_3;
  wire       [11:0]   tmp_Q_raw90_raw270_e_4;
  wire       [11:0]   tmp_Q_raw90_raw270_e_5;
  wire       [11:0]   tmp_Q_raw90_raw270_e_6;
  wire       [11:0]   tmp_Q_raw90_raw270_e_7;
  wire       [11:0]   tmp_Q_raw90_raw270_e_8;
  wire       [11:0]   tmp_Q_raw90_raw270_e_9;
  wire       [11:0]   tmp_Q_raw90_raw270_e_10;
  wire       [11:0]   tmp_Q_raw90_raw270_e_11;
  wire       [3:0]    tmp_18;
  wire                tmp_19;
  wire                tmp_20;
  wire                tmp_21;
  wire       [15:0]   tmp_22;
  wire                tmp_23;
  wire                tmp_24;
  wire                tmp_25;
  wire                tmp_26;
  wire                tmp_27;
  wire                tmp_28;
  wire                tmp_29;
  wire                tmp_30;
  wire                tmp_31;
  wire                tmp_32;
  wire                tmp_33;
  wire                tmp_34;
  wire       [11:0]   Q_raw90_raw270_e;
  wire       [11:0]   Q_raw90_raw270_o;
  wire                squarer_Q_in_vld_e;
  wire                squarer_Q_out_vld_e;
  wire                squarer_I_out_vld_e;
  wire                squarer_Din_vld_e;
  wire       [11:0]   squarer_Din_e;
  reg                 squarer_I_out_vld_e_regNext;
  wire                squarer_Q_in_vld_o;
  reg                 squarer_I_in_vld_o;
  wire                squarer_Q_out_vld_o;
  reg                 squarer_I_out_vld_o;
  wire                squarer_Din_vld_o;
  wire       [11:0]   squarer_Din_o;
  reg        [22:0]   IQ_sum_buffer;
  reg                 IQ_sum_out_vld_e;
  reg                 IQ_sum_out_vld_o;
  reg        [2:0]    therm_comp_ratio;
  reg        [15:0]   therm_comp_dout_e;
  reg        [15:0]   therm_comp_dout_o;
  wire                amp_out_vld_e;
  wire                amp_out_vld_o;
  wire       [11:0]   amp_dout_e;
  wire       [11:0]   amp_dout_o;
  wire                all_amp_store;
  wire       [11:0]   amp_comp_din;
  reg        [15:0]   sigma_amp_buffer;
  reg                 sigma_amp_buffer_vld;
  reg                 divider_dout_vld_0;
  reg                 divider_dout_vld_1;
  reg                 divider_dout_vld_2;
  reg                 tmp_iq_ready_pulse;
  wire       [3:0]    tmp_35;
  wire       [3:0]    tmp_36;
  wire       [10:0]   tmp_amp_mean_0;
  wire       [11:0]   tmp_smpArrayQ_0_0;
  wire       [11:0]   tmp_smpArrayQ_0_0_1;
  wire       [11:0]   tmp_smpArrayI_0_0;
  wire       [11:0]   tmp_smpArrayQ_0_0_2;
  `ifndef SYNTHESIS
  reg [103:0] curr_state_string;
  reg [103:0] next_state_string;
  `endif


  assign tmp_row_cnt_valueNext_1 = row_cnt_willIncrement;
  assign tmp_row_cnt_valueNext = {3'd0, tmp_row_cnt_valueNext_1};
  assign tmp_PhaseCnt_valueNext_1 = PhaseCnt_willIncrement;
  assign tmp_PhaseCnt_valueNext = {1'd0, tmp_PhaseCnt_valueNext_1};
  assign tmp_storeCnt_ov = (rg_amp_sample_num - 4'b0001);
  assign tmp_I_raw0_raw180_1 = tmp_I_raw0_raw180_2;
  assign tmp_I_raw0_raw180_2 = {1'd0, fdt_adc_in};
  assign tmp_Q_raw90_raw270_e_13 = tmp_Q_raw90_raw270_e_14;
  assign tmp_Q_raw90_raw270_e_14 = {1'd0, fdt_adc_in_cut_0};
  assign tmp_Q_raw90_raw270_o_1 = (storeCnt + 4'b0001);
  assign tmp_Q_raw90_raw270_o_2 = tmp_Q_raw90_raw270_o_3;
  assign tmp_Q_raw90_raw270_o_3 = {1'd0, fdt_adc_in_cut_1};
  assign tmp_squarer_Din_o_13 = (storeCnt + 4'b0001);
  assign tmp_tmp_amp_mean_0 = divider_quot[10:0];
  assign tmp_area_num_next = (area_num + 2'b01);
  assign tmp_IQ_sum_buffer = squarer_dout;
  assign tmp_IQ_sum_buffer_2 = squarer_dout;
  assign tmp_IQ_sum_buffer_1 = tmp_IQ_sum_buffer_2[22:0];
  assign tmp_amp_dout_e = (therm_comp_dout_e >>> rg_amp_data_ratio);
  assign tmp_amp_dout_o = (therm_comp_dout_o >>> rg_amp_data_ratio);
  assign tmp_sigma_amp_buffer = {4'd0, amp_comp_din};
  assign tmp_tmp_smpArrayI_0_0 = {1'd0, fdt_adc_in};
  assign tmp_tmp_smpArrayQ_0_0_2 = {1'd0, fdt_adc_in};
  SignMultiplier squarer (
    .dinA     (squarer_dinA[11:0]), //i
    .dinB     (squarer_dinA[11:0]), //i
    .din_vld  (squarer_din_vld   ), //i
    .dout     (squarer_dout[23:0]), //o
    .dout_vld (squarer_dout_vld  ), //o
    .clkout   (clkout            ), //i
    .rstn_80m (rstn_80m          )  //i
  );
  Sqrt_unsigned sqrt_e (
    .din_vld  (IQ_sum_out_vld_e ), //i
    .din      (sqrt_e_din[31:0] ), //i
    .dout_vld (sqrt_e_dout_vld  ), //o
    .dout     (sqrt_e_dout[15:0]), //o
    .clkout   (clkout           ), //i
    .rstn_80m (rstn_80m         )  //i
  );
  Sqrt_unsigned sqrt_o (
    .din_vld  (IQ_sum_out_vld_o ), //i
    .din      (sqrt_o_din[31:0] ), //i
    .dout_vld (sqrt_o_dout_vld  ), //o
    .dout     (sqrt_o_dout[15:0]), //o
    .clkout   (clkout           ), //i
    .rstn_80m (rstn_80m         )  //i
  );
  restoring_div_unsigned divider (
    .din_vld   (sigma_amp_buffer_vld  ), //i
    .dinA      (divider_dinA[15:0]    ), //i
    .dinB      (divider_dinB[3:0]     ), //i
    .dout_vld  (divider_dout_vld      ), //o
    .quot      (divider_quot[15:0]    ), //o
    .remainder (divider_remainder[3:0]), //o
    .clkout    (clkout                ), //i
    .rstn_80m  (rstn_80m              )  //i
  );
  always @(*) begin
    case(area_num)
      2'b00 : begin
        tmp_tmp_squarer_Din_o = smpArrayI_0_0;
        tmp_tmp_squarer_Din_o_1 = smpArrayI_0_1;
        tmp_tmp_squarer_Din_o_2 = smpArrayI_0_2;
        tmp_tmp_squarer_Din_o_3 = smpArrayI_0_3;
        tmp_tmp_squarer_Din_o_4 = smpArrayI_0_4;
        tmp_tmp_squarer_Din_o_5 = smpArrayI_0_5;
        tmp_tmp_squarer_Din_o_6 = smpArrayI_0_6;
        tmp_tmp_squarer_Din_o_7 = smpArrayI_0_7;
        tmp_tmp_squarer_Din_o_8 = smpArrayI_0_8;
        tmp_tmp_squarer_Din_o_9 = smpArrayI_0_9;
        tmp_tmp_squarer_Din_o_10 = smpArrayI_0_10;
        tmp_tmp_squarer_Din_o_11 = smpArrayI_0_11;
        tmp_tmp_Q_raw90_raw270_e = smpArrayQ_0_0;
        tmp_tmp_Q_raw90_raw270_e_1 = smpArrayQ_0_1;
        tmp_tmp_Q_raw90_raw270_e_2 = smpArrayQ_0_2;
        tmp_tmp_Q_raw90_raw270_e_3 = smpArrayQ_0_3;
        tmp_tmp_Q_raw90_raw270_e_4 = smpArrayQ_0_4;
        tmp_tmp_Q_raw90_raw270_e_5 = smpArrayQ_0_5;
        tmp_tmp_Q_raw90_raw270_e_6 = smpArrayQ_0_6;
        tmp_tmp_Q_raw90_raw270_e_7 = smpArrayQ_0_7;
        tmp_tmp_Q_raw90_raw270_e_8 = smpArrayQ_0_8;
        tmp_tmp_Q_raw90_raw270_e_9 = smpArrayQ_0_9;
        tmp_tmp_Q_raw90_raw270_e_10 = smpArrayQ_0_10;
        tmp_tmp_Q_raw90_raw270_e_11 = smpArrayQ_0_11;
      end
      2'b01 : begin
        tmp_tmp_squarer_Din_o = smpArrayI_1_0;
        tmp_tmp_squarer_Din_o_1 = smpArrayI_1_1;
        tmp_tmp_squarer_Din_o_2 = smpArrayI_1_2;
        tmp_tmp_squarer_Din_o_3 = smpArrayI_1_3;
        tmp_tmp_squarer_Din_o_4 = smpArrayI_1_4;
        tmp_tmp_squarer_Din_o_5 = smpArrayI_1_5;
        tmp_tmp_squarer_Din_o_6 = smpArrayI_1_6;
        tmp_tmp_squarer_Din_o_7 = smpArrayI_1_7;
        tmp_tmp_squarer_Din_o_8 = smpArrayI_1_8;
        tmp_tmp_squarer_Din_o_9 = smpArrayI_1_9;
        tmp_tmp_squarer_Din_o_10 = smpArrayI_1_10;
        tmp_tmp_squarer_Din_o_11 = smpArrayI_1_11;
        tmp_tmp_Q_raw90_raw270_e = smpArrayQ_1_0;
        tmp_tmp_Q_raw90_raw270_e_1 = smpArrayQ_1_1;
        tmp_tmp_Q_raw90_raw270_e_2 = smpArrayQ_1_2;
        tmp_tmp_Q_raw90_raw270_e_3 = smpArrayQ_1_3;
        tmp_tmp_Q_raw90_raw270_e_4 = smpArrayQ_1_4;
        tmp_tmp_Q_raw90_raw270_e_5 = smpArrayQ_1_5;
        tmp_tmp_Q_raw90_raw270_e_6 = smpArrayQ_1_6;
        tmp_tmp_Q_raw90_raw270_e_7 = smpArrayQ_1_7;
        tmp_tmp_Q_raw90_raw270_e_8 = smpArrayQ_1_8;
        tmp_tmp_Q_raw90_raw270_e_9 = smpArrayQ_1_9;
        tmp_tmp_Q_raw90_raw270_e_10 = smpArrayQ_1_10;
        tmp_tmp_Q_raw90_raw270_e_11 = smpArrayQ_1_11;
      end
      default : begin
        tmp_tmp_squarer_Din_o = smpArrayI_2_0;
        tmp_tmp_squarer_Din_o_1 = smpArrayI_2_1;
        tmp_tmp_squarer_Din_o_2 = smpArrayI_2_2;
        tmp_tmp_squarer_Din_o_3 = smpArrayI_2_3;
        tmp_tmp_squarer_Din_o_4 = smpArrayI_2_4;
        tmp_tmp_squarer_Din_o_5 = smpArrayI_2_5;
        tmp_tmp_squarer_Din_o_6 = smpArrayI_2_6;
        tmp_tmp_squarer_Din_o_7 = smpArrayI_2_7;
        tmp_tmp_squarer_Din_o_8 = smpArrayI_2_8;
        tmp_tmp_squarer_Din_o_9 = smpArrayI_2_9;
        tmp_tmp_squarer_Din_o_10 = smpArrayI_2_10;
        tmp_tmp_squarer_Din_o_11 = smpArrayI_2_11;
        tmp_tmp_Q_raw90_raw270_e = smpArrayQ_2_0;
        tmp_tmp_Q_raw90_raw270_e_1 = smpArrayQ_2_1;
        tmp_tmp_Q_raw90_raw270_e_2 = smpArrayQ_2_2;
        tmp_tmp_Q_raw90_raw270_e_3 = smpArrayQ_2_3;
        tmp_tmp_Q_raw90_raw270_e_4 = smpArrayQ_2_4;
        tmp_tmp_Q_raw90_raw270_e_5 = smpArrayQ_2_5;
        tmp_tmp_Q_raw90_raw270_e_6 = smpArrayQ_2_6;
        tmp_tmp_Q_raw90_raw270_e_7 = smpArrayQ_2_7;
        tmp_tmp_Q_raw90_raw270_e_8 = smpArrayQ_2_8;
        tmp_tmp_Q_raw90_raw270_e_9 = smpArrayQ_2_9;
        tmp_tmp_Q_raw90_raw270_e_10 = smpArrayQ_2_10;
        tmp_tmp_Q_raw90_raw270_e_11 = smpArrayQ_2_11;
      end
    endcase
  end

  always @(*) begin
    case(storeCnt)
      4'b0000 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e;
      end
      4'b0001 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_1;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_1;
      end
      4'b0010 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_2;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_2;
      end
      4'b0011 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_3;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_3;
      end
      4'b0100 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_4;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_4;
      end
      4'b0101 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_5;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_5;
      end
      4'b0110 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_6;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_6;
      end
      4'b0111 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_7;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_7;
      end
      4'b1000 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_8;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_8;
      end
      4'b1001 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_9;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_9;
      end
      4'b1010 : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_10;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_10;
      end
      default : begin
        tmp_tmp_I_raw0_raw180 = tmp_squarer_Din_o_11;
        tmp_Q_raw90_raw270_e_12 = tmp_Q_raw90_raw270_e_11;
      end
    endcase
  end

  always @(*) begin
    case(tmp_Q_raw90_raw270_o_1)
      4'b0000 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e;
      4'b0001 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_1;
      4'b0010 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_2;
      4'b0011 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_3;
      4'b0100 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_4;
      4'b0101 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_5;
      4'b0110 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_6;
      4'b0111 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_7;
      4'b1000 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_8;
      4'b1001 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_9;
      4'b1010 : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_10;
      default : tmp_Q_raw90_raw270_o = tmp_Q_raw90_raw270_e_11;
    endcase
  end

  always @(*) begin
    case(tmp_squarer_Din_o_13)
      4'b0000 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o;
      4'b0001 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_1;
      4'b0010 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_2;
      4'b0011 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_3;
      4'b0100 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_4;
      4'b0101 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_5;
      4'b0110 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_6;
      4'b0111 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_7;
      4'b1000 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_8;
      4'b1001 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_9;
      4'b1010 : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_10;
      default : tmp_squarer_Din_o_12 = tmp_squarer_Din_o_11;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(curr_state)
      Proc_STATE_WAIT_IQ_READY : curr_state_string = "WAIT_IQ_READY";
      Proc_STATE_WAIT_SQUARE_Q : curr_state_string = "WAIT_SQUARE_Q";
      Proc_STATE_SQUARE_I : curr_state_string = "SQUARE_I     ";
      Proc_STATE_SQRT : curr_state_string = "SQRT         ";
      default : curr_state_string = "?????????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      Proc_STATE_WAIT_IQ_READY : next_state_string = "WAIT_IQ_READY";
      Proc_STATE_WAIT_SQUARE_Q : next_state_string = "WAIT_SQUARE_Q";
      Proc_STATE_SQUARE_I : next_state_string = "SQUARE_I     ";
      Proc_STATE_SQRT : next_state_string = "SQRT         ";
      default : next_state_string = "?????????????";
    endcase
  end
  `endif

  assign fdt_adc_in_cut_0 = fdt_adc_in_0[11 : 1];
  assign fdt_adc_in_cut_1 = fdt_adc_in_1[11 : 1];
  assign col_cnt_incr = (fdt_adc_in_mode ? fdt_adc_in_vld : fdt_adc_in_vld_dly);
  assign col_cnt_ov = (fdt_adc_in_mode ? (col_cnt == 2'b11) : (col_cnt == 2'b01));
  always @(*) begin
    row_cnt_willIncrement = 1'b0;
    if((col_cnt_incr && col_cnt_ov)) begin
      if(!row_cnt_willOverflowIfInc) begin
        row_cnt_willIncrement = 1'b1;
      end
    end
  end

  always @(*) begin
    row_cnt_willClear = 1'b0;
    if((col_cnt_incr && col_cnt_ov)) begin
      if(row_cnt_willOverflowIfInc) begin
        row_cnt_willClear = 1'b1;
      end
    end
  end

  assign row_cnt_willOverflowIfInc = (row_cnt_value == 4'b1000);
  assign row_cnt_willOverflow = (row_cnt_willOverflowIfInc && row_cnt_willIncrement);
  always @(*) begin
    if(row_cnt_willOverflow) begin
      row_cnt_valueNext = 4'b0000;
    end else begin
      row_cnt_valueNext = (row_cnt_value + tmp_row_cnt_valueNext);
    end
    if(row_cnt_willClear) begin
      row_cnt_valueNext = 4'b0000;
    end
  end

  assign area_num_ov = (area_num == 2'b10);
  always @(*) begin
    PhaseCnt_willIncrement = 1'b0;
    if(PhaseCnt_Inc) begin
      if(!PhaseCnt_willOverflowIfInc) begin
        PhaseCnt_willIncrement = 1'b1;
      end
    end
  end

  always @(*) begin
    PhaseCnt_willClear = 1'b0;
    if(PhaseCnt_Inc) begin
      if(PhaseCnt_willOverflowIfInc) begin
        PhaseCnt_willClear = 1'b1;
      end
    end
  end

  assign PhaseCnt_willOverflowIfInc = (PhaseCnt_value == 2'b11);
  assign PhaseCnt_willOverflow = (PhaseCnt_willOverflowIfInc && PhaseCnt_willIncrement);
  always @(*) begin
    PhaseCnt_valueNext = (PhaseCnt_value + tmp_PhaseCnt_valueNext);
    if(PhaseCnt_willClear) begin
      PhaseCnt_valueNext = 2'b00;
    end
  end

  assign PhaseCnt_Inc = ((col_cnt_incr && col_cnt_ov) && row_cnt_willOverflowIfInc);
  assign store_vld_e = (rg_amp_downsamp_row_onehot[row_cnt_value] && fdt_adc_in_vld);
  assign store_vld_o = (fdt_adc_in_mode ? 1'b0 : (rg_amp_downsamp_row_onehot[row_cnt_value] && fdt_adc_in_vld_dly));
  assign storeCnt_ov = (storeCnt == tmp_storeCnt_ov);
  assign fdt_adc_in = (store_vld_o ? fdt_adc_in_cut_1 : fdt_adc_in_cut_0);
  assign tmp_squarer_Din_o = tmp_tmp_squarer_Din_o;
  assign tmp_squarer_Din_o_1 = tmp_tmp_squarer_Din_o_1;
  assign tmp_squarer_Din_o_2 = tmp_tmp_squarer_Din_o_2;
  assign tmp_squarer_Din_o_3 = tmp_tmp_squarer_Din_o_3;
  assign tmp_squarer_Din_o_4 = tmp_tmp_squarer_Din_o_4;
  assign tmp_squarer_Din_o_5 = tmp_tmp_squarer_Din_o_5;
  assign tmp_squarer_Din_o_6 = tmp_tmp_squarer_Din_o_6;
  assign tmp_squarer_Din_o_7 = tmp_tmp_squarer_Din_o_7;
  assign tmp_squarer_Din_o_8 = tmp_tmp_squarer_Din_o_8;
  assign tmp_squarer_Din_o_9 = tmp_tmp_squarer_Din_o_9;
  assign tmp_squarer_Din_o_10 = tmp_tmp_squarer_Din_o_10;
  assign tmp_squarer_Din_o_11 = tmp_tmp_squarer_Din_o_11;
  assign tmp_1 = ({3'd0,1'b1} <<< area_num);
  assign tmp_2 = tmp_1[0];
  assign tmp_3 = tmp_1[1];
  assign tmp_4 = tmp_1[2];
  assign tmp_I_raw0_raw180 = tmp_tmp_I_raw0_raw180;
  assign tmp_5 = ({15'd0,1'b1} <<< storeCnt);
  assign tmp_6 = tmp_5[0];
  assign tmp_7 = tmp_5[1];
  assign tmp_8 = tmp_5[2];
  assign tmp_9 = tmp_5[3];
  assign tmp_10 = tmp_5[4];
  assign tmp_11 = tmp_5[5];
  assign tmp_12 = tmp_5[6];
  assign tmp_13 = tmp_5[7];
  assign tmp_14 = tmp_5[8];
  assign tmp_15 = tmp_5[9];
  assign tmp_16 = tmp_5[10];
  assign tmp_17 = tmp_5[11];
  assign I_raw0_raw180 = ($signed(tmp_I_raw0_raw180) - $signed(tmp_I_raw0_raw180_1));
  assign tmp_Q_raw90_raw270_e = tmp_tmp_Q_raw90_raw270_e;
  assign tmp_Q_raw90_raw270_e_1 = tmp_tmp_Q_raw90_raw270_e_1;
  assign tmp_Q_raw90_raw270_e_2 = tmp_tmp_Q_raw90_raw270_e_2;
  assign tmp_Q_raw90_raw270_e_3 = tmp_tmp_Q_raw90_raw270_e_3;
  assign tmp_Q_raw90_raw270_e_4 = tmp_tmp_Q_raw90_raw270_e_4;
  assign tmp_Q_raw90_raw270_e_5 = tmp_tmp_Q_raw90_raw270_e_5;
  assign tmp_Q_raw90_raw270_e_6 = tmp_tmp_Q_raw90_raw270_e_6;
  assign tmp_Q_raw90_raw270_e_7 = tmp_tmp_Q_raw90_raw270_e_7;
  assign tmp_Q_raw90_raw270_e_8 = tmp_tmp_Q_raw90_raw270_e_8;
  assign tmp_Q_raw90_raw270_e_9 = tmp_tmp_Q_raw90_raw270_e_9;
  assign tmp_Q_raw90_raw270_e_10 = tmp_tmp_Q_raw90_raw270_e_10;
  assign tmp_Q_raw90_raw270_e_11 = tmp_tmp_Q_raw90_raw270_e_11;
  assign tmp_18 = ({3'd0,1'b1} <<< area_num);
  assign tmp_19 = tmp_18[0];
  assign tmp_20 = tmp_18[1];
  assign tmp_21 = tmp_18[2];
  assign tmp_22 = ({15'd0,1'b1} <<< storeCnt);
  assign tmp_23 = tmp_22[0];
  assign tmp_24 = tmp_22[1];
  assign tmp_25 = tmp_22[2];
  assign tmp_26 = tmp_22[3];
  assign tmp_27 = tmp_22[4];
  assign tmp_28 = tmp_22[5];
  assign tmp_29 = tmp_22[6];
  assign tmp_30 = tmp_22[7];
  assign tmp_31 = tmp_22[8];
  assign tmp_32 = tmp_22[9];
  assign tmp_33 = tmp_22[10];
  assign tmp_34 = tmp_22[11];
  assign Q_raw90_raw270_e = ($signed(tmp_Q_raw90_raw270_e_12) - $signed(tmp_Q_raw90_raw270_e_13));
  assign Q_raw90_raw270_o = ($signed(tmp_Q_raw90_raw270_o) - $signed(tmp_Q_raw90_raw270_o_2));
  assign squarer_Q_in_vld_e = ((curr_state == Proc_STATE_WAIT_SQUARE_Q) && store_vld_e);
  assign squarer_Q_out_vld_e = (squarer_dout_vld && (curr_state == Proc_STATE_WAIT_SQUARE_Q));
  assign squarer_I_out_vld_e = (squarer_dout_vld && (curr_state == Proc_STATE_SQUARE_I));
  assign squarer_Din_vld_e = (squarer_Q_in_vld_e || state_in_SQUARE_I);
  assign squarer_Din_e = (squarer_Q_in_vld_e ? Q_raw90_raw270_e : tmp_I_raw0_raw180);
  assign squarer_Q_in_vld_o = ((! fdt_adc_in_mode) && squarer_I_out_vld_e_regNext);
  assign squarer_Q_out_vld_o = (squarer_dout_vld && squarer_I_in_vld_o);
  assign squarer_Din_vld_o = (squarer_Q_in_vld_o || squarer_I_in_vld_o);
  assign squarer_Din_o = (squarer_Q_in_vld_o ? Q_raw90_raw270_o : tmp_squarer_Din_o_12);
  assign all_amp_store = ((fdt_adc_in_mode ? amp_out_vld_e : amp_out_vld_o) && storeCnt_ov);
  assign amp_comp_din = (amp_out_vld_o ? amp_dout_o : amp_dout_e);
  assign divider_dinA = sigma_amp_buffer;
  assign divider_dinB = rg_amp_sample_num;
  assign iq_ready_pulse = tmp_iq_ready_pulse;
  assign amp_cal_end = (sqrt_o_dout_vld && storeCnt_ov);
  always @(*) begin
    divider_dout_vld_0 = 1'b0;
    if((area_num < 2'b11)) begin
      if(tmp_35[0]) begin
        divider_dout_vld_0 = divider_dout_vld;
      end
    end
  end

  always @(*) begin
    divider_dout_vld_1 = 1'b0;
    if((area_num < 2'b11)) begin
      if(tmp_35[1]) begin
        divider_dout_vld_1 = divider_dout_vld;
      end
    end
  end

  always @(*) begin
    divider_dout_vld_2 = 1'b0;
    if((area_num < 2'b11)) begin
      if(tmp_35[2]) begin
        divider_dout_vld_2 = divider_dout_vld;
      end
    end
  end

  assign tmp_35 = ({3'd0,1'b1} <<< area_num);
  assign tmp_36 = ({3'd0,1'b1} <<< area_num);
  assign tmp_amp_mean_0 = tmp_tmp_amp_mean_0;
  assign area_num_next = (area_num_ov ? 2'b00 : tmp_area_num_next);
  assign state_in_SQUARE_I = ((curr_state == Proc_STATE_WAIT_SQUARE_Q) && (next_state == Proc_STATE_SQUARE_I));
  assign state_is_cal_amp = (((curr_state == Proc_STATE_WAIT_SQUARE_Q) || (curr_state == Proc_STATE_SQUARE_I)) || (curr_state == Proc_STATE_SQRT));
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      Proc_STATE_WAIT_IQ_READY : begin
        if(iq_ready_pulse) begin
          next_state = Proc_STATE_WAIT_SQUARE_Q;
        end
      end
      Proc_STATE_WAIT_SQUARE_Q : begin
        if((area_num_ov && divider_dout_vld)) begin
          next_state = Proc_STATE_WAIT_IQ_READY;
        end else begin
          if(squarer_dout_vld) begin
            next_state = Proc_STATE_SQUARE_I;
          end
        end
      end
      Proc_STATE_SQUARE_I : begin
        if(squarer_dout_vld) begin
          next_state = Proc_STATE_SQRT;
        end
      end
      default : begin
        if(sqrt_e_dout_vld) begin
          next_state = Proc_STATE_WAIT_SQUARE_Q;
        end
      end
    endcase
  end

  assign squarer_din_vld = (squarer_Din_vld_e || squarer_Din_vld_o);
  assign squarer_dinA = (squarer_Din_vld_o ? squarer_Din_o : squarer_Din_e);
  assign sqrt_e_din = {9'd0, IQ_sum_buffer};
  assign sqrt_o_din = {9'd0, IQ_sum_buffer};
  always @(*) begin
    therm_comp_ratio = 3'b010;
    case(fdt_therm_comp_one_hot)
      5'h10 : begin
        therm_comp_ratio = rg_amp_therm_comp_amp_ratio_0;
      end
      5'h08 : begin
        therm_comp_ratio = rg_amp_therm_comp_amp_ratio_1;
      end
      5'h04 : begin
        therm_comp_ratio = rg_amp_therm_comp_amp_ratio_2;
      end
      5'h02 : begin
        therm_comp_ratio = rg_amp_therm_comp_amp_ratio_3;
      end
      5'h01 : begin
        therm_comp_ratio = rg_amp_therm_comp_amp_ratio_4;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    therm_comp_dout_o = 16'h0;
    case(therm_comp_ratio)
      3'b000 : begin
        if(!fdt_adc_in_mode) begin
          therm_comp_dout_o = (sqrt_o_dout >>> 2);
        end
      end
      3'b001 : begin
        if(!fdt_adc_in_mode) begin
          therm_comp_dout_o = (sqrt_o_dout >>> 1);
        end
      end
      3'b010 : begin
        if(!fdt_adc_in_mode) begin
          therm_comp_dout_o = sqrt_o_dout;
        end
      end
      3'b011 : begin
        if(!fdt_adc_in_mode) begin
          therm_comp_dout_o = (sqrt_o_dout <<< 1);
        end
      end
      3'b100 : begin
        if(!fdt_adc_in_mode) begin
          therm_comp_dout_o = (sqrt_o_dout <<< 2);
        end
      end
      default : begin
        therm_comp_dout_o = sqrt_o_dout;
      end
    endcase
  end

  always @(*) begin
    case(therm_comp_ratio)
      3'b000 : begin
        if(fdt_adc_in_mode) begin
          therm_comp_dout_e = (sqrt_e_dout >>> 2);
        end else begin
          therm_comp_dout_e = (sqrt_e_dout >>> 2);
        end
      end
      3'b001 : begin
        if(fdt_adc_in_mode) begin
          therm_comp_dout_e = (sqrt_e_dout >>> 1);
        end else begin
          therm_comp_dout_e = (sqrt_e_dout >>> 1);
        end
      end
      3'b010 : begin
        if(fdt_adc_in_mode) begin
          therm_comp_dout_e = sqrt_e_dout;
        end else begin
          therm_comp_dout_e = sqrt_e_dout;
        end
      end
      3'b011 : begin
        if(fdt_adc_in_mode) begin
          therm_comp_dout_e = (sqrt_e_dout <<< 1);
        end else begin
          therm_comp_dout_e = (sqrt_e_dout <<< 1);
        end
      end
      3'b100 : begin
        if(fdt_adc_in_mode) begin
          therm_comp_dout_e = (sqrt_e_dout <<< 2);
        end else begin
          therm_comp_dout_e = (sqrt_e_dout <<< 2);
        end
      end
      default : begin
        therm_comp_dout_e = sqrt_e_dout;
      end
    endcase
  end

  assign amp_out_vld_e = sqrt_e_dout_vld;
  assign amp_out_vld_o = sqrt_o_dout_vld;
  assign amp_dout_e = tmp_amp_dout_e[11:0];
  assign amp_dout_o = tmp_amp_dout_o[11:0];
  assign tmp_smpArrayQ_0_0 = amp_dout_e;
  assign tmp_smpArrayQ_0_0_1 = amp_dout_o;
  assign tmp_smpArrayI_0_0 = tmp_tmp_smpArrayI_0_0;
  assign tmp_smpArrayQ_0_0_2 = tmp_tmp_smpArrayQ_0_0_2;
  always @(posedge clkout or negedge rstn_80m) begin
    if(!rstn_80m) begin
      amp_mean_0 <= 11'h0;
      amp_mean_1 <= 11'h0;
      amp_mean_2 <= 11'h0;
      amp_mean_vld_0 <= 1'b0;
      amp_mean_vld_1 <= 1'b0;
      amp_mean_vld_2 <= 1'b0;
      smpArrayI_0_0 <= 12'h0;
      smpArrayI_0_1 <= 12'h0;
      smpArrayI_0_2 <= 12'h0;
      smpArrayI_0_3 <= 12'h0;
      smpArrayI_0_4 <= 12'h0;
      smpArrayI_0_5 <= 12'h0;
      smpArrayI_0_6 <= 12'h0;
      smpArrayI_0_7 <= 12'h0;
      smpArrayI_0_8 <= 12'h0;
      smpArrayI_0_9 <= 12'h0;
      smpArrayI_0_10 <= 12'h0;
      smpArrayI_0_11 <= 12'h0;
      smpArrayI_1_0 <= 12'h0;
      smpArrayI_1_1 <= 12'h0;
      smpArrayI_1_2 <= 12'h0;
      smpArrayI_1_3 <= 12'h0;
      smpArrayI_1_4 <= 12'h0;
      smpArrayI_1_5 <= 12'h0;
      smpArrayI_1_6 <= 12'h0;
      smpArrayI_1_7 <= 12'h0;
      smpArrayI_1_8 <= 12'h0;
      smpArrayI_1_9 <= 12'h0;
      smpArrayI_1_10 <= 12'h0;
      smpArrayI_1_11 <= 12'h0;
      smpArrayI_2_0 <= 12'h0;
      smpArrayI_2_1 <= 12'h0;
      smpArrayI_2_2 <= 12'h0;
      smpArrayI_2_3 <= 12'h0;
      smpArrayI_2_4 <= 12'h0;
      smpArrayI_2_5 <= 12'h0;
      smpArrayI_2_6 <= 12'h0;
      smpArrayI_2_7 <= 12'h0;
      smpArrayI_2_8 <= 12'h0;
      smpArrayI_2_9 <= 12'h0;
      smpArrayI_2_10 <= 12'h0;
      smpArrayI_2_11 <= 12'h0;
      smpArrayQ_0_0 <= 12'h0;
      smpArrayQ_0_1 <= 12'h0;
      smpArrayQ_0_2 <= 12'h0;
      smpArrayQ_0_3 <= 12'h0;
      smpArrayQ_0_4 <= 12'h0;
      smpArrayQ_0_5 <= 12'h0;
      smpArrayQ_0_6 <= 12'h0;
      smpArrayQ_0_7 <= 12'h0;
      smpArrayQ_0_8 <= 12'h0;
      smpArrayQ_0_9 <= 12'h0;
      smpArrayQ_0_10 <= 12'h0;
      smpArrayQ_0_11 <= 12'h0;
      smpArrayQ_1_0 <= 12'h0;
      smpArrayQ_1_1 <= 12'h0;
      smpArrayQ_1_2 <= 12'h0;
      smpArrayQ_1_3 <= 12'h0;
      smpArrayQ_1_4 <= 12'h0;
      smpArrayQ_1_5 <= 12'h0;
      smpArrayQ_1_6 <= 12'h0;
      smpArrayQ_1_7 <= 12'h0;
      smpArrayQ_1_8 <= 12'h0;
      smpArrayQ_1_9 <= 12'h0;
      smpArrayQ_1_10 <= 12'h0;
      smpArrayQ_1_11 <= 12'h0;
      smpArrayQ_2_0 <= 12'h0;
      smpArrayQ_2_1 <= 12'h0;
      smpArrayQ_2_2 <= 12'h0;
      smpArrayQ_2_3 <= 12'h0;
      smpArrayQ_2_4 <= 12'h0;
      smpArrayQ_2_5 <= 12'h0;
      smpArrayQ_2_6 <= 12'h0;
      smpArrayQ_2_7 <= 12'h0;
      smpArrayQ_2_8 <= 12'h0;
      smpArrayQ_2_9 <= 12'h0;
      smpArrayQ_2_10 <= 12'h0;
      smpArrayQ_2_11 <= 12'h0;
      fdt_adc_in_vld_dly <= 1'b0;
      curr_state <= Proc_STATE_WAIT_IQ_READY;
      col_cnt <= 2'b00;
      row_cnt_value <= 4'b0000;
      area_num <= 2'b00;
      PhaseCnt_value <= 2'b00;
      storeCnt <= 4'b0000;
      squarer_I_out_vld_e_regNext <= 1'b0;
      squarer_I_in_vld_o <= 1'b0;
      squarer_I_out_vld_o <= 1'b0;
      IQ_sum_buffer <= 23'h0;
      IQ_sum_out_vld_e <= 1'b0;
      IQ_sum_out_vld_o <= 1'b0;
      sigma_amp_buffer <= 16'h0;
      sigma_amp_buffer_vld <= 1'b0;
      tmp_iq_ready_pulse <= 1'b0;
    end else begin
      fdt_adc_in_vld_dly <= fdt_adc_in_vld;
      row_cnt_value <= row_cnt_valueNext;
      PhaseCnt_value <= PhaseCnt_valueNext;
      squarer_I_out_vld_e_regNext <= squarer_I_out_vld_e;
      squarer_I_in_vld_o <= squarer_Q_in_vld_o;
      squarer_I_out_vld_o <= squarer_Q_out_vld_o;
      IQ_sum_out_vld_e <= squarer_I_out_vld_e;
      IQ_sum_out_vld_o <= squarer_I_out_vld_o;
      sigma_amp_buffer_vld <= all_amp_store;
      tmp_iq_ready_pulse <= (PhaseCnt_Inc && (PhaseCnt_value == 2'b10));
      amp_mean_vld_0 <= divider_dout_vld_0;
      amp_mean_vld_1 <= divider_dout_vld_1;
      amp_mean_vld_2 <= divider_dout_vld_2;
      if(divider_dout_vld) begin
        if(tmp_36[0]) begin
          amp_mean_0 <= tmp_amp_mean_0;
        end
        if(tmp_36[1]) begin
          amp_mean_1 <= tmp_amp_mean_0;
        end
        if(tmp_36[2]) begin
          amp_mean_2 <= tmp_amp_mean_0;
        end
      end
      if(state_is_cal_amp) begin
        if(divider_dout_vld) begin
          area_num <= area_num_next;
        end
      end else begin
        if((storeCnt_ov && (store_vld_o || store_vld_e))) begin
          area_num <= area_num_next;
        end
      end
      if(col_cnt_incr) begin
        if(col_cnt_ov) begin
          col_cnt <= 2'b00;
        end else begin
          col_cnt <= (col_cnt + 2'b01);
        end
      end
      curr_state <= next_state;
      if((squarer_Q_out_vld_e || squarer_Q_out_vld_o)) begin
        IQ_sum_buffer <= tmp_IQ_sum_buffer[22:0];
      end else begin
        if((squarer_I_out_vld_e || squarer_I_out_vld_o)) begin
          IQ_sum_buffer <= (IQ_sum_buffer + tmp_IQ_sum_buffer_1);
        end
      end
      if(state_is_cal_amp) begin
        if((amp_out_vld_e || amp_out_vld_o)) begin
          if((storeCnt == 4'b0000)) begin
            sigma_amp_buffer <= {4'd0, amp_comp_din};
          end else begin
            sigma_amp_buffer <= (sigma_amp_buffer + tmp_sigma_amp_buffer);
          end
        end
      end
      if(state_is_cal_amp) begin
        if((amp_out_vld_e || amp_out_vld_o)) begin
          if(storeCnt_ov) begin
            storeCnt <= 4'b0000;
          end else begin
            storeCnt <= (storeCnt + 4'b0001);
          end
        end
      end else begin
        if((store_vld_e || store_vld_o)) begin
          if(storeCnt_ov) begin
            storeCnt <= 4'b0000;
          end else begin
            storeCnt <= (storeCnt + 4'b0001);
          end
        end
      end
      if(state_is_cal_amp) begin
        if(amp_out_vld_e) begin
          if(tmp_23) begin
            if(tmp_19) begin
              smpArrayQ_0_0 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_0 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_0 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_24) begin
            if(tmp_19) begin
              smpArrayQ_0_1 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_1 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_1 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_25) begin
            if(tmp_19) begin
              smpArrayQ_0_2 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_2 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_2 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_26) begin
            if(tmp_19) begin
              smpArrayQ_0_3 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_3 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_3 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_27) begin
            if(tmp_19) begin
              smpArrayQ_0_4 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_4 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_4 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_28) begin
            if(tmp_19) begin
              smpArrayQ_0_5 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_5 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_5 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_29) begin
            if(tmp_19) begin
              smpArrayQ_0_6 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_6 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_6 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_30) begin
            if(tmp_19) begin
              smpArrayQ_0_7 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_7 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_7 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_31) begin
            if(tmp_19) begin
              smpArrayQ_0_8 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_8 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_8 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_32) begin
            if(tmp_19) begin
              smpArrayQ_0_9 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_9 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_9 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_33) begin
            if(tmp_19) begin
              smpArrayQ_0_10 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_10 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_10 <= tmp_smpArrayQ_0_0;
            end
          end
          if(tmp_34) begin
            if(tmp_19) begin
              smpArrayQ_0_11 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_20) begin
              smpArrayQ_1_11 <= tmp_smpArrayQ_0_0;
            end
            if(tmp_21) begin
              smpArrayQ_2_11 <= tmp_smpArrayQ_0_0;
            end
          end
        end else begin
          if(amp_out_vld_o) begin
            if(tmp_23) begin
              if(tmp_19) begin
                smpArrayQ_0_0 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_0 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_0 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_24) begin
              if(tmp_19) begin
                smpArrayQ_0_1 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_1 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_1 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_25) begin
              if(tmp_19) begin
                smpArrayQ_0_2 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_2 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_2 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_26) begin
              if(tmp_19) begin
                smpArrayQ_0_3 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_3 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_3 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_27) begin
              if(tmp_19) begin
                smpArrayQ_0_4 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_4 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_4 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_28) begin
              if(tmp_19) begin
                smpArrayQ_0_5 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_5 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_5 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_29) begin
              if(tmp_19) begin
                smpArrayQ_0_6 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_6 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_6 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_30) begin
              if(tmp_19) begin
                smpArrayQ_0_7 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_7 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_7 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_31) begin
              if(tmp_19) begin
                smpArrayQ_0_8 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_8 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_8 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_32) begin
              if(tmp_19) begin
                smpArrayQ_0_9 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_9 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_9 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_33) begin
              if(tmp_19) begin
                smpArrayQ_0_10 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_10 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_10 <= tmp_smpArrayQ_0_0_1;
              end
            end
            if(tmp_34) begin
              if(tmp_19) begin
                smpArrayQ_0_11 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_20) begin
                smpArrayQ_1_11 <= tmp_smpArrayQ_0_0_1;
              end
              if(tmp_21) begin
                smpArrayQ_2_11 <= tmp_smpArrayQ_0_0_1;
              end
            end
          end
        end
      end else begin
        if((store_vld_e || store_vld_o)) begin
          case(PhaseCnt_value)
            2'b00 : begin
              if(tmp_6) begin
                if(tmp_2) begin
                  smpArrayI_0_0 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_0 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_0 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_7) begin
                if(tmp_2) begin
                  smpArrayI_0_1 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_1 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_1 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_8) begin
                if(tmp_2) begin
                  smpArrayI_0_2 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_2 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_2 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_9) begin
                if(tmp_2) begin
                  smpArrayI_0_3 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_3 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_3 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_10) begin
                if(tmp_2) begin
                  smpArrayI_0_4 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_4 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_4 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_11) begin
                if(tmp_2) begin
                  smpArrayI_0_5 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_5 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_5 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_12) begin
                if(tmp_2) begin
                  smpArrayI_0_6 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_6 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_6 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_13) begin
                if(tmp_2) begin
                  smpArrayI_0_7 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_7 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_7 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_14) begin
                if(tmp_2) begin
                  smpArrayI_0_8 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_8 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_8 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_15) begin
                if(tmp_2) begin
                  smpArrayI_0_9 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_9 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_9 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_16) begin
                if(tmp_2) begin
                  smpArrayI_0_10 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_10 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_10 <= tmp_smpArrayI_0_0;
                end
              end
              if(tmp_17) begin
                if(tmp_2) begin
                  smpArrayI_0_11 <= tmp_smpArrayI_0_0;
                end
                if(tmp_3) begin
                  smpArrayI_1_11 <= tmp_smpArrayI_0_0;
                end
                if(tmp_4) begin
                  smpArrayI_2_11 <= tmp_smpArrayI_0_0;
                end
              end
            end
            2'b01 : begin
              if(tmp_6) begin
                if(tmp_2) begin
                  smpArrayI_0_0 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_0 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_0 <= I_raw0_raw180;
                end
              end
              if(tmp_7) begin
                if(tmp_2) begin
                  smpArrayI_0_1 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_1 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_1 <= I_raw0_raw180;
                end
              end
              if(tmp_8) begin
                if(tmp_2) begin
                  smpArrayI_0_2 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_2 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_2 <= I_raw0_raw180;
                end
              end
              if(tmp_9) begin
                if(tmp_2) begin
                  smpArrayI_0_3 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_3 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_3 <= I_raw0_raw180;
                end
              end
              if(tmp_10) begin
                if(tmp_2) begin
                  smpArrayI_0_4 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_4 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_4 <= I_raw0_raw180;
                end
              end
              if(tmp_11) begin
                if(tmp_2) begin
                  smpArrayI_0_5 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_5 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_5 <= I_raw0_raw180;
                end
              end
              if(tmp_12) begin
                if(tmp_2) begin
                  smpArrayI_0_6 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_6 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_6 <= I_raw0_raw180;
                end
              end
              if(tmp_13) begin
                if(tmp_2) begin
                  smpArrayI_0_7 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_7 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_7 <= I_raw0_raw180;
                end
              end
              if(tmp_14) begin
                if(tmp_2) begin
                  smpArrayI_0_8 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_8 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_8 <= I_raw0_raw180;
                end
              end
              if(tmp_15) begin
                if(tmp_2) begin
                  smpArrayI_0_9 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_9 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_9 <= I_raw0_raw180;
                end
              end
              if(tmp_16) begin
                if(tmp_2) begin
                  smpArrayI_0_10 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_10 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_10 <= I_raw0_raw180;
                end
              end
              if(tmp_17) begin
                if(tmp_2) begin
                  smpArrayI_0_11 <= I_raw0_raw180;
                end
                if(tmp_3) begin
                  smpArrayI_1_11 <= I_raw0_raw180;
                end
                if(tmp_4) begin
                  smpArrayI_2_11 <= I_raw0_raw180;
                end
              end
            end
            2'b10 : begin
              if(tmp_23) begin
                if(tmp_19) begin
                  smpArrayQ_0_0 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_0 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_0 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_24) begin
                if(tmp_19) begin
                  smpArrayQ_0_1 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_1 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_1 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_25) begin
                if(tmp_19) begin
                  smpArrayQ_0_2 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_2 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_2 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_26) begin
                if(tmp_19) begin
                  smpArrayQ_0_3 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_3 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_3 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_27) begin
                if(tmp_19) begin
                  smpArrayQ_0_4 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_4 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_4 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_28) begin
                if(tmp_19) begin
                  smpArrayQ_0_5 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_5 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_5 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_29) begin
                if(tmp_19) begin
                  smpArrayQ_0_6 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_6 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_6 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_30) begin
                if(tmp_19) begin
                  smpArrayQ_0_7 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_7 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_7 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_31) begin
                if(tmp_19) begin
                  smpArrayQ_0_8 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_8 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_8 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_32) begin
                if(tmp_19) begin
                  smpArrayQ_0_9 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_9 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_9 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_33) begin
                if(tmp_19) begin
                  smpArrayQ_0_10 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_10 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_10 <= tmp_smpArrayQ_0_0_2;
                end
              end
              if(tmp_34) begin
                if(tmp_19) begin
                  smpArrayQ_0_11 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_20) begin
                  smpArrayQ_1_11 <= tmp_smpArrayQ_0_0_2;
                end
                if(tmp_21) begin
                  smpArrayQ_2_11 <= tmp_smpArrayQ_0_0_2;
                end
              end
            end
            default : begin
            end
          endcase
        end
      end
    end
  end


endmodule

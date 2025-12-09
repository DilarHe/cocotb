// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : label_seq_decide

`timescale 1ns/1ps 
module label_seq_decide (
  input  wire          detect_mode,
  input  wire [1:0]    rg_nn_label_num,
  input  wire          rg_label_seq_en,
  input  wire [2:0]    rg_label_seq_length,
  input  wire [1:0]    rg_label_Updown_TH,
  input  wire [1:0]    rg_label_Heavy_TH,
  input  wire [1:0]    area_cnt,
  input  wire          UpDown_label_result_vld,
  input  wire [7:0]    UpDown_label_result_0,
  input  wire [7:0]    UpDown_label_result_1,
  input  wire [7:0]    UpDown_label_result_2,
  input  wire          Heavy_label_result_vld,
  input  wire [15:0]   Heavy_label_result_0,
  input  wire [15:0]   Heavy_label_result_1,
  input  wire [15:0]   Heavy_label_result_2,
  output wire          done,
  output wire          UpDown,
  output wire          Heavy,
  input  wire          clk,
  input  wire          resetn
);
  localparam LABEL_STATE_IDLE = 2'd0;
  localparam LABEL_STATE_Up_Down_PRED_COMP = 2'd1;
  localparam LABEL_STATE_LEB_SEQ = 2'd2;
  localparam LABEL_STATE_Heavy_PRED_COMP = 2'd3;

  wire       [2:0]    tmp_label_0_num_fake_0_1;
  wire       [1:0]    tmp_label_0_num_fake_0_2;
  wire       [1:0]    tmp_label_0_num_fake_0_3;
  wire       [0:0]    tmp_label_0_num_fake_0_4;
  wire       [2:0]    tmp_label_0_num_fake_0_5;
  wire       [1:0]    tmp_label_0_num_fake_0_6;
  wire       [1:0]    tmp_label_0_num_fake_0_7;
  wire       [0:0]    tmp_label_0_num_fake_0_8;
  wire       [3:0]    tmp_label_0_num_fake_0_9;
  wire       [2:0]    tmp_label_0_num_fake_0_10;
  wire       [1:0]    tmp_label_0_num_fake_0_11;
  wire       [1:0]    tmp_label_0_num_fake_0_12;
  wire       [0:0]    tmp_label_0_num_fake_0_13;
  wire       [2:0]    tmp_label_0_num_fake_0_14;
  wire       [1:0]    tmp_label_0_num_fake_0_15;
  wire       [1:0]    tmp_label_0_num_fake_0_16;
  wire       [0:0]    tmp_label_0_num_fake_0_17;
  wire       [2:0]    tmp_label_1_num_0_1;
  wire       [1:0]    tmp_label_1_num_0_2;
  wire       [1:0]    tmp_label_1_num_0_3;
  wire       [0:0]    tmp_label_1_num_0_4;
  wire       [2:0]    tmp_label_1_num_0_5;
  wire       [1:0]    tmp_label_1_num_0_6;
  wire       [1:0]    tmp_label_1_num_0_7;
  wire       [0:0]    tmp_label_1_num_0_8;
  wire       [3:0]    tmp_label_1_num_0_9;
  wire       [2:0]    tmp_label_1_num_0_10;
  wire       [1:0]    tmp_label_1_num_0_11;
  wire       [1:0]    tmp_label_1_num_0_12;
  wire       [0:0]    tmp_label_1_num_0_13;
  wire       [2:0]    tmp_label_1_num_0_14;
  wire       [1:0]    tmp_label_1_num_0_15;
  wire       [1:0]    tmp_label_1_num_0_16;
  wire       [0:0]    tmp_label_1_num_0_17;
  wire       [3:0]    tmp_label_0_num_0;
  wire       [2:0]    tmp_label_0_num_0_1;
  wire       [2:0]    tmp_label_0_num_fake_1_1;
  wire       [1:0]    tmp_label_0_num_fake_1_2;
  wire       [1:0]    tmp_label_0_num_fake_1_3;
  wire       [0:0]    tmp_label_0_num_fake_1_4;
  wire       [2:0]    tmp_label_0_num_fake_1_5;
  wire       [1:0]    tmp_label_0_num_fake_1_6;
  wire       [1:0]    tmp_label_0_num_fake_1_7;
  wire       [0:0]    tmp_label_0_num_fake_1_8;
  wire       [3:0]    tmp_label_0_num_fake_1_9;
  wire       [2:0]    tmp_label_0_num_fake_1_10;
  wire       [1:0]    tmp_label_0_num_fake_1_11;
  wire       [1:0]    tmp_label_0_num_fake_1_12;
  wire       [0:0]    tmp_label_0_num_fake_1_13;
  wire       [2:0]    tmp_label_0_num_fake_1_14;
  wire       [1:0]    tmp_label_0_num_fake_1_15;
  wire       [1:0]    tmp_label_0_num_fake_1_16;
  wire       [0:0]    tmp_label_0_num_fake_1_17;
  wire       [2:0]    tmp_label_1_num_1_1;
  wire       [1:0]    tmp_label_1_num_1_2;
  wire       [1:0]    tmp_label_1_num_1_3;
  wire       [0:0]    tmp_label_1_num_1_4;
  wire       [2:0]    tmp_label_1_num_1_5;
  wire       [1:0]    tmp_label_1_num_1_6;
  wire       [1:0]    tmp_label_1_num_1_7;
  wire       [0:0]    tmp_label_1_num_1_8;
  wire       [3:0]    tmp_label_1_num_1_9;
  wire       [2:0]    tmp_label_1_num_1_10;
  wire       [1:0]    tmp_label_1_num_1_11;
  wire       [1:0]    tmp_label_1_num_1_12;
  wire       [0:0]    tmp_label_1_num_1_13;
  wire       [2:0]    tmp_label_1_num_1_14;
  wire       [1:0]    tmp_label_1_num_1_15;
  wire       [1:0]    tmp_label_1_num_1_16;
  wire       [0:0]    tmp_label_1_num_1_17;
  wire       [3:0]    tmp_label_0_num_1;
  wire       [2:0]    tmp_label_0_num_1_1;
  wire       [2:0]    tmp_label_0_num_fake_2_1;
  wire       [1:0]    tmp_label_0_num_fake_2_2;
  wire       [1:0]    tmp_label_0_num_fake_2_3;
  wire       [0:0]    tmp_label_0_num_fake_2_4;
  wire       [2:0]    tmp_label_0_num_fake_2_5;
  wire       [1:0]    tmp_label_0_num_fake_2_6;
  wire       [1:0]    tmp_label_0_num_fake_2_7;
  wire       [0:0]    tmp_label_0_num_fake_2_8;
  wire       [3:0]    tmp_label_0_num_fake_2_9;
  wire       [2:0]    tmp_label_0_num_fake_2_10;
  wire       [1:0]    tmp_label_0_num_fake_2_11;
  wire       [1:0]    tmp_label_0_num_fake_2_12;
  wire       [0:0]    tmp_label_0_num_fake_2_13;
  wire       [2:0]    tmp_label_0_num_fake_2_14;
  wire       [1:0]    tmp_label_0_num_fake_2_15;
  wire       [1:0]    tmp_label_0_num_fake_2_16;
  wire       [0:0]    tmp_label_0_num_fake_2_17;
  wire       [2:0]    tmp_label_1_num_2_1;
  wire       [1:0]    tmp_label_1_num_2_2;
  wire       [1:0]    tmp_label_1_num_2_3;
  wire       [0:0]    tmp_label_1_num_2_4;
  wire       [2:0]    tmp_label_1_num_2_5;
  wire       [1:0]    tmp_label_1_num_2_6;
  wire       [1:0]    tmp_label_1_num_2_7;
  wire       [0:0]    tmp_label_1_num_2_8;
  wire       [3:0]    tmp_label_1_num_2_9;
  wire       [2:0]    tmp_label_1_num_2_10;
  wire       [1:0]    tmp_label_1_num_2_11;
  wire       [1:0]    tmp_label_1_num_2_12;
  wire       [0:0]    tmp_label_1_num_2_13;
  wire       [2:0]    tmp_label_1_num_2_14;
  wire       [1:0]    tmp_label_1_num_2_15;
  wire       [1:0]    tmp_label_1_num_2_16;
  wire       [0:0]    tmp_label_1_num_2_17;
  wire       [3:0]    tmp_label_0_num_2;
  wire       [2:0]    tmp_label_0_num_2_1;
  wire       [1:0]    tmp_UpDown_flag_num_1;
  wire       [1:0]    tmp_UpDown_flag_num_2;
  wire       [0:0]    tmp_UpDown_flag_num_3;
  wire       [1:0]    tmp_Heavy_flag_num_1;
  wire       [1:0]    tmp_Heavy_flag_num_2;
  wire       [0:0]    tmp_Heavy_flag_num_3;
  reg        [7:0]    tmp_tmp_label_seq_buffer_0;
  reg                 tmp_tmp_label_seq_buffer_0_1;
  reg                 tmp_when;
  wire       [15:0]   tmp_pred_Label_result_in_0;
  wire       [15:0]   tmp_pred_Label_result_in_1;
  wire       [15:0]   tmp_pred_Label_result_in_2;
  reg        [15:0]   tmp_tmp_max_pred;
  reg        [1:0]    curr_state;
  reg        [1:0]    next_state;
  wire                state_is_Up_Down_PRED;
  wire                state_is_Heavy_PRED;
  wire                state_out_Up_Down_Pred;
  wire                pred_cnt_incr;
  reg        [1:0]    pred_cnt;
  wire                pred_cnt_ov;
  wire       [15:0]   pred_Label_result_in_0;
  wire       [15:0]   pred_Label_result_in_1;
  wire       [15:0]   pred_Label_result_in_2;
  reg        [15:0]   max_pred;
  reg        [1:0]    pred_index;
  reg                 label_Up_Down_vld;
  reg                 label_vld_delay;
  reg        [7:0]    label_seq_buffer_0;
  reg        [7:0]    label_seq_buffer_1;
  reg        [7:0]    label_seq_buffer_2;
  wire                label_seq_vec_0_0;
  wire                label_seq_vec_0_1;
  wire                label_seq_vec_0_2;
  wire                label_seq_vec_0_3;
  wire                label_seq_vec_0_4;
  wire                label_seq_vec_0_5;
  wire                label_seq_vec_0_6;
  wire                label_seq_vec_0_7;
  wire                label_seq_vec_1_0;
  wire                label_seq_vec_1_1;
  wire                label_seq_vec_1_2;
  wire                label_seq_vec_1_3;
  wire                label_seq_vec_1_4;
  wire                label_seq_vec_1_5;
  wire                label_seq_vec_1_6;
  wire                label_seq_vec_1_7;
  wire                label_seq_vec_2_0;
  wire                label_seq_vec_2_1;
  wire                label_seq_vec_2_2;
  wire                label_seq_vec_2_3;
  wire                label_seq_vec_2_4;
  wire                label_seq_vec_2_5;
  wire                label_seq_vec_2_6;
  wire                label_seq_vec_2_7;
  wire       [3:0]    label_0_num_fake_0;
  wire       [3:0]    label_0_num_fake_1;
  wire       [3:0]    label_0_num_fake_2;
  wire       [3:0]    label_1_num_0;
  wire       [3:0]    label_1_num_1;
  wire       [3:0]    label_1_num_2;
  wire       [3:0]    label_0_num_0;
  wire       [3:0]    label_0_num_1;
  wire       [3:0]    label_0_num_2;
  wire                label0_is_more_0;
  wire                label0_is_more_1;
  wire                label0_is_more_2;
  wire                tmp_label_0_num_fake_0;
  wire                tmp_label_1_num_0;
  wire                tmp_label_0_num_fake_1;
  wire                tmp_label_1_num_1;
  wire                tmp_label_0_num_fake_2;
  wire                tmp_label_1_num_2;
  reg                 pre_trans_label_0;
  reg                 pre_trans_label_1;
  reg                 pre_trans_label_2;
  reg        [1:0]    pre_trans_heavy_label_0;
  reg        [1:0]    pre_trans_heavy_label_1;
  reg        [1:0]    pre_trans_heavy_label_2;
  reg                 label_Heavy_vld;
  wire       [3:0]    tmp_1;
  wire                UpDown_flag_0;
  wire                UpDown_flag_1;
  wire                UpDown_flag_2;
  wire                Heavy_flag_0;
  wire                Heavy_flag_1;
  wire                Heavy_flag_2;
  wire                tmp_UpDown_flag_num;
  wire       [1:0]    UpDown_flag_num;
  wire                tmp_Heavy_flag_num;
  wire       [1:0]    Heavy_flag_num;
  wire       [7:0]    tmp_label_seq_buffer_0;
  wire       [3:0]    tmp_2;
  wire                tmp_3;
  wire                tmp_4;
  wire                tmp_5;
  wire                tmp_label_seq_buffer_0_1;
  wire       [3:0]    tmp_6;
  wire                tmp_7;
  wire                tmp_8;
  wire                tmp_9;
  wire                tmp_pre_trans_label_0;
  wire       [0:0]    tmp_label_seq_buffer_0_2;
  wire       [1:0]    tmp_label_seq_buffer_0_3;
  wire       [2:0]    tmp_label_seq_buffer_0_4;
  wire       [3:0]    tmp_label_seq_buffer_0_5;
  wire       [4:0]    tmp_label_seq_buffer_0_6;
  wire       [5:0]    tmp_label_seq_buffer_0_7;
  wire       [6:0]    tmp_label_seq_buffer_0_8;
  wire       [15:0]   tmp_max_pred;
  `ifndef SYNTHESIS
  reg [135:0] curr_state_string;
  reg [135:0] next_state_string;
  `endif


  assign tmp_label_0_num_fake_0_1 = ({1'b0,tmp_label_0_num_fake_0_2} + tmp_label_0_num_fake_0_5);
  assign tmp_label_0_num_fake_0_2 = ({1'b0,(label_seq_vec_0_0 == tmp_label_0_num_fake_0)} + tmp_label_0_num_fake_0_3);
  assign tmp_label_0_num_fake_0_4 = (label_seq_vec_0_1 == tmp_label_0_num_fake_0);
  assign tmp_label_0_num_fake_0_3 = {1'd0, tmp_label_0_num_fake_0_4};
  assign tmp_label_0_num_fake_0_6 = ({1'b0,(label_seq_vec_0_2 == tmp_label_0_num_fake_0)} + tmp_label_0_num_fake_0_7);
  assign tmp_label_0_num_fake_0_5 = {1'd0, tmp_label_0_num_fake_0_6};
  assign tmp_label_0_num_fake_0_8 = (label_seq_vec_0_3 == tmp_label_0_num_fake_0);
  assign tmp_label_0_num_fake_0_7 = {1'd0, tmp_label_0_num_fake_0_8};
  assign tmp_label_0_num_fake_0_10 = ({1'b0,tmp_label_0_num_fake_0_11} + tmp_label_0_num_fake_0_14);
  assign tmp_label_0_num_fake_0_9 = {1'd0, tmp_label_0_num_fake_0_10};
  assign tmp_label_0_num_fake_0_11 = ({1'b0,(label_seq_vec_0_4 == tmp_label_0_num_fake_0)} + tmp_label_0_num_fake_0_12);
  assign tmp_label_0_num_fake_0_13 = (label_seq_vec_0_5 == tmp_label_0_num_fake_0);
  assign tmp_label_0_num_fake_0_12 = {1'd0, tmp_label_0_num_fake_0_13};
  assign tmp_label_0_num_fake_0_15 = ({1'b0,(label_seq_vec_0_6 == tmp_label_0_num_fake_0)} + tmp_label_0_num_fake_0_16);
  assign tmp_label_0_num_fake_0_14 = {1'd0, tmp_label_0_num_fake_0_15};
  assign tmp_label_0_num_fake_0_17 = (label_seq_vec_0_7 == tmp_label_0_num_fake_0);
  assign tmp_label_0_num_fake_0_16 = {1'd0, tmp_label_0_num_fake_0_17};
  assign tmp_label_1_num_0_1 = ({1'b0,tmp_label_1_num_0_2} + tmp_label_1_num_0_5);
  assign tmp_label_1_num_0_2 = ({1'b0,(label_seq_vec_0_0 == tmp_label_1_num_0)} + tmp_label_1_num_0_3);
  assign tmp_label_1_num_0_4 = (label_seq_vec_0_1 == tmp_label_1_num_0);
  assign tmp_label_1_num_0_3 = {1'd0, tmp_label_1_num_0_4};
  assign tmp_label_1_num_0_6 = ({1'b0,(label_seq_vec_0_2 == tmp_label_1_num_0)} + tmp_label_1_num_0_7);
  assign tmp_label_1_num_0_5 = {1'd0, tmp_label_1_num_0_6};
  assign tmp_label_1_num_0_8 = (label_seq_vec_0_3 == tmp_label_1_num_0);
  assign tmp_label_1_num_0_7 = {1'd0, tmp_label_1_num_0_8};
  assign tmp_label_1_num_0_10 = ({1'b0,tmp_label_1_num_0_11} + tmp_label_1_num_0_14);
  assign tmp_label_1_num_0_9 = {1'd0, tmp_label_1_num_0_10};
  assign tmp_label_1_num_0_11 = ({1'b0,(label_seq_vec_0_4 == tmp_label_1_num_0)} + tmp_label_1_num_0_12);
  assign tmp_label_1_num_0_13 = (label_seq_vec_0_5 == tmp_label_1_num_0);
  assign tmp_label_1_num_0_12 = {1'd0, tmp_label_1_num_0_13};
  assign tmp_label_1_num_0_15 = ({1'b0,(label_seq_vec_0_6 == tmp_label_1_num_0)} + tmp_label_1_num_0_16);
  assign tmp_label_1_num_0_14 = {1'd0, tmp_label_1_num_0_15};
  assign tmp_label_1_num_0_17 = (label_seq_vec_0_7 == tmp_label_1_num_0);
  assign tmp_label_1_num_0_16 = {1'd0, tmp_label_1_num_0_17};
  assign tmp_label_0_num_0_1 = (3'b111 - rg_label_seq_length);
  assign tmp_label_0_num_0 = {1'd0, tmp_label_0_num_0_1};
  assign tmp_label_0_num_fake_1_1 = ({1'b0,tmp_label_0_num_fake_1_2} + tmp_label_0_num_fake_1_5);
  assign tmp_label_0_num_fake_1_2 = ({1'b0,(label_seq_vec_1_0 == tmp_label_0_num_fake_1)} + tmp_label_0_num_fake_1_3);
  assign tmp_label_0_num_fake_1_4 = (label_seq_vec_1_1 == tmp_label_0_num_fake_1);
  assign tmp_label_0_num_fake_1_3 = {1'd0, tmp_label_0_num_fake_1_4};
  assign tmp_label_0_num_fake_1_6 = ({1'b0,(label_seq_vec_1_2 == tmp_label_0_num_fake_1)} + tmp_label_0_num_fake_1_7);
  assign tmp_label_0_num_fake_1_5 = {1'd0, tmp_label_0_num_fake_1_6};
  assign tmp_label_0_num_fake_1_8 = (label_seq_vec_1_3 == tmp_label_0_num_fake_1);
  assign tmp_label_0_num_fake_1_7 = {1'd0, tmp_label_0_num_fake_1_8};
  assign tmp_label_0_num_fake_1_10 = ({1'b0,tmp_label_0_num_fake_1_11} + tmp_label_0_num_fake_1_14);
  assign tmp_label_0_num_fake_1_9 = {1'd0, tmp_label_0_num_fake_1_10};
  assign tmp_label_0_num_fake_1_11 = ({1'b0,(label_seq_vec_1_4 == tmp_label_0_num_fake_1)} + tmp_label_0_num_fake_1_12);
  assign tmp_label_0_num_fake_1_13 = (label_seq_vec_1_5 == tmp_label_0_num_fake_1);
  assign tmp_label_0_num_fake_1_12 = {1'd0, tmp_label_0_num_fake_1_13};
  assign tmp_label_0_num_fake_1_15 = ({1'b0,(label_seq_vec_1_6 == tmp_label_0_num_fake_1)} + tmp_label_0_num_fake_1_16);
  assign tmp_label_0_num_fake_1_14 = {1'd0, tmp_label_0_num_fake_1_15};
  assign tmp_label_0_num_fake_1_17 = (label_seq_vec_1_7 == tmp_label_0_num_fake_1);
  assign tmp_label_0_num_fake_1_16 = {1'd0, tmp_label_0_num_fake_1_17};
  assign tmp_label_1_num_1_1 = ({1'b0,tmp_label_1_num_1_2} + tmp_label_1_num_1_5);
  assign tmp_label_1_num_1_2 = ({1'b0,(label_seq_vec_1_0 == tmp_label_1_num_1)} + tmp_label_1_num_1_3);
  assign tmp_label_1_num_1_4 = (label_seq_vec_1_1 == tmp_label_1_num_1);
  assign tmp_label_1_num_1_3 = {1'd0, tmp_label_1_num_1_4};
  assign tmp_label_1_num_1_6 = ({1'b0,(label_seq_vec_1_2 == tmp_label_1_num_1)} + tmp_label_1_num_1_7);
  assign tmp_label_1_num_1_5 = {1'd0, tmp_label_1_num_1_6};
  assign tmp_label_1_num_1_8 = (label_seq_vec_1_3 == tmp_label_1_num_1);
  assign tmp_label_1_num_1_7 = {1'd0, tmp_label_1_num_1_8};
  assign tmp_label_1_num_1_10 = ({1'b0,tmp_label_1_num_1_11} + tmp_label_1_num_1_14);
  assign tmp_label_1_num_1_9 = {1'd0, tmp_label_1_num_1_10};
  assign tmp_label_1_num_1_11 = ({1'b0,(label_seq_vec_1_4 == tmp_label_1_num_1)} + tmp_label_1_num_1_12);
  assign tmp_label_1_num_1_13 = (label_seq_vec_1_5 == tmp_label_1_num_1);
  assign tmp_label_1_num_1_12 = {1'd0, tmp_label_1_num_1_13};
  assign tmp_label_1_num_1_15 = ({1'b0,(label_seq_vec_1_6 == tmp_label_1_num_1)} + tmp_label_1_num_1_16);
  assign tmp_label_1_num_1_14 = {1'd0, tmp_label_1_num_1_15};
  assign tmp_label_1_num_1_17 = (label_seq_vec_1_7 == tmp_label_1_num_1);
  assign tmp_label_1_num_1_16 = {1'd0, tmp_label_1_num_1_17};
  assign tmp_label_0_num_1_1 = (3'b111 - rg_label_seq_length);
  assign tmp_label_0_num_1 = {1'd0, tmp_label_0_num_1_1};
  assign tmp_label_0_num_fake_2_1 = ({1'b0,tmp_label_0_num_fake_2_2} + tmp_label_0_num_fake_2_5);
  assign tmp_label_0_num_fake_2_2 = ({1'b0,(label_seq_vec_2_0 == tmp_label_0_num_fake_2)} + tmp_label_0_num_fake_2_3);
  assign tmp_label_0_num_fake_2_4 = (label_seq_vec_2_1 == tmp_label_0_num_fake_2);
  assign tmp_label_0_num_fake_2_3 = {1'd0, tmp_label_0_num_fake_2_4};
  assign tmp_label_0_num_fake_2_6 = ({1'b0,(label_seq_vec_2_2 == tmp_label_0_num_fake_2)} + tmp_label_0_num_fake_2_7);
  assign tmp_label_0_num_fake_2_5 = {1'd0, tmp_label_0_num_fake_2_6};
  assign tmp_label_0_num_fake_2_8 = (label_seq_vec_2_3 == tmp_label_0_num_fake_2);
  assign tmp_label_0_num_fake_2_7 = {1'd0, tmp_label_0_num_fake_2_8};
  assign tmp_label_0_num_fake_2_10 = ({1'b0,tmp_label_0_num_fake_2_11} + tmp_label_0_num_fake_2_14);
  assign tmp_label_0_num_fake_2_9 = {1'd0, tmp_label_0_num_fake_2_10};
  assign tmp_label_0_num_fake_2_11 = ({1'b0,(label_seq_vec_2_4 == tmp_label_0_num_fake_2)} + tmp_label_0_num_fake_2_12);
  assign tmp_label_0_num_fake_2_13 = (label_seq_vec_2_5 == tmp_label_0_num_fake_2);
  assign tmp_label_0_num_fake_2_12 = {1'd0, tmp_label_0_num_fake_2_13};
  assign tmp_label_0_num_fake_2_15 = ({1'b0,(label_seq_vec_2_6 == tmp_label_0_num_fake_2)} + tmp_label_0_num_fake_2_16);
  assign tmp_label_0_num_fake_2_14 = {1'd0, tmp_label_0_num_fake_2_15};
  assign tmp_label_0_num_fake_2_17 = (label_seq_vec_2_7 == tmp_label_0_num_fake_2);
  assign tmp_label_0_num_fake_2_16 = {1'd0, tmp_label_0_num_fake_2_17};
  assign tmp_label_1_num_2_1 = ({1'b0,tmp_label_1_num_2_2} + tmp_label_1_num_2_5);
  assign tmp_label_1_num_2_2 = ({1'b0,(label_seq_vec_2_0 == tmp_label_1_num_2)} + tmp_label_1_num_2_3);
  assign tmp_label_1_num_2_4 = (label_seq_vec_2_1 == tmp_label_1_num_2);
  assign tmp_label_1_num_2_3 = {1'd0, tmp_label_1_num_2_4};
  assign tmp_label_1_num_2_6 = ({1'b0,(label_seq_vec_2_2 == tmp_label_1_num_2)} + tmp_label_1_num_2_7);
  assign tmp_label_1_num_2_5 = {1'd0, tmp_label_1_num_2_6};
  assign tmp_label_1_num_2_8 = (label_seq_vec_2_3 == tmp_label_1_num_2);
  assign tmp_label_1_num_2_7 = {1'd0, tmp_label_1_num_2_8};
  assign tmp_label_1_num_2_10 = ({1'b0,tmp_label_1_num_2_11} + tmp_label_1_num_2_14);
  assign tmp_label_1_num_2_9 = {1'd0, tmp_label_1_num_2_10};
  assign tmp_label_1_num_2_11 = ({1'b0,(label_seq_vec_2_4 == tmp_label_1_num_2)} + tmp_label_1_num_2_12);
  assign tmp_label_1_num_2_13 = (label_seq_vec_2_5 == tmp_label_1_num_2);
  assign tmp_label_1_num_2_12 = {1'd0, tmp_label_1_num_2_13};
  assign tmp_label_1_num_2_15 = ({1'b0,(label_seq_vec_2_6 == tmp_label_1_num_2)} + tmp_label_1_num_2_16);
  assign tmp_label_1_num_2_14 = {1'd0, tmp_label_1_num_2_15};
  assign tmp_label_1_num_2_17 = (label_seq_vec_2_7 == tmp_label_1_num_2);
  assign tmp_label_1_num_2_16 = {1'd0, tmp_label_1_num_2_17};
  assign tmp_label_0_num_2_1 = (3'b111 - rg_label_seq_length);
  assign tmp_label_0_num_2 = {1'd0, tmp_label_0_num_2_1};
  assign tmp_UpDown_flag_num_1 = ({1'b0,(UpDown_flag_1 == tmp_UpDown_flag_num)} + tmp_UpDown_flag_num_2);
  assign tmp_UpDown_flag_num_3 = (UpDown_flag_2 == tmp_UpDown_flag_num);
  assign tmp_UpDown_flag_num_2 = {1'd0, tmp_UpDown_flag_num_3};
  assign tmp_Heavy_flag_num_1 = ({1'b0,(Heavy_flag_1 == tmp_Heavy_flag_num)} + tmp_Heavy_flag_num_2);
  assign tmp_Heavy_flag_num_3 = (Heavy_flag_2 == tmp_Heavy_flag_num);
  assign tmp_Heavy_flag_num_2 = {1'd0, tmp_Heavy_flag_num_3};
  assign tmp_pred_Label_result_in_0 = {{8{UpDown_label_result_0[7]}}, UpDown_label_result_0};
  assign tmp_pred_Label_result_in_1 = {{8{UpDown_label_result_1[7]}}, UpDown_label_result_1};
  assign tmp_pred_Label_result_in_2 = {{8{UpDown_label_result_2[7]}}, UpDown_label_result_2};
  always @(*) begin
    case(area_cnt)
      2'b00 : begin
        tmp_tmp_label_seq_buffer_0 = label_seq_buffer_0;
        tmp_tmp_label_seq_buffer_0_1 = pre_trans_label_0;
        tmp_when = label0_is_more_0;
      end
      2'b01 : begin
        tmp_tmp_label_seq_buffer_0 = label_seq_buffer_1;
        tmp_tmp_label_seq_buffer_0_1 = pre_trans_label_1;
        tmp_when = label0_is_more_1;
      end
      default : begin
        tmp_tmp_label_seq_buffer_0 = label_seq_buffer_2;
        tmp_tmp_label_seq_buffer_0_1 = pre_trans_label_2;
        tmp_when = label0_is_more_2;
      end
    endcase
  end

  always @(*) begin
    case(pred_cnt)
      2'b00 : tmp_tmp_max_pred = pred_Label_result_in_0;
      2'b01 : tmp_tmp_max_pred = pred_Label_result_in_1;
      default : tmp_tmp_max_pred = pred_Label_result_in_2;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(curr_state)
      LABEL_STATE_IDLE : curr_state_string = "IDLE             ";
      LABEL_STATE_Up_Down_PRED_COMP : curr_state_string = "Up_Down_PRED_COMP";
      LABEL_STATE_LEB_SEQ : curr_state_string = "LEB_SEQ          ";
      LABEL_STATE_Heavy_PRED_COMP : curr_state_string = "Heavy_PRED_COMP  ";
      default : curr_state_string = "?????????????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      LABEL_STATE_IDLE : next_state_string = "IDLE             ";
      LABEL_STATE_Up_Down_PRED_COMP : next_state_string = "Up_Down_PRED_COMP";
      LABEL_STATE_LEB_SEQ : next_state_string = "LEB_SEQ          ";
      LABEL_STATE_Heavy_PRED_COMP : next_state_string = "Heavy_PRED_COMP  ";
      default : next_state_string = "?????????????????";
    endcase
  end
  `endif

  assign state_is_Up_Down_PRED = (curr_state == LABEL_STATE_Up_Down_PRED_COMP);
  assign state_is_Heavy_PRED = (curr_state == LABEL_STATE_Heavy_PRED_COMP);
  assign state_out_Up_Down_Pred = (state_is_Up_Down_PRED && (next_state != LABEL_STATE_Up_Down_PRED_COMP));
  assign pred_cnt_incr = (state_is_Up_Down_PRED || state_is_Heavy_PRED);
  assign pred_cnt_ov = (pred_cnt == rg_nn_label_num);
  assign label_seq_vec_0_0 = label_seq_buffer_0[0];
  assign label_seq_vec_0_1 = label_seq_buffer_0[1];
  assign label_seq_vec_0_2 = label_seq_buffer_0[2];
  assign label_seq_vec_0_3 = label_seq_buffer_0[3];
  assign label_seq_vec_0_4 = label_seq_buffer_0[4];
  assign label_seq_vec_0_5 = label_seq_buffer_0[5];
  assign label_seq_vec_0_6 = label_seq_buffer_0[6];
  assign label_seq_vec_0_7 = label_seq_buffer_0[7];
  assign label_seq_vec_1_0 = label_seq_buffer_1[0];
  assign label_seq_vec_1_1 = label_seq_buffer_1[1];
  assign label_seq_vec_1_2 = label_seq_buffer_1[2];
  assign label_seq_vec_1_3 = label_seq_buffer_1[3];
  assign label_seq_vec_1_4 = label_seq_buffer_1[4];
  assign label_seq_vec_1_5 = label_seq_buffer_1[5];
  assign label_seq_vec_1_6 = label_seq_buffer_1[6];
  assign label_seq_vec_1_7 = label_seq_buffer_1[7];
  assign label_seq_vec_2_0 = label_seq_buffer_2[0];
  assign label_seq_vec_2_1 = label_seq_buffer_2[1];
  assign label_seq_vec_2_2 = label_seq_buffer_2[2];
  assign label_seq_vec_2_3 = label_seq_buffer_2[3];
  assign label_seq_vec_2_4 = label_seq_buffer_2[4];
  assign label_seq_vec_2_5 = label_seq_buffer_2[5];
  assign label_seq_vec_2_6 = label_seq_buffer_2[6];
  assign label_seq_vec_2_7 = label_seq_buffer_2[7];
  assign tmp_label_0_num_fake_0 = 1'b0;
  assign label_0_num_fake_0 = ({1'b0,tmp_label_0_num_fake_0_1} + tmp_label_0_num_fake_0_9);
  assign tmp_label_1_num_0 = 1'b1;
  assign label_1_num_0 = ({1'b0,tmp_label_1_num_0_1} + tmp_label_1_num_0_9);
  assign label_0_num_0 = (label_0_num_fake_0 - tmp_label_0_num_0);
  assign label0_is_more_0 = (label_1_num_0 <= label_0_num_0);
  assign tmp_label_0_num_fake_1 = 1'b0;
  assign label_0_num_fake_1 = ({1'b0,tmp_label_0_num_fake_1_1} + tmp_label_0_num_fake_1_9);
  assign tmp_label_1_num_1 = 1'b1;
  assign label_1_num_1 = ({1'b0,tmp_label_1_num_1_1} + tmp_label_1_num_1_9);
  assign label_0_num_1 = (label_0_num_fake_1 - tmp_label_0_num_1);
  assign label0_is_more_1 = (label_1_num_1 <= label_0_num_1);
  assign tmp_label_0_num_fake_2 = 1'b0;
  assign label_0_num_fake_2 = ({1'b0,tmp_label_0_num_fake_2_1} + tmp_label_0_num_fake_2_9);
  assign tmp_label_1_num_2 = 1'b1;
  assign label_1_num_2 = ({1'b0,tmp_label_1_num_2_1} + tmp_label_1_num_2_9);
  assign label_0_num_2 = (label_0_num_fake_2 - tmp_label_0_num_2);
  assign label0_is_more_2 = (label_1_num_2 <= label_0_num_2);
  assign tmp_1 = ({3'd0,1'b1} <<< area_cnt);
  assign tmp_UpDown_flag_num = 1'b1;
  assign UpDown_flag_num = ({1'b0,(UpDown_flag_0 == tmp_UpDown_flag_num)} + tmp_UpDown_flag_num_1);
  assign tmp_Heavy_flag_num = 1'b1;
  assign Heavy_flag_num = ({1'b0,(Heavy_flag_0 == tmp_Heavy_flag_num)} + tmp_Heavy_flag_num_1);
  assign UpDown_flag_0 = (detect_mode ? (pre_trans_label_0 && (pre_trans_heavy_label_0 != 2'b00)) : pre_trans_label_0);
  assign Heavy_flag_0 = (detect_mode ? ((pre_trans_heavy_label_0 == 2'b10) && pre_trans_label_0) : 1'b0);
  assign UpDown_flag_1 = (detect_mode ? (pre_trans_label_1 && (pre_trans_heavy_label_1 != 2'b00)) : pre_trans_label_1);
  assign Heavy_flag_1 = (detect_mode ? ((pre_trans_heavy_label_1 == 2'b10) && pre_trans_label_1) : 1'b0);
  assign UpDown_flag_2 = (detect_mode ? (pre_trans_label_2 && (pre_trans_heavy_label_2 != 2'b00)) : pre_trans_label_2);
  assign Heavy_flag_2 = (detect_mode ? ((pre_trans_heavy_label_2 == 2'b10) && pre_trans_label_2) : 1'b0);
  assign done = label_Heavy_vld;
  assign UpDown = (rg_label_Updown_TH < UpDown_flag_num);
  assign Heavy = ((rg_label_Heavy_TH < Heavy_flag_num) && (rg_label_Updown_TH < UpDown_flag_num));
  assign tmp_label_seq_buffer_0 = tmp_tmp_label_seq_buffer_0;
  assign tmp_2 = ({3'd0,1'b1} <<< area_cnt);
  assign tmp_3 = tmp_2[0];
  assign tmp_4 = tmp_2[1];
  assign tmp_5 = tmp_2[2];
  assign tmp_label_seq_buffer_0_1 = tmp_tmp_label_seq_buffer_0_1;
  assign tmp_6 = ({3'd0,1'b1} <<< area_cnt);
  assign tmp_7 = tmp_6[0];
  assign tmp_8 = tmp_6[1];
  assign tmp_9 = tmp_6[2];
  assign tmp_pre_trans_label_0 = (pred_index == 2'b01);
  assign tmp_label_seq_buffer_0_2 = tmp_label_seq_buffer_0[1 : 1];
  assign tmp_label_seq_buffer_0_3 = tmp_label_seq_buffer_0[2 : 1];
  assign tmp_label_seq_buffer_0_4 = tmp_label_seq_buffer_0[3 : 1];
  assign tmp_label_seq_buffer_0_5 = tmp_label_seq_buffer_0[4 : 1];
  assign tmp_label_seq_buffer_0_6 = tmp_label_seq_buffer_0[5 : 1];
  assign tmp_label_seq_buffer_0_7 = tmp_label_seq_buffer_0[6 : 1];
  assign tmp_label_seq_buffer_0_8 = tmp_label_seq_buffer_0[7 : 1];
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      LABEL_STATE_IDLE : begin
        if(UpDown_label_result_vld) begin
          next_state = LABEL_STATE_Up_Down_PRED_COMP;
        end else begin
          if(Heavy_label_result_vld) begin
            next_state = LABEL_STATE_Heavy_PRED_COMP;
          end
        end
      end
      LABEL_STATE_Up_Down_PRED_COMP : begin
        if(pred_cnt_ov) begin
          if(rg_label_seq_en) begin
            next_state = LABEL_STATE_LEB_SEQ;
          end else begin
            next_state = LABEL_STATE_IDLE;
          end
        end
      end
      LABEL_STATE_LEB_SEQ : begin
        if(label_vld_delay) begin
          next_state = LABEL_STATE_IDLE;
        end
      end
      default : begin
        if(pred_cnt_ov) begin
          next_state = LABEL_STATE_IDLE;
        end
      end
    endcase
  end

  assign pred_Label_result_in_0 = (state_is_Up_Down_PRED ? tmp_pred_Label_result_in_0 : Heavy_label_result_0);
  assign pred_Label_result_in_1 = (state_is_Up_Down_PRED ? tmp_pred_Label_result_in_1 : Heavy_label_result_1);
  assign pred_Label_result_in_2 = (state_is_Up_Down_PRED ? tmp_pred_Label_result_in_2 : Heavy_label_result_2);
  assign tmp_max_pred = tmp_tmp_max_pred;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      curr_state <= LABEL_STATE_IDLE;
      pred_cnt <= 2'b00;
      max_pred <= 16'h0;
      pred_index <= 2'b00;
      label_Up_Down_vld <= 1'b0;
      label_vld_delay <= 1'b0;
      label_seq_buffer_0 <= 8'h0;
      label_seq_buffer_1 <= 8'h0;
      label_seq_buffer_2 <= 8'h0;
      pre_trans_label_0 <= 1'b0;
      pre_trans_label_1 <= 1'b0;
      pre_trans_label_2 <= 1'b0;
      pre_trans_heavy_label_0 <= 2'b00;
      pre_trans_heavy_label_1 <= 2'b00;
      pre_trans_heavy_label_2 <= 2'b00;
      label_Heavy_vld <= 1'b0;
    end else begin
      label_Up_Down_vld <= state_out_Up_Down_Pred;
      label_vld_delay <= label_Up_Down_vld;
      label_Heavy_vld <= (state_is_Heavy_PRED && pred_cnt_ov);
      if(label_Heavy_vld) begin
        if(tmp_1[0]) begin
          pre_trans_heavy_label_0 <= pred_index;
        end
        if(tmp_1[1]) begin
          pre_trans_heavy_label_1 <= pred_index;
        end
        if(tmp_1[2]) begin
          pre_trans_heavy_label_2 <= pred_index;
        end
      end
      if((label_Up_Down_vld && rg_label_seq_en)) begin
        if((pred_index == 2'b10)) begin
          if((tmp_label_seq_buffer_0[rg_label_seq_length] == 1'b0)) begin
            if(tmp_7) begin
              pre_trans_label_0 <= 1'b0;
            end
            if(tmp_8) begin
              pre_trans_label_1 <= 1'b0;
            end
            if(tmp_9) begin
              pre_trans_label_2 <= 1'b0;
            end
          end else begin
            if(tmp_when) begin
              if(tmp_7) begin
                pre_trans_label_0 <= 1'b0;
              end
              if(tmp_8) begin
                pre_trans_label_1 <= 1'b0;
              end
              if(tmp_9) begin
                pre_trans_label_2 <= 1'b0;
              end
            end else begin
              if(tmp_7) begin
                pre_trans_label_0 <= 1'b1;
              end
              if(tmp_8) begin
                pre_trans_label_1 <= 1'b1;
              end
              if(tmp_9) begin
                pre_trans_label_2 <= 1'b1;
              end
            end
          end
        end else begin
          if(tmp_7) begin
            pre_trans_label_0 <= tmp_pre_trans_label_0;
          end
          if(tmp_8) begin
            pre_trans_label_1 <= tmp_pre_trans_label_0;
          end
          if(tmp_9) begin
            pre_trans_label_2 <= tmp_pre_trans_label_0;
          end
        end
      end else begin
        if(label_Up_Down_vld) begin
          if((pred_index == 2'b00)) begin
            if(tmp_7) begin
              pre_trans_label_0 <= 1'b0;
            end
            if(tmp_8) begin
              pre_trans_label_1 <= 1'b0;
            end
            if(tmp_9) begin
              pre_trans_label_2 <= 1'b0;
            end
          end else begin
            if((pred_index == 2'b01)) begin
              if(tmp_7) begin
                pre_trans_label_0 <= 1'b1;
              end
              if(tmp_8) begin
                pre_trans_label_1 <= 1'b1;
              end
              if(tmp_9) begin
                pre_trans_label_2 <= 1'b1;
              end
            end else begin
              if(tmp_7) begin
                pre_trans_label_0 <= 1'b0;
              end
              if(tmp_8) begin
                pre_trans_label_1 <= 1'b0;
              end
              if(tmp_9) begin
                pre_trans_label_2 <= 1'b0;
              end
            end
          end
        end
      end
      if((label_vld_delay && rg_label_seq_en)) begin
        case(rg_label_seq_length)
          3'b000 : begin
            if(tmp_3) begin
              label_seq_buffer_0[0] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_4) begin
              label_seq_buffer_1[0] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_5) begin
              label_seq_buffer_2[0] <= tmp_label_seq_buffer_0_1;
            end
          end
          3'b001 : begin
            if(tmp_3) begin
              label_seq_buffer_0[0 : 0] <= tmp_label_seq_buffer_0_2;
            end
            if(tmp_4) begin
              label_seq_buffer_1[0 : 0] <= tmp_label_seq_buffer_0_2;
            end
            if(tmp_5) begin
              label_seq_buffer_2[0 : 0] <= tmp_label_seq_buffer_0_2;
            end
            if(tmp_3) begin
              label_seq_buffer_0[1] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_4) begin
              label_seq_buffer_1[1] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_5) begin
              label_seq_buffer_2[1] <= tmp_label_seq_buffer_0_1;
            end
          end
          3'b010 : begin
            if(tmp_3) begin
              label_seq_buffer_0[1 : 0] <= tmp_label_seq_buffer_0_3;
            end
            if(tmp_4) begin
              label_seq_buffer_1[1 : 0] <= tmp_label_seq_buffer_0_3;
            end
            if(tmp_5) begin
              label_seq_buffer_2[1 : 0] <= tmp_label_seq_buffer_0_3;
            end
            if(tmp_3) begin
              label_seq_buffer_0[2] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_4) begin
              label_seq_buffer_1[2] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_5) begin
              label_seq_buffer_2[2] <= tmp_label_seq_buffer_0_1;
            end
          end
          3'b011 : begin
            if(tmp_3) begin
              label_seq_buffer_0[2 : 0] <= tmp_label_seq_buffer_0_4;
            end
            if(tmp_4) begin
              label_seq_buffer_1[2 : 0] <= tmp_label_seq_buffer_0_4;
            end
            if(tmp_5) begin
              label_seq_buffer_2[2 : 0] <= tmp_label_seq_buffer_0_4;
            end
            if(tmp_3) begin
              label_seq_buffer_0[3] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_4) begin
              label_seq_buffer_1[3] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_5) begin
              label_seq_buffer_2[3] <= tmp_label_seq_buffer_0_1;
            end
          end
          3'b100 : begin
            if(tmp_3) begin
              label_seq_buffer_0[3 : 0] <= tmp_label_seq_buffer_0_5;
            end
            if(tmp_4) begin
              label_seq_buffer_1[3 : 0] <= tmp_label_seq_buffer_0_5;
            end
            if(tmp_5) begin
              label_seq_buffer_2[3 : 0] <= tmp_label_seq_buffer_0_5;
            end
            if(tmp_3) begin
              label_seq_buffer_0[4] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_4) begin
              label_seq_buffer_1[4] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_5) begin
              label_seq_buffer_2[4] <= tmp_label_seq_buffer_0_1;
            end
          end
          3'b101 : begin
            if(tmp_3) begin
              label_seq_buffer_0[4 : 0] <= tmp_label_seq_buffer_0_6;
            end
            if(tmp_4) begin
              label_seq_buffer_1[4 : 0] <= tmp_label_seq_buffer_0_6;
            end
            if(tmp_5) begin
              label_seq_buffer_2[4 : 0] <= tmp_label_seq_buffer_0_6;
            end
            if(tmp_3) begin
              label_seq_buffer_0[5] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_4) begin
              label_seq_buffer_1[5] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_5) begin
              label_seq_buffer_2[5] <= tmp_label_seq_buffer_0_1;
            end
          end
          3'b110 : begin
            if(tmp_3) begin
              label_seq_buffer_0[5 : 0] <= tmp_label_seq_buffer_0_7;
            end
            if(tmp_4) begin
              label_seq_buffer_1[5 : 0] <= tmp_label_seq_buffer_0_7;
            end
            if(tmp_5) begin
              label_seq_buffer_2[5 : 0] <= tmp_label_seq_buffer_0_7;
            end
            if(tmp_3) begin
              label_seq_buffer_0[6] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_4) begin
              label_seq_buffer_1[6] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_5) begin
              label_seq_buffer_2[6] <= tmp_label_seq_buffer_0_1;
            end
          end
          default : begin
            if(tmp_3) begin
              label_seq_buffer_0[6 : 0] <= tmp_label_seq_buffer_0_8;
            end
            if(tmp_4) begin
              label_seq_buffer_1[6 : 0] <= tmp_label_seq_buffer_0_8;
            end
            if(tmp_5) begin
              label_seq_buffer_2[6 : 0] <= tmp_label_seq_buffer_0_8;
            end
            if(tmp_3) begin
              label_seq_buffer_0[7] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_4) begin
              label_seq_buffer_1[7] <= tmp_label_seq_buffer_0_1;
            end
            if(tmp_5) begin
              label_seq_buffer_2[7] <= tmp_label_seq_buffer_0_1;
            end
          end
        endcase
      end
      curr_state <= next_state;
      if(pred_cnt_incr) begin
        if(pred_cnt_ov) begin
          pred_cnt <= 2'b00;
        end else begin
          pred_cnt <= (pred_cnt + 2'b01);
        end
      end
      if(((pred_cnt == 2'b00) && pred_cnt_incr)) begin
        max_pred <= pred_Label_result_in_0;
        pred_index <= 2'b00;
      end else begin
        if(pred_cnt_incr) begin
          if(($signed(max_pred) < $signed(tmp_max_pred))) begin
            max_pred <= tmp_max_pred;
            pred_index <= pred_cnt;
          end
        end
      end
    end
  end


endmodule

// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : matmul

`timescale 1ns/1ps 
module matmul (
  input  wire          start,
  input  wire          need_relu,
  input  wire          need_scale,
  input  wire          is_fc_layer,
  input  wire          is_scala_mult,
  input  wire          is_hidden_layer,
  input  wire [2:0]    rg_nn_data_ratio,
  input  wire [2:0]    input_loop_num,
  input  wire [2:0]    output_loop_num,
  input  wire [6:0]    curr_layer_result_line_num,
  input  wire          psum_come_from_coef,
  input  wire [9:0]    psum_base_addr,
  input  wire [9:0]    weight_base_addr,
  input  wire [6:0]    input_base_addr,
  input  wire [6:0]    output_base_addr,
  output reg           coef_ena,
  output reg           coef_wena,
  output reg  [9:0]    coef_addr,
  output reg  [63:0]   coef_wdata,
  input  wire [63:0]   coef_rdata,
  output reg           cache_ena,
  output reg           cache_wena,
  output reg  [6:0]    cache_addr,
  output reg  [63:0]   cache_wdata,
  input  wire [63:0]   cache_rdata,
  output wire          done,
  output wire          scala_psum_out_vld,
  output wire [21:0]   scala_psum_out_0,
  output wire [21:0]   scala_psum_out_1,
  output wire [21:0]   scala_psum_out_2,
  input  wire          clkout,
  input  wire          resetn
);
  localparam MATMUL_STATE_IDLE = 3'd0;
  localparam MATMUL_STATE_LOAD_PSUM1 = 3'd1;
  localparam MATMUL_STATE_LOAD_PSUM2 = 3'd2;
  localparam MATMUL_STATE_LOAD_PSUM3 = 3'd3;
  localparam MATMUL_STATE_LOAD_PSUM4 = 3'd4;
  localparam MATMUL_STATE_MAC = 3'd5;

  wire                mac_clka;
  wire                mac_rstn_a;
  wire                mac_valid;
  wire       [7:0]    mac_A_0;
  wire       [7:0]    mac_A_1;
  wire       [7:0]    mac_A_2;
  wire       [7:0]    mac_A_3;
  wire       [7:0]    mac_A_4;
  wire       [7:0]    mac_A_5;
  wire       [7:0]    mac_A_6;
  wire       [7:0]    mac_A_7;
  wire       [21:0]   mac_psum_in;
  wire       [15:0]   mac_mult_out_0;
  wire       [15:0]   mac_mult_out_1;
  wire       [15:0]   mac_mult_out_2;
  wire       [15:0]   mac_mult_out_3;
  wire       [15:0]   mac_mult_out_4;
  wire       [15:0]   mac_mult_out_5;
  wire       [15:0]   mac_mult_out_6;
  wire       [15:0]   mac_mult_out_7;
  wire       [21:0]   mac_psum_out;
  wire                mac_psum_acc_valid;
  wire       [3:0]    tmp_Iter_outLoopCnt_ov;
  wire       [3:0]    tmp_Iter_outLoopCnt_ov_1;
  wire       [1:0]    tmp_Iter_outLoopCnt_ov_2;
  reg        [21:0]   tmp_psum_in;
  wire       [21:0]   tmp_mac_psum_buffer_4;
  wire       [15:0]   tmp_mac_psum_buffer_4_1;
  wire       [21:0]   tmp_mac_psum_buffer_5;
  wire       [15:0]   tmp_mac_psum_buffer_5_1;
  wire       [21:0]   tmp_mac_psum_buffer_6;
  wire       [15:0]   tmp_mac_psum_buffer_6_1;
  wire       [21:0]   tmp_mac_psum_buffer_7;
  wire       [15:0]   tmp_mac_psum_buffer_7_1;
  wire       [21:0]   tmp_mac_psum_buffer_0;
  wire       [15:0]   tmp_mac_psum_buffer_0_1;
  wire       [21:0]   tmp_mac_psum_buffer_1;
  wire       [15:0]   tmp_mac_psum_buffer_1_1;
  wire       [21:0]   tmp_mac_psum_buffer_2;
  wire       [15:0]   tmp_mac_psum_buffer_2_1;
  wire       [21:0]   tmp_mac_psum_buffer_3;
  wire       [15:0]   tmp_mac_psum_buffer_3_1;
  wire       [21:0]   tmp_mac_psum_buffer_6_2;
  wire       [31:0]   tmp_mac_psum_buffer_6_3;
  wire       [21:0]   tmp_mac_psum_buffer_7_2;
  wire       [31:0]   tmp_mac_psum_buffer_7_3;
  wire       [21:0]   tmp_mac_psum_buffer_4_2;
  wire       [31:0]   tmp_mac_psum_buffer_4_3;
  wire       [21:0]   tmp_mac_psum_buffer_5_2;
  wire       [31:0]   tmp_mac_psum_buffer_5_3;
  wire       [21:0]   tmp_mac_psum_buffer_2_2;
  wire       [31:0]   tmp_mac_psum_buffer_2_3;
  wire       [21:0]   tmp_mac_psum_buffer_3_2;
  wire       [31:0]   tmp_mac_psum_buffer_3_3;
  wire       [21:0]   tmp_mac_psum_buffer_0_2;
  wire       [31:0]   tmp_mac_psum_buffer_0_3;
  wire       [21:0]   tmp_mac_psum_buffer_1_2;
  wire       [31:0]   tmp_mac_psum_buffer_1_3;
  wire       [21:0]   tmp_mac_psum_buffer_0_4;
  wire       [21:0]   tmp_mac_psum_buffer_1_4;
  wire       [21:0]   tmp_mac_psum_buffer_2_4;
  wire       [21:0]   tmp_mac_psum_buffer_3_4;
  wire       [21:0]   tmp_mac_psum_buffer_4_4;
  wire       [21:0]   tmp_mac_psum_buffer_5_4;
  wire       [21:0]   tmp_mac_psum_buffer_6_4;
  wire       [21:0]   tmp_mac_psum_buffer_7_4;
  wire       [31:0]   tmp_mac_psum_out_32b_0_0;
  wire       [31:0]   tmp_mac_psum_out_32b_1_0;
  wire       [31:0]   tmp_mac_psum_out_32b_2_0;
  wire       [31:0]   tmp_mac_psum_out_32b_3_0;
  wire       [31:0]   tmp_mac_psum_out_32b_0_0_1;
  wire       [21:0]   tmp_mac_psum_out_32b_0_0_2;
  wire       [31:0]   tmp_mac_psum_out_32b_1_0_1;
  wire       [21:0]   tmp_mac_psum_out_32b_1_0_2;
  wire       [31:0]   tmp_mac_psum_out_32b_2_0_1;
  wire       [21:0]   tmp_mac_psum_out_32b_2_0_2;
  wire       [31:0]   tmp_mac_psum_out_32b_3_0_1;
  wire       [21:0]   tmp_mac_psum_out_32b_3_0_2;
  wire       [31:0]   tmp_mac_psum_out_32b_0_1;
  wire       [31:0]   tmp_mac_psum_out_32b_1_1;
  wire       [31:0]   tmp_mac_psum_out_32b_2_1;
  wire       [31:0]   tmp_mac_psum_out_32b_3_1;
  wire       [31:0]   tmp_mac_psum_out_32b_0_1_1;
  wire       [21:0]   tmp_mac_psum_out_32b_0_1_2;
  wire       [31:0]   tmp_mac_psum_out_32b_1_1_1;
  wire       [21:0]   tmp_mac_psum_out_32b_1_1_2;
  wire       [31:0]   tmp_mac_psum_out_32b_2_1_1;
  wire       [21:0]   tmp_mac_psum_out_32b_2_1_2;
  wire       [31:0]   tmp_mac_psum_out_32b_3_1_1;
  wire       [21:0]   tmp_mac_psum_out_32b_3_1_2;
  wire       [21:0]   tmp_tmp_mac_psum_buffer_scale_0;
  wire       [6:0]    tmp_when;
  wire       [5:0]    tmp_when_1;
  wire       [8:0]    tmp_when_2;
  wire       [7:0]    tmp_when_3;
  wire       [7:0]    tmp_when_4;
  wire       [21:0]   tmp_tmp_mac_psum_buffer_scale_1;
  wire       [6:0]    tmp_when_5;
  wire       [5:0]    tmp_when_6;
  wire       [8:0]    tmp_when_7;
  wire       [7:0]    tmp_when_8;
  wire       [7:0]    tmp_when_9;
  wire       [21:0]   tmp_tmp_mac_psum_buffer_scale_2;
  wire       [6:0]    tmp_when_10;
  wire       [5:0]    tmp_when_11;
  wire       [8:0]    tmp_when_12;
  wire       [7:0]    tmp_when_13;
  wire       [7:0]    tmp_when_14;
  wire       [21:0]   tmp_tmp_mac_psum_buffer_scale_3;
  wire       [6:0]    tmp_when_15;
  wire       [5:0]    tmp_when_16;
  wire       [8:0]    tmp_when_17;
  wire       [7:0]    tmp_when_18;
  wire       [7:0]    tmp_when_19;
  wire       [21:0]   tmp_tmp_mac_psum_buffer_scale_4;
  wire       [6:0]    tmp_when_20;
  wire       [5:0]    tmp_when_21;
  wire       [8:0]    tmp_when_22;
  wire       [7:0]    tmp_when_23;
  wire       [7:0]    tmp_when_24;
  wire       [21:0]   tmp_tmp_mac_psum_buffer_scale_5;
  wire       [6:0]    tmp_when_25;
  wire       [5:0]    tmp_when_26;
  wire       [8:0]    tmp_when_27;
  wire       [7:0]    tmp_when_28;
  wire       [7:0]    tmp_when_29;
  wire       [21:0]   tmp_tmp_mac_psum_buffer_scale_6;
  wire       [6:0]    tmp_when_30;
  wire       [5:0]    tmp_when_31;
  wire       [8:0]    tmp_when_32;
  wire       [7:0]    tmp_when_33;
  wire       [7:0]    tmp_when_34;
  wire       [21:0]   tmp_tmp_mac_psum_buffer_scale_7;
  wire       [6:0]    tmp_when_35;
  wire       [5:0]    tmp_when_36;
  wire       [8:0]    tmp_when_37;
  wire       [7:0]    tmp_when_38;
  wire       [7:0]    tmp_when_39;
  wire       [9:0]    tmp_coef_addr;
  wire       [4:0]    tmp_coef_addr_1;
  wire       [9:0]    tmp_coef_addr_2;
  wire       [9:0]    tmp_coef_addr_3;
  wire       [4:0]    tmp_coef_addr_4;
  wire       [9:0]    tmp_cache_addr;
  wire       [9:0]    tmp_cache_addr_1;
  wire       [5:0]    tmp_cache_addr_2;
  wire       [9:0]    tmp_cache_addr_3;
  wire       [9:0]    tmp_cache_addr_4;
  wire       [9:0]    tmp_cache_addr_5;
  wire       [5:0]    tmp_cache_addr_6;
  wire       [9:0]    tmp_cache_addr_7;
  wire       [9:0]    tmp_cache_addr_8;
  wire       [9:0]    tmp_cache_addr_9;
  wire       [5:0]    tmp_cache_addr_10;
  wire       [9:0]    tmp_cache_addr_11;
  wire       [9:0]    tmp_cache_addr_12;
  wire       [9:0]    tmp_cache_addr_13;
  wire       [5:0]    tmp_cache_addr_14;
  wire       [6:0]    tmp_cache_addr_15;
  wire       [6:0]    tmp_cache_addr_16;
  wire       [6:0]    tmp_cache_addr_17;
  wire       [6:0]    tmp_cache_addr_18;
  wire       [5:0]    tmp_cache_addr_19;
  wire       [6:0]    tmp_cache_addr_20;
  wire       [6:0]    tmp_cache_addr_21;
  wire       [6:0]    tmp_cache_addr_22;
  wire       [5:0]    tmp_cache_addr_23;
  wire       [6:0]    tmp_cache_addr_24;
  wire       [6:0]    tmp_cache_addr_25;
  wire       [6:0]    tmp_cache_addr_26;
  wire       [5:0]    tmp_cache_addr_27;
  wire       [6:0]    tmp_cache_addr_28;
  wire       [6:0]    tmp_cache_addr_29;
  wire       [6:0]    tmp_cache_addr_30;
  wire       [5:0]    tmp_cache_addr_31;
  reg        [2:0]    curr_state;
  reg        [2:0]    next_state;
  wire                state_is_idle;
  wire                state_is_load_psum1;
  wire                statein_load_psum1;
  wire                state_is_load_psum2;
  wire                statein_load_psum2;
  wire                state_is_load_psum3;
  wire                statein_load_psum3;
  wire                state_is_load_psum4;
  wire                statein_load_psum4;
  reg        [2:0]    Iter_inCnt;
  wire                Iter_inCnt_inc;
  reg                 Iter_inCnt_inc_not;
  wire                Iter_inCnt_ov;
  reg        [2:0]    Iter_sliceCnt;
  wire                Iter_sliceCnt_ov;
  reg        [3:0]    Iter_outLoopCnt;
  wire                Iter_outLoopCnt_ov;
  reg        [9:0]    weight_read_addr;
  reg                 psum1_read_out_flag;
  reg                 psum2_read_out_flag;
  reg                 psum3_read_out_flag;
  reg                 psum4_read_out_flag;
  wire                psum1_read_bias;
  wire                psum2_read_bias;
  wire                psum1_read_psum;
  wire                psum2_read_psum;
  wire                psum3_read_psum;
  wire                psum4_read_psum;
  wire                psum1_read_scala;
  wire                psum2_read_scala;
  reg                 tmp_switch_psum_pulse;
  reg                 tmp_switch_psum_pulse_1;
  reg                 tmp_switch_psum_pulse_2;
  wire                switch_psum_pulse;
  reg        [2:0]    switch_psum_index;
  wire                switch_psum_index_ov;
  reg                 mac_input_read;
  reg                 Iter_inCnt_inc_regNext;
  wire                mac_input_read_end;
  reg                 mac_input_valid;
  reg        [7:0]    mac_data_in_0;
  reg        [7:0]    mac_data_in_1;
  reg        [7:0]    mac_data_in_2;
  reg        [7:0]    mac_data_in_3;
  reg        [7:0]    mac_data_in_4;
  reg        [7:0]    mac_data_in_5;
  reg        [7:0]    mac_data_in_6;
  reg        [7:0]    mac_data_in_7;
  reg        [7:0]    mac_weight_in_0;
  reg        [7:0]    mac_weight_in_1;
  reg        [7:0]    mac_weight_in_2;
  reg        [7:0]    mac_weight_in_3;
  reg        [7:0]    mac_weight_in_4;
  reg        [7:0]    mac_weight_in_5;
  reg        [7:0]    mac_weight_in_6;
  reg        [7:0]    mac_weight_in_7;
  wire       [7:0]    cache_read_slice_8bits_0;
  wire       [7:0]    cache_read_slice_8bits_1;
  wire       [7:0]    cache_read_slice_8bits_2;
  wire       [7:0]    cache_read_slice_8bits_3;
  wire       [7:0]    cache_read_slice_8bits_4;
  wire       [7:0]    cache_read_slice_8bits_5;
  wire       [7:0]    cache_read_slice_8bits_6;
  wire       [7:0]    cache_read_slice_8bits_7;
  reg        [21:0]   mac_psum_buffer_0;
  reg        [21:0]   mac_psum_buffer_1;
  reg        [21:0]   mac_psum_buffer_2;
  reg        [21:0]   mac_psum_buffer_3;
  reg        [21:0]   mac_psum_buffer_4;
  reg        [21:0]   mac_psum_buffer_5;
  reg        [21:0]   mac_psum_buffer_6;
  reg        [21:0]   mac_psum_buffer_7;
  reg        [31:0]   mac_psum_out_32b_0_0;
  reg        [31:0]   mac_psum_out_32b_0_1;
  reg        [31:0]   mac_psum_out_32b_1_0;
  reg        [31:0]   mac_psum_out_32b_1_1;
  reg        [31:0]   mac_psum_out_32b_2_0;
  reg        [31:0]   mac_psum_out_32b_2_1;
  reg        [31:0]   mac_psum_out_32b_3_0;
  reg        [31:0]   mac_psum_out_32b_3_1;
  wire       [63:0]   mac_psum_gather_32b_0;
  wire       [63:0]   mac_psum_gather_32b_1;
  wire       [63:0]   mac_psum_gather_32b_2;
  wire       [63:0]   mac_psum_gather_32b_3;
  reg        [15:0]   mac_psum_buffer_scale_0;
  reg        [15:0]   mac_psum_buffer_scale_1;
  reg        [15:0]   mac_psum_buffer_scale_2;
  reg        [15:0]   mac_psum_buffer_scale_3;
  reg        [15:0]   mac_psum_buffer_scale_4;
  reg        [15:0]   mac_psum_buffer_scale_5;
  reg        [15:0]   mac_psum_buffer_scale_6;
  reg        [15:0]   mac_psum_buffer_scale_7;
  reg        [7:0]    mac_psum_buffer_sat_0;
  reg        [7:0]    mac_psum_buffer_sat_1;
  reg        [7:0]    mac_psum_buffer_sat_2;
  reg        [7:0]    mac_psum_buffer_sat_3;
  reg        [7:0]    mac_psum_buffer_sat_4;
  reg        [7:0]    mac_psum_buffer_sat_5;
  reg        [7:0]    mac_psum_buffer_sat_6;
  reg        [7:0]    mac_psum_buffer_sat_7;
  reg        [7:0]    mac_psum_out_8b_0;
  reg        [7:0]    mac_psum_out_8b_1;
  reg        [7:0]    mac_psum_out_8b_2;
  reg        [7:0]    mac_psum_out_8b_3;
  reg        [7:0]    mac_psum_out_8b_4;
  reg        [7:0]    mac_psum_out_8b_5;
  reg        [7:0]    mac_psum_out_8b_6;
  reg        [7:0]    mac_psum_out_8b_7;
  wire       [63:0]   mac_psum_gather_8b;
  reg                 mac_input_valid_regNext;
  wire                mac_pipe_last2_valid_fall;
  reg                 mac_once_finish;
  reg                 write_psum_pulse1;
  reg                 write_psum_pulse2;
  reg                 write_psum_pulse3;
  reg                 write_psum_pulse4;
  wire                matmul_result_write_en;
  wire                fc_layer_write_psum_en;
  wire                matmulH_write_psum_en1;
  wire                matmulH_write_psum_en2;
  wire                matmulH_write_psum_en3;
  wire                matmulH_write_psum_en4;
  wire                scala_done;
  wire                scala_data_in_val;
  reg                 scala_data_out_val;
  wire       [7:0]    scala_data_in_0;
  wire       [7:0]    scala_data_in_1;
  wire       [7:0]    scala_data_in_2;
  wire       [7:0]    scala_data_in_3;
  wire       [7:0]    scala_data_in_4;
  wire       [7:0]    scala_data_in_5;
  wire       [7:0]    scala_data_in_6;
  wire       [7:0]    scala_data_in_7;
  reg        [7:0]    scala_data_in_buf_0_0;
  reg        [7:0]    scala_data_in_buf_0_1;
  reg        [7:0]    scala_data_in_buf_0_2;
  reg        [7:0]    scala_data_in_buf_0_3;
  reg        [7:0]    scala_data_in_buf_0_4;
  reg        [7:0]    scala_data_in_buf_0_5;
  reg        [7:0]    scala_data_in_buf_0_6;
  reg        [7:0]    scala_data_in_buf_0_7;
  reg        [7:0]    scala_data_in_buf_1_0;
  reg        [7:0]    scala_data_in_buf_1_1;
  reg        [7:0]    scala_data_in_buf_1_2;
  reg        [7:0]    scala_data_in_buf_1_3;
  reg        [7:0]    scala_data_in_buf_1_4;
  reg        [7:0]    scala_data_in_buf_1_5;
  reg        [7:0]    scala_data_in_buf_1_6;
  reg        [7:0]    scala_data_in_buf_1_7;
  wire                scala_write_out_en1;
  wire                scala_write_out_en2;
  wire                tmp_scala_data_in_0;
  wire       [7:0]    tmp_1;
  wire       [21:0]   tmp_mac_psum_buffer_scale_0;
  reg        [15:0]   tmp_mac_psum_buffer_scale_0_1;
  reg        [7:0]    tmp_mac_psum_buffer_sat_0;
  wire       [21:0]   tmp_mac_psum_buffer_scale_1;
  reg        [15:0]   tmp_mac_psum_buffer_scale_1_1;
  reg        [7:0]    tmp_mac_psum_buffer_sat_1;
  wire       [21:0]   tmp_mac_psum_buffer_scale_2;
  reg        [15:0]   tmp_mac_psum_buffer_scale_2_1;
  reg        [7:0]    tmp_mac_psum_buffer_sat_2;
  wire       [21:0]   tmp_mac_psum_buffer_scale_3;
  reg        [15:0]   tmp_mac_psum_buffer_scale_3_1;
  reg        [7:0]    tmp_mac_psum_buffer_sat_3;
  wire       [21:0]   tmp_mac_psum_buffer_scale_4;
  reg        [15:0]   tmp_mac_psum_buffer_scale_4_1;
  reg        [7:0]    tmp_mac_psum_buffer_sat_4;
  wire       [21:0]   tmp_mac_psum_buffer_scale_5;
  reg        [15:0]   tmp_mac_psum_buffer_scale_5_1;
  reg        [7:0]    tmp_mac_psum_buffer_sat_5;
  wire       [21:0]   tmp_mac_psum_buffer_scale_6;
  reg        [15:0]   tmp_mac_psum_buffer_scale_6_1;
  reg        [7:0]    tmp_mac_psum_buffer_sat_6;
  wire       [21:0]   tmp_mac_psum_buffer_scale_7;
  reg        [15:0]   tmp_mac_psum_buffer_scale_7_1;
  reg        [7:0]    tmp_mac_psum_buffer_sat_7;
  wire       [6:0]    cali_matmulH_write_psum_addr_base;
  `ifndef SYNTHESIS
  reg [79:0] curr_state_string;
  reg [79:0] next_state_string;
  `endif


  assign tmp_Iter_outLoopCnt_ov = ({1'b0,output_loop_num} + tmp_Iter_outLoopCnt_ov_1);
  assign tmp_Iter_outLoopCnt_ov_2 = {1'b0,1'b1};
  assign tmp_Iter_outLoopCnt_ov_1 = {2'd0, tmp_Iter_outLoopCnt_ov_2};
  assign tmp_mac_psum_buffer_4_1 = coef_rdata[15 : 0];
  assign tmp_mac_psum_buffer_4 = {{6{tmp_mac_psum_buffer_4_1[15]}}, tmp_mac_psum_buffer_4_1};
  assign tmp_mac_psum_buffer_5_1 = coef_rdata[31 : 16];
  assign tmp_mac_psum_buffer_5 = {{6{tmp_mac_psum_buffer_5_1[15]}}, tmp_mac_psum_buffer_5_1};
  assign tmp_mac_psum_buffer_6_1 = coef_rdata[47 : 32];
  assign tmp_mac_psum_buffer_6 = {{6{tmp_mac_psum_buffer_6_1[15]}}, tmp_mac_psum_buffer_6_1};
  assign tmp_mac_psum_buffer_7_1 = coef_rdata[63 : 48];
  assign tmp_mac_psum_buffer_7 = {{6{tmp_mac_psum_buffer_7_1[15]}}, tmp_mac_psum_buffer_7_1};
  assign tmp_mac_psum_buffer_0_1 = coef_rdata[15 : 0];
  assign tmp_mac_psum_buffer_0 = {{6{tmp_mac_psum_buffer_0_1[15]}}, tmp_mac_psum_buffer_0_1};
  assign tmp_mac_psum_buffer_1_1 = coef_rdata[31 : 16];
  assign tmp_mac_psum_buffer_1 = {{6{tmp_mac_psum_buffer_1_1[15]}}, tmp_mac_psum_buffer_1_1};
  assign tmp_mac_psum_buffer_2_1 = coef_rdata[47 : 32];
  assign tmp_mac_psum_buffer_2 = {{6{tmp_mac_psum_buffer_2_1[15]}}, tmp_mac_psum_buffer_2_1};
  assign tmp_mac_psum_buffer_3_1 = coef_rdata[63 : 48];
  assign tmp_mac_psum_buffer_3 = {{6{tmp_mac_psum_buffer_3_1[15]}}, tmp_mac_psum_buffer_3_1};
  assign tmp_mac_psum_buffer_6_3 = cache_rdata[31 : 0];
  assign tmp_mac_psum_buffer_6_2 = tmp_mac_psum_buffer_6_3[21:0];
  assign tmp_mac_psum_buffer_7_3 = cache_rdata[63 : 32];
  assign tmp_mac_psum_buffer_7_2 = tmp_mac_psum_buffer_7_3[21:0];
  assign tmp_mac_psum_buffer_4_3 = cache_rdata[31 : 0];
  assign tmp_mac_psum_buffer_4_2 = tmp_mac_psum_buffer_4_3[21:0];
  assign tmp_mac_psum_buffer_5_3 = cache_rdata[63 : 32];
  assign tmp_mac_psum_buffer_5_2 = tmp_mac_psum_buffer_5_3[21:0];
  assign tmp_mac_psum_buffer_2_3 = cache_rdata[31 : 0];
  assign tmp_mac_psum_buffer_2_2 = tmp_mac_psum_buffer_2_3[21:0];
  assign tmp_mac_psum_buffer_3_3 = cache_rdata[63 : 32];
  assign tmp_mac_psum_buffer_3_2 = tmp_mac_psum_buffer_3_3[21:0];
  assign tmp_mac_psum_buffer_0_3 = cache_rdata[31 : 0];
  assign tmp_mac_psum_buffer_0_2 = tmp_mac_psum_buffer_0_3[21:0];
  assign tmp_mac_psum_buffer_1_3 = cache_rdata[63 : 32];
  assign tmp_mac_psum_buffer_1_2 = tmp_mac_psum_buffer_1_3[21:0];
  assign tmp_mac_psum_buffer_0_4 = {{6{mac_mult_out_0[15]}}, mac_mult_out_0};
  assign tmp_mac_psum_buffer_1_4 = {{6{mac_mult_out_1[15]}}, mac_mult_out_1};
  assign tmp_mac_psum_buffer_2_4 = {{6{mac_mult_out_2[15]}}, mac_mult_out_2};
  assign tmp_mac_psum_buffer_3_4 = {{6{mac_mult_out_3[15]}}, mac_mult_out_3};
  assign tmp_mac_psum_buffer_4_4 = {{6{mac_mult_out_4[15]}}, mac_mult_out_4};
  assign tmp_mac_psum_buffer_5_4 = {{6{mac_mult_out_5[15]}}, mac_mult_out_5};
  assign tmp_mac_psum_buffer_6_4 = {{6{mac_mult_out_6[15]}}, mac_mult_out_6};
  assign tmp_mac_psum_buffer_7_4 = {{6{mac_mult_out_7[15]}}, mac_mult_out_7};
  assign tmp_mac_psum_out_32b_0_0 = {{16{mac_psum_buffer_scale_0[15]}}, mac_psum_buffer_scale_0};
  assign tmp_mac_psum_out_32b_1_0 = {{16{mac_psum_buffer_scale_2[15]}}, mac_psum_buffer_scale_2};
  assign tmp_mac_psum_out_32b_2_0 = {{16{mac_psum_buffer_scale_4[15]}}, mac_psum_buffer_scale_4};
  assign tmp_mac_psum_out_32b_3_0 = {{16{mac_psum_buffer_scale_6[15]}}, mac_psum_buffer_scale_6};
  assign tmp_mac_psum_out_32b_0_0_2 = mac_psum_buffer_0;
  assign tmp_mac_psum_out_32b_0_0_1 = {{10{tmp_mac_psum_out_32b_0_0_2[21]}}, tmp_mac_psum_out_32b_0_0_2};
  assign tmp_mac_psum_out_32b_1_0_2 = mac_psum_buffer_2;
  assign tmp_mac_psum_out_32b_1_0_1 = {{10{tmp_mac_psum_out_32b_1_0_2[21]}}, tmp_mac_psum_out_32b_1_0_2};
  assign tmp_mac_psum_out_32b_2_0_2 = mac_psum_buffer_4;
  assign tmp_mac_psum_out_32b_2_0_1 = {{10{tmp_mac_psum_out_32b_2_0_2[21]}}, tmp_mac_psum_out_32b_2_0_2};
  assign tmp_mac_psum_out_32b_3_0_2 = mac_psum_buffer_6;
  assign tmp_mac_psum_out_32b_3_0_1 = {{10{tmp_mac_psum_out_32b_3_0_2[21]}}, tmp_mac_psum_out_32b_3_0_2};
  assign tmp_mac_psum_out_32b_0_1 = {{16{mac_psum_buffer_scale_1[15]}}, mac_psum_buffer_scale_1};
  assign tmp_mac_psum_out_32b_1_1 = {{16{mac_psum_buffer_scale_3[15]}}, mac_psum_buffer_scale_3};
  assign tmp_mac_psum_out_32b_2_1 = {{16{mac_psum_buffer_scale_5[15]}}, mac_psum_buffer_scale_5};
  assign tmp_mac_psum_out_32b_3_1 = {{16{mac_psum_buffer_scale_7[15]}}, mac_psum_buffer_scale_7};
  assign tmp_mac_psum_out_32b_0_1_2 = mac_psum_buffer_1;
  assign tmp_mac_psum_out_32b_0_1_1 = {{10{tmp_mac_psum_out_32b_0_1_2[21]}}, tmp_mac_psum_out_32b_0_1_2};
  assign tmp_mac_psum_out_32b_1_1_2 = mac_psum_buffer_3;
  assign tmp_mac_psum_out_32b_1_1_1 = {{10{tmp_mac_psum_out_32b_1_1_2[21]}}, tmp_mac_psum_out_32b_1_1_2};
  assign tmp_mac_psum_out_32b_2_1_2 = mac_psum_buffer_5;
  assign tmp_mac_psum_out_32b_2_1_1 = {{10{tmp_mac_psum_out_32b_2_1_2[21]}}, tmp_mac_psum_out_32b_2_1_2};
  assign tmp_mac_psum_out_32b_3_1_2 = mac_psum_buffer_7;
  assign tmp_mac_psum_out_32b_3_1_1 = {{10{tmp_mac_psum_out_32b_3_1_2[21]}}, tmp_mac_psum_out_32b_3_1_2};
  assign tmp_tmp_mac_psum_buffer_scale_0 = mac_psum_buffer_0;
  assign tmp_when = tmp_mac_psum_buffer_scale_0[21 : 15];
  assign tmp_when_1 = tmp_mac_psum_buffer_scale_0[20 : 15];
  assign tmp_when_2 = mac_psum_buffer_scale_0[15 : 7];
  assign tmp_when_3 = mac_psum_buffer_scale_0[14 : 7];
  assign tmp_when_4 = mac_psum_buffer_sat_0;
  assign tmp_tmp_mac_psum_buffer_scale_1 = mac_psum_buffer_1;
  assign tmp_when_5 = tmp_mac_psum_buffer_scale_1[21 : 15];
  assign tmp_when_6 = tmp_mac_psum_buffer_scale_1[20 : 15];
  assign tmp_when_7 = mac_psum_buffer_scale_1[15 : 7];
  assign tmp_when_8 = mac_psum_buffer_scale_1[14 : 7];
  assign tmp_when_9 = mac_psum_buffer_sat_1;
  assign tmp_tmp_mac_psum_buffer_scale_2 = mac_psum_buffer_2;
  assign tmp_when_10 = tmp_mac_psum_buffer_scale_2[21 : 15];
  assign tmp_when_11 = tmp_mac_psum_buffer_scale_2[20 : 15];
  assign tmp_when_12 = mac_psum_buffer_scale_2[15 : 7];
  assign tmp_when_13 = mac_psum_buffer_scale_2[14 : 7];
  assign tmp_when_14 = mac_psum_buffer_sat_2;
  assign tmp_tmp_mac_psum_buffer_scale_3 = mac_psum_buffer_3;
  assign tmp_when_15 = tmp_mac_psum_buffer_scale_3[21 : 15];
  assign tmp_when_16 = tmp_mac_psum_buffer_scale_3[20 : 15];
  assign tmp_when_17 = mac_psum_buffer_scale_3[15 : 7];
  assign tmp_when_18 = mac_psum_buffer_scale_3[14 : 7];
  assign tmp_when_19 = mac_psum_buffer_sat_3;
  assign tmp_tmp_mac_psum_buffer_scale_4 = mac_psum_buffer_4;
  assign tmp_when_20 = tmp_mac_psum_buffer_scale_4[21 : 15];
  assign tmp_when_21 = tmp_mac_psum_buffer_scale_4[20 : 15];
  assign tmp_when_22 = mac_psum_buffer_scale_4[15 : 7];
  assign tmp_when_23 = mac_psum_buffer_scale_4[14 : 7];
  assign tmp_when_24 = mac_psum_buffer_sat_4;
  assign tmp_tmp_mac_psum_buffer_scale_5 = mac_psum_buffer_5;
  assign tmp_when_25 = tmp_mac_psum_buffer_scale_5[21 : 15];
  assign tmp_when_26 = tmp_mac_psum_buffer_scale_5[20 : 15];
  assign tmp_when_27 = mac_psum_buffer_scale_5[15 : 7];
  assign tmp_when_28 = mac_psum_buffer_scale_5[14 : 7];
  assign tmp_when_29 = mac_psum_buffer_sat_5;
  assign tmp_tmp_mac_psum_buffer_scale_6 = mac_psum_buffer_6;
  assign tmp_when_30 = tmp_mac_psum_buffer_scale_6[21 : 15];
  assign tmp_when_31 = tmp_mac_psum_buffer_scale_6[20 : 15];
  assign tmp_when_32 = mac_psum_buffer_scale_6[15 : 7];
  assign tmp_when_33 = mac_psum_buffer_scale_6[14 : 7];
  assign tmp_when_34 = mac_psum_buffer_sat_6;
  assign tmp_tmp_mac_psum_buffer_scale_7 = mac_psum_buffer_7;
  assign tmp_when_35 = tmp_mac_psum_buffer_scale_7[21 : 15];
  assign tmp_when_36 = tmp_mac_psum_buffer_scale_7[20 : 15];
  assign tmp_when_37 = mac_psum_buffer_scale_7[15 : 7];
  assign tmp_when_38 = mac_psum_buffer_scale_7[14 : 7];
  assign tmp_when_39 = mac_psum_buffer_sat_7;
  assign tmp_coef_addr_1 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  assign tmp_coef_addr = {5'd0, tmp_coef_addr_1};
  assign tmp_coef_addr_2 = (psum_base_addr + tmp_coef_addr_3);
  assign tmp_coef_addr_4 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  assign tmp_coef_addr_3 = {5'd0, tmp_coef_addr_4};
  assign tmp_cache_addr = (psum_base_addr + tmp_cache_addr_1);
  assign tmp_cache_addr_2 = ({2'd0,Iter_outLoopCnt} <<< 2'd2);
  assign tmp_cache_addr_1 = {4'd0, tmp_cache_addr_2};
  assign tmp_cache_addr_3 = (tmp_cache_addr_4 + 10'h001);
  assign tmp_cache_addr_4 = (psum_base_addr + tmp_cache_addr_5);
  assign tmp_cache_addr_6 = ({2'd0,Iter_outLoopCnt} <<< 2'd2);
  assign tmp_cache_addr_5 = {4'd0, tmp_cache_addr_6};
  assign tmp_cache_addr_7 = (tmp_cache_addr_8 + 10'h002);
  assign tmp_cache_addr_8 = (psum_base_addr + tmp_cache_addr_9);
  assign tmp_cache_addr_10 = ({2'd0,Iter_outLoopCnt} <<< 2'd2);
  assign tmp_cache_addr_9 = {4'd0, tmp_cache_addr_10};
  assign tmp_cache_addr_11 = (tmp_cache_addr_12 + 10'h003);
  assign tmp_cache_addr_12 = (psum_base_addr + tmp_cache_addr_13);
  assign tmp_cache_addr_14 = ({2'd0,Iter_outLoopCnt} <<< 2'd2);
  assign tmp_cache_addr_13 = {4'd0, tmp_cache_addr_14};
  assign tmp_cache_addr_15 = {4'd0, Iter_inCnt};
  assign tmp_cache_addr_16 = {3'd0, Iter_outLoopCnt};
  assign tmp_cache_addr_17 = (cali_matmulH_write_psum_addr_base + curr_layer_result_line_num);
  assign tmp_cache_addr_19 = ({2'd0,Iter_outLoopCnt} <<< 2'd2);
  assign tmp_cache_addr_18 = {1'd0, tmp_cache_addr_19};
  assign tmp_cache_addr_20 = (tmp_cache_addr_21 + tmp_cache_addr_22);
  assign tmp_cache_addr_21 = (cali_matmulH_write_psum_addr_base + curr_layer_result_line_num);
  assign tmp_cache_addr_23 = ({2'd0,Iter_outLoopCnt} <<< 2'd2);
  assign tmp_cache_addr_22 = {1'd0, tmp_cache_addr_23};
  assign tmp_cache_addr_24 = (tmp_cache_addr_25 + tmp_cache_addr_26);
  assign tmp_cache_addr_25 = (cali_matmulH_write_psum_addr_base + curr_layer_result_line_num);
  assign tmp_cache_addr_27 = ({2'd0,Iter_outLoopCnt} <<< 2'd2);
  assign tmp_cache_addr_26 = {1'd0, tmp_cache_addr_27};
  assign tmp_cache_addr_28 = (tmp_cache_addr_29 + tmp_cache_addr_30);
  assign tmp_cache_addr_29 = (cali_matmulH_write_psum_addr_base + curr_layer_result_line_num);
  assign tmp_cache_addr_31 = ({2'd0,Iter_outLoopCnt} <<< 2'd2);
  assign tmp_cache_addr_30 = {1'd0, tmp_cache_addr_31};
  mac_unit mac (
    .clka           (mac_clka            ), //i
    .rstn_a         (mac_rstn_a          ), //i
    .valid          (mac_valid           ), //i
    .A_0            (mac_A_0[7:0]        ), //i
    .A_1            (mac_A_1[7:0]        ), //i
    .A_2            (mac_A_2[7:0]        ), //i
    .A_3            (mac_A_3[7:0]        ), //i
    .A_4            (mac_A_4[7:0]        ), //i
    .A_5            (mac_A_5[7:0]        ), //i
    .A_6            (mac_A_6[7:0]        ), //i
    .A_7            (mac_A_7[7:0]        ), //i
    .B_0            (mac_data_in_0[7:0]  ), //i
    .B_1            (mac_data_in_1[7:0]  ), //i
    .B_2            (mac_data_in_2[7:0]  ), //i
    .B_3            (mac_data_in_3[7:0]  ), //i
    .B_4            (mac_data_in_4[7:0]  ), //i
    .B_5            (mac_data_in_5[7:0]  ), //i
    .B_6            (mac_data_in_6[7:0]  ), //i
    .B_7            (mac_data_in_7[7:0]  ), //i
    .mult_out_0     (mac_mult_out_0[15:0]), //o
    .mult_out_1     (mac_mult_out_1[15:0]), //o
    .mult_out_2     (mac_mult_out_2[15:0]), //o
    .mult_out_3     (mac_mult_out_3[15:0]), //o
    .mult_out_4     (mac_mult_out_4[15:0]), //o
    .mult_out_5     (mac_mult_out_5[15:0]), //o
    .mult_out_6     (mac_mult_out_6[15:0]), //o
    .mult_out_7     (mac_mult_out_7[15:0]), //o
    .psum_in        (mac_psum_in[21:0]   ), //i
    .psum_out       (mac_psum_out[21:0]  ), //o
    .psum_acc_valid (mac_psum_acc_valid  ), //o
    .clkout         (clkout              ), //i
    .resetn         (resetn              )  //i
  );
  always @(*) begin
    case(switch_psum_index)
      3'b000 : tmp_psum_in = mac_psum_buffer_0;
      3'b001 : tmp_psum_in = mac_psum_buffer_1;
      3'b010 : tmp_psum_in = mac_psum_buffer_2;
      3'b011 : tmp_psum_in = mac_psum_buffer_3;
      3'b100 : tmp_psum_in = mac_psum_buffer_4;
      3'b101 : tmp_psum_in = mac_psum_buffer_5;
      3'b110 : tmp_psum_in = mac_psum_buffer_6;
      default : tmp_psum_in = mac_psum_buffer_7;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(curr_state)
      MATMUL_STATE_IDLE : curr_state_string = "IDLE      ";
      MATMUL_STATE_LOAD_PSUM1 : curr_state_string = "LOAD_PSUM1";
      MATMUL_STATE_LOAD_PSUM2 : curr_state_string = "LOAD_PSUM2";
      MATMUL_STATE_LOAD_PSUM3 : curr_state_string = "LOAD_PSUM3";
      MATMUL_STATE_LOAD_PSUM4 : curr_state_string = "LOAD_PSUM4";
      MATMUL_STATE_MAC : curr_state_string = "MAC       ";
      default : curr_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      MATMUL_STATE_IDLE : next_state_string = "IDLE      ";
      MATMUL_STATE_LOAD_PSUM1 : next_state_string = "LOAD_PSUM1";
      MATMUL_STATE_LOAD_PSUM2 : next_state_string = "LOAD_PSUM2";
      MATMUL_STATE_LOAD_PSUM3 : next_state_string = "LOAD_PSUM3";
      MATMUL_STATE_LOAD_PSUM4 : next_state_string = "LOAD_PSUM4";
      MATMUL_STATE_MAC : next_state_string = "MAC       ";
      default : next_state_string = "??????????";
    endcase
  end
  `endif

  assign state_is_idle = (curr_state == MATMUL_STATE_IDLE);
  assign state_is_load_psum1 = (curr_state == MATMUL_STATE_LOAD_PSUM1);
  assign statein_load_psum1 = ((curr_state != MATMUL_STATE_LOAD_PSUM1) && (next_state == MATMUL_STATE_LOAD_PSUM1));
  assign state_is_load_psum2 = (curr_state == MATMUL_STATE_LOAD_PSUM2);
  assign statein_load_psum2 = ((curr_state != MATMUL_STATE_LOAD_PSUM2) && (next_state == MATMUL_STATE_LOAD_PSUM2));
  assign state_is_load_psum3 = (curr_state == MATMUL_STATE_LOAD_PSUM3);
  assign statein_load_psum3 = ((curr_state != MATMUL_STATE_LOAD_PSUM3) && (next_state == MATMUL_STATE_LOAD_PSUM3));
  assign state_is_load_psum4 = (curr_state == MATMUL_STATE_LOAD_PSUM4);
  assign statein_load_psum4 = ((curr_state != MATMUL_STATE_LOAD_PSUM4) && (next_state == MATMUL_STATE_LOAD_PSUM4));
  assign done = ((curr_state == MATMUL_STATE_MAC) && (next_state == MATMUL_STATE_IDLE));
  assign Iter_inCnt_ov = (Iter_inCnt == input_loop_num);
  assign Iter_sliceCnt_ov = (is_scala_mult ? (Iter_sliceCnt == 3'b001) : (Iter_sliceCnt == 3'b111));
  assign Iter_outLoopCnt_ov = (is_scala_mult ? (Iter_outLoopCnt == 4'b0001) : (Iter_outLoopCnt == tmp_Iter_outLoopCnt_ov));
  assign psum1_read_bias = (psum1_read_out_flag && psum_come_from_coef);
  assign psum2_read_bias = (psum2_read_out_flag && psum_come_from_coef);
  assign psum1_read_psum = (psum1_read_out_flag && (! psum_come_from_coef));
  assign psum2_read_psum = (psum2_read_out_flag && (! psum_come_from_coef));
  assign psum3_read_psum = (psum3_read_out_flag && (! psum_come_from_coef));
  assign psum4_read_psum = (psum4_read_out_flag && (! psum_come_from_coef));
  assign psum1_read_scala = ((psum1_read_out_flag && (! psum_come_from_coef)) && is_scala_mult);
  assign psum2_read_scala = ((psum2_read_out_flag && (! psum_come_from_coef)) && is_scala_mult);
  assign switch_psum_pulse = (tmp_switch_psum_pulse_2 && (! is_scala_mult));
  assign switch_psum_index_ov = (switch_psum_index == 3'b111);
  assign mac_input_read_end = ((! Iter_inCnt_inc) && Iter_inCnt_inc_regNext);
  assign cache_read_slice_8bits_0 = cache_rdata[7 : 0];
  assign cache_read_slice_8bits_1 = cache_rdata[15 : 8];
  assign cache_read_slice_8bits_2 = cache_rdata[23 : 16];
  assign cache_read_slice_8bits_3 = cache_rdata[31 : 24];
  assign cache_read_slice_8bits_4 = cache_rdata[39 : 32];
  assign cache_read_slice_8bits_5 = cache_rdata[47 : 40];
  assign cache_read_slice_8bits_6 = cache_rdata[55 : 48];
  assign cache_read_slice_8bits_7 = cache_rdata[63 : 56];
  assign mac_psum_gather_32b_0 = {mac_psum_out_32b_0_1,mac_psum_out_32b_0_0};
  assign mac_psum_gather_32b_1 = {mac_psum_out_32b_1_1,mac_psum_out_32b_1_0};
  assign mac_psum_gather_32b_2 = {mac_psum_out_32b_2_1,mac_psum_out_32b_2_0};
  assign mac_psum_gather_32b_3 = {mac_psum_out_32b_3_1,mac_psum_out_32b_3_0};
  assign mac_psum_gather_8b = {{{{{{{mac_psum_out_8b_7,mac_psum_out_8b_6},mac_psum_out_8b_5},mac_psum_out_8b_4},mac_psum_out_8b_3},mac_psum_out_8b_2},mac_psum_out_8b_1},mac_psum_out_8b_0};
  assign mac_pipe_last2_valid_fall = ((! mac_input_valid) && mac_input_valid_regNext);
  assign matmul_result_write_en = (((write_psum_pulse3 && need_scale) && (! is_fc_layer)) && (! is_scala_mult));
  assign fc_layer_write_psum_en = (((write_psum_pulse3 && need_scale) && is_fc_layer) && (! is_scala_mult));
  assign matmulH_write_psum_en1 = (mac_once_finish && (! need_scale));
  assign matmulH_write_psum_en2 = (write_psum_pulse1 && (! need_scale));
  assign matmulH_write_psum_en3 = (write_psum_pulse2 && (! need_scale));
  assign matmulH_write_psum_en4 = (write_psum_pulse3 && (! need_scale));
  assign scala_done = ((Iter_inCnt_ov && Iter_sliceCnt_ov) && is_scala_mult);
  assign scala_data_in_val = ((Iter_inCnt_inc && mac_input_valid) && is_scala_mult);
  assign scala_write_out_en1 = (scala_data_out_val && (Iter_inCnt == 3'b001));
  assign scala_write_out_en2 = ((scala_data_out_val && (Iter_inCnt == 3'b000)) && (output_loop_num != 3'b000));
  assign scala_psum_out_vld = scala_write_out_en1;
  assign scala_psum_out_0 = mac_psum_buffer_0;
  assign scala_psum_out_1 = mac_psum_buffer_1;
  assign scala_psum_out_2 = mac_psum_buffer_2;
  assign tmp_scala_data_in_0 = (Iter_inCnt == 3'b001);
  assign scala_data_in_0 = (tmp_scala_data_in_0 ? scala_data_in_buf_1_0 : scala_data_in_buf_0_0);
  assign scala_data_in_1 = (tmp_scala_data_in_0 ? scala_data_in_buf_1_1 : scala_data_in_buf_0_1);
  assign scala_data_in_2 = (tmp_scala_data_in_0 ? scala_data_in_buf_1_2 : scala_data_in_buf_0_2);
  assign scala_data_in_3 = (tmp_scala_data_in_0 ? scala_data_in_buf_1_3 : scala_data_in_buf_0_3);
  assign scala_data_in_4 = (tmp_scala_data_in_0 ? scala_data_in_buf_1_4 : scala_data_in_buf_0_4);
  assign scala_data_in_5 = (tmp_scala_data_in_0 ? scala_data_in_buf_1_5 : scala_data_in_buf_0_5);
  assign scala_data_in_6 = (tmp_scala_data_in_0 ? scala_data_in_buf_1_6 : scala_data_in_buf_0_6);
  assign scala_data_in_7 = (tmp_scala_data_in_0 ? scala_data_in_buf_1_7 : scala_data_in_buf_0_7);
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      MATMUL_STATE_IDLE : begin
        if(start) begin
          next_state = MATMUL_STATE_LOAD_PSUM1;
        end
      end
      MATMUL_STATE_LOAD_PSUM1 : begin
        next_state = MATMUL_STATE_LOAD_PSUM2;
      end
      MATMUL_STATE_LOAD_PSUM2 : begin
        if(psum_come_from_coef) begin
          next_state = MATMUL_STATE_MAC;
        end else begin
          next_state = MATMUL_STATE_LOAD_PSUM3;
        end
      end
      MATMUL_STATE_LOAD_PSUM3 : begin
        next_state = MATMUL_STATE_LOAD_PSUM4;
      end
      MATMUL_STATE_LOAD_PSUM4 : begin
        next_state = MATMUL_STATE_MAC;
      end
      default : begin
        if((write_psum_pulse4 && (! Iter_outLoopCnt_ov))) begin
          next_state = MATMUL_STATE_LOAD_PSUM1;
        end else begin
          if((write_psum_pulse4 && Iter_outLoopCnt_ov)) begin
            next_state = MATMUL_STATE_IDLE;
          end
        end
      end
    endcase
  end

  assign Iter_inCnt_inc = Iter_inCnt_inc_not;
  always @(*) begin
    mac_weight_in_0 = 8'h0;
    if(mac_input_valid) begin
      mac_weight_in_0 = coef_rdata[7 : 0];
    end
  end

  always @(*) begin
    mac_data_in_0 = 8'h0;
    if(mac_input_valid) begin
      mac_data_in_0 = cache_rdata[7 : 0];
    end
  end

  always @(*) begin
    mac_weight_in_1 = 8'h0;
    if(mac_input_valid) begin
      mac_weight_in_1 = coef_rdata[15 : 8];
    end
  end

  always @(*) begin
    mac_data_in_1 = 8'h0;
    if(mac_input_valid) begin
      mac_data_in_1 = cache_rdata[15 : 8];
    end
  end

  always @(*) begin
    mac_weight_in_2 = 8'h0;
    if(mac_input_valid) begin
      mac_weight_in_2 = coef_rdata[23 : 16];
    end
  end

  always @(*) begin
    mac_data_in_2 = 8'h0;
    if(mac_input_valid) begin
      mac_data_in_2 = cache_rdata[23 : 16];
    end
  end

  always @(*) begin
    mac_weight_in_3 = 8'h0;
    if(mac_input_valid) begin
      mac_weight_in_3 = coef_rdata[31 : 24];
    end
  end

  always @(*) begin
    mac_data_in_3 = 8'h0;
    if(mac_input_valid) begin
      mac_data_in_3 = cache_rdata[31 : 24];
    end
  end

  always @(*) begin
    mac_weight_in_4 = 8'h0;
    if(mac_input_valid) begin
      mac_weight_in_4 = coef_rdata[39 : 32];
    end
  end

  always @(*) begin
    mac_data_in_4 = 8'h0;
    if(mac_input_valid) begin
      mac_data_in_4 = cache_rdata[39 : 32];
    end
  end

  always @(*) begin
    mac_weight_in_5 = 8'h0;
    if(mac_input_valid) begin
      mac_weight_in_5 = coef_rdata[47 : 40];
    end
  end

  always @(*) begin
    mac_data_in_5 = 8'h0;
    if(mac_input_valid) begin
      mac_data_in_5 = cache_rdata[47 : 40];
    end
  end

  always @(*) begin
    mac_weight_in_6 = 8'h0;
    if(mac_input_valid) begin
      mac_weight_in_6 = coef_rdata[55 : 48];
    end
  end

  always @(*) begin
    mac_data_in_6 = 8'h0;
    if(mac_input_valid) begin
      mac_data_in_6 = cache_rdata[55 : 48];
    end
  end

  always @(*) begin
    mac_weight_in_7 = 8'h0;
    if(mac_input_valid) begin
      mac_weight_in_7 = coef_rdata[63 : 56];
    end
  end

  always @(*) begin
    mac_data_in_7 = 8'h0;
    if(mac_input_valid) begin
      mac_data_in_7 = cache_rdata[63 : 56];
    end
  end

  assign mac_valid = (is_scala_mult ? scala_data_in_val : mac_input_valid);
  assign mac_A_0 = (is_scala_mult ? scala_data_in_0 : mac_weight_in_0);
  assign mac_A_1 = (is_scala_mult ? scala_data_in_1 : mac_weight_in_1);
  assign mac_A_2 = (is_scala_mult ? scala_data_in_2 : mac_weight_in_2);
  assign mac_A_3 = (is_scala_mult ? scala_data_in_3 : mac_weight_in_3);
  assign mac_A_4 = (is_scala_mult ? scala_data_in_4 : mac_weight_in_4);
  assign mac_A_5 = (is_scala_mult ? scala_data_in_5 : mac_weight_in_5);
  assign mac_A_6 = (is_scala_mult ? scala_data_in_6 : mac_weight_in_6);
  assign mac_A_7 = (is_scala_mult ? scala_data_in_7 : mac_weight_in_7);
  assign tmp_1 = ({7'd0,1'b1} <<< switch_psum_index);
  assign mac_psum_in = tmp_psum_in;
  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_32b_0_0 = tmp_mac_psum_out_32b_0_0;
    end else begin
      mac_psum_out_32b_0_0 = tmp_mac_psum_out_32b_0_0_1;
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_32b_1_0 = tmp_mac_psum_out_32b_1_0;
    end else begin
      mac_psum_out_32b_1_0 = tmp_mac_psum_out_32b_1_0_1;
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_32b_2_0 = tmp_mac_psum_out_32b_2_0;
    end else begin
      mac_psum_out_32b_2_0 = tmp_mac_psum_out_32b_2_0_1;
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_32b_3_0 = tmp_mac_psum_out_32b_3_0;
    end else begin
      mac_psum_out_32b_3_0 = tmp_mac_psum_out_32b_3_0_1;
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_32b_0_1 = tmp_mac_psum_out_32b_0_1;
    end else begin
      mac_psum_out_32b_0_1 = tmp_mac_psum_out_32b_0_1_1;
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_32b_1_1 = tmp_mac_psum_out_32b_1_1;
    end else begin
      mac_psum_out_32b_1_1 = tmp_mac_psum_out_32b_1_1_1;
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_32b_2_1 = tmp_mac_psum_out_32b_2_1;
    end else begin
      mac_psum_out_32b_2_1 = tmp_mac_psum_out_32b_2_1_1;
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_32b_3_1 = tmp_mac_psum_out_32b_3_1;
    end else begin
      mac_psum_out_32b_3_1 = tmp_mac_psum_out_32b_3_1_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_0 = 16'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_scale_0 = tmp_mac_psum_buffer_scale_0_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_sat_0 = 8'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_sat_0 = tmp_mac_psum_buffer_sat_0;
    end
  end

  always @(*) begin
    mac_psum_out_8b_0 = 8'h0;
    if((((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2)) begin
      if(need_relu) begin
        if(($signed(8'h0) < $signed(tmp_when_4))) begin
          mac_psum_out_8b_0 = mac_psum_buffer_sat_0;
        end else begin
          mac_psum_out_8b_0 = 8'h0;
        end
      end else begin
        mac_psum_out_8b_0 = mac_psum_buffer_sat_0;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_0 = ($signed(tmp_tmp_mac_psum_buffer_scale_0) >>> rg_nn_data_ratio);
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_0[21]) begin
      if((! (&tmp_when))) begin
        tmp_mac_psum_buffer_scale_0_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_0_1 = tmp_mac_psum_buffer_scale_0[15 : 0];
      end
    end else begin
      if((|tmp_when_1)) begin
        tmp_mac_psum_buffer_scale_0_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_0_1 = tmp_mac_psum_buffer_scale_0[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_0[15]) begin
      if((! (&tmp_when_2))) begin
        tmp_mac_psum_buffer_sat_0 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_sat_0 = mac_psum_buffer_scale_0[7 : 0];
      end
    end else begin
      if((|tmp_when_3)) begin
        tmp_mac_psum_buffer_sat_0 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_sat_0 = mac_psum_buffer_scale_0[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_1 = 16'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_scale_1 = tmp_mac_psum_buffer_scale_1_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_sat_1 = 8'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_sat_1 = tmp_mac_psum_buffer_sat_1;
    end
  end

  always @(*) begin
    mac_psum_out_8b_1 = 8'h0;
    if((((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2)) begin
      if(need_relu) begin
        if(($signed(8'h0) < $signed(tmp_when_9))) begin
          mac_psum_out_8b_1 = mac_psum_buffer_sat_1;
        end else begin
          mac_psum_out_8b_1 = 8'h0;
        end
      end else begin
        mac_psum_out_8b_1 = mac_psum_buffer_sat_1;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_1 = ($signed(tmp_tmp_mac_psum_buffer_scale_1) >>> rg_nn_data_ratio);
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_1[21]) begin
      if((! (&tmp_when_5))) begin
        tmp_mac_psum_buffer_scale_1_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_1_1 = tmp_mac_psum_buffer_scale_1[15 : 0];
      end
    end else begin
      if((|tmp_when_6)) begin
        tmp_mac_psum_buffer_scale_1_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_1_1 = tmp_mac_psum_buffer_scale_1[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_1[15]) begin
      if((! (&tmp_when_7))) begin
        tmp_mac_psum_buffer_sat_1 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_sat_1 = mac_psum_buffer_scale_1[7 : 0];
      end
    end else begin
      if((|tmp_when_8)) begin
        tmp_mac_psum_buffer_sat_1 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_sat_1 = mac_psum_buffer_scale_1[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_2 = 16'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_scale_2 = tmp_mac_psum_buffer_scale_2_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_sat_2 = 8'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_sat_2 = tmp_mac_psum_buffer_sat_2;
    end
  end

  always @(*) begin
    mac_psum_out_8b_2 = 8'h0;
    if((((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2)) begin
      if(need_relu) begin
        if(($signed(8'h0) < $signed(tmp_when_14))) begin
          mac_psum_out_8b_2 = mac_psum_buffer_sat_2;
        end else begin
          mac_psum_out_8b_2 = 8'h0;
        end
      end else begin
        mac_psum_out_8b_2 = mac_psum_buffer_sat_2;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_2 = ($signed(tmp_tmp_mac_psum_buffer_scale_2) >>> rg_nn_data_ratio);
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_2[21]) begin
      if((! (&tmp_when_10))) begin
        tmp_mac_psum_buffer_scale_2_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_2_1 = tmp_mac_psum_buffer_scale_2[15 : 0];
      end
    end else begin
      if((|tmp_when_11)) begin
        tmp_mac_psum_buffer_scale_2_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_2_1 = tmp_mac_psum_buffer_scale_2[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_2[15]) begin
      if((! (&tmp_when_12))) begin
        tmp_mac_psum_buffer_sat_2 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_sat_2 = mac_psum_buffer_scale_2[7 : 0];
      end
    end else begin
      if((|tmp_when_13)) begin
        tmp_mac_psum_buffer_sat_2 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_sat_2 = mac_psum_buffer_scale_2[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_3 = 16'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_scale_3 = tmp_mac_psum_buffer_scale_3_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_sat_3 = 8'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_sat_3 = tmp_mac_psum_buffer_sat_3;
    end
  end

  always @(*) begin
    mac_psum_out_8b_3 = 8'h0;
    if((((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2)) begin
      if(need_relu) begin
        if(($signed(8'h0) < $signed(tmp_when_19))) begin
          mac_psum_out_8b_3 = mac_psum_buffer_sat_3;
        end else begin
          mac_psum_out_8b_3 = 8'h0;
        end
      end else begin
        mac_psum_out_8b_3 = mac_psum_buffer_sat_3;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_3 = ($signed(tmp_tmp_mac_psum_buffer_scale_3) >>> rg_nn_data_ratio);
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_3[21]) begin
      if((! (&tmp_when_15))) begin
        tmp_mac_psum_buffer_scale_3_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_3_1 = tmp_mac_psum_buffer_scale_3[15 : 0];
      end
    end else begin
      if((|tmp_when_16)) begin
        tmp_mac_psum_buffer_scale_3_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_3_1 = tmp_mac_psum_buffer_scale_3[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_3[15]) begin
      if((! (&tmp_when_17))) begin
        tmp_mac_psum_buffer_sat_3 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_sat_3 = mac_psum_buffer_scale_3[7 : 0];
      end
    end else begin
      if((|tmp_when_18)) begin
        tmp_mac_psum_buffer_sat_3 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_sat_3 = mac_psum_buffer_scale_3[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_4 = 16'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_scale_4 = tmp_mac_psum_buffer_scale_4_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_sat_4 = 8'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_sat_4 = tmp_mac_psum_buffer_sat_4;
    end
  end

  always @(*) begin
    mac_psum_out_8b_4 = 8'h0;
    if((((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2)) begin
      if(need_relu) begin
        if(($signed(8'h0) < $signed(tmp_when_24))) begin
          mac_psum_out_8b_4 = mac_psum_buffer_sat_4;
        end else begin
          mac_psum_out_8b_4 = 8'h0;
        end
      end else begin
        mac_psum_out_8b_4 = mac_psum_buffer_sat_4;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_4 = ($signed(tmp_tmp_mac_psum_buffer_scale_4) >>> rg_nn_data_ratio);
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_4[21]) begin
      if((! (&tmp_when_20))) begin
        tmp_mac_psum_buffer_scale_4_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_4_1 = tmp_mac_psum_buffer_scale_4[15 : 0];
      end
    end else begin
      if((|tmp_when_21)) begin
        tmp_mac_psum_buffer_scale_4_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_4_1 = tmp_mac_psum_buffer_scale_4[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_4[15]) begin
      if((! (&tmp_when_22))) begin
        tmp_mac_psum_buffer_sat_4 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_sat_4 = mac_psum_buffer_scale_4[7 : 0];
      end
    end else begin
      if((|tmp_when_23)) begin
        tmp_mac_psum_buffer_sat_4 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_sat_4 = mac_psum_buffer_scale_4[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_5 = 16'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_scale_5 = tmp_mac_psum_buffer_scale_5_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_sat_5 = 8'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_sat_5 = tmp_mac_psum_buffer_sat_5;
    end
  end

  always @(*) begin
    mac_psum_out_8b_5 = 8'h0;
    if((((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2)) begin
      if(need_relu) begin
        if(($signed(8'h0) < $signed(tmp_when_29))) begin
          mac_psum_out_8b_5 = mac_psum_buffer_sat_5;
        end else begin
          mac_psum_out_8b_5 = 8'h0;
        end
      end else begin
        mac_psum_out_8b_5 = mac_psum_buffer_sat_5;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_5 = ($signed(tmp_tmp_mac_psum_buffer_scale_5) >>> rg_nn_data_ratio);
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_5[21]) begin
      if((! (&tmp_when_25))) begin
        tmp_mac_psum_buffer_scale_5_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_5_1 = tmp_mac_psum_buffer_scale_5[15 : 0];
      end
    end else begin
      if((|tmp_when_26)) begin
        tmp_mac_psum_buffer_scale_5_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_5_1 = tmp_mac_psum_buffer_scale_5[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_5[15]) begin
      if((! (&tmp_when_27))) begin
        tmp_mac_psum_buffer_sat_5 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_sat_5 = mac_psum_buffer_scale_5[7 : 0];
      end
    end else begin
      if((|tmp_when_28)) begin
        tmp_mac_psum_buffer_sat_5 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_sat_5 = mac_psum_buffer_scale_5[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_6 = 16'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_scale_6 = tmp_mac_psum_buffer_scale_6_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_sat_6 = 8'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_sat_6 = tmp_mac_psum_buffer_sat_6;
    end
  end

  always @(*) begin
    mac_psum_out_8b_6 = 8'h0;
    if((((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2)) begin
      if(need_relu) begin
        if(($signed(8'h0) < $signed(tmp_when_34))) begin
          mac_psum_out_8b_6 = mac_psum_buffer_sat_6;
        end else begin
          mac_psum_out_8b_6 = 8'h0;
        end
      end else begin
        mac_psum_out_8b_6 = mac_psum_buffer_sat_6;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_6 = ($signed(tmp_tmp_mac_psum_buffer_scale_6) >>> rg_nn_data_ratio);
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_6[21]) begin
      if((! (&tmp_when_30))) begin
        tmp_mac_psum_buffer_scale_6_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_6_1 = tmp_mac_psum_buffer_scale_6[15 : 0];
      end
    end else begin
      if((|tmp_when_31)) begin
        tmp_mac_psum_buffer_scale_6_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_6_1 = tmp_mac_psum_buffer_scale_6[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_6[15]) begin
      if((! (&tmp_when_32))) begin
        tmp_mac_psum_buffer_sat_6 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_sat_6 = mac_psum_buffer_scale_6[7 : 0];
      end
    end else begin
      if((|tmp_when_33)) begin
        tmp_mac_psum_buffer_sat_6 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_sat_6 = mac_psum_buffer_scale_6[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_7 = 16'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_scale_7 = tmp_mac_psum_buffer_scale_7_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_sat_7 = 8'h0;
    if((need_scale && (((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2))) begin
      mac_psum_buffer_sat_7 = tmp_mac_psum_buffer_sat_7;
    end
  end

  always @(*) begin
    mac_psum_out_8b_7 = 8'h0;
    if((((((mac_once_finish || write_psum_pulse1) || write_psum_pulse2) || write_psum_pulse3) || scala_write_out_en1) || scala_write_out_en2)) begin
      if(need_relu) begin
        if(($signed(8'h0) < $signed(tmp_when_39))) begin
          mac_psum_out_8b_7 = mac_psum_buffer_sat_7;
        end else begin
          mac_psum_out_8b_7 = 8'h0;
        end
      end else begin
        mac_psum_out_8b_7 = mac_psum_buffer_sat_7;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_7 = ($signed(tmp_tmp_mac_psum_buffer_scale_7) >>> rg_nn_data_ratio);
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_7[21]) begin
      if((! (&tmp_when_35))) begin
        tmp_mac_psum_buffer_scale_7_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_7_1 = tmp_mac_psum_buffer_scale_7[15 : 0];
      end
    end else begin
      if((|tmp_when_36)) begin
        tmp_mac_psum_buffer_scale_7_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_7_1 = tmp_mac_psum_buffer_scale_7[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_7[15]) begin
      if((! (&tmp_when_37))) begin
        tmp_mac_psum_buffer_sat_7 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_sat_7 = mac_psum_buffer_scale_7[7 : 0];
      end
    end else begin
      if((|tmp_when_38)) begin
        tmp_mac_psum_buffer_sat_7 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_sat_7 = mac_psum_buffer_scale_7[7 : 0];
      end
    end
  end

  always @(*) begin
    coef_wdata = 64'h0;
    if(!(statein_load_psum1 && psum_come_from_coef)) begin
      if(!(statein_load_psum2 && psum_come_from_coef)) begin
        if(!Iter_inCnt_inc) begin
          if(mac_input_read_end) begin
            coef_wdata = 64'h0;
          end
        end
      end
    end
  end

  assign cali_matmulH_write_psum_addr_base = ((is_hidden_layer && (7'h2e <= output_base_addr)) ? 7'h12 : output_base_addr);
  always @(posedge clkout or negedge resetn) begin
    if(!resetn) begin
      curr_state <= MATMUL_STATE_IDLE;
      Iter_inCnt <= 3'b000;
      Iter_inCnt_inc_not <= 1'b0;
      Iter_sliceCnt <= 3'b000;
      Iter_outLoopCnt <= 4'b0000;
      weight_read_addr <= 10'h0;
      psum1_read_out_flag <= 1'b0;
      psum2_read_out_flag <= 1'b0;
      psum3_read_out_flag <= 1'b0;
      psum4_read_out_flag <= 1'b0;
      tmp_switch_psum_pulse <= 1'b0;
      tmp_switch_psum_pulse_1 <= 1'b0;
      tmp_switch_psum_pulse_2 <= 1'b0;
      switch_psum_index <= 3'b000;
      mac_input_read <= 1'b0;
      Iter_inCnt_inc_regNext <= 1'b0;
      mac_input_valid <= 1'b0;
      mac_psum_buffer_0 <= 22'h0;
      mac_psum_buffer_1 <= 22'h0;
      mac_psum_buffer_2 <= 22'h0;
      mac_psum_buffer_3 <= 22'h0;
      mac_psum_buffer_4 <= 22'h0;
      mac_psum_buffer_5 <= 22'h0;
      mac_psum_buffer_6 <= 22'h0;
      mac_psum_buffer_7 <= 22'h0;
      mac_input_valid_regNext <= 1'b0;
      mac_once_finish <= 1'b0;
      write_psum_pulse1 <= 1'b0;
      write_psum_pulse2 <= 1'b0;
      write_psum_pulse3 <= 1'b0;
      write_psum_pulse4 <= 1'b0;
      scala_data_out_val <= 1'b0;
      coef_addr <= 10'h0;
      coef_wena <= 1'b0;
      coef_ena <= 1'b0;
      cache_addr <= 7'h0;
      cache_wena <= 1'b0;
      cache_ena <= 1'b0;
      cache_wdata <= 64'h0;
    end else begin
      psum1_read_out_flag <= state_is_load_psum1;
      psum2_read_out_flag <= state_is_load_psum2;
      psum3_read_out_flag <= state_is_load_psum3;
      psum4_read_out_flag <= state_is_load_psum4;
      tmp_switch_psum_pulse <= (Iter_inCnt_ov && Iter_inCnt_inc);
      tmp_switch_psum_pulse_1 <= tmp_switch_psum_pulse;
      tmp_switch_psum_pulse_2 <= tmp_switch_psum_pulse_1;
      mac_input_read <= Iter_inCnt_inc;
      Iter_inCnt_inc_regNext <= Iter_inCnt_inc;
      mac_input_valid <= mac_input_read;
      mac_input_valid_regNext <= mac_input_valid;
      mac_once_finish <= mac_pipe_last2_valid_fall;
      write_psum_pulse1 <= mac_once_finish;
      write_psum_pulse2 <= write_psum_pulse1;
      write_psum_pulse3 <= write_psum_pulse2;
      write_psum_pulse4 <= write_psum_pulse3;
      scala_data_out_val <= scala_data_in_val;
      curr_state <= next_state;
      if((statein_load_psum2 && psum_come_from_coef)) begin
        Iter_inCnt_inc_not <= 1'b1;
      end else begin
        if((statein_load_psum4 && (! psum_come_from_coef))) begin
          Iter_inCnt_inc_not <= 1'b1;
        end else begin
          if((Iter_inCnt_ov && Iter_sliceCnt_ov)) begin
            Iter_inCnt_inc_not <= 1'b0;
          end
        end
      end
      if(Iter_inCnt_inc) begin
        if(Iter_inCnt_ov) begin
          Iter_inCnt <= 3'b000;
          if(Iter_sliceCnt_ov) begin
            Iter_sliceCnt <= 3'b000;
          end else begin
            Iter_sliceCnt <= (Iter_sliceCnt + 3'b001);
          end
        end else begin
          Iter_inCnt <= (Iter_inCnt + 3'b001);
        end
      end
      if((Iter_outLoopCnt_ov || done)) begin
        Iter_outLoopCnt <= 4'b0000;
      end else begin
        if(write_psum_pulse3) begin
          Iter_outLoopCnt <= (Iter_outLoopCnt + 4'b0001);
        end
      end
      if(start) begin
        weight_read_addr <= weight_base_addr;
      end else begin
        if(Iter_inCnt_inc) begin
          weight_read_addr <= (weight_read_addr + 10'h001);
        end
      end
      if(switch_psum_pulse) begin
        if(switch_psum_index_ov) begin
          switch_psum_index <= 3'b000;
        end else begin
          switch_psum_index <= (switch_psum_index + 3'b001);
        end
      end
      if(psum2_read_bias) begin
        mac_psum_buffer_4 <= tmp_mac_psum_buffer_4;
        mac_psum_buffer_5 <= tmp_mac_psum_buffer_5;
        mac_psum_buffer_6 <= tmp_mac_psum_buffer_6;
        mac_psum_buffer_7 <= tmp_mac_psum_buffer_7;
      end else begin
        if(psum1_read_bias) begin
          mac_psum_buffer_0 <= tmp_mac_psum_buffer_0;
          mac_psum_buffer_1 <= tmp_mac_psum_buffer_1;
          mac_psum_buffer_2 <= tmp_mac_psum_buffer_2;
          mac_psum_buffer_3 <= tmp_mac_psum_buffer_3;
        end else begin
          if(psum4_read_psum) begin
            mac_psum_buffer_6 <= tmp_mac_psum_buffer_6_2;
            mac_psum_buffer_7 <= tmp_mac_psum_buffer_7_2;
          end else begin
            if(psum3_read_psum) begin
              mac_psum_buffer_4 <= tmp_mac_psum_buffer_4_2;
              mac_psum_buffer_5 <= tmp_mac_psum_buffer_5_2;
            end else begin
              if(psum2_read_psum) begin
                mac_psum_buffer_2 <= tmp_mac_psum_buffer_2_2;
                mac_psum_buffer_3 <= tmp_mac_psum_buffer_3_2;
              end else begin
                if(psum1_read_psum) begin
                  mac_psum_buffer_0 <= tmp_mac_psum_buffer_0_2;
                  mac_psum_buffer_1 <= tmp_mac_psum_buffer_1_2;
                end else begin
                  if((mac_psum_acc_valid && (! is_scala_mult))) begin
                    if(tmp_1[0]) begin
                      mac_psum_buffer_0 <= mac_psum_out;
                    end
                    if(tmp_1[1]) begin
                      mac_psum_buffer_1 <= mac_psum_out;
                    end
                    if(tmp_1[2]) begin
                      mac_psum_buffer_2 <= mac_psum_out;
                    end
                    if(tmp_1[3]) begin
                      mac_psum_buffer_3 <= mac_psum_out;
                    end
                    if(tmp_1[4]) begin
                      mac_psum_buffer_4 <= mac_psum_out;
                    end
                    if(tmp_1[5]) begin
                      mac_psum_buffer_5 <= mac_psum_out;
                    end
                    if(tmp_1[6]) begin
                      mac_psum_buffer_6 <= mac_psum_out;
                    end
                    if(tmp_1[7]) begin
                      mac_psum_buffer_7 <= mac_psum_out;
                    end
                  end else begin
                    if(scala_data_in_val) begin
                      mac_psum_buffer_0 <= tmp_mac_psum_buffer_0_4;
                      mac_psum_buffer_1 <= tmp_mac_psum_buffer_1_4;
                      mac_psum_buffer_2 <= tmp_mac_psum_buffer_2_4;
                      mac_psum_buffer_3 <= tmp_mac_psum_buffer_3_4;
                      mac_psum_buffer_4 <= tmp_mac_psum_buffer_4_4;
                      mac_psum_buffer_5 <= tmp_mac_psum_buffer_5_4;
                      mac_psum_buffer_6 <= tmp_mac_psum_buffer_6_4;
                      mac_psum_buffer_7 <= tmp_mac_psum_buffer_7_4;
                    end
                  end
                end
              end
            end
          end
        end
      end
      if((statein_load_psum1 && psum_come_from_coef)) begin
        coef_ena <= 1'b1;
        coef_wena <= 1'b0;
        coef_addr <= (psum_base_addr + tmp_coef_addr);
      end else begin
        if((statein_load_psum2 && psum_come_from_coef)) begin
          coef_ena <= 1'b1;
          coef_wena <= 1'b0;
          coef_addr <= (tmp_coef_addr_2 + 10'h001);
        end else begin
          if(Iter_inCnt_inc) begin
            coef_ena <= 1'b1;
            coef_wena <= 1'b0;
            coef_addr <= weight_read_addr;
          end else begin
            if(mac_input_read_end) begin
              coef_ena <= 1'b0;
              coef_wena <= 1'b0;
              coef_addr <= 10'h0;
            end
          end
        end
      end
      if((statein_load_psum1 && (! psum_come_from_coef))) begin
        cache_ena <= 1'b1;
        cache_wena <= 1'b0;
        cache_addr <= tmp_cache_addr[6:0];
      end else begin
        if((statein_load_psum2 && (! psum_come_from_coef))) begin
          cache_ena <= 1'b1;
          cache_wena <= 1'b0;
          cache_addr <= tmp_cache_addr_3[6:0];
        end else begin
          if((statein_load_psum3 && (! psum_come_from_coef))) begin
            cache_ena <= 1'b1;
            cache_wena <= 1'b0;
            cache_addr <= tmp_cache_addr_7[6:0];
          end else begin
            if((statein_load_psum4 && (! psum_come_from_coef))) begin
              cache_ena <= 1'b1;
              cache_wena <= 1'b0;
              cache_addr <= tmp_cache_addr_11[6:0];
            end else begin
              if((Iter_inCnt_inc && (! scala_data_in_val))) begin
                cache_ena <= 1'b1;
                cache_wena <= 1'b0;
                cache_addr <= (input_base_addr + tmp_cache_addr_15);
              end else begin
                if((matmul_result_write_en || fc_layer_write_psum_en)) begin
                  cache_ena <= 1'b1;
                  cache_wena <= 1'b1;
                  cache_addr <= (output_base_addr + tmp_cache_addr_16);
                  cache_wdata <= mac_psum_gather_8b;
                end else begin
                  if(matmulH_write_psum_en1) begin
                    cache_ena <= 1'b1;
                    cache_wena <= 1'b1;
                    cache_addr <= (tmp_cache_addr_17 + tmp_cache_addr_18);
                    cache_wdata <= mac_psum_gather_32b_0;
                  end else begin
                    if(matmulH_write_psum_en2) begin
                      cache_ena <= 1'b1;
                      cache_wena <= 1'b1;
                      cache_addr <= (tmp_cache_addr_20 + 7'h01);
                      cache_wdata <= mac_psum_gather_32b_1;
                    end else begin
                      if(matmulH_write_psum_en3) begin
                        cache_ena <= 1'b1;
                        cache_wena <= 1'b1;
                        cache_addr <= (tmp_cache_addr_24 + 7'h02);
                        cache_wdata <= mac_psum_gather_32b_2;
                      end else begin
                        if(matmulH_write_psum_en4) begin
                          cache_ena <= 1'b1;
                          cache_wena <= 1'b1;
                          cache_addr <= (tmp_cache_addr_28 + 7'h03);
                          cache_wdata <= mac_psum_gather_32b_3;
                        end else begin
                          if(scala_write_out_en1) begin
                            cache_ena <= 1'b1;
                            cache_wena <= 1'b1;
                            cache_addr <= output_base_addr;
                            cache_wdata <= mac_psum_gather_8b;
                          end else begin
                            if(scala_write_out_en2) begin
                              cache_ena <= 1'b1;
                              cache_wena <= 1'b1;
                              cache_addr <= (output_base_addr + 7'h01);
                              cache_wdata <= mac_psum_gather_8b;
                            end else begin
                              if((write_psum_pulse4 || mac_input_read_end)) begin
                                cache_ena <= 1'b0;
                                cache_wena <= 1'b0;
                                cache_addr <= 7'h0;
                                cache_wdata <= 64'h0;
                              end else begin
                                cache_ena <= 1'b0;
                                cache_wena <= 1'b0;
                                cache_addr <= 7'h0;
                                cache_wdata <= 64'h0;
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  always @(posedge clkout) begin
    if(psum1_read_scala) begin
      scala_data_in_buf_0_0 <= cache_read_slice_8bits_0;
      scala_data_in_buf_0_1 <= cache_read_slice_8bits_1;
      scala_data_in_buf_0_2 <= cache_read_slice_8bits_2;
      scala_data_in_buf_0_3 <= cache_read_slice_8bits_3;
      scala_data_in_buf_0_4 <= cache_read_slice_8bits_4;
      scala_data_in_buf_0_5 <= cache_read_slice_8bits_5;
      scala_data_in_buf_0_6 <= cache_read_slice_8bits_6;
      scala_data_in_buf_0_7 <= cache_read_slice_8bits_7;
    end else begin
      if(psum2_read_scala) begin
        scala_data_in_buf_1_0 <= cache_read_slice_8bits_0;
        scala_data_in_buf_1_1 <= cache_read_slice_8bits_1;
        scala_data_in_buf_1_2 <= cache_read_slice_8bits_2;
        scala_data_in_buf_1_3 <= cache_read_slice_8bits_3;
        scala_data_in_buf_1_4 <= cache_read_slice_8bits_4;
        scala_data_in_buf_1_5 <= cache_read_slice_8bits_5;
        scala_data_in_buf_1_6 <= cache_read_slice_8bits_6;
        scala_data_in_buf_1_7 <= cache_read_slice_8bits_7;
      end
    end
  end


endmodule

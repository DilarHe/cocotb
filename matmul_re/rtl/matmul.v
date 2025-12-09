// Generator : SpinalHDL v1.10.0    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : matmul
// Git hash  : 56c2b66e602752b287b395de50f6f24a76424a54

`timescale 1ns/1ps 
module matmul (
  input  wire          start,
  input  wire [2:0]    rg_rnn_data_ratio,
  input  wire [2:0]    input_loop_num,
  input  wire [2:0]    output_loop_num,
  input  wire          psum_come_from_coef,
  input  wire [7:0]    psum_base_addr,
  input  wire [7:0]    weight_base_addr,
  input  wire [3:0]    input_base_addr,
  input  wire [3:0]    output_base_addr,
  output reg           coef_ena,
  output reg           coef_wena,
  output reg  [7:0]    coef_addr,
  output reg  [63:0]   coef_wdata,
  input  wire [63:0]   coef_rdata,
  output reg           cache_ena,
  output reg           cache_wena,
  output reg  [3:0]    cache_addr,
  output reg  [63:0]   cache_wdata,
  input  wire [63:0]   cache_rdata,
  output wire          done,
  input  wire          clk,
  input  wire          resetn
);
  localparam MATMUL_STATE_IDLE = 2'd0;
  localparam MATMUL_STATE_LOAD_PSUM1 = 2'd1;
  localparam MATMUL_STATE_LOAD_PSUM2 = 2'd2;
  localparam MATMUL_STATE_MAC = 2'd3;

  wire                mac_clka;
  wire                mac_rstn_a;
  wire       [19:0]   mac_psum_in;
  wire       [19:0]   mac_psum_out;
  wire                mac_psum_acc_valid;
  wire       [3:0]    tmp_Iter_outLoopCnt_ov;
  wire       [3:0]    tmp_Iter_outLoopCnt_ov_1;
  wire       [1:0]    tmp_Iter_outLoopCnt_ov_2;
  reg        [19:0]   tmp_psum_in;
  wire       [19:0]   tmp_mac_psum_buffer_4;
  wire       [22:0]   tmp_mac_psum_buffer_4_1;
  wire       [15:0]   tmp_mac_psum_buffer_4_2;
  wire       [19:0]   tmp_mac_psum_buffer_5;
  wire       [22:0]   tmp_mac_psum_buffer_5_1;
  wire       [15:0]   tmp_mac_psum_buffer_5_2;
  wire       [19:0]   tmp_mac_psum_buffer_6;
  wire       [22:0]   tmp_mac_psum_buffer_6_1;
  wire       [15:0]   tmp_mac_psum_buffer_6_2;
  wire       [19:0]   tmp_mac_psum_buffer_7;
  wire       [22:0]   tmp_mac_psum_buffer_7_1;
  wire       [15:0]   tmp_mac_psum_buffer_7_2;
  wire       [19:0]   tmp_mac_psum_buffer_0;
  wire       [22:0]   tmp_mac_psum_buffer_0_1;
  wire       [15:0]   tmp_mac_psum_buffer_0_2;
  wire       [19:0]   tmp_mac_psum_buffer_1;
  wire       [22:0]   tmp_mac_psum_buffer_1_1;
  wire       [15:0]   tmp_mac_psum_buffer_1_2;
  wire       [19:0]   tmp_mac_psum_buffer_2;
  wire       [22:0]   tmp_mac_psum_buffer_2_1;
  wire       [15:0]   tmp_mac_psum_buffer_2_2;
  wire       [19:0]   tmp_mac_psum_buffer_3;
  wire       [22:0]   tmp_mac_psum_buffer_3_1;
  wire       [15:0]   tmp_mac_psum_buffer_3_2;
  wire       [31:0]   tmp_mac_psum_out_32b_0_0;
  wire       [19:0]   tmp_mac_psum_out_32b_0_0_1;
  wire       [31:0]   tmp_mac_psum_out_32b_1_0;
  wire       [19:0]   tmp_mac_psum_out_32b_1_0_1;
  wire       [31:0]   tmp_mac_psum_out_32b_2_0;
  wire       [19:0]   tmp_mac_psum_out_32b_2_0_1;
  wire       [31:0]   tmp_mac_psum_out_32b_3_0;
  wire       [19:0]   tmp_mac_psum_out_32b_3_0_1;
  wire       [31:0]   tmp_mac_psum_out_32b_0_1;
  wire       [19:0]   tmp_mac_psum_out_32b_0_1_1;
  wire       [31:0]   tmp_mac_psum_out_32b_1_1;
  wire       [19:0]   tmp_mac_psum_out_32b_1_1_1;
  wire       [31:0]   tmp_mac_psum_out_32b_2_1;
  wire       [19:0]   tmp_mac_psum_out_32b_2_1_1;
  wire       [31:0]   tmp_mac_psum_out_32b_3_1;
  wire       [19:0]   tmp_mac_psum_out_32b_3_1_1;
  wire       [7:0]    tmp_coef_addr;
  wire       [4:0]    tmp_coef_addr_1;
  wire       [7:0]    tmp_coef_addr_2;
  wire       [7:0]    tmp_coef_addr_3;
  wire       [4:0]    tmp_coef_addr_4;
  wire       [7:0]    tmp_cache_addr;
  wire       [7:0]    tmp_cache_addr_1;
  wire       [4:0]    tmp_cache_addr_2;
  wire       [7:0]    tmp_cache_addr_3;
  wire       [7:0]    tmp_cache_addr_4;
  wire       [7:0]    tmp_cache_addr_5;
  wire       [4:0]    tmp_cache_addr_6;
  wire       [3:0]    tmp_cache_addr_7;
  wire       [4:0]    tmp_cache_addr_8;
  wire       [4:0]    tmp_cache_addr_9;
  wire       [4:0]    tmp_cache_addr_10;
  wire       [4:0]    tmp_cache_addr_11;
  wire       [4:0]    tmp_cache_addr_12;
  wire       [4:0]    tmp_cache_addr_13;
  wire       [4:0]    tmp_cache_addr_14;
  wire       [4:0]    tmp_cache_addr_15;
  wire       [4:0]    tmp_cache_addr_16;
  wire       [4:0]    tmp_cache_addr_17;
  wire       [4:0]    tmp_cache_addr_18;
  wire       [4:0]    tmp_cache_addr_19;
  wire       [4:0]    tmp_cache_addr_20;
  wire       [4:0]    tmp_cache_addr_21;
  wire       [4:0]    tmp_cache_addr_22;
  reg        [1:0]    curr_state;
  reg        [1:0]    next_state;
  wire                state_is_idle;
  wire                state_is_load_psum1;
  wire                statein_load_psum1;
  wire                state_is_load_psum2;
  wire                statein_load_psum2;
  reg        [2:0]    Iter_inCnt;
  wire                Iter_inCnt_inc;
  reg                 Iter_inCnt_inc_not;
  wire                Iter_inCnt_ov;
  reg        [2:0]    Iter_sliceCnt;
  wire                Iter_sliceCnt_ov;
  reg        [3:0]    Iter_outLoopCnt;
  wire                Iter_outLoopCnt_ov;
  reg        [7:0]    weight_read_addr;
  reg                 psum1_read_out_flag;
  reg                 psum2_read_out_flag;
  reg                 tmp_switch_psum_pulse;
  reg                 tmp_switch_psum_pulse_1;
  reg                 switch_psum_pulse;
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
  reg        [19:0]   mac_psum_buffer_0;
  reg        [19:0]   mac_psum_buffer_1;
  reg        [19:0]   mac_psum_buffer_2;
  reg        [19:0]   mac_psum_buffer_3;
  reg        [19:0]   mac_psum_buffer_4;
  reg        [19:0]   mac_psum_buffer_5;
  reg        [19:0]   mac_psum_buffer_6;
  reg        [19:0]   mac_psum_buffer_7;
  wire       [31:0]   mac_psum_out_32b_0_0;
  wire       [31:0]   mac_psum_out_32b_0_1;
  wire       [31:0]   mac_psum_out_32b_1_0;
  wire       [31:0]   mac_psum_out_32b_1_1;
  wire       [31:0]   mac_psum_out_32b_2_0;
  wire       [31:0]   mac_psum_out_32b_2_1;
  wire       [31:0]   mac_psum_out_32b_3_0;
  wire       [31:0]   mac_psum_out_32b_3_1;
  wire       [63:0]   mac_psum_gather_32b_0;
  wire       [63:0]   mac_psum_gather_32b_1;
  wire       [63:0]   mac_psum_gather_32b_2;
  wire       [63:0]   mac_psum_gather_32b_3;
  reg                 mac_input_valid_regNext;
  wire                mac_pipe_last2_valid_fall;
  reg                 mac_once_finish;
  reg                 write_psum_pulse1;
  reg                 write_psum_pulse2;
  reg                 write_psum_pulse3;
  reg                 write_psum_pulse4;
  wire       [7:0]    tmp_1;
  `ifndef SYNTHESIS
  reg [79:0] curr_state_string;
  reg [79:0] next_state_string;
  `endif


  assign tmp_Iter_outLoopCnt_ov = ({1'b0,output_loop_num} + tmp_Iter_outLoopCnt_ov_1);
  assign tmp_Iter_outLoopCnt_ov_2 = {1'b0,1'b1};
  assign tmp_Iter_outLoopCnt_ov_1 = {2'd0, tmp_Iter_outLoopCnt_ov_2};
  assign tmp_mac_psum_buffer_4_1 = ({{7{tmp_mac_psum_buffer_4_2[15]}},tmp_mac_psum_buffer_4_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_4 = tmp_mac_psum_buffer_4_1[19:0];
  assign tmp_mac_psum_buffer_4_2 = coef_rdata[15 : 0];
  assign tmp_mac_psum_buffer_5_1 = ({{7{tmp_mac_psum_buffer_5_2[15]}},tmp_mac_psum_buffer_5_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_5 = tmp_mac_psum_buffer_5_1[19:0];
  assign tmp_mac_psum_buffer_5_2 = coef_rdata[31 : 16];
  assign tmp_mac_psum_buffer_6_1 = ({{7{tmp_mac_psum_buffer_6_2[15]}},tmp_mac_psum_buffer_6_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_6 = tmp_mac_psum_buffer_6_1[19:0];
  assign tmp_mac_psum_buffer_6_2 = coef_rdata[47 : 32];
  assign tmp_mac_psum_buffer_7_1 = ({{7{tmp_mac_psum_buffer_7_2[15]}},tmp_mac_psum_buffer_7_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_7 = tmp_mac_psum_buffer_7_1[19:0];
  assign tmp_mac_psum_buffer_7_2 = coef_rdata[63 : 48];
  assign tmp_mac_psum_buffer_0_1 = ({{7{tmp_mac_psum_buffer_0_2[15]}},tmp_mac_psum_buffer_0_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_0 = tmp_mac_psum_buffer_0_1[19:0];
  assign tmp_mac_psum_buffer_0_2 = coef_rdata[15 : 0];
  assign tmp_mac_psum_buffer_1_1 = ({{7{tmp_mac_psum_buffer_1_2[15]}},tmp_mac_psum_buffer_1_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_1 = tmp_mac_psum_buffer_1_1[19:0];
  assign tmp_mac_psum_buffer_1_2 = coef_rdata[31 : 16];
  assign tmp_mac_psum_buffer_2_1 = ({{7{tmp_mac_psum_buffer_2_2[15]}},tmp_mac_psum_buffer_2_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_2 = tmp_mac_psum_buffer_2_1[19:0];
  assign tmp_mac_psum_buffer_2_2 = coef_rdata[47 : 32];
  assign tmp_mac_psum_buffer_3_1 = ({{7{tmp_mac_psum_buffer_3_2[15]}},tmp_mac_psum_buffer_3_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_3 = tmp_mac_psum_buffer_3_1[19:0];
  assign tmp_mac_psum_buffer_3_2 = coef_rdata[63 : 48];
  assign tmp_mac_psum_out_32b_0_0_1 = mac_psum_buffer_0;
  assign tmp_mac_psum_out_32b_0_0 = {{12{tmp_mac_psum_out_32b_0_0_1[19]}}, tmp_mac_psum_out_32b_0_0_1};
  assign tmp_mac_psum_out_32b_1_0_1 = mac_psum_buffer_2;
  assign tmp_mac_psum_out_32b_1_0 = {{12{tmp_mac_psum_out_32b_1_0_1[19]}}, tmp_mac_psum_out_32b_1_0_1};
  assign tmp_mac_psum_out_32b_2_0_1 = mac_psum_buffer_4;
  assign tmp_mac_psum_out_32b_2_0 = {{12{tmp_mac_psum_out_32b_2_0_1[19]}}, tmp_mac_psum_out_32b_2_0_1};
  assign tmp_mac_psum_out_32b_3_0_1 = mac_psum_buffer_6;
  assign tmp_mac_psum_out_32b_3_0 = {{12{tmp_mac_psum_out_32b_3_0_1[19]}}, tmp_mac_psum_out_32b_3_0_1};
  assign tmp_mac_psum_out_32b_0_1_1 = mac_psum_buffer_1;
  assign tmp_mac_psum_out_32b_0_1 = {{12{tmp_mac_psum_out_32b_0_1_1[19]}}, tmp_mac_psum_out_32b_0_1_1};
  assign tmp_mac_psum_out_32b_1_1_1 = mac_psum_buffer_3;
  assign tmp_mac_psum_out_32b_1_1 = {{12{tmp_mac_psum_out_32b_1_1_1[19]}}, tmp_mac_psum_out_32b_1_1_1};
  assign tmp_mac_psum_out_32b_2_1_1 = mac_psum_buffer_5;
  assign tmp_mac_psum_out_32b_2_1 = {{12{tmp_mac_psum_out_32b_2_1_1[19]}}, tmp_mac_psum_out_32b_2_1_1};
  assign tmp_mac_psum_out_32b_3_1_1 = mac_psum_buffer_7;
  assign tmp_mac_psum_out_32b_3_1 = {{12{tmp_mac_psum_out_32b_3_1_1[19]}}, tmp_mac_psum_out_32b_3_1_1};
  assign tmp_coef_addr_1 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  assign tmp_coef_addr = {3'd0, tmp_coef_addr_1};
  assign tmp_coef_addr_2 = (psum_base_addr + tmp_coef_addr_3);
  assign tmp_coef_addr_4 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  assign tmp_coef_addr_3 = {3'd0, tmp_coef_addr_4};
  assign tmp_cache_addr = (psum_base_addr + tmp_cache_addr_1);
  assign tmp_cache_addr_2 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  assign tmp_cache_addr_1 = {3'd0, tmp_cache_addr_2};
  assign tmp_cache_addr_3 = (tmp_cache_addr_4 + 8'h01);
  assign tmp_cache_addr_4 = (psum_base_addr + tmp_cache_addr_5);
  assign tmp_cache_addr_6 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  assign tmp_cache_addr_5 = {3'd0, tmp_cache_addr_6};
  assign tmp_cache_addr_7 = {1'd0, Iter_inCnt};
  assign tmp_cache_addr_8 = (tmp_cache_addr_9 + tmp_cache_addr_10);
  assign tmp_cache_addr_9 = {1'd0, output_base_addr};
  assign tmp_cache_addr_10 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  assign tmp_cache_addr_11 = (tmp_cache_addr_12 + 5'h01);
  assign tmp_cache_addr_12 = (tmp_cache_addr_13 + tmp_cache_addr_14);
  assign tmp_cache_addr_13 = {1'd0, output_base_addr};
  assign tmp_cache_addr_14 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  assign tmp_cache_addr_15 = (tmp_cache_addr_16 + 5'h02);
  assign tmp_cache_addr_16 = (tmp_cache_addr_17 + tmp_cache_addr_18);
  assign tmp_cache_addr_17 = {1'd0, output_base_addr};
  assign tmp_cache_addr_18 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  assign tmp_cache_addr_19 = (tmp_cache_addr_20 + 5'h03);
  assign tmp_cache_addr_20 = (tmp_cache_addr_21 + tmp_cache_addr_22);
  assign tmp_cache_addr_21 = {1'd0, output_base_addr};
  assign tmp_cache_addr_22 = ({1'd0,Iter_outLoopCnt} <<< 1'd1);
  mac_unit mac (
    .clka           (mac_clka            ), //i
    .rstn_a         (mac_rstn_a          ), //i
    .valid          (mac_input_valid     ), //i
    .A_0            (mac_weight_in_0[7:0]), //i
    .A_1            (mac_weight_in_1[7:0]), //i
    .A_2            (mac_weight_in_2[7:0]), //i
    .A_3            (mac_weight_in_3[7:0]), //i
    .A_4            (mac_weight_in_4[7:0]), //i
    .A_5            (mac_weight_in_5[7:0]), //i
    .A_6            (mac_weight_in_6[7:0]), //i
    .A_7            (mac_weight_in_7[7:0]), //i
    .B_0            (mac_data_in_0[7:0]  ), //i
    .B_1            (mac_data_in_1[7:0]  ), //i
    .B_2            (mac_data_in_2[7:0]  ), //i
    .B_3            (mac_data_in_3[7:0]  ), //i
    .B_4            (mac_data_in_4[7:0]  ), //i
    .B_5            (mac_data_in_5[7:0]  ), //i
    .B_6            (mac_data_in_6[7:0]  ), //i
    .B_7            (mac_data_in_7[7:0]  ), //i
    .psum_in        (mac_psum_in[19:0]   ), //i
    .psum_out       (mac_psum_out[19:0]  ), //o
    .psum_acc_valid (mac_psum_acc_valid  ), //o
    .clk            (clk                 ), //i
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
      MATMUL_STATE_MAC : curr_state_string = "MAC       ";
      default : curr_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      MATMUL_STATE_IDLE : next_state_string = "IDLE      ";
      MATMUL_STATE_LOAD_PSUM1 : next_state_string = "LOAD_PSUM1";
      MATMUL_STATE_LOAD_PSUM2 : next_state_string = "LOAD_PSUM2";
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
  assign done = ((curr_state == MATMUL_STATE_MAC) && (next_state == MATMUL_STATE_IDLE));
  assign Iter_inCnt_ov = (Iter_inCnt == input_loop_num);
  assign Iter_sliceCnt_ov = (Iter_sliceCnt == 3'b111);
  assign Iter_outLoopCnt_ov = (Iter_outLoopCnt == tmp_Iter_outLoopCnt_ov);
  assign switch_psum_index_ov = (switch_psum_index == 3'b111);
  assign mac_input_read_end = ((! Iter_inCnt_inc) && Iter_inCnt_inc_regNext);
  assign mac_psum_gather_32b_0 = {mac_psum_out_32b_0_1,mac_psum_out_32b_0_0};
  assign mac_psum_gather_32b_1 = {mac_psum_out_32b_1_1,mac_psum_out_32b_1_0};
  assign mac_psum_gather_32b_2 = {mac_psum_out_32b_2_1,mac_psum_out_32b_2_0};
  assign mac_psum_gather_32b_3 = {mac_psum_out_32b_3_1,mac_psum_out_32b_3_0};
  assign mac_pipe_last2_valid_fall = ((! mac_input_valid) && mac_input_valid_regNext);
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
    mac_weight_in_0 = 8'h00;
    if(mac_input_valid) begin
      mac_weight_in_0 = coef_rdata[7 : 0];
    end
  end

  always @(*) begin
    mac_data_in_0 = 8'h00;
    if(mac_input_valid) begin
      mac_data_in_0 = cache_rdata[7 : 0];
    end
  end

  always @(*) begin
    mac_weight_in_1 = 8'h00;
    if(mac_input_valid) begin
      mac_weight_in_1 = coef_rdata[15 : 8];
    end
  end

  always @(*) begin
    mac_data_in_1 = 8'h00;
    if(mac_input_valid) begin
      mac_data_in_1 = cache_rdata[15 : 8];
    end
  end

  always @(*) begin
    mac_weight_in_2 = 8'h00;
    if(mac_input_valid) begin
      mac_weight_in_2 = coef_rdata[23 : 16];
    end
  end

  always @(*) begin
    mac_data_in_2 = 8'h00;
    if(mac_input_valid) begin
      mac_data_in_2 = cache_rdata[23 : 16];
    end
  end

  always @(*) begin
    mac_weight_in_3 = 8'h00;
    if(mac_input_valid) begin
      mac_weight_in_3 = coef_rdata[31 : 24];
    end
  end

  always @(*) begin
    mac_data_in_3 = 8'h00;
    if(mac_input_valid) begin
      mac_data_in_3 = cache_rdata[31 : 24];
    end
  end

  always @(*) begin
    mac_weight_in_4 = 8'h00;
    if(mac_input_valid) begin
      mac_weight_in_4 = coef_rdata[39 : 32];
    end
  end

  always @(*) begin
    mac_data_in_4 = 8'h00;
    if(mac_input_valid) begin
      mac_data_in_4 = cache_rdata[39 : 32];
    end
  end

  always @(*) begin
    mac_weight_in_5 = 8'h00;
    if(mac_input_valid) begin
      mac_weight_in_5 = coef_rdata[47 : 40];
    end
  end

  always @(*) begin
    mac_data_in_5 = 8'h00;
    if(mac_input_valid) begin
      mac_data_in_5 = cache_rdata[47 : 40];
    end
  end

  always @(*) begin
    mac_weight_in_6 = 8'h00;
    if(mac_input_valid) begin
      mac_weight_in_6 = coef_rdata[55 : 48];
    end
  end

  always @(*) begin
    mac_data_in_6 = 8'h00;
    if(mac_input_valid) begin
      mac_data_in_6 = cache_rdata[55 : 48];
    end
  end

  always @(*) begin
    mac_weight_in_7 = 8'h00;
    if(mac_input_valid) begin
      mac_weight_in_7 = coef_rdata[63 : 56];
    end
  end

  always @(*) begin
    mac_data_in_7 = 8'h00;
    if(mac_input_valid) begin
      mac_data_in_7 = cache_rdata[63 : 56];
    end
  end

  assign tmp_1 = ({7'd0,1'b1} <<< switch_psum_index);
  assign mac_psum_in = tmp_psum_in;
  assign mac_psum_out_32b_0_0 = tmp_mac_psum_out_32b_0_0;
  assign mac_psum_out_32b_1_0 = tmp_mac_psum_out_32b_1_0;
  assign mac_psum_out_32b_2_0 = tmp_mac_psum_out_32b_2_0;
  assign mac_psum_out_32b_3_0 = tmp_mac_psum_out_32b_3_0;
  assign mac_psum_out_32b_0_1 = tmp_mac_psum_out_32b_0_1;
  assign mac_psum_out_32b_1_1 = tmp_mac_psum_out_32b_1_1;
  assign mac_psum_out_32b_2_1 = tmp_mac_psum_out_32b_2_1;
  assign mac_psum_out_32b_3_1 = tmp_mac_psum_out_32b_3_1;
  always @(*) begin
    coef_wdata = 64'h0000000000000000;
    if(!(statein_load_psum1 && psum_come_from_coef)) begin
      if(!(statein_load_psum2 && psum_come_from_coef)) begin
        if(!Iter_inCnt_inc) begin
          if(mac_input_read_end) begin
            coef_wdata = 64'h0000000000000000;
          end
        end
      end
    end
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      curr_state <= MATMUL_STATE_IDLE;
      Iter_inCnt <= 3'b000;
      Iter_inCnt_inc_not <= 1'b0;
      Iter_sliceCnt <= 3'b000;
      Iter_outLoopCnt <= 4'b0000;
      weight_read_addr <= 8'h00;
      psum1_read_out_flag <= 1'b0;
      psum2_read_out_flag <= 1'b0;
      tmp_switch_psum_pulse <= 1'b0;
      tmp_switch_psum_pulse_1 <= 1'b0;
      switch_psum_pulse <= 1'b0;
      switch_psum_index <= 3'b000;
      mac_input_read <= 1'b0;
      Iter_inCnt_inc_regNext <= 1'b0;
      mac_input_valid <= 1'b0;
      mac_psum_buffer_0 <= 20'h00000;
      mac_psum_buffer_1 <= 20'h00000;
      mac_psum_buffer_2 <= 20'h00000;
      mac_psum_buffer_3 <= 20'h00000;
      mac_psum_buffer_4 <= 20'h00000;
      mac_psum_buffer_5 <= 20'h00000;
      mac_psum_buffer_6 <= 20'h00000;
      mac_psum_buffer_7 <= 20'h00000;
      mac_input_valid_regNext <= 1'b0;
      mac_once_finish <= 1'b0;
      write_psum_pulse1 <= 1'b0;
      write_psum_pulse2 <= 1'b0;
      write_psum_pulse3 <= 1'b0;
      write_psum_pulse4 <= 1'b0;
      coef_addr <= 8'h00;
      coef_wena <= 1'b0;
      coef_ena <= 1'b0;
      cache_addr <= 4'b0000;
      cache_wena <= 1'b0;
      cache_ena <= 1'b0;
      cache_wdata <= 64'h0000000000000000;
    end else begin
      psum1_read_out_flag <= state_is_load_psum1;
      psum2_read_out_flag <= state_is_load_psum2;
      tmp_switch_psum_pulse <= (Iter_inCnt_ov && Iter_inCnt_inc);
      tmp_switch_psum_pulse_1 <= tmp_switch_psum_pulse;
      switch_psum_pulse <= tmp_switch_psum_pulse_1;
      mac_input_read <= Iter_inCnt_inc;
      Iter_inCnt_inc_regNext <= Iter_inCnt_inc;
      mac_input_valid <= mac_input_read;
      mac_input_valid_regNext <= mac_input_valid;
      mac_once_finish <= mac_pipe_last2_valid_fall;
      write_psum_pulse1 <= mac_once_finish;
      write_psum_pulse2 <= write_psum_pulse1;
      write_psum_pulse3 <= write_psum_pulse2;
      write_psum_pulse4 <= write_psum_pulse3;
      curr_state <= next_state;
      if(statein_load_psum2) begin
        Iter_inCnt_inc_not <= 1'b1;
      end else begin
        if((Iter_inCnt_ov && Iter_sliceCnt_ov)) begin
          Iter_inCnt_inc_not <= 1'b0;
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
          weight_read_addr <= (weight_read_addr + 8'h01);
        end
      end
      if(switch_psum_pulse) begin
        if(switch_psum_index_ov) begin
          switch_psum_index <= 3'b000;
        end else begin
          switch_psum_index <= (switch_psum_index + 3'b001);
        end
      end
      if((psum2_read_out_flag && psum_come_from_coef)) begin
        mac_psum_buffer_4 <= tmp_mac_psum_buffer_4;
        mac_psum_buffer_5 <= tmp_mac_psum_buffer_5;
        mac_psum_buffer_6 <= tmp_mac_psum_buffer_6;
        mac_psum_buffer_7 <= tmp_mac_psum_buffer_7;
      end else begin
        if((psum1_read_out_flag && psum_come_from_coef)) begin
          mac_psum_buffer_0 <= tmp_mac_psum_buffer_0;
          mac_psum_buffer_1 <= tmp_mac_psum_buffer_1;
          mac_psum_buffer_2 <= tmp_mac_psum_buffer_2;
          mac_psum_buffer_3 <= tmp_mac_psum_buffer_3;
        end else begin
          if(mac_psum_acc_valid) begin
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
          coef_addr <= (tmp_coef_addr_2 + 8'h01);
        end else begin
          if(Iter_inCnt_inc) begin
            coef_ena <= 1'b1;
            coef_wena <= 1'b0;
            coef_addr <= weight_read_addr;
          end else begin
            if(mac_input_read_end) begin
              coef_ena <= 1'b0;
              coef_wena <= 1'b0;
              coef_addr <= 8'h00;
            end
          end
        end
      end
      if((statein_load_psum1 && (! psum_come_from_coef))) begin
        cache_ena <= 1'b1;
        cache_wena <= 1'b0;
        cache_addr <= tmp_cache_addr[3:0];
      end else begin
        if((statein_load_psum2 && (! psum_come_from_coef))) begin
          cache_ena <= 1'b1;
          cache_wena <= 1'b0;
          cache_addr <= tmp_cache_addr_3[3:0];
        end else begin
          if(Iter_inCnt_inc) begin
            cache_ena <= 1'b1;
            cache_wena <= 1'b0;
            cache_addr <= (input_base_addr + tmp_cache_addr_7);
          end else begin
            if(mac_once_finish) begin
              cache_ena <= 1'b1;
              cache_wena <= 1'b1;
              cache_addr <= tmp_cache_addr_8[3:0];
              cache_wdata <= mac_psum_gather_32b_0;
            end else begin
              if(write_psum_pulse1) begin
                cache_ena <= 1'b1;
                cache_wena <= 1'b1;
                cache_addr <= tmp_cache_addr_11[3:0];
                cache_wdata <= mac_psum_gather_32b_1;
              end else begin
                if(write_psum_pulse2) begin
                  cache_ena <= 1'b1;
                  cache_wena <= 1'b1;
                  cache_addr <= tmp_cache_addr_15[3:0];
                  cache_wdata <= mac_psum_gather_32b_2;
                end else begin
                  if(write_psum_pulse3) begin
                    cache_ena <= 1'b1;
                    cache_wena <= 1'b1;
                    cache_addr <= tmp_cache_addr_19[3:0];
                    cache_wdata <= mac_psum_gather_32b_3;
                  end else begin
                    if((write_psum_pulse4 || mac_input_read_end)) begin
                      cache_ena <= 1'b0;
                      cache_wena <= 1'b0;
                      cache_addr <= 4'b0000;
                      cache_wdata <= 64'h0000000000000000;
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


endmodule

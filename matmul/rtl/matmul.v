// Generator : SpinalHDL v1.8.1    git head : 2a7592004363e5b40ec43e1f122ed8641cd8965b
// Component : matmul

`timescale 1ns/1ps

module matmul (
  input               start_once,
  input               need_relu,
  input               need_scale,
  input      [2:0]    rg_rnn_data_ratio,
  input      [1:0]    ifmap_loop_num,
  input      [1:0]    ofmap_loop_num,
  input      [7:0]    psum_base_addr,
  input      [7:0]    weight_base_addr,
  input      [4:0]    ifmap_base_addr,
  input      [4:0]    ofmap_base_addr,
  input               psum_come_from_coef,
  output reg          coef_ena,
  output reg          coef_wena,
  output reg [7:0]    coef_addr,
  output reg [31:0]   coef_wdata,
  input      [31:0]   coef_rdata,
  output reg          cache_ena,
  output reg          cache_wena,
  output reg [4:0]    cache_addr,
  output reg [31:0]   cache_wdata,
  input      [31:0]   cache_rdata,
  output              done,
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam LOAD_PSUM1 = 2'd1;
  localparam LOAD_PSUM2 = 2'd2;
  localparam MAC = 2'd3;

  wire       [15:0]   mac_psum_in;
  wire       [15:0]   mac_psum_out;
  wire                mac_psum_acc_valid;
  wire       [2:0]    tmp_outLoopCnt_ov_flag;
  wire       [2:0]    tmp_outLoopCnt_ov_flag_1;
  wire       [1:0]    tmp_outLoopCnt_ov_flag_2;
  wire       [15:0]   tmp_mac_psum_buffer_scale_0;
  wire       [8:0]    tmp_when;
  wire       [7:0]    tmp_when_1;
  wire       [7:0]    tmp_when_2;
  wire       [7:0]    tmp_when_3;
  wire       [15:0]   tmp_mac_psum_buffer_scale_1;
  wire       [8:0]    tmp_when_4;
  wire       [7:0]    tmp_when_5;
  wire       [7:0]    tmp_when_6;
  wire       [7:0]    tmp_when_7;
  wire       [15:0]   tmp_mac_psum_buffer_scale_2;
  wire       [8:0]    tmp_when_8;
  wire       [7:0]    tmp_when_9;
  wire       [7:0]    tmp_when_10;
  wire       [7:0]    tmp_when_11;
  wire       [15:0]   tmp_mac_psum_buffer_scale_3;
  wire       [8:0]    tmp_when_12;
  wire       [7:0]    tmp_when_13;
  wire       [7:0]    tmp_when_14;
  wire       [7:0]    tmp_when_15;
  wire       [7:0]    tmp_coef_addr;
  wire       [3:0]    tmp_coef_addr_1;
  wire       [7:0]    tmp_coef_addr_2;
  wire       [7:0]    tmp_coef_addr_3;
  wire       [3:0]    tmp_coef_addr_4;
  wire       [7:0]    tmp_cache_addr;
  wire       [7:0]    tmp_cache_addr_1;
  wire       [3:0]    tmp_cache_addr_2;
  wire       [7:0]    tmp_cache_addr_3;
  wire       [7:0]    tmp_cache_addr_4;
  wire       [7:0]    tmp_cache_addr_5;
  wire       [3:0]    tmp_cache_addr_6;
  wire       [4:0]    tmp_cache_addr_7;
  wire       [4:0]    tmp_cache_addr_8;
  wire       [4:0]    tmp_cache_addr_9;
  wire       [3:0]    tmp_cache_addr_10;
  wire       [4:0]    tmp_cache_addr_11;
  wire       [4:0]    tmp_cache_addr_12;
  wire       [3:0]    tmp_cache_addr_13;
  reg        [15:0]   tmp_psum_in;
  reg        [1:0]    curr_state;
  reg        [1:0]    next_state;
  reg        [1:0]    inCnt;
  reg        [1:0]    outCnt;
  reg        [2:0]    outLoopCnt;
  wire                outCnt_ov_flag;
  wire                inCnt_ov_flag;
  wire                outLoopCnt_ov_flag;
  reg                 incnt_inc_flag_notrue;
  wire                incnt_inc_flag_true;
  reg                 read_mac_input_flag;
  reg                 mac_input_valid_flag;
  reg                 mac_input_valid_flag_regNext;
  wire                mac_pipe_last2_valid_fall;
  reg                 write_psum_pulse1;
  reg                 write_psum_pulse2;
  reg        [15:0]   mac_psum_buffer_0;
  reg        [15:0]   mac_psum_buffer_1;
  reg        [15:0]   mac_psum_buffer_2;
  reg        [15:0]   mac_psum_buffer_3;
  reg        [15:0]   mac_psum_buffer_scale_0;
  reg        [15:0]   mac_psum_buffer_scale_1;
  reg        [15:0]   mac_psum_buffer_scale_2;
  reg        [15:0]   mac_psum_buffer_scale_3;
  reg        [7:0]    mac_psum_buffer_cut_0;
  reg        [7:0]    mac_psum_buffer_cut_1;
  reg        [7:0]    mac_psum_buffer_cut_2;
  reg        [7:0]    mac_psum_buffer_cut_3;
  reg        [7:0]    mac_psum_out_8b_0;
  reg        [7:0]    mac_psum_out_8b_1;
  reg        [7:0]    mac_psum_out_8b_2;
  reg        [7:0]    mac_psum_out_8b_3;
  wire       [15:0]   mac_psum_out_16b_0_0;
  wire       [15:0]   mac_psum_out_16b_0_1;
  wire       [15:0]   mac_psum_out_16b_1_0;
  wire       [15:0]   mac_psum_out_16b_1_1;
  reg        [7:0]    tmp_mac_psum_buffer_cut_0;
  reg        [7:0]    tmp_mac_psum_buffer_cut_1;
  reg        [7:0]    tmp_mac_psum_buffer_cut_2;
  reg        [7:0]    tmp_mac_psum_buffer_cut_3;
  wire       [31:0]   mac_psum_gather_8b;
  wire       [31:0]   mac_psum_gather_16b_0;
  wire       [31:0]   mac_psum_gather_16b_1;
  reg        [7:0]    mac_ifmap_in_0;
  reg        [7:0]    mac_ifmap_in_1;
  reg        [7:0]    mac_ifmap_in_2;
  reg        [7:0]    mac_ifmap_in_3;
  reg        [7:0]    mac_weight_in_0;
  reg        [7:0]    mac_weight_in_1;
  reg        [7:0]    mac_weight_in_2;
  reg        [7:0]    mac_weight_in_3;
  wire                state_is_idle;
  wire                state_is_load_psum1;
  wire                statein_load_psum1;
  wire                state_is_load_psum2;
  wire                statein_load_psum2;
  reg                 psum1_read_out_flag;
  reg                 psum2_read_out_flag;
  reg        [7:0]    weight_read_addr;
  reg                 incnt_inc_flag_true_regNext;
  wire                read_mac_input_end;
  reg                 inCnt_ov_flag_delay_1;
  reg                 inCnt_ov_flag_delay_2;
  reg                 switch_psum_pulse;
  reg        [1:0]    switch_psum_index;
  wire                switch_psum_index_ov;
  wire       [3:0]    tmp_1;
  `ifndef SYNTHESIS
  reg [79:0] curr_state_string;
  reg [79:0] next_state_string;
  `endif


  assign tmp_outLoopCnt_ov_flag = ({1'b0,ofmap_loop_num} + tmp_outLoopCnt_ov_flag_1);
  assign tmp_outLoopCnt_ov_flag_2 = {1'b0,1'b1};
  assign tmp_outLoopCnt_ov_flag_1 = {1'd0, tmp_outLoopCnt_ov_flag_2};
  assign tmp_mac_psum_buffer_scale_0 = mac_psum_buffer_0;
  assign tmp_when = mac_psum_buffer_scale_0[15 : 7];
  assign tmp_when_1 = mac_psum_buffer_scale_0[14 : 7];
  assign tmp_when_2 = 8'h0;
  assign tmp_when_3 = mac_psum_buffer_cut_0;
  assign tmp_mac_psum_buffer_scale_1 = mac_psum_buffer_1;
  assign tmp_when_4 = mac_psum_buffer_scale_1[15 : 7];
  assign tmp_when_5 = mac_psum_buffer_scale_1[14 : 7];
  assign tmp_when_6 = 8'h0;
  assign tmp_when_7 = mac_psum_buffer_cut_1;
  assign tmp_mac_psum_buffer_scale_2 = mac_psum_buffer_2;
  assign tmp_when_8 = mac_psum_buffer_scale_2[15 : 7];
  assign tmp_when_9 = mac_psum_buffer_scale_2[14 : 7];
  assign tmp_when_10 = 8'h0;
  assign tmp_when_11 = mac_psum_buffer_cut_2;
  assign tmp_mac_psum_buffer_scale_3 = mac_psum_buffer_3;
  assign tmp_when_12 = mac_psum_buffer_scale_3[15 : 7];
  assign tmp_when_13 = mac_psum_buffer_scale_3[14 : 7];
  assign tmp_when_14 = 8'h0;
  assign tmp_when_15 = mac_psum_buffer_cut_3;
  assign tmp_coef_addr_1 = ({1'd0,outLoopCnt} <<< 1);
  assign tmp_coef_addr = {4'd0, tmp_coef_addr_1};
  assign tmp_coef_addr_2 = (psum_base_addr + tmp_coef_addr_3);
  assign tmp_coef_addr_4 = ({1'd0,outLoopCnt} <<< 1);
  assign tmp_coef_addr_3 = {4'd0, tmp_coef_addr_4};
  assign tmp_cache_addr = (psum_base_addr + tmp_cache_addr_1);
  assign tmp_cache_addr_2 = ({1'd0,outLoopCnt} <<< 1);
  assign tmp_cache_addr_1 = {4'd0, tmp_cache_addr_2};
  assign tmp_cache_addr_3 = (tmp_cache_addr_4 + 8'h01);
  assign tmp_cache_addr_4 = (psum_base_addr + tmp_cache_addr_5);
  assign tmp_cache_addr_6 = ({1'd0,outLoopCnt} <<< 1);
  assign tmp_cache_addr_5 = {4'd0, tmp_cache_addr_6};
  assign tmp_cache_addr_7 = {3'd0, inCnt};
  assign tmp_cache_addr_8 = {2'd0, outLoopCnt};
  assign tmp_cache_addr_10 = ({1'd0,outLoopCnt} <<< 1);
  assign tmp_cache_addr_9 = {1'd0, tmp_cache_addr_10};
  assign tmp_cache_addr_11 = (ofmap_base_addr + tmp_cache_addr_12);
  assign tmp_cache_addr_13 = ({1'd0,outLoopCnt} <<< 1);
  assign tmp_cache_addr_12 = {1'd0, tmp_cache_addr_13};
  mac_unit mac (
    .valid          (mac_input_valid_flag), //i
    .A_0            (mac_weight_in_0[7:0]), //i
    .A_1            (mac_weight_in_1[7:0]), //i
    .A_2            (mac_weight_in_2[7:0]), //i
    .A_3            (mac_weight_in_3[7:0]), //i
    .B_0            (mac_ifmap_in_0[7:0] ), //i
    .B_1            (mac_ifmap_in_1[7:0] ), //i
    .B_2            (mac_ifmap_in_2[7:0] ), //i
    .B_3            (mac_ifmap_in_3[7:0] ), //i
    .psum_in        (mac_psum_in[15:0]   ), //i
    .psum_out       (mac_psum_out[15:0]  ), //o
    .psum_acc_valid (mac_psum_acc_valid  ), //o
    .clk            (clk                 ), //i
    .resetn         (resetn              )  //i
  );
  always @(*) begin
    case(switch_psum_index)
      2'b00 : tmp_psum_in = mac_psum_buffer_0;
      2'b01 : tmp_psum_in = mac_psum_buffer_1;
      2'b10 : tmp_psum_in = mac_psum_buffer_2;
      default : tmp_psum_in = mac_psum_buffer_3;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE      ";
      LOAD_PSUM1 : curr_state_string = "LOAD_PSUM1";
      LOAD_PSUM2 : curr_state_string = "LOAD_PSUM2";
      MAC : curr_state_string = "MAC       ";
      default : curr_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE      ";
      LOAD_PSUM1 : next_state_string = "LOAD_PSUM1";
      LOAD_PSUM2 : next_state_string = "LOAD_PSUM2";
      MAC : next_state_string = "MAC       ";
      default : next_state_string = "??????????";
    endcase
  end
  `endif

  assign outCnt_ov_flag = (outCnt == 2'b11);
  assign inCnt_ov_flag = (inCnt == ifmap_loop_num);
  assign outLoopCnt_ov_flag = (outLoopCnt == tmp_outLoopCnt_ov_flag);
  assign mac_pipe_last2_valid_fall = ((! mac_input_valid_flag) && mac_input_valid_flag_regNext);
  assign mac_psum_out_16b_0_0 = mac_psum_buffer_0;
  assign mac_psum_out_16b_1_0 = mac_psum_buffer_2;
  assign mac_psum_out_16b_0_1 = mac_psum_buffer_1;
  assign mac_psum_out_16b_1_1 = mac_psum_buffer_3;
  always @(*) begin
    mac_psum_buffer_scale_0 = 16'h0;
    if(need_scale) begin
      mac_psum_buffer_scale_0 = ($signed(tmp_mac_psum_buffer_scale_0) >>> rg_rnn_data_ratio);
    end
  end

  always @(*) begin
    mac_psum_buffer_cut_0 = 8'h0;
    if(need_scale) begin
      mac_psum_buffer_cut_0 = tmp_mac_psum_buffer_cut_0;
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_0[15]) begin
      if((! (&tmp_when))) begin
        tmp_mac_psum_buffer_cut_0 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_cut_0 = mac_psum_buffer_scale_0[7 : 0];
      end
    end else begin
      if((|tmp_when_1)) begin
        tmp_mac_psum_buffer_cut_0 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_cut_0 = mac_psum_buffer_scale_0[7 : 0];
      end
    end
  end

  always @(*) begin
    if(need_relu) begin
      if(($signed(tmp_when_2) < $signed(tmp_when_3))) begin
        mac_psum_out_8b_0 = mac_psum_buffer_cut_0;
      end else begin
        mac_psum_out_8b_0 = 8'h0;
      end
    end else begin
      mac_psum_out_8b_0 = mac_psum_buffer_cut_0;
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_1 = 16'h0;
    if(need_scale) begin
      mac_psum_buffer_scale_1 = ($signed(tmp_mac_psum_buffer_scale_1) >>> rg_rnn_data_ratio);
    end
  end

  always @(*) begin
    mac_psum_buffer_cut_1 = 8'h0;
    if(need_scale) begin
      mac_psum_buffer_cut_1 = tmp_mac_psum_buffer_cut_1;
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_1[15]) begin
      if((! (&tmp_when_4))) begin
        tmp_mac_psum_buffer_cut_1 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_cut_1 = mac_psum_buffer_scale_1[7 : 0];
      end
    end else begin
      if((|tmp_when_5)) begin
        tmp_mac_psum_buffer_cut_1 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_cut_1 = mac_psum_buffer_scale_1[7 : 0];
      end
    end
  end

  always @(*) begin
    if(need_relu) begin
      if(($signed(tmp_when_6) < $signed(tmp_when_7))) begin
        mac_psum_out_8b_1 = mac_psum_buffer_cut_1;
      end else begin
        mac_psum_out_8b_1 = 8'h0;
      end
    end else begin
      mac_psum_out_8b_1 = mac_psum_buffer_cut_1;
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_2 = 16'h0;
    if(need_scale) begin
      mac_psum_buffer_scale_2 = ($signed(tmp_mac_psum_buffer_scale_2) >>> rg_rnn_data_ratio);
    end
  end

  always @(*) begin
    mac_psum_buffer_cut_2 = 8'h0;
    if(need_scale) begin
      mac_psum_buffer_cut_2 = tmp_mac_psum_buffer_cut_2;
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_2[15]) begin
      if((! (&tmp_when_8))) begin
        tmp_mac_psum_buffer_cut_2 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_cut_2 = mac_psum_buffer_scale_2[7 : 0];
      end
    end else begin
      if((|tmp_when_9)) begin
        tmp_mac_psum_buffer_cut_2 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_cut_2 = mac_psum_buffer_scale_2[7 : 0];
      end
    end
  end

  always @(*) begin
    if(need_relu) begin
      if(($signed(tmp_when_10) < $signed(tmp_when_11))) begin
        mac_psum_out_8b_2 = mac_psum_buffer_cut_2;
      end else begin
        mac_psum_out_8b_2 = 8'h0;
      end
    end else begin
      mac_psum_out_8b_2 = mac_psum_buffer_cut_2;
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_3 = 16'h0;
    if(need_scale) begin
      mac_psum_buffer_scale_3 = ($signed(tmp_mac_psum_buffer_scale_3) >>> rg_rnn_data_ratio);
    end
  end

  always @(*) begin
    mac_psum_buffer_cut_3 = 8'h0;
    if(need_scale) begin
      mac_psum_buffer_cut_3 = tmp_mac_psum_buffer_cut_3;
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_3[15]) begin
      if((! (&tmp_when_12))) begin
        tmp_mac_psum_buffer_cut_3 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_cut_3 = mac_psum_buffer_scale_3[7 : 0];
      end
    end else begin
      if((|tmp_when_13)) begin
        tmp_mac_psum_buffer_cut_3 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_cut_3 = mac_psum_buffer_scale_3[7 : 0];
      end
    end
  end

  always @(*) begin
    if(need_relu) begin
      if(($signed(tmp_when_14) < $signed(tmp_when_15))) begin
        mac_psum_out_8b_3 = mac_psum_buffer_cut_3;
      end else begin
        mac_psum_out_8b_3 = 8'h0;
      end
    end else begin
      mac_psum_out_8b_3 = mac_psum_buffer_cut_3;
    end
  end

  assign mac_psum_gather_8b = {{{mac_psum_out_8b_3,mac_psum_out_8b_2},mac_psum_out_8b_1},mac_psum_out_8b_0};
  assign mac_psum_gather_16b_0 = {mac_psum_out_16b_0_1,mac_psum_out_16b_0_0};
  assign mac_psum_gather_16b_1 = {mac_psum_out_16b_1_1,mac_psum_out_16b_1_0};
  assign state_is_idle = (curr_state == IDLE);
  assign state_is_load_psum1 = (curr_state == LOAD_PSUM1);
  assign statein_load_psum1 = ((curr_state != LOAD_PSUM1) && (next_state == LOAD_PSUM1));
  assign state_is_load_psum2 = (curr_state == LOAD_PSUM2);
  assign statein_load_psum2 = ((curr_state != LOAD_PSUM2) && (next_state == LOAD_PSUM2));
  assign done = ((curr_state == MAC) && (next_state == IDLE));
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      IDLE : begin
        if(start_once) begin
          next_state = LOAD_PSUM1;
        end
      end
      LOAD_PSUM1 : begin
        next_state = LOAD_PSUM2;
      end
      LOAD_PSUM2 : begin
        next_state = MAC;
      end
      default : begin
        if((write_psum_pulse2 && (! outLoopCnt_ov_flag))) begin
          next_state = LOAD_PSUM1;
        end else begin
          if((write_psum_pulse2 && outLoopCnt_ov_flag)) begin
            next_state = IDLE;
          end
        end
      end
    endcase
  end

  assign incnt_inc_flag_true = incnt_inc_flag_notrue;
  assign read_mac_input_end = ((! incnt_inc_flag_true) && incnt_inc_flag_true_regNext);
  always @(*) begin
    mac_weight_in_0 = 8'h0;
    if(mac_input_valid_flag) begin
      mac_weight_in_0 = coef_rdata[7 : 0];
    end
  end

  always @(*) begin
    mac_ifmap_in_0 = 8'h0;
    if(mac_input_valid_flag) begin
      mac_ifmap_in_0 = cache_rdata[7 : 0];
    end
  end

  always @(*) begin
    mac_weight_in_1 = 8'h0;
    if(mac_input_valid_flag) begin
      mac_weight_in_1 = coef_rdata[15 : 8];
    end
  end

  always @(*) begin
    mac_ifmap_in_1 = 8'h0;
    if(mac_input_valid_flag) begin
      mac_ifmap_in_1 = cache_rdata[15 : 8];
    end
  end

  always @(*) begin
    mac_weight_in_2 = 8'h0;
    if(mac_input_valid_flag) begin
      mac_weight_in_2 = coef_rdata[23 : 16];
    end
  end

  always @(*) begin
    mac_ifmap_in_2 = 8'h0;
    if(mac_input_valid_flag) begin
      mac_ifmap_in_2 = cache_rdata[23 : 16];
    end
  end

  always @(*) begin
    mac_weight_in_3 = 8'h0;
    if(mac_input_valid_flag) begin
      mac_weight_in_3 = coef_rdata[31 : 24];
    end
  end

  always @(*) begin
    mac_ifmap_in_3 = 8'h0;
    if(mac_input_valid_flag) begin
      mac_ifmap_in_3 = cache_rdata[31 : 24];
    end
  end

  assign switch_psum_index_ov = (switch_psum_index == ifmap_loop_num);
  assign tmp_1 = ({3'd0,1'b1} <<< switch_psum_index);
  assign mac_psum_in = tmp_psum_in;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      curr_state <= IDLE;
      inCnt <= 2'b00;
      outCnt <= 2'b00;
      outLoopCnt <= 3'b000;
      incnt_inc_flag_notrue <= 1'b0;
      read_mac_input_flag <= 1'b0;
      mac_input_valid_flag <= 1'b0;
      mac_input_valid_flag_regNext <= 1'b0;
      write_psum_pulse1 <= 1'b0;
      write_psum_pulse2 <= 1'b0;
      mac_psum_buffer_0 <= 16'h0;
      mac_psum_buffer_1 <= 16'h0;
      mac_psum_buffer_2 <= 16'h0;
      mac_psum_buffer_3 <= 16'h0;
      psum1_read_out_flag <= 1'b0;
      psum2_read_out_flag <= 1'b0;
      coef_addr <= 8'h0;
      coef_wena <= 1'b0;
      coef_ena <= 1'b0;
      coef_wdata <= 32'h0;
      cache_addr <= 5'h0;
      cache_wena <= 1'b0;
      cache_ena <= 1'b0;
      cache_wdata <= 32'h0;
      weight_read_addr <= 8'h0;
      incnt_inc_flag_true_regNext <= 1'b0;
      inCnt_ov_flag_delay_1 <= 1'b0;
      inCnt_ov_flag_delay_2 <= 1'b0;
      switch_psum_pulse <= 1'b0;
      switch_psum_index <= 2'b00;
    end else begin
      curr_state <= next_state;
      read_mac_input_flag <= incnt_inc_flag_true;
      mac_input_valid_flag <= read_mac_input_flag;
      mac_input_valid_flag_regNext <= mac_input_valid_flag;
      write_psum_pulse1 <= mac_pipe_last2_valid_fall;
      write_psum_pulse2 <= write_psum_pulse1;
      psum1_read_out_flag <= state_is_load_psum1;
      psum2_read_out_flag <= state_is_load_psum2;
      if(state_is_idle) begin
        inCnt <= 2'b00;
        outCnt <= 2'b00;
      end
      if(statein_load_psum2) begin
        incnt_inc_flag_notrue <= 1'b1;
      end else begin
        if((inCnt_ov_flag && outCnt_ov_flag)) begin
          incnt_inc_flag_notrue <= 1'b0;
        end
      end
      if(incnt_inc_flag_true) begin
        if(inCnt_ov_flag) begin
          inCnt <= 2'b00;
          if(outCnt_ov_flag) begin
            outCnt <= 2'b00;
          end else begin
            outCnt <= (outCnt + 2'b01);
          end
        end else begin
          inCnt <= (inCnt + 2'b01);
        end
      end
      if(write_psum_pulse1) begin
        if((outLoopCnt_ov_flag || done)) begin
          outLoopCnt <= 3'b000;
        end else begin
          outLoopCnt <= (outLoopCnt + 3'b001);
        end
      end
      incnt_inc_flag_true_regNext <= incnt_inc_flag_true;
      if(start_once) begin
        weight_read_addr <= weight_base_addr;
      end else begin
        if(incnt_inc_flag_true) begin
          weight_read_addr <= (weight_read_addr + 8'h01);
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
          if(incnt_inc_flag_true) begin
            coef_ena <= 1'b1;
            coef_wena <= 1'b0;
            coef_addr <= weight_read_addr;
          end else begin
            if(read_mac_input_end) begin
              coef_ena <= 1'b0;
              coef_wena <= 1'b0;
              coef_addr <= 8'h0;
              coef_wdata <= 32'h0;
            end
          end
        end
      end
      if((statein_load_psum1 && (! psum_come_from_coef))) begin
        cache_ena <= 1'b1;
        cache_wena <= 1'b0;
        cache_addr <= tmp_cache_addr[4:0];
      end else begin
        if((statein_load_psum2 && (! psum_come_from_coef))) begin
          cache_ena <= 1'b1;
          cache_wena <= 1'b0;
          cache_addr <= tmp_cache_addr_3[4:0];
        end else begin
          if(incnt_inc_flag_true) begin
            cache_ena <= 1'b1;
            cache_wena <= 1'b0;
            cache_addr <= (ifmap_base_addr + tmp_cache_addr_7);
          end else begin
            if((mac_pipe_last2_valid_fall && need_scale)) begin
              cache_ena <= 1'b1;
              cache_wena <= 1'b1;
              cache_addr <= (ofmap_base_addr + tmp_cache_addr_8);
              cache_wdata <= mac_psum_gather_8b;
            end else begin
              if((mac_pipe_last2_valid_fall && (! need_scale))) begin
                cache_ena <= 1'b1;
                cache_wena <= 1'b1;
                cache_addr <= (ofmap_base_addr + tmp_cache_addr_9);
                cache_wdata <= mac_psum_gather_16b_0;
              end else begin
                if((write_psum_pulse1 && (! need_scale))) begin
                  cache_ena <= 1'b1;
                  cache_wena <= 1'b1;
                  cache_addr <= (tmp_cache_addr_11 + 5'h01);
                  cache_wdata <= mac_psum_gather_16b_1;
                end else begin
                  if((write_psum_pulse2 || read_mac_input_end)) begin
                    cache_ena <= 1'b0;
                    cache_wena <= 1'b0;
                    cache_addr <= 5'h0;
                    cache_wdata <= 32'h0;
                  end
                end
              end
            end
          end
        end
      end
      inCnt_ov_flag_delay_1 <= inCnt_ov_flag;
      inCnt_ov_flag_delay_2 <= inCnt_ov_flag_delay_1;
      switch_psum_pulse <= inCnt_ov_flag_delay_2;
      if(switch_psum_pulse) begin
        if(switch_psum_index_ov) begin
          switch_psum_index <= 2'b00;
        end else begin
          switch_psum_index <= (switch_psum_index + 2'b01);
        end
      end
      if((psum2_read_out_flag && psum_come_from_coef)) begin
        mac_psum_buffer_2 <= coef_rdata[15 : 0];
        mac_psum_buffer_3 <= coef_rdata[31 : 16];
      end else begin
        if((psum1_read_out_flag && psum_come_from_coef)) begin
          mac_psum_buffer_0 <= coef_rdata[15 : 0];
          mac_psum_buffer_1 <= coef_rdata[31 : 16];
        end else begin
          if((psum2_read_out_flag && (! psum_come_from_coef))) begin
            mac_psum_buffer_2 <= cache_rdata[15 : 0];
            mac_psum_buffer_3 <= cache_rdata[31 : 16];
          end else begin
            if((psum1_read_out_flag && (! psum_come_from_coef))) begin
              mac_psum_buffer_0 <= cache_rdata[15 : 0];
              mac_psum_buffer_1 <= cache_rdata[31 : 16];
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
              end
            end
          end
        end
      end
    end
  end


endmodule

module mac_unit (
  input               valid,
  input      [7:0]    A_0,
  input      [7:0]    A_1,
  input      [7:0]    A_2,
  input      [7:0]    A_3,
  input      [7:0]    B_0,
  input      [7:0]    B_1,
  input      [7:0]    B_2,
  input      [7:0]    B_3,
  input      [15:0]   psum_in,
  output     [15:0]   psum_out,
  output              psum_acc_valid,
  input               clk,
  input               resetn
);

  wire       [7:0]    tmp_product_0;
  wire       [7:0]    tmp_product_0_1;
  wire       [7:0]    tmp_product_1;
  wire       [7:0]    tmp_product_1_1;
  wire       [7:0]    tmp_product_2;
  wire       [7:0]    tmp_product_2_1;
  wire       [7:0]    tmp_product_3;
  wire       [7:0]    tmp_product_3_1;
  wire       [15:0]   tmp_sum;
  wire       [15:0]   tmp_sum_1;
  wire       [15:0]   tmp_psum_out;
  wire       [15:0]   tmp_psum_out_1;
  reg        [15:0]   product_0;
  reg        [15:0]   product_1;
  reg        [15:0]   product_2;
  reg        [15:0]   product_3;
  reg        [15:0]   sum;
  reg                 stage1_valid;

  assign tmp_product_0 = A_0;
  assign tmp_product_0_1 = B_0;
  assign tmp_product_1 = A_1;
  assign tmp_product_1_1 = B_1;
  assign tmp_product_2 = A_2;
  assign tmp_product_2_1 = B_2;
  assign tmp_product_3 = A_3;
  assign tmp_product_3_1 = B_3;
  assign tmp_sum = ($signed(product_0) + $signed(product_1));
  assign tmp_sum_1 = ($signed(product_2) + $signed(product_3));
  assign tmp_psum_out = ($signed(sum) + $signed(tmp_psum_out_1));
  assign tmp_psum_out_1 = psum_in;
  always @(*) begin
    product_0 = 16'h0;
    if(valid) begin
      product_0 = ($signed(tmp_product_0) * $signed(tmp_product_0_1));
    end
  end

  always @(*) begin
    product_1 = 16'h0;
    if(valid) begin
      product_1 = ($signed(tmp_product_1) * $signed(tmp_product_1_1));
    end
  end

  always @(*) begin
    product_2 = 16'h0;
    if(valid) begin
      product_2 = ($signed(tmp_product_2) * $signed(tmp_product_2_1));
    end
  end

  always @(*) begin
    product_3 = 16'h0;
    if(valid) begin
      product_3 = ($signed(tmp_product_3) * $signed(tmp_product_3_1));
    end
  end

  assign psum_out = tmp_psum_out;
  assign psum_acc_valid = stage1_valid;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      sum <= 16'h0;
      stage1_valid <= 1'b0;
    end else begin
      if(valid) begin
        sum <= ($signed(tmp_sum) + $signed(tmp_sum_1));
      end
      stage1_valid <= valid;
    end
  end


endmodule

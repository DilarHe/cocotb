// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : NN_layer

`timescale 1ns/1ps 
module NN_layer (
  input  wire [2:0]    rg_NN_data_ratio,
  input  wire [0:0]    rg_NN_layer_num,
  input  wire [6:0]    rg_NN_input_base_addr,
  input  wire [6:0]    rg_NN_cache_ofmap_base_addr,
  input  wire [2:0]    rg_NN_ifmap_groupnum,
  input  wire [2:0]    rg_NN_hidden_groupnum_layer_0,
  input  wire [2:0]    rg_NN_hidden_groupnum_layer_1,
  input  wire [9:0]    rg_NN_bias_addr_layer_0,
  input  wire [9:0]    rg_NN_bias_addr_layer_1,
  input  wire [9:0]    rg_NN_whi_addr_layer_0,
  input  wire [9:0]    rg_NN_whi_addr_layer_1,
  input  wire [9:0]    rg_NN_whh_addr_layer_0,
  input  wire [9:0]    rg_NN_whh_addr_layer_1,
  input  wire [9:0]    rg_NN_fc_bias_addr,
  input  wire [9:0]    rg_NN_fc_weight_addr,
  input  wire [9:0]    rg_NN_gate_w_bias_addr,
  input  wire [9:0]    rg_NN_gate_w_weight_addr,
  input  wire [9:0]    rg_NN_fcn1_bias_addr,
  input  wire [9:0]    rg_NN_fcn1_weight_addr,
  input  wire [9:0]    rg_NN_fcn2_bias_addr,
  input  wire [9:0]    rg_NN_fcn2_weight_addr,
  input  wire          start_once,
  input  wire          is_first_seq,
  output wire          coef_ena,
  output wire          coef_wena,
  output wire [9:0]    coef_addr,
  output wire [63:0]   coef_wdata,
  input  wire [63:0]   coef_rdata,
  output wire          cache_ena,
  output wire          cache_wena,
  output wire [6:0]    cache_addr,
  output wire [63:0]   cache_wdata,
  input  wire [63:0]   cache_rdata,
  output wire          matmul_done_once,
  output wire          UpDown_label_result_vld,
  output reg  [7:0]    UpDown_label_result_0,
  output reg  [7:0]    UpDown_label_result_1,
  output reg  [7:0]    UpDown_label_result_2,
  output wire          Heavy_label_result_vld,
  output reg  [15:0]   Heavy_label_result_0,
  output reg  [15:0]   Heavy_label_result_1,
  output reg  [15:0]   Heavy_label_result_2,
  output wire          done,
  input  wire          clkout,
  input  wire          resetn
);
  localparam NN_STATE_IDLE = 4'd0;
  localparam NN_STATE_INPUT_LAYER = 4'd1;
  localparam NN_STATE_HIDDEN_LAYER = 4'd2;
  localparam NN_STATE_FC_W = 4'd3;
  localparam NN_STATE_GATE_W = 4'd4;
  localparam NN_STATE_SCALA_MULT1 = 4'd5;
  localparam NN_STATE_FCN_1 = 4'd6;
  localparam NN_STATE_FCN_2 = 4'd7;
  localparam NN_STATE_SCALA_MULT2 = 4'd8;
  localparam LAYER_STATE_IDLE = 3'd0;
  localparam LAYER_STATE_MATMUL_H = 3'd1;
  localparam LAYER_STATE_MATMUL_I = 3'd2;
  localparam LAYER_STATE_WAIT_FC_SWITCH = 3'd3;
  localparam LAYER_STATE_MATMUL_OUT = 3'd4;
  localparam LAYER_STATE_SCALA_MUL = 3'd5;

  wire                matmul_unit_need_relu;
  wire                matmul_unit_need_scale;
  wire                matmul_unit_is_fc_layer;
  reg                 matmul_unit_is_scala_mult;
  reg        [2:0]    matmul_unit_input_loop_num;
  reg        [2:0]    matmul_unit_output_loop_num;
  reg        [6:0]    matmul_unit_curr_layer_result_line_num;
  reg                 matmul_unit_psum_come_from_coef;
  reg        [9:0]    matmul_unit_psum_base_addr;
  reg        [9:0]    matmul_unit_weight_base_addr;
  reg        [6:0]    matmul_unit_input_base_addr;
  reg        [6:0]    matmul_unit_output_base_addr;
  wire                matmul_unit_coef_ena;
  wire                matmul_unit_coef_wena;
  wire       [9:0]    matmul_unit_coef_addr;
  wire       [63:0]   matmul_unit_coef_wdata;
  wire                matmul_unit_cache_ena;
  wire                matmul_unit_cache_wena;
  wire       [6:0]    matmul_unit_cache_addr;
  wire       [63:0]   matmul_unit_cache_wdata;
  wire                matmul_unit_done;
  wire                matmul_unit_scala_psum_out_vld;
  wire       [21:0]   matmul_unit_scala_psum_out_0;
  wire       [21:0]   matmul_unit_scala_psum_out_1;
  wire       [21:0]   matmul_unit_scala_psum_out_2;
  reg        [2:0]    tmp_tmp_cur_layer_result_word_num;
  wire       [4:0]    tmp_cur_hidden_layer_word_num;
  wire       [4:0]    tmp_cur_hidden_layer_word_num_1;
  wire       [6:0]    tmp_next_layer_input_ptr;
  wire       [3:0]    tmp_next_layer_input_ptr_1;
  wire       [3:0]    tmp_next_layer_input_ptr_2;
  wire       [1:0]    tmp_next_layer_input_ptr_3;
  wire       [6:0]    tmp_next_layer_input_ptr_4;
  wire       [6:0]    tmp_next_layer_input_ptr_5;
  wire       [3:0]    tmp_next_layer_input_ptr_6;
  wire       [3:0]    tmp_next_layer_input_ptr_7;
  wire       [1:0]    tmp_next_layer_input_ptr_8;
  wire       [6:0]    tmp_next_layer_output_ptr;
  wire       [6:0]    tmp_cur_layer_output_ptr;
  wire       [6:0]    tmp_scala_layer_input_ptr;
  reg        [2:0]    tmp_input_loop_num;
  wire       [0:0]    tmp_input_loop_num_1;
  reg        [9:0]    tmp_tmp_psum_base_addr;
  wire       [6:0]    tmp_psum_base_addr_1;
  wire       [6:0]    tmp_psum_base_addr_2;
  reg        [9:0]    tmp_weight_base_addr;
  reg        [9:0]    tmp_weight_base_addr_1;
  reg        [2:0]    tmp_input_loop_num_2;
  wire       [0:0]    tmp_input_loop_num_3;
  reg        [2:0]    tmp_input_loop_num_4;
  wire       [0:0]    tmp_input_loop_num_5;
  reg        [2:0]    tmp_input_loop_num_6;
  wire       [0:0]    tmp_input_loop_num_7;
  wire       [21:0]   tmp_Heavy_label_result_0;
  wire       [21:0]   tmp_Heavy_label_result_1;
  wire       [21:0]   tmp_Heavy_label_result_2;
  reg                 matmul_start_once;
  reg        [3:0]    NN_cur_state;
  reg        [3:0]    NN_nxt_state;
  reg        [2:0]    LY_cur_state;
  reg        [2:0]    LY_nxt_state;
  wire                LY_in_matmulI;
  wire                LY_out_matmulI;
  wire                LY_in_matmulH;
  wire                LY_out_matmulH;
  wire                LY_in_matmulOut;
  wire                LY_is_matmulOut;
  wire                LY_in_scalaMul;
  reg                 LY_all_in_pulse;
  wire                NN_is_FCW;
  wire                NN_is_SCALA_MUL2;
  wire                input_layer_start;
  reg                 input_layer_start_dly;
  wire                input_layer_done;
  wire                NN_is_Hidden;
  wire                hidden_layer_done;
  wire                fc_updown_layer_done;
  wire                gate_w_layer_done;
  wire                scala_mult1_done;
  wire                fc_1_layer_done;
  wire                fc_2_layer_done;
  wire                scala_mult2_done;
  wire                next_state_is_fc;
  wire                next_state_is_scala;
  reg        [0:0]    layerCnt;
  wire                layerCnt_ov_flag;
  wire       [2:0]    tmp_cur_layer_result_word_num;
  wire       [2:0]    cur_layer_result_word_num;
  wire       [4:0]    cur_hidden_layer_word_num;
  reg        [6:0]    cur_layer_input_ptr;
  reg        [6:0]    next_layer_input_ptr;
  reg        [6:0]    cur_layer_output_ptr;
  wire       [6:0]    next_layer_output_ptr;
  reg        [6:0]    scala_layer_input_ptr;
  reg                 scala_mult2_done_regNext;
  reg                 tmp_matmul_start_once;
  wire       [9:0]    tmp_psum_base_addr;
  reg                 fc_updown_layer_done_delay_1;
  reg                 scala_mult2_done_delay_1;
  `ifndef SYNTHESIS
  reg [95:0] NN_cur_state_string;
  reg [95:0] NN_nxt_state_string;
  reg [111:0] LY_cur_state_string;
  reg [111:0] LY_nxt_state_string;
  `endif


  assign tmp_cur_hidden_layer_word_num = ({2'd0,cur_layer_result_word_num} <<< 2'd2);
  assign tmp_cur_hidden_layer_word_num_1 = {2'd0, cur_layer_result_word_num};
  assign tmp_next_layer_input_ptr_1 = ({1'b0,rg_NN_ifmap_groupnum} + tmp_next_layer_input_ptr_2);
  assign tmp_next_layer_input_ptr = {3'd0, tmp_next_layer_input_ptr_1};
  assign tmp_next_layer_input_ptr_3 = {1'b0,1'b1};
  assign tmp_next_layer_input_ptr_2 = {2'd0, tmp_next_layer_input_ptr_3};
  assign tmp_next_layer_input_ptr_4 = {2'd0, cur_hidden_layer_word_num};
  assign tmp_next_layer_input_ptr_6 = ({1'b0,rg_NN_ifmap_groupnum} + tmp_next_layer_input_ptr_7);
  assign tmp_next_layer_input_ptr_5 = {3'd0, tmp_next_layer_input_ptr_6};
  assign tmp_next_layer_input_ptr_8 = {1'b0,1'b1};
  assign tmp_next_layer_input_ptr_7 = {2'd0, tmp_next_layer_input_ptr_8};
  assign tmp_next_layer_output_ptr = {2'd0, cur_hidden_layer_word_num};
  assign tmp_cur_layer_output_ptr = {4'd0, cur_layer_result_word_num};
  assign tmp_scala_layer_input_ptr = {4'd0, cur_layer_result_word_num};
  assign tmp_input_loop_num_1 = (layerCnt - 1'b1);
  assign tmp_psum_base_addr_1 = (((NN_is_Hidden && (7'h2e <= cur_layer_output_ptr)) ? 7'h12 : cur_layer_output_ptr) + tmp_psum_base_addr_2);
  assign tmp_psum_base_addr_2 = {4'd0, cur_layer_result_word_num};
  assign tmp_input_loop_num_3 = (rg_NN_layer_num - 1'b1);
  assign tmp_input_loop_num_5 = (rg_NN_layer_num - 1'b1);
  assign tmp_input_loop_num_7 = (rg_NN_layer_num - 1'b1);
  assign tmp_Heavy_label_result_0 = matmul_unit_scala_psum_out_0;
  assign tmp_Heavy_label_result_1 = matmul_unit_scala_psum_out_1;
  assign tmp_Heavy_label_result_2 = matmul_unit_scala_psum_out_2;
  matmul matmul_unit (
    .start                      (matmul_start_once                          ), //i
    .need_relu                  (matmul_unit_need_relu                      ), //i
    .need_scale                 (matmul_unit_need_scale                     ), //i
    .is_fc_layer                (matmul_unit_is_fc_layer                    ), //i
    .is_scala_mult              (matmul_unit_is_scala_mult                  ), //i
    .is_hidden_layer            (NN_is_Hidden                               ), //i
    .rg_nn_data_ratio           (rg_NN_data_ratio[2:0]                      ), //i
    .input_loop_num             (matmul_unit_input_loop_num[2:0]            ), //i
    .output_loop_num            (matmul_unit_output_loop_num[2:0]           ), //i
    .curr_layer_result_line_num (matmul_unit_curr_layer_result_line_num[6:0]), //i
    .psum_come_from_coef        (matmul_unit_psum_come_from_coef            ), //i
    .psum_base_addr             (matmul_unit_psum_base_addr[9:0]            ), //i
    .weight_base_addr           (matmul_unit_weight_base_addr[9:0]          ), //i
    .input_base_addr            (matmul_unit_input_base_addr[6:0]           ), //i
    .output_base_addr           (matmul_unit_output_base_addr[6:0]          ), //i
    .coef_ena                   (matmul_unit_coef_ena                       ), //o
    .coef_wena                  (matmul_unit_coef_wena                      ), //o
    .coef_addr                  (matmul_unit_coef_addr[9:0]                 ), //o
    .coef_wdata                 (matmul_unit_coef_wdata[63:0]               ), //o
    .coef_rdata                 (coef_rdata[63:0]                           ), //i
    .cache_ena                  (matmul_unit_cache_ena                      ), //o
    .cache_wena                 (matmul_unit_cache_wena                     ), //o
    .cache_addr                 (matmul_unit_cache_addr[6:0]                ), //o
    .cache_wdata                (matmul_unit_cache_wdata[63:0]              ), //o
    .cache_rdata                (cache_rdata[63:0]                          ), //i
    .done                       (matmul_unit_done                           ), //o
    .scala_psum_out_vld         (matmul_unit_scala_psum_out_vld             ), //o
    .scala_psum_out_0           (matmul_unit_scala_psum_out_0[21:0]         ), //o
    .scala_psum_out_1           (matmul_unit_scala_psum_out_1[21:0]         ), //o
    .scala_psum_out_2           (matmul_unit_scala_psum_out_2[21:0]         ), //o
    .clkout                     (clkout                                     ), //i
    .resetn                     (resetn                                     )  //i
  );
  always @(*) begin
    case(layerCnt)
      1'b0 : begin
        tmp_tmp_cur_layer_result_word_num = rg_NN_hidden_groupnum_layer_0;
        tmp_tmp_psum_base_addr = rg_NN_bias_addr_layer_0;
        tmp_weight_base_addr = rg_NN_whi_addr_layer_0;
        tmp_weight_base_addr_1 = rg_NN_whh_addr_layer_0;
      end
      default : begin
        tmp_tmp_cur_layer_result_word_num = rg_NN_hidden_groupnum_layer_1;
        tmp_tmp_psum_base_addr = rg_NN_bias_addr_layer_1;
        tmp_weight_base_addr = rg_NN_whi_addr_layer_1;
        tmp_weight_base_addr_1 = rg_NN_whh_addr_layer_1;
      end
    endcase
  end

  always @(*) begin
    case(tmp_input_loop_num_1)
      1'b0 : tmp_input_loop_num = rg_NN_hidden_groupnum_layer_0;
      default : tmp_input_loop_num = rg_NN_hidden_groupnum_layer_1;
    endcase
  end

  always @(*) begin
    case(tmp_input_loop_num_3)
      1'b0 : tmp_input_loop_num_2 = rg_NN_hidden_groupnum_layer_0;
      default : tmp_input_loop_num_2 = rg_NN_hidden_groupnum_layer_1;
    endcase
  end

  always @(*) begin
    case(tmp_input_loop_num_5)
      1'b0 : tmp_input_loop_num_4 = rg_NN_hidden_groupnum_layer_0;
      default : tmp_input_loop_num_4 = rg_NN_hidden_groupnum_layer_1;
    endcase
  end

  always @(*) begin
    case(tmp_input_loop_num_7)
      1'b0 : tmp_input_loop_num_6 = rg_NN_hidden_groupnum_layer_0;
      default : tmp_input_loop_num_6 = rg_NN_hidden_groupnum_layer_1;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(NN_cur_state)
      NN_STATE_IDLE : NN_cur_state_string = "IDLE        ";
      NN_STATE_INPUT_LAYER : NN_cur_state_string = "INPUT_LAYER ";
      NN_STATE_HIDDEN_LAYER : NN_cur_state_string = "HIDDEN_LAYER";
      NN_STATE_FC_W : NN_cur_state_string = "FC_W        ";
      NN_STATE_GATE_W : NN_cur_state_string = "GATE_W      ";
      NN_STATE_SCALA_MULT1 : NN_cur_state_string = "SCALA_MULT1 ";
      NN_STATE_FCN_1 : NN_cur_state_string = "FCN_1       ";
      NN_STATE_FCN_2 : NN_cur_state_string = "FCN_2       ";
      NN_STATE_SCALA_MULT2 : NN_cur_state_string = "SCALA_MULT2 ";
      default : NN_cur_state_string = "????????????";
    endcase
  end
  always @(*) begin
    case(NN_nxt_state)
      NN_STATE_IDLE : NN_nxt_state_string = "IDLE        ";
      NN_STATE_INPUT_LAYER : NN_nxt_state_string = "INPUT_LAYER ";
      NN_STATE_HIDDEN_LAYER : NN_nxt_state_string = "HIDDEN_LAYER";
      NN_STATE_FC_W : NN_nxt_state_string = "FC_W        ";
      NN_STATE_GATE_W : NN_nxt_state_string = "GATE_W      ";
      NN_STATE_SCALA_MULT1 : NN_nxt_state_string = "SCALA_MULT1 ";
      NN_STATE_FCN_1 : NN_nxt_state_string = "FCN_1       ";
      NN_STATE_FCN_2 : NN_nxt_state_string = "FCN_2       ";
      NN_STATE_SCALA_MULT2 : NN_nxt_state_string = "SCALA_MULT2 ";
      default : NN_nxt_state_string = "????????????";
    endcase
  end
  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_IDLE : LY_cur_state_string = "IDLE          ";
      LAYER_STATE_MATMUL_H : LY_cur_state_string = "MATMUL_H      ";
      LAYER_STATE_MATMUL_I : LY_cur_state_string = "MATMUL_I      ";
      LAYER_STATE_WAIT_FC_SWITCH : LY_cur_state_string = "WAIT_FC_SWITCH";
      LAYER_STATE_MATMUL_OUT : LY_cur_state_string = "MATMUL_OUT    ";
      LAYER_STATE_SCALA_MUL : LY_cur_state_string = "SCALA_MUL     ";
      default : LY_cur_state_string = "??????????????";
    endcase
  end
  always @(*) begin
    case(LY_nxt_state)
      LAYER_STATE_IDLE : LY_nxt_state_string = "IDLE          ";
      LAYER_STATE_MATMUL_H : LY_nxt_state_string = "MATMUL_H      ";
      LAYER_STATE_MATMUL_I : LY_nxt_state_string = "MATMUL_I      ";
      LAYER_STATE_WAIT_FC_SWITCH : LY_nxt_state_string = "WAIT_FC_SWITCH";
      LAYER_STATE_MATMUL_OUT : LY_nxt_state_string = "MATMUL_OUT    ";
      LAYER_STATE_SCALA_MUL : LY_nxt_state_string = "SCALA_MUL     ";
      default : LY_nxt_state_string = "??????????????";
    endcase
  end
  `endif

  assign LY_in_matmulI = ((LY_cur_state != LAYER_STATE_MATMUL_I) && (LY_nxt_state == LAYER_STATE_MATMUL_I));
  assign LY_out_matmulI = ((LY_cur_state == LAYER_STATE_MATMUL_I) && (LY_nxt_state != LAYER_STATE_MATMUL_I));
  assign LY_in_matmulH = ((LY_cur_state != LAYER_STATE_MATMUL_H) && (LY_nxt_state == LAYER_STATE_MATMUL_H));
  assign LY_out_matmulH = ((LY_cur_state == LAYER_STATE_MATMUL_H) && (LY_nxt_state != LAYER_STATE_MATMUL_H));
  assign LY_in_matmulOut = ((LY_cur_state != LAYER_STATE_MATMUL_OUT) && (LY_nxt_state == LAYER_STATE_MATMUL_OUT));
  assign LY_is_matmulOut = (LY_cur_state == LAYER_STATE_MATMUL_OUT);
  assign LY_in_scalaMul = ((LY_cur_state != LAYER_STATE_SCALA_MUL) && (LY_nxt_state == LAYER_STATE_SCALA_MUL));
  assign NN_is_FCW = (NN_cur_state == NN_STATE_FC_W);
  assign NN_is_SCALA_MUL2 = (NN_cur_state == NN_STATE_SCALA_MULT2);
  assign input_layer_start = ((NN_cur_state != NN_STATE_INPUT_LAYER) && (NN_nxt_state == NN_STATE_INPUT_LAYER));
  assign input_layer_done = (LY_out_matmulI && (NN_cur_state == NN_STATE_INPUT_LAYER));
  assign NN_is_Hidden = (NN_cur_state == NN_STATE_HIDDEN_LAYER);
  assign hidden_layer_done = (LY_out_matmulI && (NN_cur_state == NN_STATE_HIDDEN_LAYER));
  assign fc_updown_layer_done = (matmul_unit_done && NN_is_FCW);
  assign gate_w_layer_done = (matmul_unit_done && (NN_cur_state == NN_STATE_GATE_W));
  assign scala_mult1_done = (matmul_unit_done && (NN_cur_state == NN_STATE_SCALA_MULT1));
  assign fc_1_layer_done = (matmul_unit_done && (NN_cur_state == NN_STATE_FCN_1));
  assign fc_2_layer_done = (matmul_unit_done && (NN_cur_state == NN_STATE_FCN_2));
  assign scala_mult2_done = (matmul_unit_done && NN_is_SCALA_MUL2);
  assign next_state_is_fc = (((NN_is_FCW || (NN_cur_state == NN_STATE_GATE_W)) || (NN_cur_state == NN_STATE_FCN_1)) || (NN_cur_state == NN_STATE_FCN_2));
  assign next_state_is_scala = ((NN_cur_state == NN_STATE_SCALA_MULT1) || NN_is_SCALA_MUL2);
  assign layerCnt_ov_flag = (layerCnt == rg_NN_layer_num);
  assign tmp_cur_layer_result_word_num = tmp_tmp_cur_layer_result_word_num;
  assign cur_layer_result_word_num = (tmp_cur_layer_result_word_num + 3'b001);
  assign cur_hidden_layer_word_num = (tmp_cur_hidden_layer_word_num + tmp_cur_hidden_layer_word_num_1);
  assign matmul_done_once = matmul_unit_done;
  assign done = scala_mult2_done_regNext;
  always @(*) begin
    NN_nxt_state = NN_cur_state;
    case(NN_cur_state)
      NN_STATE_IDLE : begin
        if(start_once) begin
          NN_nxt_state = NN_STATE_INPUT_LAYER;
        end
      end
      NN_STATE_INPUT_LAYER : begin
        if(input_layer_done) begin
          NN_nxt_state = NN_STATE_HIDDEN_LAYER;
        end
      end
      NN_STATE_HIDDEN_LAYER : begin
        if(hidden_layer_done) begin
          NN_nxt_state = NN_STATE_FC_W;
        end
      end
      NN_STATE_FC_W : begin
        if(fc_updown_layer_done) begin
          NN_nxt_state = NN_STATE_GATE_W;
        end
      end
      NN_STATE_GATE_W : begin
        if(gate_w_layer_done) begin
          NN_nxt_state = NN_STATE_SCALA_MULT1;
        end
      end
      NN_STATE_SCALA_MULT1 : begin
        if(scala_mult1_done) begin
          NN_nxt_state = NN_STATE_FCN_1;
        end
      end
      NN_STATE_FCN_1 : begin
        if(fc_1_layer_done) begin
          NN_nxt_state = NN_STATE_FCN_2;
        end
      end
      NN_STATE_FCN_2 : begin
        if(fc_2_layer_done) begin
          NN_nxt_state = NN_STATE_SCALA_MULT2;
        end
      end
      default : begin
        if(scala_mult2_done) begin
          NN_nxt_state = NN_STATE_IDLE;
        end
      end
    endcase
  end

  always @(*) begin
    LY_nxt_state = LY_cur_state;
    case(LY_cur_state)
      LAYER_STATE_IDLE : begin
        if(input_layer_start_dly) begin
          LY_nxt_state = LAYER_STATE_MATMUL_H;
        end
      end
      LAYER_STATE_MATMUL_H : begin
        if(is_first_seq) begin
          LY_nxt_state = LAYER_STATE_MATMUL_I;
        end else begin
          if(matmul_done_once) begin
            LY_nxt_state = LAYER_STATE_MATMUL_I;
          end
        end
      end
      LAYER_STATE_MATMUL_I : begin
        if(matmul_done_once) begin
          if(layerCnt_ov_flag) begin
            LY_nxt_state = LAYER_STATE_MATMUL_OUT;
          end else begin
            LY_nxt_state = LAYER_STATE_MATMUL_H;
          end
        end
      end
      LAYER_STATE_MATMUL_OUT : begin
        if(matmul_done_once) begin
          LY_nxt_state = LAYER_STATE_WAIT_FC_SWITCH;
        end
      end
      LAYER_STATE_WAIT_FC_SWITCH : begin
        if(next_state_is_fc) begin
          LY_nxt_state = LAYER_STATE_MATMUL_OUT;
        end else begin
          if(next_state_is_scala) begin
            LY_nxt_state = LAYER_STATE_SCALA_MUL;
          end
        end
      end
      default : begin
        if(matmul_done_once) begin
          if(NN_is_SCALA_MUL2) begin
            LY_nxt_state = LAYER_STATE_IDLE;
          end else begin
            LY_nxt_state = LAYER_STATE_WAIT_FC_SWITCH;
          end
        end
      end
    endcase
  end

  always @(*) begin
    if((NN_cur_state == NN_STATE_INPUT_LAYER)) begin
      next_layer_input_ptr = (cur_layer_input_ptr + tmp_next_layer_input_ptr);
    end else begin
      if((NN_cur_state == NN_STATE_HIDDEN_LAYER)) begin
        next_layer_input_ptr = (cur_layer_input_ptr + tmp_next_layer_input_ptr_4);
      end else begin
        next_layer_input_ptr = (cur_layer_input_ptr + tmp_next_layer_input_ptr_5);
      end
    end
  end

  assign next_layer_output_ptr = (cur_layer_output_ptr + tmp_next_layer_output_ptr);
  assign matmul_unit_need_relu = (LY_cur_state == LAYER_STATE_MATMUL_I);
  assign matmul_unit_need_scale = (((LY_cur_state == LAYER_STATE_MATMUL_I) || (LY_cur_state == LAYER_STATE_MATMUL_OUT)) || (LY_cur_state == LAYER_STATE_SCALA_MUL));
  assign matmul_unit_is_fc_layer = (LY_cur_state == LAYER_STATE_MATMUL_OUT);
  assign cache_ena = matmul_unit_cache_ena;
  assign cache_wena = matmul_unit_cache_wena;
  assign cache_addr = matmul_unit_cache_addr;
  assign cache_wdata = matmul_unit_cache_wdata;
  assign coef_ena = matmul_unit_coef_ena;
  assign coef_wena = matmul_unit_coef_wena;
  assign coef_addr = matmul_unit_coef_addr;
  assign coef_wdata = matmul_unit_coef_wdata;
  always @(*) begin
    if((! is_first_seq)) begin
      matmul_start_once = LY_all_in_pulse;
    end else begin
      matmul_start_once = tmp_matmul_start_once;
    end
  end

  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_MATMUL_I : begin
        if((layerCnt == 1'b0)) begin
          matmul_unit_input_loop_num = rg_NN_ifmap_groupnum;
        end else begin
          matmul_unit_input_loop_num = tmp_input_loop_num;
        end
      end
      LAYER_STATE_MATMUL_H : begin
        matmul_unit_input_loop_num = tmp_cur_layer_result_word_num;
      end
      LAYER_STATE_MATMUL_OUT : begin
        if(NN_is_FCW) begin
          matmul_unit_input_loop_num = tmp_input_loop_num_2;
        end else begin
          if((NN_cur_state == NN_STATE_GATE_W)) begin
            matmul_unit_input_loop_num = tmp_input_loop_num_4;
          end else begin
            if((NN_cur_state == NN_STATE_FCN_1)) begin
              matmul_unit_input_loop_num = tmp_input_loop_num_6;
            end else begin
              if((NN_cur_state == NN_STATE_FCN_2)) begin
                matmul_unit_input_loop_num = 3'b000;
              end else begin
                matmul_unit_input_loop_num = 3'b000;
              end
            end
          end
        end
      end
      LAYER_STATE_SCALA_MUL : begin
        matmul_unit_input_loop_num = 3'b001;
      end
      default : begin
        matmul_unit_input_loop_num = 3'b000;
      end
    endcase
  end

  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_MATMUL_I : begin
        matmul_unit_curr_layer_result_line_num = {4'd0, cur_layer_result_word_num};
      end
      LAYER_STATE_MATMUL_H : begin
        matmul_unit_curr_layer_result_line_num = {4'd0, cur_layer_result_word_num};
      end
      LAYER_STATE_MATMUL_OUT : begin
        if(NN_is_FCW) begin
          matmul_unit_curr_layer_result_line_num = {4'd0, cur_layer_result_word_num};
        end else begin
          if((NN_cur_state == NN_STATE_GATE_W)) begin
            matmul_unit_curr_layer_result_line_num = {4'd0, cur_layer_result_word_num};
          end else begin
            if((NN_cur_state == NN_STATE_FCN_1)) begin
              matmul_unit_curr_layer_result_line_num = {4'd0, cur_layer_result_word_num};
            end else begin
              if((NN_cur_state == NN_STATE_FCN_2)) begin
                matmul_unit_curr_layer_result_line_num = {4'd0, cur_layer_result_word_num};
              end else begin
                matmul_unit_curr_layer_result_line_num = {4'd0, cur_layer_result_word_num};
              end
            end
          end
        end
      end
      LAYER_STATE_SCALA_MUL : begin
        matmul_unit_curr_layer_result_line_num = 7'h0;
      end
      default : begin
        matmul_unit_curr_layer_result_line_num = 7'h0;
      end
    endcase
  end

  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_MATMUL_I : begin
        matmul_unit_output_loop_num = tmp_cur_layer_result_word_num;
      end
      LAYER_STATE_MATMUL_H : begin
        matmul_unit_output_loop_num = tmp_cur_layer_result_word_num;
      end
      LAYER_STATE_MATMUL_OUT : begin
        if(NN_is_FCW) begin
          matmul_unit_output_loop_num = 3'b000;
        end else begin
          if((NN_cur_state == NN_STATE_GATE_W)) begin
            matmul_unit_output_loop_num = 3'b001;
          end else begin
            if((NN_cur_state == NN_STATE_FCN_1)) begin
              matmul_unit_output_loop_num = 3'b000;
            end else begin
              if((NN_cur_state == NN_STATE_FCN_2)) begin
                matmul_unit_output_loop_num = 3'b000;
              end else begin
                matmul_unit_output_loop_num = 3'b000;
              end
            end
          end
        end
      end
      LAYER_STATE_SCALA_MUL : begin
        if((NN_cur_state == NN_STATE_SCALA_MULT1)) begin
          matmul_unit_output_loop_num = 3'b001;
        end else begin
          matmul_unit_output_loop_num = 3'b000;
        end
      end
      default : begin
        matmul_unit_output_loop_num = 3'b000;
      end
    endcase
  end

  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_MATMUL_I : begin
        matmul_unit_input_base_addr = cur_layer_input_ptr;
      end
      LAYER_STATE_MATMUL_H : begin
        matmul_unit_input_base_addr = cur_layer_input_ptr;
      end
      LAYER_STATE_MATMUL_OUT : begin
        matmul_unit_input_base_addr = cur_layer_input_ptr;
      end
      LAYER_STATE_SCALA_MUL : begin
        matmul_unit_input_base_addr = cur_layer_input_ptr;
      end
      default : begin
        matmul_unit_input_base_addr = 7'h0;
      end
    endcase
  end

  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_MATMUL_I : begin
        matmul_unit_output_base_addr = cur_layer_output_ptr;
      end
      LAYER_STATE_MATMUL_H : begin
        matmul_unit_output_base_addr = cur_layer_output_ptr;
      end
      LAYER_STATE_MATMUL_OUT : begin
        matmul_unit_output_base_addr = cur_layer_output_ptr;
      end
      LAYER_STATE_SCALA_MUL : begin
        matmul_unit_output_base_addr = cur_layer_output_ptr;
      end
      default : begin
        matmul_unit_output_base_addr = 7'h0;
      end
    endcase
  end

  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_MATMUL_I : begin
        if(is_first_seq) begin
          matmul_unit_psum_come_from_coef = 1'b1;
        end else begin
          matmul_unit_psum_come_from_coef = 1'b0;
        end
      end
      LAYER_STATE_MATMUL_H : begin
        matmul_unit_psum_come_from_coef = 1'b1;
      end
      LAYER_STATE_MATMUL_OUT : begin
        matmul_unit_psum_come_from_coef = 1'b1;
      end
      LAYER_STATE_SCALA_MUL : begin
        matmul_unit_psum_come_from_coef = 1'b0;
      end
      default : begin
        matmul_unit_psum_come_from_coef = 1'b0;
      end
    endcase
  end

  assign tmp_psum_base_addr = tmp_tmp_psum_base_addr;
  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_MATMUL_I : begin
        if(is_first_seq) begin
          matmul_unit_psum_base_addr = tmp_psum_base_addr;
        end else begin
          matmul_unit_psum_base_addr = {3'd0, tmp_psum_base_addr_1};
        end
      end
      LAYER_STATE_MATMUL_H : begin
        matmul_unit_psum_base_addr = tmp_psum_base_addr;
      end
      LAYER_STATE_MATMUL_OUT : begin
        if(NN_is_FCW) begin
          matmul_unit_psum_base_addr = rg_NN_fc_bias_addr;
        end else begin
          if((NN_cur_state == NN_STATE_GATE_W)) begin
            matmul_unit_psum_base_addr = rg_NN_gate_w_bias_addr;
          end else begin
            if((NN_cur_state == NN_STATE_FCN_1)) begin
              matmul_unit_psum_base_addr = rg_NN_fcn1_bias_addr;
            end else begin
              if((NN_cur_state == NN_STATE_FCN_2)) begin
                matmul_unit_psum_base_addr = rg_NN_fcn2_bias_addr;
              end else begin
                matmul_unit_psum_base_addr = rg_NN_fc_bias_addr;
              end
            end
          end
        end
      end
      LAYER_STATE_SCALA_MUL : begin
        if((NN_cur_state == NN_STATE_SCALA_MULT1)) begin
          matmul_unit_psum_base_addr = {3'd0, scala_layer_input_ptr};
        end else begin
          matmul_unit_psum_base_addr = {3'd0, scala_layer_input_ptr};
        end
      end
      default : begin
        matmul_unit_psum_base_addr = 10'h0;
      end
    endcase
  end

  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_MATMUL_I : begin
        matmul_unit_weight_base_addr = tmp_weight_base_addr;
      end
      LAYER_STATE_MATMUL_H : begin
        matmul_unit_weight_base_addr = tmp_weight_base_addr_1;
      end
      LAYER_STATE_MATMUL_OUT : begin
        if(NN_is_FCW) begin
          matmul_unit_weight_base_addr = rg_NN_fc_weight_addr;
        end else begin
          if((NN_cur_state == NN_STATE_GATE_W)) begin
            matmul_unit_weight_base_addr = rg_NN_gate_w_weight_addr;
          end else begin
            if((NN_cur_state == NN_STATE_FCN_1)) begin
              matmul_unit_weight_base_addr = rg_NN_fcn1_weight_addr;
            end else begin
              if((NN_cur_state == NN_STATE_FCN_2)) begin
                matmul_unit_weight_base_addr = rg_NN_fcn2_weight_addr;
              end else begin
                matmul_unit_weight_base_addr = rg_NN_fc_weight_addr;
              end
            end
          end
        end
      end
      LAYER_STATE_SCALA_MUL : begin
        matmul_unit_weight_base_addr = 10'h0;
      end
      default : begin
        matmul_unit_weight_base_addr = 10'h0;
      end
    endcase
  end

  always @(*) begin
    case(LY_cur_state)
      LAYER_STATE_MATMUL_I : begin
        matmul_unit_is_scala_mult = 1'b0;
      end
      LAYER_STATE_MATMUL_H : begin
        matmul_unit_is_scala_mult = 1'b0;
      end
      LAYER_STATE_MATMUL_OUT : begin
        matmul_unit_is_scala_mult = 1'b0;
      end
      LAYER_STATE_SCALA_MUL : begin
        matmul_unit_is_scala_mult = 1'b1;
      end
      default : begin
        matmul_unit_is_scala_mult = 1'b0;
      end
    endcase
  end

  assign UpDown_label_result_vld = fc_updown_layer_done_delay_1;
  assign Heavy_label_result_vld = scala_mult2_done_delay_1;
  always @(posedge clkout or negedge resetn) begin
    if(!resetn) begin
      UpDown_label_result_0 <= 8'h0;
      UpDown_label_result_1 <= 8'h0;
      UpDown_label_result_2 <= 8'h0;
      Heavy_label_result_0 <= 16'h0;
      Heavy_label_result_1 <= 16'h0;
      Heavy_label_result_2 <= 16'h0;
      NN_cur_state <= NN_STATE_IDLE;
      LY_cur_state <= LAYER_STATE_IDLE;
      LY_all_in_pulse <= 1'b0;
      input_layer_start_dly <= 1'b0;
      layerCnt <= 1'b0;
      cur_layer_input_ptr <= 7'h0;
      cur_layer_output_ptr <= 7'h0;
      scala_layer_input_ptr <= 7'h0;
      scala_mult2_done_regNext <= 1'b0;
      fc_updown_layer_done_delay_1 <= 1'b0;
      scala_mult2_done_delay_1 <= 1'b0;
    end else begin
      LY_all_in_pulse <= (((LY_in_matmulI || LY_in_matmulH) || LY_in_matmulOut) || LY_in_scalaMul);
      input_layer_start_dly <= input_layer_start;
      scala_mult2_done_regNext <= scala_mult2_done;
      NN_cur_state <= NN_nxt_state;
      LY_cur_state <= LY_nxt_state;
      if(LY_out_matmulI) begin
        if(layerCnt_ov_flag) begin
          layerCnt <= 1'b0;
        end else begin
          layerCnt <= (layerCnt + 1'b1);
        end
      end
      if(start_once) begin
        if(is_first_seq) begin
          cur_layer_input_ptr <= rg_NN_input_base_addr;
        end else begin
          cur_layer_input_ptr <= rg_NN_cache_ofmap_base_addr;
        end
      end else begin
        if(LY_out_matmulH) begin
          if((layerCnt == 1'b0)) begin
            cur_layer_input_ptr <= rg_NN_input_base_addr;
          end else begin
            cur_layer_input_ptr <= rg_NN_cache_ofmap_base_addr;
          end
        end else begin
          if(((((hidden_layer_done || gate_w_layer_done) || scala_mult1_done) || fc_1_layer_done) || fc_2_layer_done)) begin
            cur_layer_input_ptr <= cur_layer_output_ptr;
          end else begin
            if(LY_out_matmulI) begin
              if(is_first_seq) begin
                cur_layer_input_ptr <= next_layer_input_ptr;
              end else begin
                cur_layer_input_ptr <= next_layer_output_ptr;
              end
            end
          end
        end
      end
      if(start_once) begin
        cur_layer_output_ptr <= rg_NN_cache_ofmap_base_addr;
      end else begin
        if(hidden_layer_done) begin
          cur_layer_output_ptr <= (rg_NN_cache_ofmap_base_addr + tmp_cur_layer_output_ptr);
        end else begin
          if(fc_updown_layer_done) begin
            cur_layer_output_ptr <= (cur_layer_output_ptr + 7'h01);
          end else begin
            if((gate_w_layer_done || scala_mult1_done)) begin
              cur_layer_output_ptr <= (cur_layer_output_ptr + 7'h02);
            end else begin
              if((fc_1_layer_done || fc_2_layer_done)) begin
                cur_layer_output_ptr <= (cur_layer_output_ptr + 7'h01);
              end else begin
                if(LY_out_matmulI) begin
                  cur_layer_output_ptr <= next_layer_output_ptr;
                end
              end
            end
          end
        end
      end
      if(gate_w_layer_done) begin
        scala_layer_input_ptr <= cur_layer_input_ptr;
      end else begin
        if(fc_2_layer_done) begin
          scala_layer_input_ptr <= (rg_NN_cache_ofmap_base_addr + tmp_scala_layer_input_ptr);
        end
      end
      fc_updown_layer_done_delay_1 <= fc_updown_layer_done;
      if(((NN_is_FCW && cache_wena) && cache_ena)) begin
        UpDown_label_result_0 <= cache_wdata[7 : 0];
        UpDown_label_result_1 <= cache_wdata[15 : 8];
        UpDown_label_result_2 <= cache_wdata[23 : 16];
      end
      scala_mult2_done_delay_1 <= scala_mult2_done;
      if((NN_is_SCALA_MUL2 && matmul_unit_scala_psum_out_vld)) begin
        Heavy_label_result_0 <= tmp_Heavy_label_result_0[15:0];
        Heavy_label_result_1 <= tmp_Heavy_label_result_1[15:0];
        Heavy_label_result_2 <= tmp_Heavy_label_result_2[15:0];
      end
    end
  end

  always @(posedge clkout or negedge resetn) begin
    if(!resetn) begin
      tmp_matmul_start_once <= 1'b0;
    end else begin
      tmp_matmul_start_once <= ((LY_in_matmulI || LY_in_matmulOut) || LY_in_scalaMul);
    end
  end


endmodule

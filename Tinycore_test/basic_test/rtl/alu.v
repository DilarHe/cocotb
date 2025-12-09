// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : alu
// Git hash  : 31ce619fdcbb774cfe2df26d308fe4584454b941

`timescale 1ns/1ps 
module alu (
  input      [4:0]    op_type,
  input               oprand_vld_in,
  input      [127:0]  voperand_in_vs1,
  input      [127:0]  voperand_in_vs2,
  input      [4:0]    voperand_in_vs1_index,
  input      [4:0]    voperand_in_vs2_index,
  input      [31:0]   roperand_in_rs1,
  input      [4:0]    roperand_in_rs1_index,
  input      [31:0]   roperand_in_rs2,
  input      [4:0]    roperand_in_rs2_index,
  input      [4:0]    roperand_in_rd_index,
  output reg [31:0]   vd_out_vd_0,
  output reg [31:0]   vd_out_vd_1,
  output reg [31:0]   vd_out_vd_2,
  output reg [31:0]   vd_out_vd_3,
  output reg [31:0]   vd_out_vd_4,
  output reg [31:0]   vd_out_vd_5,
  output reg [31:0]   vd_out_vd_6,
  output reg [31:0]   vd_out_vd_7,
  output reg [31:0]   vd_out_vd_8,
  output reg [31:0]   vd_out_vd_9,
  output reg [31:0]   vd_out_vd_10,
  output reg [31:0]   vd_out_vd_11,
  output reg [31:0]   vd_out_vd_12,
  output reg [31:0]   vd_out_vd_13,
  output reg [31:0]   vd_out_vd_14,
  output reg [31:0]   vd_out_vd_15,
  output reg [31:0]   alu_write_rd_data,
  output reg [4:0]    alu_write_rd_index,
  output reg          alu_write_rd_vld,
  input               is_branch,
  input      [9:0]    pc_in,
  output reg [9:0]    branch_taken_addr,
  output reg          branch_taken_vld,
  output reg          result_vld_out,
  output     [31:0]   to_lsu_addr,
  output reg          to_lsu_addr_vld,
  output reg          to_lsu_is_vector,
  output reg          ebreak,
  input               clk,
  input               resetn
);
  localparam NOP = 5'd0;
  localparam LW = 5'd1;
  localparam LV = 5'd2;
  localparam SW = 5'd3;
  localparam SV1 = 5'd4;
  localparam SV2 = 5'd5;
  localparam J = 5'd6;
  localparam JAL = 5'd7;
  localparam JR = 5'd8;
  localparam BEQZ = 5'd9;
  localparam BNEZ = 5'd10;
  localparam MV = 5'd11;
  localparam EBREAK = 5'd12;
  localparam VMUL_SUM = 5'd13;
  localparam V_MUL = 5'd14;
  localparam MUL = 5'd15;
  localparam DIV = 5'd16;
  localparam ADDI4SPN = 5'd17;
  localparam ADDI = 5'd18;
  localparam ADD = 5'd19;
  localparam SUB = 5'd20;
  localparam SRLI = 5'd21;
  localparam SRAI = 5'd22;
  localparam SRL_1 = 5'd23;
  localparam SLLI = 5'd24;
  localparam SLL_1 = 5'd25;

  wire       [31:0]   alu_adder_dinA;
  wire       [31:0]   alu_adder_dinB;
  wire                scalar_mul_io_din_vld;
  wire       [31:0]   scalar_mul_io_dinA;
  wire       [31:0]   scalar_mul_io_dinB;
  wire                scalar_div_din_vld;
  wire       [15:0]   scalar_div_dinA;
  wire       [7:0]    scalar_div_dinB;
  wire       [15:0]   multipliers_0_dout;
  wire       [15:0]   multipliers_1_dout;
  wire       [15:0]   multipliers_2_dout;
  wire       [15:0]   multipliers_3_dout;
  wire       [15:0]   multipliers_4_dout;
  wire       [15:0]   multipliers_5_dout;
  wire       [15:0]   multipliers_6_dout;
  wire       [15:0]   multipliers_7_dout;
  wire       [15:0]   multipliers_8_dout;
  wire       [15:0]   multipliers_9_dout;
  wire       [15:0]   multipliers_10_dout;
  wire       [15:0]   multipliers_11_dout;
  wire       [15:0]   multipliers_12_dout;
  wire       [15:0]   multipliers_13_dout;
  wire       [15:0]   multipliers_14_dout;
  wire       [15:0]   multipliers_15_dout;
  wire       [16:0]   adder_1cycle_15_dout;
  wire       [16:0]   adder_1cycle_16_dout;
  wire       [16:0]   adder_1cycle_17_dout;
  wire       [16:0]   adder_1cycle_18_dout;
  wire       [16:0]   adder_1cycle_19_dout;
  wire       [16:0]   adder_1cycle_20_dout;
  wire       [16:0]   adder_1cycle_21_dout;
  wire       [16:0]   adder_1cycle_22_dout;
  wire       [17:0]   adder_1cycle_23_dout;
  wire       [17:0]   adder_1cycle_24_dout;
  wire       [17:0]   adder_1cycle_25_dout;
  wire       [17:0]   adder_1cycle_26_dout;
  wire       [18:0]   adder_1cycle_27_dout;
  wire       [18:0]   adder_1cycle_28_dout;
  wire       [19:0]   adder_1cycle_29_dout;
  wire       [31:0]   alu_adder_dout;
  wire                scalar_mul_io_dout_vld;
  wire                scalar_mul_io_cal_finish;
  wire       [63:0]   scalar_mul_io_dout;
  wire                scalar_div_dout_vld;
  wire       [16:0]   scalar_div_quot;
  wire       [7:0]    scalar_div_remainder;
  wire       [31:0]   tmp_dinA;
  wire       [31:0]   tmp_dinA_1;
  wire       [31:0]   tmp_dinA_2;
  wire       [31:0]   tmp_dinB;
  wire       [31:0]   tmp_dinB_1;
  wire       [31:0]   tmp_alu_write_rd_data;
  wire       [31:0]   tmp_alu_write_rd_data_1;
  wire       [31:0]   tmp_alu_write_rd_data_2;
  wire       [31:0]   tmp_alu_write_rd_data_3;
  wire       [31:0]   tmp_alu_write_rd_data_4;
  wire       [31:0]   tmp_alu_write_rd_data_5;
  wire       [31:0]   tmp_alu_write_rd_data_6;
  wire       [31:0]   tmp_alu_write_rd_data_7;
  wire       [9:0]    tmp_branch_taken_addr;
  wire       [9:0]    tmp_branch_taken_addr_1;
  wire       [9:0]    tmp_branch_taken_addr_2;
  wire       [7:0]    element_in_a_0;
  wire       [7:0]    element_in_a_1;
  wire       [7:0]    element_in_a_2;
  wire       [7:0]    element_in_a_3;
  wire       [7:0]    element_in_a_4;
  wire       [7:0]    element_in_a_5;
  wire       [7:0]    element_in_a_6;
  wire       [7:0]    element_in_a_7;
  wire       [7:0]    element_in_a_8;
  wire       [7:0]    element_in_a_9;
  wire       [7:0]    element_in_a_10;
  wire       [7:0]    element_in_a_11;
  wire       [7:0]    element_in_a_12;
  wire       [7:0]    element_in_a_13;
  wire       [7:0]    element_in_a_14;
  wire       [7:0]    element_in_a_15;
  wire       [7:0]    element_in_b_0;
  wire       [7:0]    element_in_b_1;
  wire       [7:0]    element_in_b_2;
  wire       [7:0]    element_in_b_3;
  wire       [7:0]    element_in_b_4;
  wire       [7:0]    element_in_b_5;
  wire       [7:0]    element_in_b_6;
  wire       [7:0]    element_in_b_7;
  wire       [7:0]    element_in_b_8;
  wire       [7:0]    element_in_b_9;
  wire       [7:0]    element_in_b_10;
  wire       [7:0]    element_in_b_11;
  wire       [7:0]    element_in_b_12;
  wire       [7:0]    element_in_b_13;
  wire       [7:0]    element_in_b_14;
  wire       [7:0]    element_in_b_15;
  wire       [15:0]   mul_out_0;
  wire       [15:0]   mul_out_1;
  wire       [15:0]   mul_out_2;
  wire       [15:0]   mul_out_3;
  wire       [15:0]   mul_out_4;
  wire       [15:0]   mul_out_5;
  wire       [15:0]   mul_out_6;
  wire       [15:0]   mul_out_7;
  wire       [15:0]   mul_out_8;
  wire       [15:0]   mul_out_9;
  wire       [15:0]   mul_out_10;
  wire       [15:0]   mul_out_11;
  wire       [15:0]   mul_out_12;
  wire       [15:0]   mul_out_13;
  wire       [15:0]   mul_out_14;
  wire       [15:0]   mul_out_15;
  reg                 is_vector_mul_sum;
  wire                is_load_store;
  wire                sub_en;
  `ifndef SYNTHESIS
  reg [63:0] op_type_string;
  `endif


  assign tmp_dinA = tmp_dinA_1;
  assign tmp_dinA_1 = {22'd0, pc_in};
  assign tmp_dinA_2 = roperand_in_rs1;
  assign tmp_dinB = {{12{adder_1cycle_29_dout[19]}}, adder_1cycle_29_dout};
  assign tmp_dinB_1 = roperand_in_rs2;
  assign tmp_alu_write_rd_data = alu_adder_dout[31 : 0];
  assign tmp_alu_write_rd_data_1 = scalar_mul_io_dout[31 : 0];
  assign tmp_alu_write_rd_data_2 = {{15{scalar_div_quot[16]}}, scalar_div_quot};
  assign tmp_alu_write_rd_data_3 = ($signed(tmp_alu_write_rd_data_4) <<< roperand_in_rs2[5 : 0]);
  assign tmp_alu_write_rd_data_4 = roperand_in_rs1;
  assign tmp_alu_write_rd_data_5 = (roperand_in_rs1 >>> roperand_in_rs2[5 : 0]);
  assign tmp_alu_write_rd_data_6 = ($signed(tmp_alu_write_rd_data_7) >>> roperand_in_rs2[5 : 0]);
  assign tmp_alu_write_rd_data_7 = roperand_in_rs1;
  assign tmp_branch_taken_addr = alu_adder_dout[9 : 0];
  assign tmp_branch_taken_addr_1 = alu_adder_dout[9 : 0];
  assign tmp_branch_taken_addr_2 = alu_adder_dout[9 : 0];
  mul_1cycle_15 multipliers_0 (
    .dinA (element_in_a_0[7:0]     ), //i
    .dinB (element_in_b_0[7:0]     ), //i
    .dout (multipliers_0_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_1 (
    .dinA (element_in_a_1[7:0]     ), //i
    .dinB (element_in_b_1[7:0]     ), //i
    .dout (multipliers_1_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_2 (
    .dinA (element_in_a_2[7:0]     ), //i
    .dinB (element_in_b_2[7:0]     ), //i
    .dout (multipliers_2_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_3 (
    .dinA (element_in_a_3[7:0]     ), //i
    .dinB (element_in_b_3[7:0]     ), //i
    .dout (multipliers_3_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_4 (
    .dinA (element_in_a_4[7:0]     ), //i
    .dinB (element_in_b_4[7:0]     ), //i
    .dout (multipliers_4_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_5 (
    .dinA (element_in_a_5[7:0]     ), //i
    .dinB (element_in_b_5[7:0]     ), //i
    .dout (multipliers_5_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_6 (
    .dinA (element_in_a_6[7:0]     ), //i
    .dinB (element_in_b_6[7:0]     ), //i
    .dout (multipliers_6_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_7 (
    .dinA (element_in_a_7[7:0]     ), //i
    .dinB (element_in_b_7[7:0]     ), //i
    .dout (multipliers_7_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_8 (
    .dinA (element_in_a_8[7:0]     ), //i
    .dinB (element_in_b_8[7:0]     ), //i
    .dout (multipliers_8_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_9 (
    .dinA (element_in_a_9[7:0]     ), //i
    .dinB (element_in_b_9[7:0]     ), //i
    .dout (multipliers_9_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_10 (
    .dinA (element_in_a_10[7:0]     ), //i
    .dinB (element_in_b_10[7:0]     ), //i
    .dout (multipliers_10_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_11 (
    .dinA (element_in_a_11[7:0]     ), //i
    .dinB (element_in_b_11[7:0]     ), //i
    .dout (multipliers_11_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_12 (
    .dinA (element_in_a_12[7:0]     ), //i
    .dinB (element_in_b_12[7:0]     ), //i
    .dout (multipliers_12_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_13 (
    .dinA (element_in_a_13[7:0]     ), //i
    .dinB (element_in_b_13[7:0]     ), //i
    .dout (multipliers_13_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_14 (
    .dinA (element_in_a_14[7:0]     ), //i
    .dinB (element_in_b_14[7:0]     ), //i
    .dout (multipliers_14_dout[15:0])  //o
  );
  mul_1cycle_15 multipliers_15 (
    .dinA (element_in_a_15[7:0]     ), //i
    .dinB (element_in_b_15[7:0]     ), //i
    .dout (multipliers_15_dout[15:0])  //o
  );
  adder_1cycle_14 adder_1cycle_15 (
    .dinA (mul_out_0[15:0]           ), //i
    .dinB (mul_out_1[15:0]           ), //i
    .dout (adder_1cycle_15_dout[16:0])  //o
  );
  adder_1cycle_14 adder_1cycle_16 (
    .dinA (mul_out_2[15:0]           ), //i
    .dinB (mul_out_3[15:0]           ), //i
    .dout (adder_1cycle_16_dout[16:0])  //o
  );
  adder_1cycle_14 adder_1cycle_17 (
    .dinA (mul_out_4[15:0]           ), //i
    .dinB (mul_out_5[15:0]           ), //i
    .dout (adder_1cycle_17_dout[16:0])  //o
  );
  adder_1cycle_14 adder_1cycle_18 (
    .dinA (mul_out_6[15:0]           ), //i
    .dinB (mul_out_7[15:0]           ), //i
    .dout (adder_1cycle_18_dout[16:0])  //o
  );
  adder_1cycle_14 adder_1cycle_19 (
    .dinA (mul_out_8[15:0]           ), //i
    .dinB (mul_out_9[15:0]           ), //i
    .dout (adder_1cycle_19_dout[16:0])  //o
  );
  adder_1cycle_14 adder_1cycle_20 (
    .dinA (mul_out_10[15:0]          ), //i
    .dinB (mul_out_11[15:0]          ), //i
    .dout (adder_1cycle_20_dout[16:0])  //o
  );
  adder_1cycle_14 adder_1cycle_21 (
    .dinA (mul_out_12[15:0]          ), //i
    .dinB (mul_out_13[15:0]          ), //i
    .dout (adder_1cycle_21_dout[16:0])  //o
  );
  adder_1cycle_14 adder_1cycle_22 (
    .dinA (mul_out_14[15:0]          ), //i
    .dinB (mul_out_15[15:0]          ), //i
    .dout (adder_1cycle_22_dout[16:0])  //o
  );
  adder_1cycle_6 adder_1cycle_23 (
    .dinA (adder_1cycle_15_dout[16:0]), //i
    .dinB (adder_1cycle_16_dout[16:0]), //i
    .dout (adder_1cycle_23_dout[17:0])  //o
  );
  adder_1cycle_6 adder_1cycle_24 (
    .dinA (adder_1cycle_17_dout[16:0]), //i
    .dinB (adder_1cycle_18_dout[16:0]), //i
    .dout (adder_1cycle_24_dout[17:0])  //o
  );
  adder_1cycle_6 adder_1cycle_25 (
    .dinA (adder_1cycle_19_dout[16:0]), //i
    .dinB (adder_1cycle_20_dout[16:0]), //i
    .dout (adder_1cycle_25_dout[17:0])  //o
  );
  adder_1cycle_6 adder_1cycle_26 (
    .dinA (adder_1cycle_21_dout[16:0]), //i
    .dinB (adder_1cycle_22_dout[16:0]), //i
    .dout (adder_1cycle_26_dout[17:0])  //o
  );
  adder_1cycle_2 adder_1cycle_27 (
    .dinA (adder_1cycle_23_dout[17:0]), //i
    .dinB (adder_1cycle_24_dout[17:0]), //i
    .dout (adder_1cycle_27_dout[18:0])  //o
  );
  adder_1cycle_2 adder_1cycle_28 (
    .dinA (adder_1cycle_25_dout[17:0]), //i
    .dinB (adder_1cycle_26_dout[17:0]), //i
    .dout (adder_1cycle_28_dout[18:0])  //o
  );
  adder_1cycle adder_1cycle_29 (
    .dinA (adder_1cycle_27_dout[18:0]), //i
    .dinB (adder_1cycle_28_dout[18:0]), //i
    .dout (adder_1cycle_29_dout[19:0])  //o
  );
  AdderWithSub_1cycle alu_adder (
    .sub_en (sub_en              ), //i
    .dinA   (alu_adder_dinA[31:0]), //i
    .dinB   (alu_adder_dinB[31:0]), //i
    .dout   (alu_adder_dout[31:0])  //o
  );
  booth4 scalar_mul (
    .io_din_vld    (scalar_mul_io_din_vld   ), //i
    .io_dinA       (scalar_mul_io_dinA[31:0]), //i
    .io_dinB       (scalar_mul_io_dinB[31:0]), //i
    .io_dout_vld   (scalar_mul_io_dout_vld  ), //o
    .io_cal_finish (scalar_mul_io_cal_finish), //o
    .io_dout       (scalar_mul_io_dout[63:0]), //o
    .clk           (clk                     ), //i
    .resetn        (resetn                  )  //i
  );
  restoring_div_radix4 scalar_div (
    .din_vld   (scalar_div_din_vld       ), //i
    .dinA      (scalar_div_dinA[15:0]    ), //i
    .dinB      (scalar_div_dinB[7:0]     ), //i
    .dout_vld  (scalar_div_dout_vld      ), //o
    .quot      (scalar_div_quot[16:0]    ), //o
    .remainder (scalar_div_remainder[7:0]), //o
    .clk       (clk                      ), //i
    .resetn    (resetn                   )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(op_type)
      NOP : op_type_string = "NOP     ";
      LW : op_type_string = "LW      ";
      LV : op_type_string = "LV      ";
      SW : op_type_string = "SW      ";
      SV1 : op_type_string = "SV1     ";
      SV2 : op_type_string = "SV2     ";
      J : op_type_string = "J       ";
      JAL : op_type_string = "JAL     ";
      JR : op_type_string = "JR      ";
      BEQZ : op_type_string = "BEQZ    ";
      BNEZ : op_type_string = "BNEZ    ";
      MV : op_type_string = "MV      ";
      EBREAK : op_type_string = "EBREAK  ";
      VMUL_SUM : op_type_string = "VMUL_SUM";
      V_MUL : op_type_string = "V_MUL   ";
      MUL : op_type_string = "MUL     ";
      DIV : op_type_string = "DIV     ";
      ADDI4SPN : op_type_string = "ADDI4SPN";
      ADDI : op_type_string = "ADDI    ";
      ADD : op_type_string = "ADD     ";
      SUB : op_type_string = "SUB     ";
      SRLI : op_type_string = "SRLI    ";
      SRAI : op_type_string = "SRAI    ";
      SRL_1 : op_type_string = "SRL_1   ";
      SLLI : op_type_string = "SLLI    ";
      SLL_1 : op_type_string = "SLL_1   ";
      default : op_type_string = "????????";
    endcase
  end
  `endif

  assign element_in_a_0 = voperand_in_vs1[7 : 0]; // @[alu.scala 79:21]
  assign element_in_b_0 = voperand_in_vs2[7 : 0]; // @[alu.scala 80:21]
  assign mul_out_0 = multipliers_0_dout; // @[alu.scala 83:16]
  assign element_in_a_1 = voperand_in_vs1[15 : 8]; // @[alu.scala 79:21]
  assign element_in_b_1 = voperand_in_vs2[15 : 8]; // @[alu.scala 80:21]
  assign mul_out_1 = multipliers_1_dout; // @[alu.scala 83:16]
  assign element_in_a_2 = voperand_in_vs1[23 : 16]; // @[alu.scala 79:21]
  assign element_in_b_2 = voperand_in_vs2[23 : 16]; // @[alu.scala 80:21]
  assign mul_out_2 = multipliers_2_dout; // @[alu.scala 83:16]
  assign element_in_a_3 = voperand_in_vs1[31 : 24]; // @[alu.scala 79:21]
  assign element_in_b_3 = voperand_in_vs2[31 : 24]; // @[alu.scala 80:21]
  assign mul_out_3 = multipliers_3_dout; // @[alu.scala 83:16]
  assign element_in_a_4 = voperand_in_vs1[39 : 32]; // @[alu.scala 79:21]
  assign element_in_b_4 = voperand_in_vs2[39 : 32]; // @[alu.scala 80:21]
  assign mul_out_4 = multipliers_4_dout; // @[alu.scala 83:16]
  assign element_in_a_5 = voperand_in_vs1[47 : 40]; // @[alu.scala 79:21]
  assign element_in_b_5 = voperand_in_vs2[47 : 40]; // @[alu.scala 80:21]
  assign mul_out_5 = multipliers_5_dout; // @[alu.scala 83:16]
  assign element_in_a_6 = voperand_in_vs1[55 : 48]; // @[alu.scala 79:21]
  assign element_in_b_6 = voperand_in_vs2[55 : 48]; // @[alu.scala 80:21]
  assign mul_out_6 = multipliers_6_dout; // @[alu.scala 83:16]
  assign element_in_a_7 = voperand_in_vs1[63 : 56]; // @[alu.scala 79:21]
  assign element_in_b_7 = voperand_in_vs2[63 : 56]; // @[alu.scala 80:21]
  assign mul_out_7 = multipliers_7_dout; // @[alu.scala 83:16]
  assign element_in_a_8 = voperand_in_vs1[71 : 64]; // @[alu.scala 79:21]
  assign element_in_b_8 = voperand_in_vs2[71 : 64]; // @[alu.scala 80:21]
  assign mul_out_8 = multipliers_8_dout; // @[alu.scala 83:16]
  assign element_in_a_9 = voperand_in_vs1[79 : 72]; // @[alu.scala 79:21]
  assign element_in_b_9 = voperand_in_vs2[79 : 72]; // @[alu.scala 80:21]
  assign mul_out_9 = multipliers_9_dout; // @[alu.scala 83:16]
  assign element_in_a_10 = voperand_in_vs1[87 : 80]; // @[alu.scala 79:21]
  assign element_in_b_10 = voperand_in_vs2[87 : 80]; // @[alu.scala 80:21]
  assign mul_out_10 = multipliers_10_dout; // @[alu.scala 83:16]
  assign element_in_a_11 = voperand_in_vs1[95 : 88]; // @[alu.scala 79:21]
  assign element_in_b_11 = voperand_in_vs2[95 : 88]; // @[alu.scala 80:21]
  assign mul_out_11 = multipliers_11_dout; // @[alu.scala 83:16]
  assign element_in_a_12 = voperand_in_vs1[103 : 96]; // @[alu.scala 79:21]
  assign element_in_b_12 = voperand_in_vs2[103 : 96]; // @[alu.scala 80:21]
  assign mul_out_12 = multipliers_12_dout; // @[alu.scala 83:16]
  assign element_in_a_13 = voperand_in_vs1[111 : 104]; // @[alu.scala 79:21]
  assign element_in_b_13 = voperand_in_vs2[111 : 104]; // @[alu.scala 80:21]
  assign mul_out_13 = multipliers_13_dout; // @[alu.scala 83:16]
  assign element_in_a_14 = voperand_in_vs1[119 : 112]; // @[alu.scala 79:21]
  assign element_in_b_14 = voperand_in_vs2[119 : 112]; // @[alu.scala 80:21]
  assign mul_out_14 = multipliers_14_dout; // @[alu.scala 83:16]
  assign element_in_a_15 = voperand_in_vs1[127 : 120]; // @[alu.scala 79:21]
  assign element_in_b_15 = voperand_in_vs2[127 : 120]; // @[alu.scala 80:21]
  assign mul_out_15 = multipliers_15_dout; // @[alu.scala 83:16]
  assign sub_en = (op_type == SUB); // @[BaseType.scala 305:24]
  assign alu_adder_dinA = (is_branch ? tmp_dinA : tmp_dinA_2); // @[alu.scala 112:21]
  assign alu_adder_dinB = (is_vector_mul_sum ? tmp_dinB : tmp_dinB_1); // @[alu.scala 113:21]
  assign to_lsu_addr = alu_adder_dout; // @[alu.scala 115:18]
  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_0 = {{16{mul_out_0[15]}}, mul_out_0}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_0 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_1 = {{16{mul_out_1[15]}}, mul_out_1}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_1 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_2 = {{16{mul_out_2[15]}}, mul_out_2}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_2 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_3 = {{16{mul_out_3[15]}}, mul_out_3}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_3 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_4 = {{16{mul_out_4[15]}}, mul_out_4}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_4 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_5 = {{16{mul_out_5[15]}}, mul_out_5}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_5 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_6 = {{16{mul_out_6[15]}}, mul_out_6}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_6 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_7 = {{16{mul_out_7[15]}}, mul_out_7}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_7 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_8 = {{16{mul_out_8[15]}}, mul_out_8}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_8 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_9 = {{16{mul_out_9[15]}}, mul_out_9}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_9 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_10 = {{16{mul_out_10[15]}}, mul_out_10}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_10 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_11 = {{16{mul_out_11[15]}}, mul_out_11}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_11 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_12 = {{16{mul_out_12[15]}}, mul_out_12}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_12 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_13 = {{16{mul_out_13[15]}}, mul_out_13}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_13 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_14 = {{16{mul_out_14[15]}}, mul_out_14}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_14 = 32'h0; // @[alu.scala 121:23]
    end
  end

  always @(*) begin
    if((op_type == V_MUL)) begin
      vd_out_vd_15 = {{16{mul_out_15[15]}}, mul_out_15}; // @[alu.scala 119:23]
    end else begin
      vd_out_vd_15 = 32'h0; // @[alu.scala 121:23]
    end
  end

  assign scalar_mul_io_dinA = roperand_in_rs1; // @[alu.scala 127:22]
  assign scalar_mul_io_dinB = roperand_in_rs2; // @[alu.scala 128:22]
  assign scalar_mul_io_din_vld = ((op_type == MUL) && oprand_vld_in); // @[alu.scala 129:25]
  assign scalar_div_dinA = roperand_in_rs1[15 : 0]; // @[alu.scala 131:22]
  assign scalar_div_dinB = roperand_in_rs2[7 : 0]; // @[alu.scala 132:22]
  assign scalar_div_din_vld = ((op_type == DIV) && oprand_vld_in); // @[alu.scala 133:25]
  always @(*) begin
    alu_write_rd_data = 32'h0; // @[alu.scala 135:24]
    case(op_type)
      VMUL_SUM : begin
        alu_write_rd_data = tmp_alu_write_rd_data; // @[alu.scala 167:28]
      end
      ADD, SUB, ADDI : begin
        alu_write_rd_data = alu_adder_dout; // @[alu.scala 174:28]
      end
      ADDI4SPN : begin
        alu_write_rd_data = alu_adder_dout; // @[alu.scala 181:28]
      end
      MUL : begin
        alu_write_rd_data = tmp_alu_write_rd_data_1; // @[alu.scala 187:28]
      end
      DIV : begin
        alu_write_rd_data = tmp_alu_write_rd_data_2; // @[alu.scala 193:28]
      end
      SLL_1, SLLI : begin
        alu_write_rd_data = tmp_alu_write_rd_data_3; // @[alu.scala 199:28]
      end
      SRL_1, SRLI : begin
        alu_write_rd_data = tmp_alu_write_rd_data_5; // @[alu.scala 205:28]
      end
      SRAI : begin
        alu_write_rd_data = tmp_alu_write_rd_data_6; // @[alu.scala 211:28]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    alu_write_rd_index = 5'h0; // @[alu.scala 136:25]
    case(op_type)
      VMUL_SUM : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 168:29]
      end
      ADD, SUB, ADDI : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 175:29]
      end
      ADDI4SPN : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 182:29]
      end
      MUL : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 188:29]
      end
      DIV : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 194:29]
      end
      SLL_1, SLLI : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 200:29]
      end
      SRL_1, SRLI : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 206:29]
      end
      SRAI : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 212:29]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    alu_write_rd_vld = 1'b0; // @[alu.scala 137:23]
    case(op_type)
      VMUL_SUM : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 171:27]
      end
      ADD, SUB, ADDI : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 177:27]
      end
      ADDI4SPN : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 184:27]
      end
      MUL : begin
        alu_write_rd_vld = scalar_mul_io_dout_vld; // @[alu.scala 190:27]
      end
      DIV : begin
        alu_write_rd_vld = scalar_div_dout_vld; // @[alu.scala 196:27]
      end
      SLL_1, SLLI : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 202:27]
      end
      SRL_1, SRLI : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 208:27]
      end
      SRAI : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 214:27]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    to_lsu_addr_vld = 1'b0; // @[alu.scala 139:22]
    case(op_type)
      LW, SW : begin
        to_lsu_addr_vld = oprand_vld_in; // @[alu.scala 159:26]
      end
      LV, SV1, SV2 : begin
        to_lsu_addr_vld = oprand_vld_in; // @[alu.scala 163:26]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    to_lsu_is_vector = 1'b0; // @[alu.scala 140:23]
    case(op_type)
      LV, SV1, SV2 : begin
        to_lsu_is_vector = 1'b1; // @[alu.scala 164:27]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    result_vld_out = 1'b0; // @[alu.scala 143:21]
    case(op_type)
      NOP : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 152:25]
      end
      VMUL_SUM : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 169:25]
      end
      ADD, SUB, ADDI : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 176:25]
      end
      ADDI4SPN : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 183:25]
      end
      MUL : begin
        result_vld_out = scalar_mul_io_dout_vld; // @[alu.scala 189:25]
      end
      DIV : begin
        result_vld_out = scalar_div_dout_vld; // @[alu.scala 195:25]
      end
      SLL_1, SLLI : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 201:25]
      end
      SRL_1, SRLI : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 207:25]
      end
      SRAI : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 213:25]
      end
      J : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 219:25]
      end
      JR : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 224:25]
      end
      BEQZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          result_vld_out = oprand_vld_in; // @[alu.scala 230:27]
        end else begin
          result_vld_out = oprand_vld_in; // @[alu.scala 233:27]
        end
      end
      BNEZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          result_vld_out = oprand_vld_in; // @[alu.scala 239:27]
        end else begin
          result_vld_out = oprand_vld_in; // @[alu.scala 243:27]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_vector_mul_sum = 1'b0; // @[alu.scala 144:21]
    case(op_type)
      VMUL_SUM : begin
        is_vector_mul_sum = 1'b1; // @[alu.scala 170:25]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    branch_taken_vld = 1'b0; // @[alu.scala 146:23]
    case(op_type)
      J : begin
        branch_taken_vld = 1'b1; // @[alu.scala 218:27]
      end
      JR : begin
        branch_taken_vld = 1'b1; // @[alu.scala 223:27]
      end
      BEQZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          branch_taken_vld = 1'b1; // @[alu.scala 229:29]
        end else begin
          branch_taken_vld = 1'b0; // @[alu.scala 232:29]
        end
      end
      BNEZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          branch_taken_vld = 1'b0; // @[alu.scala 238:29]
        end else begin
          branch_taken_vld = 1'b1; // @[alu.scala 242:29]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    branch_taken_addr = 10'h0; // @[alu.scala 147:24]
    case(op_type)
      J : begin
        branch_taken_addr = tmp_branch_taken_addr; // @[alu.scala 217:28]
      end
      JR : begin
        branch_taken_addr = roperand_in_rs1[9 : 0]; // @[alu.scala 222:28]
      end
      BEQZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          branch_taken_addr = tmp_branch_taken_addr_1; // @[alu.scala 228:30]
        end
      end
      BNEZ : begin
        if(!(roperand_in_rs1 == 32'h0)) begin
          branch_taken_addr = tmp_branch_taken_addr_2; // @[alu.scala 241:30]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    ebreak = 1'b0; // @[alu.scala 149:13]
    case(op_type)
      EBREAK : begin
        ebreak = 1'b1; // @[alu.scala 155:17]
      end
      default : begin
      end
    endcase
  end


endmodule

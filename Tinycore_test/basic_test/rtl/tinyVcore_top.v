// Generator : SpinalHDL v1.10.0    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : tinyVcore_top
// Git hash  : f6a52a8fc3dc228986b52ef392859d32cae9e2ff

`timescale 1ns/1ps

module tinyVcore_top (
  input  wire          core_start,
  input  wire          debug_en,
  input  wire [10:0]   debug_break_point,
  output wire          iram_mem_rd,
  output wire          iram_mem_wr,
  output wire [10:0]   iram_mem_addr,
  output wire [15:0]   iram_mem_wdata,
  input  wire [15:0]   iram_mem_rdata,
  output wire          highBandWidth_fb_mem_rd,
  output wire          highBandWidth_fb_mem_wr,
  output wire [6:0]    highBandWidth_fb_mem_addr,
  output wire [127:0]  highBandWidth_fb_mem_wdata,
  input  wire [127:0]  highBandWidth_fb_mem_rdata,
  output wire          highBandWidth_a_mem_rd,
  output wire          highBandWidth_a_mem_wr,
  output wire [6:0]    highBandWidth_a_mem_addr,
  output wire [127:0]  highBandWidth_a_mem_wdata,
  input  wire [127:0]  highBandWidth_a_mem_rdata,
  output wire          highBandWidth_w_mem_rd,
  output wire          highBandWidth_w_mem_wr,
  output wire [9:0]    highBandWidth_w_mem_addr,
  output wire [127:0]  highBandWidth_w_mem_wdata,
  input  wire [127:0]  highBandWidth_w_mem_rdata,
  output wire          lowBandWidth_mem_rd,
  output wire          lowBandWidth_mem_wr,
  output wire [6:0]    lowBandWidth_mem_addr,
  output wire [31:0]   lowBandWidth_mem_wdata,
  input  wire [31:0]   lowBandWidth_mem_rdata,
  output wire          core_end,
  output wire [31:0]   x_0,
  output wire [31:0]   x_1,
  output wire [31:0]   x_2,
  output wire [31:0]   x_3,
  output wire [31:0]   x_4,
  output wire [31:0]   x_5,
  output wire [31:0]   x_6,
  output wire [31:0]   x_7,
  output wire [31:0]   x_8,
  output wire [31:0]   x_9,
  output wire [31:0]   x_10,
  output wire [31:0]   x_11,
  output wire [31:0]   x_12,
  output wire [31:0]   x_13,
  output wire [31:0]   x_14,
  output wire [31:0]   x_15,
  output wire [31:0]   x_16,
  output wire [31:0]   x_17,
  output wire [31:0]   x_18,
  output wire [31:0]   x_19,
  output wire [31:0]   x_20,
  output wire [31:0]   x_21,
  output wire [31:0]   x_22,
  output wire [31:0]   x_23,
  output wire [31:0]   x_24,
  output wire [31:0]   x_25,
  output wire [31:0]   x_26,
  output wire [31:0]   x_27,
  output wire [31:0]   x_28,
  output wire [31:0]   x_29,
  output wire [31:0]   x_30,
  output wire [31:0]   x_31,
  output reg  [31:0]   tmp_1,
  output reg  [31:0]   tmp_2,
  output reg  [31:0]   tmp_3,
  output reg  [31:0]   tmp_4,
  output reg  [31:0]   tmp_5,
  output reg  [31:0]   tmp_6,
  output reg  [31:0]   tmp_7,
  output reg  [31:0]   tmp_8,
  output reg  [31:0]   tmp_9,
  output reg  [31:0]   tmp_10,
  output reg  [31:0]   tmp_11,
  output reg  [31:0]   tmp_12,
  output reg  [31:0]   tmp_13,
  output reg  [31:0]   tmp_14,
  output reg  [31:0]   tmp_15,
  output reg  [31:0]   tmp_16,
  output reg  [31:0]   tmp_17,
  output reg  [31:0]   tmp_18,
  output reg  [31:0]   tmp_19,
  output reg  [31:0]   tmp_20,
  output reg  [31:0]   tmp_21,
  output reg  [31:0]   tmp_22,
  output reg  [31:0]   tmp_23,
  output reg  [31:0]   tmp_24,
  output reg  [31:0]   tmp_25,
  output reg  [31:0]   tmp_26,
  output reg  [31:0]   tmp_27,
  output reg  [31:0]   tmp_28,
  output reg  [31:0]   tmp_29,
  output reg  [31:0]   tmp_30,
  output reg  [31:0]   tmp_31,
  output reg  [31:0]   tmp_32,
  output reg  [31:0]   tmp_33,
  output reg  [31:0]   tmp_34,
  output reg  [31:0]   tmp_35,
  output reg  [31:0]   tmp_36,
  output reg  [31:0]   tmp_37,
  output reg  [31:0]   tmp_38,
  output reg  [31:0]   tmp_39,
  output reg  [31:0]   tmp_40,
  output reg  [31:0]   tmp_41,
  output reg  [31:0]   tmp_42,
  output reg  [31:0]   tmp_43,
  output reg  [31:0]   tmp_44,
  output reg  [31:0]   tmp_45,
  output reg  [31:0]   tmp_46,
  output reg  [31:0]   tmp_47,
  output reg  [31:0]   tmp_48,
  output reg  [31:0]   tmp_49,
  output reg  [31:0]   tmp_50,
  output reg  [31:0]   tmp_51,
  output reg  [31:0]   tmp_52,
  output reg  [31:0]   tmp_53,
  output reg  [31:0]   tmp_54,
  output reg  [31:0]   tmp_55,
  output reg  [31:0]   tmp_56,
  output reg  [31:0]   tmp_57,
  output reg  [31:0]   tmp_58,
  output reg  [31:0]   tmp_59,
  output reg  [31:0]   tmp_60,
  output reg  [31:0]   tmp_61,
  output reg  [31:0]   tmp_62,
  output reg  [31:0]   tmp_63,
  output reg  [31:0]   tmp_64,
  output reg  [31:0]   tmp_65,
  output reg  [31:0]   tmp_66,
  output reg  [31:0]   tmp_67,
  output reg  [31:0]   tmp_68,
  output reg  [31:0]   tmp_69,
  output reg  [31:0]   tmp_70,
  output reg  [31:0]   tmp_71,
  output reg  [31:0]   tmp_72,
  output reg  [31:0]   tmp_73,
  output reg  [31:0]   tmp_74,
  output reg  [31:0]   tmp_75,
  output reg  [31:0]   tmp_76,
  output reg  [31:0]   tmp_77,
  output reg  [31:0]   tmp_78,
  output reg  [31:0]   tmp_79,
  output reg  [31:0]   tmp_80,
  output reg  [31:0]   tmp_81,
  output reg  [31:0]   tmp_82,
  output reg  [31:0]   tmp_83,
  output reg  [31:0]   tmp_84,
  output reg  [31:0]   tmp_85,
  output reg  [31:0]   tmp_86,
  output reg  [31:0]   tmp_87,
  output reg  [31:0]   tmp_88,
  output reg  [31:0]   tmp_89,
  output reg  [31:0]   tmp_90,
  output reg  [31:0]   tmp_91,
  output reg  [31:0]   tmp_92,
  output reg  [31:0]   tmp_93,
  output reg  [31:0]   tmp_94,
  output reg  [31:0]   tmp_95,
  output reg  [31:0]   tmp_96,
  output reg  [31:0]   tmp_97,
  output reg  [31:0]   tmp_98,
  output reg  [31:0]   tmp_99,
  output reg  [31:0]   tmp_100,
  output reg  [31:0]   tmp_101,
  output reg  [31:0]   tmp_102,
  output reg  [31:0]   tmp_103,
  output reg  [31:0]   tmp_104,
  output reg  [31:0]   tmp_105,
  output reg  [31:0]   tmp_106,
  output reg  [31:0]   tmp_107,
  output reg  [31:0]   tmp_108,
  output reg  [31:0]   tmp_109,
  output reg  [31:0]   tmp_110,
  output reg  [31:0]   tmp_111,
  output reg  [31:0]   tmp_112,
  output reg  [31:0]   tmp_113,
  output reg  [31:0]   tmp_114,
  output reg  [31:0]   tmp_115,
  output reg  [31:0]   tmp_116,
  output reg  [31:0]   tmp_117,
  output reg  [31:0]   tmp_118,
  output reg  [31:0]   tmp_119,
  output reg  [31:0]   tmp_120,
  output reg  [31:0]   tmp_121,
  output reg  [31:0]   tmp_122,
  output reg  [31:0]   tmp_123,
  output reg  [31:0]   tmp_124,
  output reg  [31:0]   tmp_125,
  output reg  [31:0]   tmp_126,
  output reg  [31:0]   tmp_127,
  output reg  [31:0]   tmp_128,
  input  wire          clk,
  input  wire          resetn
);
  localparam ILLEGAL = 6'd0;
  localparam NOP = 6'd1;
  localparam LW = 6'd2;
  localparam LV = 6'd3;
  localparam SW = 6'd4;
  localparam SV1 = 6'd5;
  localparam SV2 = 6'd6;
  localparam J = 6'd7;
  localparam JAL = 6'd8;
  localparam JR = 6'd9;
  localparam BEQZ = 6'd10;
  localparam BNEZ = 6'd11;
  localparam BLTZ = 6'd12;
  localparam MV = 6'd13;
  localparam EBREAK = 6'd14;
  localparam MVIMMX4 = 6'd15;
  localparam VMUL_SUM = 6'd16;
  localparam FXMUL = 6'd17;
  localparam DIV = 6'd18;
  localparam VMAC8 = 6'd19;
  localparam FMSR = 6'd20;
  localparam MAX = 6'd21;
  localparam MIN = 6'd22;
  localparam ADDX = 6'd23;
  localparam SUBX = 6'd24;
  localparam SKIPADD = 6'd25;
  localparam MVX = 6'd26;
  localparam ADDI4SPN = 6'd27;
  localparam ADDI = 6'd28;
  localparam ADD = 6'd29;
  localparam SUB = 6'd30;
  localparam LUIH8 = 6'd31;
  localparam LUIL8 = 6'd32;
  localparam SRLI = 6'd33;
  localparam SRAI = 6'd34;
  localparam SRL_1 = 6'd35;
  localparam SLLI = 6'd36;
  localparam SLL_1 = 6'd37;

  wire                alu_inst_is_branch_or_jump;
  wire                lsu_inst_is_vstore;
  wire       [31:0]   lsu_inst_access_mem_wr_sdata;
  wire                fetcher_inst_imem_rd;
  wire       [10:0]   fetcher_inst_imem_addr;
  wire                fetcher_inst_instr_valid;
  wire       [15:0]   fetcher_inst_instr_payload;
  wire       [10:0]   fetcher_inst_pc_curr;
  wire       [4:0]    decode_inst_dec_rs1_index;
  wire       [4:0]    decode_inst_dec_rs2_index;
  wire       [4:0]    decode_inst_dec_rs3_index;
  wire       [4:0]    decode_inst_dec_rd_index;
  wire       [31:0]   decode_inst_dec_imm;
  wire                decode_inst_dec_imm_is_rs2;
  wire                decode_inst_dec_is_jump;
  wire                decode_inst_dec_is_branch;
  wire                decode_inst_dec_is_wload;
  wire                decode_inst_dec_is_wstore;
  wire                decode_inst_dec_is_multi_rs1_index;
  wire                decode_inst_dec_is_multi_rd_index;
  wire                decode_inst_dec_is_vector_oprand_used;
  wire                decode_inst_dec_is_vload;
  wire                decode_inst_dec_is_vstore1;
  wire                decode_inst_dec_is_vstore2;
  wire                decode_inst_dec_info_vld;
  wire       [5:0]    decode_inst_op_type;
  wire       [31:0]   regfile_inst_roperand_out_rs1;
  wire       [4:0]    regfile_inst_roperand_out_rs1_index;
  wire       [31:0]   regfile_inst_roperand_out_rs2;
  wire       [4:0]    regfile_inst_roperand_out_rs2_index;
  wire       [31:0]   regfile_inst_roperand_out_rs3;
  wire       [4:0]    regfile_inst_roperand_out_rs3_index;
  wire       [4:0]    regfile_inst_roperand_out_rd_index;
  wire       [127:0]  regfile_inst_voperand_out_vs1;
  wire       [127:0]  regfile_inst_voperand_out_vs2;
  wire       [4:0]    regfile_inst_voperand_out_vs1_index;
  wire       [4:0]    regfile_inst_voperand_out_vs2_index;
  wire                regfile_inst_oprand_vld_out;
  wire       [31:0]   regfile_inst_reg_x_0;
  wire       [31:0]   regfile_inst_reg_x_1;
  wire       [31:0]   regfile_inst_reg_x_2;
  wire       [31:0]   regfile_inst_reg_x_3;
  wire       [31:0]   regfile_inst_reg_x_4;
  wire       [31:0]   regfile_inst_reg_x_5;
  wire       [31:0]   regfile_inst_reg_x_6;
  wire       [31:0]   regfile_inst_reg_x_7;
  wire       [31:0]   regfile_inst_reg_x_8;
  wire       [31:0]   regfile_inst_reg_x_9;
  wire       [31:0]   regfile_inst_reg_x_10;
  wire       [31:0]   regfile_inst_reg_x_11;
  wire       [31:0]   regfile_inst_reg_x_12;
  wire       [31:0]   regfile_inst_reg_x_13;
  wire       [31:0]   regfile_inst_reg_x_14;
  wire       [31:0]   regfile_inst_reg_x_15;
  wire       [31:0]   regfile_inst_reg_x_16;
  wire       [31:0]   regfile_inst_reg_x_17;
  wire       [31:0]   regfile_inst_reg_x_18;
  wire       [31:0]   regfile_inst_reg_x_19;
  wire       [31:0]   regfile_inst_reg_x_20;
  wire       [31:0]   regfile_inst_reg_x_21;
  wire       [31:0]   regfile_inst_reg_x_22;
  wire       [31:0]   regfile_inst_reg_x_23;
  wire       [31:0]   regfile_inst_reg_x_24;
  wire       [31:0]   regfile_inst_reg_x_25;
  wire       [31:0]   regfile_inst_reg_x_26;
  wire       [31:0]   regfile_inst_reg_x_27;
  wire       [31:0]   regfile_inst_reg_x_28;
  wire       [31:0]   regfile_inst_reg_x_29;
  wire       [31:0]   regfile_inst_reg_x_30;
  wire       [31:0]   regfile_inst_reg_x_31;
  wire       [31:0]   alu_inst_alu_write_rd_data;
  wire       [4:0]    alu_inst_alu_write_rd_index;
  wire                alu_inst_alu_write_rd_vld;
  wire       [10:0]   alu_inst_branch_taken_addr;
  wire                alu_inst_branch_taken_vld;
  wire                alu_inst_result_vld_out;
  wire       [31:0]   alu_inst_to_lsu_addr;
  wire                alu_inst_to_lsu_addr_vld;
  wire                alu_inst_to_lsu_is_vector;
  wire                alu_inst_ebreak;
  wire       [31:0]   lsu_inst_lsu_write_rd_data;
  wire       [4:0]    lsu_inst_lsu_write_rd_index;
  wire                lsu_inst_lsu_write_rd_vld;
  wire                lsu_inst_lsu_write_rd_is_vector;
  wire       [127:0]  lsu_inst_lsu_write_rd_vector_data;
  wire                lsu_inst_highBandWidth_fb_mem_rd;
  wire                lsu_inst_highBandWidth_fb_mem_wr;
  wire       [6:0]    lsu_inst_highBandWidth_fb_mem_addr;
  wire       [127:0]  lsu_inst_highBandWidth_fb_mem_wdata;
  wire                lsu_inst_highBandWidth_a_mem_rd;
  wire                lsu_inst_highBandWidth_a_mem_wr;
  wire       [6:0]    lsu_inst_highBandWidth_a_mem_addr;
  wire       [127:0]  lsu_inst_highBandWidth_a_mem_wdata;
  wire                lsu_inst_highBandWidth_w_mem_rd;
  wire                lsu_inst_highBandWidth_w_mem_wr;
  wire       [9:0]    lsu_inst_highBandWidth_w_mem_addr;
  wire       [127:0]  lsu_inst_highBandWidth_w_mem_wdata;
  wire                lsu_inst_lowBandWidth_mem_rd;
  wire                lsu_inst_lowBandWidth_mem_wr;
  wire       [6:0]    lsu_inst_lowBandWidth_mem_addr;
  wire       [31:0]   lsu_inst_lowBandWidth_mem_wdata;
  wire       [127:0]  tmp_129;
  wire                fetch_break;
  wire                fetch_restore;
  wire       [10:0]   branch_taken_addr;
  wire                branch_taken_vld;
  wire       [10:0]   pc_curr;
  wire                debug_break;
  wire       [4:0]    dec_rs1_index;
  wire       [4:0]    dec_rs2_index;
  wire       [4:0]    dec_rs3_index;
  wire       [4:0]    dec_rd_index;
  wire       [31:0]   dec_imm;
  wire                dec_imm_is_rs2;
  wire                dec_is_jump;
  wire                dec_is_branch;
  wire                dec_is_wload;
  wire                dec_is_wstore;
  wire                dec_is_multi_rs1_index;
  wire                dec_is_multi_rd_index;
  wire                dec_is_vector_oprand_used;
  wire                dec_is_vload;
  wire                dec_is_vstore1;
  wire                dec_is_vstore2;
  wire                dec_info_vld;
  wire       [5:0]    op_type;
  wire       [31:0]   alu_write_rd_data;
  wire       [4:0]    alu_write_rd_index;
  wire                alu_write_rd_vld;
  wire       [31:0]   lsu_write_rd_data;
  wire       [4:0]    lsu_write_rd_index;
  wire                lsu_write_rd_vld;
  wire                lsu_write_rd_is_vector;
  wire       [127:0]  lsu_write_rd_vector_data;
  reg        [31:0]   s1_roperand_out_regs_rs1;
  reg        [4:0]    s1_roperand_out_regs_rs1_index;
  reg        [31:0]   s1_roperand_out_regs_rs2;
  reg        [4:0]    s1_roperand_out_regs_rs2_index;
  reg        [31:0]   s1_roperand_out_regs_rs3;
  reg        [4:0]    s1_roperand_out_regs_rs3_index;
  reg        [4:0]    s1_roperand_out_regs_rd_index;
  reg        [127:0]  s1_voperand_out_regs_vs1;
  reg        [127:0]  s1_voperand_out_regs_vs2;
  reg        [4:0]    s1_voperand_out_regs_vs1_index;
  reg        [4:0]    s1_voperand_out_regs_vs2_index;
  reg                 s1_oprand_vld_out_regs;
  reg        [4:0]    s1_dec_regs_rs1_index;
  reg        [4:0]    s1_dec_regs_rs2_index;
  reg        [4:0]    s1_dec_regs_rs3_index;
  reg        [4:0]    s1_dec_regs_rd_index;
  reg        [31:0]   s1_dec_regs_imm;
  reg                 s1_dec_regs_imm_is_rs2;
  reg                 s1_dec_regs_is_jump;
  reg                 s1_dec_regs_is_branch;
  reg                 s1_dec_regs_is_wload;
  reg                 s1_dec_regs_is_wstore;
  reg                 s1_dec_regs_is_multi_rs1_index;
  reg                 s1_dec_regs_is_multi_rd_index;
  reg                 s1_dec_regs_is_vector_oprand_used;
  reg                 s1_dec_regs_is_vload;
  reg                 s1_dec_regs_is_vstore1;
  reg                 s1_dec_regs_is_vstore2;
  reg        [5:0]    s1_op_type_regs;
  reg        [10:0]   s1_pc_curr_reg;
  wire                forwarding_id_ld_rs1;
  wire                forwarding_id_ld_rs2;
  wire                forwarding_id_ld_rs3;
  wire                forwarding_id_ld_vs1;
  wire                forwarding_id_ld_vs2;
  wire                forwarding_alu_rs1;
  wire                forwarding_alu_rs2;
  wire                forwarding_alu_rs3;
  wire       [31:0]   fd_id_roperand_reg_in_rs1;
  wire       [4:0]    fd_id_roperand_reg_in_rs1_index;
  wire       [31:0]   fd_id_roperand_reg_in_rs2;
  wire       [4:0]    fd_id_roperand_reg_in_rs2_index;
  wire       [31:0]   fd_id_roperand_reg_in_rs3;
  wire       [4:0]    fd_id_roperand_reg_in_rs3_index;
  wire       [4:0]    fd_id_roperand_reg_in_rd_index;
  wire       [127:0]  fd_id_voperand_reg_in_vs1;
  wire       [127:0]  fd_id_voperand_reg_in_vs2;
  wire       [4:0]    fd_id_voperand_reg_in_vs1_index;
  wire       [4:0]    fd_id_voperand_reg_in_vs2_index;
  wire                forwarding_id_ex_rs1;
  wire                forwarding_id_ex_rs2;
  wire                forwarding_id_ex_rs3;
  wire       [31:0]   fd_ex_roperand_reg_in_rs1;
  wire       [4:0]    fd_ex_roperand_reg_in_rs1_index;
  wire       [31:0]   fd_ex_roperand_reg_in_rs2;
  wire       [4:0]    fd_ex_roperand_reg_in_rs2_index;
  wire       [31:0]   fd_ex_roperand_reg_in_rs3;
  wire       [4:0]    fd_ex_roperand_reg_in_rs3_index;
  wire       [4:0]    fd_ex_roperand_reg_in_rd_index;
  wire       [127:0]  fd_ex_voperand_reg_in_vs1;
  wire       [127:0]  fd_ex_voperand_reg_in_vs2;
  wire       [4:0]    fd_ex_voperand_reg_in_vs1_index;
  wire       [4:0]    fd_ex_voperand_reg_in_vs2_index;
  wire       [5:0]    tmp_s1_op_type_regs;
  wire       [5:0]    tmp_s1_op_type_regs_1;
  wire                result_vld_out;
  wire       [31:0]   to_lsu_addr;
  wire                to_lsu_addr_vld;
  wire                to_lsu_is_vector;
  reg                 debug_en_regNext;
  `ifndef SYNTHESIS
  reg [63:0] op_type_string;
  reg [63:0] s1_op_type_regs_string;
  reg [63:0] tmp_s1_op_type_regs_string;
  reg [63:0] tmp_s1_op_type_regs_1_string;
  `endif


  fetch fetcher_inst (
    .imem_rd       (fetcher_inst_imem_rd            ), //o
    .imem_addr     (fetcher_inst_imem_addr[10:0]    ), //o
    .imem_rdata    (iram_mem_rdata[15:0]            ), //i
    .fetch_start   (core_start                      ), //i
    .fetch_break   (fetch_break                     ), //i
    .fetch_restore (fetch_restore                   ), //i
    .branch_addr   (branch_taken_addr[10:0]         ), //i
    .branch_vld    (branch_taken_vld                ), //i
    .instr_valid   (fetcher_inst_instr_valid        ), //o
    .instr_payload (fetcher_inst_instr_payload[15:0]), //o
    .pc_curr       (fetcher_inst_pc_curr[10:0]      ), //o
    .clk           (clk                             ), //i
    .resetn        (resetn                          )  //i
  );
  decoder decode_inst (
    .instr_valid               (fetcher_inst_instr_valid             ), //i
    .instr_payload             (fetcher_inst_instr_payload[15:0]     ), //i
    .dec_rs1_index             (decode_inst_dec_rs1_index[4:0]       ), //o
    .dec_rs2_index             (decode_inst_dec_rs2_index[4:0]       ), //o
    .dec_rs3_index             (decode_inst_dec_rs3_index[4:0]       ), //o
    .dec_rd_index              (decode_inst_dec_rd_index[4:0]        ), //o
    .dec_imm                   (decode_inst_dec_imm[31:0]            ), //o
    .dec_imm_is_rs2            (decode_inst_dec_imm_is_rs2           ), //o
    .dec_is_jump               (decode_inst_dec_is_jump              ), //o
    .dec_is_branch             (decode_inst_dec_is_branch            ), //o
    .dec_is_wload              (decode_inst_dec_is_wload             ), //o
    .dec_is_wstore             (decode_inst_dec_is_wstore            ), //o
    .dec_is_multi_rs1_index    (decode_inst_dec_is_multi_rs1_index   ), //o
    .dec_is_multi_rd_index     (decode_inst_dec_is_multi_rd_index    ), //o
    .dec_is_vector_oprand_used (decode_inst_dec_is_vector_oprand_used), //o
    .dec_is_vload              (decode_inst_dec_is_vload             ), //o
    .dec_is_vstore1            (decode_inst_dec_is_vstore1           ), //o
    .dec_is_vstore2            (decode_inst_dec_is_vstore2           ), //o
    .dec_info_vld              (decode_inst_dec_info_vld             ), //o
    .op_type                   (decode_inst_op_type[5:0]             )  //o
  );
  registers regfile_inst (
    .dec_rs1_index             (dec_rs1_index[4:0]                      ), //i
    .dec_rs2_index             (dec_rs2_index[4:0]                      ), //i
    .dec_rs3_index             (dec_rs3_index[4:0]                      ), //i
    .dec_rd_index              (dec_rd_index[4:0]                       ), //i
    .dec_imm                   (dec_imm[31:0]                           ), //i
    .dec_imm_is_rs2            (dec_imm_is_rs2                          ), //i
    .dec_is_jump               (dec_is_jump                             ), //i
    .dec_is_branch             (dec_is_branch                           ), //i
    .dec_is_wload              (dec_is_wload                            ), //i
    .dec_is_wstore             (dec_is_wstore                           ), //i
    .dec_is_multi_rs1_index    (dec_is_multi_rs1_index                  ), //i
    .dec_is_multi_rd_index     (dec_is_multi_rd_index                   ), //i
    .dec_is_vector_oprand_used (dec_is_vector_oprand_used               ), //i
    .dec_is_vload              (dec_is_vload                            ), //i
    .dec_is_vstore1            (dec_is_vstore1                          ), //i
    .dec_is_vstore2            (dec_is_vstore2                          ), //i
    .dec_info_vld              (dec_info_vld                            ), //i
    .alu_write_rd_data         (alu_write_rd_data[31:0]                 ), //i
    .alu_write_rd_index        (alu_write_rd_index[4:0]                 ), //i
    .alu_write_rd_vld          (alu_write_rd_vld                        ), //i
    .lsu_write_rd_data         (lsu_write_rd_data[31:0]                 ), //i
    .lsu_write_rd_index        (lsu_write_rd_index[4:0]                 ), //i
    .lsu_write_rd_vld          (lsu_write_rd_vld                        ), //i
    .lsu_write_rd_is_vector    (lsu_write_rd_is_vector                  ), //i
    .lsu_write_rd_vector_data  (lsu_write_rd_vector_data[127:0]         ), //i
    .roperand_out_rs1          (regfile_inst_roperand_out_rs1[31:0]     ), //o
    .roperand_out_rs1_index    (regfile_inst_roperand_out_rs1_index[4:0]), //o
    .roperand_out_rs2          (regfile_inst_roperand_out_rs2[31:0]     ), //o
    .roperand_out_rs2_index    (regfile_inst_roperand_out_rs2_index[4:0]), //o
    .roperand_out_rs3          (regfile_inst_roperand_out_rs3[31:0]     ), //o
    .roperand_out_rs3_index    (regfile_inst_roperand_out_rs3_index[4:0]), //o
    .roperand_out_rd_index     (regfile_inst_roperand_out_rd_index[4:0] ), //o
    .voperand_out_vs1          (regfile_inst_voperand_out_vs1[127:0]    ), //o
    .voperand_out_vs2          (regfile_inst_voperand_out_vs2[127:0]    ), //o
    .voperand_out_vs1_index    (regfile_inst_voperand_out_vs1_index[4:0]), //o
    .voperand_out_vs2_index    (regfile_inst_voperand_out_vs2_index[4:0]), //o
    .oprand_vld_out            (regfile_inst_oprand_vld_out             ), //o
    .reg_x_0                   (regfile_inst_reg_x_0[31:0]              ), //o
    .reg_x_1                   (regfile_inst_reg_x_1[31:0]              ), //o
    .reg_x_2                   (regfile_inst_reg_x_2[31:0]              ), //o
    .reg_x_3                   (regfile_inst_reg_x_3[31:0]              ), //o
    .reg_x_4                   (regfile_inst_reg_x_4[31:0]              ), //o
    .reg_x_5                   (regfile_inst_reg_x_5[31:0]              ), //o
    .reg_x_6                   (regfile_inst_reg_x_6[31:0]              ), //o
    .reg_x_7                   (regfile_inst_reg_x_7[31:0]              ), //o
    .reg_x_8                   (regfile_inst_reg_x_8[31:0]              ), //o
    .reg_x_9                   (regfile_inst_reg_x_9[31:0]              ), //o
    .reg_x_10                  (regfile_inst_reg_x_10[31:0]             ), //o
    .reg_x_11                  (regfile_inst_reg_x_11[31:0]             ), //o
    .reg_x_12                  (regfile_inst_reg_x_12[31:0]             ), //o
    .reg_x_13                  (regfile_inst_reg_x_13[31:0]             ), //o
    .reg_x_14                  (regfile_inst_reg_x_14[31:0]             ), //o
    .reg_x_15                  (regfile_inst_reg_x_15[31:0]             ), //o
    .reg_x_16                  (regfile_inst_reg_x_16[31:0]             ), //o
    .reg_x_17                  (regfile_inst_reg_x_17[31:0]             ), //o
    .reg_x_18                  (regfile_inst_reg_x_18[31:0]             ), //o
    .reg_x_19                  (regfile_inst_reg_x_19[31:0]             ), //o
    .reg_x_20                  (regfile_inst_reg_x_20[31:0]             ), //o
    .reg_x_21                  (regfile_inst_reg_x_21[31:0]             ), //o
    .reg_x_22                  (regfile_inst_reg_x_22[31:0]             ), //o
    .reg_x_23                  (regfile_inst_reg_x_23[31:0]             ), //o
    .reg_x_24                  (regfile_inst_reg_x_24[31:0]             ), //o
    .reg_x_25                  (regfile_inst_reg_x_25[31:0]             ), //o
    .reg_x_26                  (regfile_inst_reg_x_26[31:0]             ), //o
    .reg_x_27                  (regfile_inst_reg_x_27[31:0]             ), //o
    .reg_x_28                  (regfile_inst_reg_x_28[31:0]             ), //o
    .reg_x_29                  (regfile_inst_reg_x_29[31:0]             ), //o
    .reg_x_30                  (regfile_inst_reg_x_30[31:0]             ), //o
    .reg_x_31                  (regfile_inst_reg_x_31[31:0]             ), //o
    .clk                       (clk                                     ), //i
    .resetn                    (resetn                                  )  //i
  );
  alu alu_inst (
    .op_type               (s1_op_type_regs[5:0]                ), //i
    .oprand_vld_in         (s1_oprand_vld_out_regs              ), //i
    .voperand_in_vs1       (fd_ex_voperand_reg_in_vs1[127:0]    ), //i
    .voperand_in_vs2       (fd_ex_voperand_reg_in_vs2[127:0]    ), //i
    .voperand_in_vs1_index (fd_ex_voperand_reg_in_vs1_index[4:0]), //i
    .voperand_in_vs2_index (fd_ex_voperand_reg_in_vs2_index[4:0]), //i
    .roperand_in_rs1       (fd_ex_roperand_reg_in_rs1[31:0]     ), //i
    .roperand_in_rs1_index (fd_ex_roperand_reg_in_rs1_index[4:0]), //i
    .roperand_in_rs2       (fd_ex_roperand_reg_in_rs2[31:0]     ), //i
    .roperand_in_rs2_index (fd_ex_roperand_reg_in_rs2_index[4:0]), //i
    .roperand_in_rs3       (fd_ex_roperand_reg_in_rs3[31:0]     ), //i
    .roperand_in_rs3_index (fd_ex_roperand_reg_in_rs3_index[4:0]), //i
    .roperand_in_rd_index  (fd_ex_roperand_reg_in_rd_index[4:0] ), //i
    .alu_write_rd_data     (alu_inst_alu_write_rd_data[31:0]    ), //o
    .alu_write_rd_index    (alu_inst_alu_write_rd_index[4:0]    ), //o
    .alu_write_rd_vld      (alu_inst_alu_write_rd_vld           ), //o
    .is_branch_or_jump     (alu_inst_is_branch_or_jump          ), //i
    .pc_in                 (s1_pc_curr_reg[10:0]                ), //i
    .branch_taken_addr     (alu_inst_branch_taken_addr[10:0]    ), //o
    .branch_taken_vld      (alu_inst_branch_taken_vld           ), //o
    .result_vld_out        (alu_inst_result_vld_out             ), //o
    .to_lsu_addr           (alu_inst_to_lsu_addr[31:0]          ), //o
    .to_lsu_addr_vld       (alu_inst_to_lsu_addr_vld            ), //o
    .to_lsu_is_vector      (alu_inst_to_lsu_is_vector           ), //o
    .ebreak                (alu_inst_ebreak                     ), //o
    .clk                   (clk                                 ), //i
    .resetn                (resetn                              )  //i
  );
  lsu lsu_inst (
    .is_wstore                  (s1_dec_regs_is_wstore                     ), //i
    .is_wload                   (s1_dec_regs_is_wload                      ), //i
    .is_vload                   (s1_dec_regs_is_vload                      ), //i
    .is_vstore                  (lsu_inst_is_vstore                        ), //i
    .access_mem_vld             (to_lsu_addr_vld                           ), //i
    .access_mem_addr            (to_lsu_addr[31:0]                         ), //i
    .access_mem_wr_sdata        (lsu_inst_access_mem_wr_sdata[31:0]        ), //i
    .access_mem_wr_vdata        (s1_voperand_out_regs_vs2[127:0]           ), //i
    .rd_load_index_in           (s1_dec_regs_rd_index[4:0]                 ), //i
    .lsu_write_rd_data          (lsu_inst_lsu_write_rd_data[31:0]          ), //o
    .lsu_write_rd_index         (lsu_inst_lsu_write_rd_index[4:0]          ), //o
    .lsu_write_rd_vld           (lsu_inst_lsu_write_rd_vld                 ), //o
    .lsu_write_rd_is_vector     (lsu_inst_lsu_write_rd_is_vector           ), //o
    .lsu_write_rd_vector_data   (lsu_inst_lsu_write_rd_vector_data[127:0]  ), //o
    .highBandWidth_fb_mem_rd    (lsu_inst_highBandWidth_fb_mem_rd          ), //o
    .highBandWidth_fb_mem_wr    (lsu_inst_highBandWidth_fb_mem_wr          ), //o
    .highBandWidth_fb_mem_addr  (lsu_inst_highBandWidth_fb_mem_addr[6:0]   ), //o
    .highBandWidth_fb_mem_wdata (lsu_inst_highBandWidth_fb_mem_wdata[127:0]), //o
    .highBandWidth_fb_mem_rdata (highBandWidth_fb_mem_rdata[127:0]         ), //i
    .highBandWidth_a_mem_rd     (lsu_inst_highBandWidth_a_mem_rd           ), //o
    .highBandWidth_a_mem_wr     (lsu_inst_highBandWidth_a_mem_wr           ), //o
    .highBandWidth_a_mem_addr   (lsu_inst_highBandWidth_a_mem_addr[6:0]    ), //o
    .highBandWidth_a_mem_wdata  (lsu_inst_highBandWidth_a_mem_wdata[127:0] ), //o
    .highBandWidth_a_mem_rdata  (highBandWidth_a_mem_rdata[127:0]          ), //i
    .highBandWidth_w_mem_rd     (lsu_inst_highBandWidth_w_mem_rd           ), //o
    .highBandWidth_w_mem_wr     (lsu_inst_highBandWidth_w_mem_wr           ), //o
    .highBandWidth_w_mem_addr   (lsu_inst_highBandWidth_w_mem_addr[9:0]    ), //o
    .highBandWidth_w_mem_wdata  (lsu_inst_highBandWidth_w_mem_wdata[127:0] ), //o
    .highBandWidth_w_mem_rdata  (highBandWidth_w_mem_rdata[127:0]          ), //i
    .lowBandWidth_mem_rd        (lsu_inst_lowBandWidth_mem_rd              ), //o
    .lowBandWidth_mem_wr        (lsu_inst_lowBandWidth_mem_wr              ), //o
    .lowBandWidth_mem_addr      (lsu_inst_lowBandWidth_mem_addr[6:0]       ), //o
    .lowBandWidth_mem_wdata     (lsu_inst_lowBandWidth_mem_wdata[31:0]     ), //o
    .lowBandWidth_mem_rdata     (lowBandWidth_mem_rdata[31:0]              ), //i
    .clk                        (clk                                       ), //i
    .resetn                     (resetn                                    )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(op_type)
      ILLEGAL : op_type_string = "ILLEGAL ";
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
      BLTZ : op_type_string = "BLTZ    ";
      MV : op_type_string = "MV      ";
      EBREAK : op_type_string = "EBREAK  ";
      MVIMMX4 : op_type_string = "MVIMMX4 ";
      VMUL_SUM : op_type_string = "VMUL_SUM";
      FXMUL : op_type_string = "FXMUL   ";
      DIV : op_type_string = "DIV     ";
      VMAC8 : op_type_string = "VMAC8   ";
      FMSR : op_type_string = "FMSR    ";
      MAX : op_type_string = "MAX     ";
      MIN : op_type_string = "MIN     ";
      ADDX : op_type_string = "ADDX    ";
      SUBX : op_type_string = "SUBX    ";
      SKIPADD : op_type_string = "SKIPADD ";
      MVX : op_type_string = "MVX     ";
      ADDI4SPN : op_type_string = "ADDI4SPN";
      ADDI : op_type_string = "ADDI    ";
      ADD : op_type_string = "ADD     ";
      SUB : op_type_string = "SUB     ";
      LUIH8 : op_type_string = "LUIH8   ";
      LUIL8 : op_type_string = "LUIL8   ";
      SRLI : op_type_string = "SRLI    ";
      SRAI : op_type_string = "SRAI    ";
      SRL_1 : op_type_string = "SRL_1   ";
      SLLI : op_type_string = "SLLI    ";
      SLL_1 : op_type_string = "SLL_1   ";
      default : op_type_string = "????????";
    endcase
  end
  always @(*) begin
    case(s1_op_type_regs)
      ILLEGAL : s1_op_type_regs_string = "ILLEGAL ";
      NOP : s1_op_type_regs_string = "NOP     ";
      LW : s1_op_type_regs_string = "LW      ";
      LV : s1_op_type_regs_string = "LV      ";
      SW : s1_op_type_regs_string = "SW      ";
      SV1 : s1_op_type_regs_string = "SV1     ";
      SV2 : s1_op_type_regs_string = "SV2     ";
      J : s1_op_type_regs_string = "J       ";
      JAL : s1_op_type_regs_string = "JAL     ";
      JR : s1_op_type_regs_string = "JR      ";
      BEQZ : s1_op_type_regs_string = "BEQZ    ";
      BNEZ : s1_op_type_regs_string = "BNEZ    ";
      BLTZ : s1_op_type_regs_string = "BLTZ    ";
      MV : s1_op_type_regs_string = "MV      ";
      EBREAK : s1_op_type_regs_string = "EBREAK  ";
      MVIMMX4 : s1_op_type_regs_string = "MVIMMX4 ";
      VMUL_SUM : s1_op_type_regs_string = "VMUL_SUM";
      FXMUL : s1_op_type_regs_string = "FXMUL   ";
      DIV : s1_op_type_regs_string = "DIV     ";
      VMAC8 : s1_op_type_regs_string = "VMAC8   ";
      FMSR : s1_op_type_regs_string = "FMSR    ";
      MAX : s1_op_type_regs_string = "MAX     ";
      MIN : s1_op_type_regs_string = "MIN     ";
      ADDX : s1_op_type_regs_string = "ADDX    ";
      SUBX : s1_op_type_regs_string = "SUBX    ";
      SKIPADD : s1_op_type_regs_string = "SKIPADD ";
      MVX : s1_op_type_regs_string = "MVX     ";
      ADDI4SPN : s1_op_type_regs_string = "ADDI4SPN";
      ADDI : s1_op_type_regs_string = "ADDI    ";
      ADD : s1_op_type_regs_string = "ADD     ";
      SUB : s1_op_type_regs_string = "SUB     ";
      LUIH8 : s1_op_type_regs_string = "LUIH8   ";
      LUIL8 : s1_op_type_regs_string = "LUIL8   ";
      SRLI : s1_op_type_regs_string = "SRLI    ";
      SRAI : s1_op_type_regs_string = "SRAI    ";
      SRL_1 : s1_op_type_regs_string = "SRL_1   ";
      SLLI : s1_op_type_regs_string = "SLLI    ";
      SLL_1 : s1_op_type_regs_string = "SLL_1   ";
      default : s1_op_type_regs_string = "????????";
    endcase
  end
  always @(*) begin
    case(tmp_s1_op_type_regs)
      ILLEGAL : tmp_s1_op_type_regs_string = "ILLEGAL ";
      NOP : tmp_s1_op_type_regs_string = "NOP     ";
      LW : tmp_s1_op_type_regs_string = "LW      ";
      LV : tmp_s1_op_type_regs_string = "LV      ";
      SW : tmp_s1_op_type_regs_string = "SW      ";
      SV1 : tmp_s1_op_type_regs_string = "SV1     ";
      SV2 : tmp_s1_op_type_regs_string = "SV2     ";
      J : tmp_s1_op_type_regs_string = "J       ";
      JAL : tmp_s1_op_type_regs_string = "JAL     ";
      JR : tmp_s1_op_type_regs_string = "JR      ";
      BEQZ : tmp_s1_op_type_regs_string = "BEQZ    ";
      BNEZ : tmp_s1_op_type_regs_string = "BNEZ    ";
      BLTZ : tmp_s1_op_type_regs_string = "BLTZ    ";
      MV : tmp_s1_op_type_regs_string = "MV      ";
      EBREAK : tmp_s1_op_type_regs_string = "EBREAK  ";
      MVIMMX4 : tmp_s1_op_type_regs_string = "MVIMMX4 ";
      VMUL_SUM : tmp_s1_op_type_regs_string = "VMUL_SUM";
      FXMUL : tmp_s1_op_type_regs_string = "FXMUL   ";
      DIV : tmp_s1_op_type_regs_string = "DIV     ";
      VMAC8 : tmp_s1_op_type_regs_string = "VMAC8   ";
      FMSR : tmp_s1_op_type_regs_string = "FMSR    ";
      MAX : tmp_s1_op_type_regs_string = "MAX     ";
      MIN : tmp_s1_op_type_regs_string = "MIN     ";
      ADDX : tmp_s1_op_type_regs_string = "ADDX    ";
      SUBX : tmp_s1_op_type_regs_string = "SUBX    ";
      SKIPADD : tmp_s1_op_type_regs_string = "SKIPADD ";
      MVX : tmp_s1_op_type_regs_string = "MVX     ";
      ADDI4SPN : tmp_s1_op_type_regs_string = "ADDI4SPN";
      ADDI : tmp_s1_op_type_regs_string = "ADDI    ";
      ADD : tmp_s1_op_type_regs_string = "ADD     ";
      SUB : tmp_s1_op_type_regs_string = "SUB     ";
      LUIH8 : tmp_s1_op_type_regs_string = "LUIH8   ";
      LUIL8 : tmp_s1_op_type_regs_string = "LUIL8   ";
      SRLI : tmp_s1_op_type_regs_string = "SRLI    ";
      SRAI : tmp_s1_op_type_regs_string = "SRAI    ";
      SRL_1 : tmp_s1_op_type_regs_string = "SRL_1   ";
      SLLI : tmp_s1_op_type_regs_string = "SLLI    ";
      SLL_1 : tmp_s1_op_type_regs_string = "SLL_1   ";
      default : tmp_s1_op_type_regs_string = "????????";
    endcase
  end
  always @(*) begin
    case(tmp_s1_op_type_regs_1)
      ILLEGAL : tmp_s1_op_type_regs_1_string = "ILLEGAL ";
      NOP : tmp_s1_op_type_regs_1_string = "NOP     ";
      LW : tmp_s1_op_type_regs_1_string = "LW      ";
      LV : tmp_s1_op_type_regs_1_string = "LV      ";
      SW : tmp_s1_op_type_regs_1_string = "SW      ";
      SV1 : tmp_s1_op_type_regs_1_string = "SV1     ";
      SV2 : tmp_s1_op_type_regs_1_string = "SV2     ";
      J : tmp_s1_op_type_regs_1_string = "J       ";
      JAL : tmp_s1_op_type_regs_1_string = "JAL     ";
      JR : tmp_s1_op_type_regs_1_string = "JR      ";
      BEQZ : tmp_s1_op_type_regs_1_string = "BEQZ    ";
      BNEZ : tmp_s1_op_type_regs_1_string = "BNEZ    ";
      BLTZ : tmp_s1_op_type_regs_1_string = "BLTZ    ";
      MV : tmp_s1_op_type_regs_1_string = "MV      ";
      EBREAK : tmp_s1_op_type_regs_1_string = "EBREAK  ";
      MVIMMX4 : tmp_s1_op_type_regs_1_string = "MVIMMX4 ";
      VMUL_SUM : tmp_s1_op_type_regs_1_string = "VMUL_SUM";
      FXMUL : tmp_s1_op_type_regs_1_string = "FXMUL   ";
      DIV : tmp_s1_op_type_regs_1_string = "DIV     ";
      VMAC8 : tmp_s1_op_type_regs_1_string = "VMAC8   ";
      FMSR : tmp_s1_op_type_regs_1_string = "FMSR    ";
      MAX : tmp_s1_op_type_regs_1_string = "MAX     ";
      MIN : tmp_s1_op_type_regs_1_string = "MIN     ";
      ADDX : tmp_s1_op_type_regs_1_string = "ADDX    ";
      SUBX : tmp_s1_op_type_regs_1_string = "SUBX    ";
      SKIPADD : tmp_s1_op_type_regs_1_string = "SKIPADD ";
      MVX : tmp_s1_op_type_regs_1_string = "MVX     ";
      ADDI4SPN : tmp_s1_op_type_regs_1_string = "ADDI4SPN";
      ADDI : tmp_s1_op_type_regs_1_string = "ADDI    ";
      ADD : tmp_s1_op_type_regs_1_string = "ADD     ";
      SUB : tmp_s1_op_type_regs_1_string = "SUB     ";
      LUIH8 : tmp_s1_op_type_regs_1_string = "LUIH8   ";
      LUIL8 : tmp_s1_op_type_regs_1_string = "LUIL8   ";
      SRLI : tmp_s1_op_type_regs_1_string = "SRLI    ";
      SRAI : tmp_s1_op_type_regs_1_string = "SRAI    ";
      SRL_1 : tmp_s1_op_type_regs_1_string = "SRL_1   ";
      SLLI : tmp_s1_op_type_regs_1_string = "SLLI    ";
      SLL_1 : tmp_s1_op_type_regs_1_string = "SLL_1   ";
      default : tmp_s1_op_type_regs_1_string = "????????";
    endcase
  end
  `endif

  assign tmp_129 = ({127'd0,1'b1} <<< lowBandWidth_mem_addr[6 : 0]);
  assign iram_mem_rd = fetcher_inst_imem_rd;
  assign iram_mem_addr = fetcher_inst_imem_addr;
  assign pc_curr = fetcher_inst_pc_curr;
  assign debug_break = ((debug_break_point == fetcher_inst_imem_addr) && debug_en);
  assign iram_mem_wr = 1'b0;
  assign iram_mem_wdata = 16'h0000;
  assign op_type = decode_inst_op_type;
  assign dec_info_vld = decode_inst_dec_info_vld;
  assign dec_rs1_index = decode_inst_dec_rs1_index;
  assign dec_rs2_index = decode_inst_dec_rs2_index;
  assign dec_rs3_index = decode_inst_dec_rs3_index;
  assign dec_rd_index = decode_inst_dec_rd_index;
  assign dec_imm = decode_inst_dec_imm;
  assign dec_imm_is_rs2 = decode_inst_dec_imm_is_rs2;
  assign dec_is_jump = decode_inst_dec_is_jump;
  assign dec_is_branch = decode_inst_dec_is_branch;
  assign dec_is_wload = decode_inst_dec_is_wload;
  assign dec_is_wstore = decode_inst_dec_is_wstore;
  assign dec_is_multi_rs1_index = decode_inst_dec_is_multi_rs1_index;
  assign dec_is_multi_rd_index = decode_inst_dec_is_multi_rd_index;
  assign dec_is_vector_oprand_used = decode_inst_dec_is_vector_oprand_used;
  assign dec_is_vload = decode_inst_dec_is_vload;
  assign dec_is_vstore1 = decode_inst_dec_is_vstore1;
  assign dec_is_vstore2 = decode_inst_dec_is_vstore2;
  assign fetch_break = ((((((op_type == EBREAK) || (op_type == FXMUL)) || (op_type == DIV)) || (op_type == FMSR)) || (op_type == SKIPADD)) || debug_break);
  assign x_0 = regfile_inst_reg_x_0;
  assign x_1 = regfile_inst_reg_x_1;
  assign x_2 = regfile_inst_reg_x_2;
  assign x_3 = regfile_inst_reg_x_3;
  assign x_4 = regfile_inst_reg_x_4;
  assign x_5 = regfile_inst_reg_x_5;
  assign x_6 = regfile_inst_reg_x_6;
  assign x_7 = regfile_inst_reg_x_7;
  assign x_8 = regfile_inst_reg_x_8;
  assign x_9 = regfile_inst_reg_x_9;
  assign x_10 = regfile_inst_reg_x_10;
  assign x_11 = regfile_inst_reg_x_11;
  assign x_12 = regfile_inst_reg_x_12;
  assign x_13 = regfile_inst_reg_x_13;
  assign x_14 = regfile_inst_reg_x_14;
  assign x_15 = regfile_inst_reg_x_15;
  assign x_16 = regfile_inst_reg_x_16;
  assign x_17 = regfile_inst_reg_x_17;
  assign x_18 = regfile_inst_reg_x_18;
  assign x_19 = regfile_inst_reg_x_19;
  assign x_20 = regfile_inst_reg_x_20;
  assign x_21 = regfile_inst_reg_x_21;
  assign x_22 = regfile_inst_reg_x_22;
  assign x_23 = regfile_inst_reg_x_23;
  assign x_24 = regfile_inst_reg_x_24;
  assign x_25 = regfile_inst_reg_x_25;
  assign x_26 = regfile_inst_reg_x_26;
  assign x_27 = regfile_inst_reg_x_27;
  assign x_28 = regfile_inst_reg_x_28;
  assign x_29 = regfile_inst_reg_x_29;
  assign x_30 = regfile_inst_reg_x_30;
  assign x_31 = regfile_inst_reg_x_31;
  assign forwarding_id_ld_rs1 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == regfile_inst_roperand_out_rs1_index));
  assign forwarding_id_ld_rs2 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == regfile_inst_roperand_out_rs2_index));
  assign forwarding_id_ld_rs3 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == regfile_inst_roperand_out_rs3_index));
  assign forwarding_id_ld_vs1 = ((lsu_write_rd_vld && lsu_write_rd_is_vector) && (lsu_write_rd_index == regfile_inst_voperand_out_vs1_index));
  assign forwarding_id_ld_vs2 = ((lsu_write_rd_vld && lsu_write_rd_is_vector) && (lsu_write_rd_index == regfile_inst_voperand_out_vs2_index));
  assign forwarding_alu_rs1 = (alu_write_rd_vld && (alu_write_rd_index == regfile_inst_roperand_out_rs1_index));
  assign forwarding_alu_rs2 = (alu_write_rd_vld && (alu_write_rd_index == regfile_inst_roperand_out_rs2_index));
  assign forwarding_alu_rs3 = (alu_write_rd_vld && (alu_write_rd_index == regfile_inst_roperand_out_rs3_index));
  assign fd_id_roperand_reg_in_rs1 = (forwarding_alu_rs1 ? alu_write_rd_data : (forwarding_id_ld_rs1 ? lsu_write_rd_data : regfile_inst_roperand_out_rs1));
  assign fd_id_roperand_reg_in_rs2 = (forwarding_alu_rs2 ? alu_write_rd_data : (forwarding_id_ld_rs2 ? lsu_write_rd_data : regfile_inst_roperand_out_rs2));
  assign fd_id_roperand_reg_in_rs3 = (forwarding_alu_rs3 ? alu_write_rd_data : (forwarding_id_ld_rs3 ? lsu_write_rd_data : regfile_inst_roperand_out_rs3));
  assign fd_id_roperand_reg_in_rs1_index = regfile_inst_roperand_out_rs1_index;
  assign fd_id_roperand_reg_in_rs2_index = regfile_inst_roperand_out_rs2_index;
  assign fd_id_roperand_reg_in_rs3_index = regfile_inst_roperand_out_rs3_index;
  assign fd_id_roperand_reg_in_rd_index = regfile_inst_roperand_out_rd_index;
  assign fd_id_voperand_reg_in_vs2 = (forwarding_id_ld_vs2 ? lsu_write_rd_vector_data : regfile_inst_voperand_out_vs2);
  assign fd_id_voperand_reg_in_vs1 = (forwarding_id_ld_vs1 ? lsu_write_rd_vector_data : regfile_inst_voperand_out_vs1);
  assign fd_id_voperand_reg_in_vs1_index = regfile_inst_voperand_out_vs1_index;
  assign fd_id_voperand_reg_in_vs2_index = regfile_inst_voperand_out_vs2_index;
  assign forwarding_id_ex_rs1 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == s1_roperand_out_regs_rs1_index));
  assign forwarding_id_ex_rs2 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == s1_roperand_out_regs_rs2_index));
  assign forwarding_id_ex_rs3 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == s1_roperand_out_regs_rs3_index));
  assign fd_ex_roperand_reg_in_rs1 = (forwarding_id_ex_rs1 ? lsu_write_rd_data : s1_roperand_out_regs_rs1);
  assign fd_ex_roperand_reg_in_rs2 = (forwarding_id_ex_rs2 ? lsu_write_rd_data : s1_roperand_out_regs_rs2);
  assign fd_ex_roperand_reg_in_rs3 = (forwarding_id_ex_rs3 ? lsu_write_rd_data : s1_roperand_out_regs_rs3);
  assign fd_ex_roperand_reg_in_rs1_index = s1_roperand_out_regs_rs1_index;
  assign fd_ex_roperand_reg_in_rs2_index = s1_roperand_out_regs_rs2_index;
  assign fd_ex_roperand_reg_in_rs3_index = s1_roperand_out_regs_rs3_index;
  assign fd_ex_roperand_reg_in_rd_index = s1_roperand_out_regs_rd_index;
  assign fd_ex_voperand_reg_in_vs2 = s1_voperand_out_regs_vs2;
  assign fd_ex_voperand_reg_in_vs1 = s1_voperand_out_regs_vs1;
  assign fd_ex_voperand_reg_in_vs1_index = s1_voperand_out_regs_vs1_index;
  assign fd_ex_voperand_reg_in_vs2_index = s1_voperand_out_regs_vs2_index;
  assign tmp_s1_op_type_regs_1 = 6'h00;
  assign tmp_s1_op_type_regs = tmp_s1_op_type_regs_1;
  assign alu_inst_is_branch_or_jump = (s1_dec_regs_is_branch || s1_dec_regs_is_jump);
  assign branch_taken_addr = alu_inst_branch_taken_addr;
  assign branch_taken_vld = alu_inst_branch_taken_vld;
  assign alu_write_rd_data = alu_inst_alu_write_rd_data;
  assign alu_write_rd_index = alu_inst_alu_write_rd_index;
  assign alu_write_rd_vld = alu_inst_alu_write_rd_vld;
  assign result_vld_out = alu_inst_result_vld_out;
  assign to_lsu_addr = alu_inst_to_lsu_addr;
  assign to_lsu_addr_vld = alu_inst_to_lsu_addr_vld;
  assign to_lsu_is_vector = alu_inst_to_lsu_is_vector;
  assign core_end = alu_inst_ebreak;
  assign fetch_restore = (((! fetcher_inst_instr_valid) && result_vld_out) || ((! debug_en) && debug_en_regNext));
  assign lsu_inst_is_vstore = (s1_dec_regs_is_vstore1 || s1_dec_regs_is_vstore2);
  assign highBandWidth_fb_mem_rd = lsu_inst_highBandWidth_fb_mem_rd;
  assign highBandWidth_fb_mem_wr = lsu_inst_highBandWidth_fb_mem_wr;
  assign highBandWidth_fb_mem_addr = lsu_inst_highBandWidth_fb_mem_addr;
  assign highBandWidth_fb_mem_wdata = lsu_inst_highBandWidth_fb_mem_wdata;
  assign highBandWidth_a_mem_rd = lsu_inst_highBandWidth_a_mem_rd;
  assign highBandWidth_a_mem_wr = lsu_inst_highBandWidth_a_mem_wr;
  assign highBandWidth_a_mem_addr = lsu_inst_highBandWidth_a_mem_addr;
  assign highBandWidth_a_mem_wdata = lsu_inst_highBandWidth_a_mem_wdata;
  assign highBandWidth_w_mem_rd = lsu_inst_highBandWidth_w_mem_rd;
  assign highBandWidth_w_mem_wr = lsu_inst_highBandWidth_w_mem_wr;
  assign highBandWidth_w_mem_addr = lsu_inst_highBandWidth_w_mem_addr;
  assign highBandWidth_w_mem_wdata = lsu_inst_highBandWidth_w_mem_wdata;
  assign lowBandWidth_mem_rd = lsu_inst_lowBandWidth_mem_rd;
  assign lowBandWidth_mem_wr = lsu_inst_lowBandWidth_mem_wr;
  assign lowBandWidth_mem_addr = lsu_inst_lowBandWidth_mem_addr;
  assign lowBandWidth_mem_wdata = lsu_inst_lowBandWidth_mem_wdata;
  assign lsu_inst_access_mem_wr_sdata = (forwarding_alu_rs3 ? alu_write_rd_data : ((forwarding_id_ld_rs3 || forwarding_id_ex_rs3) ? lsu_write_rd_data : s1_roperand_out_regs_rs3));
  assign lsu_write_rd_data = lsu_inst_lsu_write_rd_data;
  assign lsu_write_rd_index = lsu_inst_lsu_write_rd_index;
  assign lsu_write_rd_vld = lsu_inst_lsu_write_rd_vld;
  assign lsu_write_rd_is_vector = lsu_inst_lsu_write_rd_is_vector;
  assign lsu_write_rd_vector_data = lsu_inst_lsu_write_rd_vector_data;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      tmp_1 <= 32'h00000000;
      tmp_2 <= 32'h00000000;
      tmp_3 <= 32'h00000000;
      tmp_4 <= 32'h00000000;
      tmp_5 <= 32'h00000000;
      tmp_6 <= 32'h00000000;
      tmp_7 <= 32'h00000000;
      tmp_8 <= 32'h00000000;
      tmp_9 <= 32'h00000000;
      tmp_10 <= 32'h00000000;
      tmp_11 <= 32'h00000000;
      tmp_12 <= 32'h00000000;
      tmp_13 <= 32'h00000000;
      tmp_14 <= 32'h00000000;
      tmp_15 <= 32'h00000000;
      tmp_16 <= 32'h00000000;
      tmp_17 <= 32'h00000000;
      tmp_18 <= 32'h00000000;
      tmp_19 <= 32'h00000000;
      tmp_20 <= 32'h00000000;
      tmp_21 <= 32'h00000000;
      tmp_22 <= 32'h00000000;
      tmp_23 <= 32'h00000000;
      tmp_24 <= 32'h00000000;
      tmp_25 <= 32'h00000000;
      tmp_26 <= 32'h00000000;
      tmp_27 <= 32'h00000000;
      tmp_28 <= 32'h00000000;
      tmp_29 <= 32'h00000000;
      tmp_30 <= 32'h00000000;
      tmp_31 <= 32'h00000000;
      tmp_32 <= 32'h00000000;
      tmp_33 <= 32'h00000000;
      tmp_34 <= 32'h00000000;
      tmp_35 <= 32'h00000000;
      tmp_36 <= 32'h00000000;
      tmp_37 <= 32'h00000000;
      tmp_38 <= 32'h00000000;
      tmp_39 <= 32'h00000000;
      tmp_40 <= 32'h00000000;
      tmp_41 <= 32'h00000000;
      tmp_42 <= 32'h00000000;
      tmp_43 <= 32'h00000000;
      tmp_44 <= 32'h00000000;
      tmp_45 <= 32'h00000000;
      tmp_46 <= 32'h00000000;
      tmp_47 <= 32'h00000000;
      tmp_48 <= 32'h00000000;
      tmp_49 <= 32'h00000000;
      tmp_50 <= 32'h00000000;
      tmp_51 <= 32'h00000000;
      tmp_52 <= 32'h00000000;
      tmp_53 <= 32'h00000000;
      tmp_54 <= 32'h00000000;
      tmp_55 <= 32'h00000000;
      tmp_56 <= 32'h00000000;
      tmp_57 <= 32'h00000000;
      tmp_58 <= 32'h00000000;
      tmp_59 <= 32'h00000000;
      tmp_60 <= 32'h00000000;
      tmp_61 <= 32'h00000000;
      tmp_62 <= 32'h00000000;
      tmp_63 <= 32'h00000000;
      tmp_64 <= 32'h00000000;
      tmp_65 <= 32'h00000000;
      tmp_66 <= 32'h00000000;
      tmp_67 <= 32'h00000000;
      tmp_68 <= 32'h00000000;
      tmp_69 <= 32'h00000000;
      tmp_70 <= 32'h00000000;
      tmp_71 <= 32'h00000000;
      tmp_72 <= 32'h00000000;
      tmp_73 <= 32'h00000000;
      tmp_74 <= 32'h00000000;
      tmp_75 <= 32'h00000000;
      tmp_76 <= 32'h00000000;
      tmp_77 <= 32'h00000000;
      tmp_78 <= 32'h00000000;
      tmp_79 <= 32'h00000000;
      tmp_80 <= 32'h00000000;
      tmp_81 <= 32'h00000000;
      tmp_82 <= 32'h00000000;
      tmp_83 <= 32'h00000000;
      tmp_84 <= 32'h00000000;
      tmp_85 <= 32'h00000000;
      tmp_86 <= 32'h00000000;
      tmp_87 <= 32'h00000000;
      tmp_88 <= 32'h00000000;
      tmp_89 <= 32'h00000000;
      tmp_90 <= 32'h00000000;
      tmp_91 <= 32'h00000000;
      tmp_92 <= 32'h00000000;
      tmp_93 <= 32'h00000000;
      tmp_94 <= 32'h00000000;
      tmp_95 <= 32'h00000000;
      tmp_96 <= 32'h00000000;
      tmp_97 <= 32'h00000000;
      tmp_98 <= 32'h00000000;
      tmp_99 <= 32'h00000000;
      tmp_100 <= 32'h00000000;
      tmp_101 <= 32'h00000000;
      tmp_102 <= 32'h00000000;
      tmp_103 <= 32'h00000000;
      tmp_104 <= 32'h00000000;
      tmp_105 <= 32'h00000000;
      tmp_106 <= 32'h00000000;
      tmp_107 <= 32'h00000000;
      tmp_108 <= 32'h00000000;
      tmp_109 <= 32'h00000000;
      tmp_110 <= 32'h00000000;
      tmp_111 <= 32'h00000000;
      tmp_112 <= 32'h00000000;
      tmp_113 <= 32'h00000000;
      tmp_114 <= 32'h00000000;
      tmp_115 <= 32'h00000000;
      tmp_116 <= 32'h00000000;
      tmp_117 <= 32'h00000000;
      tmp_118 <= 32'h00000000;
      tmp_119 <= 32'h00000000;
      tmp_120 <= 32'h00000000;
      tmp_121 <= 32'h00000000;
      tmp_122 <= 32'h00000000;
      tmp_123 <= 32'h00000000;
      tmp_124 <= 32'h00000000;
      tmp_125 <= 32'h00000000;
      tmp_126 <= 32'h00000000;
      tmp_127 <= 32'h00000000;
      tmp_128 <= 32'h00000000;
      s1_oprand_vld_out_regs <= 1'b0;
      s1_op_type_regs <= ILLEGAL;
      s1_pc_curr_reg <= 11'h098;
      s1_roperand_out_regs_rs1 <= 32'h00000000;
      s1_roperand_out_regs_rs1_index <= 5'h00;
      s1_roperand_out_regs_rs2 <= 32'h00000000;
      s1_roperand_out_regs_rs2_index <= 5'h00;
      s1_roperand_out_regs_rs3 <= 32'h00000000;
      s1_roperand_out_regs_rs3_index <= 5'h00;
      s1_roperand_out_regs_rd_index <= 5'h00;
      s1_voperand_out_regs_vs1 <= 128'h00000000000000000000000000000000;
      s1_voperand_out_regs_vs2 <= 128'h00000000000000000000000000000000;
      s1_voperand_out_regs_vs1_index <= 5'h00;
      s1_voperand_out_regs_vs2_index <= 5'h00;
      s1_dec_regs_rs1_index <= 5'h00;
      s1_dec_regs_rs2_index <= 5'h00;
      s1_dec_regs_rs3_index <= 5'h00;
      s1_dec_regs_rd_index <= 5'h00;
      s1_dec_regs_imm <= 32'h00000000;
      s1_dec_regs_imm_is_rs2 <= 1'b0;
      s1_dec_regs_is_jump <= 1'b0;
      s1_dec_regs_is_branch <= 1'b0;
      s1_dec_regs_is_wload <= 1'b0;
      s1_dec_regs_is_wstore <= 1'b0;
      s1_dec_regs_is_multi_rs1_index <= 1'b0;
      s1_dec_regs_is_multi_rd_index <= 1'b0;
      s1_dec_regs_is_vector_oprand_used <= 1'b0;
      s1_dec_regs_is_vload <= 1'b0;
      s1_dec_regs_is_vstore1 <= 1'b0;
      s1_dec_regs_is_vstore2 <= 1'b0;
    end else begin
      if(lowBandWidth_mem_wr) begin
        if(tmp_129[0]) begin
          tmp_1 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[1]) begin
          tmp_2 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[2]) begin
          tmp_3 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[3]) begin
          tmp_4 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[4]) begin
          tmp_5 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[5]) begin
          tmp_6 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[6]) begin
          tmp_7 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[7]) begin
          tmp_8 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[8]) begin
          tmp_9 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[9]) begin
          tmp_10 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[10]) begin
          tmp_11 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[11]) begin
          tmp_12 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[12]) begin
          tmp_13 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[13]) begin
          tmp_14 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[14]) begin
          tmp_15 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[15]) begin
          tmp_16 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[16]) begin
          tmp_17 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[17]) begin
          tmp_18 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[18]) begin
          tmp_19 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[19]) begin
          tmp_20 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[20]) begin
          tmp_21 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[21]) begin
          tmp_22 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[22]) begin
          tmp_23 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[23]) begin
          tmp_24 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[24]) begin
          tmp_25 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[25]) begin
          tmp_26 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[26]) begin
          tmp_27 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[27]) begin
          tmp_28 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[28]) begin
          tmp_29 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[29]) begin
          tmp_30 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[30]) begin
          tmp_31 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[31]) begin
          tmp_32 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[32]) begin
          tmp_33 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[33]) begin
          tmp_34 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[34]) begin
          tmp_35 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[35]) begin
          tmp_36 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[36]) begin
          tmp_37 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[37]) begin
          tmp_38 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[38]) begin
          tmp_39 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[39]) begin
          tmp_40 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[40]) begin
          tmp_41 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[41]) begin
          tmp_42 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[42]) begin
          tmp_43 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[43]) begin
          tmp_44 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[44]) begin
          tmp_45 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[45]) begin
          tmp_46 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[46]) begin
          tmp_47 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[47]) begin
          tmp_48 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[48]) begin
          tmp_49 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[49]) begin
          tmp_50 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[50]) begin
          tmp_51 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[51]) begin
          tmp_52 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[52]) begin
          tmp_53 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[53]) begin
          tmp_54 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[54]) begin
          tmp_55 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[55]) begin
          tmp_56 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[56]) begin
          tmp_57 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[57]) begin
          tmp_58 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[58]) begin
          tmp_59 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[59]) begin
          tmp_60 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[60]) begin
          tmp_61 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[61]) begin
          tmp_62 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[62]) begin
          tmp_63 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[63]) begin
          tmp_64 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[64]) begin
          tmp_65 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[65]) begin
          tmp_66 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[66]) begin
          tmp_67 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[67]) begin
          tmp_68 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[68]) begin
          tmp_69 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[69]) begin
          tmp_70 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[70]) begin
          tmp_71 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[71]) begin
          tmp_72 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[72]) begin
          tmp_73 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[73]) begin
          tmp_74 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[74]) begin
          tmp_75 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[75]) begin
          tmp_76 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[76]) begin
          tmp_77 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[77]) begin
          tmp_78 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[78]) begin
          tmp_79 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[79]) begin
          tmp_80 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[80]) begin
          tmp_81 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[81]) begin
          tmp_82 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[82]) begin
          tmp_83 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[83]) begin
          tmp_84 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[84]) begin
          tmp_85 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[85]) begin
          tmp_86 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[86]) begin
          tmp_87 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[87]) begin
          tmp_88 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[88]) begin
          tmp_89 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[89]) begin
          tmp_90 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[90]) begin
          tmp_91 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[91]) begin
          tmp_92 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[92]) begin
          tmp_93 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[93]) begin
          tmp_94 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[94]) begin
          tmp_95 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[95]) begin
          tmp_96 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[96]) begin
          tmp_97 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[97]) begin
          tmp_98 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[98]) begin
          tmp_99 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[99]) begin
          tmp_100 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[100]) begin
          tmp_101 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[101]) begin
          tmp_102 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[102]) begin
          tmp_103 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[103]) begin
          tmp_104 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[104]) begin
          tmp_105 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[105]) begin
          tmp_106 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[106]) begin
          tmp_107 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[107]) begin
          tmp_108 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[108]) begin
          tmp_109 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[109]) begin
          tmp_110 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[110]) begin
          tmp_111 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[111]) begin
          tmp_112 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[112]) begin
          tmp_113 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[113]) begin
          tmp_114 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[114]) begin
          tmp_115 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[115]) begin
          tmp_116 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[116]) begin
          tmp_117 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[117]) begin
          tmp_118 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[118]) begin
          tmp_119 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[119]) begin
          tmp_120 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[120]) begin
          tmp_121 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[121]) begin
          tmp_122 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[122]) begin
          tmp_123 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[123]) begin
          tmp_124 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[124]) begin
          tmp_125 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[125]) begin
          tmp_126 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[126]) begin
          tmp_127 <= lowBandWidth_mem_wdata;
        end
        if(tmp_129[127]) begin
          tmp_128 <= lowBandWidth_mem_wdata;
        end
      end
      if(branch_taken_vld) begin
        s1_roperand_out_regs_rs1 <= 32'h00000000;
        s1_roperand_out_regs_rs1_index <= 5'h00;
        s1_roperand_out_regs_rs2 <= 32'h00000000;
        s1_roperand_out_regs_rs2_index <= 5'h00;
        s1_roperand_out_regs_rs3 <= 32'h00000000;
        s1_roperand_out_regs_rs3_index <= 5'h00;
        s1_roperand_out_regs_rd_index <= 5'h00;
        s1_voperand_out_regs_vs1 <= 128'h00000000000000000000000000000000;
        s1_voperand_out_regs_vs2 <= 128'h00000000000000000000000000000000;
        s1_voperand_out_regs_vs1_index <= 5'h00;
        s1_voperand_out_regs_vs2_index <= 5'h00;
        s1_oprand_vld_out_regs <= 1'b0;
        s1_dec_regs_rs1_index <= 5'h00;
        s1_dec_regs_rs2_index <= 5'h00;
        s1_dec_regs_rs3_index <= 5'h00;
        s1_dec_regs_rd_index <= 5'h00;
        s1_dec_regs_imm <= 32'h00000000;
        s1_dec_regs_imm_is_rs2 <= 1'b0;
        s1_dec_regs_is_jump <= 1'b0;
        s1_dec_regs_is_branch <= 1'b0;
        s1_dec_regs_is_wload <= 1'b0;
        s1_dec_regs_is_wstore <= 1'b0;
        s1_dec_regs_is_multi_rs1_index <= 1'b0;
        s1_dec_regs_is_multi_rd_index <= 1'b0;
        s1_dec_regs_is_vector_oprand_used <= 1'b0;
        s1_dec_regs_is_vload <= 1'b0;
        s1_dec_regs_is_vstore1 <= 1'b0;
        s1_dec_regs_is_vstore2 <= 1'b0;
        s1_op_type_regs <= tmp_s1_op_type_regs;
      end else begin
        if(dec_info_vld) begin
          s1_roperand_out_regs_rs1 <= fd_id_roperand_reg_in_rs1;
          s1_roperand_out_regs_rs1_index <= fd_id_roperand_reg_in_rs1_index;
          s1_roperand_out_regs_rs2 <= fd_id_roperand_reg_in_rs2;
          s1_roperand_out_regs_rs2_index <= fd_id_roperand_reg_in_rs2_index;
          s1_roperand_out_regs_rs3 <= fd_id_roperand_reg_in_rs3;
          s1_roperand_out_regs_rs3_index <= fd_id_roperand_reg_in_rs3_index;
          s1_roperand_out_regs_rd_index <= fd_id_roperand_reg_in_rd_index;
          s1_voperand_out_regs_vs1 <= fd_id_voperand_reg_in_vs1;
          s1_voperand_out_regs_vs2 <= fd_id_voperand_reg_in_vs2;
          s1_voperand_out_regs_vs1_index <= fd_id_voperand_reg_in_vs1_index;
          s1_voperand_out_regs_vs2_index <= fd_id_voperand_reg_in_vs2_index;
          s1_oprand_vld_out_regs <= regfile_inst_oprand_vld_out;
          s1_dec_regs_rs1_index <= dec_rs1_index;
          s1_dec_regs_rs2_index <= dec_rs2_index;
          s1_dec_regs_rs3_index <= dec_rs3_index;
          s1_dec_regs_rd_index <= dec_rd_index;
          s1_dec_regs_imm <= dec_imm;
          s1_dec_regs_imm_is_rs2 <= dec_imm_is_rs2;
          s1_dec_regs_is_jump <= dec_is_jump;
          s1_dec_regs_is_branch <= dec_is_branch;
          s1_dec_regs_is_wload <= dec_is_wload;
          s1_dec_regs_is_wstore <= dec_is_wstore;
          s1_dec_regs_is_multi_rs1_index <= dec_is_multi_rs1_index;
          s1_dec_regs_is_multi_rd_index <= dec_is_multi_rd_index;
          s1_dec_regs_is_vector_oprand_used <= dec_is_vector_oprand_used;
          s1_dec_regs_is_vload <= dec_is_vload;
          s1_dec_regs_is_vstore1 <= dec_is_vstore1;
          s1_dec_regs_is_vstore2 <= dec_is_vstore2;
          s1_op_type_regs <= op_type;
          s1_pc_curr_reg <= pc_curr;
        end
      end
    end
  end

  always @(posedge clk) begin
    debug_en_regNext <= debug_en;
  end


endmodule

module lsu (
  input  wire          is_wstore,
  input  wire          is_wload,
  input  wire          is_vload,
  input  wire          is_vstore,
  input  wire          access_mem_vld,
  input  wire [31:0]   access_mem_addr,
  input  wire [31:0]   access_mem_wr_sdata,
  input  wire [127:0]  access_mem_wr_vdata,
  input  wire [4:0]    rd_load_index_in,
  output wire [31:0]   lsu_write_rd_data,
  output wire [4:0]    lsu_write_rd_index,
  output wire          lsu_write_rd_vld,
  output wire          lsu_write_rd_is_vector,
  output wire [127:0]  lsu_write_rd_vector_data,
  output reg           highBandWidth_fb_mem_rd,
  output reg           highBandWidth_fb_mem_wr,
  output reg  [6:0]    highBandWidth_fb_mem_addr,
  output reg  [127:0]  highBandWidth_fb_mem_wdata,
  input  wire [127:0]  highBandWidth_fb_mem_rdata,
  output reg           highBandWidth_a_mem_rd,
  output reg           highBandWidth_a_mem_wr,
  output reg  [6:0]    highBandWidth_a_mem_addr,
  output reg  [127:0]  highBandWidth_a_mem_wdata,
  input  wire [127:0]  highBandWidth_a_mem_rdata,
  output reg           highBandWidth_w_mem_rd,
  output reg           highBandWidth_w_mem_wr,
  output reg  [9:0]    highBandWidth_w_mem_addr,
  output reg  [127:0]  highBandWidth_w_mem_wdata,
  input  wire [127:0]  highBandWidth_w_mem_rdata,
  output reg           lowBandWidth_mem_rd,
  output reg           lowBandWidth_mem_wr,
  output reg  [6:0]    lowBandWidth_mem_addr,
  output reg  [31:0]   lowBandWidth_mem_wdata,
  input  wire [31:0]   lowBandWidth_mem_rdata,
  input  wire          clk,
  input  wire          resetn
);

  wire       [31:0]   tmp_highBandWidth_fb_mem_addr;
  wire       [31:0]   tmp_highBandWidth_a_mem_addr;
  wire       [31:0]   tmp_highBandWidth_w_mem_addr;
  reg        [31:0]   access_mem_rd_sdata;
  reg        [127:0]  access_mem_rd_vdata;
  wire                is_load;
  reg                 is_load_regNext;
  reg                 is_vload_regNext;
  reg        [4:0]    load_index;
  wire                lowBandWidth_sel;
  wire                highBandWidth_fb_sel;
  wire                highBandWidth_a_sel;
  wire                highBandWidth_w_sel;
  wire       [3:0]    mem_sel;
  reg        [3:0]    mem_sel_regNext;

  assign tmp_highBandWidth_fb_mem_addr = (access_mem_addr - 32'h00000080);
  assign tmp_highBandWidth_a_mem_addr = (access_mem_addr - 32'h000000f8);
  assign tmp_highBandWidth_w_mem_addr = (access_mem_addr - 32'h0000015c);
  assign is_load = (access_mem_vld && (is_vload || is_wload));
  assign lsu_write_rd_vld = is_load_regNext;
  assign lsu_write_rd_is_vector = is_vload_regNext;
  assign lsu_write_rd_data = access_mem_rd_sdata;
  assign lsu_write_rd_vector_data = access_mem_rd_vdata;
  assign lsu_write_rd_index = load_index;
  assign lowBandWidth_sel = (access_mem_addr < 32'h00000080);
  assign highBandWidth_fb_sel = ((! lowBandWidth_sel) && (access_mem_addr < 32'h000000f8));
  assign highBandWidth_a_sel = (((! lowBandWidth_sel) && (! highBandWidth_fb_sel)) && (access_mem_addr < 32'h0000015c));
  assign highBandWidth_w_sel = (((! lowBandWidth_sel) && (! highBandWidth_fb_sel)) && (! highBandWidth_a_sel));
  assign mem_sel = {{{lowBandWidth_sel,highBandWidth_fb_sel},highBandWidth_a_sel},highBandWidth_w_sel};
  always @(*) begin
    highBandWidth_fb_mem_rd = 1'b0;
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_rd = (is_vload && access_mem_vld);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_fb_mem_wr = 1'b0;
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_wr = (is_vstore && access_mem_vld);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_fb_mem_addr = 7'h00;
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_addr = tmp_highBandWidth_fb_mem_addr[6 : 0];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_fb_mem_wdata = 128'h00000000000000000000000000000000;
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_wdata = access_mem_wr_vdata;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_rd = 1'b0;
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_rd = (is_vload && access_mem_vld);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_wr = 1'b0;
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_wr = (is_vstore && access_mem_vld);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_addr = 7'h00;
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_addr = tmp_highBandWidth_a_mem_addr[6 : 0];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_wdata = 128'h00000000000000000000000000000000;
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_wdata = access_mem_wr_vdata;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_rd = 1'b0;
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_rd = (is_vload && access_mem_vld);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_wr = 1'b0;
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_wr = (is_vstore && access_mem_vld);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_addr = 10'h000;
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_addr = tmp_highBandWidth_w_mem_addr[9 : 0];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_wdata = 128'h00000000000000000000000000000000;
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_wdata = access_mem_wr_vdata;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_rd = 1'b0;
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_rd = (is_wload && access_mem_vld);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_wr = 1'b0;
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_wr = (is_wstore && access_mem_vld);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_addr = 7'h00;
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_addr = access_mem_addr[6 : 0];
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_wdata = 32'h00000000;
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_wdata = access_mem_wr_sdata;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    access_mem_rd_vdata = 128'h00000000000000000000000000000000;
    case(mem_sel_regNext)
      4'b0100 : begin
        access_mem_rd_vdata = highBandWidth_fb_mem_rdata;
      end
      4'b0010 : begin
        access_mem_rd_vdata = highBandWidth_a_mem_rdata;
      end
      4'b0001 : begin
        access_mem_rd_vdata = highBandWidth_w_mem_rdata;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    access_mem_rd_sdata = 32'h00000000;
    case(mem_sel_regNext)
      4'b1000 : begin
        access_mem_rd_sdata = lowBandWidth_mem_rdata;
      end
      default : begin
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      is_load_regNext <= 1'b0;
      is_vload_regNext <= 1'b0;
      load_index <= 5'h00;
      mem_sel_regNext <= 4'b0000;
    end else begin
      is_load_regNext <= is_load;
      is_vload_regNext <= is_vload;
      if(is_load) begin
        load_index <= rd_load_index_in;
      end
      mem_sel_regNext <= mem_sel;
    end
  end


endmodule

module alu (
  input  wire [5:0]    op_type,
  input  wire          oprand_vld_in,
  input  wire [127:0]  voperand_in_vs1,
  input  wire [127:0]  voperand_in_vs2,
  input  wire [4:0]    voperand_in_vs1_index,
  input  wire [4:0]    voperand_in_vs2_index,
  input  wire [31:0]   roperand_in_rs1,
  input  wire [4:0]    roperand_in_rs1_index,
  input  wire [31:0]   roperand_in_rs2,
  input  wire [4:0]    roperand_in_rs2_index,
  input  wire [31:0]   roperand_in_rs3,
  input  wire [4:0]    roperand_in_rs3_index,
  input  wire [4:0]    roperand_in_rd_index,
  output reg  [31:0]   alu_write_rd_data,
  output reg  [4:0]    alu_write_rd_index,
  output reg           alu_write_rd_vld,
  input  wire          is_branch_or_jump,
  input  wire [10:0]   pc_in,
  output reg  [10:0]   branch_taken_addr,
  output reg           branch_taken_vld,
  output reg           result_vld_out,
  output wire [31:0]   to_lsu_addr,
  output reg           to_lsu_addr_vld,
  output reg           to_lsu_is_vector,
  output reg           ebreak,
  input  wire          clk,
  input  wire          resetn
);
  localparam ILLEGAL = 6'd0;
  localparam NOP = 6'd1;
  localparam LW = 6'd2;
  localparam LV = 6'd3;
  localparam SW = 6'd4;
  localparam SV1 = 6'd5;
  localparam SV2 = 6'd6;
  localparam J = 6'd7;
  localparam JAL = 6'd8;
  localparam JR = 6'd9;
  localparam BEQZ = 6'd10;
  localparam BNEZ = 6'd11;
  localparam BLTZ = 6'd12;
  localparam MV = 6'd13;
  localparam EBREAK = 6'd14;
  localparam MVIMMX4 = 6'd15;
  localparam VMUL_SUM = 6'd16;
  localparam FXMUL = 6'd17;
  localparam DIV = 6'd18;
  localparam VMAC8 = 6'd19;
  localparam FMSR = 6'd20;
  localparam MAX = 6'd21;
  localparam MIN = 6'd22;
  localparam ADDX = 6'd23;
  localparam SUBX = 6'd24;
  localparam SKIPADD = 6'd25;
  localparam MVX = 6'd26;
  localparam ADDI4SPN = 6'd27;
  localparam ADDI = 6'd28;
  localparam ADD = 6'd29;
  localparam SUB = 6'd30;
  localparam LUIH8 = 6'd31;
  localparam LUIL8 = 6'd32;
  localparam SRLI = 6'd33;
  localparam SRAI = 6'd34;
  localparam SRL_1 = 6'd35;
  localparam SLLI = 6'd36;
  localparam SLL_1 = 6'd37;

  reg        [31:0]   alu_adder_dinA;
  reg        [31:0]   alu_adder_dinB;
  wire                scalar_mul_io_din_vld;
  wire       [31:0]   scalar_mul_io_dinA;
  wire       [31:0]   scalar_mul_io_dinB;
  wire                scalar_div_din_vld;
  wire       [15:0]   scalar_div_dinA;
  wire       [7:0]    scalar_div_dinB;
  wire                skip_add_start;
  wire       [63:0]   round2even_din;
  wire       [5:0]    round2even_right_shift;
  wire       [16:0]   multipliers_0_dout;
  wire       [16:0]   multipliers_1_dout;
  wire       [16:0]   multipliers_2_dout;
  wire       [16:0]   multipliers_3_dout;
  wire       [16:0]   multipliers_4_dout;
  wire       [16:0]   multipliers_5_dout;
  wire       [16:0]   multipliers_6_dout;
  wire       [16:0]   multipliers_7_dout;
  wire       [16:0]   multipliers_8_dout;
  wire       [16:0]   multipliers_9_dout;
  wire       [16:0]   multipliers_10_dout;
  wire       [16:0]   multipliers_11_dout;
  wire       [16:0]   multipliers_12_dout;
  wire       [16:0]   multipliers_13_dout;
  wire       [16:0]   multipliers_14_dout;
  wire       [16:0]   multipliers_15_dout;
  wire       [17:0]   adder_1cycle_15_dout;
  wire       [17:0]   adder_1cycle_16_dout;
  wire       [17:0]   adder_1cycle_17_dout;
  wire       [17:0]   adder_1cycle_18_dout;
  wire       [17:0]   adder_1cycle_19_dout;
  wire       [17:0]   adder_1cycle_20_dout;
  wire       [17:0]   adder_1cycle_21_dout;
  wire       [17:0]   adder_1cycle_22_dout;
  wire       [18:0]   adder_1cycle_23_dout;
  wire       [18:0]   adder_1cycle_24_dout;
  wire       [18:0]   adder_1cycle_25_dout;
  wire       [18:0]   adder_1cycle_26_dout;
  wire       [19:0]   adder_1cycle_27_dout;
  wire       [19:0]   adder_1cycle_28_dout;
  wire       [20:0]   adder_1cycle_29_dout;
  wire       [31:0]   alu_adder_dout;
  wire                scalar_mul_io_dout_vld;
  wire                scalar_mul_io_cal_finish;
  wire       [63:0]   scalar_mul_io_dout;
  wire                scalar_div_dout_vld;
  wire       [16:0]   scalar_div_quot;
  wire       [7:0]    scalar_div_remainder;
  wire                skip_add_end_1;
  wire                skip_add_mul_start_out;
  wire       [31:0]   skip_add_mul_pinA_out;
  wire       [31:0]   skip_add_mul_pinB_out;
  wire       [7:0]    skip_add_shift_out;
  wire       [31:0]   skip_add_skipadd_out;
  wire       [31:0]   round2even_dout;
  wire       [8:0]    tmp_element_in_a_0;
  wire       [7:0]    tmp_element_in_a_0_1;
  wire       [8:0]    tmp_element_in_a_1;
  wire       [7:0]    tmp_element_in_a_1_1;
  wire       [8:0]    tmp_element_in_a_2;
  wire       [7:0]    tmp_element_in_a_2_1;
  wire       [8:0]    tmp_element_in_a_3;
  wire       [7:0]    tmp_element_in_a_3_1;
  wire       [8:0]    tmp_element_in_a_4;
  wire       [7:0]    tmp_element_in_a_4_1;
  wire       [8:0]    tmp_element_in_a_5;
  wire       [7:0]    tmp_element_in_a_5_1;
  wire       [8:0]    tmp_element_in_a_6;
  wire       [7:0]    tmp_element_in_a_6_1;
  wire       [8:0]    tmp_element_in_a_7;
  wire       [7:0]    tmp_element_in_a_7_1;
  wire       [8:0]    tmp_element_in_a_8;
  wire       [7:0]    tmp_element_in_a_8_1;
  wire       [8:0]    tmp_element_in_a_9;
  wire       [7:0]    tmp_element_in_a_9_1;
  wire       [8:0]    tmp_element_in_a_10;
  wire       [7:0]    tmp_element_in_a_10_1;
  wire       [8:0]    tmp_element_in_a_11;
  wire       [7:0]    tmp_element_in_a_11_1;
  wire       [8:0]    tmp_element_in_a_12;
  wire       [7:0]    tmp_element_in_a_12_1;
  wire       [8:0]    tmp_element_in_a_13;
  wire       [7:0]    tmp_element_in_a_13_1;
  wire       [8:0]    tmp_element_in_a_14;
  wire       [7:0]    tmp_element_in_a_14_1;
  wire       [8:0]    tmp_element_in_a_15;
  wire       [7:0]    tmp_element_in_a_15_1;
  wire       [31:0]   tmp_dinA;
  reg        [16:0]   tmp_dinB;
  wire       [3:0]    tmp_dinB_1;
  wire       [31:0]   tmp_io_dinA;
  wire       [31:0]   tmp_io_dinB;
  wire       [63:0]   tmp_din;
  wire       [63:0]   tmp_din_1;
  wire       [31:0]   tmp_fmsr_result;
  wire       [31:0]   tmp_alu_write_rd_data;
  wire       [31:0]   tmp_alu_write_rd_data_1;
  wire       [31:0]   tmp_alu_write_rd_data_2;
  wire       [63:0]   tmp_alu_write_rd_data_3;
  wire       [31:0]   tmp_alu_write_rd_data_4;
  wire       [31:0]   tmp_alu_write_rd_data_5;
  wire       [31:0]   tmp_alu_write_rd_data_6;
  wire       [31:0]   tmp_alu_write_rd_data_7;
  wire       [31:0]   tmp_alu_write_rd_data_8;
  wire       [10:0]   tmp_branch_taken_addr;
  wire       [10:0]   tmp_branch_taken_addr_1;
  wire       [31:0]   tmp_alu_write_rd_data_9;
  wire       [10:0]   tmp_alu_write_rd_data_10;
  wire       [10:0]   tmp_branch_taken_addr_2;
  wire       [10:0]   tmp_branch_taken_addr_3;
  wire       [10:0]   tmp_branch_taken_addr_4;
  wire       [8:0]    element_in_a_0;
  wire       [8:0]    element_in_a_1;
  wire       [8:0]    element_in_a_2;
  wire       [8:0]    element_in_a_3;
  wire       [8:0]    element_in_a_4;
  wire       [8:0]    element_in_a_5;
  wire       [8:0]    element_in_a_6;
  wire       [8:0]    element_in_a_7;
  wire       [8:0]    element_in_a_8;
  wire       [8:0]    element_in_a_9;
  wire       [8:0]    element_in_a_10;
  wire       [8:0]    element_in_a_11;
  wire       [8:0]    element_in_a_12;
  wire       [8:0]    element_in_a_13;
  wire       [8:0]    element_in_a_14;
  wire       [8:0]    element_in_a_15;
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
  wire       [16:0]   mul_out_0;
  wire       [16:0]   mul_out_1;
  wire       [16:0]   mul_out_2;
  wire       [16:0]   mul_out_3;
  wire       [16:0]   mul_out_4;
  wire       [16:0]   mul_out_5;
  wire       [16:0]   mul_out_6;
  wire       [16:0]   mul_out_7;
  wire       [16:0]   mul_out_8;
  wire       [16:0]   mul_out_9;
  wire       [16:0]   mul_out_10;
  wire       [16:0]   mul_out_11;
  wire       [16:0]   mul_out_12;
  wire       [16:0]   mul_out_13;
  wire       [16:0]   mul_out_14;
  wire       [16:0]   mul_out_15;
  reg                 is_vector_mul_sum;
  reg                 is_vmac8;
  reg                 is_max;
  reg                 is_min;
  reg                 is_fmsr;
  wire                is_load_store;
  wire                sub_en;
  wire       [31:0]   rs2minus16;
  wire                skip_add_finish;
  wire                mul_start_out;
  wire       [31:0]   mul_pinA_out;
  wire       [31:0]   mul_pinB_out;
  wire       [7:0]    shift_out;
  wire       [31:0]   skipadd_out;
  wire                tmp_start;
  reg                 tmp_start_1;
  wire                tmp_io_din_vld;
  reg                 tmp_io_din_vld_1;
  wire                tmp_din_vld;
  reg                 tmp_din_vld_1;
  wire       [31:0]   fmsr_result;
  `ifndef SYNTHESIS
  reg [63:0] op_type_string;
  `endif


  assign tmp_element_in_a_0_1 = voperand_in_vs1[7 : 0];
  assign tmp_element_in_a_0 = {1'd0, tmp_element_in_a_0_1};
  assign tmp_element_in_a_1_1 = voperand_in_vs1[15 : 8];
  assign tmp_element_in_a_1 = {1'd0, tmp_element_in_a_1_1};
  assign tmp_element_in_a_2_1 = voperand_in_vs1[23 : 16];
  assign tmp_element_in_a_2 = {1'd0, tmp_element_in_a_2_1};
  assign tmp_element_in_a_3_1 = voperand_in_vs1[31 : 24];
  assign tmp_element_in_a_3 = {1'd0, tmp_element_in_a_3_1};
  assign tmp_element_in_a_4_1 = voperand_in_vs1[39 : 32];
  assign tmp_element_in_a_4 = {1'd0, tmp_element_in_a_4_1};
  assign tmp_element_in_a_5_1 = voperand_in_vs1[47 : 40];
  assign tmp_element_in_a_5 = {1'd0, tmp_element_in_a_5_1};
  assign tmp_element_in_a_6_1 = voperand_in_vs1[55 : 48];
  assign tmp_element_in_a_6 = {1'd0, tmp_element_in_a_6_1};
  assign tmp_element_in_a_7_1 = voperand_in_vs1[63 : 56];
  assign tmp_element_in_a_7 = {1'd0, tmp_element_in_a_7_1};
  assign tmp_element_in_a_8_1 = voperand_in_vs1[71 : 64];
  assign tmp_element_in_a_8 = {1'd0, tmp_element_in_a_8_1};
  assign tmp_element_in_a_9_1 = voperand_in_vs1[79 : 72];
  assign tmp_element_in_a_9 = {1'd0, tmp_element_in_a_9_1};
  assign tmp_element_in_a_10_1 = voperand_in_vs1[87 : 80];
  assign tmp_element_in_a_10 = {1'd0, tmp_element_in_a_10_1};
  assign tmp_element_in_a_11_1 = voperand_in_vs1[95 : 88];
  assign tmp_element_in_a_11 = {1'd0, tmp_element_in_a_11_1};
  assign tmp_element_in_a_12_1 = voperand_in_vs1[103 : 96];
  assign tmp_element_in_a_12 = {1'd0, tmp_element_in_a_12_1};
  assign tmp_element_in_a_13_1 = voperand_in_vs1[111 : 104];
  assign tmp_element_in_a_13 = {1'd0, tmp_element_in_a_13_1};
  assign tmp_element_in_a_14_1 = voperand_in_vs1[119 : 112];
  assign tmp_element_in_a_14 = {1'd0, tmp_element_in_a_14_1};
  assign tmp_element_in_a_15_1 = voperand_in_vs1[127 : 120];
  assign tmp_element_in_a_15 = {1'd0, tmp_element_in_a_15_1};
  assign tmp_dinA = {21'd0, pc_in};
  assign tmp_io_dinA = roperand_in_rs1;
  assign tmp_io_dinB = roperand_in_rs2;
  assign tmp_din = {{32{skipadd_out[31]}}, skipadd_out};
  assign tmp_din_1 = ((is_fmsr && scalar_mul_io_dout_vld) ? scalar_mul_io_dout : 64'h0000000000000000);
  assign tmp_fmsr_result = round2even_dout[31 : 0];
  assign tmp_alu_write_rd_data = alu_adder_dout[31 : 0];
  assign tmp_alu_write_rd_data_1 = alu_adder_dout[31 : 0];
  assign tmp_alu_write_rd_data_3 = ($signed(scalar_mul_io_dout) >>> roperand_in_rs3[4 : 0]);
  assign tmp_alu_write_rd_data_2 = tmp_alu_write_rd_data_3[31 : 0];
  assign tmp_alu_write_rd_data_4 = {{15{scalar_div_quot[16]}}, scalar_div_quot};
  assign tmp_alu_write_rd_data_5 = ($signed(tmp_alu_write_rd_data_6) <<< roperand_in_rs2[5 : 0]);
  assign tmp_alu_write_rd_data_6 = roperand_in_rs1;
  assign tmp_alu_write_rd_data_7 = (roperand_in_rs1 >>> roperand_in_rs2[5 : 0]);
  assign tmp_alu_write_rd_data_8 = (roperand_in_rs1 >>> roperand_in_rs2[5 : 0]);
  assign tmp_branch_taken_addr = alu_adder_dout[10 : 0];
  assign tmp_branch_taken_addr_1 = alu_adder_dout[10 : 0];
  assign tmp_alu_write_rd_data_10 = (pc_in + 11'h001);
  assign tmp_alu_write_rd_data_9 = {21'd0, tmp_alu_write_rd_data_10};
  assign tmp_branch_taken_addr_2 = alu_adder_dout[10 : 0];
  assign tmp_branch_taken_addr_3 = alu_adder_dout[10 : 0];
  assign tmp_branch_taken_addr_4 = alu_adder_dout[10 : 0];
  assign tmp_dinB_1 = rs2minus16[3 : 0];
  mul_1cycle multipliers_0 (
    .dinA (element_in_a_0[8:0]     ), //i
    .dinB (element_in_b_0[7:0]     ), //i
    .dout (multipliers_0_dout[16:0])  //o
  );
  mul_1cycle multipliers_1 (
    .dinA (element_in_a_1[8:0]     ), //i
    .dinB (element_in_b_1[7:0]     ), //i
    .dout (multipliers_1_dout[16:0])  //o
  );
  mul_1cycle multipliers_2 (
    .dinA (element_in_a_2[8:0]     ), //i
    .dinB (element_in_b_2[7:0]     ), //i
    .dout (multipliers_2_dout[16:0])  //o
  );
  mul_1cycle multipliers_3 (
    .dinA (element_in_a_3[8:0]     ), //i
    .dinB (element_in_b_3[7:0]     ), //i
    .dout (multipliers_3_dout[16:0])  //o
  );
  mul_1cycle multipliers_4 (
    .dinA (element_in_a_4[8:0]     ), //i
    .dinB (element_in_b_4[7:0]     ), //i
    .dout (multipliers_4_dout[16:0])  //o
  );
  mul_1cycle multipliers_5 (
    .dinA (element_in_a_5[8:0]     ), //i
    .dinB (element_in_b_5[7:0]     ), //i
    .dout (multipliers_5_dout[16:0])  //o
  );
  mul_1cycle multipliers_6 (
    .dinA (element_in_a_6[8:0]     ), //i
    .dinB (element_in_b_6[7:0]     ), //i
    .dout (multipliers_6_dout[16:0])  //o
  );
  mul_1cycle multipliers_7 (
    .dinA (element_in_a_7[8:0]     ), //i
    .dinB (element_in_b_7[7:0]     ), //i
    .dout (multipliers_7_dout[16:0])  //o
  );
  mul_1cycle multipliers_8 (
    .dinA (element_in_a_8[8:0]     ), //i
    .dinB (element_in_b_8[7:0]     ), //i
    .dout (multipliers_8_dout[16:0])  //o
  );
  mul_1cycle multipliers_9 (
    .dinA (element_in_a_9[8:0]     ), //i
    .dinB (element_in_b_9[7:0]     ), //i
    .dout (multipliers_9_dout[16:0])  //o
  );
  mul_1cycle multipliers_10 (
    .dinA (element_in_a_10[8:0]     ), //i
    .dinB (element_in_b_10[7:0]     ), //i
    .dout (multipliers_10_dout[16:0])  //o
  );
  mul_1cycle multipliers_11 (
    .dinA (element_in_a_11[8:0]     ), //i
    .dinB (element_in_b_11[7:0]     ), //i
    .dout (multipliers_11_dout[16:0])  //o
  );
  mul_1cycle multipliers_12 (
    .dinA (element_in_a_12[8:0]     ), //i
    .dinB (element_in_b_12[7:0]     ), //i
    .dout (multipliers_12_dout[16:0])  //o
  );
  mul_1cycle multipliers_13 (
    .dinA (element_in_a_13[8:0]     ), //i
    .dinB (element_in_b_13[7:0]     ), //i
    .dout (multipliers_13_dout[16:0])  //o
  );
  mul_1cycle multipliers_14 (
    .dinA (element_in_a_14[8:0]     ), //i
    .dinB (element_in_b_14[7:0]     ), //i
    .dout (multipliers_14_dout[16:0])  //o
  );
  mul_1cycle multipliers_15 (
    .dinA (element_in_a_15[8:0]     ), //i
    .dinB (element_in_b_15[7:0]     ), //i
    .dout (multipliers_15_dout[16:0])  //o
  );
  adder_1cycle adder_1cycle_15 (
    .dinA (mul_out_0[16:0]           ), //i
    .dinB (mul_out_1[16:0]           ), //i
    .dout (adder_1cycle_15_dout[17:0])  //o
  );
  adder_1cycle adder_1cycle_16 (
    .dinA (mul_out_2[16:0]           ), //i
    .dinB (mul_out_3[16:0]           ), //i
    .dout (adder_1cycle_16_dout[17:0])  //o
  );
  adder_1cycle adder_1cycle_17 (
    .dinA (mul_out_4[16:0]           ), //i
    .dinB (mul_out_5[16:0]           ), //i
    .dout (adder_1cycle_17_dout[17:0])  //o
  );
  adder_1cycle adder_1cycle_18 (
    .dinA (mul_out_6[16:0]           ), //i
    .dinB (mul_out_7[16:0]           ), //i
    .dout (adder_1cycle_18_dout[17:0])  //o
  );
  adder_1cycle adder_1cycle_19 (
    .dinA (mul_out_8[16:0]           ), //i
    .dinB (mul_out_9[16:0]           ), //i
    .dout (adder_1cycle_19_dout[17:0])  //o
  );
  adder_1cycle adder_1cycle_20 (
    .dinA (mul_out_10[16:0]          ), //i
    .dinB (mul_out_11[16:0]          ), //i
    .dout (adder_1cycle_20_dout[17:0])  //o
  );
  adder_1cycle adder_1cycle_21 (
    .dinA (mul_out_12[16:0]          ), //i
    .dinB (mul_out_13[16:0]          ), //i
    .dout (adder_1cycle_21_dout[17:0])  //o
  );
  adder_1cycle adder_1cycle_22 (
    .dinA (mul_out_14[16:0]          ), //i
    .dinB (mul_out_15[16:0]          ), //i
    .dout (adder_1cycle_22_dout[17:0])  //o
  );
  adder_1cycle_8 adder_1cycle_23 (
    .dinA (adder_1cycle_15_dout[17:0]), //i
    .dinB (adder_1cycle_16_dout[17:0]), //i
    .dout (adder_1cycle_23_dout[18:0])  //o
  );
  adder_1cycle_8 adder_1cycle_24 (
    .dinA (adder_1cycle_17_dout[17:0]), //i
    .dinB (adder_1cycle_18_dout[17:0]), //i
    .dout (adder_1cycle_24_dout[18:0])  //o
  );
  adder_1cycle_8 adder_1cycle_25 (
    .dinA (adder_1cycle_19_dout[17:0]), //i
    .dinB (adder_1cycle_20_dout[17:0]), //i
    .dout (adder_1cycle_25_dout[18:0])  //o
  );
  adder_1cycle_8 adder_1cycle_26 (
    .dinA (adder_1cycle_21_dout[17:0]), //i
    .dinB (adder_1cycle_22_dout[17:0]), //i
    .dout (adder_1cycle_26_dout[18:0])  //o
  );
  adder_1cycle_12 adder_1cycle_27 (
    .dinA (adder_1cycle_23_dout[18:0]), //i
    .dinB (adder_1cycle_24_dout[18:0]), //i
    .dout (adder_1cycle_27_dout[19:0])  //o
  );
  adder_1cycle_12 adder_1cycle_28 (
    .dinA (adder_1cycle_25_dout[18:0]), //i
    .dinB (adder_1cycle_26_dout[18:0]), //i
    .dout (adder_1cycle_28_dout[19:0])  //o
  );
  adder_1cycle_14 adder_1cycle_29 (
    .dinA (adder_1cycle_27_dout[19:0]), //i
    .dinB (adder_1cycle_28_dout[19:0]), //i
    .dout (adder_1cycle_29_dout[20:0])  //o
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
  skipadd skip_add (
    .start         (skip_add_start             ), //i
    .end_1         (skip_add_end_1             ), //o
    .rs1           (roperand_in_rs1[31:0]      ), //i
    .rs2           (roperand_in_rs2[31:0]      ), //i
    .rs3           (roperand_in_rs3[31:0]      ), //i
    .rd_index      (roperand_in_rd_index[4:0]  ), //i
    .vs1           (voperand_in_vs1[127:0]     ), //i
    .vs2           (voperand_in_vs2[127:0]     ), //i
    .mul_start_out (skip_add_mul_start_out     ), //o
    .mul_pinA_out  (skip_add_mul_pinA_out[31:0]), //o
    .mul_pinB_out  (skip_add_mul_pinB_out[31:0]), //o
    .mul_dout_in   (scalar_mul_io_dout[63:0]   ), //i
    .mul_end_in    (scalar_mul_io_dout_vld     ), //i
    .shift_out     (skip_add_shift_out[7:0]    ), //o
    .skipadd_out   (skip_add_skipadd_out[31:0] ), //o
    .clk           (clk                        ), //i
    .resetn        (resetn                     )  //i
  );
  Round2EvenSW round2even (
    .din         (round2even_din[63:0]       ), //i
    .dout        (round2even_dout[31:0]      ), //o
    .right_shift (round2even_right_shift[5:0])  //i
  );
  always @(*) begin
    case(tmp_dinB_1)
      4'b0000 : tmp_dinB = mul_out_0;
      4'b0001 : tmp_dinB = mul_out_1;
      4'b0010 : tmp_dinB = mul_out_2;
      4'b0011 : tmp_dinB = mul_out_3;
      4'b0100 : tmp_dinB = mul_out_4;
      4'b0101 : tmp_dinB = mul_out_5;
      4'b0110 : tmp_dinB = mul_out_6;
      4'b0111 : tmp_dinB = mul_out_7;
      4'b1000 : tmp_dinB = mul_out_8;
      4'b1001 : tmp_dinB = mul_out_9;
      4'b1010 : tmp_dinB = mul_out_10;
      4'b1011 : tmp_dinB = mul_out_11;
      4'b1100 : tmp_dinB = mul_out_12;
      4'b1101 : tmp_dinB = mul_out_13;
      4'b1110 : tmp_dinB = mul_out_14;
      default : tmp_dinB = mul_out_15;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(op_type)
      ILLEGAL : op_type_string = "ILLEGAL ";
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
      BLTZ : op_type_string = "BLTZ    ";
      MV : op_type_string = "MV      ";
      EBREAK : op_type_string = "EBREAK  ";
      MVIMMX4 : op_type_string = "MVIMMX4 ";
      VMUL_SUM : op_type_string = "VMUL_SUM";
      FXMUL : op_type_string = "FXMUL   ";
      DIV : op_type_string = "DIV     ";
      VMAC8 : op_type_string = "VMAC8   ";
      FMSR : op_type_string = "FMSR    ";
      MAX : op_type_string = "MAX     ";
      MIN : op_type_string = "MIN     ";
      ADDX : op_type_string = "ADDX    ";
      SUBX : op_type_string = "SUBX    ";
      SKIPADD : op_type_string = "SKIPADD ";
      MVX : op_type_string = "MVX     ";
      ADDI4SPN : op_type_string = "ADDI4SPN";
      ADDI : op_type_string = "ADDI    ";
      ADD : op_type_string = "ADD     ";
      SUB : op_type_string = "SUB     ";
      LUIH8 : op_type_string = "LUIH8   ";
      LUIL8 : op_type_string = "LUIL8   ";
      SRLI : op_type_string = "SRLI    ";
      SRAI : op_type_string = "SRAI    ";
      SRL_1 : op_type_string = "SRL_1   ";
      SLLI : op_type_string = "SLLI    ";
      SLL_1 : op_type_string = "SLL_1   ";
      default : op_type_string = "????????";
    endcase
  end
  `endif

  assign element_in_a_0 = tmp_element_in_a_0;
  assign element_in_b_0 = voperand_in_vs2[7 : 0];
  assign mul_out_0 = multipliers_0_dout;
  assign element_in_a_1 = tmp_element_in_a_1;
  assign element_in_b_1 = voperand_in_vs2[15 : 8];
  assign mul_out_1 = multipliers_1_dout;
  assign element_in_a_2 = tmp_element_in_a_2;
  assign element_in_b_2 = voperand_in_vs2[23 : 16];
  assign mul_out_2 = multipliers_2_dout;
  assign element_in_a_3 = tmp_element_in_a_3;
  assign element_in_b_3 = voperand_in_vs2[31 : 24];
  assign mul_out_3 = multipliers_3_dout;
  assign element_in_a_4 = tmp_element_in_a_4;
  assign element_in_b_4 = voperand_in_vs2[39 : 32];
  assign mul_out_4 = multipliers_4_dout;
  assign element_in_a_5 = tmp_element_in_a_5;
  assign element_in_b_5 = voperand_in_vs2[47 : 40];
  assign mul_out_5 = multipliers_5_dout;
  assign element_in_a_6 = tmp_element_in_a_6;
  assign element_in_b_6 = voperand_in_vs2[55 : 48];
  assign mul_out_6 = multipliers_6_dout;
  assign element_in_a_7 = tmp_element_in_a_7;
  assign element_in_b_7 = voperand_in_vs2[63 : 56];
  assign mul_out_7 = multipliers_7_dout;
  assign element_in_a_8 = tmp_element_in_a_8;
  assign element_in_b_8 = voperand_in_vs2[71 : 64];
  assign mul_out_8 = multipliers_8_dout;
  assign element_in_a_9 = tmp_element_in_a_9;
  assign element_in_b_9 = voperand_in_vs2[79 : 72];
  assign mul_out_9 = multipliers_9_dout;
  assign element_in_a_10 = tmp_element_in_a_10;
  assign element_in_b_10 = voperand_in_vs2[87 : 80];
  assign mul_out_10 = multipliers_10_dout;
  assign element_in_a_11 = tmp_element_in_a_11;
  assign element_in_b_11 = voperand_in_vs2[95 : 88];
  assign mul_out_11 = multipliers_11_dout;
  assign element_in_a_12 = tmp_element_in_a_12;
  assign element_in_b_12 = voperand_in_vs2[103 : 96];
  assign mul_out_12 = multipliers_12_dout;
  assign element_in_a_13 = tmp_element_in_a_13;
  assign element_in_b_13 = voperand_in_vs2[111 : 104];
  assign mul_out_13 = multipliers_13_dout;
  assign element_in_a_14 = tmp_element_in_a_14;
  assign element_in_b_14 = voperand_in_vs2[119 : 112];
  assign mul_out_14 = multipliers_14_dout;
  assign element_in_a_15 = tmp_element_in_a_15;
  assign element_in_b_15 = voperand_in_vs2[127 : 120];
  assign mul_out_15 = multipliers_15_dout;
  assign sub_en = ((((op_type == SUB) || (op_type == SUBX)) || is_max) || is_min);
  assign rs2minus16 = (roperand_in_rs2 - 32'h00000010);
  always @(*) begin
    if(is_branch_or_jump) begin
      alu_adder_dinA = tmp_dinA;
    end else begin
      alu_adder_dinA = roperand_in_rs1;
    end
  end

  always @(*) begin
    if(is_vector_mul_sum) begin
      alu_adder_dinB = {{11{adder_1cycle_29_dout[20]}}, adder_1cycle_29_dout};
    end else begin
      if(is_vmac8) begin
        alu_adder_dinB = {{15{tmp_dinB[16]}}, tmp_dinB};
      end else begin
        alu_adder_dinB = roperand_in_rs2;
      end
    end
  end

  assign to_lsu_addr = alu_adder_dout;
  assign tmp_start = ((op_type == SKIPADD) && oprand_vld_in);
  assign skip_add_start = (tmp_start && (! tmp_start_1));
  assign skip_add_finish = skip_add_end_1;
  assign mul_start_out = skip_add_mul_start_out;
  assign mul_pinA_out = skip_add_mul_pinA_out;
  assign mul_pinB_out = skip_add_mul_pinB_out;
  assign shift_out = skip_add_shift_out;
  assign skipadd_out = skip_add_skipadd_out;
  assign scalar_mul_io_dinA = ((op_type == SKIPADD) ? mul_pinA_out : tmp_io_dinA);
  assign scalar_mul_io_dinB = ((op_type == SKIPADD) ? mul_pinB_out : tmp_io_dinB);
  assign tmp_io_din_vld = (((op_type == FXMUL) || is_fmsr) && oprand_vld_in);
  assign scalar_mul_io_din_vld = ((tmp_io_din_vld && (! tmp_io_din_vld_1)) || mul_start_out);
  assign scalar_div_dinA = roperand_in_rs1[15 : 0];
  assign scalar_div_dinB = roperand_in_rs2[7 : 0];
  assign tmp_din_vld = ((op_type == DIV) && oprand_vld_in);
  assign scalar_div_din_vld = (tmp_din_vld && (! tmp_din_vld_1));
  assign round2even_right_shift = (skip_add_finish ? shift_out[5 : 0] : ((is_fmsr && scalar_mul_io_dout_vld) ? roperand_in_rs3[5 : 0] : 6'h00));
  assign round2even_din = (skip_add_finish ? tmp_din : tmp_din_1);
  assign fmsr_result = tmp_fmsr_result;
  always @(*) begin
    alu_write_rd_data = 32'h00000000;
    case(op_type)
      VMUL_SUM : begin
        alu_write_rd_data = tmp_alu_write_rd_data;
      end
      VMAC8 : begin
        alu_write_rd_data = tmp_alu_write_rd_data_1;
      end
      FMSR : begin
        alu_write_rd_data = fmsr_result;
      end
      SKIPADD : begin
        alu_write_rd_data = fmsr_result;
      end
      MAX : begin
        alu_write_rd_data = (alu_adder_dout[31] ? roperand_in_rs2 : roperand_in_rs1);
      end
      MIN : begin
        alu_write_rd_data = (alu_adder_dout[31] ? roperand_in_rs1 : roperand_in_rs2);
      end
      ADD, SUB, ADDI, ADDX, SUBX : begin
        alu_write_rd_data = alu_adder_dout;
      end
      ADDI4SPN : begin
        alu_write_rd_data = alu_adder_dout;
      end
      MVIMMX4 : begin
        alu_write_rd_data = roperand_in_rs2;
      end
      LUIL8 : begin
        alu_write_rd_data = {24'h000000,roperand_in_rs2[7 : 0]};
      end
      LUIH8 : begin
        alu_write_rd_data = {{16'h0000,roperand_in_rs2[7 : 0]},roperand_in_rs1[7 : 0]};
      end
      FXMUL : begin
        alu_write_rd_data = tmp_alu_write_rd_data_2;
      end
      DIV : begin
        alu_write_rd_data = tmp_alu_write_rd_data_4;
      end
      SLL_1, SLLI : begin
        alu_write_rd_data = tmp_alu_write_rd_data_5;
      end
      SRL_1, SRLI : begin
        alu_write_rd_data = tmp_alu_write_rd_data_7;
      end
      SRAI : begin
        alu_write_rd_data = tmp_alu_write_rd_data_8;
      end
      MV : begin
        alu_write_rd_data = roperand_in_rs2;
      end
      MVX : begin
        alu_write_rd_data = roperand_in_rs1;
      end
      JAL : begin
        alu_write_rd_data = tmp_alu_write_rd_data_9;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    alu_write_rd_index = 5'h00;
    case(op_type)
      VMUL_SUM : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      VMAC8 : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      FMSR : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      SKIPADD : begin
        alu_write_rd_index = (roperand_in_rd_index + 5'h10);
      end
      MAX : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      MIN : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      ADD, SUB, ADDI, ADDX, SUBX : begin
        alu_write_rd_index = roperand_in_rs1_index;
      end
      ADDI4SPN : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      MVIMMX4 : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      LUIL8 : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      LUIH8 : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      FXMUL : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      DIV : begin
        alu_write_rd_index = roperand_in_rs1_index;
      end
      SLL_1, SLLI : begin
        alu_write_rd_index = roperand_in_rs1_index;
      end
      SRL_1, SRLI : begin
        alu_write_rd_index = roperand_in_rs1_index;
      end
      SRAI : begin
        alu_write_rd_index = roperand_in_rs1_index;
      end
      MV : begin
        alu_write_rd_index = roperand_in_rs1_index;
      end
      MVX : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      JAL : begin
        alu_write_rd_index = roperand_in_rd_index;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    alu_write_rd_vld = 1'b0;
    case(op_type)
      VMUL_SUM : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      VMAC8 : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      FMSR : begin
        alu_write_rd_vld = scalar_mul_io_dout_vld;
      end
      SKIPADD : begin
        alu_write_rd_vld = skip_add_finish;
      end
      MAX : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      MIN : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      ADD, SUB, ADDI, ADDX, SUBX : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      ADDI4SPN : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      MVIMMX4 : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      LUIL8 : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      LUIH8 : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      FXMUL : begin
        alu_write_rd_vld = scalar_mul_io_dout_vld;
      end
      DIV : begin
        alu_write_rd_vld = scalar_div_dout_vld;
      end
      SLL_1, SLLI : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      SRL_1, SRLI : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      SRAI : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      MV : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      MVX : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      JAL : begin
        alu_write_rd_vld = oprand_vld_in;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    to_lsu_addr_vld = 1'b0;
    case(op_type)
      LW, SW : begin
        to_lsu_addr_vld = oprand_vld_in;
      end
      LV, SV1, SV2 : begin
        to_lsu_addr_vld = oprand_vld_in;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    to_lsu_is_vector = 1'b0;
    case(op_type)
      LV, SV1, SV2 : begin
        to_lsu_is_vector = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    result_vld_out = 1'b0;
    case(op_type)
      NOP : begin
        result_vld_out = oprand_vld_in;
      end
      VMUL_SUM : begin
        result_vld_out = oprand_vld_in;
      end
      VMAC8 : begin
        result_vld_out = oprand_vld_in;
      end
      FMSR : begin
        result_vld_out = scalar_mul_io_dout_vld;
      end
      SKIPADD : begin
        result_vld_out = skip_add_finish;
      end
      MAX : begin
        result_vld_out = oprand_vld_in;
      end
      MIN : begin
        result_vld_out = oprand_vld_in;
      end
      ADD, SUB, ADDI, ADDX, SUBX : begin
        result_vld_out = oprand_vld_in;
      end
      ADDI4SPN : begin
        result_vld_out = oprand_vld_in;
      end
      MVIMMX4 : begin
        result_vld_out = oprand_vld_in;
      end
      LUIL8 : begin
        result_vld_out = oprand_vld_in;
      end
      LUIH8 : begin
        result_vld_out = oprand_vld_in;
      end
      FXMUL : begin
        result_vld_out = scalar_mul_io_dout_vld;
      end
      DIV : begin
        result_vld_out = scalar_div_dout_vld;
      end
      SLL_1, SLLI : begin
        result_vld_out = oprand_vld_in;
      end
      SRL_1, SRLI : begin
        result_vld_out = oprand_vld_in;
      end
      SRAI : begin
        result_vld_out = oprand_vld_in;
      end
      MV : begin
        result_vld_out = oprand_vld_in;
      end
      MVX : begin
        result_vld_out = oprand_vld_in;
      end
      J : begin
        result_vld_out = oprand_vld_in;
      end
      JAL : begin
        result_vld_out = oprand_vld_in;
      end
      JR : begin
        result_vld_out = oprand_vld_in;
      end
      BEQZ : begin
        if((roperand_in_rs1 == 32'h00000000)) begin
          result_vld_out = oprand_vld_in;
        end else begin
          result_vld_out = oprand_vld_in;
        end
      end
      BNEZ : begin
        if((roperand_in_rs1 == 32'h00000000)) begin
          result_vld_out = oprand_vld_in;
        end else begin
          result_vld_out = oprand_vld_in;
        end
      end
      BLTZ : begin
        if(roperand_in_rs1[31]) begin
          result_vld_out = oprand_vld_in;
        end else begin
          result_vld_out = oprand_vld_in;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_vector_mul_sum = 1'b0;
    case(op_type)
      VMUL_SUM : begin
        is_vector_mul_sum = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_vmac8 = 1'b0;
    case(op_type)
      VMAC8 : begin
        is_vmac8 = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_max = 1'b0;
    case(op_type)
      MAX : begin
        is_max = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_min = 1'b0;
    case(op_type)
      MIN : begin
        is_min = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_fmsr = 1'b0;
    case(op_type)
      FMSR : begin
        is_fmsr = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    branch_taken_vld = 1'b0;
    case(op_type)
      J : begin
        branch_taken_vld = 1'b1;
      end
      JAL : begin
        branch_taken_vld = 1'b1;
      end
      JR : begin
        branch_taken_vld = 1'b1;
      end
      BEQZ : begin
        if((roperand_in_rs1 == 32'h00000000)) begin
          branch_taken_vld = 1'b1;
        end else begin
          branch_taken_vld = 1'b0;
        end
      end
      BNEZ : begin
        if((roperand_in_rs1 == 32'h00000000)) begin
          branch_taken_vld = 1'b0;
        end else begin
          branch_taken_vld = 1'b1;
        end
      end
      BLTZ : begin
        if(roperand_in_rs1[31]) begin
          branch_taken_vld = 1'b1;
        end else begin
          branch_taken_vld = 1'b0;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    branch_taken_addr = 11'h000;
    case(op_type)
      J : begin
        branch_taken_addr = tmp_branch_taken_addr;
      end
      JAL : begin
        branch_taken_addr = tmp_branch_taken_addr_1;
      end
      JR : begin
        branch_taken_addr = roperand_in_rs1[10 : 0];
      end
      BEQZ : begin
        if((roperand_in_rs1 == 32'h00000000)) begin
          branch_taken_addr = tmp_branch_taken_addr_2;
        end
      end
      BNEZ : begin
        if(!(roperand_in_rs1 == 32'h00000000)) begin
          branch_taken_addr = tmp_branch_taken_addr_3;
        end
      end
      BLTZ : begin
        if(roperand_in_rs1[31]) begin
          branch_taken_addr = tmp_branch_taken_addr_4;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    ebreak = 1'b0;
    case(op_type)
      EBREAK : begin
        ebreak = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(posedge clk) begin
    tmp_start_1 <= tmp_start;
    tmp_io_din_vld_1 <= tmp_io_din_vld;
    tmp_din_vld_1 <= tmp_din_vld;
  end


endmodule

module registers (
  input  wire [4:0]    dec_rs1_index,
  input  wire [4:0]    dec_rs2_index,
  input  wire [4:0]    dec_rs3_index,
  input  wire [4:0]    dec_rd_index,
  input  wire [31:0]   dec_imm,
  input  wire          dec_imm_is_rs2,
  input  wire          dec_is_jump,
  input  wire          dec_is_branch,
  input  wire          dec_is_wload,
  input  wire          dec_is_wstore,
  input  wire          dec_is_multi_rs1_index,
  input  wire          dec_is_multi_rd_index,
  input  wire          dec_is_vector_oprand_used,
  input  wire          dec_is_vload,
  input  wire          dec_is_vstore1,
  input  wire          dec_is_vstore2,
  input  wire          dec_info_vld,
  input  wire [31:0]   alu_write_rd_data,
  input  wire [4:0]    alu_write_rd_index,
  input  wire          alu_write_rd_vld,
  input  wire [31:0]   lsu_write_rd_data,
  input  wire [4:0]    lsu_write_rd_index,
  input  wire          lsu_write_rd_vld,
  input  wire          lsu_write_rd_is_vector,
  input  wire [127:0]  lsu_write_rd_vector_data,
  output wire [31:0]   roperand_out_rs1,
  output wire [4:0]    roperand_out_rs1_index,
  output wire [31:0]   roperand_out_rs2,
  output wire [4:0]    roperand_out_rs2_index,
  output wire [31:0]   roperand_out_rs3,
  output wire [4:0]    roperand_out_rs3_index,
  output wire [4:0]    roperand_out_rd_index,
  output reg  [127:0]  voperand_out_vs1,
  output reg  [127:0]  voperand_out_vs2,
  output wire [4:0]    voperand_out_vs1_index,
  output wire [4:0]    voperand_out_vs2_index,
  output wire          oprand_vld_out,
  output wire [31:0]   reg_x_0,
  output wire [31:0]   reg_x_1,
  output wire [31:0]   reg_x_2,
  output wire [31:0]   reg_x_3,
  output wire [31:0]   reg_x_4,
  output wire [31:0]   reg_x_5,
  output wire [31:0]   reg_x_6,
  output wire [31:0]   reg_x_7,
  output wire [31:0]   reg_x_8,
  output wire [31:0]   reg_x_9,
  output wire [31:0]   reg_x_10,
  output wire [31:0]   reg_x_11,
  output wire [31:0]   reg_x_12,
  output wire [31:0]   reg_x_13,
  output wire [31:0]   reg_x_14,
  output wire [31:0]   reg_x_15,
  output wire [31:0]   reg_x_16,
  output wire [31:0]   reg_x_17,
  output wire [31:0]   reg_x_18,
  output wire [31:0]   reg_x_19,
  output wire [31:0]   reg_x_20,
  output wire [31:0]   reg_x_21,
  output wire [31:0]   reg_x_22,
  output wire [31:0]   reg_x_23,
  output wire [31:0]   reg_x_24,
  output wire [31:0]   reg_x_25,
  output wire [31:0]   reg_x_26,
  output wire [31:0]   reg_x_27,
  output wire [31:0]   reg_x_28,
  output wire [31:0]   reg_x_29,
  output wire [31:0]   reg_x_30,
  output wire [31:0]   reg_x_31,
  input  wire          clk,
  input  wire          resetn
);

  reg        [31:0]   tmp_tmp_roperand_out_rs1;
  reg        [31:0]   tmp_roperand_out_rs1_1;
  wire       [4:0]    tmp_roperand_out_rs1_2;
  reg        [31:0]   tmp_roperand_out_rs2;
  reg        [31:0]   tmp_roperand_out_rd_index;
  reg        [31:0]   tmp_roperand_out_rs3;
  wire                lsu_write_normal_regfile_vld;
  wire                lsu_write_vector_regfile_vld;
  wire       [4:0]    lsu_write_normal_rd_index;
  wire       [31:0]   lsu_write_normal_rd_data;
  wire       [4:0]    write_vector_rd_index_0;
  wire       [4:0]    write_vector_rd_index_1;
  wire       [4:0]    write_vector_rd_index_2;
  wire       [4:0]    write_vector_rd_index_3;
  wire       [31:0]   write_vector_rd_data_0;
  wire       [31:0]   write_vector_rd_data_1;
  wire       [31:0]   write_vector_rd_data_2;
  wire       [31:0]   write_vector_rd_data_3;
  reg        [31:0]   x_0;
  reg        [31:0]   x_1;
  reg        [31:0]   x_2;
  reg        [31:0]   x_3;
  reg        [31:0]   x_4;
  reg        [31:0]   x_5;
  reg        [31:0]   x_6;
  reg        [31:0]   x_7;
  reg        [31:0]   x_8;
  reg        [31:0]   x_9;
  reg        [31:0]   x_10;
  reg        [31:0]   x_11;
  reg        [31:0]   x_12;
  reg        [31:0]   x_13;
  reg        [31:0]   x_14;
  reg        [31:0]   x_15;
  reg        [31:0]   x_16;
  reg        [31:0]   x_17;
  reg        [31:0]   x_18;
  reg        [31:0]   x_19;
  reg        [31:0]   x_20;
  reg        [31:0]   x_21;
  reg        [31:0]   x_22;
  reg        [31:0]   x_23;
  reg        [31:0]   x_24;
  reg        [31:0]   x_25;
  reg        [31:0]   x_26;
  reg        [31:0]   x_27;
  reg        [31:0]   x_28;
  reg        [31:0]   x_29;
  reg        [31:0]   x_30;
  reg        [31:0]   x_31;
  wire       [4:0]    vs2_index;
  wire       [31:0]   tmp_roperand_out_rs1;
  wire                is_vector_instr;

  assign tmp_roperand_out_rs1_2 = tmp_roperand_out_rs1[4 : 0];
  always @(*) begin
    case(dec_rs1_index)
      5'b00000 : tmp_tmp_roperand_out_rs1 = x_0;
      5'b00001 : tmp_tmp_roperand_out_rs1 = x_1;
      5'b00010 : tmp_tmp_roperand_out_rs1 = x_2;
      5'b00011 : tmp_tmp_roperand_out_rs1 = x_3;
      5'b00100 : tmp_tmp_roperand_out_rs1 = x_4;
      5'b00101 : tmp_tmp_roperand_out_rs1 = x_5;
      5'b00110 : tmp_tmp_roperand_out_rs1 = x_6;
      5'b00111 : tmp_tmp_roperand_out_rs1 = x_7;
      5'b01000 : tmp_tmp_roperand_out_rs1 = x_8;
      5'b01001 : tmp_tmp_roperand_out_rs1 = x_9;
      5'b01010 : tmp_tmp_roperand_out_rs1 = x_10;
      5'b01011 : tmp_tmp_roperand_out_rs1 = x_11;
      5'b01100 : tmp_tmp_roperand_out_rs1 = x_12;
      5'b01101 : tmp_tmp_roperand_out_rs1 = x_13;
      5'b01110 : tmp_tmp_roperand_out_rs1 = x_14;
      5'b01111 : tmp_tmp_roperand_out_rs1 = x_15;
      5'b10000 : tmp_tmp_roperand_out_rs1 = x_16;
      5'b10001 : tmp_tmp_roperand_out_rs1 = x_17;
      5'b10010 : tmp_tmp_roperand_out_rs1 = x_18;
      5'b10011 : tmp_tmp_roperand_out_rs1 = x_19;
      5'b10100 : tmp_tmp_roperand_out_rs1 = x_20;
      5'b10101 : tmp_tmp_roperand_out_rs1 = x_21;
      5'b10110 : tmp_tmp_roperand_out_rs1 = x_22;
      5'b10111 : tmp_tmp_roperand_out_rs1 = x_23;
      5'b11000 : tmp_tmp_roperand_out_rs1 = x_24;
      5'b11001 : tmp_tmp_roperand_out_rs1 = x_25;
      5'b11010 : tmp_tmp_roperand_out_rs1 = x_26;
      5'b11011 : tmp_tmp_roperand_out_rs1 = x_27;
      5'b11100 : tmp_tmp_roperand_out_rs1 = x_28;
      5'b11101 : tmp_tmp_roperand_out_rs1 = x_29;
      5'b11110 : tmp_tmp_roperand_out_rs1 = x_30;
      default : tmp_tmp_roperand_out_rs1 = x_31;
    endcase
  end

  always @(*) begin
    case(tmp_roperand_out_rs1_2)
      5'b00000 : tmp_roperand_out_rs1_1 = x_0;
      5'b00001 : tmp_roperand_out_rs1_1 = x_1;
      5'b00010 : tmp_roperand_out_rs1_1 = x_2;
      5'b00011 : tmp_roperand_out_rs1_1 = x_3;
      5'b00100 : tmp_roperand_out_rs1_1 = x_4;
      5'b00101 : tmp_roperand_out_rs1_1 = x_5;
      5'b00110 : tmp_roperand_out_rs1_1 = x_6;
      5'b00111 : tmp_roperand_out_rs1_1 = x_7;
      5'b01000 : tmp_roperand_out_rs1_1 = x_8;
      5'b01001 : tmp_roperand_out_rs1_1 = x_9;
      5'b01010 : tmp_roperand_out_rs1_1 = x_10;
      5'b01011 : tmp_roperand_out_rs1_1 = x_11;
      5'b01100 : tmp_roperand_out_rs1_1 = x_12;
      5'b01101 : tmp_roperand_out_rs1_1 = x_13;
      5'b01110 : tmp_roperand_out_rs1_1 = x_14;
      5'b01111 : tmp_roperand_out_rs1_1 = x_15;
      5'b10000 : tmp_roperand_out_rs1_1 = x_16;
      5'b10001 : tmp_roperand_out_rs1_1 = x_17;
      5'b10010 : tmp_roperand_out_rs1_1 = x_18;
      5'b10011 : tmp_roperand_out_rs1_1 = x_19;
      5'b10100 : tmp_roperand_out_rs1_1 = x_20;
      5'b10101 : tmp_roperand_out_rs1_1 = x_21;
      5'b10110 : tmp_roperand_out_rs1_1 = x_22;
      5'b10111 : tmp_roperand_out_rs1_1 = x_23;
      5'b11000 : tmp_roperand_out_rs1_1 = x_24;
      5'b11001 : tmp_roperand_out_rs1_1 = x_25;
      5'b11010 : tmp_roperand_out_rs1_1 = x_26;
      5'b11011 : tmp_roperand_out_rs1_1 = x_27;
      5'b11100 : tmp_roperand_out_rs1_1 = x_28;
      5'b11101 : tmp_roperand_out_rs1_1 = x_29;
      5'b11110 : tmp_roperand_out_rs1_1 = x_30;
      default : tmp_roperand_out_rs1_1 = x_31;
    endcase
  end

  always @(*) begin
    case(dec_rs2_index)
      5'b00000 : tmp_roperand_out_rs2 = x_0;
      5'b00001 : tmp_roperand_out_rs2 = x_1;
      5'b00010 : tmp_roperand_out_rs2 = x_2;
      5'b00011 : tmp_roperand_out_rs2 = x_3;
      5'b00100 : tmp_roperand_out_rs2 = x_4;
      5'b00101 : tmp_roperand_out_rs2 = x_5;
      5'b00110 : tmp_roperand_out_rs2 = x_6;
      5'b00111 : tmp_roperand_out_rs2 = x_7;
      5'b01000 : tmp_roperand_out_rs2 = x_8;
      5'b01001 : tmp_roperand_out_rs2 = x_9;
      5'b01010 : tmp_roperand_out_rs2 = x_10;
      5'b01011 : tmp_roperand_out_rs2 = x_11;
      5'b01100 : tmp_roperand_out_rs2 = x_12;
      5'b01101 : tmp_roperand_out_rs2 = x_13;
      5'b01110 : tmp_roperand_out_rs2 = x_14;
      5'b01111 : tmp_roperand_out_rs2 = x_15;
      5'b10000 : tmp_roperand_out_rs2 = x_16;
      5'b10001 : tmp_roperand_out_rs2 = x_17;
      5'b10010 : tmp_roperand_out_rs2 = x_18;
      5'b10011 : tmp_roperand_out_rs2 = x_19;
      5'b10100 : tmp_roperand_out_rs2 = x_20;
      5'b10101 : tmp_roperand_out_rs2 = x_21;
      5'b10110 : tmp_roperand_out_rs2 = x_22;
      5'b10111 : tmp_roperand_out_rs2 = x_23;
      5'b11000 : tmp_roperand_out_rs2 = x_24;
      5'b11001 : tmp_roperand_out_rs2 = x_25;
      5'b11010 : tmp_roperand_out_rs2 = x_26;
      5'b11011 : tmp_roperand_out_rs2 = x_27;
      5'b11100 : tmp_roperand_out_rs2 = x_28;
      5'b11101 : tmp_roperand_out_rs2 = x_29;
      5'b11110 : tmp_roperand_out_rs2 = x_30;
      default : tmp_roperand_out_rs2 = x_31;
    endcase
  end

  always @(*) begin
    case(dec_rd_index)
      5'b00000 : tmp_roperand_out_rd_index = x_0;
      5'b00001 : tmp_roperand_out_rd_index = x_1;
      5'b00010 : tmp_roperand_out_rd_index = x_2;
      5'b00011 : tmp_roperand_out_rd_index = x_3;
      5'b00100 : tmp_roperand_out_rd_index = x_4;
      5'b00101 : tmp_roperand_out_rd_index = x_5;
      5'b00110 : tmp_roperand_out_rd_index = x_6;
      5'b00111 : tmp_roperand_out_rd_index = x_7;
      5'b01000 : tmp_roperand_out_rd_index = x_8;
      5'b01001 : tmp_roperand_out_rd_index = x_9;
      5'b01010 : tmp_roperand_out_rd_index = x_10;
      5'b01011 : tmp_roperand_out_rd_index = x_11;
      5'b01100 : tmp_roperand_out_rd_index = x_12;
      5'b01101 : tmp_roperand_out_rd_index = x_13;
      5'b01110 : tmp_roperand_out_rd_index = x_14;
      5'b01111 : tmp_roperand_out_rd_index = x_15;
      5'b10000 : tmp_roperand_out_rd_index = x_16;
      5'b10001 : tmp_roperand_out_rd_index = x_17;
      5'b10010 : tmp_roperand_out_rd_index = x_18;
      5'b10011 : tmp_roperand_out_rd_index = x_19;
      5'b10100 : tmp_roperand_out_rd_index = x_20;
      5'b10101 : tmp_roperand_out_rd_index = x_21;
      5'b10110 : tmp_roperand_out_rd_index = x_22;
      5'b10111 : tmp_roperand_out_rd_index = x_23;
      5'b11000 : tmp_roperand_out_rd_index = x_24;
      5'b11001 : tmp_roperand_out_rd_index = x_25;
      5'b11010 : tmp_roperand_out_rd_index = x_26;
      5'b11011 : tmp_roperand_out_rd_index = x_27;
      5'b11100 : tmp_roperand_out_rd_index = x_28;
      5'b11101 : tmp_roperand_out_rd_index = x_29;
      5'b11110 : tmp_roperand_out_rd_index = x_30;
      default : tmp_roperand_out_rd_index = x_31;
    endcase
  end

  always @(*) begin
    case(dec_rs3_index)
      5'b00000 : tmp_roperand_out_rs3 = x_0;
      5'b00001 : tmp_roperand_out_rs3 = x_1;
      5'b00010 : tmp_roperand_out_rs3 = x_2;
      5'b00011 : tmp_roperand_out_rs3 = x_3;
      5'b00100 : tmp_roperand_out_rs3 = x_4;
      5'b00101 : tmp_roperand_out_rs3 = x_5;
      5'b00110 : tmp_roperand_out_rs3 = x_6;
      5'b00111 : tmp_roperand_out_rs3 = x_7;
      5'b01000 : tmp_roperand_out_rs3 = x_8;
      5'b01001 : tmp_roperand_out_rs3 = x_9;
      5'b01010 : tmp_roperand_out_rs3 = x_10;
      5'b01011 : tmp_roperand_out_rs3 = x_11;
      5'b01100 : tmp_roperand_out_rs3 = x_12;
      5'b01101 : tmp_roperand_out_rs3 = x_13;
      5'b01110 : tmp_roperand_out_rs3 = x_14;
      5'b01111 : tmp_roperand_out_rs3 = x_15;
      5'b10000 : tmp_roperand_out_rs3 = x_16;
      5'b10001 : tmp_roperand_out_rs3 = x_17;
      5'b10010 : tmp_roperand_out_rs3 = x_18;
      5'b10011 : tmp_roperand_out_rs3 = x_19;
      5'b10100 : tmp_roperand_out_rs3 = x_20;
      5'b10101 : tmp_roperand_out_rs3 = x_21;
      5'b10110 : tmp_roperand_out_rs3 = x_22;
      5'b10111 : tmp_roperand_out_rs3 = x_23;
      5'b11000 : tmp_roperand_out_rs3 = x_24;
      5'b11001 : tmp_roperand_out_rs3 = x_25;
      5'b11010 : tmp_roperand_out_rs3 = x_26;
      5'b11011 : tmp_roperand_out_rs3 = x_27;
      5'b11100 : tmp_roperand_out_rs3 = x_28;
      5'b11101 : tmp_roperand_out_rs3 = x_29;
      5'b11110 : tmp_roperand_out_rs3 = x_30;
      default : tmp_roperand_out_rs3 = x_31;
    endcase
  end

  assign lsu_write_normal_regfile_vld = (lsu_write_rd_vld && (! lsu_write_rd_is_vector));
  assign lsu_write_vector_regfile_vld = (lsu_write_rd_vld && lsu_write_rd_is_vector);
  assign lsu_write_normal_rd_index = (lsu_write_normal_regfile_vld ? lsu_write_rd_index : 5'h00);
  assign lsu_write_normal_rd_data = (lsu_write_normal_regfile_vld ? lsu_write_rd_data : 32'h00000000);
  assign write_vector_rd_index_0 = (lsu_write_rd_index + 5'h00);
  assign write_vector_rd_data_0 = lsu_write_rd_vector_data[31 : 0];
  assign write_vector_rd_index_1 = (lsu_write_rd_index + 5'h01);
  assign write_vector_rd_data_1 = lsu_write_rd_vector_data[63 : 32];
  assign write_vector_rd_index_2 = (lsu_write_rd_index + 5'h02);
  assign write_vector_rd_data_2 = lsu_write_rd_vector_data[95 : 64];
  assign write_vector_rd_index_3 = (lsu_write_rd_index + 5'h03);
  assign write_vector_rd_data_3 = lsu_write_rd_vector_data[127 : 96];
  assign vs2_index = (dec_rs2_index + 5'h04);
  assign voperand_out_vs1_index = dec_rs2_index;
  assign voperand_out_vs2_index = vs2_index;
  assign tmp_roperand_out_rs1 = tmp_tmp_roperand_out_rs1;
  assign roperand_out_rs1_index = (dec_is_multi_rs1_index ? tmp_roperand_out_rs1[4 : 0] : dec_rs1_index);
  assign roperand_out_rs2_index = (dec_imm_is_rs2 ? 5'h00 : dec_rs2_index);
  assign roperand_out_rs1 = (dec_is_multi_rs1_index ? tmp_roperand_out_rs1_1 : tmp_roperand_out_rs1);
  assign roperand_out_rs2 = (dec_imm_is_rs2 ? dec_imm : tmp_roperand_out_rs2);
  assign roperand_out_rd_index = (dec_is_multi_rd_index ? tmp_roperand_out_rd_index[4 : 0] : dec_rd_index);
  assign roperand_out_rs3 = tmp_roperand_out_rs3;
  assign roperand_out_rs3_index = dec_rs3_index;
  assign oprand_vld_out = dec_info_vld;
  assign is_vector_instr = (dec_is_vector_oprand_used || dec_is_vload);
  always @(*) begin
    if(is_vector_instr) begin
      voperand_out_vs1[31 : 0] = x_8;
      voperand_out_vs1[63 : 32] = x_9;
      voperand_out_vs1[95 : 64] = x_10;
      voperand_out_vs1[127 : 96] = x_11;
    end else begin
      voperand_out_vs1 = 128'h00000000000000000000000000000000;
    end
  end

  always @(*) begin
    if(is_vector_instr) begin
      voperand_out_vs2[31 : 0] = x_12;
      voperand_out_vs2[63 : 32] = x_13;
      voperand_out_vs2[95 : 64] = x_14;
      voperand_out_vs2[127 : 96] = x_15;
    end else begin
      if(dec_is_vstore1) begin
        voperand_out_vs2[7 : 0] = x_16[7 : 0];
        voperand_out_vs2[15 : 8] = x_17[7 : 0];
        voperand_out_vs2[23 : 16] = x_18[7 : 0];
        voperand_out_vs2[31 : 24] = x_19[7 : 0];
        voperand_out_vs2[39 : 32] = x_20[7 : 0];
        voperand_out_vs2[47 : 40] = x_21[7 : 0];
        voperand_out_vs2[55 : 48] = x_22[7 : 0];
        voperand_out_vs2[63 : 56] = x_23[7 : 0];
        voperand_out_vs2[71 : 64] = x_24[7 : 0];
        voperand_out_vs2[79 : 72] = x_25[7 : 0];
        voperand_out_vs2[87 : 80] = x_26[7 : 0];
        voperand_out_vs2[95 : 88] = x_27[7 : 0];
        voperand_out_vs2[103 : 96] = x_28[7 : 0];
        voperand_out_vs2[111 : 104] = x_29[7 : 0];
        voperand_out_vs2[119 : 112] = x_30[7 : 0];
        voperand_out_vs2[127 : 120] = x_31[7 : 0];
      end else begin
        voperand_out_vs2 = 128'h00000000000000000000000000000000;
      end
    end
  end

  assign reg_x_0 = x_0;
  assign reg_x_1 = x_1;
  assign reg_x_2 = x_2;
  assign reg_x_3 = x_3;
  assign reg_x_4 = x_4;
  assign reg_x_5 = x_5;
  assign reg_x_6 = x_6;
  assign reg_x_7 = x_7;
  assign reg_x_8 = x_8;
  assign reg_x_9 = x_9;
  assign reg_x_10 = x_10;
  assign reg_x_11 = x_11;
  assign reg_x_12 = x_12;
  assign reg_x_13 = x_13;
  assign reg_x_14 = x_14;
  assign reg_x_15 = x_15;
  assign reg_x_16 = x_16;
  assign reg_x_17 = x_17;
  assign reg_x_18 = x_18;
  assign reg_x_19 = x_19;
  assign reg_x_20 = x_20;
  assign reg_x_21 = x_21;
  assign reg_x_22 = x_22;
  assign reg_x_23 = x_23;
  assign reg_x_24 = x_24;
  assign reg_x_25 = x_25;
  assign reg_x_26 = x_26;
  assign reg_x_27 = x_27;
  assign reg_x_28 = x_28;
  assign reg_x_29 = x_29;
  assign reg_x_30 = x_30;
  assign reg_x_31 = x_31;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      x_0 <= 32'h00000000;
      x_1 <= 32'h00000000;
      x_2 <= 32'h00000000;
      x_3 <= 32'h00000000;
      x_4 <= 32'h00000000;
      x_5 <= 32'h00000000;
      x_6 <= 32'h00000000;
      x_7 <= 32'h00000000;
      x_8 <= 32'h00000000;
      x_9 <= 32'h00000000;
      x_10 <= 32'h00000000;
      x_11 <= 32'h00000000;
      x_12 <= 32'h00000000;
      x_13 <= 32'h00000000;
      x_14 <= 32'h00000000;
      x_15 <= 32'h00000000;
      x_16 <= 32'h00000000;
      x_17 <= 32'h00000000;
      x_18 <= 32'h00000000;
      x_19 <= 32'h00000000;
      x_20 <= 32'h00000000;
      x_21 <= 32'h00000000;
      x_22 <= 32'h00000000;
      x_23 <= 32'h00000000;
      x_24 <= 32'h00000000;
      x_25 <= 32'h00000000;
      x_26 <= 32'h00000000;
      x_27 <= 32'h00000000;
      x_28 <= 32'h00000000;
      x_29 <= 32'h00000000;
      x_30 <= 32'h00000000;
      x_31 <= 32'h00000000;
    end else begin
      x_0 <= 32'h00000000;
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h01))) begin
        x_1 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h01))) begin
          x_1 <= lsu_write_normal_rd_data;
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h02))) begin
        x_2 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h02))) begin
          x_2 <= lsu_write_normal_rd_data;
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h03))) begin
        x_3 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h03))) begin
          x_3 <= lsu_write_normal_rd_data;
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h04))) begin
        x_4 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h04))) begin
          x_4 <= lsu_write_normal_rd_data;
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h05))) begin
        x_5 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h05))) begin
          x_5 <= lsu_write_normal_rd_data;
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h06))) begin
        x_6 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h06))) begin
          x_6 <= lsu_write_normal_rd_data;
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h07))) begin
        x_7 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h07))) begin
          x_7 <= lsu_write_normal_rd_data;
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h08))) begin
        x_8 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h08))) begin
          x_8 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h08)) begin
              x_8 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h08)) begin
              x_8 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h08)) begin
              x_8 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h08)) begin
              x_8 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h09))) begin
        x_9 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h09))) begin
          x_9 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h09)) begin
              x_9 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h09)) begin
              x_9 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h09)) begin
              x_9 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h09)) begin
              x_9 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0a))) begin
        x_10 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0a))) begin
          x_10 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0a)) begin
              x_10 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h0a)) begin
              x_10 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h0a)) begin
              x_10 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h0a)) begin
              x_10 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0b))) begin
        x_11 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0b))) begin
          x_11 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0b)) begin
              x_11 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h0b)) begin
              x_11 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h0b)) begin
              x_11 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h0b)) begin
              x_11 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0c))) begin
        x_12 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0c))) begin
          x_12 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0c)) begin
              x_12 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h0c)) begin
              x_12 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h0c)) begin
              x_12 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h0c)) begin
              x_12 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0d))) begin
        x_13 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0d))) begin
          x_13 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0d)) begin
              x_13 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h0d)) begin
              x_13 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h0d)) begin
              x_13 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h0d)) begin
              x_13 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0e))) begin
        x_14 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0e))) begin
          x_14 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0e)) begin
              x_14 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h0e)) begin
              x_14 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h0e)) begin
              x_14 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h0e)) begin
              x_14 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0f))) begin
        x_15 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0f))) begin
          x_15 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0f)) begin
              x_15 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h0f)) begin
              x_15 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h0f)) begin
              x_15 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h0f)) begin
              x_15 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h10))) begin
        x_16 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h10))) begin
          x_16 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h10)) begin
              x_16 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h10)) begin
              x_16 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h10)) begin
              x_16 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h10)) begin
              x_16 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h11))) begin
        x_17 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h11))) begin
          x_17 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h11)) begin
              x_17 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h11)) begin
              x_17 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h11)) begin
              x_17 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h11)) begin
              x_17 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h12))) begin
        x_18 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h12))) begin
          x_18 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h12)) begin
              x_18 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h12)) begin
              x_18 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h12)) begin
              x_18 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h12)) begin
              x_18 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h13))) begin
        x_19 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h13))) begin
          x_19 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h13)) begin
              x_19 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h13)) begin
              x_19 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h13)) begin
              x_19 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h13)) begin
              x_19 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h14))) begin
        x_20 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h14))) begin
          x_20 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h14)) begin
              x_20 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h14)) begin
              x_20 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h14)) begin
              x_20 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h14)) begin
              x_20 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h15))) begin
        x_21 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h15))) begin
          x_21 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h15)) begin
              x_21 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h15)) begin
              x_21 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h15)) begin
              x_21 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h15)) begin
              x_21 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h16))) begin
        x_22 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h16))) begin
          x_22 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h16)) begin
              x_22 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h16)) begin
              x_22 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h16)) begin
              x_22 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h16)) begin
              x_22 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h17))) begin
        x_23 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h17))) begin
          x_23 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h17)) begin
              x_23 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h17)) begin
              x_23 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h17)) begin
              x_23 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h17)) begin
              x_23 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h18))) begin
        x_24 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h18))) begin
          x_24 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h18)) begin
              x_24 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h18)) begin
              x_24 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h18)) begin
              x_24 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h18)) begin
              x_24 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h19))) begin
        x_25 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h19))) begin
          x_25 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h19)) begin
              x_25 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h19)) begin
              x_25 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h19)) begin
              x_25 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h19)) begin
              x_25 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1a))) begin
        x_26 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1a))) begin
          x_26 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1a)) begin
              x_26 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h1a)) begin
              x_26 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h1a)) begin
              x_26 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h1a)) begin
              x_26 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1b))) begin
        x_27 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1b))) begin
          x_27 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1b)) begin
              x_27 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h1b)) begin
              x_27 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h1b)) begin
              x_27 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h1b)) begin
              x_27 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1c))) begin
        x_28 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1c))) begin
          x_28 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1c)) begin
              x_28 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h1c)) begin
              x_28 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h1c)) begin
              x_28 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h1c)) begin
              x_28 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1d))) begin
        x_29 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1d))) begin
          x_29 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1d)) begin
              x_29 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h1d)) begin
              x_29 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h1d)) begin
              x_29 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h1d)) begin
              x_29 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1e))) begin
        x_30 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1e))) begin
          x_30 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1e)) begin
              x_30 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h1e)) begin
              x_30 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h1e)) begin
              x_30 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h1e)) begin
              x_30 <= write_vector_rd_data_3;
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1f))) begin
        x_31 <= alu_write_rd_data;
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1f))) begin
          x_31 <= lsu_write_normal_rd_data;
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1f)) begin
              x_31 <= write_vector_rd_data_0;
            end
            if((write_vector_rd_index_1 == 5'h1f)) begin
              x_31 <= write_vector_rd_data_1;
            end
            if((write_vector_rd_index_2 == 5'h1f)) begin
              x_31 <= write_vector_rd_data_2;
            end
            if((write_vector_rd_index_3 == 5'h1f)) begin
              x_31 <= write_vector_rd_data_3;
            end
          end
        end
      end
    end
  end


endmodule

module decoder (
  input  wire          instr_valid,
  input  wire [15:0]   instr_payload,
  output reg  [4:0]    dec_rs1_index,
  output reg  [4:0]    dec_rs2_index,
  output reg  [4:0]    dec_rs3_index,
  output reg  [4:0]    dec_rd_index,
  output reg  [31:0]   dec_imm,
  output reg           dec_imm_is_rs2,
  output reg           dec_is_jump,
  output reg           dec_is_branch,
  output reg           dec_is_wload,
  output reg           dec_is_wstore,
  output reg           dec_is_multi_rs1_index,
  output reg           dec_is_multi_rd_index,
  output reg           dec_is_vector_oprand_used,
  output reg           dec_is_vload,
  output reg           dec_is_vstore1,
  output reg           dec_is_vstore2,
  output wire          dec_info_vld,
  output reg  [5:0]    op_type
);
  localparam ILLEGAL = 6'd0;
  localparam NOP = 6'd1;
  localparam LW = 6'd2;
  localparam LV = 6'd3;
  localparam SW = 6'd4;
  localparam SV1 = 6'd5;
  localparam SV2 = 6'd6;
  localparam J = 6'd7;
  localparam JAL = 6'd8;
  localparam JR = 6'd9;
  localparam BEQZ = 6'd10;
  localparam BNEZ = 6'd11;
  localparam BLTZ = 6'd12;
  localparam MV = 6'd13;
  localparam EBREAK = 6'd14;
  localparam MVIMMX4 = 6'd15;
  localparam VMUL_SUM = 6'd16;
  localparam FXMUL = 6'd17;
  localparam DIV = 6'd18;
  localparam VMAC8 = 6'd19;
  localparam FMSR = 6'd20;
  localparam MAX = 6'd21;
  localparam MIN = 6'd22;
  localparam ADDX = 6'd23;
  localparam SUBX = 6'd24;
  localparam SKIPADD = 6'd25;
  localparam MVX = 6'd26;
  localparam ADDI4SPN = 6'd27;
  localparam ADDI = 6'd28;
  localparam ADD = 6'd29;
  localparam SUB = 6'd30;
  localparam LUIH8 = 6'd31;
  localparam LUIL8 = 6'd32;
  localparam SRLI = 6'd33;
  localparam SRAI = 6'd34;
  localparam SRL_1 = 6'd35;
  localparam SLLI = 6'd36;
  localparam SLL_1 = 6'd37;

  wire       [2:0]    tmp_rs1_index_short;
  wire       [2:0]    tmp_rs2_index_short;
  wire       [4:0]    tmp_imm_op00;
  wire       [31:0]   tmp_imm_op11;
  wire       [1:0]    tmp_imm_op11_1;
  wire       [31:0]   tmp_dec_imm;
  wire       [10:0]   tmp_dec_imm_1;
  wire       [2:0]    tmp_dec_rd_index;
  wire       [31:0]   tmp_dec_imm_2;
  wire       [7:0]    tmp_dec_imm_3;
  wire       [31:0]   tmp_dec_imm_4;
  wire       [5:0]    tmp_dec_imm_5;
  wire       [31:0]   tmp_dec_imm_6;
  wire       [10:0]   tmp_dec_imm_7;
  wire       [31:0]   tmp_dec_imm_8;
  wire       [5:0]    tmp_dec_imm_9;
  wire       [31:0]   tmp_dec_imm_10;
  wire       [5:0]    tmp_dec_imm_11;
  wire       [2:0]    tmp_dec_rd_index_1;
  wire       [31:0]   tmp_dec_imm_12;
  wire       [7:0]    tmp_dec_imm_13;
  wire       [2:0]    tmp_dec_rd_index_2;
  wire       [31:0]   tmp_dec_imm_14;
  wire       [7:0]    tmp_dec_imm_15;
  wire       [31:0]   tmp_dec_imm_16;
  wire       [10:0]   tmp_dec_imm_17;
  wire       [31:0]   tmp_dec_imm_18;
  wire       [7:0]    tmp_dec_imm_19;
  wire       [31:0]   tmp_dec_imm_20;
  wire       [7:0]    tmp_dec_imm_21;
  wire       [31:0]   tmp_dec_imm_22;
  wire       [5:0]    tmp_dec_imm_23;
  wire       [31:0]   tmp_dec_imm_24;
  wire       [7:0]    tmp_dec_imm_25;
  wire       [2:0]    tmp_dec_rs1_index;
  wire       [31:0]   tmp_dec_imm_26;
  wire       [3:0]    tmp_dec_imm_27;
  wire       [3:0]    tmp_dec_rd_index_3;
  wire       [4:0]    tmp_dec_rs2_index;
  wire       [2:0]    tmp_dec_rs2_index_1;
  wire       [2:0]    tmp_dec_rd_index_4;
  wire       [3:0]    tmp_dec_rs2_index_2;
  wire       [3:0]    tmp_dec_rd_index_5;
  wire       [2:0]    tmp_dec_rs2_index_3;
  wire       [3:0]    tmp_dec_rd_index_6;
  wire       [2:0]    tmp_dec_rs2_index_4;
  wire       [3:0]    tmp_dec_rd_index_7;
  wire       [2:0]    tmp_dec_rs2_index_5;
  wire       [2:0]    tmp_dec_rd_index_8;
  wire       [3:0]    tmp_dec_rs2_index_6;
  wire       [2:0]    tmp_dec_rd_index_9;
  wire       [3:0]    tmp_dec_rs2_index_7;
  wire       [2:0]    tmp_dec_rd_index_10;
  wire       [4:0]    tmp_dec_rs3_index;
  wire       [3:0]    tmp_dec_rs3_index_1;
  wire       [4:0]    tmp_dec_rs2_index_8;
  wire       [3:0]    tmp_dec_rs2_index_9;
  wire       [3:0]    tmp_dec_rs1_index_1;
  wire       [3:0]    tmp_dec_rd_index_11;
  wire       [2:0]    tmp_dec_rs1_index_2;
  wire       [2:0]    tmp_dec_rs1_index_3;
  wire       [31:0]   tmp_dec_imm_28;
  wire       [4:0]    tmp_dec_imm_29;
  wire       [1:0]    op;
  wire       [2:0]    funct3;
  wire       [4:0]    rs1_index_short;
  wire       [4:0]    rs1_index;
  wire       [4:0]    rs2_index_short;
  wire       [4:0]    rs2_index;
  wire       [31:0]   imm_op00;
  wire       [34:0]   imm_op11;
  `ifndef SYNTHESIS
  reg [63:0] op_type_string;
  `endif


  assign tmp_rs1_index_short = instr_payload[9 : 7];
  assign tmp_rs2_index_short = instr_payload[4 : 2];
  assign tmp_imm_op00 = {instr_payload[12 : 10],instr_payload[6 : 5]};
  assign tmp_imm_op11_1 = instr_payload[8 : 7];
  assign tmp_imm_op11 = {{30{tmp_imm_op11_1[1]}}, tmp_imm_op11_1};
  assign tmp_dec_imm_1 = instr_payload[12 : 2];
  assign tmp_dec_imm = {21'd0, tmp_dec_imm_1};
  assign tmp_dec_rd_index = instr_payload[4 : 2];
  assign tmp_dec_imm_3 = instr_payload[12 : 5];
  assign tmp_dec_imm_2 = {24'd0, tmp_dec_imm_3};
  assign tmp_dec_imm_5 = {instr_payload[12],rs2_index};
  assign tmp_dec_imm_4 = {{26{tmp_dec_imm_5[5]}}, tmp_dec_imm_5};
  assign tmp_dec_imm_7 = instr_payload[12 : 2];
  assign tmp_dec_imm_6 = {{21{tmp_dec_imm_7[10]}}, tmp_dec_imm_7};
  assign tmp_dec_imm_9 = {instr_payload[12],rs2_index};
  assign tmp_dec_imm_8 = {26'd0, tmp_dec_imm_9};
  assign tmp_dec_imm_11 = {instr_payload[12],rs2_index};
  assign tmp_dec_imm_10 = {26'd0, tmp_dec_imm_11};
  assign tmp_dec_rd_index_1 = instr_payload[4 : 2];
  assign tmp_dec_imm_13 = instr_payload[12 : 5];
  assign tmp_dec_imm_12 = {24'd0, tmp_dec_imm_13};
  assign tmp_dec_rd_index_2 = instr_payload[4 : 2];
  assign tmp_dec_imm_15 = instr_payload[12 : 5];
  assign tmp_dec_imm_14 = {24'd0, tmp_dec_imm_15};
  assign tmp_dec_imm_17 = instr_payload[12 : 2];
  assign tmp_dec_imm_16 = {{21{tmp_dec_imm_17[10]}}, tmp_dec_imm_17};
  assign tmp_dec_imm_19 = {instr_payload[12 : 10],instr_payload[6 : 2]};
  assign tmp_dec_imm_18 = {{24{tmp_dec_imm_19[7]}}, tmp_dec_imm_19};
  assign tmp_dec_imm_21 = {instr_payload[12 : 10],instr_payload[6 : 2]};
  assign tmp_dec_imm_20 = {{24{tmp_dec_imm_21[7]}}, tmp_dec_imm_21};
  assign tmp_dec_imm_23 = {instr_payload[12],rs2_index};
  assign tmp_dec_imm_22 = {26'd0, tmp_dec_imm_23};
  assign tmp_dec_imm_25 = {instr_payload[12 : 10],instr_payload[6 : 2]};
  assign tmp_dec_imm_24 = {{24{tmp_dec_imm_25[7]}}, tmp_dec_imm_25};
  assign tmp_dec_rs1_index = instr_payload[10 : 8];
  assign tmp_dec_imm_27 = {instr_payload[13 : 11],instr_payload[7 : 7]};
  assign tmp_dec_imm_26 = {{28{tmp_dec_imm_27[3]}}, tmp_dec_imm_27};
  assign tmp_dec_rd_index_3 = instr_payload[12 : 9];
  assign tmp_dec_rs2_index_1 = instr_payload[8 : 6];
  assign tmp_dec_rs2_index = {2'd0, tmp_dec_rs2_index_1};
  assign tmp_dec_rd_index_4 = instr_payload[12 : 10];
  assign tmp_dec_rs2_index_2 = instr_payload[9 : 6];
  assign tmp_dec_rd_index_5 = instr_payload[12 : 9];
  assign tmp_dec_rs2_index_3 = instr_payload[8 : 6];
  assign tmp_dec_rd_index_6 = instr_payload[12 : 9];
  assign tmp_dec_rs2_index_4 = instr_payload[8 : 6];
  assign tmp_dec_rd_index_7 = instr_payload[12 : 9];
  assign tmp_dec_rs2_index_5 = instr_payload[8 : 6];
  assign tmp_dec_rd_index_8 = instr_payload[12 : 10];
  assign tmp_dec_rs2_index_6 = instr_payload[9 : 6];
  assign tmp_dec_rd_index_9 = instr_payload[12 : 10];
  assign tmp_dec_rs2_index_7 = instr_payload[9 : 6];
  assign tmp_dec_rd_index_10 = instr_payload[12 : 10];
  assign tmp_dec_rs3_index_1 = instr_payload[9 : 6];
  assign tmp_dec_rs3_index = {1'd0, tmp_dec_rs3_index_1};
  assign tmp_dec_rs2_index_9 = instr_payload[9 : 6];
  assign tmp_dec_rs2_index_8 = {1'd0, tmp_dec_rs2_index_9};
  assign tmp_dec_rs1_index_1 = instr_payload[9 : 6];
  assign tmp_dec_rd_index_11 = instr_payload[12 : 9];
  assign tmp_dec_rs1_index_2 = instr_payload[8 : 6];
  assign tmp_dec_rs1_index_3 = instr_payload[11 : 9];
  assign tmp_dec_imm_29 = {instr_payload[14 : 12],instr_payload[8 : 7]};
  assign tmp_dec_imm_28 = {{27{tmp_dec_imm_29[4]}}, tmp_dec_imm_29};
  `ifndef SYNTHESIS
  always @(*) begin
    case(op_type)
      ILLEGAL : op_type_string = "ILLEGAL ";
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
      BLTZ : op_type_string = "BLTZ    ";
      MV : op_type_string = "MV      ";
      EBREAK : op_type_string = "EBREAK  ";
      MVIMMX4 : op_type_string = "MVIMMX4 ";
      VMUL_SUM : op_type_string = "VMUL_SUM";
      FXMUL : op_type_string = "FXMUL   ";
      DIV : op_type_string = "DIV     ";
      VMAC8 : op_type_string = "VMAC8   ";
      FMSR : op_type_string = "FMSR    ";
      MAX : op_type_string = "MAX     ";
      MIN : op_type_string = "MIN     ";
      ADDX : op_type_string = "ADDX    ";
      SUBX : op_type_string = "SUBX    ";
      SKIPADD : op_type_string = "SKIPADD ";
      MVX : op_type_string = "MVX     ";
      ADDI4SPN : op_type_string = "ADDI4SPN";
      ADDI : op_type_string = "ADDI    ";
      ADD : op_type_string = "ADD     ";
      SUB : op_type_string = "SUB     ";
      LUIH8 : op_type_string = "LUIH8   ";
      LUIL8 : op_type_string = "LUIL8   ";
      SRLI : op_type_string = "SRLI    ";
      SRAI : op_type_string = "SRAI    ";
      SRL_1 : op_type_string = "SRL_1   ";
      SLLI : op_type_string = "SLLI    ";
      SLL_1 : op_type_string = "SLL_1   ";
      default : op_type_string = "????????";
    endcase
  end
  `endif

  assign op = instr_payload[1 : 0];
  assign funct3 = instr_payload[15 : 13];
  assign rs1_index_short = {2'd0, tmp_rs1_index_short};
  assign rs1_index = instr_payload[11 : 7];
  assign rs2_index_short = {2'd0, tmp_rs2_index_short};
  assign rs2_index = instr_payload[6 : 2];
  assign imm_op00 = {{27{tmp_imm_op00[4]}}, tmp_imm_op00};
  assign imm_op11 = {instr_payload[14 : 12],tmp_imm_op11};
  always @(*) begin
    dec_rs1_index = 5'h00;
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_rs1_index = rs1_index_short;
          end
          3'b001 : begin
            dec_rs1_index = 5'h00;
          end
          3'b110 : begin
            dec_rs1_index = rs1_index_short;
          end
          3'b000 : begin
            if(!(instr_payload[13 : 0] == 14'h0000)) begin
              dec_rs1_index = 5'h00;
            end
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            dec_rs1_index = rs1_index;
          end
          3'b001 : begin
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                dec_rs1_index = rs1_index_short;
              end
              2'b01 : begin
                dec_rs1_index = rs1_index_short;
              end
              2'b11 : begin
                case(instr_payload[6 : 5])
                  2'b00 : begin
                    dec_rs1_index = rs1_index_short;
                  end
                  2'b10 : begin
                    dec_rs1_index = rs1_index_short;
                  end
                  default : begin
                  end
                endcase
              end
              default : begin
              end
            endcase
          end
          3'b010 : begin
            dec_rs1_index = dec_rd_index;
          end
          3'b011 : begin
            dec_rs1_index = dec_rd_index;
          end
          3'b101 : begin
            dec_rs1_index = 5'h00;
          end
          3'b110 : begin
            dec_rs1_index = rs1_index_short;
          end
          default : begin
            dec_rs1_index = rs1_index_short;
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            dec_rs1_index = rs1_index_short;
          end
          3'b010 : begin
            dec_rs1_index = rs1_index_short;
          end
          3'b100 : begin
            dec_rs1_index = rs1_index;
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_rs1_index = {2'd0, tmp_dec_rs1_index};
            end else begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      dec_rs1_index = dec_rd_index;
                    end
                    4'b0001 : begin
                      dec_rs1_index = dec_rd_index;
                    end
                    4'b0010 : begin
                      dec_rs1_index = dec_rd_index;
                    end
                    4'b0011 : begin
                      dec_rs1_index = dec_rd_index;
                    end
                    4'b0100 : begin
                      dec_rs1_index = dec_rd_index;
                    end
                    4'b0101 : begin
                      dec_rs1_index = dec_rd_index;
                    end
                    4'b0110 : begin
                      dec_rs1_index = dec_rd_index;
                    end
                    4'b0111 : begin
                      dec_rs1_index = {1'd0, tmp_dec_rs1_index_1};
                    end
                    4'b1000 : begin
                      dec_rs1_index = {2'd0, tmp_dec_rs1_index_2};
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rs1_index = dec_rd_index;
                    end
                    default : begin
                      dec_rs1_index = instr_payload[11 : 7];
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            dec_rs1_index = {2'd0, tmp_dec_rs1_index_3};
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_rs2_index = 5'h00;
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b11 : begin
                case(instr_payload[6 : 5])
                  2'b00 : begin
                    dec_rs2_index = rs2_index_short;
                  end
                  2'b10 : begin
                    dec_rs2_index = rs2_index_short;
                  end
                  default : begin
                  end
                endcase
              end
              default : begin
              end
            endcase
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b100 : begin
            dec_rs2_index = rs2_index;
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if(!(instr_payload[15 : 14] == 2'b01)) begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      dec_rs2_index = (tmp_dec_rs2_index + 5'h08);
                    end
                    4'b0001 : begin
                      dec_rs2_index = {1'd0, tmp_dec_rs2_index_2};
                    end
                    4'b0010 : begin
                      dec_rs2_index = {2'd0, tmp_dec_rs2_index_3};
                    end
                    4'b0011 : begin
                      dec_rs2_index = {2'd0, tmp_dec_rs2_index_4};
                    end
                    4'b0100 : begin
                      dec_rs2_index = {2'd0, tmp_dec_rs2_index_5};
                    end
                    4'b0101 : begin
                      dec_rs2_index = {1'd0, tmp_dec_rs2_index_6};
                    end
                    4'b0110 : begin
                      dec_rs2_index = {1'd0, tmp_dec_rs2_index_7};
                    end
                    4'b0111 : begin
                      dec_rs2_index = (tmp_dec_rs2_index_8 + 5'h01);
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rs2_index = instr_payload[6 : 2];
                    end
                    default : begin
                      dec_rs2_index = instr_payload[6 : 2];
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            dec_rs2_index = instr_payload[6 : 2];
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_rs3_index = 5'h00;
    case(op)
      2'b00 : begin
        case(funct3)
          3'b110 : begin
            dec_rs3_index = rs2_index_short;
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if(!(instr_payload[15 : 14] == 2'b01)) begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0001 : begin
                      dec_rs3_index = 5'h07;
                    end
                    4'b0111 : begin
                      dec_rs3_index = (tmp_dec_rs3_index + 5'h02);
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rs3_index = 5'h07;
                    end
                    default : begin
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_rd_index = 5'h00;
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_rd_index = rs2_index_short;
          end
          3'b001 : begin
            dec_rd_index = 5'h04;
          end
          3'b000 : begin
            if(!(instr_payload[13 : 0] == 14'h0000)) begin
              dec_rd_index = {2'd0, tmp_dec_rd_index};
            end
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
          end
          3'b001 : begin
            dec_rd_index = 5'h01;
          end
          3'b100 : begin
          end
          3'b010 : begin
            dec_rd_index = {2'd0, tmp_dec_rd_index_1};
          end
          3'b011 : begin
            dec_rd_index = {2'd0, tmp_dec_rd_index_2};
          end
          3'b101 : begin
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b100 : begin
            dec_rd_index = rs1_index;
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_rd_index = (instr_payload[6 : 2] + 5'h08);
            end else begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_3};
                    end
                    4'b0001 : begin
                      dec_rd_index = {2'd0, tmp_dec_rd_index_4};
                    end
                    4'b0010 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_5};
                    end
                    4'b0011 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_6};
                    end
                    4'b0100 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_7};
                    end
                    4'b0101 : begin
                      dec_rd_index = {2'd0, tmp_dec_rd_index_8};
                    end
                    4'b0110 : begin
                      dec_rd_index = {2'd0, tmp_dec_rd_index_9};
                    end
                    4'b0111 : begin
                      dec_rd_index = {2'd0, tmp_dec_rd_index_10};
                    end
                    4'b1000 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_11};
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rd_index = instr_payload[11 : 7];
                    end
                    default : begin
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_imm = 32'h00000000;
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_imm = imm_op00;
          end
          3'b001 : begin
            dec_imm = tmp_dec_imm;
          end
          3'b110 : begin
            dec_imm = imm_op00;
          end
          3'b000 : begin
            if(!(instr_payload[13 : 0] == 14'h0000)) begin
              dec_imm = tmp_dec_imm_2;
            end
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            dec_imm = tmp_dec_imm_4;
          end
          3'b001 : begin
            dec_imm = tmp_dec_imm_6;
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                dec_imm = tmp_dec_imm_8;
              end
              2'b01 : begin
                dec_imm = tmp_dec_imm_10;
              end
              default : begin
              end
            endcase
          end
          3'b010 : begin
            dec_imm = tmp_dec_imm_12;
          end
          3'b011 : begin
            dec_imm = tmp_dec_imm_14;
          end
          3'b101 : begin
            dec_imm = tmp_dec_imm_16;
          end
          3'b110 : begin
            dec_imm = tmp_dec_imm_18;
          end
          default : begin
            dec_imm = tmp_dec_imm_20;
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            dec_imm = tmp_dec_imm_22;
          end
          3'b010 : begin
            dec_imm = tmp_dec_imm_24;
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_imm = tmp_dec_imm_26;
            end
          end
          default : begin
            dec_imm = tmp_dec_imm_28;
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_imm_is_rs2 = 1'b0;
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          3'b001 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          3'b110 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          3'b000 : begin
            if(!(instr_payload[13 : 0] == 14'h0000)) begin
              dec_imm_is_rs2 = 1'b1;
            end
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            if(!((rs1_index == 5'h00) && ({instr_payload[12],rs2_index} == 6'h3f))) begin
              dec_imm_is_rs2 = 1'b1;
            end
          end
          3'b001 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                dec_imm_is_rs2 = 1'b1;
              end
              2'b01 : begin
                dec_imm_is_rs2 = 1'b1;
              end
              default : begin
              end
            endcase
          end
          3'b010 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          3'b011 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          3'b101 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          3'b110 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          default : begin
            dec_imm_is_rs2 = 1'b1;
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          3'b010 : begin
            dec_imm_is_rs2 = 1'b1;
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_imm_is_rs2 = 1'b1;
            end
          end
          default : begin
            dec_imm_is_rs2 = 1'b1;
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_jump = 1'b0;
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
          end
          3'b001 : begin
            dec_is_jump = 1'b1;
          end
          3'b100 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b101 : begin
            dec_is_jump = 1'b1;
          end
          3'b110 : begin
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    dec_is_branch = 1'b0;
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
          end
          3'b001 : begin
          end
          3'b100 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b101 : begin
          end
          3'b110 : begin
            dec_is_branch = 1'b1;
          end
          default : begin
            dec_is_branch = 1'b1;
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b010 : begin
            dec_is_branch = 1'b1;
          end
          default : begin
          end
        endcase
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    dec_is_wload = 1'b0;
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_is_wload = 1'b1;
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    dec_is_wstore = 1'b0;
    case(op)
      2'b00 : begin
        case(funct3)
          3'b110 : begin
            dec_is_wstore = 1'b1;
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    dec_is_multi_rs1_index = 1'b0;
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if(!(instr_payload[15 : 14] == 2'b01)) begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      dec_is_multi_rs1_index = 1'b1;
                    end
                    4'b0001 : begin
                      dec_is_multi_rs1_index = 1'b1;
                    end
                    4'b0010 : begin
                      dec_is_multi_rs1_index = 1'b1;
                    end
                    4'b0011 : begin
                      dec_is_multi_rs1_index = 1'b1;
                    end
                    4'b0100 : begin
                      dec_is_multi_rs1_index = 1'b1;
                    end
                    4'b0101 : begin
                      dec_is_multi_rs1_index = 1'b1;
                    end
                    4'b0110 : begin
                      dec_is_multi_rs1_index = 1'b1;
                    end
                    4'b0111 : begin
                      dec_is_multi_rs1_index = 1'b0;
                    end
                    4'b1000 : begin
                      dec_is_multi_rs1_index = 1'b1;
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_is_multi_rs1_index = 1'b1;
                    end
                    default : begin
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_multi_rd_index = 1'b0;
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if(!(instr_payload[15 : 14] == 2'b01)) begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      dec_is_multi_rd_index = 1'b1;
                    end
                    4'b0001 : begin
                      dec_is_multi_rd_index = 1'b1;
                    end
                    4'b0010 : begin
                      dec_is_multi_rd_index = 1'b1;
                    end
                    4'b0011 : begin
                      dec_is_multi_rd_index = 1'b1;
                    end
                    4'b0100 : begin
                      dec_is_multi_rd_index = 1'b1;
                    end
                    4'b0101 : begin
                      dec_is_multi_rd_index = 1'b1;
                    end
                    4'b0110 : begin
                      dec_is_multi_rd_index = 1'b1;
                    end
                    4'b0111 : begin
                      dec_is_multi_rd_index = 1'b1;
                    end
                    4'b1000 : begin
                      dec_is_multi_rd_index = 1'b0;
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_is_multi_rd_index = 1'b1;
                    end
                    default : begin
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_vector_oprand_used = 1'b0;
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if(!(instr_payload[15 : 14] == 2'b01)) begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      dec_is_vector_oprand_used = 1'b1;
                    end
                    4'b0010 : begin
                      dec_is_vector_oprand_used = 1'b1;
                    end
                    4'b0111 : begin
                      dec_is_vector_oprand_used = 1'b1;
                    end
                    default : begin
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_vload = 1'b0;
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_is_vload = 1'b1;
            end
          end
          default : begin
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_vstore1 = 1'b0;
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
          end
          default : begin
            if((dec_rs2_index == 5'h00)) begin
              dec_is_vstore1 = 1'b1;
            end
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_vstore2 = 1'b0;
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
          end
          default : begin
            if(!(dec_rs2_index == 5'h00)) begin
              dec_is_vstore2 = 1'b1;
            end
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    op_type = ILLEGAL;
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            op_type = LW;
          end
          3'b001 : begin
            op_type = MVIMMX4;
          end
          3'b110 : begin
            op_type = SW;
          end
          3'b000 : begin
            if((instr_payload[13 : 0] == 14'h0000)) begin
              op_type = ILLEGAL;
            end else begin
              op_type = ADDI4SPN;
            end
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            if(((rs1_index == 5'h00) && ({instr_payload[12],rs2_index} == 6'h3f))) begin
              op_type = NOP;
            end else begin
              op_type = ADDI;
            end
          end
          3'b001 : begin
            op_type = JAL;
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                op_type = SRLI;
              end
              2'b01 : begin
                op_type = SRAI;
              end
              2'b11 : begin
                case(instr_payload[6 : 5])
                  2'b00 : begin
                    op_type = SUB;
                  end
                  2'b10 : begin
                    op_type = SRL_1;
                  end
                  default : begin
                  end
                endcase
              end
              default : begin
              end
            endcase
          end
          3'b010 : begin
            op_type = LUIH8;
          end
          3'b011 : begin
            op_type = LUIL8;
          end
          3'b101 : begin
            op_type = J;
          end
          3'b110 : begin
            op_type = BEQZ;
          end
          default : begin
            op_type = BNEZ;
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            op_type = SLLI;
          end
          3'b010 : begin
            op_type = BLTZ;
          end
          3'b100 : begin
            case(instr_payload[12])
              1'b0 : begin
                if(((! (rs1_index == 5'h00)) && (rs2_index == 5'h00))) begin
                  op_type = JR;
                end else begin
                  op_type = MV;
                end
              end
              default : begin
                if(((rs1_index == 5'h00) && (rs2_index == 5'h00))) begin
                  op_type = EBREAK;
                end else begin
                  if(((! (rs1_index == 5'h00)) && (! (rs2_index == 5'h00)))) begin
                    op_type = ADD;
                  end
                end
              end
            endcase
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              op_type = LV;
            end else begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      op_type = VMUL_SUM;
                    end
                    4'b0001 : begin
                      op_type = FMSR;
                    end
                    4'b0010 : begin
                      op_type = VMAC8;
                    end
                    4'b0011 : begin
                      op_type = MAX;
                    end
                    4'b0100 : begin
                      op_type = MIN;
                    end
                    4'b0101 : begin
                      op_type = ADDX;
                    end
                    4'b0110 : begin
                      op_type = SUBX;
                    end
                    4'b0111 : begin
                      op_type = SKIPADD;
                    end
                    4'b1000 : begin
                      op_type = MVX;
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      op_type = FXMUL;
                    end
                    default : begin
                      op_type = DIV;
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            if((dec_rs2_index == 5'h00)) begin
              op_type = SV1;
            end else begin
              op_type = SV2;
            end
          end
        endcase
      end
    endcase
  end

  assign dec_info_vld = instr_valid;

endmodule

module fetch (
  output wire          imem_rd,
  output wire [10:0]   imem_addr,
  input  wire [15:0]   imem_rdata,
  input  wire          fetch_start,
  input  wire          fetch_break,
  input  wire          fetch_restore,
  input  wire [10:0]   branch_addr,
  input  wire          branch_vld,
  output wire          instr_valid,
  output wire [15:0]   instr_payload,
  output wire [10:0]   pc_curr,
  input  wire          clk,
  input  wire          resetn
);

  reg                 fetch_going;
  reg        [10:0]   pc_reg;
  reg        [10:0]   pc_next;
  reg                 imem_rd_regNext;

  assign imem_rd = ((fetch_start || fetch_restore) || (fetch_going && (! fetch_break)));
  assign pc_curr = pc_reg;
  always @(*) begin
    if(fetch_start) begin
      pc_next = 11'h098;
    end else begin
      if(branch_vld) begin
        pc_next = branch_addr[10 : 0];
      end else begin
        pc_next = (pc_reg + 11'h001);
      end
    end
  end

  assign imem_addr = pc_next;
  assign instr_payload = imem_rdata;
  assign instr_valid = imem_rd_regNext;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      fetch_going <= 1'b0;
      pc_reg <= 11'h098;
      imem_rd_regNext <= 1'b0;
    end else begin
      if(fetch_start) begin
        fetch_going <= 1'b1;
      end else begin
        if(fetch_restore) begin
          fetch_going <= 1'b1;
        end else begin
          if(fetch_break) begin
            fetch_going <= 1'b0;
          end
        end
      end
      if(imem_rd) begin
        pc_reg <= pc_next;
      end
      imem_rd_regNext <= imem_rd;
    end
  end


endmodule

module Round2EvenSW (
  input  wire [63:0]   din,
  output wire [31:0]   dout,
  input  wire [5:0]    right_shift
);

  wire       [63:0]   tmp_din_abs;
  wire       [63:0]   tmp_din_abs_1;
  wire       [63:0]   tmp_din_abs_2;
  wire       [0:0]    tmp_din_abs_3;
  wire       [63:0]   tmp_decimal_part;
  wire       [63:0]   tmp_decimal_part_1;
  wire       [5:0]    tmp_decimal_part_2;
  wire       [63:0]   tmp_decide_value;
  wire       [5:0]    tmp_decide_value_1;
  wire       [63:0]   tmp_result;
  wire       [63:0]   tmp_result_1;
  wire       [0:0]    tmp_result_2;
  wire       [5:0]    tmp_result_3;
  wire       [31:0]   tmp_dout;
  wire       [31:0]   tmp_dout_1;
  wire       [0:0]    tmp_dout_2;
  wire                signbit;
  wire       [63:0]   din_abs;
  wire       [63:0]   decimal_part;
  wire       [63:0]   decide_value;
  wire                cond;
  wire       [63:0]   result;
  wire       [31:0]   result_clip;

  assign tmp_din_abs = (signbit ? tmp_din_abs_1 : din);
  assign tmp_din_abs_1 = (~ din);
  assign tmp_din_abs_3 = signbit;
  assign tmp_din_abs_2 = {63'd0, tmp_din_abs_3};
  assign tmp_decimal_part = (tmp_decimal_part_1 - 64'h0000000000000001);
  assign tmp_decimal_part_1 = (64'h0000000000000001 <<< tmp_decimal_part_2);
  assign tmp_decimal_part_2 = (right_shift + 6'h01);
  assign tmp_decide_value = (64'h0000000000000001 <<< tmp_decide_value_1);
  assign tmp_decide_value_1 = (right_shift - 6'h01);
  assign tmp_result = (din_abs >>> right_shift);
  assign tmp_result_2 = (din_abs[tmp_result_3] && cond);
  assign tmp_result_1 = {63'd0, tmp_result_2};
  assign tmp_result_3 = (right_shift - 6'h01);
  assign tmp_dout = ((signbit ? (~ result_clip) : result_clip) + tmp_dout_1);
  assign tmp_dout_2 = signbit;
  assign tmp_dout_1 = {31'd0, tmp_dout_2};
  assign signbit = din[63];
  assign din_abs = (tmp_din_abs + tmp_din_abs_2);
  assign decimal_part = (din_abs & tmp_decimal_part);
  assign decide_value = tmp_decide_value;
  assign cond = (decimal_part == decimal_part);
  assign result = (tmp_result + tmp_result_1);
  assign result_clip = result[31 : 0];
  assign dout = tmp_dout;

endmodule

module skipadd (
  input  wire          start,
  output wire          end_1,
  input  wire [31:0]   rs1,
  input  wire [31:0]   rs2,
  input  wire [31:0]   rs3,
  input  wire [4:0]    rd_index,
  input  wire [127:0]  vs1,
  input  wire [127:0]  vs2,
  output wire          mul_start_out,
  output reg  [31:0]   mul_pinA_out,
  output reg  [31:0]   mul_pinB_out,
  input  wire [63:0]   mul_dout_in,
  input  wire          mul_end_in,
  output wire [7:0]    shift_out,
  output wire [31:0]   skipadd_out,
  input  wire          clk,
  input  wire          resetn
);
  localparam IDLE = 2'd0;
  localparam MUL1 = 2'd1;
  localparam MUL2 = 2'd2;
  localparam ADD = 2'd3;

  reg        [7:0]    tmp_input_data1_val;
  wire       [3:0]    tmp_input_data1_val_1;
  reg        [7:0]    tmp_input_data2_val;
  wire       [3:0]    tmp_input_data2_val_1;
  wire       [7:0]    tmp_offset1;
  wire       [7:0]    tmp_offset2;
  wire       [31:0]   tmp_sum_reg;
  wire       [8:0]    tmp_mul_pinA_out;
  wire       [8:0]    tmp_mul_pinA_out_1;
  wire       [8:0]    tmp_mul_pinA_out_2;
  wire       [8:0]    tmp_mul_pinA_out_3;
  wire       [8:0]    tmp_mul_pinA_out_4;
  wire       [8:0]    tmp_mul_pinA_out_5;
  wire       [7:0]    input_data1_vec_0;
  wire       [7:0]    input_data1_vec_1;
  wire       [7:0]    input_data1_vec_2;
  wire       [7:0]    input_data1_vec_3;
  wire       [7:0]    input_data1_vec_4;
  wire       [7:0]    input_data1_vec_5;
  wire       [7:0]    input_data1_vec_6;
  wire       [7:0]    input_data1_vec_7;
  wire       [7:0]    input_data1_vec_8;
  wire       [7:0]    input_data1_vec_9;
  wire       [7:0]    input_data1_vec_10;
  wire       [7:0]    input_data1_vec_11;
  wire       [7:0]    input_data1_vec_12;
  wire       [7:0]    input_data1_vec_13;
  wire       [7:0]    input_data1_vec_14;
  wire       [7:0]    input_data1_vec_15;
  wire       [7:0]    input_data2_vec_0;
  wire       [7:0]    input_data2_vec_1;
  wire       [7:0]    input_data2_vec_2;
  wire       [7:0]    input_data2_vec_3;
  wire       [7:0]    input_data2_vec_4;
  wire       [7:0]    input_data2_vec_5;
  wire       [7:0]    input_data2_vec_6;
  wire       [7:0]    input_data2_vec_7;
  wire       [7:0]    input_data2_vec_8;
  wire       [7:0]    input_data2_vec_9;
  wire       [7:0]    input_data2_vec_10;
  wire       [7:0]    input_data2_vec_11;
  wire       [7:0]    input_data2_vec_12;
  wire       [7:0]    input_data2_vec_13;
  wire       [7:0]    input_data2_vec_14;
  wire       [7:0]    input_data2_vec_15;
  wire       [8:0]    input_data1_val;
  wire       [8:0]    input_data2_val;
  wire       [8:0]    offset1;
  wire       [8:0]    offset2;
  reg        [31:0]   sum_reg;
  reg        [1:0]    next_state;
  reg        [1:0]    curr_state;
  wire                tmp_mul1_state_in;
  reg                 tmp_mul1_state_in_1;
  wire                mul1_state_in;
  wire                tmp_mul2_state_in;
  reg                 tmp_mul2_state_in_1;
  wire                mul2_state_in;
  wire                mul1_mul_end;
  wire                mul2_mul_end;
  `ifndef SYNTHESIS
  reg [31:0] next_state_string;
  reg [31:0] curr_state_string;
  `endif


  assign tmp_offset1 = rs3[15 : 8];
  assign tmp_offset2 = rs3[23 : 16];
  assign tmp_sum_reg = mul_dout_in[31 : 0];
  assign tmp_mul_pinA_out = ($signed(tmp_mul_pinA_out_1) - $signed(tmp_mul_pinA_out_2));
  assign tmp_mul_pinA_out_1 = input_data1_val;
  assign tmp_mul_pinA_out_2 = offset1;
  assign tmp_mul_pinA_out_3 = ($signed(tmp_mul_pinA_out_4) - $signed(tmp_mul_pinA_out_5));
  assign tmp_mul_pinA_out_4 = input_data2_val;
  assign tmp_mul_pinA_out_5 = offset2;
  assign tmp_input_data1_val_1 = rd_index[3 : 0];
  assign tmp_input_data2_val_1 = rd_index[3 : 0];
  always @(*) begin
    case(tmp_input_data1_val_1)
      4'b0000 : tmp_input_data1_val = input_data1_vec_0;
      4'b0001 : tmp_input_data1_val = input_data1_vec_1;
      4'b0010 : tmp_input_data1_val = input_data1_vec_2;
      4'b0011 : tmp_input_data1_val = input_data1_vec_3;
      4'b0100 : tmp_input_data1_val = input_data1_vec_4;
      4'b0101 : tmp_input_data1_val = input_data1_vec_5;
      4'b0110 : tmp_input_data1_val = input_data1_vec_6;
      4'b0111 : tmp_input_data1_val = input_data1_vec_7;
      4'b1000 : tmp_input_data1_val = input_data1_vec_8;
      4'b1001 : tmp_input_data1_val = input_data1_vec_9;
      4'b1010 : tmp_input_data1_val = input_data1_vec_10;
      4'b1011 : tmp_input_data1_val = input_data1_vec_11;
      4'b1100 : tmp_input_data1_val = input_data1_vec_12;
      4'b1101 : tmp_input_data1_val = input_data1_vec_13;
      4'b1110 : tmp_input_data1_val = input_data1_vec_14;
      default : tmp_input_data1_val = input_data1_vec_15;
    endcase
  end

  always @(*) begin
    case(tmp_input_data2_val_1)
      4'b0000 : tmp_input_data2_val = input_data2_vec_0;
      4'b0001 : tmp_input_data2_val = input_data2_vec_1;
      4'b0010 : tmp_input_data2_val = input_data2_vec_2;
      4'b0011 : tmp_input_data2_val = input_data2_vec_3;
      4'b0100 : tmp_input_data2_val = input_data2_vec_4;
      4'b0101 : tmp_input_data2_val = input_data2_vec_5;
      4'b0110 : tmp_input_data2_val = input_data2_vec_6;
      4'b0111 : tmp_input_data2_val = input_data2_vec_7;
      4'b1000 : tmp_input_data2_val = input_data2_vec_8;
      4'b1001 : tmp_input_data2_val = input_data2_vec_9;
      4'b1010 : tmp_input_data2_val = input_data2_vec_10;
      4'b1011 : tmp_input_data2_val = input_data2_vec_11;
      4'b1100 : tmp_input_data2_val = input_data2_vec_12;
      4'b1101 : tmp_input_data2_val = input_data2_vec_13;
      4'b1110 : tmp_input_data2_val = input_data2_vec_14;
      default : tmp_input_data2_val = input_data2_vec_15;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE";
      MUL1 : next_state_string = "MUL1";
      MUL2 : next_state_string = "MUL2";
      ADD : next_state_string = "ADD ";
      default : next_state_string = "????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE";
      MUL1 : curr_state_string = "MUL1";
      MUL2 : curr_state_string = "MUL2";
      ADD : curr_state_string = "ADD ";
      default : curr_state_string = "????";
    endcase
  end
  `endif

  assign input_data1_vec_0 = vs1[7 : 0];
  assign input_data1_vec_1 = vs1[15 : 8];
  assign input_data1_vec_2 = vs1[23 : 16];
  assign input_data1_vec_3 = vs1[31 : 24];
  assign input_data1_vec_4 = vs1[39 : 32];
  assign input_data1_vec_5 = vs1[47 : 40];
  assign input_data1_vec_6 = vs1[55 : 48];
  assign input_data1_vec_7 = vs1[63 : 56];
  assign input_data1_vec_8 = vs1[71 : 64];
  assign input_data1_vec_9 = vs1[79 : 72];
  assign input_data1_vec_10 = vs1[87 : 80];
  assign input_data1_vec_11 = vs1[95 : 88];
  assign input_data1_vec_12 = vs1[103 : 96];
  assign input_data1_vec_13 = vs1[111 : 104];
  assign input_data1_vec_14 = vs1[119 : 112];
  assign input_data1_vec_15 = vs1[127 : 120];
  assign input_data2_vec_0 = vs2[7 : 0];
  assign input_data2_vec_1 = vs2[15 : 8];
  assign input_data2_vec_2 = vs2[23 : 16];
  assign input_data2_vec_3 = vs2[31 : 24];
  assign input_data2_vec_4 = vs2[39 : 32];
  assign input_data2_vec_5 = vs2[47 : 40];
  assign input_data2_vec_6 = vs2[55 : 48];
  assign input_data2_vec_7 = vs2[63 : 56];
  assign input_data2_vec_8 = vs2[71 : 64];
  assign input_data2_vec_9 = vs2[79 : 72];
  assign input_data2_vec_10 = vs2[87 : 80];
  assign input_data2_vec_11 = vs2[95 : 88];
  assign input_data2_vec_12 = vs2[103 : 96];
  assign input_data2_vec_13 = vs2[111 : 104];
  assign input_data2_vec_14 = vs2[119 : 112];
  assign input_data2_vec_15 = vs2[127 : 120];
  assign input_data1_val = {1'b0,tmp_input_data1_val};
  assign input_data2_val = {1'b0,tmp_input_data2_val};
  assign offset1 = {1'd0, tmp_offset1};
  assign offset2 = {1'd0, tmp_offset2};
  assign shift_out = rs3[7 : 0];
  assign tmp_mul1_state_in = (curr_state == MUL1);
  assign mul1_state_in = (tmp_mul1_state_in && (! tmp_mul1_state_in_1));
  assign tmp_mul2_state_in = (curr_state == MUL2);
  assign mul2_state_in = (tmp_mul2_state_in && (! tmp_mul2_state_in_1));
  assign mul1_mul_end = ((curr_state == MUL1) && mul_end_in);
  assign mul2_mul_end = ((curr_state == MUL2) && mul_end_in);
  assign mul_start_out = (mul1_state_in || mul2_state_in);
  assign end_1 = (curr_state == ADD);
  assign skipadd_out = (end_1 ? sum_reg : 32'h00000000);
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = MUL1;
        end
      end
      MUL1 : begin
        if(mul_end_in) begin
          next_state = MUL2;
        end
      end
      MUL2 : begin
        if(mul_end_in) begin
          next_state = ADD;
        end
      end
      default : begin
        next_state = IDLE;
      end
    endcase
  end

  always @(*) begin
    mul_pinA_out = 32'h00000000;
    case(curr_state)
      MUL1 : begin
        mul_pinA_out = {{23{tmp_mul_pinA_out[8]}}, tmp_mul_pinA_out};
      end
      MUL2 : begin
        mul_pinA_out = {{23{tmp_mul_pinA_out_3[8]}}, tmp_mul_pinA_out_3};
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mul_pinB_out = 32'h00000000;
    case(curr_state)
      MUL1 : begin
        mul_pinB_out = rs1;
      end
      MUL2 : begin
        mul_pinB_out = rs2;
      end
      default : begin
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      sum_reg <= 32'h00000000;
      curr_state <= IDLE;
    end else begin
      curr_state <= next_state;
      if(mul1_mul_end) begin
        sum_reg <= mul_dout_in[31 : 0];
      end else begin
        if(mul2_mul_end) begin
          sum_reg <= ($signed(tmp_sum_reg) + $signed(sum_reg));
        end
      end
    end
  end

  always @(posedge clk) begin
    tmp_mul1_state_in_1 <= tmp_mul1_state_in;
    tmp_mul2_state_in_1 <= tmp_mul2_state_in;
  end


endmodule

module restoring_div_radix4 (
  input  wire          din_vld,
  input  wire [15:0]   dinA,
  input  wire [7:0]    dinB,
  output wire          dout_vld,
  output wire [16:0]   quot,
  output wire [7:0]    remainder,
  input  wire          clk,
  input  wire          resetn
);

  wire       [15:0]   tmp_dinA_abs;
  wire       [15:0]   tmp_dinA_abs_1;
  wire       [15:0]   tmp_dinA_abs_2;
  wire       [0:0]    tmp_dinA_abs_3;
  wire       [7:0]    tmp_dinB_abs;
  wire       [7:0]    tmp_dinB_abs_1;
  wire       [7:0]    tmp_dinB_abs_2;
  wire       [0:0]    tmp_dinB_abs_3;
  wire       [7:0]    tmp_divisior;
  wire       [9:0]    tmp_p_r_minus_d;
  wire       [9:0]    tmp_p_r_minus_d_1;
  wire       [9:0]    tmp_p_r_minus_d_2;
  wire       [9:0]    tmp_p_r_minus_2d;
  wire       [9:0]    tmp_p_r_minus_2d_1;
  wire       [9:0]    tmp_p_r_minus_2d_2;
  wire       [9:0]    tmp_p_r_minus_2d_3;
  wire       [9:0]    tmp_p_r_minus_3d;
  wire       [9:0]    tmp_p_r_minus_3d_1;
  wire       [9:0]    tmp_p_r_minus_3d_2;
  wire       [9:0]    tmp_p_r_minus_3d_3;
  wire       [7:0]    tmp_remainder;
  wire       [7:0]    tmp_remainder_1;
  wire       [7:0]    tmp_remainder_2;
  wire       [16:0]   tmp_quot;
  wire       [15:0]   tmp_quot_1;
  wire       [16:0]   tmp_quot_2;
  wire                sign_out;
  wire       [15:0]   dinA_abs;
  wire       [7:0]    dinB_abs;
  reg        [15:0]   quotient;
  reg        [9:0]    divisior;
  reg        [25:0]   p_remainder;
  wire       [25:0]   p_r_shift;
  wire       [9:0]    p_r_calpart;
  wire       [9:0]    p_r_minus_d;
  wire       [9:0]    p_r_minus_2d;
  wire       [9:0]    p_r_minus_3d;
  reg        [9:0]    p_r_part_next;
  wire       [2:0]    deside_bits;
  reg        [1:0]    quot_updata_bits;
  reg        [2:0]    control_cnt;
  reg                 doing;
  wire                finish_pulse;
  wire       [7:0]    remainder_abs;
  reg                 finish_pulse_regNext;

  assign tmp_dinA_abs = (dinA[15] ? tmp_dinA_abs_1 : dinA);
  assign tmp_dinA_abs_1 = (~ dinA);
  assign tmp_dinA_abs_3 = dinA[15];
  assign tmp_dinA_abs_2 = {15'd0, tmp_dinA_abs_3};
  assign tmp_dinB_abs = (dinB[7] ? tmp_dinB_abs_1 : dinB);
  assign tmp_dinB_abs_1 = (~ dinB);
  assign tmp_dinB_abs_3 = dinB[7];
  assign tmp_dinB_abs_2 = {7'd0, tmp_dinB_abs_3};
  assign tmp_divisior = dinB_abs;
  assign tmp_p_r_minus_d = ($signed(tmp_p_r_minus_d_1) - $signed(tmp_p_r_minus_d_2));
  assign tmp_p_r_minus_d_1 = p_r_calpart;
  assign tmp_p_r_minus_d_2 = divisior;
  assign tmp_p_r_minus_2d = ($signed(tmp_p_r_minus_2d_1) - $signed(tmp_p_r_minus_2d_2));
  assign tmp_p_r_minus_2d_1 = p_r_calpart;
  assign tmp_p_r_minus_2d_2 = (tmp_p_r_minus_2d_3 <<< 1);
  assign tmp_p_r_minus_2d_3 = divisior;
  assign tmp_p_r_minus_3d = ($signed(tmp_p_r_minus_3d_1) - $signed(tmp_p_r_minus_3d_2));
  assign tmp_p_r_minus_3d_1 = p_r_minus_d;
  assign tmp_p_r_minus_3d_2 = (tmp_p_r_minus_3d_3 <<< 1);
  assign tmp_p_r_minus_3d_3 = divisior;
  assign tmp_remainder = tmp_remainder_1;
  assign tmp_remainder_1 = ((~ remainder_abs) + 8'h01);
  assign tmp_remainder_2 = remainder_abs;
  assign tmp_quot = {1'b1,tmp_quot_1};
  assign tmp_quot_1 = ((~ quotient) + 16'h0001);
  assign tmp_quot_2 = {1'b0,quotient};
  assign sign_out = (dinA[15] ^ dinB[7]);
  assign dinA_abs = (tmp_dinA_abs + tmp_dinA_abs_2);
  assign dinB_abs = (tmp_dinB_abs + tmp_dinB_abs_2);
  assign p_r_shift = (p_remainder <<< 2);
  assign p_r_calpart = p_r_shift[25 : 16];
  assign p_r_minus_d = tmp_p_r_minus_d;
  assign p_r_minus_2d = tmp_p_r_minus_2d;
  assign p_r_minus_3d = tmp_p_r_minus_3d;
  assign deside_bits = {{p_r_minus_d[9],p_r_minus_2d[9]},p_r_minus_3d[9]};
  always @(*) begin
    case(deside_bits)
      3'b000 : begin
        p_r_part_next = p_r_minus_3d;
      end
      3'b001 : begin
        p_r_part_next = p_r_minus_2d;
      end
      3'b010, 3'b011 : begin
        p_r_part_next = p_r_minus_d;
      end
      default : begin
        p_r_part_next = p_r_calpart;
      end
    endcase
  end

  always @(*) begin
    case(deside_bits)
      3'b000 : begin
        quot_updata_bits = 2'b11;
      end
      3'b001 : begin
        quot_updata_bits = 2'b10;
      end
      3'b010, 3'b011 : begin
        quot_updata_bits = 2'b01;
      end
      default : begin
        quot_updata_bits = 2'b00;
      end
    endcase
  end

  assign finish_pulse = (control_cnt == 3'b111);
  assign remainder_abs = p_remainder[23 : 16];
  assign remainder = (dinB[7] ? tmp_remainder : tmp_remainder_2);
  assign quot = (sign_out ? tmp_quot : tmp_quot_2);
  assign dout_vld = finish_pulse_regNext;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      quotient <= 16'h0000;
      divisior <= 10'h000;
      p_remainder <= 26'h0000000;
      control_cnt <= 3'b000;
      doing <= 1'b0;
      finish_pulse_regNext <= 1'b0;
    end else begin
      if(din_vld) begin
        divisior <= {2'd0, tmp_divisior};
      end
      if(din_vld) begin
        doing <= 1'b1;
      end else begin
        if(finish_pulse) begin
          doing <= 1'b0;
        end
      end
      if(din_vld) begin
        control_cnt <= 3'b000;
      end else begin
        if(doing) begin
          control_cnt <= (control_cnt + 3'b001);
        end else begin
          if(finish_pulse) begin
            control_cnt <= 3'b000;
          end
        end
      end
      if(din_vld) begin
        p_remainder <= {10'h000,dinA_abs};
      end else begin
        if(doing) begin
          p_remainder <= {p_r_part_next,p_r_shift[15 : 0]};
        end
      end
      if(din_vld) begin
        quotient[15 : 14] <= 2'b00;
      end else begin
        if(doing) begin
          if((control_cnt == 3'b000)) begin
            quotient[15 : 14] <= quot_updata_bits;
          end
        end
      end
      if(din_vld) begin
        quotient[13 : 12] <= 2'b00;
      end else begin
        if(doing) begin
          if((control_cnt == 3'b001)) begin
            quotient[13 : 12] <= quot_updata_bits;
          end
        end
      end
      if(din_vld) begin
        quotient[11 : 10] <= 2'b00;
      end else begin
        if(doing) begin
          if((control_cnt == 3'b010)) begin
            quotient[11 : 10] <= quot_updata_bits;
          end
        end
      end
      if(din_vld) begin
        quotient[9 : 8] <= 2'b00;
      end else begin
        if(doing) begin
          if((control_cnt == 3'b011)) begin
            quotient[9 : 8] <= quot_updata_bits;
          end
        end
      end
      if(din_vld) begin
        quotient[7 : 6] <= 2'b00;
      end else begin
        if(doing) begin
          if((control_cnt == 3'b100)) begin
            quotient[7 : 6] <= quot_updata_bits;
          end
        end
      end
      if(din_vld) begin
        quotient[5 : 4] <= 2'b00;
      end else begin
        if(doing) begin
          if((control_cnt == 3'b101)) begin
            quotient[5 : 4] <= quot_updata_bits;
          end
        end
      end
      if(din_vld) begin
        quotient[3 : 2] <= 2'b00;
      end else begin
        if(doing) begin
          if((control_cnt == 3'b110)) begin
            quotient[3 : 2] <= quot_updata_bits;
          end
        end
      end
      if(din_vld) begin
        quotient[1 : 0] <= 2'b00;
      end else begin
        if(doing) begin
          if((control_cnt == 3'b111)) begin
            quotient[1 : 0] <= quot_updata_bits;
          end
        end
      end
      finish_pulse_regNext <= finish_pulse;
    end
  end


endmodule

module booth4 (
  input  wire          io_din_vld,
  input  wire [31:0]   io_dinA,
  input  wire [31:0]   io_dinB,
  output wire          io_dout_vld,
  output wire          io_cal_finish,
  output wire [63:0]   io_dout,
  input  wire          clk,
  input  wire          resetn
);

  wire       [66:0]   tmp_aftershift;
  wire       [66:0]   tmp_aftershift_1;
  reg        [31:0]   Breg;
  reg        [66:0]   shiftReg;
  wire       [2:0]    flag_bits;
  wire       [33:0]   NegativeB;
  wire       [33:0]   Negative2B;
  wire       [33:0]   PositiveB;
  wire       [33:0]   Positive2B;
  wire       [33:0]   AddB;
  wire       [33:0]   Add2B;
  wire       [33:0]   MinusB;
  wire       [33:0]   Minus2B;
  reg        [3:0]    cal_cnt;
  reg                 cal_en;
  wire       [32:0]   shiftReg_low;
  wire       [33:0]   shiftReg_high;
  wire                cal_cnt_ov_flag;
  reg        [33:0]   beforeshift;
  wire       [66:0]   aftershift;
  reg                 cal_en_regNext;

  assign tmp_aftershift = ($signed(tmp_aftershift_1) >>> 2);
  assign tmp_aftershift_1 = {beforeshift,shiftReg_low};
  assign flag_bits = shiftReg[2 : 0];
  assign NegativeB = (- PositiveB);
  assign PositiveB = {{2{Breg[31]}}, Breg};
  assign Negative2B = (NegativeB <<< 1);
  assign Positive2B = (PositiveB <<< 1);
  assign shiftReg_low = shiftReg[32 : 0];
  assign shiftReg_high = shiftReg[66 : 33];
  assign AddB = ($signed(shiftReg_high) + $signed(PositiveB));
  assign Add2B = ($signed(shiftReg_high) + $signed(Positive2B));
  assign MinusB = ($signed(shiftReg_high) + $signed(NegativeB));
  assign Minus2B = ($signed(shiftReg_high) + $signed(Negative2B));
  assign cal_cnt_ov_flag = (cal_cnt == 4'b1111);
  assign io_cal_finish = (cal_cnt_ov_flag && cal_en);
  always @(*) begin
    case(flag_bits)
      3'b000, 3'b111 : begin
        beforeshift = shiftReg_high;
      end
      3'b001, 3'b010 : begin
        beforeshift = AddB;
      end
      3'b101, 3'b110 : begin
        beforeshift = MinusB;
      end
      3'b011 : begin
        beforeshift = Add2B;
      end
      default : begin
        beforeshift = Minus2B;
      end
    endcase
  end

  assign aftershift = tmp_aftershift;
  assign io_dout_vld = ((! cal_en) && cal_en_regNext);
  assign io_dout = shiftReg[64 : 1];
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      Breg <= 32'h00000000;
      shiftReg <= 67'h00000000000000000;
      cal_cnt <= 4'b0000;
      cal_en <= 1'b0;
    end else begin
      if(io_din_vld) begin
        cal_en <= 1'b1;
      end else begin
        if(cal_cnt_ov_flag) begin
          cal_en <= 1'b0;
        end
      end
      if(cal_en) begin
        cal_cnt <= (cal_cnt + 4'b0001);
      end else begin
        if(io_din_vld) begin
          cal_cnt <= 4'b0000;
        end
      end
      if(io_din_vld) begin
        shiftReg <= {{34'h000000000,io_dinA},1'b0};
        Breg <= io_dinB;
      end else begin
        if(cal_en) begin
          shiftReg <= aftershift;
        end
      end
    end
  end

  always @(posedge clk) begin
    cal_en_regNext <= cal_en;
  end


endmodule

module AdderWithSub_1cycle (
  input  wire          sub_en,
  input  wire [31:0]   dinA,
  input  wire [31:0]   dinB,
  output wire [31:0]   dout
);

  wire       [31:0]   tmp_dinB_tmp;
  wire       [31:0]   tmp_dinB_tmp_1;
  wire       [31:0]   dinB_tmp;

  assign tmp_dinB_tmp = ($signed(tmp_dinB_tmp_1) + $signed(32'h00000001));
  assign tmp_dinB_tmp_1 = (~ dinB);
  assign dinB_tmp = (sub_en ? tmp_dinB_tmp : dinB);
  assign dout = ($signed(dinA) + $signed(dinB_tmp));

endmodule

module adder_1cycle_14 (
  input  wire [19:0]   dinA,
  input  wire [19:0]   dinB,
  output wire [20:0]   dout
);

  wire       [20:0]   tmp_dout;
  wire       [20:0]   tmp_dout_1;

  assign tmp_dout = {dinA[19],dinA};
  assign tmp_dout_1 = {dinB[19],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1));

endmodule

//adder_1cycle_13 replaced by adder_1cycle_12

module adder_1cycle_12 (
  input  wire [18:0]   dinA,
  input  wire [18:0]   dinB,
  output wire [19:0]   dout
);

  wire       [19:0]   tmp_dout;
  wire       [19:0]   tmp_dout_1;

  assign tmp_dout = {dinA[18],dinA};
  assign tmp_dout_1 = {dinB[18],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1));

endmodule

//adder_1cycle_11 replaced by adder_1cycle_8

//adder_1cycle_10 replaced by adder_1cycle_8

//adder_1cycle_9 replaced by adder_1cycle_8

module adder_1cycle_8 (
  input  wire [17:0]   dinA,
  input  wire [17:0]   dinB,
  output wire [18:0]   dout
);

  wire       [18:0]   tmp_dout;
  wire       [18:0]   tmp_dout_1;

  assign tmp_dout = {dinA[17],dinA};
  assign tmp_dout_1 = {dinB[17],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1));

endmodule

//adder_1cycle_7 replaced by adder_1cycle

//adder_1cycle_6 replaced by adder_1cycle

//adder_1cycle_5 replaced by adder_1cycle

//adder_1cycle_4 replaced by adder_1cycle

//adder_1cycle_3 replaced by adder_1cycle

//adder_1cycle_2 replaced by adder_1cycle

//adder_1cycle_1 replaced by adder_1cycle

module adder_1cycle (
  input  wire [16:0]   dinA,
  input  wire [16:0]   dinB,
  output wire [17:0]   dout
);

  wire       [17:0]   tmp_dout;
  wire       [17:0]   tmp_dout_1;

  assign tmp_dout = {dinA[16],dinA};
  assign tmp_dout_1 = {dinB[16],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1));

endmodule

//mul_1cycle_15 replaced by mul_1cycle

//mul_1cycle_14 replaced by mul_1cycle

//mul_1cycle_13 replaced by mul_1cycle

//mul_1cycle_12 replaced by mul_1cycle

//mul_1cycle_11 replaced by mul_1cycle

//mul_1cycle_10 replaced by mul_1cycle

//mul_1cycle_9 replaced by mul_1cycle

//mul_1cycle_8 replaced by mul_1cycle

//mul_1cycle_7 replaced by mul_1cycle

//mul_1cycle_6 replaced by mul_1cycle

//mul_1cycle_5 replaced by mul_1cycle

//mul_1cycle_4 replaced by mul_1cycle

//mul_1cycle_3 replaced by mul_1cycle

//mul_1cycle_2 replaced by mul_1cycle

//mul_1cycle_1 replaced by mul_1cycle

module mul_1cycle (
  input  wire [8:0]    dinA,
  input  wire [7:0]    dinB,
  output wire [16:0]   dout
);


  assign dout = ($signed(dinA) * $signed(dinB));

endmodule

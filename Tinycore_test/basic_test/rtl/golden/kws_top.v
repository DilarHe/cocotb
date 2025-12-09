// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : kws_top
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps

module kws_top (
  input               kws_enable,
  input      [15:0]   pcm16k_in,
  input               pcm16k_vld,
  input               rg_kws_fb_sys_clken,
  input               rg_kws_fb_lp_filter_en,
  input               rg_kws_fb_window_en,
  input               rg_kws_fb_vad_en,
  input               rg_kws_fb_fbank_en,
  input               rg_kws_fb_debug_rx_en,
  input      [15:0]   rg_kws_fb_vad_energy_threshold,
  input      [7:0]    rg_kws_fb_vad_hangover,
  input      [15:0]   rg_kws_fb_quant_scale,
  input      [7:0]    rg_kws_fb_quant_zerpoint,
  input      [4:0]    rg_kws_fb_quant_shift,
  output     [31:0]   nn_layer_done_state,
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
  output              pcm_mb0_rd,
  output              pcm_mb0_wr,
  output     [7:0]    pcm_mb0_addr,
  output     [15:0]   pcm_mb0_wdata,
  input      [15:0]   pcm_mb0_rdata,
  output              pcm_mb1_rd,
  output              pcm_mb1_wr,
  output     [7:0]    pcm_mb1_addr,
  output     [15:0]   pcm_mb1_wdata,
  input      [15:0]   pcm_mb1_rdata,
  output              pcm_mb2_rd,
  output              pcm_mb2_wr,
  output     [7:0]    pcm_mb2_addr,
  output     [15:0]   pcm_mb2_wdata,
  input      [15:0]   pcm_mb2_rdata,
  output              highBandWidth_fb_mem_rd,
  output              highBandWidth_fb_mem_wr,
  output     [6:0]    highBandWidth_fb_mem_addr,
  output     [127:0]  highBandWidth_fb_mem_wdata,
  input      [127:0]  highBandWidth_fb_mem_rdata,
  output              highBandWidth_a_mem_rd,
  output              highBandWidth_a_mem_wr,
  output     [6:0]    highBandWidth_a_mem_addr,
  output     [127:0]  highBandWidth_a_mem_wdata,
  input      [127:0]  highBandWidth_a_mem_rdata,
  output              highBandWidth_w_mem_rd,
  output              highBandWidth_w_mem_wr,
  output     [9:0]    highBandWidth_w_mem_addr,
  output     [127:0]  highBandWidth_w_mem_wdata,
  input      [127:0]  highBandWidth_w_mem_rdata,
  output              nn_active,
  output              pcm_pingpong_flag,
  output              pcm_buff_ov_int,
  output              kws_out_int,
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
  output     [31:0]   x_0,
  output     [31:0]   x_1,
  output     [31:0]   x_2,
  output     [31:0]   x_3,
  output     [31:0]   x_4,
  output     [31:0]   x_5,
  output     [31:0]   x_6,
  output     [31:0]   x_7,
  output     [31:0]   x_8,
  output     [31:0]   x_9,
  output     [31:0]   x_10,
  output     [31:0]   x_11,
  output     [31:0]   x_12,
  output     [31:0]   x_13,
  output     [31:0]   x_14,
  output     [31:0]   x_15,
  output     [31:0]   x_16,
  output     [31:0]   x_17,
  output     [31:0]   x_18,
  output     [31:0]   x_19,
  output     [31:0]   x_20,
  output     [31:0]   x_21,
  output     [31:0]   x_22,
  output     [31:0]   x_23,
  output     [31:0]   x_24,
  output     [31:0]   x_25,
  output     [31:0]   x_26,
  output     [31:0]   x_27,
  output     [31:0]   x_28,
  output     [31:0]   x_29,
  output     [31:0]   x_30,
  output     [31:0]   x_31,
  output     [31:0]   lmfb_write_addr_debug,
  input               clk,
  input               resetn
);

  wire                fbank_pcm_mb0_rd;
  wire                fbank_pcm_mb0_wr;
  wire       [15:0]   fbank_pcm_mb0_wdata;
  wire       [7:0]    fbank_pcm_mb0_addr;
  wire                fbank_pcm_mb1_rd;
  wire                fbank_pcm_mb1_wr;
  wire       [15:0]   fbank_pcm_mb1_wdata;
  wire       [7:0]    fbank_pcm_mb1_addr;
  wire                fbank_pcm_mb2_rd;
  wire                fbank_pcm_mb2_wr;
  wire       [15:0]   fbank_pcm_mb2_wdata;
  wire       [7:0]    fbank_pcm_mb2_addr;
  wire                fbank_lmfb_mem_rd;
  wire                fbank_lmfb_mem_wr;
  wire       [127:0]  fbank_lmfb_mem_wdata;
  wire       [6:0]    fbank_lmfb_mem_addr;
  wire       [6:0]    fbank_lmfb_write_addr;
  wire                fbank_fbank_finish;
  wire                fbank_pingpong_flag;
  wire                nn_core_core_end;
  wire                nn_core_kws_out_int;
  wire                nn_core_highBandWidth_fb_mem_rd;
  wire                nn_core_highBandWidth_fb_mem_wr;
  wire       [6:0]    nn_core_highBandWidth_fb_mem_addr;
  wire       [127:0]  nn_core_highBandWidth_fb_mem_wdata;
  wire                nn_core_highBandWidth_a_mem_rd;
  wire                nn_core_highBandWidth_a_mem_wr;
  wire       [6:0]    nn_core_highBandWidth_a_mem_addr;
  wire       [127:0]  nn_core_highBandWidth_a_mem_wdata;
  wire                nn_core_highBandWidth_w_mem_rd;
  wire                nn_core_highBandWidth_w_mem_wr;
  wire       [9:0]    nn_core_highBandWidth_w_mem_addr;
  wire       [127:0]  nn_core_highBandWidth_w_mem_wdata;
  wire       [31:0]   nn_core_nn_layer_done_state;
  wire       [31:0]   nn_core_ro_stack_0;
  wire       [31:0]   nn_core_ro_stack_1;
  wire       [31:0]   nn_core_ro_stack_2;
  wire       [31:0]   nn_core_ro_stack_3;
  wire       [31:0]   nn_core_ro_stack_4;
  wire       [31:0]   nn_core_ro_stack_5;
  wire       [31:0]   nn_core_ro_stack_6;
  wire       [31:0]   nn_core_ro_stack_7;
  wire       [31:0]   nn_core_ro_stack_8;
  wire       [31:0]   nn_core_ro_stack_9;
  wire       [31:0]   nn_core_ro_stack_10;
  wire       [31:0]   nn_core_ro_stack_11;
  wire       [31:0]   nn_core_ro_stack_12;
  wire       [31:0]   nn_core_ro_stack_13;
  wire       [31:0]   nn_core_ro_stack_14;
  wire       [31:0]   nn_core_ro_stack_15;
  wire       [31:0]   nn_core_ro_stack_16;
  wire       [31:0]   nn_core_ro_stack_17;
  wire       [31:0]   nn_core_ro_stack_18;
  wire       [31:0]   nn_core_ro_stack_19;
  wire       [31:0]   nn_core_ro_stack_20;
  wire       [31:0]   nn_core_ro_stack_21;
  wire       [31:0]   nn_core_ro_stack_22;
  wire       [31:0]   nn_core_ro_stack_23;
  wire       [31:0]   nn_core_ro_stack_24;
  wire       [31:0]   nn_core_ro_stack_25;
  wire       [31:0]   nn_core_ro_stack_26;
  wire       [31:0]   nn_core_ro_stack_27;
  wire       [31:0]   nn_core_ro_stack_28;
  wire       [31:0]   nn_core_ro_stack_29;
  wire       [31:0]   nn_core_ro_stack_30;
  wire       [31:0]   nn_core_ro_stack_31;
  wire       [31:0]   nn_core_ro_stack_32;
  wire       [31:0]   nn_core_ro_stack_33;
  wire       [31:0]   nn_core_ro_stack_34;
  wire       [31:0]   nn_core_ro_stack_35;
  wire       [31:0]   nn_core_ro_stack_36;
  wire       [31:0]   nn_core_ro_stack_37;
  wire       [31:0]   nn_core_ro_stack_38;
  wire       [31:0]   nn_core_ro_stack_39;
  wire       [31:0]   nn_core_ro_stack_40;
  wire       [31:0]   nn_core_ro_stack_41;
  wire       [31:0]   nn_core_ro_stack_42;
  wire       [31:0]   nn_core_ro_stack_43;
  wire       [31:0]   nn_core_ro_stack_44;
  wire       [31:0]   nn_core_ro_stack_45;
  wire       [31:0]   nn_core_ro_stack_46;
  wire       [31:0]   nn_core_ro_stack_47;
  wire       [31:0]   nn_core_ro_stack_48;
  wire       [31:0]   nn_core_ro_stack_49;
  wire       [31:0]   nn_core_ro_stack_50;
  wire       [31:0]   nn_core_ro_stack_51;
  wire       [31:0]   nn_core_ro_stack_52;
  wire       [31:0]   nn_core_ro_stack_53;
  wire       [31:0]   nn_core_x_0;
  wire       [31:0]   nn_core_x_1;
  wire       [31:0]   nn_core_x_2;
  wire       [31:0]   nn_core_x_3;
  wire       [31:0]   nn_core_x_4;
  wire       [31:0]   nn_core_x_5;
  wire       [31:0]   nn_core_x_6;
  wire       [31:0]   nn_core_x_7;
  wire       [31:0]   nn_core_x_8;
  wire       [31:0]   nn_core_x_9;
  wire       [31:0]   nn_core_x_10;
  wire       [31:0]   nn_core_x_11;
  wire       [31:0]   nn_core_x_12;
  wire       [31:0]   nn_core_x_13;
  wire       [31:0]   nn_core_x_14;
  wire       [31:0]   nn_core_x_15;
  wire       [31:0]   nn_core_x_16;
  wire       [31:0]   nn_core_x_17;
  wire       [31:0]   nn_core_x_18;
  wire       [31:0]   nn_core_x_19;
  wire       [31:0]   nn_core_x_20;
  wire       [31:0]   nn_core_x_21;
  wire       [31:0]   nn_core_x_22;
  wire       [31:0]   nn_core_x_23;
  wire       [31:0]   nn_core_x_24;
  wire       [31:0]   nn_core_x_25;
  wire       [31:0]   nn_core_x_26;
  wire       [31:0]   nn_core_x_27;
  wire       [31:0]   nn_core_x_28;
  wire       [31:0]   nn_core_x_29;
  wire       [31:0]   nn_core_x_30;
  wire       [31:0]   nn_core_x_31;
  wire                nn_cken_enable_out;
  wire                lmfb_fb_mmeif_rd;
  wire                lmfb_fb_mmeif_wr;
  wire       [6:0]    lmfb_fb_mmeif_addr;
  wire       [127:0]  lmfb_fb_mmeif_wdata;
  wire       [127:0]  lmfb_fb_mmeif_rdata;
  wire       [6:0]    lmfb_write_addr;
  wire                fbank_finish;
  wire                fbank_pcm_in_vld;
  reg                 toplevel_fbank_pingpong_flag_regNext;
  reg                 core_start;
  reg        [6:0]    lmfb_base_addr;
  wire                lmfb_nn_memif_mem_rd;
  wire                lmfb_nn_memif_mem_wr;
  wire       [6:0]    lmfb_nn_memif_mem_addr;
  wire       [127:0]  lmfb_nn_memif_mem_wdata;
  wire       [127:0]  lmfb_nn_memif_mem_rdata;
  wire       [7:0]    base_add_fbank_mem_addr;
  wire       [7:0]    turnback_fbank_mem_addr;
  wire                fbank_mem_addr_ov_flag;
  wire       [6:0]    true_fbank_mem_addr;
  wire                core_end;

  fbank_top fbank (
    .kws_enable                     (kws_enable                          ), //i
    .debug_nn                       (rg_kws_nn_debug_en                  ), //i
    .rg_kws_fb_sys_clken            (rg_kws_fb_sys_clken                 ), //i
    .rg_kws_fb_lp_filter_en         (rg_kws_fb_lp_filter_en              ), //i
    .rg_kws_fb_window_en            (rg_kws_fb_window_en                 ), //i
    .rg_kws_fb_vad_en               (rg_kws_fb_vad_en                    ), //i
    .rg_kws_fb_fbank_en             (rg_kws_fb_fbank_en                  ), //i
    .rg_kws_fb_debug_rx_en          (rg_kws_fb_debug_rx_en               ), //i
    .rg_kws_fb_vad_energy_threshold (rg_kws_fb_vad_energy_threshold[15:0]), //i
    .rg_kws_fb_vad_hangover         (rg_kws_fb_vad_hangover[7:0]         ), //i
    .rg_kws_fb_quant_scale          (rg_kws_fb_quant_scale[15:0]         ), //i
    .rg_kws_fb_quant_zerpoint       (rg_kws_fb_quant_zerpoint[7:0]       ), //i
    .rg_kws_fb_quant_shift          (rg_kws_fb_quant_shift[4:0]          ), //i
    .pcm16k_in                      (pcm16k_in[15:0]                     ), //i
    .pcm16k_vld                     (fbank_pcm_in_vld                    ), //i
    .pcm_mb0_rd                     (fbank_pcm_mb0_rd                    ), //o
    .pcm_mb0_wr                     (fbank_pcm_mb0_wr                    ), //o
    .pcm_mb0_addr                   (fbank_pcm_mb0_addr[7:0]             ), //o
    .pcm_mb0_wdata                  (fbank_pcm_mb0_wdata[15:0]           ), //o
    .pcm_mb0_rdata                  (pcm_mb0_rdata[15:0]                 ), //i
    .pcm_mb1_rd                     (fbank_pcm_mb1_rd                    ), //o
    .pcm_mb1_wr                     (fbank_pcm_mb1_wr                    ), //o
    .pcm_mb1_addr                   (fbank_pcm_mb1_addr[7:0]             ), //o
    .pcm_mb1_wdata                  (fbank_pcm_mb1_wdata[15:0]           ), //o
    .pcm_mb1_rdata                  (pcm_mb1_rdata[15:0]                 ), //i
    .pcm_mb2_rd                     (fbank_pcm_mb2_rd                    ), //o
    .pcm_mb2_wr                     (fbank_pcm_mb2_wr                    ), //o
    .pcm_mb2_addr                   (fbank_pcm_mb2_addr[7:0]             ), //o
    .pcm_mb2_wdata                  (fbank_pcm_mb2_wdata[15:0]           ), //o
    .pcm_mb2_rdata                  (pcm_mb2_rdata[15:0]                 ), //i
    .lmfb_mem_rd                    (fbank_lmfb_mem_rd                   ), //o
    .lmfb_mem_wr                    (fbank_lmfb_mem_wr                   ), //o
    .lmfb_mem_addr                  (fbank_lmfb_mem_addr[6:0]            ), //o
    .lmfb_mem_wdata                 (fbank_lmfb_mem_wdata[127:0]         ), //o
    .lmfb_mem_rdata                 (lmfb_fb_mmeif_rdata[127:0]          ), //i
    .lmfb_write_addr                (fbank_lmfb_write_addr[6:0]          ), //o
    .fbank_finish                   (fbank_fbank_finish                  ), //o
    .pingpong_flag                  (fbank_pingpong_flag                 ), //o
    .clk                            (clk                                 ), //i
    .resetn                         (resetn                              )  //i
  );
  nn_core_top nn_core (
    .core_start                 (core_start                               ), //i
    .core_end                   (nn_core_core_end                         ), //o
    .kws_out_int                (nn_core_kws_out_int                      ), //o
    .highBandWidth_fb_mem_rd    (nn_core_highBandWidth_fb_mem_rd          ), //o
    .highBandWidth_fb_mem_wr    (nn_core_highBandWidth_fb_mem_wr          ), //o
    .highBandWidth_fb_mem_addr  (nn_core_highBandWidth_fb_mem_addr[6:0]   ), //o
    .highBandWidth_fb_mem_wdata (nn_core_highBandWidth_fb_mem_wdata[127:0]), //o
    .highBandWidth_fb_mem_rdata (lmfb_nn_memif_mem_rdata[127:0]           ), //i
    .highBandWidth_a_mem_rd     (nn_core_highBandWidth_a_mem_rd           ), //o
    .highBandWidth_a_mem_wr     (nn_core_highBandWidth_a_mem_wr           ), //o
    .highBandWidth_a_mem_addr   (nn_core_highBandWidth_a_mem_addr[6:0]    ), //o
    .highBandWidth_a_mem_wdata  (nn_core_highBandWidth_a_mem_wdata[127:0] ), //o
    .highBandWidth_a_mem_rdata  (highBandWidth_a_mem_rdata[127:0]         ), //i
    .highBandWidth_w_mem_rd     (nn_core_highBandWidth_w_mem_rd           ), //o
    .highBandWidth_w_mem_wr     (nn_core_highBandWidth_w_mem_wr           ), //o
    .highBandWidth_w_mem_addr   (nn_core_highBandWidth_w_mem_addr[9:0]    ), //o
    .highBandWidth_w_mem_wdata  (nn_core_highBandWidth_w_mem_wdata[127:0] ), //o
    .highBandWidth_w_mem_rdata  (highBandWidth_w_mem_rdata[127:0]         ), //i
    .rg_kws_nn_nn_en            (rg_kws_nn_nn_en                          ), //i
    .rg_kws_nn_score_thre_0     (rg_kws_nn_score_thre_0[7:0]              ), //i
    .rg_kws_nn_score_thre_1     (rg_kws_nn_score_thre_1[7:0]              ), //i
    .rg_kws_nn_score_thre_2     (rg_kws_nn_score_thre_2[7:0]              ), //i
    .rg_kws_nn_score_thre_3     (rg_kws_nn_score_thre_3[7:0]              ), //i
    .rg_kws_nn_score_thre_4     (rg_kws_nn_score_thre_4[7:0]              ), //i
    .rg_kws_nn_score_thre_5     (rg_kws_nn_score_thre_5[7:0]              ), //i
    .rg_kws_nn_score_thre_6     (rg_kws_nn_score_thre_6[7:0]              ), //i
    .rg_kws_nn_block_num_0      (rg_kws_nn_block_num_0[7:0]               ), //i
    .rg_kws_nn_block_num_1      (rg_kws_nn_block_num_1[7:0]               ), //i
    .rg_kws_nn_eva_num_0        (rg_kws_nn_eva_num_0[7:0]                 ), //i
    .rg_kws_nn_eva_num_1        (rg_kws_nn_eva_num_1[7:0]                 ), //i
    .rg_kws_nn_debug_en         (rg_kws_nn_debug_en                       ), //i
    .rg_kws_nn_nn_break_point   (rg_kws_nn_nn_break_point[10:0]           ), //i
    .nn_layer_done_state        (nn_core_nn_layer_done_state[31:0]        ), //o
    .ro_stack_0                 (nn_core_ro_stack_0[31:0]                 ), //o
    .ro_stack_1                 (nn_core_ro_stack_1[31:0]                 ), //o
    .ro_stack_2                 (nn_core_ro_stack_2[31:0]                 ), //o
    .ro_stack_3                 (nn_core_ro_stack_3[31:0]                 ), //o
    .ro_stack_4                 (nn_core_ro_stack_4[31:0]                 ), //o
    .ro_stack_5                 (nn_core_ro_stack_5[31:0]                 ), //o
    .ro_stack_6                 (nn_core_ro_stack_6[31:0]                 ), //o
    .ro_stack_7                 (nn_core_ro_stack_7[31:0]                 ), //o
    .ro_stack_8                 (nn_core_ro_stack_8[31:0]                 ), //o
    .ro_stack_9                 (nn_core_ro_stack_9[31:0]                 ), //o
    .ro_stack_10                (nn_core_ro_stack_10[31:0]                ), //o
    .ro_stack_11                (nn_core_ro_stack_11[31:0]                ), //o
    .ro_stack_12                (nn_core_ro_stack_12[31:0]                ), //o
    .ro_stack_13                (nn_core_ro_stack_13[31:0]                ), //o
    .ro_stack_14                (nn_core_ro_stack_14[31:0]                ), //o
    .ro_stack_15                (nn_core_ro_stack_15[31:0]                ), //o
    .ro_stack_16                (nn_core_ro_stack_16[31:0]                ), //o
    .ro_stack_17                (nn_core_ro_stack_17[31:0]                ), //o
    .ro_stack_18                (nn_core_ro_stack_18[31:0]                ), //o
    .ro_stack_19                (nn_core_ro_stack_19[31:0]                ), //o
    .ro_stack_20                (nn_core_ro_stack_20[31:0]                ), //o
    .ro_stack_21                (nn_core_ro_stack_21[31:0]                ), //o
    .ro_stack_22                (nn_core_ro_stack_22[31:0]                ), //o
    .ro_stack_23                (nn_core_ro_stack_23[31:0]                ), //o
    .ro_stack_24                (nn_core_ro_stack_24[31:0]                ), //o
    .ro_stack_25                (nn_core_ro_stack_25[31:0]                ), //o
    .ro_stack_26                (nn_core_ro_stack_26[31:0]                ), //o
    .ro_stack_27                (nn_core_ro_stack_27[31:0]                ), //o
    .ro_stack_28                (nn_core_ro_stack_28[31:0]                ), //o
    .ro_stack_29                (nn_core_ro_stack_29[31:0]                ), //o
    .ro_stack_30                (nn_core_ro_stack_30[31:0]                ), //o
    .ro_stack_31                (nn_core_ro_stack_31[31:0]                ), //o
    .ro_stack_32                (nn_core_ro_stack_32[31:0]                ), //o
    .ro_stack_33                (nn_core_ro_stack_33[31:0]                ), //o
    .ro_stack_34                (nn_core_ro_stack_34[31:0]                ), //o
    .ro_stack_35                (nn_core_ro_stack_35[31:0]                ), //o
    .ro_stack_36                (nn_core_ro_stack_36[31:0]                ), //o
    .ro_stack_37                (nn_core_ro_stack_37[31:0]                ), //o
    .ro_stack_38                (nn_core_ro_stack_38[31:0]                ), //o
    .ro_stack_39                (nn_core_ro_stack_39[31:0]                ), //o
    .ro_stack_40                (nn_core_ro_stack_40[31:0]                ), //o
    .ro_stack_41                (nn_core_ro_stack_41[31:0]                ), //o
    .ro_stack_42                (nn_core_ro_stack_42[31:0]                ), //o
    .ro_stack_43                (nn_core_ro_stack_43[31:0]                ), //o
    .ro_stack_44                (nn_core_ro_stack_44[31:0]                ), //o
    .ro_stack_45                (nn_core_ro_stack_45[31:0]                ), //o
    .ro_stack_46                (nn_core_ro_stack_46[31:0]                ), //o
    .ro_stack_47                (nn_core_ro_stack_47[31:0]                ), //o
    .ro_stack_48                (nn_core_ro_stack_48[31:0]                ), //o
    .ro_stack_49                (nn_core_ro_stack_49[31:0]                ), //o
    .ro_stack_50                (nn_core_ro_stack_50[31:0]                ), //o
    .ro_stack_51                (nn_core_ro_stack_51[31:0]                ), //o
    .ro_stack_52                (nn_core_ro_stack_52[31:0]                ), //o
    .ro_stack_53                (nn_core_ro_stack_53[31:0]                ), //o
    .x_0                        (nn_core_x_0[31:0]                        ), //o
    .x_1                        (nn_core_x_1[31:0]                        ), //o
    .x_2                        (nn_core_x_2[31:0]                        ), //o
    .x_3                        (nn_core_x_3[31:0]                        ), //o
    .x_4                        (nn_core_x_4[31:0]                        ), //o
    .x_5                        (nn_core_x_5[31:0]                        ), //o
    .x_6                        (nn_core_x_6[31:0]                        ), //o
    .x_7                        (nn_core_x_7[31:0]                        ), //o
    .x_8                        (nn_core_x_8[31:0]                        ), //o
    .x_9                        (nn_core_x_9[31:0]                        ), //o
    .x_10                       (nn_core_x_10[31:0]                       ), //o
    .x_11                       (nn_core_x_11[31:0]                       ), //o
    .x_12                       (nn_core_x_12[31:0]                       ), //o
    .x_13                       (nn_core_x_13[31:0]                       ), //o
    .x_14                       (nn_core_x_14[31:0]                       ), //o
    .x_15                       (nn_core_x_15[31:0]                       ), //o
    .x_16                       (nn_core_x_16[31:0]                       ), //o
    .x_17                       (nn_core_x_17[31:0]                       ), //o
    .x_18                       (nn_core_x_18[31:0]                       ), //o
    .x_19                       (nn_core_x_19[31:0]                       ), //o
    .x_20                       (nn_core_x_20[31:0]                       ), //o
    .x_21                       (nn_core_x_21[31:0]                       ), //o
    .x_22                       (nn_core_x_22[31:0]                       ), //o
    .x_23                       (nn_core_x_23[31:0]                       ), //o
    .x_24                       (nn_core_x_24[31:0]                       ), //o
    .x_25                       (nn_core_x_25[31:0]                       ), //o
    .x_26                       (nn_core_x_26[31:0]                       ), //o
    .x_27                       (nn_core_x_27[31:0]                       ), //o
    .x_28                       (nn_core_x_28[31:0]                       ), //o
    .x_29                       (nn_core_x_29[31:0]                       ), //o
    .x_30                       (nn_core_x_30[31:0]                       ), //o
    .x_31                       (nn_core_x_31[31:0]                       ), //o
    .clk                        (clk                                      ), //i
    .resetn                     (resetn                                   )  //i
  );
  ck_enable_gen_5 nn_cken (
    .start      (core_start        ), //i
    .finish     (core_end          ), //i
    .enable_out (nn_cken_enable_out), //o
    .clk        (clk               ), //i
    .resetn     (resetn            )  //i
  );
  assign fbank_pcm_in_vld = (pcm16k_vld && (! rg_kws_nn_debug_en)); // @[kws_top.scala 68:20]
  assign pcm_mb0_rd = fbank_pcm_mb0_rd; // @[kws_top.scala 75:20]
  assign pcm_mb0_wr = fbank_pcm_mb0_wr; // @[kws_top.scala 75:20]
  assign pcm_mb0_addr = fbank_pcm_mb0_addr; // @[kws_top.scala 75:20]
  assign pcm_mb0_wdata = fbank_pcm_mb0_wdata; // @[kws_top.scala 75:20]
  assign pcm_mb1_rd = fbank_pcm_mb1_rd; // @[kws_top.scala 76:20]
  assign pcm_mb1_wr = fbank_pcm_mb1_wr; // @[kws_top.scala 76:20]
  assign pcm_mb1_addr = fbank_pcm_mb1_addr; // @[kws_top.scala 76:20]
  assign pcm_mb1_wdata = fbank_pcm_mb1_wdata; // @[kws_top.scala 76:20]
  assign pcm_mb2_rd = fbank_pcm_mb2_rd; // @[kws_top.scala 77:20]
  assign pcm_mb2_wr = fbank_pcm_mb2_wr; // @[kws_top.scala 77:20]
  assign pcm_mb2_addr = fbank_pcm_mb2_addr; // @[kws_top.scala 77:20]
  assign pcm_mb2_wdata = fbank_pcm_mb2_wdata; // @[kws_top.scala 77:20]
  assign lmfb_fb_mmeif_rd = fbank_lmfb_mem_rd; // @[kws_top.scala 78:21]
  assign lmfb_fb_mmeif_wr = fbank_lmfb_mem_wr; // @[kws_top.scala 78:21]
  assign lmfb_fb_mmeif_addr = fbank_lmfb_mem_addr; // @[kws_top.scala 78:21]
  assign lmfb_fb_mmeif_wdata = fbank_lmfb_mem_wdata; // @[kws_top.scala 78:21]
  assign lmfb_write_addr = fbank_lmfb_write_addr; // @[kws_top.scala 79:19]
  assign fbank_finish = fbank_fbank_finish; // @[kws_top.scala 80:16]
  assign pcm_pingpong_flag = fbank_pingpong_flag; // @[kws_top.scala 82:24]
  assign pcm_buff_ov_int = (fbank_pingpong_flag ^ toplevel_fbank_pingpong_flag_regNext); // @[kws_top.scala 83:22]
  assign base_add_fbank_mem_addr = ({1'b0,lmfb_nn_memif_mem_addr} + {1'b0,lmfb_base_addr}); // @[BaseType.scala 299:24]
  assign turnback_fbank_mem_addr = (base_add_fbank_mem_addr - 8'h78); // @[BaseType.scala 299:24]
  assign fbank_mem_addr_ov_flag = turnback_fbank_mem_addr[7]; // @[BaseType.scala 305:24]
  assign true_fbank_mem_addr = (fbank_mem_addr_ov_flag ? base_add_fbank_mem_addr[6 : 0] : turnback_fbank_mem_addr[6 : 0]); // @[kws_top.scala 103:23]
  assign nn_layer_done_state = nn_core_nn_layer_done_state; // @[kws_top.scala 109:26]
  assign highBandWidth_w_mem_rd = nn_core_highBandWidth_w_mem_rd; // @[kws_top.scala 110:30]
  assign highBandWidth_w_mem_wr = nn_core_highBandWidth_w_mem_wr; // @[kws_top.scala 110:30]
  assign highBandWidth_w_mem_addr = nn_core_highBandWidth_w_mem_addr; // @[kws_top.scala 110:30]
  assign highBandWidth_w_mem_wdata = nn_core_highBandWidth_w_mem_wdata; // @[kws_top.scala 110:30]
  assign highBandWidth_a_mem_rd = nn_core_highBandWidth_a_mem_rd; // @[kws_top.scala 111:30]
  assign highBandWidth_a_mem_wr = nn_core_highBandWidth_a_mem_wr; // @[kws_top.scala 111:30]
  assign highBandWidth_a_mem_addr = nn_core_highBandWidth_a_mem_addr; // @[kws_top.scala 111:30]
  assign highBandWidth_a_mem_wdata = nn_core_highBandWidth_a_mem_wdata; // @[kws_top.scala 111:30]
  assign lmfb_nn_memif_mem_rd = nn_core_highBandWidth_fb_mem_rd; // @[kws_top.scala 112:31]
  assign lmfb_nn_memif_mem_wr = nn_core_highBandWidth_fb_mem_wr; // @[kws_top.scala 112:31]
  assign lmfb_nn_memif_mem_addr = nn_core_highBandWidth_fb_mem_addr; // @[kws_top.scala 112:31]
  assign lmfb_nn_memif_mem_wdata = nn_core_highBandWidth_fb_mem_wdata; // @[kws_top.scala 112:31]
  assign core_end = nn_core_core_end; // @[kws_top.scala 115:12]
  assign nn_active = nn_cken_enable_out; // @[kws_top.scala 120:16]
  assign highBandWidth_fb_mem_addr = (true_fbank_mem_addr | lmfb_fb_mmeif_addr); // @[kws_top.scala 122:32]
  assign highBandWidth_fb_mem_wr = (lmfb_nn_memif_mem_wr || lmfb_fb_mmeif_wr); // @[kws_top.scala 123:30]
  assign highBandWidth_fb_mem_rd = lmfb_nn_memif_mem_rd; // @[kws_top.scala 124:30]
  assign highBandWidth_fb_mem_wdata = lmfb_fb_mmeif_wdata; // @[kws_top.scala 125:33]
  assign lmfb_nn_memif_mem_rdata = highBandWidth_fb_mem_rdata; // @[kws_top.scala 127:27]
  assign ro_stack_0 = nn_core_ro_stack_0; // @[kws_top.scala 130:12]
  assign ro_stack_1 = nn_core_ro_stack_1; // @[kws_top.scala 130:12]
  assign ro_stack_2 = nn_core_ro_stack_2; // @[kws_top.scala 130:12]
  assign ro_stack_3 = nn_core_ro_stack_3; // @[kws_top.scala 130:12]
  assign ro_stack_4 = nn_core_ro_stack_4; // @[kws_top.scala 130:12]
  assign ro_stack_5 = nn_core_ro_stack_5; // @[kws_top.scala 130:12]
  assign ro_stack_6 = nn_core_ro_stack_6; // @[kws_top.scala 130:12]
  assign ro_stack_7 = nn_core_ro_stack_7; // @[kws_top.scala 130:12]
  assign ro_stack_8 = nn_core_ro_stack_8; // @[kws_top.scala 130:12]
  assign ro_stack_9 = nn_core_ro_stack_9; // @[kws_top.scala 130:12]
  assign ro_stack_10 = nn_core_ro_stack_10; // @[kws_top.scala 130:12]
  assign ro_stack_11 = nn_core_ro_stack_11; // @[kws_top.scala 130:12]
  assign ro_stack_12 = nn_core_ro_stack_12; // @[kws_top.scala 130:12]
  assign ro_stack_13 = nn_core_ro_stack_13; // @[kws_top.scala 130:12]
  assign ro_stack_14 = nn_core_ro_stack_14; // @[kws_top.scala 130:12]
  assign ro_stack_15 = nn_core_ro_stack_15; // @[kws_top.scala 130:12]
  assign ro_stack_16 = nn_core_ro_stack_16; // @[kws_top.scala 130:12]
  assign ro_stack_17 = nn_core_ro_stack_17; // @[kws_top.scala 130:12]
  assign ro_stack_18 = nn_core_ro_stack_18; // @[kws_top.scala 130:12]
  assign ro_stack_19 = nn_core_ro_stack_19; // @[kws_top.scala 130:12]
  assign ro_stack_20 = nn_core_ro_stack_20; // @[kws_top.scala 130:12]
  assign ro_stack_21 = nn_core_ro_stack_21; // @[kws_top.scala 130:12]
  assign ro_stack_22 = nn_core_ro_stack_22; // @[kws_top.scala 130:12]
  assign ro_stack_23 = nn_core_ro_stack_23; // @[kws_top.scala 130:12]
  assign ro_stack_24 = nn_core_ro_stack_24; // @[kws_top.scala 130:12]
  assign ro_stack_25 = nn_core_ro_stack_25; // @[kws_top.scala 130:12]
  assign ro_stack_26 = nn_core_ro_stack_26; // @[kws_top.scala 130:12]
  assign ro_stack_27 = nn_core_ro_stack_27; // @[kws_top.scala 130:12]
  assign ro_stack_28 = nn_core_ro_stack_28; // @[kws_top.scala 130:12]
  assign ro_stack_29 = nn_core_ro_stack_29; // @[kws_top.scala 130:12]
  assign ro_stack_30 = nn_core_ro_stack_30; // @[kws_top.scala 130:12]
  assign ro_stack_31 = nn_core_ro_stack_31; // @[kws_top.scala 130:12]
  assign ro_stack_32 = nn_core_ro_stack_32; // @[kws_top.scala 130:12]
  assign ro_stack_33 = nn_core_ro_stack_33; // @[kws_top.scala 130:12]
  assign ro_stack_34 = nn_core_ro_stack_34; // @[kws_top.scala 130:12]
  assign ro_stack_35 = nn_core_ro_stack_35; // @[kws_top.scala 130:12]
  assign ro_stack_36 = nn_core_ro_stack_36; // @[kws_top.scala 130:12]
  assign ro_stack_37 = nn_core_ro_stack_37; // @[kws_top.scala 130:12]
  assign ro_stack_38 = nn_core_ro_stack_38; // @[kws_top.scala 130:12]
  assign ro_stack_39 = nn_core_ro_stack_39; // @[kws_top.scala 130:12]
  assign ro_stack_40 = nn_core_ro_stack_40; // @[kws_top.scala 130:12]
  assign ro_stack_41 = nn_core_ro_stack_41; // @[kws_top.scala 130:12]
  assign ro_stack_42 = nn_core_ro_stack_42; // @[kws_top.scala 130:12]
  assign ro_stack_43 = nn_core_ro_stack_43; // @[kws_top.scala 130:12]
  assign ro_stack_44 = nn_core_ro_stack_44; // @[kws_top.scala 130:12]
  assign ro_stack_45 = nn_core_ro_stack_45; // @[kws_top.scala 130:12]
  assign ro_stack_46 = nn_core_ro_stack_46; // @[kws_top.scala 130:12]
  assign ro_stack_47 = nn_core_ro_stack_47; // @[kws_top.scala 130:12]
  assign ro_stack_48 = nn_core_ro_stack_48; // @[kws_top.scala 130:12]
  assign ro_stack_49 = nn_core_ro_stack_49; // @[kws_top.scala 130:12]
  assign ro_stack_50 = nn_core_ro_stack_50; // @[kws_top.scala 130:12]
  assign ro_stack_51 = nn_core_ro_stack_51; // @[kws_top.scala 130:12]
  assign ro_stack_52 = nn_core_ro_stack_52; // @[kws_top.scala 130:12]
  assign ro_stack_53 = nn_core_ro_stack_53; // @[kws_top.scala 130:12]
  assign x_0 = nn_core_x_0; // @[kws_top.scala 133:13]
  assign x_1 = nn_core_x_1; // @[kws_top.scala 133:13]
  assign x_2 = nn_core_x_2; // @[kws_top.scala 133:13]
  assign x_3 = nn_core_x_3; // @[kws_top.scala 133:13]
  assign x_4 = nn_core_x_4; // @[kws_top.scala 133:13]
  assign x_5 = nn_core_x_5; // @[kws_top.scala 133:13]
  assign x_6 = nn_core_x_6; // @[kws_top.scala 133:13]
  assign x_7 = nn_core_x_7; // @[kws_top.scala 133:13]
  assign x_8 = nn_core_x_8; // @[kws_top.scala 133:13]
  assign x_9 = nn_core_x_9; // @[kws_top.scala 133:13]
  assign x_10 = nn_core_x_10; // @[kws_top.scala 133:13]
  assign x_11 = nn_core_x_11; // @[kws_top.scala 133:13]
  assign x_12 = nn_core_x_12; // @[kws_top.scala 133:13]
  assign x_13 = nn_core_x_13; // @[kws_top.scala 133:13]
  assign x_14 = nn_core_x_14; // @[kws_top.scala 133:13]
  assign x_15 = nn_core_x_15; // @[kws_top.scala 133:13]
  assign x_16 = nn_core_x_16; // @[kws_top.scala 133:13]
  assign x_17 = nn_core_x_17; // @[kws_top.scala 133:13]
  assign x_18 = nn_core_x_18; // @[kws_top.scala 133:13]
  assign x_19 = nn_core_x_19; // @[kws_top.scala 133:13]
  assign x_20 = nn_core_x_20; // @[kws_top.scala 133:13]
  assign x_21 = nn_core_x_21; // @[kws_top.scala 133:13]
  assign x_22 = nn_core_x_22; // @[kws_top.scala 133:13]
  assign x_23 = nn_core_x_23; // @[kws_top.scala 133:13]
  assign x_24 = nn_core_x_24; // @[kws_top.scala 133:13]
  assign x_25 = nn_core_x_25; // @[kws_top.scala 133:13]
  assign x_26 = nn_core_x_26; // @[kws_top.scala 133:13]
  assign x_27 = nn_core_x_27; // @[kws_top.scala 133:13]
  assign x_28 = nn_core_x_28; // @[kws_top.scala 133:13]
  assign x_29 = nn_core_x_29; // @[kws_top.scala 133:13]
  assign x_30 = nn_core_x_30; // @[kws_top.scala 133:13]
  assign x_31 = nn_core_x_31; // @[kws_top.scala 133:13]
  assign lmfb_write_addr_debug = {25'd0, lmfb_write_addr}; // @[kws_top.scala 136:25]
  assign kws_out_int = nn_core_kws_out_int; // @[kws_top.scala 138:18]
  always @(posedge clk) begin
    toplevel_fbank_pingpong_flag_regNext <= fbank_pingpong_flag; // @[Reg.scala 39:30]
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      core_start <= 1'b0; // @[Data.scala 400:33]
      lmfb_base_addr <= 7'h0; // @[Data.scala 400:33]
    end else begin
      if(fbank_finish) begin
        if(((((((lmfb_write_addr == 7'h13) || (lmfb_write_addr == 7'h27)) || (lmfb_write_addr == 7'h3b)) || (lmfb_write_addr == 7'h4f)) || (lmfb_write_addr == 7'h63)) || (lmfb_write_addr == 7'h77))) begin
          lmfb_base_addr <= (lmfb_write_addr + 7'h01); // @[kws_top.scala 91:22]
          core_start <= 1'b1; // @[kws_top.scala 92:18]
        end
      end else begin
        core_start <= 1'b0; // @[kws_top.scala 95:16]
      end
    end
  end


endmodule

//ck_enable_gen_5 replaced by ck_enable_gen_5

module nn_core_top (
  input               core_start,
  output              core_end,
  output              kws_out_int,
  output              highBandWidth_fb_mem_rd,
  output              highBandWidth_fb_mem_wr,
  output     [6:0]    highBandWidth_fb_mem_addr,
  output     [127:0]  highBandWidth_fb_mem_wdata,
  input      [127:0]  highBandWidth_fb_mem_rdata,
  output              highBandWidth_a_mem_rd,
  output              highBandWidth_a_mem_wr,
  output     [6:0]    highBandWidth_a_mem_addr,
  output     [127:0]  highBandWidth_a_mem_wdata,
  input      [127:0]  highBandWidth_a_mem_rdata,
  output              highBandWidth_w_mem_rd,
  output              highBandWidth_w_mem_wr,
  output     [9:0]    highBandWidth_w_mem_addr,
  output     [127:0]  highBandWidth_w_mem_wdata,
  input      [127:0]  highBandWidth_w_mem_rdata,
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
  output     [31:0]   nn_layer_done_state,
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
  output     [31:0]   x_0,
  output     [31:0]   x_1,
  output     [31:0]   x_2,
  output     [31:0]   x_3,
  output     [31:0]   x_4,
  output     [31:0]   x_5,
  output     [31:0]   x_6,
  output     [31:0]   x_7,
  output     [31:0]   x_8,
  output     [31:0]   x_9,
  output     [31:0]   x_10,
  output     [31:0]   x_11,
  output     [31:0]   x_12,
  output     [31:0]   x_13,
  output     [31:0]   x_14,
  output     [31:0]   x_15,
  output     [31:0]   x_16,
  output     [31:0]   x_17,
  output     [31:0]   x_18,
  output     [31:0]   x_19,
  output     [31:0]   x_20,
  output     [31:0]   x_21,
  output     [31:0]   x_22,
  output     [31:0]   x_23,
  output     [31:0]   x_24,
  output     [31:0]   x_25,
  output     [31:0]   x_26,
  output     [31:0]   x_27,
  output     [31:0]   x_28,
  output     [31:0]   x_29,
  output     [31:0]   x_30,
  output     [31:0]   x_31,
  input               clk,
  input               resetn
);

  wire                core_core_start;
  wire                core_iram_mem_rd;
  wire                core_iram_mem_wr;
  wire       [10:0]   core_iram_mem_addr;
  wire       [15:0]   core_iram_mem_wdata;
  wire                core_highBandWidth_fb_mem_rd;
  wire                core_highBandWidth_fb_mem_wr;
  wire       [6:0]    core_highBandWidth_fb_mem_addr;
  wire       [127:0]  core_highBandWidth_fb_mem_wdata;
  wire                core_highBandWidth_a_mem_rd;
  wire                core_highBandWidth_a_mem_wr;
  wire       [6:0]    core_highBandWidth_a_mem_addr;
  wire       [127:0]  core_highBandWidth_a_mem_wdata;
  wire                core_highBandWidth_w_mem_rd;
  wire                core_highBandWidth_w_mem_wr;
  wire       [9:0]    core_highBandWidth_w_mem_addr;
  wire       [127:0]  core_highBandWidth_w_mem_wdata;
  wire                core_lowBandWidth_mem_rd;
  wire                core_lowBandWidth_mem_wr;
  wire       [6:0]    core_lowBandWidth_mem_addr;
  wire       [31:0]   core_lowBandWidth_mem_wdata;
  wire                core_core_end;
  wire       [31:0]   core_x_0;
  wire       [31:0]   core_x_1;
  wire       [31:0]   core_x_2;
  wire       [31:0]   core_x_3;
  wire       [31:0]   core_x_4;
  wire       [31:0]   core_x_5;
  wire       [31:0]   core_x_6;
  wire       [31:0]   core_x_7;
  wire       [31:0]   core_x_8;
  wire       [31:0]   core_x_9;
  wire       [31:0]   core_x_10;
  wire       [31:0]   core_x_11;
  wire       [31:0]   core_x_12;
  wire       [31:0]   core_x_13;
  wire       [31:0]   core_x_14;
  wire       [31:0]   core_x_15;
  wire       [31:0]   core_x_16;
  wire       [31:0]   core_x_17;
  wire       [31:0]   core_x_18;
  wire       [31:0]   core_x_19;
  wire       [31:0]   core_x_20;
  wire       [31:0]   core_x_21;
  wire       [31:0]   core_x_22;
  wire       [31:0]   core_x_23;
  wire       [31:0]   core_x_24;
  wire       [31:0]   core_x_25;
  wire       [31:0]   core_x_26;
  wire       [31:0]   core_x_27;
  wire       [31:0]   core_x_28;
  wire       [31:0]   core_x_29;
  wire       [31:0]   core_x_30;
  wire       [31:0]   core_x_31;
  wire       [15:0]   instr_rom_io_irom_if_mem_rdata;
  wire       [31:0]   stack_lowBandWidth_mem_rdata;
  wire                stack_kws_out_is_valid;
  wire       [31:0]   stack_ro_stack_0;
  wire       [31:0]   stack_ro_stack_1;
  wire       [31:0]   stack_ro_stack_2;
  wire       [31:0]   stack_ro_stack_3;
  wire       [31:0]   stack_ro_stack_4;
  wire       [31:0]   stack_ro_stack_5;
  wire       [31:0]   stack_ro_stack_6;
  wire       [31:0]   stack_ro_stack_7;
  wire       [31:0]   stack_ro_stack_8;
  wire       [31:0]   stack_ro_stack_9;
  wire       [31:0]   stack_ro_stack_10;
  wire       [31:0]   stack_ro_stack_11;
  wire       [31:0]   stack_ro_stack_12;
  wire       [31:0]   stack_ro_stack_13;
  wire       [31:0]   stack_ro_stack_14;
  wire       [31:0]   stack_ro_stack_15;
  wire       [31:0]   stack_ro_stack_16;
  wire       [31:0]   stack_ro_stack_17;
  wire       [31:0]   stack_ro_stack_18;
  wire       [31:0]   stack_ro_stack_19;
  wire       [31:0]   stack_ro_stack_20;
  wire       [31:0]   stack_ro_stack_21;
  wire       [31:0]   stack_ro_stack_22;
  wire       [31:0]   stack_ro_stack_23;
  wire       [31:0]   stack_ro_stack_24;
  wire       [31:0]   stack_ro_stack_25;
  wire       [31:0]   stack_ro_stack_26;
  wire       [31:0]   stack_ro_stack_27;
  wire       [31:0]   stack_ro_stack_28;
  wire       [31:0]   stack_ro_stack_29;
  wire       [31:0]   stack_ro_stack_30;
  wire       [31:0]   stack_ro_stack_31;
  wire       [31:0]   stack_ro_stack_32;
  wire       [31:0]   stack_ro_stack_33;
  wire       [31:0]   stack_ro_stack_34;
  wire       [31:0]   stack_ro_stack_35;
  wire       [31:0]   stack_ro_stack_36;
  wire       [31:0]   stack_ro_stack_37;
  wire       [31:0]   stack_ro_stack_38;
  wire       [31:0]   stack_ro_stack_39;
  wire       [31:0]   stack_ro_stack_40;
  wire       [31:0]   stack_ro_stack_41;
  wire       [31:0]   stack_ro_stack_42;
  wire       [31:0]   stack_ro_stack_43;
  wire       [31:0]   stack_ro_stack_44;
  wire       [31:0]   stack_ro_stack_45;
  wire       [31:0]   stack_ro_stack_46;
  wire       [31:0]   stack_ro_stack_47;
  wire       [31:0]   stack_ro_stack_48;
  wire       [31:0]   stack_ro_stack_49;
  wire       [31:0]   stack_ro_stack_50;
  wire       [31:0]   stack_ro_stack_51;
  wire       [31:0]   stack_ro_stack_52;
  wire       [31:0]   stack_ro_stack_53;
  wire                lowBandWidth_mem_rd;
  wire                lowBandWidth_mem_wr;
  wire       [6:0]    lowBandWidth_mem_addr;
  wire       [31:0]   lowBandWidth_mem_wdata;
  wire       [31:0]   lowBandWidth_mem_rdata;
  reg                 nn_core_stack_kws_out_is_valid_regNext;
  reg        [31:0]   nn_done_regs;
  wire                nn_done_sigs_0;
  wire                nn_done_sigs_1;
  wire                nn_done_sigs_2;
  wire                nn_done_sigs_3;
  wire                nn_done_sigs_4;
  wire                nn_done_sigs_5;
  wire                nn_done_sigs_6;
  wire                nn_done_sigs_7;
  wire                nn_done_sigs_8;
  wire                nn_done_sigs_9;
  wire                nn_done_sigs_10;
  wire                nn_done_sigs_11;
  wire                nn_done_sigs_12;
  wire                nn_done_sigs_13;
  wire                nn_done_sigs_14;
  wire                nn_done_sigs_15;
  wire                nn_done_sigs_16;
  wire                nn_done_sigs_17;
  wire                nn_done_sigs_18;
  wire                nn_done_sigs_19;
  wire                nn_done_sigs_20;
  wire                nn_done_sigs_21;
  wire                nn_done_sigs_22;
  wire                nn_done_sigs_23;
  wire                nn_done_sigs_24;
  wire                nn_done_sigs_25;
  wire                nn_done_sigs_26;
  wire                layer_has_done_flag;

  tinyVcore_top core (
    .core_start                 (core_core_start                       ), //i
    .debug_en                   (rg_kws_nn_debug_en                    ), //i
    .debug_break_point          (rg_kws_nn_nn_break_point[10:0]        ), //i
    .iram_mem_rd                (core_iram_mem_rd                      ), //o
    .iram_mem_wr                (core_iram_mem_wr                      ), //o
    .iram_mem_addr              (core_iram_mem_addr[10:0]              ), //o
    .iram_mem_wdata             (core_iram_mem_wdata[15:0]             ), //o
    .iram_mem_rdata             (instr_rom_io_irom_if_mem_rdata[15:0]  ), //i
    .highBandWidth_fb_mem_rd    (core_highBandWidth_fb_mem_rd          ), //o
    .highBandWidth_fb_mem_wr    (core_highBandWidth_fb_mem_wr          ), //o
    .highBandWidth_fb_mem_addr  (core_highBandWidth_fb_mem_addr[6:0]   ), //o
    .highBandWidth_fb_mem_wdata (core_highBandWidth_fb_mem_wdata[127:0]), //o
    .highBandWidth_fb_mem_rdata (highBandWidth_fb_mem_rdata[127:0]     ), //i
    .highBandWidth_a_mem_rd     (core_highBandWidth_a_mem_rd           ), //o
    .highBandWidth_a_mem_wr     (core_highBandWidth_a_mem_wr           ), //o
    .highBandWidth_a_mem_addr   (core_highBandWidth_a_mem_addr[6:0]    ), //o
    .highBandWidth_a_mem_wdata  (core_highBandWidth_a_mem_wdata[127:0] ), //o
    .highBandWidth_a_mem_rdata  (highBandWidth_a_mem_rdata[127:0]      ), //i
    .highBandWidth_w_mem_rd     (core_highBandWidth_w_mem_rd           ), //o
    .highBandWidth_w_mem_wr     (core_highBandWidth_w_mem_wr           ), //o
    .highBandWidth_w_mem_addr   (core_highBandWidth_w_mem_addr[9:0]    ), //o
    .highBandWidth_w_mem_wdata  (core_highBandWidth_w_mem_wdata[127:0] ), //o
    .highBandWidth_w_mem_rdata  (highBandWidth_w_mem_rdata[127:0]      ), //i
    .lowBandWidth_mem_rd        (core_lowBandWidth_mem_rd              ), //o
    .lowBandWidth_mem_wr        (core_lowBandWidth_mem_wr              ), //o
    .lowBandWidth_mem_addr      (core_lowBandWidth_mem_addr[6:0]       ), //o
    .lowBandWidth_mem_wdata     (core_lowBandWidth_mem_wdata[31:0]     ), //o
    .lowBandWidth_mem_rdata     (lowBandWidth_mem_rdata[31:0]          ), //i
    .core_end                   (core_core_end                         ), //o
    .x_0                        (core_x_0[31:0]                        ), //o
    .x_1                        (core_x_1[31:0]                        ), //o
    .x_2                        (core_x_2[31:0]                        ), //o
    .x_3                        (core_x_3[31:0]                        ), //o
    .x_4                        (core_x_4[31:0]                        ), //o
    .x_5                        (core_x_5[31:0]                        ), //o
    .x_6                        (core_x_6[31:0]                        ), //o
    .x_7                        (core_x_7[31:0]                        ), //o
    .x_8                        (core_x_8[31:0]                        ), //o
    .x_9                        (core_x_9[31:0]                        ), //o
    .x_10                       (core_x_10[31:0]                       ), //o
    .x_11                       (core_x_11[31:0]                       ), //o
    .x_12                       (core_x_12[31:0]                       ), //o
    .x_13                       (core_x_13[31:0]                       ), //o
    .x_14                       (core_x_14[31:0]                       ), //o
    .x_15                       (core_x_15[31:0]                       ), //o
    .x_16                       (core_x_16[31:0]                       ), //o
    .x_17                       (core_x_17[31:0]                       ), //o
    .x_18                       (core_x_18[31:0]                       ), //o
    .x_19                       (core_x_19[31:0]                       ), //o
    .x_20                       (core_x_20[31:0]                       ), //o
    .x_21                       (core_x_21[31:0]                       ), //o
    .x_22                       (core_x_22[31:0]                       ), //o
    .x_23                       (core_x_23[31:0]                       ), //o
    .x_24                       (core_x_24[31:0]                       ), //o
    .x_25                       (core_x_25[31:0]                       ), //o
    .x_26                       (core_x_26[31:0]                       ), //o
    .x_27                       (core_x_27[31:0]                       ), //o
    .x_28                       (core_x_28[31:0]                       ), //o
    .x_29                       (core_x_29[31:0]                       ), //o
    .x_30                       (core_x_30[31:0]                       ), //o
    .x_31                       (core_x_31[31:0]                       ), //o
    .clk                        (clk                                   ), //i
    .resetn                     (resetn                                )  //i
  );
  irom instr_rom (
    .io_irom_if_mem_rd    (core_iram_mem_rd                    ), //i
    .io_irom_if_mem_wr    (core_iram_mem_wr                    ), //i
    .io_irom_if_mem_addr  (core_iram_mem_addr[10:0]            ), //i
    .io_irom_if_mem_wdata (core_iram_mem_wdata[15:0]           ), //i
    .io_irom_if_mem_rdata (instr_rom_io_irom_if_mem_rdata[15:0]), //o
    .clk                  (clk                                 ), //i
    .resetn               (resetn                              )  //i
  );
  core_stack_regfile stack (
    .lowBandWidth_mem_rd      (lowBandWidth_mem_rd               ), //i
    .lowBandWidth_mem_wr      (lowBandWidth_mem_wr               ), //i
    .lowBandWidth_mem_addr    (lowBandWidth_mem_addr[6:0]        ), //i
    .lowBandWidth_mem_wdata   (lowBandWidth_mem_wdata[31:0]      ), //i
    .lowBandWidth_mem_rdata   (stack_lowBandWidth_mem_rdata[31:0]), //o
    .rg_kws_nn_nn_en          (rg_kws_nn_nn_en                   ), //i
    .rg_kws_nn_score_thre_0   (rg_kws_nn_score_thre_0[7:0]       ), //i
    .rg_kws_nn_score_thre_1   (rg_kws_nn_score_thre_1[7:0]       ), //i
    .rg_kws_nn_score_thre_2   (rg_kws_nn_score_thre_2[7:0]       ), //i
    .rg_kws_nn_score_thre_3   (rg_kws_nn_score_thre_3[7:0]       ), //i
    .rg_kws_nn_score_thre_4   (rg_kws_nn_score_thre_4[7:0]       ), //i
    .rg_kws_nn_score_thre_5   (rg_kws_nn_score_thre_5[7:0]       ), //i
    .rg_kws_nn_score_thre_6   (rg_kws_nn_score_thre_6[7:0]       ), //i
    .rg_kws_nn_block_num_0    (rg_kws_nn_block_num_0[7:0]        ), //i
    .rg_kws_nn_block_num_1    (rg_kws_nn_block_num_1[7:0]        ), //i
    .rg_kws_nn_eva_num_0      (rg_kws_nn_eva_num_0[7:0]          ), //i
    .rg_kws_nn_eva_num_1      (rg_kws_nn_eva_num_1[7:0]          ), //i
    .rg_kws_nn_debug_en       (rg_kws_nn_debug_en                ), //i
    .rg_kws_nn_nn_break_point (rg_kws_nn_nn_break_point[10:0]    ), //i
    .kws_out_is_valid         (stack_kws_out_is_valid            ), //o
    .ro_stack_0               (stack_ro_stack_0[31:0]            ), //o
    .ro_stack_1               (stack_ro_stack_1[31:0]            ), //o
    .ro_stack_2               (stack_ro_stack_2[31:0]            ), //o
    .ro_stack_3               (stack_ro_stack_3[31:0]            ), //o
    .ro_stack_4               (stack_ro_stack_4[31:0]            ), //o
    .ro_stack_5               (stack_ro_stack_5[31:0]            ), //o
    .ro_stack_6               (stack_ro_stack_6[31:0]            ), //o
    .ro_stack_7               (stack_ro_stack_7[31:0]            ), //o
    .ro_stack_8               (stack_ro_stack_8[31:0]            ), //o
    .ro_stack_9               (stack_ro_stack_9[31:0]            ), //o
    .ro_stack_10              (stack_ro_stack_10[31:0]           ), //o
    .ro_stack_11              (stack_ro_stack_11[31:0]           ), //o
    .ro_stack_12              (stack_ro_stack_12[31:0]           ), //o
    .ro_stack_13              (stack_ro_stack_13[31:0]           ), //o
    .ro_stack_14              (stack_ro_stack_14[31:0]           ), //o
    .ro_stack_15              (stack_ro_stack_15[31:0]           ), //o
    .ro_stack_16              (stack_ro_stack_16[31:0]           ), //o
    .ro_stack_17              (stack_ro_stack_17[31:0]           ), //o
    .ro_stack_18              (stack_ro_stack_18[31:0]           ), //o
    .ro_stack_19              (stack_ro_stack_19[31:0]           ), //o
    .ro_stack_20              (stack_ro_stack_20[31:0]           ), //o
    .ro_stack_21              (stack_ro_stack_21[31:0]           ), //o
    .ro_stack_22              (stack_ro_stack_22[31:0]           ), //o
    .ro_stack_23              (stack_ro_stack_23[31:0]           ), //o
    .ro_stack_24              (stack_ro_stack_24[31:0]           ), //o
    .ro_stack_25              (stack_ro_stack_25[31:0]           ), //o
    .ro_stack_26              (stack_ro_stack_26[31:0]           ), //o
    .ro_stack_27              (stack_ro_stack_27[31:0]           ), //o
    .ro_stack_28              (stack_ro_stack_28[31:0]           ), //o
    .ro_stack_29              (stack_ro_stack_29[31:0]           ), //o
    .ro_stack_30              (stack_ro_stack_30[31:0]           ), //o
    .ro_stack_31              (stack_ro_stack_31[31:0]           ), //o
    .ro_stack_32              (stack_ro_stack_32[31:0]           ), //o
    .ro_stack_33              (stack_ro_stack_33[31:0]           ), //o
    .ro_stack_34              (stack_ro_stack_34[31:0]           ), //o
    .ro_stack_35              (stack_ro_stack_35[31:0]           ), //o
    .ro_stack_36              (stack_ro_stack_36[31:0]           ), //o
    .ro_stack_37              (stack_ro_stack_37[31:0]           ), //o
    .ro_stack_38              (stack_ro_stack_38[31:0]           ), //o
    .ro_stack_39              (stack_ro_stack_39[31:0]           ), //o
    .ro_stack_40              (stack_ro_stack_40[31:0]           ), //o
    .ro_stack_41              (stack_ro_stack_41[31:0]           ), //o
    .ro_stack_42              (stack_ro_stack_42[31:0]           ), //o
    .ro_stack_43              (stack_ro_stack_43[31:0]           ), //o
    .ro_stack_44              (stack_ro_stack_44[31:0]           ), //o
    .ro_stack_45              (stack_ro_stack_45[31:0]           ), //o
    .ro_stack_46              (stack_ro_stack_46[31:0]           ), //o
    .ro_stack_47              (stack_ro_stack_47[31:0]           ), //o
    .ro_stack_48              (stack_ro_stack_48[31:0]           ), //o
    .ro_stack_49              (stack_ro_stack_49[31:0]           ), //o
    .ro_stack_50              (stack_ro_stack_50[31:0]           ), //o
    .ro_stack_51              (stack_ro_stack_51[31:0]           ), //o
    .ro_stack_52              (stack_ro_stack_52[31:0]           ), //o
    .ro_stack_53              (stack_ro_stack_53[31:0]           ), //o
    .clk                      (clk                               ), //i
    .resetn                   (resetn                            )  //i
  );
  assign core_core_start = (core_start && rg_kws_nn_nn_en); // @[nn_core_top.scala 57:22]
  assign core_end = core_core_end; // @[nn_core_top.scala 58:15]
  assign highBandWidth_fb_mem_rd = core_highBandWidth_fb_mem_rd; // @[nn_core_top.scala 59:28]
  assign highBandWidth_fb_mem_wr = core_highBandWidth_fb_mem_wr; // @[nn_core_top.scala 59:28]
  assign highBandWidth_fb_mem_addr = core_highBandWidth_fb_mem_addr; // @[nn_core_top.scala 59:28]
  assign highBandWidth_fb_mem_wdata = core_highBandWidth_fb_mem_wdata; // @[nn_core_top.scala 59:28]
  assign highBandWidth_a_mem_rd = core_highBandWidth_a_mem_rd; // @[nn_core_top.scala 60:27]
  assign highBandWidth_a_mem_wr = core_highBandWidth_a_mem_wr; // @[nn_core_top.scala 60:27]
  assign highBandWidth_a_mem_addr = core_highBandWidth_a_mem_addr; // @[nn_core_top.scala 60:27]
  assign highBandWidth_a_mem_wdata = core_highBandWidth_a_mem_wdata; // @[nn_core_top.scala 60:27]
  assign highBandWidth_w_mem_rd = core_highBandWidth_w_mem_rd; // @[nn_core_top.scala 61:27]
  assign highBandWidth_w_mem_wr = core_highBandWidth_w_mem_wr; // @[nn_core_top.scala 61:27]
  assign highBandWidth_w_mem_addr = core_highBandWidth_w_mem_addr; // @[nn_core_top.scala 61:27]
  assign highBandWidth_w_mem_wdata = core_highBandWidth_w_mem_wdata; // @[nn_core_top.scala 61:27]
  assign lowBandWidth_mem_rd = core_lowBandWidth_mem_rd; // @[nn_core_top.scala 62:24]
  assign lowBandWidth_mem_wr = core_lowBandWidth_mem_wr; // @[nn_core_top.scala 62:24]
  assign lowBandWidth_mem_addr = core_lowBandWidth_mem_addr; // @[nn_core_top.scala 62:24]
  assign lowBandWidth_mem_wdata = core_lowBandWidth_mem_wdata; // @[nn_core_top.scala 62:24]
  assign lowBandWidth_mem_rdata = stack_lowBandWidth_mem_rdata; // @[nn_core_top.scala 69:25]
  assign ro_stack_0 = stack_ro_stack_0; // @[nn_core_top.scala 71:12]
  assign ro_stack_1 = stack_ro_stack_1; // @[nn_core_top.scala 71:12]
  assign ro_stack_2 = stack_ro_stack_2; // @[nn_core_top.scala 71:12]
  assign ro_stack_3 = stack_ro_stack_3; // @[nn_core_top.scala 71:12]
  assign ro_stack_4 = stack_ro_stack_4; // @[nn_core_top.scala 71:12]
  assign ro_stack_5 = stack_ro_stack_5; // @[nn_core_top.scala 71:12]
  assign ro_stack_6 = stack_ro_stack_6; // @[nn_core_top.scala 71:12]
  assign ro_stack_7 = stack_ro_stack_7; // @[nn_core_top.scala 71:12]
  assign ro_stack_8 = stack_ro_stack_8; // @[nn_core_top.scala 71:12]
  assign ro_stack_9 = stack_ro_stack_9; // @[nn_core_top.scala 71:12]
  assign ro_stack_10 = stack_ro_stack_10; // @[nn_core_top.scala 71:12]
  assign ro_stack_11 = stack_ro_stack_11; // @[nn_core_top.scala 71:12]
  assign ro_stack_12 = stack_ro_stack_12; // @[nn_core_top.scala 71:12]
  assign ro_stack_13 = stack_ro_stack_13; // @[nn_core_top.scala 71:12]
  assign ro_stack_14 = stack_ro_stack_14; // @[nn_core_top.scala 71:12]
  assign ro_stack_15 = stack_ro_stack_15; // @[nn_core_top.scala 71:12]
  assign ro_stack_16 = stack_ro_stack_16; // @[nn_core_top.scala 71:12]
  assign ro_stack_17 = stack_ro_stack_17; // @[nn_core_top.scala 71:12]
  assign ro_stack_18 = stack_ro_stack_18; // @[nn_core_top.scala 71:12]
  assign ro_stack_19 = stack_ro_stack_19; // @[nn_core_top.scala 71:12]
  assign ro_stack_20 = stack_ro_stack_20; // @[nn_core_top.scala 71:12]
  assign ro_stack_21 = stack_ro_stack_21; // @[nn_core_top.scala 71:12]
  assign ro_stack_22 = stack_ro_stack_22; // @[nn_core_top.scala 71:12]
  assign ro_stack_23 = stack_ro_stack_23; // @[nn_core_top.scala 71:12]
  assign ro_stack_24 = stack_ro_stack_24; // @[nn_core_top.scala 71:12]
  assign ro_stack_25 = stack_ro_stack_25; // @[nn_core_top.scala 71:12]
  assign ro_stack_26 = stack_ro_stack_26; // @[nn_core_top.scala 71:12]
  assign ro_stack_27 = stack_ro_stack_27; // @[nn_core_top.scala 71:12]
  assign ro_stack_28 = stack_ro_stack_28; // @[nn_core_top.scala 71:12]
  assign ro_stack_29 = stack_ro_stack_29; // @[nn_core_top.scala 71:12]
  assign ro_stack_30 = stack_ro_stack_30; // @[nn_core_top.scala 71:12]
  assign ro_stack_31 = stack_ro_stack_31; // @[nn_core_top.scala 71:12]
  assign ro_stack_32 = stack_ro_stack_32; // @[nn_core_top.scala 71:12]
  assign ro_stack_33 = stack_ro_stack_33; // @[nn_core_top.scala 71:12]
  assign ro_stack_34 = stack_ro_stack_34; // @[nn_core_top.scala 71:12]
  assign ro_stack_35 = stack_ro_stack_35; // @[nn_core_top.scala 71:12]
  assign ro_stack_36 = stack_ro_stack_36; // @[nn_core_top.scala 71:12]
  assign ro_stack_37 = stack_ro_stack_37; // @[nn_core_top.scala 71:12]
  assign ro_stack_38 = stack_ro_stack_38; // @[nn_core_top.scala 71:12]
  assign ro_stack_39 = stack_ro_stack_39; // @[nn_core_top.scala 71:12]
  assign ro_stack_40 = stack_ro_stack_40; // @[nn_core_top.scala 71:12]
  assign ro_stack_41 = stack_ro_stack_41; // @[nn_core_top.scala 71:12]
  assign ro_stack_42 = stack_ro_stack_42; // @[nn_core_top.scala 71:12]
  assign ro_stack_43 = stack_ro_stack_43; // @[nn_core_top.scala 71:12]
  assign ro_stack_44 = stack_ro_stack_44; // @[nn_core_top.scala 71:12]
  assign ro_stack_45 = stack_ro_stack_45; // @[nn_core_top.scala 71:12]
  assign ro_stack_46 = stack_ro_stack_46; // @[nn_core_top.scala 71:12]
  assign ro_stack_47 = stack_ro_stack_47; // @[nn_core_top.scala 71:12]
  assign ro_stack_48 = stack_ro_stack_48; // @[nn_core_top.scala 71:12]
  assign ro_stack_49 = stack_ro_stack_49; // @[nn_core_top.scala 71:12]
  assign ro_stack_50 = stack_ro_stack_50; // @[nn_core_top.scala 71:12]
  assign ro_stack_51 = stack_ro_stack_51; // @[nn_core_top.scala 71:12]
  assign ro_stack_52 = stack_ro_stack_52; // @[nn_core_top.scala 71:12]
  assign ro_stack_53 = stack_ro_stack_53; // @[nn_core_top.scala 71:12]
  assign kws_out_int = (stack_kws_out_is_valid && (! nn_core_stack_kws_out_is_valid_regNext)); // @[nn_core_top.scala 73:18]
  assign x_0 = core_x_0; // @[nn_core_top.scala 76:13]
  assign x_1 = core_x_1; // @[nn_core_top.scala 76:13]
  assign x_2 = core_x_2; // @[nn_core_top.scala 76:13]
  assign x_3 = core_x_3; // @[nn_core_top.scala 76:13]
  assign x_4 = core_x_4; // @[nn_core_top.scala 76:13]
  assign x_5 = core_x_5; // @[nn_core_top.scala 76:13]
  assign x_6 = core_x_6; // @[nn_core_top.scala 76:13]
  assign x_7 = core_x_7; // @[nn_core_top.scala 76:13]
  assign x_8 = core_x_8; // @[nn_core_top.scala 76:13]
  assign x_9 = core_x_9; // @[nn_core_top.scala 76:13]
  assign x_10 = core_x_10; // @[nn_core_top.scala 76:13]
  assign x_11 = core_x_11; // @[nn_core_top.scala 76:13]
  assign x_12 = core_x_12; // @[nn_core_top.scala 76:13]
  assign x_13 = core_x_13; // @[nn_core_top.scala 76:13]
  assign x_14 = core_x_14; // @[nn_core_top.scala 76:13]
  assign x_15 = core_x_15; // @[nn_core_top.scala 76:13]
  assign x_16 = core_x_16; // @[nn_core_top.scala 76:13]
  assign x_17 = core_x_17; // @[nn_core_top.scala 76:13]
  assign x_18 = core_x_18; // @[nn_core_top.scala 76:13]
  assign x_19 = core_x_19; // @[nn_core_top.scala 76:13]
  assign x_20 = core_x_20; // @[nn_core_top.scala 76:13]
  assign x_21 = core_x_21; // @[nn_core_top.scala 76:13]
  assign x_22 = core_x_22; // @[nn_core_top.scala 76:13]
  assign x_23 = core_x_23; // @[nn_core_top.scala 76:13]
  assign x_24 = core_x_24; // @[nn_core_top.scala 76:13]
  assign x_25 = core_x_25; // @[nn_core_top.scala 76:13]
  assign x_26 = core_x_26; // @[nn_core_top.scala 76:13]
  assign x_27 = core_x_27; // @[nn_core_top.scala 76:13]
  assign x_28 = core_x_28; // @[nn_core_top.scala 76:13]
  assign x_29 = core_x_29; // @[nn_core_top.scala 76:13]
  assign x_30 = core_x_30; // @[nn_core_top.scala 76:13]
  assign x_31 = core_x_31; // @[nn_core_top.scala 76:13]
  assign nn_done_sigs_0 = (x_1 == 32'h00000001); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_1 = (x_1 == 32'h00000002); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_2 = (x_1 == 32'h00000003); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_3 = (x_1 == 32'h00000004); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_4 = (x_1 == 32'h00000005); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_5 = (x_1 == 32'h00000006); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_6 = (x_1 == 32'h00000007); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_7 = (x_1 == 32'h00000008); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_8 = (x_1 == 32'h00000009); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_9 = (x_1 == 32'h0000000a); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_10 = (x_1 == 32'h0000000b); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_11 = (x_1 == 32'h0000000c); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_12 = (x_1 == 32'h0000000d); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_13 = (x_1 == 32'h0000000e); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_14 = (x_1 == 32'h0000000f); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_15 = (x_1 == 32'h00000010); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_16 = (x_1 == 32'h00000011); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_17 = (x_1 == 32'h00000012); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_18 = (x_1 == 32'h00000013); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_19 = (x_1 == 32'h00000014); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_20 = (x_1 == 32'h00000015); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_21 = (x_1 == 32'h00000016); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_22 = (x_1 == 32'h00000017); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_23 = (x_1 == 32'h00000018); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_24 = (x_1 == 32'h00000019); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_25 = (x_1 == 32'h0000001a); // @[nn_core_top.scala 84:21]
  assign nn_done_sigs_26 = (x_1 == 32'h0000001b); // @[nn_core_top.scala 84:21]
  assign layer_has_done_flag = (((((nn_done_sigs_0 || nn_done_sigs_1) || (nn_done_sigs_2 || nn_done_sigs_3)) || ((nn_done_sigs_4 || nn_done_sigs_5) || (nn_done_sigs_6 || nn_done_sigs_7))) || (((nn_done_sigs_8 || nn_done_sigs_9) || (nn_done_sigs_10 || nn_done_sigs_11)) || ((nn_done_sigs_12 || nn_done_sigs_13) || (nn_done_sigs_14 || nn_done_sigs_15)))) || ((((nn_done_sigs_16 || nn_done_sigs_17) || (nn_done_sigs_18 || nn_done_sigs_19)) || ((nn_done_sigs_20 || nn_done_sigs_21) || (nn_done_sigs_22 || nn_done_sigs_23))) || ((nn_done_sigs_24 || nn_done_sigs_25) || nn_done_sigs_26))); // @[nn_core_top.scala 86:23]
  assign nn_layer_done_state = nn_done_regs; // @[nn_core_top.scala 95:26]
  always @(posedge clk) begin
    nn_core_stack_kws_out_is_valid_regNext <= stack_kws_out_is_valid; // @[Reg.scala 39:30]
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      nn_done_regs <= 32'h0; // @[Data.scala 400:33]
    end else begin
      if(nn_done_sigs_0) begin
        nn_done_regs[0] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[0] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_1) begin
        nn_done_regs[1] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[1] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_2) begin
        nn_done_regs[2] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[2] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_3) begin
        nn_done_regs[3] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[3] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_4) begin
        nn_done_regs[4] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[4] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_5) begin
        nn_done_regs[5] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[5] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_6) begin
        nn_done_regs[6] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[6] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_7) begin
        nn_done_regs[7] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[7] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_8) begin
        nn_done_regs[8] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[8] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_9) begin
        nn_done_regs[9] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[9] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_10) begin
        nn_done_regs[10] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[10] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_11) begin
        nn_done_regs[11] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[11] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_12) begin
        nn_done_regs[12] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[12] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_13) begin
        nn_done_regs[13] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[13] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_14) begin
        nn_done_regs[14] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[14] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_15) begin
        nn_done_regs[15] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[15] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_16) begin
        nn_done_regs[16] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[16] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_17) begin
        nn_done_regs[17] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[17] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_18) begin
        nn_done_regs[18] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[18] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_19) begin
        nn_done_regs[19] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[19] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_20) begin
        nn_done_regs[20] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[20] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_21) begin
        nn_done_regs[21] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[21] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_22) begin
        nn_done_regs[22] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[22] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_23) begin
        nn_done_regs[23] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[23] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_24) begin
        nn_done_regs[24] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[24] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_25) begin
        nn_done_regs[25] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[25] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
      if(nn_done_sigs_26) begin
        nn_done_regs[26] <= 1'b1; // @[nn_core_top.scala 90:23]
      end else begin
        if(layer_has_done_flag) begin
          nn_done_regs[26] <= 1'b0; // @[nn_core_top.scala 92:23]
        end
      end
    end
  end


endmodule

module fbank_top (
  input               kws_enable,
  input               debug_nn,
  input               rg_kws_fb_sys_clken,
  input               rg_kws_fb_lp_filter_en,
  input               rg_kws_fb_window_en,
  input               rg_kws_fb_vad_en,
  input               rg_kws_fb_fbank_en,
  input               rg_kws_fb_debug_rx_en,
  input      [15:0]   rg_kws_fb_vad_energy_threshold,
  input      [7:0]    rg_kws_fb_vad_hangover,
  input      [15:0]   rg_kws_fb_quant_scale,
  input      [7:0]    rg_kws_fb_quant_zerpoint,
  input      [4:0]    rg_kws_fb_quant_shift,
  input      [15:0]   pcm16k_in,
  input               pcm16k_vld,
  output reg          pcm_mb0_rd,
  output reg          pcm_mb0_wr,
  output reg [7:0]    pcm_mb0_addr,
  output reg [15:0]   pcm_mb0_wdata,
  input      [15:0]   pcm_mb0_rdata,
  output reg          pcm_mb1_rd,
  output reg          pcm_mb1_wr,
  output reg [7:0]    pcm_mb1_addr,
  output reg [15:0]   pcm_mb1_wdata,
  input      [15:0]   pcm_mb1_rdata,
  output              pcm_mb2_rd,
  output              pcm_mb2_wr,
  output     [7:0]    pcm_mb2_addr,
  output     [15:0]   pcm_mb2_wdata,
  input      [15:0]   pcm_mb2_rdata,
  output reg          lmfb_mem_rd,
  output reg          lmfb_mem_wr,
  output reg [6:0]    lmfb_mem_addr,
  output reg [127:0]  lmfb_mem_wdata,
  input      [127:0]  lmfb_mem_rdata,
  output     [6:0]    lmfb_write_addr,
  output              fbank_finish,
  output              pingpong_flag,
  input               clk,
  input               resetn
);

  wire                filter_mulif_dout_vld;
  wire                filter_mulif_cal_finish;
  wire       [24:0]   filter_mulif_dout;
  wire                win_mulif_dout_vld;
  wire                win_mulif_cal_finish;
  wire       [24:0]   win_mulif_dout;
  wire                mul1_io_din_vld;
  wire       [15:0]   mul1_io_dinA;
  wire       [8:0]    mul1_io_dinB;
  wire                energy_vad_frame_end;
  reg                 mul2_io_din_vld;
  reg        [31:0]   mul2_io_dinA;
  reg        [15:0]   mul2_io_dinB;
  wire                fft_start;
  reg        [31:0]   fft_memif_rdata;
  reg                 fft_mulif_dout_vld;
  wire                fft_mulif_cal_finish;
  reg        [31:0]   fft_mulif_dout;
  reg        [31:0]   pow_memif_rdata;
  reg                 pow_mulif_dout_vld;
  wire                pow_mulif_cal_finish;
  reg        [31:0]   pow_mulif_dout;
  reg        [31:0]   mel_memif_rdata;
  reg                 mel_mulif_dout_vld;
  wire                mel_mulif_cal_finish;
  reg        [47:0]   mel_mulif_dout;
  reg        [31:0]   log_memif_rdata;
  wire                quant_start;
  reg                 quant_mulif_dout_vld;
  wire                quant_mulif_cal_finish;
  reg        [47:0]   quant_mulif_dout;
  reg        [31:0]   quant_pcm_memif_rdata;
  reg        [127:0]  quant_lmfb_memif_rdata;
  wire                filter_filter_start;
  wire                filter_filter_finish;
  wire       [15:0]   filter_pcm_filter_out;
  wire                filter_pcm_filter_vld;
  wire                filter_mulif_din_vld;
  wire       [15:0]   filter_mulif_dinA;
  wire       [8:0]    filter_mulif_dinB;
  wire       [15:0]   win_pcm_window_out;
  wire                win_pcm_window_vld;
  wire                win_pingpong_flag;
  wire       [7:0]    win_win_addr;
  wire                win_mulif_din_vld;
  wire       [15:0]   win_mulif_dinA;
  wire       [8:0]    win_mulif_dinB;
  wire                win_memif_rd_1;
  wire                win_memif_wr_1;
  wire       [15:0]   win_memif_wdata_1;
  wire       [7:0]    win_memif_addr_1;
  wire                mul1_io_dout_vld;
  wire                mul1_io_cal_finish;
  wire       [24:0]   mul1_io_dout;
  wire                energy_vad_vad_flag;
  wire                mul2_io_dout_vld;
  wire                mul2_io_cal_finish;
  wire       [47:0]   mul2_io_dout;
  wire                fft_finish;
  wire                fft_memif_rd;
  wire                fft_memif_wr;
  wire       [31:0]   fft_memif_wdata;
  wire       [7:0]    fft_memif_addr;
  wire                fft_mulif_din_vld;
  wire       [15:0]   fft_mulif_dinA;
  wire       [15:0]   fft_mulif_dinB;
  wire                pow_finish;
  wire                pow_memif_rd;
  wire                pow_memif_wr;
  wire       [31:0]   pow_memif_wdata;
  wire       [7:0]    pow_memif_addr;
  wire                pow_mulif_din_vld;
  wire       [15:0]   pow_mulif_dinA;
  wire       [15:0]   pow_mulif_dinB;
  wire       [19:0]   pow_mag_out;
  wire                mel_finish;
  wire                mel_memif_rd;
  wire                mel_memif_wr;
  wire       [31:0]   mel_memif_wdata;
  wire       [7:0]    mel_memif_addr;
  wire                mel_mulif_din_vld;
  wire       [31:0]   mel_mulif_dinA;
  wire       [15:0]   mel_mulif_dinB;
  wire       [19:0]   mel_mel_out;
  wire                log_finish;
  wire                log_memif_rd;
  wire                log_memif_wr;
  wire       [31:0]   log_memif_wdata;
  wire       [7:0]    log_memif_addr;
  wire       [15:0]   log_cordic_ln_out;
  wire                quant_finish;
  wire                quant_mulif_din_vld;
  wire       [31:0]   quant_mulif_dinA;
  wire       [15:0]   quant_mulif_dinB;
  wire                quant_pcm_memif_rd;
  wire                quant_pcm_memif_wr;
  wire       [31:0]   quant_pcm_memif_wdata;
  wire       [7:0]    quant_pcm_memif_addr;
  wire                quant_lmfb_memif_rd;
  wire                quant_lmfb_memif_wr;
  wire       [127:0]  quant_lmfb_memif_wdata;
  wire       [6:0]    quant_lmfb_memif_addr;
  wire       [7:0]    quant_lmfb_uint8_out;
  wire       [6:0]    quant_lmfb_write_addr;
  wire                fft_cken_enable_out;
  wire                pow_cken_enable_out;
  wire                mel_cken_enable_out;
  wire                log_cken_enable_out;
  wire                quant_cken_enable_out;
  wire       [24:0]   tmp_mulif_dout;
  wire       [24:0]   tmp_mulif_dout_1;
  reg                 filter_en_reg;
  wire                filter_en;
  reg                 kws_enable_regNext;
  wire                kws_start_pos;
  wire                win_memif_rd;
  wire                win_memif_wr;
  wire       [7:0]    win_memif_addr;
  wire       [15:0]   win_memif_wdata;
  reg        [15:0]   win_memif_rdata;
  reg                 pingpong_flag_regNext;
  reg                 pingpong_flag_regNext_1;
  reg                 vad_finish;
  reg                 combine_memif_rd;
  reg                 combine_memif_wr;
  reg        [7:0]    combine_memif_addr;
  reg        [31:0]   combine_memif_wdata;
  reg        [31:0]   combine_memif_rdata;
  reg                 fbank_fft_finish_regNext;
  reg                 fbank_pow_finish_regNext;
  reg                 fbank_mel_finish_regNext;
  wire                quant_start_time;
  reg                 quant_wait_flag;
  reg                 quant_wait_flag_regNext;

  assign tmp_mulif_dout = 25'h0;
  assign tmp_mulif_dout_1 = 25'h0;
  lowpass_filter filter (
    .rg_lpfilter_en   (rg_kws_fb_lp_filter_en     ), //i
    .kws_start_pos    (kws_start_pos              ), //i
    .filter_start     (filter_filter_start        ), //o
    .filter_finish    (filter_filter_finish       ), //o
    .pcm16k_in        (pcm16k_in[15:0]            ), //i
    .pcm16k_vld       (pcm16k_vld                 ), //i
    .pcm_filter_out   (filter_pcm_filter_out[15:0]), //o
    .pcm_filter_vld   (filter_pcm_filter_vld      ), //o
    .mulif_din_vld    (filter_mulif_din_vld       ), //o
    .mulif_dinA       (filter_mulif_dinA[15:0]    ), //o
    .mulif_dinB       (filter_mulif_dinB[8:0]     ), //o
    .mulif_dout_vld   (filter_mulif_dout_vld      ), //i
    .mulif_cal_finish (filter_mulif_cal_finish    ), //i
    .mulif_dout       (filter_mulif_dout[24:0]    ), //i
    .clk              (clk                        ), //i
    .resetn           (resetn                     )  //i
  );
  window win (
    .rg_window_en     (rg_kws_fb_window_en        ), //i
    .kws_start_pos    (kws_start_pos              ), //i
    .pcm_in           (filter_pcm_filter_out[15:0]), //i
    .pcm_vld          (filter_pcm_filter_vld      ), //i
    .pcm_window_out   (win_pcm_window_out[15:0]   ), //o
    .pcm_window_vld   (win_pcm_window_vld         ), //o
    .pingpong_flag    (win_pingpong_flag          ), //o
    .win_addr         (win_win_addr[7:0]          ), //o
    .mulif_din_vld    (win_mulif_din_vld          ), //o
    .mulif_dinA       (win_mulif_dinA[15:0]       ), //o
    .mulif_dinB       (win_mulif_dinB[8:0]        ), //o
    .mulif_dout_vld   (win_mulif_dout_vld         ), //i
    .mulif_cal_finish (win_mulif_cal_finish       ), //i
    .mulif_dout       (win_mulif_dout[24:0]       ), //i
    .memif_rd         (win_memif_rd_1             ), //o
    .memif_wr         (win_memif_wr_1             ), //o
    .memif_addr       (win_memif_addr_1[7:0]      ), //o
    .memif_wdata      (win_memif_wdata_1[15:0]    ), //o
    .memif_rdata      (win_memif_rdata[15:0]      ), //i
    .clk              (clk                        ), //i
    .resetn           (resetn                     )  //i
  );
  booth4_1 mul1 (
    .io_din_vld    (mul1_io_din_vld   ), //i
    .io_dinA       (mul1_io_dinA[15:0]), //i
    .io_dinB       (mul1_io_dinB[8:0] ), //i
    .io_dout_vld   (mul1_io_dout_vld  ), //o
    .io_cal_finish (mul1_io_cal_finish), //o
    .io_dout       (mul1_io_dout[24:0]), //o
    .clk           (clk               ), //i
    .resetn        (resetn            )  //i
  );
  vad energy_vad (
    .vad_en               (rg_kws_fb_vad_en                    ), //i
    .frame_end            (energy_vad_frame_end                ), //i
    .pcm_in               (win_pcm_window_out[15:0]            ), //i
    .pcm_vld              (win_pcm_window_vld                  ), //i
    .vad_energy_threshold (rg_kws_fb_vad_energy_threshold[15:0]), //i
    .vad_hangover         (rg_kws_fb_vad_hangover[7:0]         ), //i
    .vad_flag             (energy_vad_vad_flag                 ), //o
    .clk                  (clk                                 ), //i
    .resetn               (resetn                              )  //i
  );
  booth4 mul2 (
    .io_din_vld    (mul2_io_din_vld   ), //i
    .io_dinA       (mul2_io_dinA[31:0]), //i
    .io_dinB       (mul2_io_dinB[15:0]), //i
    .io_dout_vld   (mul2_io_dout_vld  ), //o
    .io_cal_finish (mul2_io_cal_finish), //o
    .io_dout       (mul2_io_dout[47:0]), //o
    .clk           (clk               ), //i
    .resetn        (resetn            )  //i
  );
  qfft fft (
    .start            (fft_start            ), //i
    .finish           (fft_finish           ), //o
    .memif_rd         (fft_memif_rd         ), //o
    .memif_wr         (fft_memif_wr         ), //o
    .memif_addr       (fft_memif_addr[7:0]  ), //o
    .memif_wdata      (fft_memif_wdata[31:0]), //o
    .memif_rdata      (fft_memif_rdata[31:0]), //i
    .mulif_din_vld    (fft_mulif_din_vld    ), //o
    .mulif_dinA       (fft_mulif_dinA[15:0] ), //o
    .mulif_dinB       (fft_mulif_dinB[15:0] ), //o
    .mulif_dout_vld   (fft_mulif_dout_vld   ), //i
    .mulif_cal_finish (fft_mulif_cal_finish ), //i
    .mulif_dout       (fft_mulif_dout[31:0] ), //i
    .clk              (clk                  ), //i
    .resetn           (resetn               )  //i
  );
  power pow (
    .start            (fbank_fft_finish_regNext), //i
    .finish           (pow_finish              ), //o
    .memif_rd         (pow_memif_rd            ), //o
    .memif_wr         (pow_memif_wr            ), //o
    .memif_addr       (pow_memif_addr[7:0]     ), //o
    .memif_wdata      (pow_memif_wdata[31:0]   ), //o
    .memif_rdata      (pow_memif_rdata[31:0]   ), //i
    .mulif_din_vld    (pow_mulif_din_vld       ), //o
    .mulif_dinA       (pow_mulif_dinA[15:0]    ), //o
    .mulif_dinB       (pow_mulif_dinB[15:0]    ), //o
    .mulif_dout_vld   (pow_mulif_dout_vld      ), //i
    .mulif_cal_finish (pow_mulif_cal_finish    ), //i
    .mulif_dout       (pow_mulif_dout[31:0]    ), //i
    .mag_out          (pow_mag_out[19:0]       ), //o
    .clk              (clk                     ), //i
    .resetn           (resetn                  )  //i
  );
  mel_dot mel (
    .start            (fbank_pow_finish_regNext), //i
    .finish           (mel_finish              ), //o
    .memif_rd         (mel_memif_rd            ), //o
    .memif_wr         (mel_memif_wr            ), //o
    .memif_addr       (mel_memif_addr[7:0]     ), //o
    .memif_wdata      (mel_memif_wdata[31:0]   ), //o
    .memif_rdata      (mel_memif_rdata[31:0]   ), //i
    .mulif_din_vld    (mel_mulif_din_vld       ), //o
    .mulif_dinA       (mel_mulif_dinA[31:0]    ), //o
    .mulif_dinB       (mel_mulif_dinB[15:0]    ), //o
    .mulif_dout_vld   (mel_mulif_dout_vld      ), //i
    .mulif_cal_finish (mel_mulif_cal_finish    ), //i
    .mulif_dout       (mel_mulif_dout[47:0]    ), //i
    .mel_out          (mel_mel_out[19:0]       ), //o
    .clk              (clk                     ), //i
    .resetn           (resetn                  )  //i
  );
  cordic_ln log (
    .start         (fbank_mel_finish_regNext), //i
    .finish        (log_finish              ), //o
    .memif_rd      (log_memif_rd            ), //o
    .memif_wr      (log_memif_wr            ), //o
    .memif_addr    (log_memif_addr[7:0]     ), //o
    .memif_wdata   (log_memif_wdata[31:0]   ), //o
    .memif_rdata   (log_memif_rdata[31:0]   ), //i
    .cordic_ln_out (log_cordic_ln_out[15:0] ), //o
    .clk           (clk                     ), //i
    .resetn        (resetn                  )  //i
  );
  quant8 quant (
    .start                   (quant_start                  ), //i
    .finish                  (quant_finish                 ), //o
    .rg_fbank_quant_scale    (rg_kws_fb_quant_scale[15:0]  ), //i
    .rg_fbank_quant_zerpoint (rg_kws_fb_quant_zerpoint[7:0]), //i
    .rg_fbank_quant_shift    (rg_kws_fb_quant_shift[4:0]   ), //i
    .mulif_din_vld           (quant_mulif_din_vld          ), //o
    .mulif_dinA              (quant_mulif_dinA[31:0]       ), //o
    .mulif_dinB              (quant_mulif_dinB[15:0]       ), //o
    .mulif_dout_vld          (quant_mulif_dout_vld         ), //i
    .mulif_cal_finish        (quant_mulif_cal_finish       ), //i
    .mulif_dout              (quant_mulif_dout[47:0]       ), //i
    .pcm_memif_rd            (quant_pcm_memif_rd           ), //o
    .pcm_memif_wr            (quant_pcm_memif_wr           ), //o
    .pcm_memif_addr          (quant_pcm_memif_addr[7:0]    ), //o
    .pcm_memif_wdata         (quant_pcm_memif_wdata[31:0]  ), //o
    .pcm_memif_rdata         (quant_pcm_memif_rdata[31:0]  ), //i
    .lmfb_memif_rd           (quant_lmfb_memif_rd          ), //o
    .lmfb_memif_wr           (quant_lmfb_memif_wr          ), //o
    .lmfb_memif_addr         (quant_lmfb_memif_addr[6:0]   ), //o
    .lmfb_memif_wdata        (quant_lmfb_memif_wdata[127:0]), //o
    .lmfb_memif_rdata        (quant_lmfb_memif_rdata[127:0]), //i
    .lmfb_uint8_out          (quant_lmfb_uint8_out[7:0]    ), //o
    .lmfb_write_addr         (quant_lmfb_write_addr[6:0]   ), //o
    .clk                     (clk                          ), //i
    .resetn                  (resetn                       )  //i
  );
  ck_enable_gen_5 fft_cken (
    .start      (fft_start          ), //i
    .finish     (fft_finish         ), //i
    .enable_out (fft_cken_enable_out), //o
    .clk        (clk                ), //i
    .resetn     (resetn             )  //i
  );
  ck_enable_gen_5 pow_cken (
    .start      (fbank_fft_finish_regNext), //i
    .finish     (pow_finish              ), //i
    .enable_out (pow_cken_enable_out     ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  ck_enable_gen_5 mel_cken (
    .start      (fbank_pow_finish_regNext), //i
    .finish     (mel_finish              ), //i
    .enable_out (mel_cken_enable_out     ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  ck_enable_gen_5 log_cken (
    .start      (fbank_mel_finish_regNext), //i
    .finish     (log_finish              ), //i
    .enable_out (log_cken_enable_out     ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  ck_enable_gen_5 quant_cken (
    .start      (quant_start          ), //i
    .finish     (quant_finish         ), //i
    .enable_out (quant_cken_enable_out), //o
    .clk        (clk                  ), //i
    .resetn     (resetn               )  //i
  );
  assign filter_en = (filter_filter_start || filter_en_reg); // @[BaseType.scala 305:24]
  assign mul1_io_din_vld = (filter_mulif_din_vld || win_mulif_din_vld); // @[fbank_top.scala 100:19]
  assign mul1_io_dinA = (filter_en ? filter_mulif_dinA : win_mulif_dinA); // @[fbank_top.scala 101:16]
  assign mul1_io_dinB = (filter_en ? filter_mulif_dinB : win_mulif_dinB); // @[fbank_top.scala 102:16]
  assign kws_start_pos = (kws_enable && (! kws_enable_regNext)); // @[BaseType.scala 305:24]
  assign filter_mulif_dout = (filter_en ? mul1_io_dout : tmp_mulif_dout); // @[fbank_top.scala 105:24]
  assign filter_mulif_dout_vld = (filter_en ? mul1_io_dout_vld : 1'b0); // @[fbank_top.scala 106:28]
  assign win_mulif_dout = ((! filter_en) ? mul1_io_dout : tmp_mulif_dout_1); // @[fbank_top.scala 114:21]
  assign win_mulif_dout_vld = ((! filter_en) ? mul1_io_dout_vld : 1'b0); // @[fbank_top.scala 115:25]
  assign pingpong_flag = win_pingpong_flag; // @[fbank_top.scala 120:20]
  assign win_memif_rd = win_memif_rd_1; // @[fbank_top.scala 124:13]
  assign win_memif_wr = win_memif_wr_1; // @[fbank_top.scala 124:13]
  assign win_memif_addr = win_memif_addr_1; // @[fbank_top.scala 124:13]
  assign win_memif_wdata = win_memif_wdata_1; // @[fbank_top.scala 124:13]
  assign energy_vad_frame_end = (pingpong_flag ^ pingpong_flag_regNext); // @[fbank_top.scala 129:27]
  assign fft_start = ((((vad_finish && energy_vad_vad_flag) && rg_kws_fb_fbank_en) && (! rg_kws_fb_debug_rx_en)) && (! debug_nn)); // @[fbank_top.scala 150:16]
  assign quant_start_time = (win_win_addr == 8'hc0); // @[BaseType.scala 305:24]
  assign quant_start = ((! quant_wait_flag) && quant_wait_flag_regNext); // @[fbank_top.scala 186:18]
  assign fbank_finish = quant_finish; // @[fbank_top.scala 193:19]
  assign pcm_mb2_addr = combine_memif_addr; // @[fbank_top.scala 200:19]
  assign pcm_mb2_wr = combine_memif_wr; // @[fbank_top.scala 201:17]
  assign pcm_mb2_rd = combine_memif_rd; // @[fbank_top.scala 202:17]
  assign pcm_mb2_wdata = combine_memif_wdata[15 : 0]; // @[fbank_top.scala 203:20]
  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb1_rd = win_memif_rd; // @[fbank_top.scala 205:16]
    end else begin
      pcm_mb1_rd = combine_memif_rd; // @[fbank_top.scala 215:19]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb1_wr = win_memif_wr; // @[fbank_top.scala 205:16]
    end else begin
      pcm_mb1_wr = combine_memif_wr; // @[fbank_top.scala 214:19]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb1_addr = win_memif_addr; // @[fbank_top.scala 205:16]
    end else begin
      pcm_mb1_addr = combine_memif_addr; // @[fbank_top.scala 213:21]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb1_wdata = win_memif_wdata; // @[fbank_top.scala 205:16]
    end else begin
      pcm_mb1_wdata = combine_memif_wdata[31 : 16]; // @[fbank_top.scala 216:22]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      win_memif_rdata = pcm_mb1_rdata; // @[fbank_top.scala 205:16]
    end else begin
      win_memif_rdata = pcm_mb0_rdata; // @[fbank_top.scala 212:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb0_addr = combine_memif_addr; // @[fbank_top.scala 206:21]
    end else begin
      pcm_mb0_addr = win_memif_addr; // @[fbank_top.scala 212:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb0_wr = combine_memif_wr; // @[fbank_top.scala 207:19]
    end else begin
      pcm_mb0_wr = win_memif_wr; // @[fbank_top.scala 212:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb0_rd = combine_memif_rd; // @[fbank_top.scala 208:19]
    end else begin
      pcm_mb0_rd = win_memif_rd; // @[fbank_top.scala 212:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb0_wdata = combine_memif_wdata[31 : 16]; // @[fbank_top.scala 209:22]
    end else begin
      pcm_mb0_wdata = win_memif_wdata; // @[fbank_top.scala 212:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      combine_memif_rdata = {pcm_mb0_rdata,pcm_mb2_rdata}; // @[fbank_top.scala 210:25]
    end else begin
      combine_memif_rdata = {pcm_mb1_rdata,pcm_mb2_rdata}; // @[fbank_top.scala 217:25]
    end
  end

  always @(*) begin
    combine_memif_rd = 1'b0; // @[fbank_top.scala 220:20]
    if(fft_cken_enable_out) begin
      combine_memif_rd = fft_memif_rd; // @[fbank_top.scala 247:19]
    end else begin
      if(pow_cken_enable_out) begin
        combine_memif_rd = pow_memif_rd; // @[fbank_top.scala 254:19]
      end else begin
        if(mel_cken_enable_out) begin
          combine_memif_rd = mel_memif_rd; // @[fbank_top.scala 261:19]
        end else begin
          if(log_cken_enable_out) begin
            combine_memif_rd = log_memif_rd; // @[fbank_top.scala 268:19]
          end else begin
            if(quant_cken_enable_out) begin
              combine_memif_rd = quant_pcm_memif_rd; // @[fbank_top.scala 271:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    combine_memif_wr = 1'b0; // @[fbank_top.scala 221:20]
    if(fft_cken_enable_out) begin
      combine_memif_wr = fft_memif_wr; // @[fbank_top.scala 247:19]
    end else begin
      if(pow_cken_enable_out) begin
        combine_memif_wr = pow_memif_wr; // @[fbank_top.scala 254:19]
      end else begin
        if(mel_cken_enable_out) begin
          combine_memif_wr = mel_memif_wr; // @[fbank_top.scala 261:19]
        end else begin
          if(log_cken_enable_out) begin
            combine_memif_wr = log_memif_wr; // @[fbank_top.scala 268:19]
          end else begin
            if(quant_cken_enable_out) begin
              combine_memif_wr = quant_pcm_memif_wr; // @[fbank_top.scala 271:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    combine_memif_wdata = 32'h0; // @[fbank_top.scala 222:23]
    if(fft_cken_enable_out) begin
      combine_memif_wdata = fft_memif_wdata; // @[fbank_top.scala 247:19]
    end else begin
      if(pow_cken_enable_out) begin
        combine_memif_wdata = pow_memif_wdata; // @[fbank_top.scala 254:19]
      end else begin
        if(mel_cken_enable_out) begin
          combine_memif_wdata = mel_memif_wdata; // @[fbank_top.scala 261:19]
        end else begin
          if(log_cken_enable_out) begin
            combine_memif_wdata = log_memif_wdata; // @[fbank_top.scala 268:19]
          end else begin
            if(quant_cken_enable_out) begin
              combine_memif_wdata = quant_pcm_memif_wdata; // @[fbank_top.scala 271:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    combine_memif_addr = 8'h0; // @[fbank_top.scala 223:22]
    if(fft_cken_enable_out) begin
      combine_memif_addr = fft_memif_addr; // @[fbank_top.scala 247:19]
    end else begin
      if(pow_cken_enable_out) begin
        combine_memif_addr = pow_memif_addr; // @[fbank_top.scala 254:19]
      end else begin
        if(mel_cken_enable_out) begin
          combine_memif_addr = mel_memif_addr; // @[fbank_top.scala 261:19]
        end else begin
          if(log_cken_enable_out) begin
            combine_memif_addr = log_memif_addr; // @[fbank_top.scala 268:19]
          end else begin
            if(quant_cken_enable_out) begin
              combine_memif_addr = quant_pcm_memif_addr; // @[fbank_top.scala 271:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mul2_io_din_vld = 1'b0; // @[fbank_top.scala 225:19]
    if(fft_cken_enable_out) begin
      mul2_io_din_vld = fft_mulif_din_vld; // @[fbank_top.scala 248:21]
    end else begin
      if(pow_cken_enable_out) begin
        mul2_io_din_vld = pow_mulif_din_vld; // @[fbank_top.scala 255:21]
      end else begin
        if(mel_cken_enable_out) begin
          mul2_io_din_vld = mel_mulif_din_vld; // @[fbank_top.scala 262:21]
        end else begin
          if(!log_cken_enable_out) begin
            if(quant_cken_enable_out) begin
              mul2_io_din_vld = quant_mulif_din_vld; // @[fbank_top.scala 272:21]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mul2_io_dinA = 32'h0; // @[fbank_top.scala 226:16]
    if(fft_cken_enable_out) begin
      mul2_io_dinA = {{16{fft_mulif_dinA[15]}}, fft_mulif_dinA}; // @[fbank_top.scala 249:18]
    end else begin
      if(pow_cken_enable_out) begin
        mul2_io_dinA = {{16{pow_mulif_dinA[15]}}, pow_mulif_dinA}; // @[fbank_top.scala 256:18]
      end else begin
        if(mel_cken_enable_out) begin
          mul2_io_dinA = mel_mulif_dinA; // @[fbank_top.scala 263:18]
        end else begin
          if(!log_cken_enable_out) begin
            if(quant_cken_enable_out) begin
              mul2_io_dinA = quant_mulif_dinA; // @[fbank_top.scala 273:18]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mul2_io_dinB = 16'h0; // @[fbank_top.scala 227:16]
    if(fft_cken_enable_out) begin
      mul2_io_dinB = fft_mulif_dinB; // @[fbank_top.scala 250:18]
    end else begin
      if(pow_cken_enable_out) begin
        mul2_io_dinB = pow_mulif_dinB; // @[fbank_top.scala 257:18]
      end else begin
        if(mel_cken_enable_out) begin
          mul2_io_dinB = mel_mulif_dinB; // @[fbank_top.scala 264:18]
        end else begin
          if(!log_cken_enable_out) begin
            if(quant_cken_enable_out) begin
              mul2_io_dinB = quant_mulif_dinB; // @[fbank_top.scala 274:18]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    fft_memif_rdata = 32'h0; // @[fbank_top.scala 229:22]
    if(fft_cken_enable_out) begin
      fft_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 247:19]
    end
  end

  always @(*) begin
    fft_mulif_dout = 32'h0; // @[fbank_top.scala 230:21]
    if(fft_cken_enable_out) begin
      fft_mulif_dout = mul2_io_dout[31:0]; // @[fbank_top.scala 251:23]
    end
  end

  always @(*) begin
    fft_mulif_dout_vld = 1'b0; // @[fbank_top.scala 231:25]
    if(fft_cken_enable_out) begin
      fft_mulif_dout_vld = mul2_io_dout_vld; // @[fbank_top.scala 252:27]
    end
  end

  always @(*) begin
    pow_memif_rdata = 32'h0; // @[fbank_top.scala 233:22]
    if(!fft_cken_enable_out) begin
      if(pow_cken_enable_out) begin
        pow_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 254:19]
      end
    end
  end

  always @(*) begin
    pow_mulif_dout = 32'h0; // @[fbank_top.scala 234:21]
    if(!fft_cken_enable_out) begin
      if(pow_cken_enable_out) begin
        pow_mulif_dout = mul2_io_dout[31:0]; // @[fbank_top.scala 258:23]
      end
    end
  end

  always @(*) begin
    pow_mulif_dout_vld = 1'b0; // @[fbank_top.scala 235:25]
    if(!fft_cken_enable_out) begin
      if(pow_cken_enable_out) begin
        pow_mulif_dout_vld = mul2_io_dout_vld; // @[fbank_top.scala 259:27]
      end
    end
  end

  always @(*) begin
    mel_memif_rdata = 32'h0; // @[fbank_top.scala 237:22]
    if(!fft_cken_enable_out) begin
      if(!pow_cken_enable_out) begin
        if(mel_cken_enable_out) begin
          mel_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 261:19]
        end
      end
    end
  end

  always @(*) begin
    mel_mulif_dout = 48'h0; // @[fbank_top.scala 238:21]
    if(!fft_cken_enable_out) begin
      if(!pow_cken_enable_out) begin
        if(mel_cken_enable_out) begin
          mel_mulif_dout = mul2_io_dout; // @[fbank_top.scala 265:23]
        end
      end
    end
  end

  always @(*) begin
    mel_mulif_dout_vld = 1'b0; // @[fbank_top.scala 239:25]
    if(!fft_cken_enable_out) begin
      if(!pow_cken_enable_out) begin
        if(mel_cken_enable_out) begin
          mel_mulif_dout_vld = mul2_io_dout_vld; // @[fbank_top.scala 266:27]
        end
      end
    end
  end

  always @(*) begin
    log_memif_rdata = 32'h0; // @[fbank_top.scala 241:22]
    if(!fft_cken_enable_out) begin
      if(!pow_cken_enable_out) begin
        if(!mel_cken_enable_out) begin
          if(log_cken_enable_out) begin
            log_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 268:19]
          end
        end
      end
    end
  end

  always @(*) begin
    quant_pcm_memif_rdata = 32'h0; // @[fbank_top.scala 243:28]
    if(!fft_cken_enable_out) begin
      if(!pow_cken_enable_out) begin
        if(!mel_cken_enable_out) begin
          if(!log_cken_enable_out) begin
            if(quant_cken_enable_out) begin
              quant_pcm_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 271:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    quant_mulif_dout = 48'h0; // @[fbank_top.scala 244:23]
    if(!fft_cken_enable_out) begin
      if(!pow_cken_enable_out) begin
        if(!mel_cken_enable_out) begin
          if(!log_cken_enable_out) begin
            if(quant_cken_enable_out) begin
              quant_mulif_dout = mul2_io_dout; // @[fbank_top.scala 275:25]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    quant_mulif_dout_vld = 1'b0; // @[fbank_top.scala 245:27]
    if(!fft_cken_enable_out) begin
      if(!pow_cken_enable_out) begin
        if(!mel_cken_enable_out) begin
          if(!log_cken_enable_out) begin
            if(quant_cken_enable_out) begin
              quant_mulif_dout_vld = mul2_io_dout_vld; // @[fbank_top.scala 276:29]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    lmfb_mem_rd = 1'b0; // @[fbank_top.scala 279:18]
    if(quant_cken_enable_out) begin
      lmfb_mem_rd = quant_lmfb_memif_rd; // @[fbank_top.scala 286:17]
    end
  end

  always @(*) begin
    lmfb_mem_wr = 1'b0; // @[fbank_top.scala 280:18]
    if(quant_cken_enable_out) begin
      lmfb_mem_wr = quant_lmfb_memif_wr; // @[fbank_top.scala 286:17]
    end
  end

  always @(*) begin
    lmfb_mem_wdata = 128'h0; // @[fbank_top.scala 281:21]
    if(quant_cken_enable_out) begin
      lmfb_mem_wdata = quant_lmfb_memif_wdata; // @[fbank_top.scala 286:17]
    end
  end

  always @(*) begin
    lmfb_mem_addr = 7'h0; // @[fbank_top.scala 282:20]
    if(quant_cken_enable_out) begin
      lmfb_mem_addr = quant_lmfb_memif_addr; // @[fbank_top.scala 286:17]
    end
  end

  always @(*) begin
    quant_lmfb_memif_rdata = 128'h0; // @[fbank_top.scala 284:29]
    if(quant_cken_enable_out) begin
      quant_lmfb_memif_rdata = lmfb_mem_rdata; // @[fbank_top.scala 286:17]
    end
  end

  assign lmfb_write_addr = quant_lmfb_write_addr; // @[fbank_top.scala 290:22]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      filter_en_reg <= 1'b0; // @[Data.scala 400:33]
      vad_finish <= 1'b0; // @[Data.scala 400:33]
      fbank_fft_finish_regNext <= 1'b0; // @[Data.scala 400:33]
      fbank_pow_finish_regNext <= 1'b0; // @[Data.scala 400:33]
      fbank_mel_finish_regNext <= 1'b0; // @[Data.scala 400:33]
      quant_wait_flag <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(filter_filter_start) begin
        filter_en_reg <= 1'b1; // @[fbank_top.scala 94:19]
      end else begin
        if(filter_filter_finish) begin
          filter_en_reg <= 1'b0; // @[fbank_top.scala 96:19]
        end
      end
      vad_finish <= (pingpong_flag ^ pingpong_flag_regNext_1); // @[Reg.scala 39:30]
      fbank_fft_finish_regNext <= fft_finish; // @[Reg.scala 39:30]
      fbank_pow_finish_regNext <= pow_finish; // @[Reg.scala 39:30]
      fbank_mel_finish_regNext <= mel_finish; // @[Reg.scala 39:30]
      if(log_finish) begin
        quant_wait_flag <= 1'b1; // @[fbank_top.scala 182:21]
      end else begin
        if(quant_start_time) begin
          quant_wait_flag <= 1'b0; // @[fbank_top.scala 184:21]
        end
      end
    end
  end

  always @(posedge clk) begin
    kws_enable_regNext <= kws_enable; // @[Reg.scala 39:30]
    pingpong_flag_regNext <= pingpong_flag; // @[Reg.scala 39:30]
    pingpong_flag_regNext_1 <= pingpong_flag; // @[Reg.scala 39:30]
    quant_wait_flag_regNext <= quant_wait_flag; // @[Reg.scala 39:30]
  end


endmodule

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
  output              kws_out_is_valid,
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
  wire       [3:0]    tmp_kws_out_is_valid;
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
  assign tmp_kws_out_is_valid = 4'b1111;
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
  assign kws_out_is_valid = (! (kws_output == tmp_kws_out_is_valid)); // @[core_stack_regfile.scala 143:23]
  assign lowBandWidth_mem_rdata = rdata; // @[core_stack_regfile.scala 170:29]
  assign ro_stack_0 = {21'd0, conv1_ifmap_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_1 = {21'd0, conv1_ofmap_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_2 = {21'd0, conv1_filter_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_3 = {21'd0, conv1_bias_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_4 = {21'd0, conv1_quant_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_5 = {24'd0, conv1_inner_cnt}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_6 = {24'd0, conv1_outer_cnt}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_7 = {24'd0, conv1_out_x}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_8 = {21'd0, dpconv_ifmap_start_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_9 = {21'd0, dpconv_filter_start_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_10 = {24'd0, dpconv_conv_width}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_11 = {21'd0, dpconv_bias_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_12 = {21'd0, dpconv_quant_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_13 = {21'd0, dpconv_ofmap_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_14 = {21'd0, dpconv_fmap_fifo_start_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_15 = {21'd0, dpconv_fmap_fifo_end_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_16 = {24'd0, dpconv_outer_cnt}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_17 = {21'd0, sk_ifmap1_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_18 = {21'd0, sk_ifmap2_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_19 = {21'd0, sk_params_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_20 = {21'd0, sk_ofmap_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_21 = {21'd0, ibb_c1_ifmap_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_22 = {21'd0, ibb_c1_ofmap_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_23 = {24'd0, ibb_c1_out_x}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_24 = {21'd0, ibb_dw_ifmap_p}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_25 = {24'd0, ibb_conv_cnt}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_26 = sm_ln2_p; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_27 = sm_numerator_0; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_28 = sm_numerator_1; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_29 = sm_numerator_2; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_30 = sm_numerator_3; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_31 = sm_numerator_4; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_32 = sm_numerator_5; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_33 = sm_numerator_6; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_34 = sm_numerator_7; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_35 = sm_numerator_8; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_36 = sm_denominator; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_37 = {28'd0, max_index_now}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_38 = max_value_now; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_39 = {28'd0, max_index_last}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_40 = {24'd0, wake_count}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_41 = {24'd0, block_count}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_42 = {28'd0, kws_output}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_43 = {24'd0, tmp_ro_stack_43}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_44 = {24'd0, tmp_ro_stack_44}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_45 = {24'd0, tmp_ro_stack_45}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_46 = {24'd0, tmp_ro_stack_46}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_47 = {24'd0, tmp_ro_stack_47}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_48 = {24'd0, tmp_ro_stack_48}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_49 = {24'd0, tmp_ro_stack_49}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_50 = {24'd0, tmp_ro_stack_50}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_51 = {24'd0, tmp_ro_stack_51}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_52 = {24'd0, tmp_ro_stack_52}; // @[core_stack_regfile.scala 202:17]
  assign ro_stack_53 = {24'd0, tmp_ro_stack_53}; // @[core_stack_regfile.scala 202:17]
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
          conv1_ifmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h01)) begin
          conv1_ofmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h02)) begin
          conv1_filter_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h03)) begin
          conv1_bias_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h04)) begin
          conv1_quant_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h05)) begin
          conv1_inner_cnt <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h06)) begin
          conv1_outer_cnt <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h07)) begin
          conv1_out_x <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h08)) begin
          dpconv_ifmap_start_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h09)) begin
          dpconv_filter_start_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0a)) begin
          dpconv_conv_width <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0b)) begin
          dpconv_bias_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0c)) begin
          dpconv_quant_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0d)) begin
          dpconv_ofmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0e)) begin
          dpconv_fmap_fifo_start_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0f)) begin
          dpconv_fmap_fifo_end_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h10)) begin
          dpconv_outer_cnt <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h11)) begin
          sk_ifmap1_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h12)) begin
          sk_ifmap2_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h13)) begin
          sk_params_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h14)) begin
          sk_ofmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h15)) begin
          ibb_c1_ifmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h16)) begin
          ibb_c1_ofmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h17)) begin
          ibb_c1_out_x <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h18)) begin
          ibb_dw_ifmap_p <= lowBandWidth_mem_wdata[10 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h19)) begin
          ibb_conv_cnt <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1a)) begin
          sm_ln2_p <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1b)) begin
          sm_numerator_0 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1c)) begin
          sm_numerator_1 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1d)) begin
          sm_numerator_2 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1e)) begin
          sm_numerator_3 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1f)) begin
          sm_numerator_4 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h20)) begin
          sm_numerator_5 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h21)) begin
          sm_numerator_6 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h22)) begin
          sm_numerator_7 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h23)) begin
          sm_numerator_8 <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h24)) begin
          sm_denominator <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h25)) begin
          max_index_now <= lowBandWidth_mem_wdata[3 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h26)) begin
          max_value_now <= lowBandWidth_mem_wdata[31 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h27)) begin
          max_index_last <= lowBandWidth_mem_wdata[3 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h28)) begin
          wake_count <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h29)) begin
          block_count <= lowBandWidth_mem_wdata[7 : 0]; // @[core_stack_regfile.scala 153:18]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2a)) begin
          kws_output <= lowBandWidth_mem_wdata[3 : 0]; // @[core_stack_regfile.scala 153:18]
        end
      end
      if(lowBandWidth_mem_rd) begin
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0)) begin
          rdata <= {21'd0, conv1_ifmap_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h01)) begin
          rdata <= {21'd0, conv1_ofmap_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h02)) begin
          rdata <= {21'd0, conv1_filter_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h03)) begin
          rdata <= {21'd0, conv1_bias_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h04)) begin
          rdata <= {21'd0, conv1_quant_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h05)) begin
          rdata <= {24'd0, conv1_inner_cnt}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h06)) begin
          rdata <= {24'd0, conv1_outer_cnt}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h07)) begin
          rdata <= {24'd0, conv1_out_x}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h08)) begin
          rdata <= {21'd0, dpconv_ifmap_start_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h09)) begin
          rdata <= {21'd0, dpconv_filter_start_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0a)) begin
          rdata <= {24'd0, dpconv_conv_width}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0b)) begin
          rdata <= {21'd0, dpconv_bias_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0c)) begin
          rdata <= {21'd0, dpconv_quant_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0d)) begin
          rdata <= {21'd0, dpconv_ofmap_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0e)) begin
          rdata <= {21'd0, dpconv_fmap_fifo_start_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h0f)) begin
          rdata <= {21'd0, dpconv_fmap_fifo_end_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h10)) begin
          rdata <= {24'd0, dpconv_outer_cnt}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h11)) begin
          rdata <= {21'd0, sk_ifmap1_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h12)) begin
          rdata <= {21'd0, sk_ifmap2_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h13)) begin
          rdata <= {21'd0, sk_params_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h14)) begin
          rdata <= {21'd0, sk_ofmap_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h15)) begin
          rdata <= {21'd0, ibb_c1_ifmap_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h16)) begin
          rdata <= {21'd0, ibb_c1_ofmap_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h17)) begin
          rdata <= {24'd0, ibb_c1_out_x}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h18)) begin
          rdata <= {21'd0, ibb_dw_ifmap_p}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h19)) begin
          rdata <= {24'd0, ibb_conv_cnt}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1a)) begin
          rdata <= sm_ln2_p; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1b)) begin
          rdata <= sm_numerator_0; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1c)) begin
          rdata <= sm_numerator_1; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1d)) begin
          rdata <= sm_numerator_2; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1e)) begin
          rdata <= sm_numerator_3; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h1f)) begin
          rdata <= sm_numerator_4; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h20)) begin
          rdata <= sm_numerator_5; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h21)) begin
          rdata <= sm_numerator_6; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h22)) begin
          rdata <= sm_numerator_7; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h23)) begin
          rdata <= sm_numerator_8; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h24)) begin
          rdata <= sm_denominator; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h25)) begin
          rdata <= {28'd0, max_index_now}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h26)) begin
          rdata <= max_value_now; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h27)) begin
          rdata <= {28'd0, max_index_last}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h28)) begin
          rdata <= {24'd0, wake_count}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h29)) begin
          rdata <= {24'd0, block_count}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2a)) begin
          rdata <= {28'd0, kws_output}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2b)) begin
          rdata <= {24'd0, tmp_rdata}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2c)) begin
          rdata <= {24'd0, tmp_rdata_1}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2d)) begin
          rdata <= {24'd0, tmp_rdata_2}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2e)) begin
          rdata <= {24'd0, tmp_rdata_3}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h2f)) begin
          rdata <= {24'd0, tmp_rdata_4}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h30)) begin
          rdata <= {24'd0, tmp_rdata_5}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h31)) begin
          rdata <= {24'd0, tmp_rdata_6}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h32)) begin
          rdata <= {24'd0, tmp_rdata_7}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h33)) begin
          rdata <= {24'd0, tmp_rdata_8}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h34)) begin
          rdata <= {24'd0, tmp_rdata_9}; // @[core_stack_regfile.scala 174:15]
        end
        if((lowBandWidth_mem_addr[6 : 0] == 7'h35)) begin
          rdata <= {24'd0, tmp_rdata_10}; // @[core_stack_regfile.scala 174:15]
        end
      end
    end
  end


endmodule

module irom (
  input               io_irom_if_mem_rd,
  input               io_irom_if_mem_wr,
  input      [10:0]   io_irom_if_mem_addr,
  input      [15:0]   io_irom_if_mem_wdata,
  output     [15:0]   io_irom_if_mem_rdata,
  input               clk,
  input               resetn
);

  reg        [15:0]   tmp_rd_data_reg;
  wire       [15:0]   rom_data_0;
  wire       [15:0]   rom_data_1;
  wire       [15:0]   rom_data_2;
  wire       [15:0]   rom_data_3;
  wire       [15:0]   rom_data_4;
  wire       [15:0]   rom_data_5;
  wire       [15:0]   rom_data_6;
  wire       [15:0]   rom_data_7;
  wire       [15:0]   rom_data_8;
  wire       [15:0]   rom_data_9;
  wire       [15:0]   rom_data_10;
  wire       [15:0]   rom_data_11;
  wire       [15:0]   rom_data_12;
  wire       [15:0]   rom_data_13;
  wire       [15:0]   rom_data_14;
  wire       [15:0]   rom_data_15;
  wire       [15:0]   rom_data_16;
  wire       [15:0]   rom_data_17;
  wire       [15:0]   rom_data_18;
  wire       [15:0]   rom_data_19;
  wire       [15:0]   rom_data_20;
  wire       [15:0]   rom_data_21;
  wire       [15:0]   rom_data_22;
  wire       [15:0]   rom_data_23;
  wire       [15:0]   rom_data_24;
  wire       [15:0]   rom_data_25;
  wire       [15:0]   rom_data_26;
  wire       [15:0]   rom_data_27;
  wire       [15:0]   rom_data_28;
  wire       [15:0]   rom_data_29;
  wire       [15:0]   rom_data_30;
  wire       [15:0]   rom_data_31;
  wire       [15:0]   rom_data_32;
  wire       [15:0]   rom_data_33;
  wire       [15:0]   rom_data_34;
  wire       [15:0]   rom_data_35;
  wire       [15:0]   rom_data_36;
  wire       [15:0]   rom_data_37;
  wire       [15:0]   rom_data_38;
  wire       [15:0]   rom_data_39;
  wire       [15:0]   rom_data_40;
  wire       [15:0]   rom_data_41;
  wire       [15:0]   rom_data_42;
  wire       [15:0]   rom_data_43;
  wire       [15:0]   rom_data_44;
  wire       [15:0]   rom_data_45;
  wire       [15:0]   rom_data_46;
  wire       [15:0]   rom_data_47;
  wire       [15:0]   rom_data_48;
  wire       [15:0]   rom_data_49;
  wire       [15:0]   rom_data_50;
  wire       [15:0]   rom_data_51;
  wire       [15:0]   rom_data_52;
  wire       [15:0]   rom_data_53;
  wire       [15:0]   rom_data_54;
  wire       [15:0]   rom_data_55;
  wire       [15:0]   rom_data_56;
  wire       [15:0]   rom_data_57;
  wire       [15:0]   rom_data_58;
  wire       [15:0]   rom_data_59;
  wire       [15:0]   rom_data_60;
  wire       [15:0]   rom_data_61;
  wire       [15:0]   rom_data_62;
  wire       [15:0]   rom_data_63;
  wire       [15:0]   rom_data_64;
  wire       [15:0]   rom_data_65;
  wire       [15:0]   rom_data_66;
  wire       [15:0]   rom_data_67;
  wire       [15:0]   rom_data_68;
  wire       [15:0]   rom_data_69;
  wire       [15:0]   rom_data_70;
  wire       [15:0]   rom_data_71;
  wire       [15:0]   rom_data_72;
  wire       [15:0]   rom_data_73;
  wire       [15:0]   rom_data_74;
  wire       [15:0]   rom_data_75;
  wire       [15:0]   rom_data_76;
  wire       [15:0]   rom_data_77;
  wire       [15:0]   rom_data_78;
  wire       [15:0]   rom_data_79;
  wire       [15:0]   rom_data_80;
  wire       [15:0]   rom_data_81;
  wire       [15:0]   rom_data_82;
  wire       [15:0]   rom_data_83;
  wire       [15:0]   rom_data_84;
  wire       [15:0]   rom_data_85;
  wire       [15:0]   rom_data_86;
  wire       [15:0]   rom_data_87;
  wire       [15:0]   rom_data_88;
  wire       [15:0]   rom_data_89;
  wire       [15:0]   rom_data_90;
  wire       [15:0]   rom_data_91;
  wire       [15:0]   rom_data_92;
  wire       [15:0]   rom_data_93;
  wire       [15:0]   rom_data_94;
  wire       [15:0]   rom_data_95;
  wire       [15:0]   rom_data_96;
  wire       [15:0]   rom_data_97;
  wire       [15:0]   rom_data_98;
  wire       [15:0]   rom_data_99;
  wire       [15:0]   rom_data_100;
  wire       [15:0]   rom_data_101;
  wire       [15:0]   rom_data_102;
  wire       [15:0]   rom_data_103;
  wire       [15:0]   rom_data_104;
  wire       [15:0]   rom_data_105;
  wire       [15:0]   rom_data_106;
  wire       [15:0]   rom_data_107;
  wire       [15:0]   rom_data_108;
  wire       [15:0]   rom_data_109;
  wire       [15:0]   rom_data_110;
  wire       [15:0]   rom_data_111;
  wire       [15:0]   rom_data_112;
  wire       [15:0]   rom_data_113;
  wire       [15:0]   rom_data_114;
  wire       [15:0]   rom_data_115;
  wire       [15:0]   rom_data_116;
  wire       [15:0]   rom_data_117;
  wire       [15:0]   rom_data_118;
  wire       [15:0]   rom_data_119;
  wire       [15:0]   rom_data_120;
  wire       [15:0]   rom_data_121;
  wire       [15:0]   rom_data_122;
  wire       [15:0]   rom_data_123;
  wire       [15:0]   rom_data_124;
  wire       [15:0]   rom_data_125;
  wire       [15:0]   rom_data_126;
  wire       [15:0]   rom_data_127;
  wire       [15:0]   rom_data_128;
  wire       [15:0]   rom_data_129;
  wire       [15:0]   rom_data_130;
  wire       [15:0]   rom_data_131;
  wire       [15:0]   rom_data_132;
  wire       [15:0]   rom_data_133;
  wire       [15:0]   rom_data_134;
  wire       [15:0]   rom_data_135;
  wire       [15:0]   rom_data_136;
  wire       [15:0]   rom_data_137;
  wire       [15:0]   rom_data_138;
  wire       [15:0]   rom_data_139;
  wire       [15:0]   rom_data_140;
  wire       [15:0]   rom_data_141;
  wire       [15:0]   rom_data_142;
  wire       [15:0]   rom_data_143;
  wire       [15:0]   rom_data_144;
  wire       [15:0]   rom_data_145;
  wire       [15:0]   rom_data_146;
  wire       [15:0]   rom_data_147;
  wire       [15:0]   rom_data_148;
  wire       [15:0]   rom_data_149;
  wire       [15:0]   rom_data_150;
  wire       [15:0]   rom_data_151;
  wire       [15:0]   rom_data_152;
  wire       [15:0]   rom_data_153;
  wire       [15:0]   rom_data_154;
  wire       [15:0]   rom_data_155;
  wire       [15:0]   rom_data_156;
  wire       [15:0]   rom_data_157;
  wire       [15:0]   rom_data_158;
  wire       [15:0]   rom_data_159;
  wire       [15:0]   rom_data_160;
  wire       [15:0]   rom_data_161;
  wire       [15:0]   rom_data_162;
  wire       [15:0]   rom_data_163;
  wire       [15:0]   rom_data_164;
  wire       [15:0]   rom_data_165;
  wire       [15:0]   rom_data_166;
  wire       [15:0]   rom_data_167;
  wire       [15:0]   rom_data_168;
  wire       [15:0]   rom_data_169;
  wire       [15:0]   rom_data_170;
  wire       [15:0]   rom_data_171;
  wire       [15:0]   rom_data_172;
  wire       [15:0]   rom_data_173;
  wire       [15:0]   rom_data_174;
  wire       [15:0]   rom_data_175;
  wire       [15:0]   rom_data_176;
  wire       [15:0]   rom_data_177;
  wire       [15:0]   rom_data_178;
  wire       [15:0]   rom_data_179;
  wire       [15:0]   rom_data_180;
  wire       [15:0]   rom_data_181;
  wire       [15:0]   rom_data_182;
  wire       [15:0]   rom_data_183;
  wire       [15:0]   rom_data_184;
  wire       [15:0]   rom_data_185;
  wire       [15:0]   rom_data_186;
  wire       [15:0]   rom_data_187;
  wire       [15:0]   rom_data_188;
  wire       [15:0]   rom_data_189;
  wire       [15:0]   rom_data_190;
  wire       [15:0]   rom_data_191;
  wire       [15:0]   rom_data_192;
  wire       [15:0]   rom_data_193;
  wire       [15:0]   rom_data_194;
  wire       [15:0]   rom_data_195;
  wire       [15:0]   rom_data_196;
  wire       [15:0]   rom_data_197;
  wire       [15:0]   rom_data_198;
  wire       [15:0]   rom_data_199;
  wire       [15:0]   rom_data_200;
  wire       [15:0]   rom_data_201;
  wire       [15:0]   rom_data_202;
  wire       [15:0]   rom_data_203;
  wire       [15:0]   rom_data_204;
  wire       [15:0]   rom_data_205;
  wire       [15:0]   rom_data_206;
  wire       [15:0]   rom_data_207;
  wire       [15:0]   rom_data_208;
  wire       [15:0]   rom_data_209;
  wire       [15:0]   rom_data_210;
  wire       [15:0]   rom_data_211;
  wire       [15:0]   rom_data_212;
  wire       [15:0]   rom_data_213;
  wire       [15:0]   rom_data_214;
  wire       [15:0]   rom_data_215;
  wire       [15:0]   rom_data_216;
  wire       [15:0]   rom_data_217;
  wire       [15:0]   rom_data_218;
  wire       [15:0]   rom_data_219;
  wire       [15:0]   rom_data_220;
  wire       [15:0]   rom_data_221;
  wire       [15:0]   rom_data_222;
  wire       [15:0]   rom_data_223;
  wire       [15:0]   rom_data_224;
  wire       [15:0]   rom_data_225;
  wire       [15:0]   rom_data_226;
  wire       [15:0]   rom_data_227;
  wire       [15:0]   rom_data_228;
  wire       [15:0]   rom_data_229;
  wire       [15:0]   rom_data_230;
  wire       [15:0]   rom_data_231;
  wire       [15:0]   rom_data_232;
  wire       [15:0]   rom_data_233;
  wire       [15:0]   rom_data_234;
  wire       [15:0]   rom_data_235;
  wire       [15:0]   rom_data_236;
  wire       [15:0]   rom_data_237;
  wire       [15:0]   rom_data_238;
  wire       [15:0]   rom_data_239;
  wire       [15:0]   rom_data_240;
  wire       [15:0]   rom_data_241;
  wire       [15:0]   rom_data_242;
  wire       [15:0]   rom_data_243;
  wire       [15:0]   rom_data_244;
  wire       [15:0]   rom_data_245;
  wire       [15:0]   rom_data_246;
  wire       [15:0]   rom_data_247;
  wire       [15:0]   rom_data_248;
  wire       [15:0]   rom_data_249;
  wire       [15:0]   rom_data_250;
  wire       [15:0]   rom_data_251;
  wire       [15:0]   rom_data_252;
  wire       [15:0]   rom_data_253;
  wire       [15:0]   rom_data_254;
  wire       [15:0]   rom_data_255;
  wire       [15:0]   rom_data_256;
  wire       [15:0]   rom_data_257;
  wire       [15:0]   rom_data_258;
  wire       [15:0]   rom_data_259;
  wire       [15:0]   rom_data_260;
  wire       [15:0]   rom_data_261;
  wire       [15:0]   rom_data_262;
  wire       [15:0]   rom_data_263;
  wire       [15:0]   rom_data_264;
  wire       [15:0]   rom_data_265;
  wire       [15:0]   rom_data_266;
  wire       [15:0]   rom_data_267;
  wire       [15:0]   rom_data_268;
  wire       [15:0]   rom_data_269;
  wire       [15:0]   rom_data_270;
  wire       [15:0]   rom_data_271;
  wire       [15:0]   rom_data_272;
  wire       [15:0]   rom_data_273;
  wire       [15:0]   rom_data_274;
  wire       [15:0]   rom_data_275;
  wire       [15:0]   rom_data_276;
  wire       [15:0]   rom_data_277;
  wire       [15:0]   rom_data_278;
  wire       [15:0]   rom_data_279;
  wire       [15:0]   rom_data_280;
  wire       [15:0]   rom_data_281;
  wire       [15:0]   rom_data_282;
  wire       [15:0]   rom_data_283;
  wire       [15:0]   rom_data_284;
  wire       [15:0]   rom_data_285;
  wire       [15:0]   rom_data_286;
  wire       [15:0]   rom_data_287;
  wire       [15:0]   rom_data_288;
  wire       [15:0]   rom_data_289;
  wire       [15:0]   rom_data_290;
  wire       [15:0]   rom_data_291;
  wire       [15:0]   rom_data_292;
  wire       [15:0]   rom_data_293;
  wire       [15:0]   rom_data_294;
  wire       [15:0]   rom_data_295;
  wire       [15:0]   rom_data_296;
  wire       [15:0]   rom_data_297;
  wire       [15:0]   rom_data_298;
  wire       [15:0]   rom_data_299;
  wire       [15:0]   rom_data_300;
  wire       [15:0]   rom_data_301;
  wire       [15:0]   rom_data_302;
  wire       [15:0]   rom_data_303;
  wire       [15:0]   rom_data_304;
  wire       [15:0]   rom_data_305;
  wire       [15:0]   rom_data_306;
  wire       [15:0]   rom_data_307;
  wire       [15:0]   rom_data_308;
  wire       [15:0]   rom_data_309;
  wire       [15:0]   rom_data_310;
  wire       [15:0]   rom_data_311;
  wire       [15:0]   rom_data_312;
  wire       [15:0]   rom_data_313;
  wire       [15:0]   rom_data_314;
  wire       [15:0]   rom_data_315;
  wire       [15:0]   rom_data_316;
  wire       [15:0]   rom_data_317;
  wire       [15:0]   rom_data_318;
  wire       [15:0]   rom_data_319;
  wire       [15:0]   rom_data_320;
  wire       [15:0]   rom_data_321;
  wire       [15:0]   rom_data_322;
  wire       [15:0]   rom_data_323;
  wire       [15:0]   rom_data_324;
  wire       [15:0]   rom_data_325;
  wire       [15:0]   rom_data_326;
  wire       [15:0]   rom_data_327;
  wire       [15:0]   rom_data_328;
  wire       [15:0]   rom_data_329;
  wire       [15:0]   rom_data_330;
  wire       [15:0]   rom_data_331;
  wire       [15:0]   rom_data_332;
  wire       [15:0]   rom_data_333;
  wire       [15:0]   rom_data_334;
  wire       [15:0]   rom_data_335;
  wire       [15:0]   rom_data_336;
  wire       [15:0]   rom_data_337;
  wire       [15:0]   rom_data_338;
  wire       [15:0]   rom_data_339;
  wire       [15:0]   rom_data_340;
  wire       [15:0]   rom_data_341;
  wire       [15:0]   rom_data_342;
  wire       [15:0]   rom_data_343;
  wire       [15:0]   rom_data_344;
  wire       [15:0]   rom_data_345;
  wire       [15:0]   rom_data_346;
  wire       [15:0]   rom_data_347;
  wire       [15:0]   rom_data_348;
  wire       [15:0]   rom_data_349;
  wire       [15:0]   rom_data_350;
  wire       [15:0]   rom_data_351;
  wire       [15:0]   rom_data_352;
  wire       [15:0]   rom_data_353;
  wire       [15:0]   rom_data_354;
  wire       [15:0]   rom_data_355;
  wire       [15:0]   rom_data_356;
  wire       [15:0]   rom_data_357;
  wire       [15:0]   rom_data_358;
  wire       [15:0]   rom_data_359;
  wire       [15:0]   rom_data_360;
  wire       [15:0]   rom_data_361;
  wire       [15:0]   rom_data_362;
  wire       [15:0]   rom_data_363;
  wire       [15:0]   rom_data_364;
  wire       [15:0]   rom_data_365;
  wire       [15:0]   rom_data_366;
  wire       [15:0]   rom_data_367;
  wire       [15:0]   rom_data_368;
  wire       [15:0]   rom_data_369;
  wire       [15:0]   rom_data_370;
  wire       [15:0]   rom_data_371;
  wire       [15:0]   rom_data_372;
  wire       [15:0]   rom_data_373;
  wire       [15:0]   rom_data_374;
  wire       [15:0]   rom_data_375;
  wire       [15:0]   rom_data_376;
  wire       [15:0]   rom_data_377;
  wire       [15:0]   rom_data_378;
  wire       [15:0]   rom_data_379;
  wire       [15:0]   rom_data_380;
  wire       [15:0]   rom_data_381;
  wire       [15:0]   rom_data_382;
  wire       [15:0]   rom_data_383;
  wire       [15:0]   rom_data_384;
  wire       [15:0]   rom_data_385;
  wire       [15:0]   rom_data_386;
  wire       [15:0]   rom_data_387;
  wire       [15:0]   rom_data_388;
  wire       [15:0]   rom_data_389;
  wire       [15:0]   rom_data_390;
  wire       [15:0]   rom_data_391;
  wire       [15:0]   rom_data_392;
  wire       [15:0]   rom_data_393;
  wire       [15:0]   rom_data_394;
  wire       [15:0]   rom_data_395;
  wire       [15:0]   rom_data_396;
  wire       [15:0]   rom_data_397;
  wire       [15:0]   rom_data_398;
  wire       [15:0]   rom_data_399;
  wire       [15:0]   rom_data_400;
  wire       [15:0]   rom_data_401;
  wire       [15:0]   rom_data_402;
  wire       [15:0]   rom_data_403;
  wire       [15:0]   rom_data_404;
  wire       [15:0]   rom_data_405;
  wire       [15:0]   rom_data_406;
  wire       [15:0]   rom_data_407;
  wire       [15:0]   rom_data_408;
  wire       [15:0]   rom_data_409;
  wire       [15:0]   rom_data_410;
  wire       [15:0]   rom_data_411;
  wire       [15:0]   rom_data_412;
  wire       [15:0]   rom_data_413;
  wire       [15:0]   rom_data_414;
  wire       [15:0]   rom_data_415;
  wire       [15:0]   rom_data_416;
  wire       [15:0]   rom_data_417;
  wire       [15:0]   rom_data_418;
  wire       [15:0]   rom_data_419;
  wire       [15:0]   rom_data_420;
  wire       [15:0]   rom_data_421;
  wire       [15:0]   rom_data_422;
  wire       [15:0]   rom_data_423;
  wire       [15:0]   rom_data_424;
  wire       [15:0]   rom_data_425;
  wire       [15:0]   rom_data_426;
  wire       [15:0]   rom_data_427;
  wire       [15:0]   rom_data_428;
  wire       [15:0]   rom_data_429;
  wire       [15:0]   rom_data_430;
  wire       [15:0]   rom_data_431;
  wire       [15:0]   rom_data_432;
  wire       [15:0]   rom_data_433;
  wire       [15:0]   rom_data_434;
  wire       [15:0]   rom_data_435;
  wire       [15:0]   rom_data_436;
  wire       [15:0]   rom_data_437;
  wire       [15:0]   rom_data_438;
  wire       [15:0]   rom_data_439;
  wire       [15:0]   rom_data_440;
  wire       [15:0]   rom_data_441;
  wire       [15:0]   rom_data_442;
  wire       [15:0]   rom_data_443;
  wire       [15:0]   rom_data_444;
  wire       [15:0]   rom_data_445;
  wire       [15:0]   rom_data_446;
  wire       [15:0]   rom_data_447;
  wire       [15:0]   rom_data_448;
  wire       [15:0]   rom_data_449;
  wire       [15:0]   rom_data_450;
  wire       [15:0]   rom_data_451;
  wire       [15:0]   rom_data_452;
  wire       [15:0]   rom_data_453;
  wire       [15:0]   rom_data_454;
  wire       [15:0]   rom_data_455;
  wire       [15:0]   rom_data_456;
  wire       [15:0]   rom_data_457;
  wire       [15:0]   rom_data_458;
  wire       [15:0]   rom_data_459;
  wire       [15:0]   rom_data_460;
  wire       [15:0]   rom_data_461;
  wire       [15:0]   rom_data_462;
  wire       [15:0]   rom_data_463;
  wire       [15:0]   rom_data_464;
  wire       [15:0]   rom_data_465;
  wire       [15:0]   rom_data_466;
  wire       [15:0]   rom_data_467;
  wire       [15:0]   rom_data_468;
  wire       [15:0]   rom_data_469;
  wire       [15:0]   rom_data_470;
  wire       [15:0]   rom_data_471;
  wire       [15:0]   rom_data_472;
  wire       [15:0]   rom_data_473;
  wire       [15:0]   rom_data_474;
  wire       [15:0]   rom_data_475;
  wire       [15:0]   rom_data_476;
  wire       [15:0]   rom_data_477;
  wire       [15:0]   rom_data_478;
  wire       [15:0]   rom_data_479;
  wire       [15:0]   rom_data_480;
  wire       [15:0]   rom_data_481;
  wire       [15:0]   rom_data_482;
  wire       [15:0]   rom_data_483;
  wire       [15:0]   rom_data_484;
  wire       [15:0]   rom_data_485;
  wire       [15:0]   rom_data_486;
  wire       [15:0]   rom_data_487;
  wire       [15:0]   rom_data_488;
  wire       [15:0]   rom_data_489;
  wire       [15:0]   rom_data_490;
  wire       [15:0]   rom_data_491;
  wire       [15:0]   rom_data_492;
  wire       [15:0]   rom_data_493;
  wire       [15:0]   rom_data_494;
  wire       [15:0]   rom_data_495;
  wire       [15:0]   rom_data_496;
  wire       [15:0]   rom_data_497;
  wire       [15:0]   rom_data_498;
  wire       [15:0]   rom_data_499;
  wire       [15:0]   rom_data_500;
  wire       [15:0]   rom_data_501;
  wire       [15:0]   rom_data_502;
  wire       [15:0]   rom_data_503;
  wire       [15:0]   rom_data_504;
  wire       [15:0]   rom_data_505;
  wire       [15:0]   rom_data_506;
  wire       [15:0]   rom_data_507;
  wire       [15:0]   rom_data_508;
  wire       [15:0]   rom_data_509;
  wire       [15:0]   rom_data_510;
  wire       [15:0]   rom_data_511;
  wire       [15:0]   rom_data_512;
  wire       [15:0]   rom_data_513;
  wire       [15:0]   rom_data_514;
  wire       [15:0]   rom_data_515;
  wire       [15:0]   rom_data_516;
  wire       [15:0]   rom_data_517;
  wire       [15:0]   rom_data_518;
  wire       [15:0]   rom_data_519;
  wire       [15:0]   rom_data_520;
  wire       [15:0]   rom_data_521;
  wire       [15:0]   rom_data_522;
  wire       [15:0]   rom_data_523;
  wire       [15:0]   rom_data_524;
  wire       [15:0]   rom_data_525;
  wire       [15:0]   rom_data_526;
  wire       [15:0]   rom_data_527;
  wire       [15:0]   rom_data_528;
  wire       [15:0]   rom_data_529;
  wire       [15:0]   rom_data_530;
  wire       [15:0]   rom_data_531;
  wire       [15:0]   rom_data_532;
  wire       [15:0]   rom_data_533;
  wire       [15:0]   rom_data_534;
  wire       [15:0]   rom_data_535;
  wire       [15:0]   rom_data_536;
  wire       [15:0]   rom_data_537;
  wire       [15:0]   rom_data_538;
  wire       [15:0]   rom_data_539;
  wire       [15:0]   rom_data_540;
  wire       [15:0]   rom_data_541;
  wire       [15:0]   rom_data_542;
  wire       [15:0]   rom_data_543;
  wire       [15:0]   rom_data_544;
  wire       [15:0]   rom_data_545;
  wire       [15:0]   rom_data_546;
  wire       [15:0]   rom_data_547;
  wire       [15:0]   rom_data_548;
  wire       [15:0]   rom_data_549;
  wire       [15:0]   rom_data_550;
  wire       [15:0]   rom_data_551;
  wire       [15:0]   rom_data_552;
  wire       [15:0]   rom_data_553;
  wire       [15:0]   rom_data_554;
  wire       [15:0]   rom_data_555;
  wire       [15:0]   rom_data_556;
  wire       [15:0]   rom_data_557;
  wire       [15:0]   rom_data_558;
  wire       [15:0]   rom_data_559;
  wire       [15:0]   rom_data_560;
  wire       [15:0]   rom_data_561;
  wire       [15:0]   rom_data_562;
  wire       [15:0]   rom_data_563;
  wire       [15:0]   rom_data_564;
  wire       [15:0]   rom_data_565;
  wire       [15:0]   rom_data_566;
  wire       [15:0]   rom_data_567;
  wire       [15:0]   rom_data_568;
  wire       [15:0]   rom_data_569;
  wire       [15:0]   rom_data_570;
  wire       [15:0]   rom_data_571;
  wire       [15:0]   rom_data_572;
  wire       [15:0]   rom_data_573;
  wire       [15:0]   rom_data_574;
  wire       [15:0]   rom_data_575;
  wire       [15:0]   rom_data_576;
  wire       [15:0]   rom_data_577;
  wire       [15:0]   rom_data_578;
  wire       [15:0]   rom_data_579;
  wire       [15:0]   rom_data_580;
  wire       [15:0]   rom_data_581;
  wire       [15:0]   rom_data_582;
  wire       [15:0]   rom_data_583;
  wire       [15:0]   rom_data_584;
  wire       [15:0]   rom_data_585;
  wire       [15:0]   rom_data_586;
  wire       [15:0]   rom_data_587;
  wire       [15:0]   rom_data_588;
  wire       [15:0]   rom_data_589;
  wire       [15:0]   rom_data_590;
  wire       [15:0]   rom_data_591;
  wire       [15:0]   rom_data_592;
  wire       [15:0]   rom_data_593;
  wire       [15:0]   rom_data_594;
  wire       [15:0]   rom_data_595;
  wire       [15:0]   rom_data_596;
  wire       [15:0]   rom_data_597;
  wire       [15:0]   rom_data_598;
  wire       [15:0]   rom_data_599;
  wire       [15:0]   rom_data_600;
  wire       [15:0]   rom_data_601;
  wire       [15:0]   rom_data_602;
  wire       [15:0]   rom_data_603;
  wire       [15:0]   rom_data_604;
  wire       [15:0]   rom_data_605;
  wire       [15:0]   rom_data_606;
  wire       [15:0]   rom_data_607;
  wire       [15:0]   rom_data_608;
  wire       [15:0]   rom_data_609;
  wire       [15:0]   rom_data_610;
  wire       [15:0]   rom_data_611;
  wire       [15:0]   rom_data_612;
  wire       [15:0]   rom_data_613;
  wire       [15:0]   rom_data_614;
  wire       [15:0]   rom_data_615;
  wire       [15:0]   rom_data_616;
  wire       [15:0]   rom_data_617;
  wire       [15:0]   rom_data_618;
  wire       [15:0]   rom_data_619;
  wire       [15:0]   rom_data_620;
  wire       [15:0]   rom_data_621;
  wire       [15:0]   rom_data_622;
  wire       [15:0]   rom_data_623;
  wire       [15:0]   rom_data_624;
  wire       [15:0]   rom_data_625;
  wire       [15:0]   rom_data_626;
  wire       [15:0]   rom_data_627;
  wire       [15:0]   rom_data_628;
  wire       [15:0]   rom_data_629;
  wire       [15:0]   rom_data_630;
  wire       [15:0]   rom_data_631;
  wire       [15:0]   rom_data_632;
  wire       [15:0]   rom_data_633;
  wire       [15:0]   rom_data_634;
  wire       [15:0]   rom_data_635;
  wire       [15:0]   rom_data_636;
  wire       [15:0]   rom_data_637;
  wire       [15:0]   rom_data_638;
  wire       [15:0]   rom_data_639;
  wire       [15:0]   rom_data_640;
  wire       [15:0]   rom_data_641;
  wire       [15:0]   rom_data_642;
  wire       [15:0]   rom_data_643;
  wire       [15:0]   rom_data_644;
  wire       [15:0]   rom_data_645;
  wire       [15:0]   rom_data_646;
  wire       [15:0]   rom_data_647;
  wire       [15:0]   rom_data_648;
  wire       [15:0]   rom_data_649;
  wire       [15:0]   rom_data_650;
  wire       [15:0]   rom_data_651;
  wire       [15:0]   rom_data_652;
  wire       [15:0]   rom_data_653;
  wire       [15:0]   rom_data_654;
  wire       [15:0]   rom_data_655;
  wire       [15:0]   rom_data_656;
  wire       [15:0]   rom_data_657;
  wire       [15:0]   rom_data_658;
  wire       [15:0]   rom_data_659;
  wire       [15:0]   rom_data_660;
  wire       [15:0]   rom_data_661;
  wire       [15:0]   rom_data_662;
  wire       [15:0]   rom_data_663;
  wire       [15:0]   rom_data_664;
  wire       [15:0]   rom_data_665;
  wire       [15:0]   rom_data_666;
  wire       [15:0]   rom_data_667;
  wire       [15:0]   rom_data_668;
  wire       [15:0]   rom_data_669;
  wire       [15:0]   rom_data_670;
  wire       [15:0]   rom_data_671;
  wire       [15:0]   rom_data_672;
  wire       [15:0]   rom_data_673;
  wire       [15:0]   rom_data_674;
  wire       [15:0]   rom_data_675;
  wire       [15:0]   rom_data_676;
  wire       [15:0]   rom_data_677;
  wire       [15:0]   rom_data_678;
  wire       [15:0]   rom_data_679;
  wire       [15:0]   rom_data_680;
  wire       [15:0]   rom_data_681;
  wire       [15:0]   rom_data_682;
  wire       [15:0]   rom_data_683;
  wire       [15:0]   rom_data_684;
  wire       [15:0]   rom_data_685;
  wire       [15:0]   rom_data_686;
  wire       [15:0]   rom_data_687;
  wire       [15:0]   rom_data_688;
  wire       [15:0]   rom_data_689;
  wire       [15:0]   rom_data_690;
  wire       [15:0]   rom_data_691;
  wire       [15:0]   rom_data_692;
  wire       [15:0]   rom_data_693;
  wire       [15:0]   rom_data_694;
  wire       [15:0]   rom_data_695;
  wire       [15:0]   rom_data_696;
  wire       [15:0]   rom_data_697;
  wire       [15:0]   rom_data_698;
  wire       [15:0]   rom_data_699;
  wire       [15:0]   rom_data_700;
  wire       [15:0]   rom_data_701;
  wire       [15:0]   rom_data_702;
  wire       [15:0]   rom_data_703;
  wire       [15:0]   rom_data_704;
  wire       [15:0]   rom_data_705;
  wire       [15:0]   rom_data_706;
  wire       [15:0]   rom_data_707;
  wire       [15:0]   rom_data_708;
  wire       [15:0]   rom_data_709;
  wire       [15:0]   rom_data_710;
  wire       [15:0]   rom_data_711;
  wire       [15:0]   rom_data_712;
  wire       [15:0]   rom_data_713;
  wire       [15:0]   rom_data_714;
  wire       [15:0]   rom_data_715;
  wire       [15:0]   rom_data_716;
  wire       [15:0]   rom_data_717;
  wire       [15:0]   rom_data_718;
  wire       [15:0]   rom_data_719;
  wire       [15:0]   rom_data_720;
  wire       [15:0]   rom_data_721;
  wire       [15:0]   rom_data_722;
  wire       [15:0]   rom_data_723;
  wire       [15:0]   rom_data_724;
  wire       [15:0]   rom_data_725;
  wire       [15:0]   rom_data_726;
  wire       [15:0]   rom_data_727;
  wire       [15:0]   rom_data_728;
  wire       [15:0]   rom_data_729;
  wire       [15:0]   rom_data_730;
  wire       [15:0]   rom_data_731;
  wire       [15:0]   rom_data_732;
  wire       [15:0]   rom_data_733;
  wire       [15:0]   rom_data_734;
  wire       [15:0]   rom_data_735;
  wire       [15:0]   rom_data_736;
  wire       [15:0]   rom_data_737;
  wire       [15:0]   rom_data_738;
  wire       [15:0]   rom_data_739;
  wire       [15:0]   rom_data_740;
  wire       [15:0]   rom_data_741;
  wire       [15:0]   rom_data_742;
  wire       [15:0]   rom_data_743;
  wire       [15:0]   rom_data_744;
  wire       [15:0]   rom_data_745;
  wire       [15:0]   rom_data_746;
  wire       [15:0]   rom_data_747;
  wire       [15:0]   rom_data_748;
  wire       [15:0]   rom_data_749;
  wire       [15:0]   rom_data_750;
  wire       [15:0]   rom_data_751;
  wire       [15:0]   rom_data_752;
  wire       [15:0]   rom_data_753;
  wire       [15:0]   rom_data_754;
  wire       [15:0]   rom_data_755;
  wire       [15:0]   rom_data_756;
  wire       [15:0]   rom_data_757;
  wire       [15:0]   rom_data_758;
  wire       [15:0]   rom_data_759;
  wire       [15:0]   rom_data_760;
  wire       [15:0]   rom_data_761;
  wire       [15:0]   rom_data_762;
  wire       [15:0]   rom_data_763;
  wire       [15:0]   rom_data_764;
  wire       [15:0]   rom_data_765;
  wire       [15:0]   rom_data_766;
  wire       [15:0]   rom_data_767;
  wire       [15:0]   rom_data_768;
  wire       [15:0]   rom_data_769;
  wire       [15:0]   rom_data_770;
  wire       [15:0]   rom_data_771;
  wire       [15:0]   rom_data_772;
  wire       [15:0]   rom_data_773;
  wire       [15:0]   rom_data_774;
  wire       [15:0]   rom_data_775;
  wire       [15:0]   rom_data_776;
  wire       [15:0]   rom_data_777;
  wire       [15:0]   rom_data_778;
  wire       [15:0]   rom_data_779;
  wire       [15:0]   rom_data_780;
  wire       [15:0]   rom_data_781;
  wire       [15:0]   rom_data_782;
  wire       [15:0]   rom_data_783;
  wire       [15:0]   rom_data_784;
  wire       [15:0]   rom_data_785;
  wire       [15:0]   rom_data_786;
  wire       [15:0]   rom_data_787;
  wire       [15:0]   rom_data_788;
  wire       [15:0]   rom_data_789;
  wire       [15:0]   rom_data_790;
  wire       [15:0]   rom_data_791;
  wire       [15:0]   rom_data_792;
  wire       [15:0]   rom_data_793;
  wire       [15:0]   rom_data_794;
  wire       [15:0]   rom_data_795;
  wire       [15:0]   rom_data_796;
  wire       [15:0]   rom_data_797;
  wire       [15:0]   rom_data_798;
  wire       [15:0]   rom_data_799;
  wire       [15:0]   rom_data_800;
  wire       [15:0]   rom_data_801;
  wire       [15:0]   rom_data_802;
  wire       [15:0]   rom_data_803;
  wire       [15:0]   rom_data_804;
  wire       [15:0]   rom_data_805;
  wire       [15:0]   rom_data_806;
  wire       [15:0]   rom_data_807;
  wire       [15:0]   rom_data_808;
  wire       [15:0]   rom_data_809;
  wire       [15:0]   rom_data_810;
  wire       [15:0]   rom_data_811;
  wire       [15:0]   rom_data_812;
  wire       [15:0]   rom_data_813;
  wire       [15:0]   rom_data_814;
  wire       [15:0]   rom_data_815;
  wire       [15:0]   rom_data_816;
  wire       [15:0]   rom_data_817;
  wire       [15:0]   rom_data_818;
  wire       [15:0]   rom_data_819;
  wire       [15:0]   rom_data_820;
  wire       [15:0]   rom_data_821;
  wire       [15:0]   rom_data_822;
  wire       [15:0]   rom_data_823;
  wire       [15:0]   rom_data_824;
  wire       [15:0]   rom_data_825;
  wire       [15:0]   rom_data_826;
  wire       [15:0]   rom_data_827;
  wire       [15:0]   rom_data_828;
  wire       [15:0]   rom_data_829;
  wire       [15:0]   rom_data_830;
  wire       [15:0]   rom_data_831;
  wire       [15:0]   rom_data_832;
  wire       [15:0]   rom_data_833;
  wire       [15:0]   rom_data_834;
  wire       [15:0]   rom_data_835;
  wire       [15:0]   rom_data_836;
  wire       [15:0]   rom_data_837;
  wire       [15:0]   rom_data_838;
  wire       [15:0]   rom_data_839;
  wire       [15:0]   rom_data_840;
  wire       [15:0]   rom_data_841;
  wire       [15:0]   rom_data_842;
  wire       [15:0]   rom_data_843;
  wire       [15:0]   rom_data_844;
  wire       [15:0]   rom_data_845;
  wire       [15:0]   rom_data_846;
  wire       [15:0]   rom_data_847;
  wire       [15:0]   rom_data_848;
  wire       [15:0]   rom_data_849;
  wire       [15:0]   rom_data_850;
  wire       [15:0]   rom_data_851;
  wire       [15:0]   rom_data_852;
  wire       [15:0]   rom_data_853;
  wire       [15:0]   rom_data_854;
  wire       [15:0]   rom_data_855;
  wire       [15:0]   rom_data_856;
  wire       [15:0]   rom_data_857;
  wire       [15:0]   rom_data_858;
  wire       [15:0]   rom_data_859;
  wire       [15:0]   rom_data_860;
  wire       [15:0]   rom_data_861;
  wire       [15:0]   rom_data_862;
  wire       [15:0]   rom_data_863;
  wire       [15:0]   rom_data_864;
  wire       [15:0]   rom_data_865;
  wire       [15:0]   rom_data_866;
  wire       [15:0]   rom_data_867;
  wire       [15:0]   rom_data_868;
  wire       [15:0]   rom_data_869;
  wire       [15:0]   rom_data_870;
  wire       [15:0]   rom_data_871;
  wire       [15:0]   rom_data_872;
  wire       [15:0]   rom_data_873;
  wire       [15:0]   rom_data_874;
  wire       [15:0]   rom_data_875;
  wire       [15:0]   rom_data_876;
  wire       [15:0]   rom_data_877;
  wire       [15:0]   rom_data_878;
  wire       [15:0]   rom_data_879;
  wire       [15:0]   rom_data_880;
  wire       [15:0]   rom_data_881;
  wire       [15:0]   rom_data_882;
  wire       [15:0]   rom_data_883;
  wire       [15:0]   rom_data_884;
  wire       [15:0]   rom_data_885;
  wire       [15:0]   rom_data_886;
  wire       [15:0]   rom_data_887;
  wire       [15:0]   rom_data_888;
  wire       [15:0]   rom_data_889;
  wire       [15:0]   rom_data_890;
  wire       [15:0]   rom_data_891;
  wire       [15:0]   rom_data_892;
  wire       [15:0]   rom_data_893;
  wire       [15:0]   rom_data_894;
  wire       [15:0]   rom_data_895;
  wire       [15:0]   rom_data_896;
  wire       [15:0]   rom_data_897;
  wire       [15:0]   rom_data_898;
  wire       [15:0]   rom_data_899;
  wire       [15:0]   rom_data_900;
  wire       [15:0]   rom_data_901;
  wire       [15:0]   rom_data_902;
  wire       [15:0]   rom_data_903;
  wire       [15:0]   rom_data_904;
  wire       [15:0]   rom_data_905;
  wire       [15:0]   rom_data_906;
  wire       [15:0]   rom_data_907;
  wire       [15:0]   rom_data_908;
  wire       [15:0]   rom_data_909;
  wire       [15:0]   rom_data_910;
  wire       [15:0]   rom_data_911;
  wire       [15:0]   rom_data_912;
  wire       [15:0]   rom_data_913;
  wire       [15:0]   rom_data_914;
  wire       [15:0]   rom_data_915;
  wire       [15:0]   rom_data_916;
  wire       [15:0]   rom_data_917;
  wire       [15:0]   rom_data_918;
  wire       [15:0]   rom_data_919;
  wire       [15:0]   rom_data_920;
  wire       [15:0]   rom_data_921;
  wire       [15:0]   rom_data_922;
  wire       [15:0]   rom_data_923;
  wire       [15:0]   rom_data_924;
  wire       [15:0]   rom_data_925;
  wire       [15:0]   rom_data_926;
  wire       [15:0]   rom_data_927;
  wire       [15:0]   rom_data_928;
  wire       [15:0]   rom_data_929;
  wire       [15:0]   rom_data_930;
  wire       [15:0]   rom_data_931;
  wire       [15:0]   rom_data_932;
  wire       [15:0]   rom_data_933;
  wire       [15:0]   rom_data_934;
  wire       [15:0]   rom_data_935;
  wire       [15:0]   rom_data_936;
  wire       [15:0]   rom_data_937;
  wire       [15:0]   rom_data_938;
  wire       [15:0]   rom_data_939;
  wire       [15:0]   rom_data_940;
  wire       [15:0]   rom_data_941;
  wire       [15:0]   rom_data_942;
  wire       [15:0]   rom_data_943;
  wire       [15:0]   rom_data_944;
  wire       [15:0]   rom_data_945;
  wire       [15:0]   rom_data_946;
  wire       [15:0]   rom_data_947;
  wire       [15:0]   rom_data_948;
  wire       [15:0]   rom_data_949;
  wire       [15:0]   rom_data_950;
  wire       [15:0]   rom_data_951;
  wire       [15:0]   rom_data_952;
  wire       [15:0]   rom_data_953;
  wire       [15:0]   rom_data_954;
  wire       [15:0]   rom_data_955;
  wire       [15:0]   rom_data_956;
  wire       [15:0]   rom_data_957;
  wire       [15:0]   rom_data_958;
  wire       [15:0]   rom_data_959;
  wire       [15:0]   rom_data_960;
  wire       [15:0]   rom_data_961;
  wire       [15:0]   rom_data_962;
  wire       [15:0]   rom_data_963;
  wire       [15:0]   rom_data_964;
  wire       [15:0]   rom_data_965;
  wire       [15:0]   rom_data_966;
  wire       [15:0]   rom_data_967;
  wire       [15:0]   rom_data_968;
  wire       [15:0]   rom_data_969;
  wire       [15:0]   rom_data_970;
  wire       [15:0]   rom_data_971;
  wire       [15:0]   rom_data_972;
  wire       [15:0]   rom_data_973;
  wire       [15:0]   rom_data_974;
  wire       [15:0]   rom_data_975;
  wire       [15:0]   rom_data_976;
  wire       [15:0]   rom_data_977;
  wire       [15:0]   rom_data_978;
  wire       [15:0]   rom_data_979;
  wire       [15:0]   rom_data_980;
  wire       [15:0]   rom_data_981;
  wire       [15:0]   rom_data_982;
  wire       [15:0]   rom_data_983;
  wire       [15:0]   rom_data_984;
  wire       [15:0]   rom_data_985;
  wire       [15:0]   rom_data_986;
  wire       [15:0]   rom_data_987;
  wire       [15:0]   rom_data_988;
  wire       [15:0]   rom_data_989;
  wire       [15:0]   rom_data_990;
  wire       [15:0]   rom_data_991;
  wire       [15:0]   rom_data_992;
  wire       [15:0]   rom_data_993;
  wire       [15:0]   rom_data_994;
  wire       [15:0]   rom_data_995;
  wire       [15:0]   rom_data_996;
  wire       [15:0]   rom_data_997;
  wire       [15:0]   rom_data_998;
  wire       [15:0]   rom_data_999;
  wire       [15:0]   rom_data_1000;
  wire       [15:0]   rom_data_1001;
  wire       [15:0]   rom_data_1002;
  wire       [15:0]   rom_data_1003;
  wire       [15:0]   rom_data_1004;
  wire       [15:0]   rom_data_1005;
  wire       [15:0]   rom_data_1006;
  wire       [15:0]   rom_data_1007;
  wire       [15:0]   rom_data_1008;
  wire       [15:0]   rom_data_1009;
  wire       [15:0]   rom_data_1010;
  wire       [15:0]   rom_data_1011;
  wire       [15:0]   rom_data_1012;
  wire       [15:0]   rom_data_1013;
  wire       [15:0]   rom_data_1014;
  wire       [15:0]   rom_data_1015;
  wire       [15:0]   rom_data_1016;
  wire       [15:0]   rom_data_1017;
  wire       [15:0]   rom_data_1018;
  wire       [15:0]   rom_data_1019;
  wire       [15:0]   rom_data_1020;
  wire       [15:0]   rom_data_1021;
  wire       [15:0]   rom_data_1022;
  wire       [15:0]   rom_data_1023;
  wire       [15:0]   rom_data_1024;
  wire       [15:0]   rom_data_1025;
  wire       [15:0]   rom_data_1026;
  wire       [15:0]   rom_data_1027;
  wire       [15:0]   rom_data_1028;
  wire       [15:0]   rom_data_1029;
  wire       [15:0]   rom_data_1030;
  wire       [15:0]   rom_data_1031;
  wire       [15:0]   rom_data_1032;
  wire       [15:0]   rom_data_1033;
  wire       [15:0]   rom_data_1034;
  wire       [15:0]   rom_data_1035;
  wire       [15:0]   rom_data_1036;
  wire       [15:0]   rom_data_1037;
  wire       [15:0]   rom_data_1038;
  wire       [15:0]   rom_data_1039;
  wire       [15:0]   rom_data_1040;
  wire       [15:0]   rom_data_1041;
  wire       [15:0]   rom_data_1042;
  wire       [15:0]   rom_data_1043;
  wire       [15:0]   rom_data_1044;
  wire       [15:0]   rom_data_1045;
  wire       [15:0]   rom_data_1046;
  wire       [15:0]   rom_data_1047;
  wire       [15:0]   rom_data_1048;
  wire       [15:0]   rom_data_1049;
  wire       [15:0]   rom_data_1050;
  wire       [15:0]   rom_data_1051;
  wire       [15:0]   rom_data_1052;
  wire       [15:0]   rom_data_1053;
  wire       [15:0]   rom_data_1054;
  wire       [15:0]   rom_data_1055;
  wire       [15:0]   rom_data_1056;
  wire       [15:0]   rom_data_1057;
  wire       [15:0]   rom_data_1058;
  wire       [15:0]   rom_data_1059;
  wire       [15:0]   rom_data_1060;
  wire       [15:0]   rom_data_1061;
  wire       [15:0]   rom_data_1062;
  wire       [15:0]   rom_data_1063;
  wire       [15:0]   rom_data_1064;
  wire       [15:0]   rom_data_1065;
  wire       [15:0]   rom_data_1066;
  wire       [15:0]   rom_data_1067;
  wire       [15:0]   rom_data_1068;
  wire       [15:0]   rom_data_1069;
  wire       [15:0]   rom_data_1070;
  wire       [15:0]   rom_data_1071;
  wire       [15:0]   rom_data_1072;
  wire       [15:0]   rom_data_1073;
  wire       [15:0]   rom_data_1074;
  wire       [15:0]   rom_data_1075;
  wire       [15:0]   rom_data_1076;
  wire       [15:0]   rom_data_1077;
  wire       [15:0]   rom_data_1078;
  wire       [15:0]   rom_data_1079;
  wire       [15:0]   rom_data_1080;
  wire       [15:0]   rom_data_1081;
  wire       [15:0]   rom_data_1082;
  wire       [15:0]   rom_data_1083;
  wire       [15:0]   rom_data_1084;
  wire       [15:0]   rom_data_1085;
  wire       [15:0]   rom_data_1086;
  wire       [15:0]   rom_data_1087;
  wire       [15:0]   rom_data_1088;
  wire       [15:0]   rom_data_1089;
  wire       [15:0]   rom_data_1090;
  wire       [15:0]   rom_data_1091;
  wire       [15:0]   rom_data_1092;
  wire       [15:0]   rom_data_1093;
  wire       [15:0]   rom_data_1094;
  wire       [15:0]   rom_data_1095;
  wire       [15:0]   rom_data_1096;
  wire       [15:0]   rom_data_1097;
  wire       [15:0]   rom_data_1098;
  wire       [15:0]   rom_data_1099;
  wire       [15:0]   rom_data_1100;
  wire       [15:0]   rom_data_1101;
  wire       [15:0]   rom_data_1102;
  wire       [15:0]   rom_data_1103;
  wire       [15:0]   rom_data_1104;
  wire       [15:0]   rom_data_1105;
  wire       [15:0]   rom_data_1106;
  wire       [15:0]   rom_data_1107;
  wire       [15:0]   rom_data_1108;
  wire       [15:0]   rom_data_1109;
  wire       [15:0]   rom_data_1110;
  wire       [15:0]   rom_data_1111;
  wire       [15:0]   rom_data_1112;
  wire       [15:0]   rom_data_1113;
  wire       [15:0]   rom_data_1114;
  wire       [15:0]   rom_data_1115;
  wire       [15:0]   rom_data_1116;
  wire       [15:0]   rom_data_1117;
  wire       [15:0]   rom_data_1118;
  wire       [15:0]   rom_data_1119;
  wire       [15:0]   rom_data_1120;
  wire       [15:0]   rom_data_1121;
  wire       [15:0]   rom_data_1122;
  wire       [15:0]   rom_data_1123;
  wire       [15:0]   rom_data_1124;
  wire       [15:0]   rom_data_1125;
  wire       [15:0]   rom_data_1126;
  wire       [15:0]   rom_data_1127;
  wire       [15:0]   rom_data_1128;
  wire       [15:0]   rom_data_1129;
  wire       [15:0]   rom_data_1130;
  wire       [15:0]   rom_data_1131;
  wire       [15:0]   rom_data_1132;
  wire       [15:0]   rom_data_1133;
  wire       [15:0]   rom_data_1134;
  wire       [15:0]   rom_data_1135;
  wire       [15:0]   rom_data_1136;
  wire       [15:0]   rom_data_1137;
  wire       [15:0]   rom_data_1138;
  wire       [15:0]   rom_data_1139;
  wire       [15:0]   rom_data_1140;
  wire       [15:0]   rom_data_1141;
  wire       [15:0]   rom_data_1142;
  wire       [15:0]   rom_data_1143;
  wire       [15:0]   rom_data_1144;
  wire       [15:0]   rom_data_1145;
  wire       [15:0]   rom_data_1146;
  wire       [15:0]   rom_data_1147;
  wire       [15:0]   rom_data_1148;
  wire       [15:0]   rom_data_1149;
  wire       [15:0]   rom_data_1150;
  wire       [15:0]   rom_data_1151;
  wire       [15:0]   rom_data_1152;
  wire       [15:0]   rom_data_1153;
  wire       [15:0]   rom_data_1154;
  wire       [15:0]   rom_data_1155;
  wire       [15:0]   rom_data_1156;
  wire       [15:0]   rom_data_1157;
  wire       [15:0]   rom_data_1158;
  wire       [15:0]   rom_data_1159;
  wire       [15:0]   rom_data_1160;
  wire       [15:0]   rom_data_1161;
  wire       [15:0]   rom_data_1162;
  wire       [15:0]   rom_data_1163;
  wire       [15:0]   rom_data_1164;
  wire       [15:0]   rom_data_1165;
  wire       [15:0]   rom_data_1166;
  wire       [15:0]   rom_data_1167;
  wire       [15:0]   rom_data_1168;
  wire       [15:0]   rom_data_1169;
  wire       [15:0]   rom_data_1170;
  wire       [15:0]   rom_data_1171;
  wire       [15:0]   rom_data_1172;
  wire       [15:0]   rom_data_1173;
  wire       [15:0]   rom_data_1174;
  wire       [15:0]   rom_data_1175;
  wire       [15:0]   rom_data_1176;
  wire       [15:0]   rom_data_1177;
  wire       [15:0]   rom_data_1178;
  wire       [15:0]   rom_data_1179;
  wire       [15:0]   rom_data_1180;
  wire       [15:0]   rom_data_1181;
  wire       [15:0]   rom_data_1182;
  wire       [15:0]   rom_data_1183;
  wire       [15:0]   rom_data_1184;
  wire       [15:0]   rom_data_1185;
  wire       [15:0]   rom_data_1186;
  wire       [15:0]   rom_data_1187;
  wire       [15:0]   rom_data_1188;
  wire       [15:0]   rom_data_1189;
  wire       [15:0]   rom_data_1190;
  wire       [15:0]   rom_data_1191;
  wire       [15:0]   rom_data_1192;
  wire       [15:0]   rom_data_1193;
  wire       [15:0]   rom_data_1194;
  wire       [15:0]   rom_data_1195;
  wire       [15:0]   rom_data_1196;
  wire       [15:0]   rom_data_1197;
  wire       [15:0]   rom_data_1198;
  wire       [15:0]   rom_data_1199;
  wire       [15:0]   rom_data_1200;
  wire       [15:0]   rom_data_1201;
  wire       [15:0]   rom_data_1202;
  wire       [15:0]   rom_data_1203;
  wire       [15:0]   rom_data_1204;
  wire       [15:0]   rom_data_1205;
  wire       [15:0]   rom_data_1206;
  wire       [15:0]   rom_data_1207;
  wire       [15:0]   rom_data_1208;
  wire       [15:0]   rom_data_1209;
  wire       [15:0]   rom_data_1210;
  wire       [15:0]   rom_data_1211;
  wire       [15:0]   rom_data_1212;
  wire       [15:0]   rom_data_1213;
  wire       [15:0]   rom_data_1214;
  wire       [15:0]   rom_data_1215;
  wire       [15:0]   rom_data_1216;
  wire       [15:0]   rom_data_1217;
  wire       [15:0]   rom_data_1218;
  wire       [15:0]   rom_data_1219;
  wire       [15:0]   rom_data_1220;
  wire       [15:0]   rom_data_1221;
  wire       [15:0]   rom_data_1222;
  wire       [15:0]   rom_data_1223;
  wire       [15:0]   rom_data_1224;
  wire       [15:0]   rom_data_1225;
  wire       [15:0]   rom_data_1226;
  wire       [15:0]   rom_data_1227;
  wire       [15:0]   rom_data_1228;
  wire       [15:0]   rom_data_1229;
  wire       [15:0]   rom_data_1230;
  wire       [15:0]   rom_data_1231;
  wire       [15:0]   rom_data_1232;
  wire       [15:0]   rom_data_1233;
  wire       [15:0]   rom_data_1234;
  wire       [15:0]   rom_data_1235;
  wire       [15:0]   rom_data_1236;
  wire       [15:0]   rom_data_1237;
  wire       [15:0]   rom_data_1238;
  wire       [15:0]   rom_data_1239;
  wire       [15:0]   rom_data_1240;
  wire       [15:0]   rom_data_1241;
  wire       [15:0]   rom_data_1242;
  wire       [15:0]   rom_data_1243;
  wire       [15:0]   rom_data_1244;
  wire       [15:0]   rom_data_1245;
  wire       [15:0]   rom_0;
  wire       [15:0]   rom_1;
  wire       [15:0]   rom_2;
  wire       [15:0]   rom_3;
  wire       [15:0]   rom_4;
  wire       [15:0]   rom_5;
  wire       [15:0]   rom_6;
  wire       [15:0]   rom_7;
  wire       [15:0]   rom_8;
  wire       [15:0]   rom_9;
  wire       [15:0]   rom_10;
  wire       [15:0]   rom_11;
  wire       [15:0]   rom_12;
  wire       [15:0]   rom_13;
  wire       [15:0]   rom_14;
  wire       [15:0]   rom_15;
  wire       [15:0]   rom_16;
  wire       [15:0]   rom_17;
  wire       [15:0]   rom_18;
  wire       [15:0]   rom_19;
  wire       [15:0]   rom_20;
  wire       [15:0]   rom_21;
  wire       [15:0]   rom_22;
  wire       [15:0]   rom_23;
  wire       [15:0]   rom_24;
  wire       [15:0]   rom_25;
  wire       [15:0]   rom_26;
  wire       [15:0]   rom_27;
  wire       [15:0]   rom_28;
  wire       [15:0]   rom_29;
  wire       [15:0]   rom_30;
  wire       [15:0]   rom_31;
  wire       [15:0]   rom_32;
  wire       [15:0]   rom_33;
  wire       [15:0]   rom_34;
  wire       [15:0]   rom_35;
  wire       [15:0]   rom_36;
  wire       [15:0]   rom_37;
  wire       [15:0]   rom_38;
  wire       [15:0]   rom_39;
  wire       [15:0]   rom_40;
  wire       [15:0]   rom_41;
  wire       [15:0]   rom_42;
  wire       [15:0]   rom_43;
  wire       [15:0]   rom_44;
  wire       [15:0]   rom_45;
  wire       [15:0]   rom_46;
  wire       [15:0]   rom_47;
  wire       [15:0]   rom_48;
  wire       [15:0]   rom_49;
  wire       [15:0]   rom_50;
  wire       [15:0]   rom_51;
  wire       [15:0]   rom_52;
  wire       [15:0]   rom_53;
  wire       [15:0]   rom_54;
  wire       [15:0]   rom_55;
  wire       [15:0]   rom_56;
  wire       [15:0]   rom_57;
  wire       [15:0]   rom_58;
  wire       [15:0]   rom_59;
  wire       [15:0]   rom_60;
  wire       [15:0]   rom_61;
  wire       [15:0]   rom_62;
  wire       [15:0]   rom_63;
  wire       [15:0]   rom_64;
  wire       [15:0]   rom_65;
  wire       [15:0]   rom_66;
  wire       [15:0]   rom_67;
  wire       [15:0]   rom_68;
  wire       [15:0]   rom_69;
  wire       [15:0]   rom_70;
  wire       [15:0]   rom_71;
  wire       [15:0]   rom_72;
  wire       [15:0]   rom_73;
  wire       [15:0]   rom_74;
  wire       [15:0]   rom_75;
  wire       [15:0]   rom_76;
  wire       [15:0]   rom_77;
  wire       [15:0]   rom_78;
  wire       [15:0]   rom_79;
  wire       [15:0]   rom_80;
  wire       [15:0]   rom_81;
  wire       [15:0]   rom_82;
  wire       [15:0]   rom_83;
  wire       [15:0]   rom_84;
  wire       [15:0]   rom_85;
  wire       [15:0]   rom_86;
  wire       [15:0]   rom_87;
  wire       [15:0]   rom_88;
  wire       [15:0]   rom_89;
  wire       [15:0]   rom_90;
  wire       [15:0]   rom_91;
  wire       [15:0]   rom_92;
  wire       [15:0]   rom_93;
  wire       [15:0]   rom_94;
  wire       [15:0]   rom_95;
  wire       [15:0]   rom_96;
  wire       [15:0]   rom_97;
  wire       [15:0]   rom_98;
  wire       [15:0]   rom_99;
  wire       [15:0]   rom_100;
  wire       [15:0]   rom_101;
  wire       [15:0]   rom_102;
  wire       [15:0]   rom_103;
  wire       [15:0]   rom_104;
  wire       [15:0]   rom_105;
  wire       [15:0]   rom_106;
  wire       [15:0]   rom_107;
  wire       [15:0]   rom_108;
  wire       [15:0]   rom_109;
  wire       [15:0]   rom_110;
  wire       [15:0]   rom_111;
  wire       [15:0]   rom_112;
  wire       [15:0]   rom_113;
  wire       [15:0]   rom_114;
  wire       [15:0]   rom_115;
  wire       [15:0]   rom_116;
  wire       [15:0]   rom_117;
  wire       [15:0]   rom_118;
  wire       [15:0]   rom_119;
  wire       [15:0]   rom_120;
  wire       [15:0]   rom_121;
  wire       [15:0]   rom_122;
  wire       [15:0]   rom_123;
  wire       [15:0]   rom_124;
  wire       [15:0]   rom_125;
  wire       [15:0]   rom_126;
  wire       [15:0]   rom_127;
  wire       [15:0]   rom_128;
  wire       [15:0]   rom_129;
  wire       [15:0]   rom_130;
  wire       [15:0]   rom_131;
  wire       [15:0]   rom_132;
  wire       [15:0]   rom_133;
  wire       [15:0]   rom_134;
  wire       [15:0]   rom_135;
  wire       [15:0]   rom_136;
  wire       [15:0]   rom_137;
  wire       [15:0]   rom_138;
  wire       [15:0]   rom_139;
  wire       [15:0]   rom_140;
  wire       [15:0]   rom_141;
  wire       [15:0]   rom_142;
  wire       [15:0]   rom_143;
  wire       [15:0]   rom_144;
  wire       [15:0]   rom_145;
  wire       [15:0]   rom_146;
  wire       [15:0]   rom_147;
  wire       [15:0]   rom_148;
  wire       [15:0]   rom_149;
  wire       [15:0]   rom_150;
  wire       [15:0]   rom_151;
  wire       [15:0]   rom_152;
  wire       [15:0]   rom_153;
  wire       [15:0]   rom_154;
  wire       [15:0]   rom_155;
  wire       [15:0]   rom_156;
  wire       [15:0]   rom_157;
  wire       [15:0]   rom_158;
  wire       [15:0]   rom_159;
  wire       [15:0]   rom_160;
  wire       [15:0]   rom_161;
  wire       [15:0]   rom_162;
  wire       [15:0]   rom_163;
  wire       [15:0]   rom_164;
  wire       [15:0]   rom_165;
  wire       [15:0]   rom_166;
  wire       [15:0]   rom_167;
  wire       [15:0]   rom_168;
  wire       [15:0]   rom_169;
  wire       [15:0]   rom_170;
  wire       [15:0]   rom_171;
  wire       [15:0]   rom_172;
  wire       [15:0]   rom_173;
  wire       [15:0]   rom_174;
  wire       [15:0]   rom_175;
  wire       [15:0]   rom_176;
  wire       [15:0]   rom_177;
  wire       [15:0]   rom_178;
  wire       [15:0]   rom_179;
  wire       [15:0]   rom_180;
  wire       [15:0]   rom_181;
  wire       [15:0]   rom_182;
  wire       [15:0]   rom_183;
  wire       [15:0]   rom_184;
  wire       [15:0]   rom_185;
  wire       [15:0]   rom_186;
  wire       [15:0]   rom_187;
  wire       [15:0]   rom_188;
  wire       [15:0]   rom_189;
  wire       [15:0]   rom_190;
  wire       [15:0]   rom_191;
  wire       [15:0]   rom_192;
  wire       [15:0]   rom_193;
  wire       [15:0]   rom_194;
  wire       [15:0]   rom_195;
  wire       [15:0]   rom_196;
  wire       [15:0]   rom_197;
  wire       [15:0]   rom_198;
  wire       [15:0]   rom_199;
  wire       [15:0]   rom_200;
  wire       [15:0]   rom_201;
  wire       [15:0]   rom_202;
  wire       [15:0]   rom_203;
  wire       [15:0]   rom_204;
  wire       [15:0]   rom_205;
  wire       [15:0]   rom_206;
  wire       [15:0]   rom_207;
  wire       [15:0]   rom_208;
  wire       [15:0]   rom_209;
  wire       [15:0]   rom_210;
  wire       [15:0]   rom_211;
  wire       [15:0]   rom_212;
  wire       [15:0]   rom_213;
  wire       [15:0]   rom_214;
  wire       [15:0]   rom_215;
  wire       [15:0]   rom_216;
  wire       [15:0]   rom_217;
  wire       [15:0]   rom_218;
  wire       [15:0]   rom_219;
  wire       [15:0]   rom_220;
  wire       [15:0]   rom_221;
  wire       [15:0]   rom_222;
  wire       [15:0]   rom_223;
  wire       [15:0]   rom_224;
  wire       [15:0]   rom_225;
  wire       [15:0]   rom_226;
  wire       [15:0]   rom_227;
  wire       [15:0]   rom_228;
  wire       [15:0]   rom_229;
  wire       [15:0]   rom_230;
  wire       [15:0]   rom_231;
  wire       [15:0]   rom_232;
  wire       [15:0]   rom_233;
  wire       [15:0]   rom_234;
  wire       [15:0]   rom_235;
  wire       [15:0]   rom_236;
  wire       [15:0]   rom_237;
  wire       [15:0]   rom_238;
  wire       [15:0]   rom_239;
  wire       [15:0]   rom_240;
  wire       [15:0]   rom_241;
  wire       [15:0]   rom_242;
  wire       [15:0]   rom_243;
  wire       [15:0]   rom_244;
  wire       [15:0]   rom_245;
  wire       [15:0]   rom_246;
  wire       [15:0]   rom_247;
  wire       [15:0]   rom_248;
  wire       [15:0]   rom_249;
  wire       [15:0]   rom_250;
  wire       [15:0]   rom_251;
  wire       [15:0]   rom_252;
  wire       [15:0]   rom_253;
  wire       [15:0]   rom_254;
  wire       [15:0]   rom_255;
  wire       [15:0]   rom_256;
  wire       [15:0]   rom_257;
  wire       [15:0]   rom_258;
  wire       [15:0]   rom_259;
  wire       [15:0]   rom_260;
  wire       [15:0]   rom_261;
  wire       [15:0]   rom_262;
  wire       [15:0]   rom_263;
  wire       [15:0]   rom_264;
  wire       [15:0]   rom_265;
  wire       [15:0]   rom_266;
  wire       [15:0]   rom_267;
  wire       [15:0]   rom_268;
  wire       [15:0]   rom_269;
  wire       [15:0]   rom_270;
  wire       [15:0]   rom_271;
  wire       [15:0]   rom_272;
  wire       [15:0]   rom_273;
  wire       [15:0]   rom_274;
  wire       [15:0]   rom_275;
  wire       [15:0]   rom_276;
  wire       [15:0]   rom_277;
  wire       [15:0]   rom_278;
  wire       [15:0]   rom_279;
  wire       [15:0]   rom_280;
  wire       [15:0]   rom_281;
  wire       [15:0]   rom_282;
  wire       [15:0]   rom_283;
  wire       [15:0]   rom_284;
  wire       [15:0]   rom_285;
  wire       [15:0]   rom_286;
  wire       [15:0]   rom_287;
  wire       [15:0]   rom_288;
  wire       [15:0]   rom_289;
  wire       [15:0]   rom_290;
  wire       [15:0]   rom_291;
  wire       [15:0]   rom_292;
  wire       [15:0]   rom_293;
  wire       [15:0]   rom_294;
  wire       [15:0]   rom_295;
  wire       [15:0]   rom_296;
  wire       [15:0]   rom_297;
  wire       [15:0]   rom_298;
  wire       [15:0]   rom_299;
  wire       [15:0]   rom_300;
  wire       [15:0]   rom_301;
  wire       [15:0]   rom_302;
  wire       [15:0]   rom_303;
  wire       [15:0]   rom_304;
  wire       [15:0]   rom_305;
  wire       [15:0]   rom_306;
  wire       [15:0]   rom_307;
  wire       [15:0]   rom_308;
  wire       [15:0]   rom_309;
  wire       [15:0]   rom_310;
  wire       [15:0]   rom_311;
  wire       [15:0]   rom_312;
  wire       [15:0]   rom_313;
  wire       [15:0]   rom_314;
  wire       [15:0]   rom_315;
  wire       [15:0]   rom_316;
  wire       [15:0]   rom_317;
  wire       [15:0]   rom_318;
  wire       [15:0]   rom_319;
  wire       [15:0]   rom_320;
  wire       [15:0]   rom_321;
  wire       [15:0]   rom_322;
  wire       [15:0]   rom_323;
  wire       [15:0]   rom_324;
  wire       [15:0]   rom_325;
  wire       [15:0]   rom_326;
  wire       [15:0]   rom_327;
  wire       [15:0]   rom_328;
  wire       [15:0]   rom_329;
  wire       [15:0]   rom_330;
  wire       [15:0]   rom_331;
  wire       [15:0]   rom_332;
  wire       [15:0]   rom_333;
  wire       [15:0]   rom_334;
  wire       [15:0]   rom_335;
  wire       [15:0]   rom_336;
  wire       [15:0]   rom_337;
  wire       [15:0]   rom_338;
  wire       [15:0]   rom_339;
  wire       [15:0]   rom_340;
  wire       [15:0]   rom_341;
  wire       [15:0]   rom_342;
  wire       [15:0]   rom_343;
  wire       [15:0]   rom_344;
  wire       [15:0]   rom_345;
  wire       [15:0]   rom_346;
  wire       [15:0]   rom_347;
  wire       [15:0]   rom_348;
  wire       [15:0]   rom_349;
  wire       [15:0]   rom_350;
  wire       [15:0]   rom_351;
  wire       [15:0]   rom_352;
  wire       [15:0]   rom_353;
  wire       [15:0]   rom_354;
  wire       [15:0]   rom_355;
  wire       [15:0]   rom_356;
  wire       [15:0]   rom_357;
  wire       [15:0]   rom_358;
  wire       [15:0]   rom_359;
  wire       [15:0]   rom_360;
  wire       [15:0]   rom_361;
  wire       [15:0]   rom_362;
  wire       [15:0]   rom_363;
  wire       [15:0]   rom_364;
  wire       [15:0]   rom_365;
  wire       [15:0]   rom_366;
  wire       [15:0]   rom_367;
  wire       [15:0]   rom_368;
  wire       [15:0]   rom_369;
  wire       [15:0]   rom_370;
  wire       [15:0]   rom_371;
  wire       [15:0]   rom_372;
  wire       [15:0]   rom_373;
  wire       [15:0]   rom_374;
  wire       [15:0]   rom_375;
  wire       [15:0]   rom_376;
  wire       [15:0]   rom_377;
  wire       [15:0]   rom_378;
  wire       [15:0]   rom_379;
  wire       [15:0]   rom_380;
  wire       [15:0]   rom_381;
  wire       [15:0]   rom_382;
  wire       [15:0]   rom_383;
  wire       [15:0]   rom_384;
  wire       [15:0]   rom_385;
  wire       [15:0]   rom_386;
  wire       [15:0]   rom_387;
  wire       [15:0]   rom_388;
  wire       [15:0]   rom_389;
  wire       [15:0]   rom_390;
  wire       [15:0]   rom_391;
  wire       [15:0]   rom_392;
  wire       [15:0]   rom_393;
  wire       [15:0]   rom_394;
  wire       [15:0]   rom_395;
  wire       [15:0]   rom_396;
  wire       [15:0]   rom_397;
  wire       [15:0]   rom_398;
  wire       [15:0]   rom_399;
  wire       [15:0]   rom_400;
  wire       [15:0]   rom_401;
  wire       [15:0]   rom_402;
  wire       [15:0]   rom_403;
  wire       [15:0]   rom_404;
  wire       [15:0]   rom_405;
  wire       [15:0]   rom_406;
  wire       [15:0]   rom_407;
  wire       [15:0]   rom_408;
  wire       [15:0]   rom_409;
  wire       [15:0]   rom_410;
  wire       [15:0]   rom_411;
  wire       [15:0]   rom_412;
  wire       [15:0]   rom_413;
  wire       [15:0]   rom_414;
  wire       [15:0]   rom_415;
  wire       [15:0]   rom_416;
  wire       [15:0]   rom_417;
  wire       [15:0]   rom_418;
  wire       [15:0]   rom_419;
  wire       [15:0]   rom_420;
  wire       [15:0]   rom_421;
  wire       [15:0]   rom_422;
  wire       [15:0]   rom_423;
  wire       [15:0]   rom_424;
  wire       [15:0]   rom_425;
  wire       [15:0]   rom_426;
  wire       [15:0]   rom_427;
  wire       [15:0]   rom_428;
  wire       [15:0]   rom_429;
  wire       [15:0]   rom_430;
  wire       [15:0]   rom_431;
  wire       [15:0]   rom_432;
  wire       [15:0]   rom_433;
  wire       [15:0]   rom_434;
  wire       [15:0]   rom_435;
  wire       [15:0]   rom_436;
  wire       [15:0]   rom_437;
  wire       [15:0]   rom_438;
  wire       [15:0]   rom_439;
  wire       [15:0]   rom_440;
  wire       [15:0]   rom_441;
  wire       [15:0]   rom_442;
  wire       [15:0]   rom_443;
  wire       [15:0]   rom_444;
  wire       [15:0]   rom_445;
  wire       [15:0]   rom_446;
  wire       [15:0]   rom_447;
  wire       [15:0]   rom_448;
  wire       [15:0]   rom_449;
  wire       [15:0]   rom_450;
  wire       [15:0]   rom_451;
  wire       [15:0]   rom_452;
  wire       [15:0]   rom_453;
  wire       [15:0]   rom_454;
  wire       [15:0]   rom_455;
  wire       [15:0]   rom_456;
  wire       [15:0]   rom_457;
  wire       [15:0]   rom_458;
  wire       [15:0]   rom_459;
  wire       [15:0]   rom_460;
  wire       [15:0]   rom_461;
  wire       [15:0]   rom_462;
  wire       [15:0]   rom_463;
  wire       [15:0]   rom_464;
  wire       [15:0]   rom_465;
  wire       [15:0]   rom_466;
  wire       [15:0]   rom_467;
  wire       [15:0]   rom_468;
  wire       [15:0]   rom_469;
  wire       [15:0]   rom_470;
  wire       [15:0]   rom_471;
  wire       [15:0]   rom_472;
  wire       [15:0]   rom_473;
  wire       [15:0]   rom_474;
  wire       [15:0]   rom_475;
  wire       [15:0]   rom_476;
  wire       [15:0]   rom_477;
  wire       [15:0]   rom_478;
  wire       [15:0]   rom_479;
  wire       [15:0]   rom_480;
  wire       [15:0]   rom_481;
  wire       [15:0]   rom_482;
  wire       [15:0]   rom_483;
  wire       [15:0]   rom_484;
  wire       [15:0]   rom_485;
  wire       [15:0]   rom_486;
  wire       [15:0]   rom_487;
  wire       [15:0]   rom_488;
  wire       [15:0]   rom_489;
  wire       [15:0]   rom_490;
  wire       [15:0]   rom_491;
  wire       [15:0]   rom_492;
  wire       [15:0]   rom_493;
  wire       [15:0]   rom_494;
  wire       [15:0]   rom_495;
  wire       [15:0]   rom_496;
  wire       [15:0]   rom_497;
  wire       [15:0]   rom_498;
  wire       [15:0]   rom_499;
  wire       [15:0]   rom_500;
  wire       [15:0]   rom_501;
  wire       [15:0]   rom_502;
  wire       [15:0]   rom_503;
  wire       [15:0]   rom_504;
  wire       [15:0]   rom_505;
  wire       [15:0]   rom_506;
  wire       [15:0]   rom_507;
  wire       [15:0]   rom_508;
  wire       [15:0]   rom_509;
  wire       [15:0]   rom_510;
  wire       [15:0]   rom_511;
  wire       [15:0]   rom_512;
  wire       [15:0]   rom_513;
  wire       [15:0]   rom_514;
  wire       [15:0]   rom_515;
  wire       [15:0]   rom_516;
  wire       [15:0]   rom_517;
  wire       [15:0]   rom_518;
  wire       [15:0]   rom_519;
  wire       [15:0]   rom_520;
  wire       [15:0]   rom_521;
  wire       [15:0]   rom_522;
  wire       [15:0]   rom_523;
  wire       [15:0]   rom_524;
  wire       [15:0]   rom_525;
  wire       [15:0]   rom_526;
  wire       [15:0]   rom_527;
  wire       [15:0]   rom_528;
  wire       [15:0]   rom_529;
  wire       [15:0]   rom_530;
  wire       [15:0]   rom_531;
  wire       [15:0]   rom_532;
  wire       [15:0]   rom_533;
  wire       [15:0]   rom_534;
  wire       [15:0]   rom_535;
  wire       [15:0]   rom_536;
  wire       [15:0]   rom_537;
  wire       [15:0]   rom_538;
  wire       [15:0]   rom_539;
  wire       [15:0]   rom_540;
  wire       [15:0]   rom_541;
  wire       [15:0]   rom_542;
  wire       [15:0]   rom_543;
  wire       [15:0]   rom_544;
  wire       [15:0]   rom_545;
  wire       [15:0]   rom_546;
  wire       [15:0]   rom_547;
  wire       [15:0]   rom_548;
  wire       [15:0]   rom_549;
  wire       [15:0]   rom_550;
  wire       [15:0]   rom_551;
  wire       [15:0]   rom_552;
  wire       [15:0]   rom_553;
  wire       [15:0]   rom_554;
  wire       [15:0]   rom_555;
  wire       [15:0]   rom_556;
  wire       [15:0]   rom_557;
  wire       [15:0]   rom_558;
  wire       [15:0]   rom_559;
  wire       [15:0]   rom_560;
  wire       [15:0]   rom_561;
  wire       [15:0]   rom_562;
  wire       [15:0]   rom_563;
  wire       [15:0]   rom_564;
  wire       [15:0]   rom_565;
  wire       [15:0]   rom_566;
  wire       [15:0]   rom_567;
  wire       [15:0]   rom_568;
  wire       [15:0]   rom_569;
  wire       [15:0]   rom_570;
  wire       [15:0]   rom_571;
  wire       [15:0]   rom_572;
  wire       [15:0]   rom_573;
  wire       [15:0]   rom_574;
  wire       [15:0]   rom_575;
  wire       [15:0]   rom_576;
  wire       [15:0]   rom_577;
  wire       [15:0]   rom_578;
  wire       [15:0]   rom_579;
  wire       [15:0]   rom_580;
  wire       [15:0]   rom_581;
  wire       [15:0]   rom_582;
  wire       [15:0]   rom_583;
  wire       [15:0]   rom_584;
  wire       [15:0]   rom_585;
  wire       [15:0]   rom_586;
  wire       [15:0]   rom_587;
  wire       [15:0]   rom_588;
  wire       [15:0]   rom_589;
  wire       [15:0]   rom_590;
  wire       [15:0]   rom_591;
  wire       [15:0]   rom_592;
  wire       [15:0]   rom_593;
  wire       [15:0]   rom_594;
  wire       [15:0]   rom_595;
  wire       [15:0]   rom_596;
  wire       [15:0]   rom_597;
  wire       [15:0]   rom_598;
  wire       [15:0]   rom_599;
  wire       [15:0]   rom_600;
  wire       [15:0]   rom_601;
  wire       [15:0]   rom_602;
  wire       [15:0]   rom_603;
  wire       [15:0]   rom_604;
  wire       [15:0]   rom_605;
  wire       [15:0]   rom_606;
  wire       [15:0]   rom_607;
  wire       [15:0]   rom_608;
  wire       [15:0]   rom_609;
  wire       [15:0]   rom_610;
  wire       [15:0]   rom_611;
  wire       [15:0]   rom_612;
  wire       [15:0]   rom_613;
  wire       [15:0]   rom_614;
  wire       [15:0]   rom_615;
  wire       [15:0]   rom_616;
  wire       [15:0]   rom_617;
  wire       [15:0]   rom_618;
  wire       [15:0]   rom_619;
  wire       [15:0]   rom_620;
  wire       [15:0]   rom_621;
  wire       [15:0]   rom_622;
  wire       [15:0]   rom_623;
  wire       [15:0]   rom_624;
  wire       [15:0]   rom_625;
  wire       [15:0]   rom_626;
  wire       [15:0]   rom_627;
  wire       [15:0]   rom_628;
  wire       [15:0]   rom_629;
  wire       [15:0]   rom_630;
  wire       [15:0]   rom_631;
  wire       [15:0]   rom_632;
  wire       [15:0]   rom_633;
  wire       [15:0]   rom_634;
  wire       [15:0]   rom_635;
  wire       [15:0]   rom_636;
  wire       [15:0]   rom_637;
  wire       [15:0]   rom_638;
  wire       [15:0]   rom_639;
  wire       [15:0]   rom_640;
  wire       [15:0]   rom_641;
  wire       [15:0]   rom_642;
  wire       [15:0]   rom_643;
  wire       [15:0]   rom_644;
  wire       [15:0]   rom_645;
  wire       [15:0]   rom_646;
  wire       [15:0]   rom_647;
  wire       [15:0]   rom_648;
  wire       [15:0]   rom_649;
  wire       [15:0]   rom_650;
  wire       [15:0]   rom_651;
  wire       [15:0]   rom_652;
  wire       [15:0]   rom_653;
  wire       [15:0]   rom_654;
  wire       [15:0]   rom_655;
  wire       [15:0]   rom_656;
  wire       [15:0]   rom_657;
  wire       [15:0]   rom_658;
  wire       [15:0]   rom_659;
  wire       [15:0]   rom_660;
  wire       [15:0]   rom_661;
  wire       [15:0]   rom_662;
  wire       [15:0]   rom_663;
  wire       [15:0]   rom_664;
  wire       [15:0]   rom_665;
  wire       [15:0]   rom_666;
  wire       [15:0]   rom_667;
  wire       [15:0]   rom_668;
  wire       [15:0]   rom_669;
  wire       [15:0]   rom_670;
  wire       [15:0]   rom_671;
  wire       [15:0]   rom_672;
  wire       [15:0]   rom_673;
  wire       [15:0]   rom_674;
  wire       [15:0]   rom_675;
  wire       [15:0]   rom_676;
  wire       [15:0]   rom_677;
  wire       [15:0]   rom_678;
  wire       [15:0]   rom_679;
  wire       [15:0]   rom_680;
  wire       [15:0]   rom_681;
  wire       [15:0]   rom_682;
  wire       [15:0]   rom_683;
  wire       [15:0]   rom_684;
  wire       [15:0]   rom_685;
  wire       [15:0]   rom_686;
  wire       [15:0]   rom_687;
  wire       [15:0]   rom_688;
  wire       [15:0]   rom_689;
  wire       [15:0]   rom_690;
  wire       [15:0]   rom_691;
  wire       [15:0]   rom_692;
  wire       [15:0]   rom_693;
  wire       [15:0]   rom_694;
  wire       [15:0]   rom_695;
  wire       [15:0]   rom_696;
  wire       [15:0]   rom_697;
  wire       [15:0]   rom_698;
  wire       [15:0]   rom_699;
  wire       [15:0]   rom_700;
  wire       [15:0]   rom_701;
  wire       [15:0]   rom_702;
  wire       [15:0]   rom_703;
  wire       [15:0]   rom_704;
  wire       [15:0]   rom_705;
  wire       [15:0]   rom_706;
  wire       [15:0]   rom_707;
  wire       [15:0]   rom_708;
  wire       [15:0]   rom_709;
  wire       [15:0]   rom_710;
  wire       [15:0]   rom_711;
  wire       [15:0]   rom_712;
  wire       [15:0]   rom_713;
  wire       [15:0]   rom_714;
  wire       [15:0]   rom_715;
  wire       [15:0]   rom_716;
  wire       [15:0]   rom_717;
  wire       [15:0]   rom_718;
  wire       [15:0]   rom_719;
  wire       [15:0]   rom_720;
  wire       [15:0]   rom_721;
  wire       [15:0]   rom_722;
  wire       [15:0]   rom_723;
  wire       [15:0]   rom_724;
  wire       [15:0]   rom_725;
  wire       [15:0]   rom_726;
  wire       [15:0]   rom_727;
  wire       [15:0]   rom_728;
  wire       [15:0]   rom_729;
  wire       [15:0]   rom_730;
  wire       [15:0]   rom_731;
  wire       [15:0]   rom_732;
  wire       [15:0]   rom_733;
  wire       [15:0]   rom_734;
  wire       [15:0]   rom_735;
  wire       [15:0]   rom_736;
  wire       [15:0]   rom_737;
  wire       [15:0]   rom_738;
  wire       [15:0]   rom_739;
  wire       [15:0]   rom_740;
  wire       [15:0]   rom_741;
  wire       [15:0]   rom_742;
  wire       [15:0]   rom_743;
  wire       [15:0]   rom_744;
  wire       [15:0]   rom_745;
  wire       [15:0]   rom_746;
  wire       [15:0]   rom_747;
  wire       [15:0]   rom_748;
  wire       [15:0]   rom_749;
  wire       [15:0]   rom_750;
  wire       [15:0]   rom_751;
  wire       [15:0]   rom_752;
  wire       [15:0]   rom_753;
  wire       [15:0]   rom_754;
  wire       [15:0]   rom_755;
  wire       [15:0]   rom_756;
  wire       [15:0]   rom_757;
  wire       [15:0]   rom_758;
  wire       [15:0]   rom_759;
  wire       [15:0]   rom_760;
  wire       [15:0]   rom_761;
  wire       [15:0]   rom_762;
  wire       [15:0]   rom_763;
  wire       [15:0]   rom_764;
  wire       [15:0]   rom_765;
  wire       [15:0]   rom_766;
  wire       [15:0]   rom_767;
  wire       [15:0]   rom_768;
  wire       [15:0]   rom_769;
  wire       [15:0]   rom_770;
  wire       [15:0]   rom_771;
  wire       [15:0]   rom_772;
  wire       [15:0]   rom_773;
  wire       [15:0]   rom_774;
  wire       [15:0]   rom_775;
  wire       [15:0]   rom_776;
  wire       [15:0]   rom_777;
  wire       [15:0]   rom_778;
  wire       [15:0]   rom_779;
  wire       [15:0]   rom_780;
  wire       [15:0]   rom_781;
  wire       [15:0]   rom_782;
  wire       [15:0]   rom_783;
  wire       [15:0]   rom_784;
  wire       [15:0]   rom_785;
  wire       [15:0]   rom_786;
  wire       [15:0]   rom_787;
  wire       [15:0]   rom_788;
  wire       [15:0]   rom_789;
  wire       [15:0]   rom_790;
  wire       [15:0]   rom_791;
  wire       [15:0]   rom_792;
  wire       [15:0]   rom_793;
  wire       [15:0]   rom_794;
  wire       [15:0]   rom_795;
  wire       [15:0]   rom_796;
  wire       [15:0]   rom_797;
  wire       [15:0]   rom_798;
  wire       [15:0]   rom_799;
  wire       [15:0]   rom_800;
  wire       [15:0]   rom_801;
  wire       [15:0]   rom_802;
  wire       [15:0]   rom_803;
  wire       [15:0]   rom_804;
  wire       [15:0]   rom_805;
  wire       [15:0]   rom_806;
  wire       [15:0]   rom_807;
  wire       [15:0]   rom_808;
  wire       [15:0]   rom_809;
  wire       [15:0]   rom_810;
  wire       [15:0]   rom_811;
  wire       [15:0]   rom_812;
  wire       [15:0]   rom_813;
  wire       [15:0]   rom_814;
  wire       [15:0]   rom_815;
  wire       [15:0]   rom_816;
  wire       [15:0]   rom_817;
  wire       [15:0]   rom_818;
  wire       [15:0]   rom_819;
  wire       [15:0]   rom_820;
  wire       [15:0]   rom_821;
  wire       [15:0]   rom_822;
  wire       [15:0]   rom_823;
  wire       [15:0]   rom_824;
  wire       [15:0]   rom_825;
  wire       [15:0]   rom_826;
  wire       [15:0]   rom_827;
  wire       [15:0]   rom_828;
  wire       [15:0]   rom_829;
  wire       [15:0]   rom_830;
  wire       [15:0]   rom_831;
  wire       [15:0]   rom_832;
  wire       [15:0]   rom_833;
  wire       [15:0]   rom_834;
  wire       [15:0]   rom_835;
  wire       [15:0]   rom_836;
  wire       [15:0]   rom_837;
  wire       [15:0]   rom_838;
  wire       [15:0]   rom_839;
  wire       [15:0]   rom_840;
  wire       [15:0]   rom_841;
  wire       [15:0]   rom_842;
  wire       [15:0]   rom_843;
  wire       [15:0]   rom_844;
  wire       [15:0]   rom_845;
  wire       [15:0]   rom_846;
  wire       [15:0]   rom_847;
  wire       [15:0]   rom_848;
  wire       [15:0]   rom_849;
  wire       [15:0]   rom_850;
  wire       [15:0]   rom_851;
  wire       [15:0]   rom_852;
  wire       [15:0]   rom_853;
  wire       [15:0]   rom_854;
  wire       [15:0]   rom_855;
  wire       [15:0]   rom_856;
  wire       [15:0]   rom_857;
  wire       [15:0]   rom_858;
  wire       [15:0]   rom_859;
  wire       [15:0]   rom_860;
  wire       [15:0]   rom_861;
  wire       [15:0]   rom_862;
  wire       [15:0]   rom_863;
  wire       [15:0]   rom_864;
  wire       [15:0]   rom_865;
  wire       [15:0]   rom_866;
  wire       [15:0]   rom_867;
  wire       [15:0]   rom_868;
  wire       [15:0]   rom_869;
  wire       [15:0]   rom_870;
  wire       [15:0]   rom_871;
  wire       [15:0]   rom_872;
  wire       [15:0]   rom_873;
  wire       [15:0]   rom_874;
  wire       [15:0]   rom_875;
  wire       [15:0]   rom_876;
  wire       [15:0]   rom_877;
  wire       [15:0]   rom_878;
  wire       [15:0]   rom_879;
  wire       [15:0]   rom_880;
  wire       [15:0]   rom_881;
  wire       [15:0]   rom_882;
  wire       [15:0]   rom_883;
  wire       [15:0]   rom_884;
  wire       [15:0]   rom_885;
  wire       [15:0]   rom_886;
  wire       [15:0]   rom_887;
  wire       [15:0]   rom_888;
  wire       [15:0]   rom_889;
  wire       [15:0]   rom_890;
  wire       [15:0]   rom_891;
  wire       [15:0]   rom_892;
  wire       [15:0]   rom_893;
  wire       [15:0]   rom_894;
  wire       [15:0]   rom_895;
  wire       [15:0]   rom_896;
  wire       [15:0]   rom_897;
  wire       [15:0]   rom_898;
  wire       [15:0]   rom_899;
  wire       [15:0]   rom_900;
  wire       [15:0]   rom_901;
  wire       [15:0]   rom_902;
  wire       [15:0]   rom_903;
  wire       [15:0]   rom_904;
  wire       [15:0]   rom_905;
  wire       [15:0]   rom_906;
  wire       [15:0]   rom_907;
  wire       [15:0]   rom_908;
  wire       [15:0]   rom_909;
  wire       [15:0]   rom_910;
  wire       [15:0]   rom_911;
  wire       [15:0]   rom_912;
  wire       [15:0]   rom_913;
  wire       [15:0]   rom_914;
  wire       [15:0]   rom_915;
  wire       [15:0]   rom_916;
  wire       [15:0]   rom_917;
  wire       [15:0]   rom_918;
  wire       [15:0]   rom_919;
  wire       [15:0]   rom_920;
  wire       [15:0]   rom_921;
  wire       [15:0]   rom_922;
  wire       [15:0]   rom_923;
  wire       [15:0]   rom_924;
  wire       [15:0]   rom_925;
  wire       [15:0]   rom_926;
  wire       [15:0]   rom_927;
  wire       [15:0]   rom_928;
  wire       [15:0]   rom_929;
  wire       [15:0]   rom_930;
  wire       [15:0]   rom_931;
  wire       [15:0]   rom_932;
  wire       [15:0]   rom_933;
  wire       [15:0]   rom_934;
  wire       [15:0]   rom_935;
  wire       [15:0]   rom_936;
  wire       [15:0]   rom_937;
  wire       [15:0]   rom_938;
  wire       [15:0]   rom_939;
  wire       [15:0]   rom_940;
  wire       [15:0]   rom_941;
  wire       [15:0]   rom_942;
  wire       [15:0]   rom_943;
  wire       [15:0]   rom_944;
  wire       [15:0]   rom_945;
  wire       [15:0]   rom_946;
  wire       [15:0]   rom_947;
  wire       [15:0]   rom_948;
  wire       [15:0]   rom_949;
  wire       [15:0]   rom_950;
  wire       [15:0]   rom_951;
  wire       [15:0]   rom_952;
  wire       [15:0]   rom_953;
  wire       [15:0]   rom_954;
  wire       [15:0]   rom_955;
  wire       [15:0]   rom_956;
  wire       [15:0]   rom_957;
  wire       [15:0]   rom_958;
  wire       [15:0]   rom_959;
  wire       [15:0]   rom_960;
  wire       [15:0]   rom_961;
  wire       [15:0]   rom_962;
  wire       [15:0]   rom_963;
  wire       [15:0]   rom_964;
  wire       [15:0]   rom_965;
  wire       [15:0]   rom_966;
  wire       [15:0]   rom_967;
  wire       [15:0]   rom_968;
  wire       [15:0]   rom_969;
  wire       [15:0]   rom_970;
  wire       [15:0]   rom_971;
  wire       [15:0]   rom_972;
  wire       [15:0]   rom_973;
  wire       [15:0]   rom_974;
  wire       [15:0]   rom_975;
  wire       [15:0]   rom_976;
  wire       [15:0]   rom_977;
  wire       [15:0]   rom_978;
  wire       [15:0]   rom_979;
  wire       [15:0]   rom_980;
  wire       [15:0]   rom_981;
  wire       [15:0]   rom_982;
  wire       [15:0]   rom_983;
  wire       [15:0]   rom_984;
  wire       [15:0]   rom_985;
  wire       [15:0]   rom_986;
  wire       [15:0]   rom_987;
  wire       [15:0]   rom_988;
  wire       [15:0]   rom_989;
  wire       [15:0]   rom_990;
  wire       [15:0]   rom_991;
  wire       [15:0]   rom_992;
  wire       [15:0]   rom_993;
  wire       [15:0]   rom_994;
  wire       [15:0]   rom_995;
  wire       [15:0]   rom_996;
  wire       [15:0]   rom_997;
  wire       [15:0]   rom_998;
  wire       [15:0]   rom_999;
  wire       [15:0]   rom_1000;
  wire       [15:0]   rom_1001;
  wire       [15:0]   rom_1002;
  wire       [15:0]   rom_1003;
  wire       [15:0]   rom_1004;
  wire       [15:0]   rom_1005;
  wire       [15:0]   rom_1006;
  wire       [15:0]   rom_1007;
  wire       [15:0]   rom_1008;
  wire       [15:0]   rom_1009;
  wire       [15:0]   rom_1010;
  wire       [15:0]   rom_1011;
  wire       [15:0]   rom_1012;
  wire       [15:0]   rom_1013;
  wire       [15:0]   rom_1014;
  wire       [15:0]   rom_1015;
  wire       [15:0]   rom_1016;
  wire       [15:0]   rom_1017;
  wire       [15:0]   rom_1018;
  wire       [15:0]   rom_1019;
  wire       [15:0]   rom_1020;
  wire       [15:0]   rom_1021;
  wire       [15:0]   rom_1022;
  wire       [15:0]   rom_1023;
  wire       [15:0]   rom_1024;
  wire       [15:0]   rom_1025;
  wire       [15:0]   rom_1026;
  wire       [15:0]   rom_1027;
  wire       [15:0]   rom_1028;
  wire       [15:0]   rom_1029;
  wire       [15:0]   rom_1030;
  wire       [15:0]   rom_1031;
  wire       [15:0]   rom_1032;
  wire       [15:0]   rom_1033;
  wire       [15:0]   rom_1034;
  wire       [15:0]   rom_1035;
  wire       [15:0]   rom_1036;
  wire       [15:0]   rom_1037;
  wire       [15:0]   rom_1038;
  wire       [15:0]   rom_1039;
  wire       [15:0]   rom_1040;
  wire       [15:0]   rom_1041;
  wire       [15:0]   rom_1042;
  wire       [15:0]   rom_1043;
  wire       [15:0]   rom_1044;
  wire       [15:0]   rom_1045;
  wire       [15:0]   rom_1046;
  wire       [15:0]   rom_1047;
  wire       [15:0]   rom_1048;
  wire       [15:0]   rom_1049;
  wire       [15:0]   rom_1050;
  wire       [15:0]   rom_1051;
  wire       [15:0]   rom_1052;
  wire       [15:0]   rom_1053;
  wire       [15:0]   rom_1054;
  wire       [15:0]   rom_1055;
  wire       [15:0]   rom_1056;
  wire       [15:0]   rom_1057;
  wire       [15:0]   rom_1058;
  wire       [15:0]   rom_1059;
  wire       [15:0]   rom_1060;
  wire       [15:0]   rom_1061;
  wire       [15:0]   rom_1062;
  wire       [15:0]   rom_1063;
  wire       [15:0]   rom_1064;
  wire       [15:0]   rom_1065;
  wire       [15:0]   rom_1066;
  wire       [15:0]   rom_1067;
  wire       [15:0]   rom_1068;
  wire       [15:0]   rom_1069;
  wire       [15:0]   rom_1070;
  wire       [15:0]   rom_1071;
  wire       [15:0]   rom_1072;
  wire       [15:0]   rom_1073;
  wire       [15:0]   rom_1074;
  wire       [15:0]   rom_1075;
  wire       [15:0]   rom_1076;
  wire       [15:0]   rom_1077;
  wire       [15:0]   rom_1078;
  wire       [15:0]   rom_1079;
  wire       [15:0]   rom_1080;
  wire       [15:0]   rom_1081;
  wire       [15:0]   rom_1082;
  wire       [15:0]   rom_1083;
  wire       [15:0]   rom_1084;
  wire       [15:0]   rom_1085;
  wire       [15:0]   rom_1086;
  wire       [15:0]   rom_1087;
  wire       [15:0]   rom_1088;
  wire       [15:0]   rom_1089;
  wire       [15:0]   rom_1090;
  wire       [15:0]   rom_1091;
  wire       [15:0]   rom_1092;
  wire       [15:0]   rom_1093;
  wire       [15:0]   rom_1094;
  wire       [15:0]   rom_1095;
  wire       [15:0]   rom_1096;
  wire       [15:0]   rom_1097;
  wire       [15:0]   rom_1098;
  wire       [15:0]   rom_1099;
  wire       [15:0]   rom_1100;
  wire       [15:0]   rom_1101;
  wire       [15:0]   rom_1102;
  wire       [15:0]   rom_1103;
  wire       [15:0]   rom_1104;
  wire       [15:0]   rom_1105;
  wire       [15:0]   rom_1106;
  wire       [15:0]   rom_1107;
  wire       [15:0]   rom_1108;
  wire       [15:0]   rom_1109;
  wire       [15:0]   rom_1110;
  wire       [15:0]   rom_1111;
  wire       [15:0]   rom_1112;
  wire       [15:0]   rom_1113;
  wire       [15:0]   rom_1114;
  wire       [15:0]   rom_1115;
  wire       [15:0]   rom_1116;
  wire       [15:0]   rom_1117;
  wire       [15:0]   rom_1118;
  wire       [15:0]   rom_1119;
  wire       [15:0]   rom_1120;
  wire       [15:0]   rom_1121;
  wire       [15:0]   rom_1122;
  wire       [15:0]   rom_1123;
  wire       [15:0]   rom_1124;
  wire       [15:0]   rom_1125;
  wire       [15:0]   rom_1126;
  wire       [15:0]   rom_1127;
  wire       [15:0]   rom_1128;
  wire       [15:0]   rom_1129;
  wire       [15:0]   rom_1130;
  wire       [15:0]   rom_1131;
  wire       [15:0]   rom_1132;
  wire       [15:0]   rom_1133;
  wire       [15:0]   rom_1134;
  wire       [15:0]   rom_1135;
  wire       [15:0]   rom_1136;
  wire       [15:0]   rom_1137;
  wire       [15:0]   rom_1138;
  wire       [15:0]   rom_1139;
  wire       [15:0]   rom_1140;
  wire       [15:0]   rom_1141;
  wire       [15:0]   rom_1142;
  wire       [15:0]   rom_1143;
  wire       [15:0]   rom_1144;
  wire       [15:0]   rom_1145;
  wire       [15:0]   rom_1146;
  wire       [15:0]   rom_1147;
  wire       [15:0]   rom_1148;
  wire       [15:0]   rom_1149;
  wire       [15:0]   rom_1150;
  wire       [15:0]   rom_1151;
  wire       [15:0]   rom_1152;
  wire       [15:0]   rom_1153;
  wire       [15:0]   rom_1154;
  wire       [15:0]   rom_1155;
  wire       [15:0]   rom_1156;
  wire       [15:0]   rom_1157;
  wire       [15:0]   rom_1158;
  wire       [15:0]   rom_1159;
  wire       [15:0]   rom_1160;
  wire       [15:0]   rom_1161;
  wire       [15:0]   rom_1162;
  wire       [15:0]   rom_1163;
  wire       [15:0]   rom_1164;
  wire       [15:0]   rom_1165;
  wire       [15:0]   rom_1166;
  wire       [15:0]   rom_1167;
  wire       [15:0]   rom_1168;
  wire       [15:0]   rom_1169;
  wire       [15:0]   rom_1170;
  wire       [15:0]   rom_1171;
  wire       [15:0]   rom_1172;
  wire       [15:0]   rom_1173;
  wire       [15:0]   rom_1174;
  wire       [15:0]   rom_1175;
  wire       [15:0]   rom_1176;
  wire       [15:0]   rom_1177;
  wire       [15:0]   rom_1178;
  wire       [15:0]   rom_1179;
  wire       [15:0]   rom_1180;
  wire       [15:0]   rom_1181;
  wire       [15:0]   rom_1182;
  wire       [15:0]   rom_1183;
  wire       [15:0]   rom_1184;
  wire       [15:0]   rom_1185;
  wire       [15:0]   rom_1186;
  wire       [15:0]   rom_1187;
  wire       [15:0]   rom_1188;
  wire       [15:0]   rom_1189;
  wire       [15:0]   rom_1190;
  wire       [15:0]   rom_1191;
  wire       [15:0]   rom_1192;
  wire       [15:0]   rom_1193;
  wire       [15:0]   rom_1194;
  wire       [15:0]   rom_1195;
  wire       [15:0]   rom_1196;
  wire       [15:0]   rom_1197;
  wire       [15:0]   rom_1198;
  wire       [15:0]   rom_1199;
  wire       [15:0]   rom_1200;
  wire       [15:0]   rom_1201;
  wire       [15:0]   rom_1202;
  wire       [15:0]   rom_1203;
  wire       [15:0]   rom_1204;
  wire       [15:0]   rom_1205;
  wire       [15:0]   rom_1206;
  wire       [15:0]   rom_1207;
  wire       [15:0]   rom_1208;
  wire       [15:0]   rom_1209;
  wire       [15:0]   rom_1210;
  wire       [15:0]   rom_1211;
  wire       [15:0]   rom_1212;
  wire       [15:0]   rom_1213;
  wire       [15:0]   rom_1214;
  wire       [15:0]   rom_1215;
  wire       [15:0]   rom_1216;
  wire       [15:0]   rom_1217;
  wire       [15:0]   rom_1218;
  wire       [15:0]   rom_1219;
  wire       [15:0]   rom_1220;
  wire       [15:0]   rom_1221;
  wire       [15:0]   rom_1222;
  wire       [15:0]   rom_1223;
  wire       [15:0]   rom_1224;
  wire       [15:0]   rom_1225;
  wire       [15:0]   rom_1226;
  wire       [15:0]   rom_1227;
  wire       [15:0]   rom_1228;
  wire       [15:0]   rom_1229;
  wire       [15:0]   rom_1230;
  wire       [15:0]   rom_1231;
  wire       [15:0]   rom_1232;
  wire       [15:0]   rom_1233;
  wire       [15:0]   rom_1234;
  wire       [15:0]   rom_1235;
  wire       [15:0]   rom_1236;
  wire       [15:0]   rom_1237;
  wire       [15:0]   rom_1238;
  wire       [15:0]   rom_1239;
  wire       [15:0]   rom_1240;
  wire       [15:0]   rom_1241;
  wire       [15:0]   rom_1242;
  wire       [15:0]   rom_1243;
  wire       [15:0]   rom_1244;
  wire       [15:0]   rom_1245;
  reg        [15:0]   rd_data_reg;

  always @(*) begin
    case(io_irom_if_mem_addr)
      11'b00000000000 : tmp_rd_data_reg = rom_0;
      11'b00000000001 : tmp_rd_data_reg = rom_1;
      11'b00000000010 : tmp_rd_data_reg = rom_2;
      11'b00000000011 : tmp_rd_data_reg = rom_3;
      11'b00000000100 : tmp_rd_data_reg = rom_4;
      11'b00000000101 : tmp_rd_data_reg = rom_5;
      11'b00000000110 : tmp_rd_data_reg = rom_6;
      11'b00000000111 : tmp_rd_data_reg = rom_7;
      11'b00000001000 : tmp_rd_data_reg = rom_8;
      11'b00000001001 : tmp_rd_data_reg = rom_9;
      11'b00000001010 : tmp_rd_data_reg = rom_10;
      11'b00000001011 : tmp_rd_data_reg = rom_11;
      11'b00000001100 : tmp_rd_data_reg = rom_12;
      11'b00000001101 : tmp_rd_data_reg = rom_13;
      11'b00000001110 : tmp_rd_data_reg = rom_14;
      11'b00000001111 : tmp_rd_data_reg = rom_15;
      11'b00000010000 : tmp_rd_data_reg = rom_16;
      11'b00000010001 : tmp_rd_data_reg = rom_17;
      11'b00000010010 : tmp_rd_data_reg = rom_18;
      11'b00000010011 : tmp_rd_data_reg = rom_19;
      11'b00000010100 : tmp_rd_data_reg = rom_20;
      11'b00000010101 : tmp_rd_data_reg = rom_21;
      11'b00000010110 : tmp_rd_data_reg = rom_22;
      11'b00000010111 : tmp_rd_data_reg = rom_23;
      11'b00000011000 : tmp_rd_data_reg = rom_24;
      11'b00000011001 : tmp_rd_data_reg = rom_25;
      11'b00000011010 : tmp_rd_data_reg = rom_26;
      11'b00000011011 : tmp_rd_data_reg = rom_27;
      11'b00000011100 : tmp_rd_data_reg = rom_28;
      11'b00000011101 : tmp_rd_data_reg = rom_29;
      11'b00000011110 : tmp_rd_data_reg = rom_30;
      11'b00000011111 : tmp_rd_data_reg = rom_31;
      11'b00000100000 : tmp_rd_data_reg = rom_32;
      11'b00000100001 : tmp_rd_data_reg = rom_33;
      11'b00000100010 : tmp_rd_data_reg = rom_34;
      11'b00000100011 : tmp_rd_data_reg = rom_35;
      11'b00000100100 : tmp_rd_data_reg = rom_36;
      11'b00000100101 : tmp_rd_data_reg = rom_37;
      11'b00000100110 : tmp_rd_data_reg = rom_38;
      11'b00000100111 : tmp_rd_data_reg = rom_39;
      11'b00000101000 : tmp_rd_data_reg = rom_40;
      11'b00000101001 : tmp_rd_data_reg = rom_41;
      11'b00000101010 : tmp_rd_data_reg = rom_42;
      11'b00000101011 : tmp_rd_data_reg = rom_43;
      11'b00000101100 : tmp_rd_data_reg = rom_44;
      11'b00000101101 : tmp_rd_data_reg = rom_45;
      11'b00000101110 : tmp_rd_data_reg = rom_46;
      11'b00000101111 : tmp_rd_data_reg = rom_47;
      11'b00000110000 : tmp_rd_data_reg = rom_48;
      11'b00000110001 : tmp_rd_data_reg = rom_49;
      11'b00000110010 : tmp_rd_data_reg = rom_50;
      11'b00000110011 : tmp_rd_data_reg = rom_51;
      11'b00000110100 : tmp_rd_data_reg = rom_52;
      11'b00000110101 : tmp_rd_data_reg = rom_53;
      11'b00000110110 : tmp_rd_data_reg = rom_54;
      11'b00000110111 : tmp_rd_data_reg = rom_55;
      11'b00000111000 : tmp_rd_data_reg = rom_56;
      11'b00000111001 : tmp_rd_data_reg = rom_57;
      11'b00000111010 : tmp_rd_data_reg = rom_58;
      11'b00000111011 : tmp_rd_data_reg = rom_59;
      11'b00000111100 : tmp_rd_data_reg = rom_60;
      11'b00000111101 : tmp_rd_data_reg = rom_61;
      11'b00000111110 : tmp_rd_data_reg = rom_62;
      11'b00000111111 : tmp_rd_data_reg = rom_63;
      11'b00001000000 : tmp_rd_data_reg = rom_64;
      11'b00001000001 : tmp_rd_data_reg = rom_65;
      11'b00001000010 : tmp_rd_data_reg = rom_66;
      11'b00001000011 : tmp_rd_data_reg = rom_67;
      11'b00001000100 : tmp_rd_data_reg = rom_68;
      11'b00001000101 : tmp_rd_data_reg = rom_69;
      11'b00001000110 : tmp_rd_data_reg = rom_70;
      11'b00001000111 : tmp_rd_data_reg = rom_71;
      11'b00001001000 : tmp_rd_data_reg = rom_72;
      11'b00001001001 : tmp_rd_data_reg = rom_73;
      11'b00001001010 : tmp_rd_data_reg = rom_74;
      11'b00001001011 : tmp_rd_data_reg = rom_75;
      11'b00001001100 : tmp_rd_data_reg = rom_76;
      11'b00001001101 : tmp_rd_data_reg = rom_77;
      11'b00001001110 : tmp_rd_data_reg = rom_78;
      11'b00001001111 : tmp_rd_data_reg = rom_79;
      11'b00001010000 : tmp_rd_data_reg = rom_80;
      11'b00001010001 : tmp_rd_data_reg = rom_81;
      11'b00001010010 : tmp_rd_data_reg = rom_82;
      11'b00001010011 : tmp_rd_data_reg = rom_83;
      11'b00001010100 : tmp_rd_data_reg = rom_84;
      11'b00001010101 : tmp_rd_data_reg = rom_85;
      11'b00001010110 : tmp_rd_data_reg = rom_86;
      11'b00001010111 : tmp_rd_data_reg = rom_87;
      11'b00001011000 : tmp_rd_data_reg = rom_88;
      11'b00001011001 : tmp_rd_data_reg = rom_89;
      11'b00001011010 : tmp_rd_data_reg = rom_90;
      11'b00001011011 : tmp_rd_data_reg = rom_91;
      11'b00001011100 : tmp_rd_data_reg = rom_92;
      11'b00001011101 : tmp_rd_data_reg = rom_93;
      11'b00001011110 : tmp_rd_data_reg = rom_94;
      11'b00001011111 : tmp_rd_data_reg = rom_95;
      11'b00001100000 : tmp_rd_data_reg = rom_96;
      11'b00001100001 : tmp_rd_data_reg = rom_97;
      11'b00001100010 : tmp_rd_data_reg = rom_98;
      11'b00001100011 : tmp_rd_data_reg = rom_99;
      11'b00001100100 : tmp_rd_data_reg = rom_100;
      11'b00001100101 : tmp_rd_data_reg = rom_101;
      11'b00001100110 : tmp_rd_data_reg = rom_102;
      11'b00001100111 : tmp_rd_data_reg = rom_103;
      11'b00001101000 : tmp_rd_data_reg = rom_104;
      11'b00001101001 : tmp_rd_data_reg = rom_105;
      11'b00001101010 : tmp_rd_data_reg = rom_106;
      11'b00001101011 : tmp_rd_data_reg = rom_107;
      11'b00001101100 : tmp_rd_data_reg = rom_108;
      11'b00001101101 : tmp_rd_data_reg = rom_109;
      11'b00001101110 : tmp_rd_data_reg = rom_110;
      11'b00001101111 : tmp_rd_data_reg = rom_111;
      11'b00001110000 : tmp_rd_data_reg = rom_112;
      11'b00001110001 : tmp_rd_data_reg = rom_113;
      11'b00001110010 : tmp_rd_data_reg = rom_114;
      11'b00001110011 : tmp_rd_data_reg = rom_115;
      11'b00001110100 : tmp_rd_data_reg = rom_116;
      11'b00001110101 : tmp_rd_data_reg = rom_117;
      11'b00001110110 : tmp_rd_data_reg = rom_118;
      11'b00001110111 : tmp_rd_data_reg = rom_119;
      11'b00001111000 : tmp_rd_data_reg = rom_120;
      11'b00001111001 : tmp_rd_data_reg = rom_121;
      11'b00001111010 : tmp_rd_data_reg = rom_122;
      11'b00001111011 : tmp_rd_data_reg = rom_123;
      11'b00001111100 : tmp_rd_data_reg = rom_124;
      11'b00001111101 : tmp_rd_data_reg = rom_125;
      11'b00001111110 : tmp_rd_data_reg = rom_126;
      11'b00001111111 : tmp_rd_data_reg = rom_127;
      11'b00010000000 : tmp_rd_data_reg = rom_128;
      11'b00010000001 : tmp_rd_data_reg = rom_129;
      11'b00010000010 : tmp_rd_data_reg = rom_130;
      11'b00010000011 : tmp_rd_data_reg = rom_131;
      11'b00010000100 : tmp_rd_data_reg = rom_132;
      11'b00010000101 : tmp_rd_data_reg = rom_133;
      11'b00010000110 : tmp_rd_data_reg = rom_134;
      11'b00010000111 : tmp_rd_data_reg = rom_135;
      11'b00010001000 : tmp_rd_data_reg = rom_136;
      11'b00010001001 : tmp_rd_data_reg = rom_137;
      11'b00010001010 : tmp_rd_data_reg = rom_138;
      11'b00010001011 : tmp_rd_data_reg = rom_139;
      11'b00010001100 : tmp_rd_data_reg = rom_140;
      11'b00010001101 : tmp_rd_data_reg = rom_141;
      11'b00010001110 : tmp_rd_data_reg = rom_142;
      11'b00010001111 : tmp_rd_data_reg = rom_143;
      11'b00010010000 : tmp_rd_data_reg = rom_144;
      11'b00010010001 : tmp_rd_data_reg = rom_145;
      11'b00010010010 : tmp_rd_data_reg = rom_146;
      11'b00010010011 : tmp_rd_data_reg = rom_147;
      11'b00010010100 : tmp_rd_data_reg = rom_148;
      11'b00010010101 : tmp_rd_data_reg = rom_149;
      11'b00010010110 : tmp_rd_data_reg = rom_150;
      11'b00010010111 : tmp_rd_data_reg = rom_151;
      11'b00010011000 : tmp_rd_data_reg = rom_152;
      11'b00010011001 : tmp_rd_data_reg = rom_153;
      11'b00010011010 : tmp_rd_data_reg = rom_154;
      11'b00010011011 : tmp_rd_data_reg = rom_155;
      11'b00010011100 : tmp_rd_data_reg = rom_156;
      11'b00010011101 : tmp_rd_data_reg = rom_157;
      11'b00010011110 : tmp_rd_data_reg = rom_158;
      11'b00010011111 : tmp_rd_data_reg = rom_159;
      11'b00010100000 : tmp_rd_data_reg = rom_160;
      11'b00010100001 : tmp_rd_data_reg = rom_161;
      11'b00010100010 : tmp_rd_data_reg = rom_162;
      11'b00010100011 : tmp_rd_data_reg = rom_163;
      11'b00010100100 : tmp_rd_data_reg = rom_164;
      11'b00010100101 : tmp_rd_data_reg = rom_165;
      11'b00010100110 : tmp_rd_data_reg = rom_166;
      11'b00010100111 : tmp_rd_data_reg = rom_167;
      11'b00010101000 : tmp_rd_data_reg = rom_168;
      11'b00010101001 : tmp_rd_data_reg = rom_169;
      11'b00010101010 : tmp_rd_data_reg = rom_170;
      11'b00010101011 : tmp_rd_data_reg = rom_171;
      11'b00010101100 : tmp_rd_data_reg = rom_172;
      11'b00010101101 : tmp_rd_data_reg = rom_173;
      11'b00010101110 : tmp_rd_data_reg = rom_174;
      11'b00010101111 : tmp_rd_data_reg = rom_175;
      11'b00010110000 : tmp_rd_data_reg = rom_176;
      11'b00010110001 : tmp_rd_data_reg = rom_177;
      11'b00010110010 : tmp_rd_data_reg = rom_178;
      11'b00010110011 : tmp_rd_data_reg = rom_179;
      11'b00010110100 : tmp_rd_data_reg = rom_180;
      11'b00010110101 : tmp_rd_data_reg = rom_181;
      11'b00010110110 : tmp_rd_data_reg = rom_182;
      11'b00010110111 : tmp_rd_data_reg = rom_183;
      11'b00010111000 : tmp_rd_data_reg = rom_184;
      11'b00010111001 : tmp_rd_data_reg = rom_185;
      11'b00010111010 : tmp_rd_data_reg = rom_186;
      11'b00010111011 : tmp_rd_data_reg = rom_187;
      11'b00010111100 : tmp_rd_data_reg = rom_188;
      11'b00010111101 : tmp_rd_data_reg = rom_189;
      11'b00010111110 : tmp_rd_data_reg = rom_190;
      11'b00010111111 : tmp_rd_data_reg = rom_191;
      11'b00011000000 : tmp_rd_data_reg = rom_192;
      11'b00011000001 : tmp_rd_data_reg = rom_193;
      11'b00011000010 : tmp_rd_data_reg = rom_194;
      11'b00011000011 : tmp_rd_data_reg = rom_195;
      11'b00011000100 : tmp_rd_data_reg = rom_196;
      11'b00011000101 : tmp_rd_data_reg = rom_197;
      11'b00011000110 : tmp_rd_data_reg = rom_198;
      11'b00011000111 : tmp_rd_data_reg = rom_199;
      11'b00011001000 : tmp_rd_data_reg = rom_200;
      11'b00011001001 : tmp_rd_data_reg = rom_201;
      11'b00011001010 : tmp_rd_data_reg = rom_202;
      11'b00011001011 : tmp_rd_data_reg = rom_203;
      11'b00011001100 : tmp_rd_data_reg = rom_204;
      11'b00011001101 : tmp_rd_data_reg = rom_205;
      11'b00011001110 : tmp_rd_data_reg = rom_206;
      11'b00011001111 : tmp_rd_data_reg = rom_207;
      11'b00011010000 : tmp_rd_data_reg = rom_208;
      11'b00011010001 : tmp_rd_data_reg = rom_209;
      11'b00011010010 : tmp_rd_data_reg = rom_210;
      11'b00011010011 : tmp_rd_data_reg = rom_211;
      11'b00011010100 : tmp_rd_data_reg = rom_212;
      11'b00011010101 : tmp_rd_data_reg = rom_213;
      11'b00011010110 : tmp_rd_data_reg = rom_214;
      11'b00011010111 : tmp_rd_data_reg = rom_215;
      11'b00011011000 : tmp_rd_data_reg = rom_216;
      11'b00011011001 : tmp_rd_data_reg = rom_217;
      11'b00011011010 : tmp_rd_data_reg = rom_218;
      11'b00011011011 : tmp_rd_data_reg = rom_219;
      11'b00011011100 : tmp_rd_data_reg = rom_220;
      11'b00011011101 : tmp_rd_data_reg = rom_221;
      11'b00011011110 : tmp_rd_data_reg = rom_222;
      11'b00011011111 : tmp_rd_data_reg = rom_223;
      11'b00011100000 : tmp_rd_data_reg = rom_224;
      11'b00011100001 : tmp_rd_data_reg = rom_225;
      11'b00011100010 : tmp_rd_data_reg = rom_226;
      11'b00011100011 : tmp_rd_data_reg = rom_227;
      11'b00011100100 : tmp_rd_data_reg = rom_228;
      11'b00011100101 : tmp_rd_data_reg = rom_229;
      11'b00011100110 : tmp_rd_data_reg = rom_230;
      11'b00011100111 : tmp_rd_data_reg = rom_231;
      11'b00011101000 : tmp_rd_data_reg = rom_232;
      11'b00011101001 : tmp_rd_data_reg = rom_233;
      11'b00011101010 : tmp_rd_data_reg = rom_234;
      11'b00011101011 : tmp_rd_data_reg = rom_235;
      11'b00011101100 : tmp_rd_data_reg = rom_236;
      11'b00011101101 : tmp_rd_data_reg = rom_237;
      11'b00011101110 : tmp_rd_data_reg = rom_238;
      11'b00011101111 : tmp_rd_data_reg = rom_239;
      11'b00011110000 : tmp_rd_data_reg = rom_240;
      11'b00011110001 : tmp_rd_data_reg = rom_241;
      11'b00011110010 : tmp_rd_data_reg = rom_242;
      11'b00011110011 : tmp_rd_data_reg = rom_243;
      11'b00011110100 : tmp_rd_data_reg = rom_244;
      11'b00011110101 : tmp_rd_data_reg = rom_245;
      11'b00011110110 : tmp_rd_data_reg = rom_246;
      11'b00011110111 : tmp_rd_data_reg = rom_247;
      11'b00011111000 : tmp_rd_data_reg = rom_248;
      11'b00011111001 : tmp_rd_data_reg = rom_249;
      11'b00011111010 : tmp_rd_data_reg = rom_250;
      11'b00011111011 : tmp_rd_data_reg = rom_251;
      11'b00011111100 : tmp_rd_data_reg = rom_252;
      11'b00011111101 : tmp_rd_data_reg = rom_253;
      11'b00011111110 : tmp_rd_data_reg = rom_254;
      11'b00011111111 : tmp_rd_data_reg = rom_255;
      11'b00100000000 : tmp_rd_data_reg = rom_256;
      11'b00100000001 : tmp_rd_data_reg = rom_257;
      11'b00100000010 : tmp_rd_data_reg = rom_258;
      11'b00100000011 : tmp_rd_data_reg = rom_259;
      11'b00100000100 : tmp_rd_data_reg = rom_260;
      11'b00100000101 : tmp_rd_data_reg = rom_261;
      11'b00100000110 : tmp_rd_data_reg = rom_262;
      11'b00100000111 : tmp_rd_data_reg = rom_263;
      11'b00100001000 : tmp_rd_data_reg = rom_264;
      11'b00100001001 : tmp_rd_data_reg = rom_265;
      11'b00100001010 : tmp_rd_data_reg = rom_266;
      11'b00100001011 : tmp_rd_data_reg = rom_267;
      11'b00100001100 : tmp_rd_data_reg = rom_268;
      11'b00100001101 : tmp_rd_data_reg = rom_269;
      11'b00100001110 : tmp_rd_data_reg = rom_270;
      11'b00100001111 : tmp_rd_data_reg = rom_271;
      11'b00100010000 : tmp_rd_data_reg = rom_272;
      11'b00100010001 : tmp_rd_data_reg = rom_273;
      11'b00100010010 : tmp_rd_data_reg = rom_274;
      11'b00100010011 : tmp_rd_data_reg = rom_275;
      11'b00100010100 : tmp_rd_data_reg = rom_276;
      11'b00100010101 : tmp_rd_data_reg = rom_277;
      11'b00100010110 : tmp_rd_data_reg = rom_278;
      11'b00100010111 : tmp_rd_data_reg = rom_279;
      11'b00100011000 : tmp_rd_data_reg = rom_280;
      11'b00100011001 : tmp_rd_data_reg = rom_281;
      11'b00100011010 : tmp_rd_data_reg = rom_282;
      11'b00100011011 : tmp_rd_data_reg = rom_283;
      11'b00100011100 : tmp_rd_data_reg = rom_284;
      11'b00100011101 : tmp_rd_data_reg = rom_285;
      11'b00100011110 : tmp_rd_data_reg = rom_286;
      11'b00100011111 : tmp_rd_data_reg = rom_287;
      11'b00100100000 : tmp_rd_data_reg = rom_288;
      11'b00100100001 : tmp_rd_data_reg = rom_289;
      11'b00100100010 : tmp_rd_data_reg = rom_290;
      11'b00100100011 : tmp_rd_data_reg = rom_291;
      11'b00100100100 : tmp_rd_data_reg = rom_292;
      11'b00100100101 : tmp_rd_data_reg = rom_293;
      11'b00100100110 : tmp_rd_data_reg = rom_294;
      11'b00100100111 : tmp_rd_data_reg = rom_295;
      11'b00100101000 : tmp_rd_data_reg = rom_296;
      11'b00100101001 : tmp_rd_data_reg = rom_297;
      11'b00100101010 : tmp_rd_data_reg = rom_298;
      11'b00100101011 : tmp_rd_data_reg = rom_299;
      11'b00100101100 : tmp_rd_data_reg = rom_300;
      11'b00100101101 : tmp_rd_data_reg = rom_301;
      11'b00100101110 : tmp_rd_data_reg = rom_302;
      11'b00100101111 : tmp_rd_data_reg = rom_303;
      11'b00100110000 : tmp_rd_data_reg = rom_304;
      11'b00100110001 : tmp_rd_data_reg = rom_305;
      11'b00100110010 : tmp_rd_data_reg = rom_306;
      11'b00100110011 : tmp_rd_data_reg = rom_307;
      11'b00100110100 : tmp_rd_data_reg = rom_308;
      11'b00100110101 : tmp_rd_data_reg = rom_309;
      11'b00100110110 : tmp_rd_data_reg = rom_310;
      11'b00100110111 : tmp_rd_data_reg = rom_311;
      11'b00100111000 : tmp_rd_data_reg = rom_312;
      11'b00100111001 : tmp_rd_data_reg = rom_313;
      11'b00100111010 : tmp_rd_data_reg = rom_314;
      11'b00100111011 : tmp_rd_data_reg = rom_315;
      11'b00100111100 : tmp_rd_data_reg = rom_316;
      11'b00100111101 : tmp_rd_data_reg = rom_317;
      11'b00100111110 : tmp_rd_data_reg = rom_318;
      11'b00100111111 : tmp_rd_data_reg = rom_319;
      11'b00101000000 : tmp_rd_data_reg = rom_320;
      11'b00101000001 : tmp_rd_data_reg = rom_321;
      11'b00101000010 : tmp_rd_data_reg = rom_322;
      11'b00101000011 : tmp_rd_data_reg = rom_323;
      11'b00101000100 : tmp_rd_data_reg = rom_324;
      11'b00101000101 : tmp_rd_data_reg = rom_325;
      11'b00101000110 : tmp_rd_data_reg = rom_326;
      11'b00101000111 : tmp_rd_data_reg = rom_327;
      11'b00101001000 : tmp_rd_data_reg = rom_328;
      11'b00101001001 : tmp_rd_data_reg = rom_329;
      11'b00101001010 : tmp_rd_data_reg = rom_330;
      11'b00101001011 : tmp_rd_data_reg = rom_331;
      11'b00101001100 : tmp_rd_data_reg = rom_332;
      11'b00101001101 : tmp_rd_data_reg = rom_333;
      11'b00101001110 : tmp_rd_data_reg = rom_334;
      11'b00101001111 : tmp_rd_data_reg = rom_335;
      11'b00101010000 : tmp_rd_data_reg = rom_336;
      11'b00101010001 : tmp_rd_data_reg = rom_337;
      11'b00101010010 : tmp_rd_data_reg = rom_338;
      11'b00101010011 : tmp_rd_data_reg = rom_339;
      11'b00101010100 : tmp_rd_data_reg = rom_340;
      11'b00101010101 : tmp_rd_data_reg = rom_341;
      11'b00101010110 : tmp_rd_data_reg = rom_342;
      11'b00101010111 : tmp_rd_data_reg = rom_343;
      11'b00101011000 : tmp_rd_data_reg = rom_344;
      11'b00101011001 : tmp_rd_data_reg = rom_345;
      11'b00101011010 : tmp_rd_data_reg = rom_346;
      11'b00101011011 : tmp_rd_data_reg = rom_347;
      11'b00101011100 : tmp_rd_data_reg = rom_348;
      11'b00101011101 : tmp_rd_data_reg = rom_349;
      11'b00101011110 : tmp_rd_data_reg = rom_350;
      11'b00101011111 : tmp_rd_data_reg = rom_351;
      11'b00101100000 : tmp_rd_data_reg = rom_352;
      11'b00101100001 : tmp_rd_data_reg = rom_353;
      11'b00101100010 : tmp_rd_data_reg = rom_354;
      11'b00101100011 : tmp_rd_data_reg = rom_355;
      11'b00101100100 : tmp_rd_data_reg = rom_356;
      11'b00101100101 : tmp_rd_data_reg = rom_357;
      11'b00101100110 : tmp_rd_data_reg = rom_358;
      11'b00101100111 : tmp_rd_data_reg = rom_359;
      11'b00101101000 : tmp_rd_data_reg = rom_360;
      11'b00101101001 : tmp_rd_data_reg = rom_361;
      11'b00101101010 : tmp_rd_data_reg = rom_362;
      11'b00101101011 : tmp_rd_data_reg = rom_363;
      11'b00101101100 : tmp_rd_data_reg = rom_364;
      11'b00101101101 : tmp_rd_data_reg = rom_365;
      11'b00101101110 : tmp_rd_data_reg = rom_366;
      11'b00101101111 : tmp_rd_data_reg = rom_367;
      11'b00101110000 : tmp_rd_data_reg = rom_368;
      11'b00101110001 : tmp_rd_data_reg = rom_369;
      11'b00101110010 : tmp_rd_data_reg = rom_370;
      11'b00101110011 : tmp_rd_data_reg = rom_371;
      11'b00101110100 : tmp_rd_data_reg = rom_372;
      11'b00101110101 : tmp_rd_data_reg = rom_373;
      11'b00101110110 : tmp_rd_data_reg = rom_374;
      11'b00101110111 : tmp_rd_data_reg = rom_375;
      11'b00101111000 : tmp_rd_data_reg = rom_376;
      11'b00101111001 : tmp_rd_data_reg = rom_377;
      11'b00101111010 : tmp_rd_data_reg = rom_378;
      11'b00101111011 : tmp_rd_data_reg = rom_379;
      11'b00101111100 : tmp_rd_data_reg = rom_380;
      11'b00101111101 : tmp_rd_data_reg = rom_381;
      11'b00101111110 : tmp_rd_data_reg = rom_382;
      11'b00101111111 : tmp_rd_data_reg = rom_383;
      11'b00110000000 : tmp_rd_data_reg = rom_384;
      11'b00110000001 : tmp_rd_data_reg = rom_385;
      11'b00110000010 : tmp_rd_data_reg = rom_386;
      11'b00110000011 : tmp_rd_data_reg = rom_387;
      11'b00110000100 : tmp_rd_data_reg = rom_388;
      11'b00110000101 : tmp_rd_data_reg = rom_389;
      11'b00110000110 : tmp_rd_data_reg = rom_390;
      11'b00110000111 : tmp_rd_data_reg = rom_391;
      11'b00110001000 : tmp_rd_data_reg = rom_392;
      11'b00110001001 : tmp_rd_data_reg = rom_393;
      11'b00110001010 : tmp_rd_data_reg = rom_394;
      11'b00110001011 : tmp_rd_data_reg = rom_395;
      11'b00110001100 : tmp_rd_data_reg = rom_396;
      11'b00110001101 : tmp_rd_data_reg = rom_397;
      11'b00110001110 : tmp_rd_data_reg = rom_398;
      11'b00110001111 : tmp_rd_data_reg = rom_399;
      11'b00110010000 : tmp_rd_data_reg = rom_400;
      11'b00110010001 : tmp_rd_data_reg = rom_401;
      11'b00110010010 : tmp_rd_data_reg = rom_402;
      11'b00110010011 : tmp_rd_data_reg = rom_403;
      11'b00110010100 : tmp_rd_data_reg = rom_404;
      11'b00110010101 : tmp_rd_data_reg = rom_405;
      11'b00110010110 : tmp_rd_data_reg = rom_406;
      11'b00110010111 : tmp_rd_data_reg = rom_407;
      11'b00110011000 : tmp_rd_data_reg = rom_408;
      11'b00110011001 : tmp_rd_data_reg = rom_409;
      11'b00110011010 : tmp_rd_data_reg = rom_410;
      11'b00110011011 : tmp_rd_data_reg = rom_411;
      11'b00110011100 : tmp_rd_data_reg = rom_412;
      11'b00110011101 : tmp_rd_data_reg = rom_413;
      11'b00110011110 : tmp_rd_data_reg = rom_414;
      11'b00110011111 : tmp_rd_data_reg = rom_415;
      11'b00110100000 : tmp_rd_data_reg = rom_416;
      11'b00110100001 : tmp_rd_data_reg = rom_417;
      11'b00110100010 : tmp_rd_data_reg = rom_418;
      11'b00110100011 : tmp_rd_data_reg = rom_419;
      11'b00110100100 : tmp_rd_data_reg = rom_420;
      11'b00110100101 : tmp_rd_data_reg = rom_421;
      11'b00110100110 : tmp_rd_data_reg = rom_422;
      11'b00110100111 : tmp_rd_data_reg = rom_423;
      11'b00110101000 : tmp_rd_data_reg = rom_424;
      11'b00110101001 : tmp_rd_data_reg = rom_425;
      11'b00110101010 : tmp_rd_data_reg = rom_426;
      11'b00110101011 : tmp_rd_data_reg = rom_427;
      11'b00110101100 : tmp_rd_data_reg = rom_428;
      11'b00110101101 : tmp_rd_data_reg = rom_429;
      11'b00110101110 : tmp_rd_data_reg = rom_430;
      11'b00110101111 : tmp_rd_data_reg = rom_431;
      11'b00110110000 : tmp_rd_data_reg = rom_432;
      11'b00110110001 : tmp_rd_data_reg = rom_433;
      11'b00110110010 : tmp_rd_data_reg = rom_434;
      11'b00110110011 : tmp_rd_data_reg = rom_435;
      11'b00110110100 : tmp_rd_data_reg = rom_436;
      11'b00110110101 : tmp_rd_data_reg = rom_437;
      11'b00110110110 : tmp_rd_data_reg = rom_438;
      11'b00110110111 : tmp_rd_data_reg = rom_439;
      11'b00110111000 : tmp_rd_data_reg = rom_440;
      11'b00110111001 : tmp_rd_data_reg = rom_441;
      11'b00110111010 : tmp_rd_data_reg = rom_442;
      11'b00110111011 : tmp_rd_data_reg = rom_443;
      11'b00110111100 : tmp_rd_data_reg = rom_444;
      11'b00110111101 : tmp_rd_data_reg = rom_445;
      11'b00110111110 : tmp_rd_data_reg = rom_446;
      11'b00110111111 : tmp_rd_data_reg = rom_447;
      11'b00111000000 : tmp_rd_data_reg = rom_448;
      11'b00111000001 : tmp_rd_data_reg = rom_449;
      11'b00111000010 : tmp_rd_data_reg = rom_450;
      11'b00111000011 : tmp_rd_data_reg = rom_451;
      11'b00111000100 : tmp_rd_data_reg = rom_452;
      11'b00111000101 : tmp_rd_data_reg = rom_453;
      11'b00111000110 : tmp_rd_data_reg = rom_454;
      11'b00111000111 : tmp_rd_data_reg = rom_455;
      11'b00111001000 : tmp_rd_data_reg = rom_456;
      11'b00111001001 : tmp_rd_data_reg = rom_457;
      11'b00111001010 : tmp_rd_data_reg = rom_458;
      11'b00111001011 : tmp_rd_data_reg = rom_459;
      11'b00111001100 : tmp_rd_data_reg = rom_460;
      11'b00111001101 : tmp_rd_data_reg = rom_461;
      11'b00111001110 : tmp_rd_data_reg = rom_462;
      11'b00111001111 : tmp_rd_data_reg = rom_463;
      11'b00111010000 : tmp_rd_data_reg = rom_464;
      11'b00111010001 : tmp_rd_data_reg = rom_465;
      11'b00111010010 : tmp_rd_data_reg = rom_466;
      11'b00111010011 : tmp_rd_data_reg = rom_467;
      11'b00111010100 : tmp_rd_data_reg = rom_468;
      11'b00111010101 : tmp_rd_data_reg = rom_469;
      11'b00111010110 : tmp_rd_data_reg = rom_470;
      11'b00111010111 : tmp_rd_data_reg = rom_471;
      11'b00111011000 : tmp_rd_data_reg = rom_472;
      11'b00111011001 : tmp_rd_data_reg = rom_473;
      11'b00111011010 : tmp_rd_data_reg = rom_474;
      11'b00111011011 : tmp_rd_data_reg = rom_475;
      11'b00111011100 : tmp_rd_data_reg = rom_476;
      11'b00111011101 : tmp_rd_data_reg = rom_477;
      11'b00111011110 : tmp_rd_data_reg = rom_478;
      11'b00111011111 : tmp_rd_data_reg = rom_479;
      11'b00111100000 : tmp_rd_data_reg = rom_480;
      11'b00111100001 : tmp_rd_data_reg = rom_481;
      11'b00111100010 : tmp_rd_data_reg = rom_482;
      11'b00111100011 : tmp_rd_data_reg = rom_483;
      11'b00111100100 : tmp_rd_data_reg = rom_484;
      11'b00111100101 : tmp_rd_data_reg = rom_485;
      11'b00111100110 : tmp_rd_data_reg = rom_486;
      11'b00111100111 : tmp_rd_data_reg = rom_487;
      11'b00111101000 : tmp_rd_data_reg = rom_488;
      11'b00111101001 : tmp_rd_data_reg = rom_489;
      11'b00111101010 : tmp_rd_data_reg = rom_490;
      11'b00111101011 : tmp_rd_data_reg = rom_491;
      11'b00111101100 : tmp_rd_data_reg = rom_492;
      11'b00111101101 : tmp_rd_data_reg = rom_493;
      11'b00111101110 : tmp_rd_data_reg = rom_494;
      11'b00111101111 : tmp_rd_data_reg = rom_495;
      11'b00111110000 : tmp_rd_data_reg = rom_496;
      11'b00111110001 : tmp_rd_data_reg = rom_497;
      11'b00111110010 : tmp_rd_data_reg = rom_498;
      11'b00111110011 : tmp_rd_data_reg = rom_499;
      11'b00111110100 : tmp_rd_data_reg = rom_500;
      11'b00111110101 : tmp_rd_data_reg = rom_501;
      11'b00111110110 : tmp_rd_data_reg = rom_502;
      11'b00111110111 : tmp_rd_data_reg = rom_503;
      11'b00111111000 : tmp_rd_data_reg = rom_504;
      11'b00111111001 : tmp_rd_data_reg = rom_505;
      11'b00111111010 : tmp_rd_data_reg = rom_506;
      11'b00111111011 : tmp_rd_data_reg = rom_507;
      11'b00111111100 : tmp_rd_data_reg = rom_508;
      11'b00111111101 : tmp_rd_data_reg = rom_509;
      11'b00111111110 : tmp_rd_data_reg = rom_510;
      11'b00111111111 : tmp_rd_data_reg = rom_511;
      11'b01000000000 : tmp_rd_data_reg = rom_512;
      11'b01000000001 : tmp_rd_data_reg = rom_513;
      11'b01000000010 : tmp_rd_data_reg = rom_514;
      11'b01000000011 : tmp_rd_data_reg = rom_515;
      11'b01000000100 : tmp_rd_data_reg = rom_516;
      11'b01000000101 : tmp_rd_data_reg = rom_517;
      11'b01000000110 : tmp_rd_data_reg = rom_518;
      11'b01000000111 : tmp_rd_data_reg = rom_519;
      11'b01000001000 : tmp_rd_data_reg = rom_520;
      11'b01000001001 : tmp_rd_data_reg = rom_521;
      11'b01000001010 : tmp_rd_data_reg = rom_522;
      11'b01000001011 : tmp_rd_data_reg = rom_523;
      11'b01000001100 : tmp_rd_data_reg = rom_524;
      11'b01000001101 : tmp_rd_data_reg = rom_525;
      11'b01000001110 : tmp_rd_data_reg = rom_526;
      11'b01000001111 : tmp_rd_data_reg = rom_527;
      11'b01000010000 : tmp_rd_data_reg = rom_528;
      11'b01000010001 : tmp_rd_data_reg = rom_529;
      11'b01000010010 : tmp_rd_data_reg = rom_530;
      11'b01000010011 : tmp_rd_data_reg = rom_531;
      11'b01000010100 : tmp_rd_data_reg = rom_532;
      11'b01000010101 : tmp_rd_data_reg = rom_533;
      11'b01000010110 : tmp_rd_data_reg = rom_534;
      11'b01000010111 : tmp_rd_data_reg = rom_535;
      11'b01000011000 : tmp_rd_data_reg = rom_536;
      11'b01000011001 : tmp_rd_data_reg = rom_537;
      11'b01000011010 : tmp_rd_data_reg = rom_538;
      11'b01000011011 : tmp_rd_data_reg = rom_539;
      11'b01000011100 : tmp_rd_data_reg = rom_540;
      11'b01000011101 : tmp_rd_data_reg = rom_541;
      11'b01000011110 : tmp_rd_data_reg = rom_542;
      11'b01000011111 : tmp_rd_data_reg = rom_543;
      11'b01000100000 : tmp_rd_data_reg = rom_544;
      11'b01000100001 : tmp_rd_data_reg = rom_545;
      11'b01000100010 : tmp_rd_data_reg = rom_546;
      11'b01000100011 : tmp_rd_data_reg = rom_547;
      11'b01000100100 : tmp_rd_data_reg = rom_548;
      11'b01000100101 : tmp_rd_data_reg = rom_549;
      11'b01000100110 : tmp_rd_data_reg = rom_550;
      11'b01000100111 : tmp_rd_data_reg = rom_551;
      11'b01000101000 : tmp_rd_data_reg = rom_552;
      11'b01000101001 : tmp_rd_data_reg = rom_553;
      11'b01000101010 : tmp_rd_data_reg = rom_554;
      11'b01000101011 : tmp_rd_data_reg = rom_555;
      11'b01000101100 : tmp_rd_data_reg = rom_556;
      11'b01000101101 : tmp_rd_data_reg = rom_557;
      11'b01000101110 : tmp_rd_data_reg = rom_558;
      11'b01000101111 : tmp_rd_data_reg = rom_559;
      11'b01000110000 : tmp_rd_data_reg = rom_560;
      11'b01000110001 : tmp_rd_data_reg = rom_561;
      11'b01000110010 : tmp_rd_data_reg = rom_562;
      11'b01000110011 : tmp_rd_data_reg = rom_563;
      11'b01000110100 : tmp_rd_data_reg = rom_564;
      11'b01000110101 : tmp_rd_data_reg = rom_565;
      11'b01000110110 : tmp_rd_data_reg = rom_566;
      11'b01000110111 : tmp_rd_data_reg = rom_567;
      11'b01000111000 : tmp_rd_data_reg = rom_568;
      11'b01000111001 : tmp_rd_data_reg = rom_569;
      11'b01000111010 : tmp_rd_data_reg = rom_570;
      11'b01000111011 : tmp_rd_data_reg = rom_571;
      11'b01000111100 : tmp_rd_data_reg = rom_572;
      11'b01000111101 : tmp_rd_data_reg = rom_573;
      11'b01000111110 : tmp_rd_data_reg = rom_574;
      11'b01000111111 : tmp_rd_data_reg = rom_575;
      11'b01001000000 : tmp_rd_data_reg = rom_576;
      11'b01001000001 : tmp_rd_data_reg = rom_577;
      11'b01001000010 : tmp_rd_data_reg = rom_578;
      11'b01001000011 : tmp_rd_data_reg = rom_579;
      11'b01001000100 : tmp_rd_data_reg = rom_580;
      11'b01001000101 : tmp_rd_data_reg = rom_581;
      11'b01001000110 : tmp_rd_data_reg = rom_582;
      11'b01001000111 : tmp_rd_data_reg = rom_583;
      11'b01001001000 : tmp_rd_data_reg = rom_584;
      11'b01001001001 : tmp_rd_data_reg = rom_585;
      11'b01001001010 : tmp_rd_data_reg = rom_586;
      11'b01001001011 : tmp_rd_data_reg = rom_587;
      11'b01001001100 : tmp_rd_data_reg = rom_588;
      11'b01001001101 : tmp_rd_data_reg = rom_589;
      11'b01001001110 : tmp_rd_data_reg = rom_590;
      11'b01001001111 : tmp_rd_data_reg = rom_591;
      11'b01001010000 : tmp_rd_data_reg = rom_592;
      11'b01001010001 : tmp_rd_data_reg = rom_593;
      11'b01001010010 : tmp_rd_data_reg = rom_594;
      11'b01001010011 : tmp_rd_data_reg = rom_595;
      11'b01001010100 : tmp_rd_data_reg = rom_596;
      11'b01001010101 : tmp_rd_data_reg = rom_597;
      11'b01001010110 : tmp_rd_data_reg = rom_598;
      11'b01001010111 : tmp_rd_data_reg = rom_599;
      11'b01001011000 : tmp_rd_data_reg = rom_600;
      11'b01001011001 : tmp_rd_data_reg = rom_601;
      11'b01001011010 : tmp_rd_data_reg = rom_602;
      11'b01001011011 : tmp_rd_data_reg = rom_603;
      11'b01001011100 : tmp_rd_data_reg = rom_604;
      11'b01001011101 : tmp_rd_data_reg = rom_605;
      11'b01001011110 : tmp_rd_data_reg = rom_606;
      11'b01001011111 : tmp_rd_data_reg = rom_607;
      11'b01001100000 : tmp_rd_data_reg = rom_608;
      11'b01001100001 : tmp_rd_data_reg = rom_609;
      11'b01001100010 : tmp_rd_data_reg = rom_610;
      11'b01001100011 : tmp_rd_data_reg = rom_611;
      11'b01001100100 : tmp_rd_data_reg = rom_612;
      11'b01001100101 : tmp_rd_data_reg = rom_613;
      11'b01001100110 : tmp_rd_data_reg = rom_614;
      11'b01001100111 : tmp_rd_data_reg = rom_615;
      11'b01001101000 : tmp_rd_data_reg = rom_616;
      11'b01001101001 : tmp_rd_data_reg = rom_617;
      11'b01001101010 : tmp_rd_data_reg = rom_618;
      11'b01001101011 : tmp_rd_data_reg = rom_619;
      11'b01001101100 : tmp_rd_data_reg = rom_620;
      11'b01001101101 : tmp_rd_data_reg = rom_621;
      11'b01001101110 : tmp_rd_data_reg = rom_622;
      11'b01001101111 : tmp_rd_data_reg = rom_623;
      11'b01001110000 : tmp_rd_data_reg = rom_624;
      11'b01001110001 : tmp_rd_data_reg = rom_625;
      11'b01001110010 : tmp_rd_data_reg = rom_626;
      11'b01001110011 : tmp_rd_data_reg = rom_627;
      11'b01001110100 : tmp_rd_data_reg = rom_628;
      11'b01001110101 : tmp_rd_data_reg = rom_629;
      11'b01001110110 : tmp_rd_data_reg = rom_630;
      11'b01001110111 : tmp_rd_data_reg = rom_631;
      11'b01001111000 : tmp_rd_data_reg = rom_632;
      11'b01001111001 : tmp_rd_data_reg = rom_633;
      11'b01001111010 : tmp_rd_data_reg = rom_634;
      11'b01001111011 : tmp_rd_data_reg = rom_635;
      11'b01001111100 : tmp_rd_data_reg = rom_636;
      11'b01001111101 : tmp_rd_data_reg = rom_637;
      11'b01001111110 : tmp_rd_data_reg = rom_638;
      11'b01001111111 : tmp_rd_data_reg = rom_639;
      11'b01010000000 : tmp_rd_data_reg = rom_640;
      11'b01010000001 : tmp_rd_data_reg = rom_641;
      11'b01010000010 : tmp_rd_data_reg = rom_642;
      11'b01010000011 : tmp_rd_data_reg = rom_643;
      11'b01010000100 : tmp_rd_data_reg = rom_644;
      11'b01010000101 : tmp_rd_data_reg = rom_645;
      11'b01010000110 : tmp_rd_data_reg = rom_646;
      11'b01010000111 : tmp_rd_data_reg = rom_647;
      11'b01010001000 : tmp_rd_data_reg = rom_648;
      11'b01010001001 : tmp_rd_data_reg = rom_649;
      11'b01010001010 : tmp_rd_data_reg = rom_650;
      11'b01010001011 : tmp_rd_data_reg = rom_651;
      11'b01010001100 : tmp_rd_data_reg = rom_652;
      11'b01010001101 : tmp_rd_data_reg = rom_653;
      11'b01010001110 : tmp_rd_data_reg = rom_654;
      11'b01010001111 : tmp_rd_data_reg = rom_655;
      11'b01010010000 : tmp_rd_data_reg = rom_656;
      11'b01010010001 : tmp_rd_data_reg = rom_657;
      11'b01010010010 : tmp_rd_data_reg = rom_658;
      11'b01010010011 : tmp_rd_data_reg = rom_659;
      11'b01010010100 : tmp_rd_data_reg = rom_660;
      11'b01010010101 : tmp_rd_data_reg = rom_661;
      11'b01010010110 : tmp_rd_data_reg = rom_662;
      11'b01010010111 : tmp_rd_data_reg = rom_663;
      11'b01010011000 : tmp_rd_data_reg = rom_664;
      11'b01010011001 : tmp_rd_data_reg = rom_665;
      11'b01010011010 : tmp_rd_data_reg = rom_666;
      11'b01010011011 : tmp_rd_data_reg = rom_667;
      11'b01010011100 : tmp_rd_data_reg = rom_668;
      11'b01010011101 : tmp_rd_data_reg = rom_669;
      11'b01010011110 : tmp_rd_data_reg = rom_670;
      11'b01010011111 : tmp_rd_data_reg = rom_671;
      11'b01010100000 : tmp_rd_data_reg = rom_672;
      11'b01010100001 : tmp_rd_data_reg = rom_673;
      11'b01010100010 : tmp_rd_data_reg = rom_674;
      11'b01010100011 : tmp_rd_data_reg = rom_675;
      11'b01010100100 : tmp_rd_data_reg = rom_676;
      11'b01010100101 : tmp_rd_data_reg = rom_677;
      11'b01010100110 : tmp_rd_data_reg = rom_678;
      11'b01010100111 : tmp_rd_data_reg = rom_679;
      11'b01010101000 : tmp_rd_data_reg = rom_680;
      11'b01010101001 : tmp_rd_data_reg = rom_681;
      11'b01010101010 : tmp_rd_data_reg = rom_682;
      11'b01010101011 : tmp_rd_data_reg = rom_683;
      11'b01010101100 : tmp_rd_data_reg = rom_684;
      11'b01010101101 : tmp_rd_data_reg = rom_685;
      11'b01010101110 : tmp_rd_data_reg = rom_686;
      11'b01010101111 : tmp_rd_data_reg = rom_687;
      11'b01010110000 : tmp_rd_data_reg = rom_688;
      11'b01010110001 : tmp_rd_data_reg = rom_689;
      11'b01010110010 : tmp_rd_data_reg = rom_690;
      11'b01010110011 : tmp_rd_data_reg = rom_691;
      11'b01010110100 : tmp_rd_data_reg = rom_692;
      11'b01010110101 : tmp_rd_data_reg = rom_693;
      11'b01010110110 : tmp_rd_data_reg = rom_694;
      11'b01010110111 : tmp_rd_data_reg = rom_695;
      11'b01010111000 : tmp_rd_data_reg = rom_696;
      11'b01010111001 : tmp_rd_data_reg = rom_697;
      11'b01010111010 : tmp_rd_data_reg = rom_698;
      11'b01010111011 : tmp_rd_data_reg = rom_699;
      11'b01010111100 : tmp_rd_data_reg = rom_700;
      11'b01010111101 : tmp_rd_data_reg = rom_701;
      11'b01010111110 : tmp_rd_data_reg = rom_702;
      11'b01010111111 : tmp_rd_data_reg = rom_703;
      11'b01011000000 : tmp_rd_data_reg = rom_704;
      11'b01011000001 : tmp_rd_data_reg = rom_705;
      11'b01011000010 : tmp_rd_data_reg = rom_706;
      11'b01011000011 : tmp_rd_data_reg = rom_707;
      11'b01011000100 : tmp_rd_data_reg = rom_708;
      11'b01011000101 : tmp_rd_data_reg = rom_709;
      11'b01011000110 : tmp_rd_data_reg = rom_710;
      11'b01011000111 : tmp_rd_data_reg = rom_711;
      11'b01011001000 : tmp_rd_data_reg = rom_712;
      11'b01011001001 : tmp_rd_data_reg = rom_713;
      11'b01011001010 : tmp_rd_data_reg = rom_714;
      11'b01011001011 : tmp_rd_data_reg = rom_715;
      11'b01011001100 : tmp_rd_data_reg = rom_716;
      11'b01011001101 : tmp_rd_data_reg = rom_717;
      11'b01011001110 : tmp_rd_data_reg = rom_718;
      11'b01011001111 : tmp_rd_data_reg = rom_719;
      11'b01011010000 : tmp_rd_data_reg = rom_720;
      11'b01011010001 : tmp_rd_data_reg = rom_721;
      11'b01011010010 : tmp_rd_data_reg = rom_722;
      11'b01011010011 : tmp_rd_data_reg = rom_723;
      11'b01011010100 : tmp_rd_data_reg = rom_724;
      11'b01011010101 : tmp_rd_data_reg = rom_725;
      11'b01011010110 : tmp_rd_data_reg = rom_726;
      11'b01011010111 : tmp_rd_data_reg = rom_727;
      11'b01011011000 : tmp_rd_data_reg = rom_728;
      11'b01011011001 : tmp_rd_data_reg = rom_729;
      11'b01011011010 : tmp_rd_data_reg = rom_730;
      11'b01011011011 : tmp_rd_data_reg = rom_731;
      11'b01011011100 : tmp_rd_data_reg = rom_732;
      11'b01011011101 : tmp_rd_data_reg = rom_733;
      11'b01011011110 : tmp_rd_data_reg = rom_734;
      11'b01011011111 : tmp_rd_data_reg = rom_735;
      11'b01011100000 : tmp_rd_data_reg = rom_736;
      11'b01011100001 : tmp_rd_data_reg = rom_737;
      11'b01011100010 : tmp_rd_data_reg = rom_738;
      11'b01011100011 : tmp_rd_data_reg = rom_739;
      11'b01011100100 : tmp_rd_data_reg = rom_740;
      11'b01011100101 : tmp_rd_data_reg = rom_741;
      11'b01011100110 : tmp_rd_data_reg = rom_742;
      11'b01011100111 : tmp_rd_data_reg = rom_743;
      11'b01011101000 : tmp_rd_data_reg = rom_744;
      11'b01011101001 : tmp_rd_data_reg = rom_745;
      11'b01011101010 : tmp_rd_data_reg = rom_746;
      11'b01011101011 : tmp_rd_data_reg = rom_747;
      11'b01011101100 : tmp_rd_data_reg = rom_748;
      11'b01011101101 : tmp_rd_data_reg = rom_749;
      11'b01011101110 : tmp_rd_data_reg = rom_750;
      11'b01011101111 : tmp_rd_data_reg = rom_751;
      11'b01011110000 : tmp_rd_data_reg = rom_752;
      11'b01011110001 : tmp_rd_data_reg = rom_753;
      11'b01011110010 : tmp_rd_data_reg = rom_754;
      11'b01011110011 : tmp_rd_data_reg = rom_755;
      11'b01011110100 : tmp_rd_data_reg = rom_756;
      11'b01011110101 : tmp_rd_data_reg = rom_757;
      11'b01011110110 : tmp_rd_data_reg = rom_758;
      11'b01011110111 : tmp_rd_data_reg = rom_759;
      11'b01011111000 : tmp_rd_data_reg = rom_760;
      11'b01011111001 : tmp_rd_data_reg = rom_761;
      11'b01011111010 : tmp_rd_data_reg = rom_762;
      11'b01011111011 : tmp_rd_data_reg = rom_763;
      11'b01011111100 : tmp_rd_data_reg = rom_764;
      11'b01011111101 : tmp_rd_data_reg = rom_765;
      11'b01011111110 : tmp_rd_data_reg = rom_766;
      11'b01011111111 : tmp_rd_data_reg = rom_767;
      11'b01100000000 : tmp_rd_data_reg = rom_768;
      11'b01100000001 : tmp_rd_data_reg = rom_769;
      11'b01100000010 : tmp_rd_data_reg = rom_770;
      11'b01100000011 : tmp_rd_data_reg = rom_771;
      11'b01100000100 : tmp_rd_data_reg = rom_772;
      11'b01100000101 : tmp_rd_data_reg = rom_773;
      11'b01100000110 : tmp_rd_data_reg = rom_774;
      11'b01100000111 : tmp_rd_data_reg = rom_775;
      11'b01100001000 : tmp_rd_data_reg = rom_776;
      11'b01100001001 : tmp_rd_data_reg = rom_777;
      11'b01100001010 : tmp_rd_data_reg = rom_778;
      11'b01100001011 : tmp_rd_data_reg = rom_779;
      11'b01100001100 : tmp_rd_data_reg = rom_780;
      11'b01100001101 : tmp_rd_data_reg = rom_781;
      11'b01100001110 : tmp_rd_data_reg = rom_782;
      11'b01100001111 : tmp_rd_data_reg = rom_783;
      11'b01100010000 : tmp_rd_data_reg = rom_784;
      11'b01100010001 : tmp_rd_data_reg = rom_785;
      11'b01100010010 : tmp_rd_data_reg = rom_786;
      11'b01100010011 : tmp_rd_data_reg = rom_787;
      11'b01100010100 : tmp_rd_data_reg = rom_788;
      11'b01100010101 : tmp_rd_data_reg = rom_789;
      11'b01100010110 : tmp_rd_data_reg = rom_790;
      11'b01100010111 : tmp_rd_data_reg = rom_791;
      11'b01100011000 : tmp_rd_data_reg = rom_792;
      11'b01100011001 : tmp_rd_data_reg = rom_793;
      11'b01100011010 : tmp_rd_data_reg = rom_794;
      11'b01100011011 : tmp_rd_data_reg = rom_795;
      11'b01100011100 : tmp_rd_data_reg = rom_796;
      11'b01100011101 : tmp_rd_data_reg = rom_797;
      11'b01100011110 : tmp_rd_data_reg = rom_798;
      11'b01100011111 : tmp_rd_data_reg = rom_799;
      11'b01100100000 : tmp_rd_data_reg = rom_800;
      11'b01100100001 : tmp_rd_data_reg = rom_801;
      11'b01100100010 : tmp_rd_data_reg = rom_802;
      11'b01100100011 : tmp_rd_data_reg = rom_803;
      11'b01100100100 : tmp_rd_data_reg = rom_804;
      11'b01100100101 : tmp_rd_data_reg = rom_805;
      11'b01100100110 : tmp_rd_data_reg = rom_806;
      11'b01100100111 : tmp_rd_data_reg = rom_807;
      11'b01100101000 : tmp_rd_data_reg = rom_808;
      11'b01100101001 : tmp_rd_data_reg = rom_809;
      11'b01100101010 : tmp_rd_data_reg = rom_810;
      11'b01100101011 : tmp_rd_data_reg = rom_811;
      11'b01100101100 : tmp_rd_data_reg = rom_812;
      11'b01100101101 : tmp_rd_data_reg = rom_813;
      11'b01100101110 : tmp_rd_data_reg = rom_814;
      11'b01100101111 : tmp_rd_data_reg = rom_815;
      11'b01100110000 : tmp_rd_data_reg = rom_816;
      11'b01100110001 : tmp_rd_data_reg = rom_817;
      11'b01100110010 : tmp_rd_data_reg = rom_818;
      11'b01100110011 : tmp_rd_data_reg = rom_819;
      11'b01100110100 : tmp_rd_data_reg = rom_820;
      11'b01100110101 : tmp_rd_data_reg = rom_821;
      11'b01100110110 : tmp_rd_data_reg = rom_822;
      11'b01100110111 : tmp_rd_data_reg = rom_823;
      11'b01100111000 : tmp_rd_data_reg = rom_824;
      11'b01100111001 : tmp_rd_data_reg = rom_825;
      11'b01100111010 : tmp_rd_data_reg = rom_826;
      11'b01100111011 : tmp_rd_data_reg = rom_827;
      11'b01100111100 : tmp_rd_data_reg = rom_828;
      11'b01100111101 : tmp_rd_data_reg = rom_829;
      11'b01100111110 : tmp_rd_data_reg = rom_830;
      11'b01100111111 : tmp_rd_data_reg = rom_831;
      11'b01101000000 : tmp_rd_data_reg = rom_832;
      11'b01101000001 : tmp_rd_data_reg = rom_833;
      11'b01101000010 : tmp_rd_data_reg = rom_834;
      11'b01101000011 : tmp_rd_data_reg = rom_835;
      11'b01101000100 : tmp_rd_data_reg = rom_836;
      11'b01101000101 : tmp_rd_data_reg = rom_837;
      11'b01101000110 : tmp_rd_data_reg = rom_838;
      11'b01101000111 : tmp_rd_data_reg = rom_839;
      11'b01101001000 : tmp_rd_data_reg = rom_840;
      11'b01101001001 : tmp_rd_data_reg = rom_841;
      11'b01101001010 : tmp_rd_data_reg = rom_842;
      11'b01101001011 : tmp_rd_data_reg = rom_843;
      11'b01101001100 : tmp_rd_data_reg = rom_844;
      11'b01101001101 : tmp_rd_data_reg = rom_845;
      11'b01101001110 : tmp_rd_data_reg = rom_846;
      11'b01101001111 : tmp_rd_data_reg = rom_847;
      11'b01101010000 : tmp_rd_data_reg = rom_848;
      11'b01101010001 : tmp_rd_data_reg = rom_849;
      11'b01101010010 : tmp_rd_data_reg = rom_850;
      11'b01101010011 : tmp_rd_data_reg = rom_851;
      11'b01101010100 : tmp_rd_data_reg = rom_852;
      11'b01101010101 : tmp_rd_data_reg = rom_853;
      11'b01101010110 : tmp_rd_data_reg = rom_854;
      11'b01101010111 : tmp_rd_data_reg = rom_855;
      11'b01101011000 : tmp_rd_data_reg = rom_856;
      11'b01101011001 : tmp_rd_data_reg = rom_857;
      11'b01101011010 : tmp_rd_data_reg = rom_858;
      11'b01101011011 : tmp_rd_data_reg = rom_859;
      11'b01101011100 : tmp_rd_data_reg = rom_860;
      11'b01101011101 : tmp_rd_data_reg = rom_861;
      11'b01101011110 : tmp_rd_data_reg = rom_862;
      11'b01101011111 : tmp_rd_data_reg = rom_863;
      11'b01101100000 : tmp_rd_data_reg = rom_864;
      11'b01101100001 : tmp_rd_data_reg = rom_865;
      11'b01101100010 : tmp_rd_data_reg = rom_866;
      11'b01101100011 : tmp_rd_data_reg = rom_867;
      11'b01101100100 : tmp_rd_data_reg = rom_868;
      11'b01101100101 : tmp_rd_data_reg = rom_869;
      11'b01101100110 : tmp_rd_data_reg = rom_870;
      11'b01101100111 : tmp_rd_data_reg = rom_871;
      11'b01101101000 : tmp_rd_data_reg = rom_872;
      11'b01101101001 : tmp_rd_data_reg = rom_873;
      11'b01101101010 : tmp_rd_data_reg = rom_874;
      11'b01101101011 : tmp_rd_data_reg = rom_875;
      11'b01101101100 : tmp_rd_data_reg = rom_876;
      11'b01101101101 : tmp_rd_data_reg = rom_877;
      11'b01101101110 : tmp_rd_data_reg = rom_878;
      11'b01101101111 : tmp_rd_data_reg = rom_879;
      11'b01101110000 : tmp_rd_data_reg = rom_880;
      11'b01101110001 : tmp_rd_data_reg = rom_881;
      11'b01101110010 : tmp_rd_data_reg = rom_882;
      11'b01101110011 : tmp_rd_data_reg = rom_883;
      11'b01101110100 : tmp_rd_data_reg = rom_884;
      11'b01101110101 : tmp_rd_data_reg = rom_885;
      11'b01101110110 : tmp_rd_data_reg = rom_886;
      11'b01101110111 : tmp_rd_data_reg = rom_887;
      11'b01101111000 : tmp_rd_data_reg = rom_888;
      11'b01101111001 : tmp_rd_data_reg = rom_889;
      11'b01101111010 : tmp_rd_data_reg = rom_890;
      11'b01101111011 : tmp_rd_data_reg = rom_891;
      11'b01101111100 : tmp_rd_data_reg = rom_892;
      11'b01101111101 : tmp_rd_data_reg = rom_893;
      11'b01101111110 : tmp_rd_data_reg = rom_894;
      11'b01101111111 : tmp_rd_data_reg = rom_895;
      11'b01110000000 : tmp_rd_data_reg = rom_896;
      11'b01110000001 : tmp_rd_data_reg = rom_897;
      11'b01110000010 : tmp_rd_data_reg = rom_898;
      11'b01110000011 : tmp_rd_data_reg = rom_899;
      11'b01110000100 : tmp_rd_data_reg = rom_900;
      11'b01110000101 : tmp_rd_data_reg = rom_901;
      11'b01110000110 : tmp_rd_data_reg = rom_902;
      11'b01110000111 : tmp_rd_data_reg = rom_903;
      11'b01110001000 : tmp_rd_data_reg = rom_904;
      11'b01110001001 : tmp_rd_data_reg = rom_905;
      11'b01110001010 : tmp_rd_data_reg = rom_906;
      11'b01110001011 : tmp_rd_data_reg = rom_907;
      11'b01110001100 : tmp_rd_data_reg = rom_908;
      11'b01110001101 : tmp_rd_data_reg = rom_909;
      11'b01110001110 : tmp_rd_data_reg = rom_910;
      11'b01110001111 : tmp_rd_data_reg = rom_911;
      11'b01110010000 : tmp_rd_data_reg = rom_912;
      11'b01110010001 : tmp_rd_data_reg = rom_913;
      11'b01110010010 : tmp_rd_data_reg = rom_914;
      11'b01110010011 : tmp_rd_data_reg = rom_915;
      11'b01110010100 : tmp_rd_data_reg = rom_916;
      11'b01110010101 : tmp_rd_data_reg = rom_917;
      11'b01110010110 : tmp_rd_data_reg = rom_918;
      11'b01110010111 : tmp_rd_data_reg = rom_919;
      11'b01110011000 : tmp_rd_data_reg = rom_920;
      11'b01110011001 : tmp_rd_data_reg = rom_921;
      11'b01110011010 : tmp_rd_data_reg = rom_922;
      11'b01110011011 : tmp_rd_data_reg = rom_923;
      11'b01110011100 : tmp_rd_data_reg = rom_924;
      11'b01110011101 : tmp_rd_data_reg = rom_925;
      11'b01110011110 : tmp_rd_data_reg = rom_926;
      11'b01110011111 : tmp_rd_data_reg = rom_927;
      11'b01110100000 : tmp_rd_data_reg = rom_928;
      11'b01110100001 : tmp_rd_data_reg = rom_929;
      11'b01110100010 : tmp_rd_data_reg = rom_930;
      11'b01110100011 : tmp_rd_data_reg = rom_931;
      11'b01110100100 : tmp_rd_data_reg = rom_932;
      11'b01110100101 : tmp_rd_data_reg = rom_933;
      11'b01110100110 : tmp_rd_data_reg = rom_934;
      11'b01110100111 : tmp_rd_data_reg = rom_935;
      11'b01110101000 : tmp_rd_data_reg = rom_936;
      11'b01110101001 : tmp_rd_data_reg = rom_937;
      11'b01110101010 : tmp_rd_data_reg = rom_938;
      11'b01110101011 : tmp_rd_data_reg = rom_939;
      11'b01110101100 : tmp_rd_data_reg = rom_940;
      11'b01110101101 : tmp_rd_data_reg = rom_941;
      11'b01110101110 : tmp_rd_data_reg = rom_942;
      11'b01110101111 : tmp_rd_data_reg = rom_943;
      11'b01110110000 : tmp_rd_data_reg = rom_944;
      11'b01110110001 : tmp_rd_data_reg = rom_945;
      11'b01110110010 : tmp_rd_data_reg = rom_946;
      11'b01110110011 : tmp_rd_data_reg = rom_947;
      11'b01110110100 : tmp_rd_data_reg = rom_948;
      11'b01110110101 : tmp_rd_data_reg = rom_949;
      11'b01110110110 : tmp_rd_data_reg = rom_950;
      11'b01110110111 : tmp_rd_data_reg = rom_951;
      11'b01110111000 : tmp_rd_data_reg = rom_952;
      11'b01110111001 : tmp_rd_data_reg = rom_953;
      11'b01110111010 : tmp_rd_data_reg = rom_954;
      11'b01110111011 : tmp_rd_data_reg = rom_955;
      11'b01110111100 : tmp_rd_data_reg = rom_956;
      11'b01110111101 : tmp_rd_data_reg = rom_957;
      11'b01110111110 : tmp_rd_data_reg = rom_958;
      11'b01110111111 : tmp_rd_data_reg = rom_959;
      11'b01111000000 : tmp_rd_data_reg = rom_960;
      11'b01111000001 : tmp_rd_data_reg = rom_961;
      11'b01111000010 : tmp_rd_data_reg = rom_962;
      11'b01111000011 : tmp_rd_data_reg = rom_963;
      11'b01111000100 : tmp_rd_data_reg = rom_964;
      11'b01111000101 : tmp_rd_data_reg = rom_965;
      11'b01111000110 : tmp_rd_data_reg = rom_966;
      11'b01111000111 : tmp_rd_data_reg = rom_967;
      11'b01111001000 : tmp_rd_data_reg = rom_968;
      11'b01111001001 : tmp_rd_data_reg = rom_969;
      11'b01111001010 : tmp_rd_data_reg = rom_970;
      11'b01111001011 : tmp_rd_data_reg = rom_971;
      11'b01111001100 : tmp_rd_data_reg = rom_972;
      11'b01111001101 : tmp_rd_data_reg = rom_973;
      11'b01111001110 : tmp_rd_data_reg = rom_974;
      11'b01111001111 : tmp_rd_data_reg = rom_975;
      11'b01111010000 : tmp_rd_data_reg = rom_976;
      11'b01111010001 : tmp_rd_data_reg = rom_977;
      11'b01111010010 : tmp_rd_data_reg = rom_978;
      11'b01111010011 : tmp_rd_data_reg = rom_979;
      11'b01111010100 : tmp_rd_data_reg = rom_980;
      11'b01111010101 : tmp_rd_data_reg = rom_981;
      11'b01111010110 : tmp_rd_data_reg = rom_982;
      11'b01111010111 : tmp_rd_data_reg = rom_983;
      11'b01111011000 : tmp_rd_data_reg = rom_984;
      11'b01111011001 : tmp_rd_data_reg = rom_985;
      11'b01111011010 : tmp_rd_data_reg = rom_986;
      11'b01111011011 : tmp_rd_data_reg = rom_987;
      11'b01111011100 : tmp_rd_data_reg = rom_988;
      11'b01111011101 : tmp_rd_data_reg = rom_989;
      11'b01111011110 : tmp_rd_data_reg = rom_990;
      11'b01111011111 : tmp_rd_data_reg = rom_991;
      11'b01111100000 : tmp_rd_data_reg = rom_992;
      11'b01111100001 : tmp_rd_data_reg = rom_993;
      11'b01111100010 : tmp_rd_data_reg = rom_994;
      11'b01111100011 : tmp_rd_data_reg = rom_995;
      11'b01111100100 : tmp_rd_data_reg = rom_996;
      11'b01111100101 : tmp_rd_data_reg = rom_997;
      11'b01111100110 : tmp_rd_data_reg = rom_998;
      11'b01111100111 : tmp_rd_data_reg = rom_999;
      11'b01111101000 : tmp_rd_data_reg = rom_1000;
      11'b01111101001 : tmp_rd_data_reg = rom_1001;
      11'b01111101010 : tmp_rd_data_reg = rom_1002;
      11'b01111101011 : tmp_rd_data_reg = rom_1003;
      11'b01111101100 : tmp_rd_data_reg = rom_1004;
      11'b01111101101 : tmp_rd_data_reg = rom_1005;
      11'b01111101110 : tmp_rd_data_reg = rom_1006;
      11'b01111101111 : tmp_rd_data_reg = rom_1007;
      11'b01111110000 : tmp_rd_data_reg = rom_1008;
      11'b01111110001 : tmp_rd_data_reg = rom_1009;
      11'b01111110010 : tmp_rd_data_reg = rom_1010;
      11'b01111110011 : tmp_rd_data_reg = rom_1011;
      11'b01111110100 : tmp_rd_data_reg = rom_1012;
      11'b01111110101 : tmp_rd_data_reg = rom_1013;
      11'b01111110110 : tmp_rd_data_reg = rom_1014;
      11'b01111110111 : tmp_rd_data_reg = rom_1015;
      11'b01111111000 : tmp_rd_data_reg = rom_1016;
      11'b01111111001 : tmp_rd_data_reg = rom_1017;
      11'b01111111010 : tmp_rd_data_reg = rom_1018;
      11'b01111111011 : tmp_rd_data_reg = rom_1019;
      11'b01111111100 : tmp_rd_data_reg = rom_1020;
      11'b01111111101 : tmp_rd_data_reg = rom_1021;
      11'b01111111110 : tmp_rd_data_reg = rom_1022;
      11'b01111111111 : tmp_rd_data_reg = rom_1023;
      11'b10000000000 : tmp_rd_data_reg = rom_1024;
      11'b10000000001 : tmp_rd_data_reg = rom_1025;
      11'b10000000010 : tmp_rd_data_reg = rom_1026;
      11'b10000000011 : tmp_rd_data_reg = rom_1027;
      11'b10000000100 : tmp_rd_data_reg = rom_1028;
      11'b10000000101 : tmp_rd_data_reg = rom_1029;
      11'b10000000110 : tmp_rd_data_reg = rom_1030;
      11'b10000000111 : tmp_rd_data_reg = rom_1031;
      11'b10000001000 : tmp_rd_data_reg = rom_1032;
      11'b10000001001 : tmp_rd_data_reg = rom_1033;
      11'b10000001010 : tmp_rd_data_reg = rom_1034;
      11'b10000001011 : tmp_rd_data_reg = rom_1035;
      11'b10000001100 : tmp_rd_data_reg = rom_1036;
      11'b10000001101 : tmp_rd_data_reg = rom_1037;
      11'b10000001110 : tmp_rd_data_reg = rom_1038;
      11'b10000001111 : tmp_rd_data_reg = rom_1039;
      11'b10000010000 : tmp_rd_data_reg = rom_1040;
      11'b10000010001 : tmp_rd_data_reg = rom_1041;
      11'b10000010010 : tmp_rd_data_reg = rom_1042;
      11'b10000010011 : tmp_rd_data_reg = rom_1043;
      11'b10000010100 : tmp_rd_data_reg = rom_1044;
      11'b10000010101 : tmp_rd_data_reg = rom_1045;
      11'b10000010110 : tmp_rd_data_reg = rom_1046;
      11'b10000010111 : tmp_rd_data_reg = rom_1047;
      11'b10000011000 : tmp_rd_data_reg = rom_1048;
      11'b10000011001 : tmp_rd_data_reg = rom_1049;
      11'b10000011010 : tmp_rd_data_reg = rom_1050;
      11'b10000011011 : tmp_rd_data_reg = rom_1051;
      11'b10000011100 : tmp_rd_data_reg = rom_1052;
      11'b10000011101 : tmp_rd_data_reg = rom_1053;
      11'b10000011110 : tmp_rd_data_reg = rom_1054;
      11'b10000011111 : tmp_rd_data_reg = rom_1055;
      11'b10000100000 : tmp_rd_data_reg = rom_1056;
      11'b10000100001 : tmp_rd_data_reg = rom_1057;
      11'b10000100010 : tmp_rd_data_reg = rom_1058;
      11'b10000100011 : tmp_rd_data_reg = rom_1059;
      11'b10000100100 : tmp_rd_data_reg = rom_1060;
      11'b10000100101 : tmp_rd_data_reg = rom_1061;
      11'b10000100110 : tmp_rd_data_reg = rom_1062;
      11'b10000100111 : tmp_rd_data_reg = rom_1063;
      11'b10000101000 : tmp_rd_data_reg = rom_1064;
      11'b10000101001 : tmp_rd_data_reg = rom_1065;
      11'b10000101010 : tmp_rd_data_reg = rom_1066;
      11'b10000101011 : tmp_rd_data_reg = rom_1067;
      11'b10000101100 : tmp_rd_data_reg = rom_1068;
      11'b10000101101 : tmp_rd_data_reg = rom_1069;
      11'b10000101110 : tmp_rd_data_reg = rom_1070;
      11'b10000101111 : tmp_rd_data_reg = rom_1071;
      11'b10000110000 : tmp_rd_data_reg = rom_1072;
      11'b10000110001 : tmp_rd_data_reg = rom_1073;
      11'b10000110010 : tmp_rd_data_reg = rom_1074;
      11'b10000110011 : tmp_rd_data_reg = rom_1075;
      11'b10000110100 : tmp_rd_data_reg = rom_1076;
      11'b10000110101 : tmp_rd_data_reg = rom_1077;
      11'b10000110110 : tmp_rd_data_reg = rom_1078;
      11'b10000110111 : tmp_rd_data_reg = rom_1079;
      11'b10000111000 : tmp_rd_data_reg = rom_1080;
      11'b10000111001 : tmp_rd_data_reg = rom_1081;
      11'b10000111010 : tmp_rd_data_reg = rom_1082;
      11'b10000111011 : tmp_rd_data_reg = rom_1083;
      11'b10000111100 : tmp_rd_data_reg = rom_1084;
      11'b10000111101 : tmp_rd_data_reg = rom_1085;
      11'b10000111110 : tmp_rd_data_reg = rom_1086;
      11'b10000111111 : tmp_rd_data_reg = rom_1087;
      11'b10001000000 : tmp_rd_data_reg = rom_1088;
      11'b10001000001 : tmp_rd_data_reg = rom_1089;
      11'b10001000010 : tmp_rd_data_reg = rom_1090;
      11'b10001000011 : tmp_rd_data_reg = rom_1091;
      11'b10001000100 : tmp_rd_data_reg = rom_1092;
      11'b10001000101 : tmp_rd_data_reg = rom_1093;
      11'b10001000110 : tmp_rd_data_reg = rom_1094;
      11'b10001000111 : tmp_rd_data_reg = rom_1095;
      11'b10001001000 : tmp_rd_data_reg = rom_1096;
      11'b10001001001 : tmp_rd_data_reg = rom_1097;
      11'b10001001010 : tmp_rd_data_reg = rom_1098;
      11'b10001001011 : tmp_rd_data_reg = rom_1099;
      11'b10001001100 : tmp_rd_data_reg = rom_1100;
      11'b10001001101 : tmp_rd_data_reg = rom_1101;
      11'b10001001110 : tmp_rd_data_reg = rom_1102;
      11'b10001001111 : tmp_rd_data_reg = rom_1103;
      11'b10001010000 : tmp_rd_data_reg = rom_1104;
      11'b10001010001 : tmp_rd_data_reg = rom_1105;
      11'b10001010010 : tmp_rd_data_reg = rom_1106;
      11'b10001010011 : tmp_rd_data_reg = rom_1107;
      11'b10001010100 : tmp_rd_data_reg = rom_1108;
      11'b10001010101 : tmp_rd_data_reg = rom_1109;
      11'b10001010110 : tmp_rd_data_reg = rom_1110;
      11'b10001010111 : tmp_rd_data_reg = rom_1111;
      11'b10001011000 : tmp_rd_data_reg = rom_1112;
      11'b10001011001 : tmp_rd_data_reg = rom_1113;
      11'b10001011010 : tmp_rd_data_reg = rom_1114;
      11'b10001011011 : tmp_rd_data_reg = rom_1115;
      11'b10001011100 : tmp_rd_data_reg = rom_1116;
      11'b10001011101 : tmp_rd_data_reg = rom_1117;
      11'b10001011110 : tmp_rd_data_reg = rom_1118;
      11'b10001011111 : tmp_rd_data_reg = rom_1119;
      11'b10001100000 : tmp_rd_data_reg = rom_1120;
      11'b10001100001 : tmp_rd_data_reg = rom_1121;
      11'b10001100010 : tmp_rd_data_reg = rom_1122;
      11'b10001100011 : tmp_rd_data_reg = rom_1123;
      11'b10001100100 : tmp_rd_data_reg = rom_1124;
      11'b10001100101 : tmp_rd_data_reg = rom_1125;
      11'b10001100110 : tmp_rd_data_reg = rom_1126;
      11'b10001100111 : tmp_rd_data_reg = rom_1127;
      11'b10001101000 : tmp_rd_data_reg = rom_1128;
      11'b10001101001 : tmp_rd_data_reg = rom_1129;
      11'b10001101010 : tmp_rd_data_reg = rom_1130;
      11'b10001101011 : tmp_rd_data_reg = rom_1131;
      11'b10001101100 : tmp_rd_data_reg = rom_1132;
      11'b10001101101 : tmp_rd_data_reg = rom_1133;
      11'b10001101110 : tmp_rd_data_reg = rom_1134;
      11'b10001101111 : tmp_rd_data_reg = rom_1135;
      11'b10001110000 : tmp_rd_data_reg = rom_1136;
      11'b10001110001 : tmp_rd_data_reg = rom_1137;
      11'b10001110010 : tmp_rd_data_reg = rom_1138;
      11'b10001110011 : tmp_rd_data_reg = rom_1139;
      11'b10001110100 : tmp_rd_data_reg = rom_1140;
      11'b10001110101 : tmp_rd_data_reg = rom_1141;
      11'b10001110110 : tmp_rd_data_reg = rom_1142;
      11'b10001110111 : tmp_rd_data_reg = rom_1143;
      11'b10001111000 : tmp_rd_data_reg = rom_1144;
      11'b10001111001 : tmp_rd_data_reg = rom_1145;
      11'b10001111010 : tmp_rd_data_reg = rom_1146;
      11'b10001111011 : tmp_rd_data_reg = rom_1147;
      11'b10001111100 : tmp_rd_data_reg = rom_1148;
      11'b10001111101 : tmp_rd_data_reg = rom_1149;
      11'b10001111110 : tmp_rd_data_reg = rom_1150;
      11'b10001111111 : tmp_rd_data_reg = rom_1151;
      11'b10010000000 : tmp_rd_data_reg = rom_1152;
      11'b10010000001 : tmp_rd_data_reg = rom_1153;
      11'b10010000010 : tmp_rd_data_reg = rom_1154;
      11'b10010000011 : tmp_rd_data_reg = rom_1155;
      11'b10010000100 : tmp_rd_data_reg = rom_1156;
      11'b10010000101 : tmp_rd_data_reg = rom_1157;
      11'b10010000110 : tmp_rd_data_reg = rom_1158;
      11'b10010000111 : tmp_rd_data_reg = rom_1159;
      11'b10010001000 : tmp_rd_data_reg = rom_1160;
      11'b10010001001 : tmp_rd_data_reg = rom_1161;
      11'b10010001010 : tmp_rd_data_reg = rom_1162;
      11'b10010001011 : tmp_rd_data_reg = rom_1163;
      11'b10010001100 : tmp_rd_data_reg = rom_1164;
      11'b10010001101 : tmp_rd_data_reg = rom_1165;
      11'b10010001110 : tmp_rd_data_reg = rom_1166;
      11'b10010001111 : tmp_rd_data_reg = rom_1167;
      11'b10010010000 : tmp_rd_data_reg = rom_1168;
      11'b10010010001 : tmp_rd_data_reg = rom_1169;
      11'b10010010010 : tmp_rd_data_reg = rom_1170;
      11'b10010010011 : tmp_rd_data_reg = rom_1171;
      11'b10010010100 : tmp_rd_data_reg = rom_1172;
      11'b10010010101 : tmp_rd_data_reg = rom_1173;
      11'b10010010110 : tmp_rd_data_reg = rom_1174;
      11'b10010010111 : tmp_rd_data_reg = rom_1175;
      11'b10010011000 : tmp_rd_data_reg = rom_1176;
      11'b10010011001 : tmp_rd_data_reg = rom_1177;
      11'b10010011010 : tmp_rd_data_reg = rom_1178;
      11'b10010011011 : tmp_rd_data_reg = rom_1179;
      11'b10010011100 : tmp_rd_data_reg = rom_1180;
      11'b10010011101 : tmp_rd_data_reg = rom_1181;
      11'b10010011110 : tmp_rd_data_reg = rom_1182;
      11'b10010011111 : tmp_rd_data_reg = rom_1183;
      11'b10010100000 : tmp_rd_data_reg = rom_1184;
      11'b10010100001 : tmp_rd_data_reg = rom_1185;
      11'b10010100010 : tmp_rd_data_reg = rom_1186;
      11'b10010100011 : tmp_rd_data_reg = rom_1187;
      11'b10010100100 : tmp_rd_data_reg = rom_1188;
      11'b10010100101 : tmp_rd_data_reg = rom_1189;
      11'b10010100110 : tmp_rd_data_reg = rom_1190;
      11'b10010100111 : tmp_rd_data_reg = rom_1191;
      11'b10010101000 : tmp_rd_data_reg = rom_1192;
      11'b10010101001 : tmp_rd_data_reg = rom_1193;
      11'b10010101010 : tmp_rd_data_reg = rom_1194;
      11'b10010101011 : tmp_rd_data_reg = rom_1195;
      11'b10010101100 : tmp_rd_data_reg = rom_1196;
      11'b10010101101 : tmp_rd_data_reg = rom_1197;
      11'b10010101110 : tmp_rd_data_reg = rom_1198;
      11'b10010101111 : tmp_rd_data_reg = rom_1199;
      11'b10010110000 : tmp_rd_data_reg = rom_1200;
      11'b10010110001 : tmp_rd_data_reg = rom_1201;
      11'b10010110010 : tmp_rd_data_reg = rom_1202;
      11'b10010110011 : tmp_rd_data_reg = rom_1203;
      11'b10010110100 : tmp_rd_data_reg = rom_1204;
      11'b10010110101 : tmp_rd_data_reg = rom_1205;
      11'b10010110110 : tmp_rd_data_reg = rom_1206;
      11'b10010110111 : tmp_rd_data_reg = rom_1207;
      11'b10010111000 : tmp_rd_data_reg = rom_1208;
      11'b10010111001 : tmp_rd_data_reg = rom_1209;
      11'b10010111010 : tmp_rd_data_reg = rom_1210;
      11'b10010111011 : tmp_rd_data_reg = rom_1211;
      11'b10010111100 : tmp_rd_data_reg = rom_1212;
      11'b10010111101 : tmp_rd_data_reg = rom_1213;
      11'b10010111110 : tmp_rd_data_reg = rom_1214;
      11'b10010111111 : tmp_rd_data_reg = rom_1215;
      11'b10011000000 : tmp_rd_data_reg = rom_1216;
      11'b10011000001 : tmp_rd_data_reg = rom_1217;
      11'b10011000010 : tmp_rd_data_reg = rom_1218;
      11'b10011000011 : tmp_rd_data_reg = rom_1219;
      11'b10011000100 : tmp_rd_data_reg = rom_1220;
      11'b10011000101 : tmp_rd_data_reg = rom_1221;
      11'b10011000110 : tmp_rd_data_reg = rom_1222;
      11'b10011000111 : tmp_rd_data_reg = rom_1223;
      11'b10011001000 : tmp_rd_data_reg = rom_1224;
      11'b10011001001 : tmp_rd_data_reg = rom_1225;
      11'b10011001010 : tmp_rd_data_reg = rom_1226;
      11'b10011001011 : tmp_rd_data_reg = rom_1227;
      11'b10011001100 : tmp_rd_data_reg = rom_1228;
      11'b10011001101 : tmp_rd_data_reg = rom_1229;
      11'b10011001110 : tmp_rd_data_reg = rom_1230;
      11'b10011001111 : tmp_rd_data_reg = rom_1231;
      11'b10011010000 : tmp_rd_data_reg = rom_1232;
      11'b10011010001 : tmp_rd_data_reg = rom_1233;
      11'b10011010010 : tmp_rd_data_reg = rom_1234;
      11'b10011010011 : tmp_rd_data_reg = rom_1235;
      11'b10011010100 : tmp_rd_data_reg = rom_1236;
      11'b10011010101 : tmp_rd_data_reg = rom_1237;
      11'b10011010110 : tmp_rd_data_reg = rom_1238;
      11'b10011010111 : tmp_rd_data_reg = rom_1239;
      11'b10011011000 : tmp_rd_data_reg = rom_1240;
      11'b10011011001 : tmp_rd_data_reg = rom_1241;
      11'b10011011010 : tmp_rd_data_reg = rom_1242;
      11'b10011011011 : tmp_rd_data_reg = rom_1243;
      11'b10011011100 : tmp_rd_data_reg = rom_1244;
      default : tmp_rd_data_reg = rom_1245;
    endcase
  end

  assign rom_data_0 = 16'h4150; // @[Expression.scala 2301:18]
  assign rom_data_1 = 16'h4178; // @[Expression.scala 2301:18]
  assign rom_data_2 = 16'h4623; // @[Expression.scala 2301:18]
  assign rom_data_3 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_4 = 16'h4633; // @[Expression.scala 2301:18]
  assign rom_data_5 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_6 = 16'h4643; // @[Expression.scala 2301:18]
  assign rom_data_7 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_8 = 16'h4653; // @[Expression.scala 2301:18]
  assign rom_data_9 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_10 = 16'hc178; // @[Expression.scala 2301:18]
  assign rom_data_11 = 16'h410c; // @[Expression.scala 2301:18]
  assign rom_data_12 = 16'h4534; // @[Expression.scala 2301:18]
  assign rom_data_13 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_14 = 16'h021c; // @[Expression.scala 2301:18]
  assign rom_data_15 = 16'h4303; // @[Expression.scala 2301:18]
  assign rom_data_16 = 16'h0185; // @[Expression.scala 2301:18]
  assign rom_data_17 = 16'h4413; // @[Expression.scala 2301:18]
  assign rom_data_18 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_19 = 16'h0e03; // @[Expression.scala 2301:18]
  assign rom_data_20 = 16'h0385; // @[Expression.scala 2301:18]
  assign rom_data_21 = 16'h137d; // @[Expression.scala 2301:18]
  assign rom_data_22 = 16'hff6d; // @[Expression.scala 2301:18]
  assign rom_data_23 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_24 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_25 = 16'hfed1; // @[Expression.scala 2301:18]
  assign rom_data_26 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_27 = 16'h4518; // @[Expression.scala 2301:18]
  assign rom_data_28 = 16'h4603; // @[Expression.scala 2301:18]
  assign rom_data_29 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_30 = 16'h0214; // @[Expression.scala 2301:18]
  assign rom_data_31 = 16'h83aa; // @[Expression.scala 2301:18]
  assign rom_data_32 = 16'h1a47; // @[Expression.scala 2301:18]
  assign rom_data_33 = 16'h1ffc; // @[Expression.scala 2301:18]
  assign rom_data_34 = 16'h1a17; // @[Expression.scala 2301:18]
  assign rom_data_35 = 16'h0dd3; // @[Expression.scala 2301:18]
  assign rom_data_36 = 16'h001c; // @[Expression.scala 2301:18]
  assign rom_data_37 = 16'h0dcf; // @[Expression.scala 2301:18]
  assign rom_data_38 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_39 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_40 = 16'hfedd; // @[Expression.scala 2301:18]
  assign rom_data_41 = 16'h4134; // @[Expression.scala 2301:18]
  assign rom_data_42 = 16'h8a03; // @[Expression.scala 2301:18]
  assign rom_data_43 = 16'h0285; // @[Expression.scala 2301:18]
  assign rom_data_44 = 16'hc134; // @[Expression.scala 2301:18]
  assign rom_data_45 = 16'h4554; // @[Expression.scala 2301:18]
  assign rom_data_46 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_47 = 16'he289; // @[Expression.scala 2301:18]
  assign rom_data_48 = 16'h8082; // @[Expression.scala 2301:18]
  assign rom_data_49 = 16'hc554; // @[Expression.scala 2301:18]
  assign rom_data_50 = 16'hbf3d; // @[Expression.scala 2301:18]
  assign rom_data_51 = 16'h410c; // @[Expression.scala 2301:18]
  assign rom_data_52 = 16'h4130; // @[Expression.scala 2301:18]
  assign rom_data_53 = 16'h4178; // @[Expression.scala 2301:18]
  assign rom_data_54 = 16'h4623; // @[Expression.scala 2301:18]
  assign rom_data_55 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_56 = 16'h4633; // @[Expression.scala 2301:18]
  assign rom_data_57 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_58 = 16'h4643; // @[Expression.scala 2301:18]
  assign rom_data_59 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_60 = 16'h4653; // @[Expression.scala 2301:18]
  assign rom_data_61 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_62 = 16'hc178; // @[Expression.scala 2301:18]
  assign rom_data_63 = 16'h4154; // @[Expression.scala 2301:18]
  assign rom_data_64 = 16'h4303; // @[Expression.scala 2301:18]
  assign rom_data_65 = 16'h838e; // @[Expression.scala 2301:18]
  assign rom_data_66 = 16'h4578; // @[Expression.scala 2301:18]
  assign rom_data_67 = 16'h8f99; // @[Expression.scala 2301:18]
  assign rom_data_68 = 16'hc38d; // @[Expression.scala 2301:18]
  assign rom_data_69 = 16'h018d; // @[Expression.scala 2301:18]
  assign rom_data_70 = 16'ha009; // @[Expression.scala 2301:18]
  assign rom_data_71 = 16'h454c; // @[Expression.scala 2301:18]
  assign rom_data_72 = 16'h4413; // @[Expression.scala 2301:18]
  assign rom_data_73 = 16'h020d; // @[Expression.scala 2301:18]
  assign rom_data_74 = 16'h021c; // @[Expression.scala 2301:18]
  assign rom_data_75 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_76 = 16'h0fcb; // @[Expression.scala 2301:18]
  assign rom_data_77 = 16'h0385; // @[Expression.scala 2301:18]
  assign rom_data_78 = 16'h137d; // @[Expression.scala 2301:18]
  assign rom_data_79 = 16'hff75; // @[Expression.scala 2301:18]
  assign rom_data_80 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_81 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_82 = 16'hfeb9; // @[Expression.scala 2301:18]
  assign rom_data_83 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_84 = 16'h4518; // @[Expression.scala 2301:18]
  assign rom_data_85 = 16'h4603; // @[Expression.scala 2301:18]
  assign rom_data_86 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_87 = 16'h0214; // @[Expression.scala 2301:18]
  assign rom_data_88 = 16'h83aa; // @[Expression.scala 2301:18]
  assign rom_data_89 = 16'h1a47; // @[Expression.scala 2301:18]
  assign rom_data_90 = 16'h1ffc; // @[Expression.scala 2301:18]
  assign rom_data_91 = 16'h1a17; // @[Expression.scala 2301:18]
  assign rom_data_92 = 16'h0dd3; // @[Expression.scala 2301:18]
  assign rom_data_93 = 16'h001c; // @[Expression.scala 2301:18]
  assign rom_data_94 = 16'h0dcf; // @[Expression.scala 2301:18]
  assign rom_data_95 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_96 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_97 = 16'hfedd; // @[Expression.scala 2301:18]
  assign rom_data_98 = 16'h4534; // @[Expression.scala 2301:18]
  assign rom_data_99 = 16'h8a03; // @[Expression.scala 2301:18]
  assign rom_data_100 = 16'h0285; // @[Expression.scala 2301:18]
  assign rom_data_101 = 16'hc534; // @[Expression.scala 2301:18]
  assign rom_data_102 = 16'h4914; // @[Expression.scala 2301:18]
  assign rom_data_103 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_104 = 16'he289; // @[Expression.scala 2301:18]
  assign rom_data_105 = 16'h8082; // @[Expression.scala 2301:18]
  assign rom_data_106 = 16'hc914; // @[Expression.scala 2301:18]
  assign rom_data_107 = 16'h4574; // @[Expression.scala 2301:18]
  assign rom_data_108 = 16'h0285; // @[Expression.scala 2301:18]
  assign rom_data_109 = 16'hc574; // @[Expression.scala 2301:18]
  assign rom_data_110 = 16'h4554; // @[Expression.scala 2301:18]
  assign rom_data_111 = 16'h0285; // @[Expression.scala 2301:18]
  assign rom_data_112 = 16'hc554; // @[Expression.scala 2301:18]
  assign rom_data_113 = 16'h410c; // @[Expression.scala 2301:18]
  assign rom_data_114 = 16'h0185; // @[Expression.scala 2301:18]
  assign rom_data_115 = 16'hc10c; // @[Expression.scala 2301:18]
  assign rom_data_116 = 16'h4130; // @[Expression.scala 2301:18]
  assign rom_data_117 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_118 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_119 = 16'hbef9; // @[Expression.scala 2301:18]
  assign rom_data_120 = 16'h414c; // @[Expression.scala 2301:18]
  assign rom_data_121 = 16'h4303; // @[Expression.scala 2301:18]
  assign rom_data_122 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_123 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_124 = 16'h822e; // @[Expression.scala 2301:18]
  assign rom_data_125 = 16'h82a6; // @[Expression.scala 2301:18]
  assign rom_data_126 = 16'h832a; // @[Expression.scala 2301:18]
  assign rom_data_127 = 16'h83a2; // @[Expression.scala 2301:18]
  assign rom_data_128 = 16'h410c; // @[Expression.scala 2301:18]
  assign rom_data_129 = 16'h4303; // @[Expression.scala 2301:18]
  assign rom_data_130 = 16'h412c; // @[Expression.scala 2301:18]
  assign rom_data_131 = 16'h4313; // @[Expression.scala 2301:18]
  assign rom_data_132 = 16'h020c; // @[Expression.scala 2301:18]
  assign rom_data_133 = 16'h11fd; // @[Expression.scala 2301:18]
  assign rom_data_134 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_135 = 16'h0d5f; // @[Expression.scala 2301:18]
  assign rom_data_136 = 16'hfdf5; // @[Expression.scala 2301:18]
  assign rom_data_137 = 16'h020c; // @[Expression.scala 2301:18]
  assign rom_data_138 = 16'h0214; // @[Expression.scala 2301:18]
  assign rom_data_139 = 16'h1ffc; // @[Expression.scala 2301:18]
  assign rom_data_140 = 16'h0d17; // @[Expression.scala 2301:18]
  assign rom_data_141 = 16'h07d3; // @[Expression.scala 2301:18]
  assign rom_data_142 = 16'h001c; // @[Expression.scala 2301:18]
  assign rom_data_143 = 16'h07cf; // @[Expression.scala 2301:18]
  assign rom_data_144 = 16'h0185; // @[Expression.scala 2301:18]
  assign rom_data_145 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_146 = 16'hfee5; // @[Expression.scala 2301:18]
  assign rom_data_147 = 16'h412c; // @[Expression.scala 2301:18]
  assign rom_data_148 = 16'h8603; // @[Expression.scala 2301:18]
  assign rom_data_149 = 16'h0185; // @[Expression.scala 2301:18]
  assign rom_data_150 = 16'hc12c; // @[Expression.scala 2301:18]
  assign rom_data_151 = 16'h8082; // @[Expression.scala 2301:18]
  assign rom_data_152 = 16'h04a8; // @[Expression.scala 2301:18]
  assign rom_data_153 = 16'h450c; // @[Expression.scala 2301:18]
  assign rom_data_154 = 16'h11fd; // @[Expression.scala 2301:18]
  assign rom_data_155 = 16'h0070; // @[Expression.scala 2301:18]
  assign rom_data_156 = 16'h0014; // @[Expression.scala 2301:18]
  assign rom_data_157 = 16'h094f; // @[Expression.scala 2301:18]
  assign rom_data_158 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_159 = 16'hc50c; // @[Expression.scala 2301:18]
  assign rom_data_160 = 16'hc189; // @[Expression.scala 2301:18]
  assign rom_data_161 = 16'hb0ed; // @[Expression.scala 2301:18]
  assign rom_data_162 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_163 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_164 = 16'h2200; // @[Expression.scala 2301:18]
  assign rom_data_165 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_166 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_167 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_168 = 16'h26f0; // @[Expression.scala 2301:18]
  assign rom_data_169 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_170 = 16'h2720; // @[Expression.scala 2301:18]
  assign rom_data_171 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_172 = 16'h2010; // @[Expression.scala 2301:18]
  assign rom_data_173 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_174 = 16'h20ec; // @[Expression.scala 2301:18]
  assign rom_data_175 = 16'hc570; // @[Expression.scala 2301:18]
  assign rom_data_176 = 16'h25f0; // @[Expression.scala 2301:18]
  assign rom_data_177 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_178 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_179 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_180 = 16'h3d31; // @[Expression.scala 2301:18]
  assign rom_data_181 = 16'h4570; // @[Expression.scala 2301:18]
  assign rom_data_182 = 16'hc279; // @[Expression.scala 2301:18]
  assign rom_data_183 = 16'h127d; // @[Expression.scala 2301:18]
  assign rom_data_184 = 16'hc570; // @[Expression.scala 2301:18]
  assign rom_data_185 = 16'hc229; // @[Expression.scala 2301:18]
  assign rom_data_186 = 16'h0754; // @[Expression.scala 2301:18]
  assign rom_data_187 = 16'h8e15; // @[Expression.scala 2301:18]
  assign rom_data_188 = 16'hc23d; // @[Expression.scala 2301:18]
  assign rom_data_189 = 16'h2700; // @[Expression.scala 2301:18]
  assign rom_data_190 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_191 = 16'h4110; // @[Expression.scala 2301:18]
  assign rom_data_192 = 16'h0209; // @[Expression.scala 2301:18]
  assign rom_data_193 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_194 = 16'hbfc1; // @[Expression.scala 2301:18]
  assign rom_data_195 = 16'h2710; // @[Expression.scala 2301:18]
  assign rom_data_196 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_197 = 16'h2010; // @[Expression.scala 2301:18]
  assign rom_data_198 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_199 = 16'h4110; // @[Expression.scala 2301:18]
  assign rom_data_200 = 16'h0209; // @[Expression.scala 2301:18]
  assign rom_data_201 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_202 = 16'hbfa1; // @[Expression.scala 2301:18]
  assign rom_data_203 = 16'h2700; // @[Expression.scala 2301:18]
  assign rom_data_204 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_205 = 16'h2570; // @[Expression.scala 2301:18]
  assign rom_data_206 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_207 = 16'h2200; // @[Expression.scala 2301:18]
  assign rom_data_208 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_209 = 16'h2018; // @[Expression.scala 2301:18]
  assign rom_data_210 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_211 = 16'hbf7d; // @[Expression.scala 2301:18]
  assign rom_data_212 = 16'h0024; // @[Expression.scala 2301:18]
  assign rom_data_213 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_214 = 16'h0228; // @[Expression.scala 2301:18]
  assign rom_data_215 = 16'h29e0; // @[Expression.scala 2301:18]
  assign rom_data_216 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_217 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_218 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_219 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_220 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_221 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_222 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_223 = 16'h2000; // @[Expression.scala 2301:18]
  assign rom_data_224 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_225 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_226 = 16'h127d; // @[Expression.scala 2301:18]
  assign rom_data_227 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_228 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_229 = 16'h1275; // @[Expression.scala 2301:18]
  assign rom_data_230 = 16'hc1b0; // @[Expression.scala 2301:18]
  assign rom_data_231 = 16'h2000; // @[Expression.scala 2301:18]
  assign rom_data_232 = 16'hc1d0; // @[Expression.scala 2301:18]
  assign rom_data_233 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_234 = 16'hc1f0; // @[Expression.scala 2301:18]
  assign rom_data_235 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_236 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_237 = 16'h27e4; // @[Expression.scala 2301:18]
  assign rom_data_238 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_239 = 16'h2814; // @[Expression.scala 2301:18]
  assign rom_data_240 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_241 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_242 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_243 = 16'h2724; // @[Expression.scala 2301:18]
  assign rom_data_244 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_245 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_246 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_247 = 16'h4190; // @[Expression.scala 2301:18]
  assign rom_data_248 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_249 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_250 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_251 = 16'h41b4; // @[Expression.scala 2301:18]
  assign rom_data_252 = 16'h028d; // @[Expression.scala 2301:18]
  assign rom_data_253 = 16'h8316; // @[Expression.scala 2301:18]
  assign rom_data_254 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_255 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_256 = 16'he28d; // @[Expression.scala 2301:18]
  assign rom_data_257 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_258 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_259 = 16'hc138; // @[Expression.scala 2301:18]
  assign rom_data_260 = 16'hc1b8; // @[Expression.scala 2301:18]
  assign rom_data_261 = 16'h3bed; // @[Expression.scala 2301:18]
  assign rom_data_262 = 16'h0044; // @[Expression.scala 2301:18]
  assign rom_data_263 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_264 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_265 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_266 = 16'h29cc; // @[Expression.scala 2301:18]
  assign rom_data_267 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_268 = 16'h29dc; // @[Expression.scala 2301:18]
  assign rom_data_269 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_270 = 16'h298c; // @[Expression.scala 2301:18]
  assign rom_data_271 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_272 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_273 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_274 = 16'h4190; // @[Expression.scala 2301:18]
  assign rom_data_275 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_276 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_277 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_278 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_279 = 16'h8285; // @[Expression.scala 2301:18]
  assign rom_data_280 = 16'h9216; // @[Expression.scala 2301:18]
  assign rom_data_281 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_282 = 16'h3b99; // @[Expression.scala 2301:18]
  assign rom_data_283 = 16'h0064; // @[Expression.scala 2301:18]
  assign rom_data_284 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_285 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_286 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_287 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_288 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_289 = 16'ha095; // @[Expression.scala 2301:18]
  assign rom_data_290 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_291 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_292 = 16'h27e4; // @[Expression.scala 2301:18]
  assign rom_data_293 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_294 = 16'h2814; // @[Expression.scala 2301:18]
  assign rom_data_295 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_296 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_297 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_298 = 16'h2724; // @[Expression.scala 2301:18]
  assign rom_data_299 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_300 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_301 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_302 = 16'h4190; // @[Expression.scala 2301:18]
  assign rom_data_303 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_304 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_305 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_306 = 16'h41b4; // @[Expression.scala 2301:18]
  assign rom_data_307 = 16'h028d; // @[Expression.scala 2301:18]
  assign rom_data_308 = 16'h8316; // @[Expression.scala 2301:18]
  assign rom_data_309 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_310 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_311 = 16'he28d; // @[Expression.scala 2301:18]
  assign rom_data_312 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_313 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_314 = 16'hc138; // @[Expression.scala 2301:18]
  assign rom_data_315 = 16'hc1b8; // @[Expression.scala 2301:18]
  assign rom_data_316 = 16'h3b11; // @[Expression.scala 2301:18]
  assign rom_data_317 = 16'h0044; // @[Expression.scala 2301:18]
  assign rom_data_318 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_319 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_320 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_321 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_322 = 16'h1289; // @[Expression.scala 2301:18]
  assign rom_data_323 = 16'hf6a1; // @[Expression.scala 2301:18]
  assign rom_data_324 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_325 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_326 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_327 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_328 = 16'h1275; // @[Expression.scala 2301:18]
  assign rom_data_329 = 16'h5a66; // @[Expression.scala 2301:18]
  assign rom_data_330 = 16'h1275; // @[Expression.scala 2301:18]
  assign rom_data_331 = 16'h421a; // @[Expression.scala 2301:18]
  assign rom_data_332 = 16'h121d; // @[Expression.scala 2301:18]
  assign rom_data_333 = 16'h425a; // @[Expression.scala 2301:18]
  assign rom_data_334 = 16'h1279; // @[Expression.scala 2301:18]
  assign rom_data_335 = 16'h426a; // @[Expression.scala 2301:18]
  assign rom_data_336 = 16'ha17d; // @[Expression.scala 2301:18]
  assign rom_data_337 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_338 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_339 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_340 = 16'h0206; // @[Expression.scala 2301:18]
  assign rom_data_341 = 16'h127d; // @[Expression.scala 2301:18]
  assign rom_data_342 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_343 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_344 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_345 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_346 = 16'h013c; // @[Expression.scala 2301:18]
  assign rom_data_347 = 16'h8f99; // @[Expression.scala 2301:18]
  assign rom_data_348 = 16'h829e; // @[Expression.scala 2301:18]
  assign rom_data_349 = 16'h0386; // @[Expression.scala 2301:18]
  assign rom_data_350 = 16'h9396; // @[Expression.scala 2301:18]
  assign rom_data_351 = 16'h2818; // @[Expression.scala 2301:18]
  assign rom_data_352 = 16'h921e; // @[Expression.scala 2301:18]
  assign rom_data_353 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_354 = 16'ha07d; // @[Expression.scala 2301:18]
  assign rom_data_355 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_356 = 16'h0130; // @[Expression.scala 2301:18]
  assign rom_data_357 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_358 = 16'h2818; // @[Expression.scala 2301:18]
  assign rom_data_359 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_360 = 16'ha02d; // @[Expression.scala 2301:18]
  assign rom_data_361 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_362 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_363 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_364 = 16'h08d4; // @[Expression.scala 2301:18]
  assign rom_data_365 = 16'h0206; // @[Expression.scala 2301:18]
  assign rom_data_366 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_367 = 16'hc154; // @[Expression.scala 2301:18]
  assign rom_data_368 = 16'h2818; // @[Expression.scala 2301:18]
  assign rom_data_369 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_370 = 16'ha005; // @[Expression.scala 2301:18]
  assign rom_data_371 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_372 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_373 = 16'h41f0; // @[Expression.scala 2301:18]
  assign rom_data_374 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_375 = 16'h0299; // @[Expression.scala 2301:18]
  assign rom_data_376 = 16'h8316; // @[Expression.scala 2301:18]
  assign rom_data_377 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_378 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_379 = 16'h4292; // @[Expression.scala 2301:18]
  assign rom_data_380 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_381 = 16'h9216; // @[Expression.scala 2301:18]
  assign rom_data_382 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_383 = 16'hc1f8; // @[Expression.scala 2301:18]
  assign rom_data_384 = 16'hc118; // @[Expression.scala 2301:18]
  assign rom_data_385 = 16'h2884; // @[Expression.scala 2301:18]
  assign rom_data_386 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_387 = 16'h28b4; // @[Expression.scala 2301:18]
  assign rom_data_388 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_389 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_390 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_391 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_392 = 16'hc910; // @[Expression.scala 2301:18]
  assign rom_data_393 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_394 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_395 = 16'h2530; // @[Expression.scala 2301:18]
  assign rom_data_396 = 16'hc570; // @[Expression.scala 2301:18]
  assign rom_data_397 = 16'h3a99; // @[Expression.scala 2301:18]
  assign rom_data_398 = 16'h0084; // @[Expression.scala 2301:18]
  assign rom_data_399 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_400 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_401 = 16'h2978; // @[Expression.scala 2301:18]
  assign rom_data_402 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_403 = 16'h2988; // @[Expression.scala 2301:18]
  assign rom_data_404 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_405 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_406 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_407 = 16'h28b8; // @[Expression.scala 2301:18]
  assign rom_data_408 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_409 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_410 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_411 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_412 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_413 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_414 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_415 = 16'h3985; // @[Expression.scala 2301:18]
  assign rom_data_416 = 16'h00a4; // @[Expression.scala 2301:18]
  assign rom_data_417 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_418 = 16'h0228; // @[Expression.scala 2301:18]
  assign rom_data_419 = 16'h3b55; // @[Expression.scala 2301:18]
  assign rom_data_420 = 16'h00c4; // @[Expression.scala 2301:18]
  assign rom_data_421 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_422 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_423 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_424 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_425 = 16'h1285; // @[Expression.scala 2301:18]
  assign rom_data_426 = 16'h4292; // @[Expression.scala 2301:18]
  assign rom_data_427 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_428 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_429 = 16'hbe65; // @[Expression.scala 2301:18]
  assign rom_data_430 = 16'hbdd1; // @[Expression.scala 2301:18]
  assign rom_data_431 = 16'h00e4; // @[Expression.scala 2301:18]
  assign rom_data_432 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_433 = 16'h0228; // @[Expression.scala 2301:18]
  assign rom_data_434 = 16'h2c4c; // @[Expression.scala 2301:18]
  assign rom_data_435 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_436 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_437 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_438 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_439 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_440 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_441 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_442 = 16'h2000; // @[Expression.scala 2301:18]
  assign rom_data_443 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_444 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_445 = 16'h127d; // @[Expression.scala 2301:18]
  assign rom_data_446 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_447 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_448 = 16'h1275; // @[Expression.scala 2301:18]
  assign rom_data_449 = 16'hc1b0; // @[Expression.scala 2301:18]
  assign rom_data_450 = 16'h2000; // @[Expression.scala 2301:18]
  assign rom_data_451 = 16'hc1d0; // @[Expression.scala 2301:18]
  assign rom_data_452 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_453 = 16'hc1f0; // @[Expression.scala 2301:18]
  assign rom_data_454 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_455 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_456 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_457 = 16'h12ed; // @[Expression.scala 2301:18]
  assign rom_data_458 = 16'h42a2; // @[Expression.scala 2301:18]
  assign rom_data_459 = 16'h12ed; // @[Expression.scala 2301:18]
  assign rom_data_460 = 16'h46a2; // @[Expression.scala 2301:18]
  assign rom_data_461 = 16'h12ad; // @[Expression.scala 2301:18]
  assign rom_data_462 = 16'h46da; // @[Expression.scala 2301:18]
  assign rom_data_463 = 16'h12f1; // @[Expression.scala 2301:18]
  assign rom_data_464 = 16'h46ea; // @[Expression.scala 2301:18]
  assign rom_data_465 = 16'ha1f1; // @[Expression.scala 2301:18]
  assign rom_data_466 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_467 = 16'h2aa4; // @[Expression.scala 2301:18]
  assign rom_data_468 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_469 = 16'h2ad4; // @[Expression.scala 2301:18]
  assign rom_data_470 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_471 = 16'h29e4; // @[Expression.scala 2301:18]
  assign rom_data_472 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_473 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_474 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_475 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_476 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_477 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_478 = 16'h4190; // @[Expression.scala 2301:18]
  assign rom_data_479 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_480 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_481 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_482 = 16'h41b4; // @[Expression.scala 2301:18]
  assign rom_data_483 = 16'h028d; // @[Expression.scala 2301:18]
  assign rom_data_484 = 16'h8316; // @[Expression.scala 2301:18]
  assign rom_data_485 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_486 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_487 = 16'he28d; // @[Expression.scala 2301:18]
  assign rom_data_488 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_489 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_490 = 16'hc138; // @[Expression.scala 2301:18]
  assign rom_data_491 = 16'hc1b8; // @[Expression.scala 2301:18]
  assign rom_data_492 = 16'h3851; // @[Expression.scala 2301:18]
  assign rom_data_493 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_494 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_495 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_496 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_497 = 16'h0104; // @[Expression.scala 2301:18]
  assign rom_data_498 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_499 = 16'hbf4d; // @[Expression.scala 2301:18]
  assign rom_data_500 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_501 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_502 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_503 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_504 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_505 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_506 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_507 = 16'h013c; // @[Expression.scala 2301:18]
  assign rom_data_508 = 16'h8f99; // @[Expression.scala 2301:18]
  assign rom_data_509 = 16'h829e; // @[Expression.scala 2301:18]
  assign rom_data_510 = 16'h0386; // @[Expression.scala 2301:18]
  assign rom_data_511 = 16'h9396; // @[Expression.scala 2301:18]
  assign rom_data_512 = 16'h2ad8; // @[Expression.scala 2301:18]
  assign rom_data_513 = 16'h921e; // @[Expression.scala 2301:18]
  assign rom_data_514 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_515 = 16'ha075; // @[Expression.scala 2301:18]
  assign rom_data_516 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_517 = 16'h0130; // @[Expression.scala 2301:18]
  assign rom_data_518 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_519 = 16'h2ad8; // @[Expression.scala 2301:18]
  assign rom_data_520 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_521 = 16'ha029; // @[Expression.scala 2301:18]
  assign rom_data_522 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_523 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_524 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_525 = 16'h04f4; // @[Expression.scala 2301:18]
  assign rom_data_526 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_527 = 16'hc154; // @[Expression.scala 2301:18]
  assign rom_data_528 = 16'h2ad8; // @[Expression.scala 2301:18]
  assign rom_data_529 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_530 = 16'ha005; // @[Expression.scala 2301:18]
  assign rom_data_531 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_532 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_533 = 16'h41f0; // @[Expression.scala 2301:18]
  assign rom_data_534 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_535 = 16'h2530; // @[Expression.scala 2301:18]
  assign rom_data_536 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_537 = 16'he28d; // @[Expression.scala 2301:18]
  assign rom_data_538 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_539 = 16'ha00d; // @[Expression.scala 2301:18]
  assign rom_data_540 = 16'h41f0; // @[Expression.scala 2301:18]
  assign rom_data_541 = 16'h020d; // @[Expression.scala 2301:18]
  assign rom_data_542 = 16'hc1f0; // @[Expression.scala 2301:18]
  assign rom_data_543 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_544 = 16'h2b44; // @[Expression.scala 2301:18]
  assign rom_data_545 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_546 = 16'h2b74; // @[Expression.scala 2301:18]
  assign rom_data_547 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_548 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_549 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_550 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_551 = 16'hc910; // @[Expression.scala 2301:18]
  assign rom_data_552 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_553 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_554 = 16'h2530; // @[Expression.scala 2301:18]
  assign rom_data_555 = 16'hc570; // @[Expression.scala 2301:18]
  assign rom_data_556 = 16'h381d; // @[Expression.scala 2301:18]
  assign rom_data_557 = 16'h0124; // @[Expression.scala 2301:18]
  assign rom_data_558 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_559 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_560 = 16'h2c38; // @[Expression.scala 2301:18]
  assign rom_data_561 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_562 = 16'h2c48; // @[Expression.scala 2301:18]
  assign rom_data_563 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_564 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_565 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_566 = 16'h2b78; // @[Expression.scala 2301:18]
  assign rom_data_567 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_568 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_569 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_570 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_571 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_572 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_573 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_574 = 16'h3709; // @[Expression.scala 2301:18]
  assign rom_data_575 = 16'h0144; // @[Expression.scala 2301:18]
  assign rom_data_576 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_577 = 16'h0228; // @[Expression.scala 2301:18]
  assign rom_data_578 = 16'h38d9; // @[Expression.scala 2301:18]
  assign rom_data_579 = 16'h0164; // @[Expression.scala 2301:18]
  assign rom_data_580 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_581 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_582 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_583 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_584 = 16'h1289; // @[Expression.scala 2301:18]
  assign rom_data_585 = 16'h52a6; // @[Expression.scala 2301:18]
  assign rom_data_586 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_587 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_588 = 16'hbde9; // @[Expression.scala 2301:18]
  assign rom_data_589 = 16'h0184; // @[Expression.scala 2301:18]
  assign rom_data_590 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_591 = 16'h0228; // @[Expression.scala 2301:18]
  assign rom_data_592 = 16'h2f0c; // @[Expression.scala 2301:18]
  assign rom_data_593 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_594 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_595 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_596 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_597 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_598 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_599 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_600 = 16'h2000; // @[Expression.scala 2301:18]
  assign rom_data_601 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_602 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_603 = 16'h127d; // @[Expression.scala 2301:18]
  assign rom_data_604 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_605 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_606 = 16'h1275; // @[Expression.scala 2301:18]
  assign rom_data_607 = 16'hc1b0; // @[Expression.scala 2301:18]
  assign rom_data_608 = 16'h2000; // @[Expression.scala 2301:18]
  assign rom_data_609 = 16'hc1d0; // @[Expression.scala 2301:18]
  assign rom_data_610 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_611 = 16'hc1f0; // @[Expression.scala 2301:18]
  assign rom_data_612 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_613 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_614 = 16'h2d10; // @[Expression.scala 2301:18]
  assign rom_data_615 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_616 = 16'h2d40; // @[Expression.scala 2301:18]
  assign rom_data_617 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_618 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_619 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_620 = 16'h2c50; // @[Expression.scala 2301:18]
  assign rom_data_621 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_622 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_623 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_624 = 16'h4190; // @[Expression.scala 2301:18]
  assign rom_data_625 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_626 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_627 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_628 = 16'h41b4; // @[Expression.scala 2301:18]
  assign rom_data_629 = 16'h028d; // @[Expression.scala 2301:18]
  assign rom_data_630 = 16'h8316; // @[Expression.scala 2301:18]
  assign rom_data_631 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_632 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_633 = 16'he28d; // @[Expression.scala 2301:18]
  assign rom_data_634 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_635 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_636 = 16'hc138; // @[Expression.scala 2301:18]
  assign rom_data_637 = 16'hc1b8; // @[Expression.scala 2301:18]
  assign rom_data_638 = 16'h3609; // @[Expression.scala 2301:18]
  assign rom_data_639 = 16'h01a4; // @[Expression.scala 2301:18]
  assign rom_data_640 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_641 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_642 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_643 = 16'h2ef8; // @[Expression.scala 2301:18]
  assign rom_data_644 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_645 = 16'h2f08; // @[Expression.scala 2301:18]
  assign rom_data_646 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_647 = 16'h2eb8; // @[Expression.scala 2301:18]
  assign rom_data_648 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_649 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_650 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_651 = 16'h4190; // @[Expression.scala 2301:18]
  assign rom_data_652 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_653 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_654 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_655 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_656 = 16'h8285; // @[Expression.scala 2301:18]
  assign rom_data_657 = 16'h9216; // @[Expression.scala 2301:18]
  assign rom_data_658 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_659 = 16'h35b5; // @[Expression.scala 2301:18]
  assign rom_data_660 = 16'h01c4; // @[Expression.scala 2301:18]
  assign rom_data_661 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_662 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_663 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_664 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_665 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_666 = 16'ha095; // @[Expression.scala 2301:18]
  assign rom_data_667 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_668 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_669 = 16'h2d10; // @[Expression.scala 2301:18]
  assign rom_data_670 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_671 = 16'h2d40; // @[Expression.scala 2301:18]
  assign rom_data_672 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_673 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_674 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_675 = 16'h2c50; // @[Expression.scala 2301:18]
  assign rom_data_676 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_677 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_678 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_679 = 16'h4190; // @[Expression.scala 2301:18]
  assign rom_data_680 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_681 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_682 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_683 = 16'h41b4; // @[Expression.scala 2301:18]
  assign rom_data_684 = 16'h028d; // @[Expression.scala 2301:18]
  assign rom_data_685 = 16'h8316; // @[Expression.scala 2301:18]
  assign rom_data_686 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_687 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_688 = 16'he28d; // @[Expression.scala 2301:18]
  assign rom_data_689 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_690 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_691 = 16'hc138; // @[Expression.scala 2301:18]
  assign rom_data_692 = 16'hc1b8; // @[Expression.scala 2301:18]
  assign rom_data_693 = 16'h352d; // @[Expression.scala 2301:18]
  assign rom_data_694 = 16'h01a4; // @[Expression.scala 2301:18]
  assign rom_data_695 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_696 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_697 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_698 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_699 = 16'h12c5; // @[Expression.scala 2301:18]
  assign rom_data_700 = 16'hf6a1; // @[Expression.scala 2301:18]
  assign rom_data_701 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_702 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_703 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_704 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_705 = 16'h1275; // @[Expression.scala 2301:18]
  assign rom_data_706 = 16'h5a66; // @[Expression.scala 2301:18]
  assign rom_data_707 = 16'h1275; // @[Expression.scala 2301:18]
  assign rom_data_708 = 16'h421a; // @[Expression.scala 2301:18]
  assign rom_data_709 = 16'h1259; // @[Expression.scala 2301:18]
  assign rom_data_710 = 16'h425a; // @[Expression.scala 2301:18]
  assign rom_data_711 = 16'h1279; // @[Expression.scala 2301:18]
  assign rom_data_712 = 16'h426a; // @[Expression.scala 2301:18]
  assign rom_data_713 = 16'ha17d; // @[Expression.scala 2301:18]
  assign rom_data_714 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_715 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_716 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_717 = 16'h0206; // @[Expression.scala 2301:18]
  assign rom_data_718 = 16'h127d; // @[Expression.scala 2301:18]
  assign rom_data_719 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_720 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_721 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_722 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_723 = 16'h013c; // @[Expression.scala 2301:18]
  assign rom_data_724 = 16'h8f99; // @[Expression.scala 2301:18]
  assign rom_data_725 = 16'h829e; // @[Expression.scala 2301:18]
  assign rom_data_726 = 16'h0386; // @[Expression.scala 2301:18]
  assign rom_data_727 = 16'h9396; // @[Expression.scala 2301:18]
  assign rom_data_728 = 16'h2d44; // @[Expression.scala 2301:18]
  assign rom_data_729 = 16'h921e; // @[Expression.scala 2301:18]
  assign rom_data_730 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_731 = 16'ha07d; // @[Expression.scala 2301:18]
  assign rom_data_732 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_733 = 16'h0130; // @[Expression.scala 2301:18]
  assign rom_data_734 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_735 = 16'h2d44; // @[Expression.scala 2301:18]
  assign rom_data_736 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_737 = 16'ha02d; // @[Expression.scala 2301:18]
  assign rom_data_738 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_739 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_740 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_741 = 16'h0514; // @[Expression.scala 2301:18]
  assign rom_data_742 = 16'h0206; // @[Expression.scala 2301:18]
  assign rom_data_743 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_744 = 16'hc154; // @[Expression.scala 2301:18]
  assign rom_data_745 = 16'h2d44; // @[Expression.scala 2301:18]
  assign rom_data_746 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_747 = 16'ha005; // @[Expression.scala 2301:18]
  assign rom_data_748 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_749 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_750 = 16'h41f0; // @[Expression.scala 2301:18]
  assign rom_data_751 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_752 = 16'h0299; // @[Expression.scala 2301:18]
  assign rom_data_753 = 16'h8316; // @[Expression.scala 2301:18]
  assign rom_data_754 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_755 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_756 = 16'h4292; // @[Expression.scala 2301:18]
  assign rom_data_757 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_758 = 16'h9216; // @[Expression.scala 2301:18]
  assign rom_data_759 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_760 = 16'hc1f8; // @[Expression.scala 2301:18]
  assign rom_data_761 = 16'hc118; // @[Expression.scala 2301:18]
  assign rom_data_762 = 16'h2db0; // @[Expression.scala 2301:18]
  assign rom_data_763 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_764 = 16'h2de0; // @[Expression.scala 2301:18]
  assign rom_data_765 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_766 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_767 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_768 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_769 = 16'hc910; // @[Expression.scala 2301:18]
  assign rom_data_770 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_771 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_772 = 16'h2530; // @[Expression.scala 2301:18]
  assign rom_data_773 = 16'hc570; // @[Expression.scala 2301:18]
  assign rom_data_774 = 16'h34b5; // @[Expression.scala 2301:18]
  assign rom_data_775 = 16'h01e4; // @[Expression.scala 2301:18]
  assign rom_data_776 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_777 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_778 = 16'h2ea4; // @[Expression.scala 2301:18]
  assign rom_data_779 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_780 = 16'h2eb4; // @[Expression.scala 2301:18]
  assign rom_data_781 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_782 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_783 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_784 = 16'h2de4; // @[Expression.scala 2301:18]
  assign rom_data_785 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_786 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_787 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_788 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_789 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_790 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_791 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_792 = 16'h33a1; // @[Expression.scala 2301:18]
  assign rom_data_793 = 16'h0204; // @[Expression.scala 2301:18]
  assign rom_data_794 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_795 = 16'h0228; // @[Expression.scala 2301:18]
  assign rom_data_796 = 16'h3571; // @[Expression.scala 2301:18]
  assign rom_data_797 = 16'h0224; // @[Expression.scala 2301:18]
  assign rom_data_798 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_799 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_800 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_801 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_802 = 16'h12c1; // @[Expression.scala 2301:18]
  assign rom_data_803 = 16'h4292; // @[Expression.scala 2301:18]
  assign rom_data_804 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_805 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_806 = 16'hbe65; // @[Expression.scala 2301:18]
  assign rom_data_807 = 16'hbdd1; // @[Expression.scala 2301:18]
  assign rom_data_808 = 16'h0244; // @[Expression.scala 2301:18]
  assign rom_data_809 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_810 = 16'h0228; // @[Expression.scala 2301:18]
  assign rom_data_811 = 16'h3178; // @[Expression.scala 2301:18]
  assign rom_data_812 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_813 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_814 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_815 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_816 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_817 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_818 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_819 = 16'h2000; // @[Expression.scala 2301:18]
  assign rom_data_820 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_821 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_822 = 16'h127d; // @[Expression.scala 2301:18]
  assign rom_data_823 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_824 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_825 = 16'h1275; // @[Expression.scala 2301:18]
  assign rom_data_826 = 16'hc1b0; // @[Expression.scala 2301:18]
  assign rom_data_827 = 16'h2000; // @[Expression.scala 2301:18]
  assign rom_data_828 = 16'hc1d0; // @[Expression.scala 2301:18]
  assign rom_data_829 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_830 = 16'hc1f0; // @[Expression.scala 2301:18]
  assign rom_data_831 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_832 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_833 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_834 = 16'h12ed; // @[Expression.scala 2301:18]
  assign rom_data_835 = 16'h42a2; // @[Expression.scala 2301:18]
  assign rom_data_836 = 16'h12ed; // @[Expression.scala 2301:18]
  assign rom_data_837 = 16'h46a2; // @[Expression.scala 2301:18]
  assign rom_data_838 = 16'h12e9; // @[Expression.scala 2301:18]
  assign rom_data_839 = 16'h46da; // @[Expression.scala 2301:18]
  assign rom_data_840 = 16'h12f1; // @[Expression.scala 2301:18]
  assign rom_data_841 = 16'h46ea; // @[Expression.scala 2301:18]
  assign rom_data_842 = 16'ha1f1; // @[Expression.scala 2301:18]
  assign rom_data_843 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_844 = 16'h2fd0; // @[Expression.scala 2301:18]
  assign rom_data_845 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_846 = 16'h3000; // @[Expression.scala 2301:18]
  assign rom_data_847 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_848 = 16'h2f10; // @[Expression.scala 2301:18]
  assign rom_data_849 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_850 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_851 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_852 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_853 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_854 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_855 = 16'h4190; // @[Expression.scala 2301:18]
  assign rom_data_856 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_857 = 16'hc190; // @[Expression.scala 2301:18]
  assign rom_data_858 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_859 = 16'h41b4; // @[Expression.scala 2301:18]
  assign rom_data_860 = 16'h028d; // @[Expression.scala 2301:18]
  assign rom_data_861 = 16'h8316; // @[Expression.scala 2301:18]
  assign rom_data_862 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_863 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_864 = 16'he28d; // @[Expression.scala 2301:18]
  assign rom_data_865 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_866 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_867 = 16'hc138; // @[Expression.scala 2301:18]
  assign rom_data_868 = 16'hc1b8; // @[Expression.scala 2301:18]
  assign rom_data_869 = 16'h326d; // @[Expression.scala 2301:18]
  assign rom_data_870 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_871 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_872 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_873 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_874 = 16'h0264; // @[Expression.scala 2301:18]
  assign rom_data_875 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_876 = 16'hbf4d; // @[Expression.scala 2301:18]
  assign rom_data_877 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_878 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_879 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_880 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_881 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_882 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_883 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_884 = 16'h013c; // @[Expression.scala 2301:18]
  assign rom_data_885 = 16'h8f99; // @[Expression.scala 2301:18]
  assign rom_data_886 = 16'h829e; // @[Expression.scala 2301:18]
  assign rom_data_887 = 16'h0386; // @[Expression.scala 2301:18]
  assign rom_data_888 = 16'h9396; // @[Expression.scala 2301:18]
  assign rom_data_889 = 16'h3004; // @[Expression.scala 2301:18]
  assign rom_data_890 = 16'h921e; // @[Expression.scala 2301:18]
  assign rom_data_891 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_892 = 16'ha075; // @[Expression.scala 2301:18]
  assign rom_data_893 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_894 = 16'h0130; // @[Expression.scala 2301:18]
  assign rom_data_895 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_896 = 16'h3004; // @[Expression.scala 2301:18]
  assign rom_data_897 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_898 = 16'ha029; // @[Expression.scala 2301:18]
  assign rom_data_899 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_900 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_901 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_902 = 16'h0314; // @[Expression.scala 2301:18]
  assign rom_data_903 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_904 = 16'hc154; // @[Expression.scala 2301:18]
  assign rom_data_905 = 16'h3004; // @[Expression.scala 2301:18]
  assign rom_data_906 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_907 = 16'ha005; // @[Expression.scala 2301:18]
  assign rom_data_908 = 16'h0108; // @[Expression.scala 2301:18]
  assign rom_data_909 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_910 = 16'h41f0; // @[Expression.scala 2301:18]
  assign rom_data_911 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_912 = 16'h2530; // @[Expression.scala 2301:18]
  assign rom_data_913 = 16'h8e91; // @[Expression.scala 2301:18]
  assign rom_data_914 = 16'he28d; // @[Expression.scala 2301:18]
  assign rom_data_915 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_916 = 16'ha00d; // @[Expression.scala 2301:18]
  assign rom_data_917 = 16'h41f0; // @[Expression.scala 2301:18]
  assign rom_data_918 = 16'h020d; // @[Expression.scala 2301:18]
  assign rom_data_919 = 16'hc1f0; // @[Expression.scala 2301:18]
  assign rom_data_920 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_921 = 16'h3070; // @[Expression.scala 2301:18]
  assign rom_data_922 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_923 = 16'h30a0; // @[Expression.scala 2301:18]
  assign rom_data_924 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_925 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_926 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_927 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_928 = 16'hc910; // @[Expression.scala 2301:18]
  assign rom_data_929 = 16'h24d0; // @[Expression.scala 2301:18]
  assign rom_data_930 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_931 = 16'h2530; // @[Expression.scala 2301:18]
  assign rom_data_932 = 16'hc570; // @[Expression.scala 2301:18]
  assign rom_data_933 = 16'h3239; // @[Expression.scala 2301:18]
  assign rom_data_934 = 16'h0284; // @[Expression.scala 2301:18]
  assign rom_data_935 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_936 = 16'h0008; // @[Expression.scala 2301:18]
  assign rom_data_937 = 16'h3164; // @[Expression.scala 2301:18]
  assign rom_data_938 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_939 = 16'h3174; // @[Expression.scala 2301:18]
  assign rom_data_940 = 16'hc510; // @[Expression.scala 2301:18]
  assign rom_data_941 = 16'h200c; // @[Expression.scala 2301:18]
  assign rom_data_942 = 16'hc530; // @[Expression.scala 2301:18]
  assign rom_data_943 = 16'h30a4; // @[Expression.scala 2301:18]
  assign rom_data_944 = 16'hc150; // @[Expression.scala 2301:18]
  assign rom_data_945 = 16'h2004; // @[Expression.scala 2301:18]
  assign rom_data_946 = 16'hc550; // @[Expression.scala 2301:18]
  assign rom_data_947 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_948 = 16'hc110; // @[Expression.scala 2301:18]
  assign rom_data_949 = 16'h253c; // @[Expression.scala 2301:18]
  assign rom_data_950 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_951 = 16'h3125; // @[Expression.scala 2301:18]
  assign rom_data_952 = 16'h02a4; // @[Expression.scala 2301:18]
  assign rom_data_953 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_954 = 16'h0228; // @[Expression.scala 2301:18]
  assign rom_data_955 = 16'h32f5; // @[Expression.scala 2301:18]
  assign rom_data_956 = 16'h02c4; // @[Expression.scala 2301:18]
  assign rom_data_957 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_958 = 16'h02ac; // @[Expression.scala 2301:18]
  assign rom_data_959 = 16'h4590; // @[Expression.scala 2301:18]
  assign rom_data_960 = 16'h8292; // @[Expression.scala 2301:18]
  assign rom_data_961 = 16'h12c5; // @[Expression.scala 2301:18]
  assign rom_data_962 = 16'h52a6; // @[Expression.scala 2301:18]
  assign rom_data_963 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_964 = 16'hc590; // @[Expression.scala 2301:18]
  assign rom_data_965 = 16'hbde9; // @[Expression.scala 2301:18]
  assign rom_data_966 = 16'h02e4; // @[Expression.scala 2301:18]
  assign rom_data_967 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_968 = 16'h6011; // @[Expression.scala 2301:18]
  assign rom_data_969 = 16'h8812; // @[Expression.scala 2301:18]
  assign rom_data_970 = 16'h8892; // @[Expression.scala 2301:18]
  assign rom_data_971 = 16'h8912; // @[Expression.scala 2301:18]
  assign rom_data_972 = 16'h8992; // @[Expression.scala 2301:18]
  assign rom_data_973 = 16'h8a12; // @[Expression.scala 2301:18]
  assign rom_data_974 = 16'h8a92; // @[Expression.scala 2301:18]
  assign rom_data_975 = 16'h8b12; // @[Expression.scala 2301:18]
  assign rom_data_976 = 16'h8b92; // @[Expression.scala 2301:18]
  assign rom_data_977 = 16'h8c12; // @[Expression.scala 2301:18]
  assign rom_data_978 = 16'h8c92; // @[Expression.scala 2301:18]
  assign rom_data_979 = 16'h8d12; // @[Expression.scala 2301:18]
  assign rom_data_980 = 16'h8d92; // @[Expression.scala 2301:18]
  assign rom_data_981 = 16'h8e12; // @[Expression.scala 2301:18]
  assign rom_data_982 = 16'h8e92; // @[Expression.scala 2301:18]
  assign rom_data_983 = 16'h8f12; // @[Expression.scala 2301:18]
  assign rom_data_984 = 16'h8f92; // @[Expression.scala 2301:18]
  assign rom_data_985 = 16'h2404; // @[Expression.scala 2301:18]
  assign rom_data_986 = 16'h0222; // @[Expression.scala 2301:18]
  assign rom_data_987 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_988 = 16'h0222; // @[Expression.scala 2301:18]
  assign rom_data_989 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_990 = 16'h8612; // @[Expression.scala 2301:18]
  assign rom_data_991 = 16'h8692; // @[Expression.scala 2301:18]
  assign rom_data_992 = 16'h8712; // @[Expression.scala 2301:18]
  assign rom_data_993 = 16'h8792; // @[Expression.scala 2301:18]
  assign rom_data_994 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_995 = 16'h01f4; // @[Expression.scala 2301:18]
  assign rom_data_996 = 16'h4403; // @[Expression.scala 2301:18]
  assign rom_data_997 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_998 = 16'h021c; // @[Expression.scala 2301:18]
  assign rom_data_999 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_1000 = 16'h0fcb; // @[Expression.scala 2301:18]
  assign rom_data_1001 = 16'h0385; // @[Expression.scala 2301:18]
  assign rom_data_1002 = 16'h137d; // @[Expression.scala 2301:18]
  assign rom_data_1003 = 16'hff75; // @[Expression.scala 2301:18]
  assign rom_data_1004 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_1005 = 16'hfedd; // @[Expression.scala 2301:18]
  assign rom_data_1006 = 16'h317c; // @[Expression.scala 2301:18]
  assign rom_data_1007 = 16'h4403; // @[Expression.scala 2301:18]
  assign rom_data_1008 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_1009 = 16'h0214; // @[Expression.scala 2301:18]
  assign rom_data_1010 = 16'h83aa; // @[Expression.scala 2301:18]
  assign rom_data_1011 = 16'h1a47; // @[Expression.scala 2301:18]
  assign rom_data_1012 = 16'h1a17; // @[Expression.scala 2301:18]
  assign rom_data_1013 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_1014 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_1015 = 16'hfef1; // @[Expression.scala 2301:18]
  assign rom_data_1016 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_1017 = 16'h8803; // @[Expression.scala 2301:18]
  assign rom_data_1018 = 16'h0304; // @[Expression.scala 2301:18]
  assign rom_data_1019 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_1020 = 16'h31a4; // @[Expression.scala 2301:18]
  assign rom_data_1021 = 16'h4423; // @[Expression.scala 2301:18]
  assign rom_data_1022 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_1023 = 16'h4433; // @[Expression.scala 2301:18]
  assign rom_data_1024 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_1025 = 16'h4443; // @[Expression.scala 2301:18]
  assign rom_data_1026 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_1027 = 16'h4453; // @[Expression.scala 2301:18]
  assign rom_data_1028 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_1029 = 16'h0138; // @[Expression.scala 2301:18]
  assign rom_data_1030 = 16'h021c; // @[Expression.scala 2301:18]
  assign rom_data_1031 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_1032 = 16'h4403; // @[Expression.scala 2301:18]
  assign rom_data_1033 = 16'h3180; // @[Expression.scala 2301:18]
  assign rom_data_1034 = 16'h4413; // @[Expression.scala 2301:18]
  assign rom_data_1035 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_1036 = 16'h0e03; // @[Expression.scala 2301:18]
  assign rom_data_1037 = 16'h0385; // @[Expression.scala 2301:18]
  assign rom_data_1038 = 16'h137d; // @[Expression.scala 2301:18]
  assign rom_data_1039 = 16'hff6d; // @[Expression.scala 2301:18]
  assign rom_data_1040 = 16'h31b0; // @[Expression.scala 2301:18]
  assign rom_data_1041 = 16'h4403; // @[Expression.scala 2301:18]
  assign rom_data_1042 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_1043 = 16'h0134; // @[Expression.scala 2301:18]
  assign rom_data_1044 = 16'h83aa; // @[Expression.scala 2301:18]
  assign rom_data_1045 = 16'h1a47; // @[Expression.scala 2301:18]
  assign rom_data_1046 = 16'h1ffc; // @[Expression.scala 2301:18]
  assign rom_data_1047 = 16'h1a17; // @[Expression.scala 2301:18]
  assign rom_data_1048 = 16'h0dd3; // @[Expression.scala 2301:18]
  assign rom_data_1049 = 16'h001c; // @[Expression.scala 2301:18]
  assign rom_data_1050 = 16'h0dcf; // @[Expression.scala 2301:18]
  assign rom_data_1051 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_1052 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_1053 = 16'hfedd; // @[Expression.scala 2301:18]
  assign rom_data_1054 = 16'h23e0; // @[Expression.scala 2301:18]
  assign rom_data_1055 = 16'h8803; // @[Expression.scala 2301:18]
  assign rom_data_1056 = 16'h0324; // @[Expression.scala 2301:18]
  assign rom_data_1057 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_1058 = 16'h31b4; // @[Expression.scala 2301:18]
  assign rom_data_1059 = 16'h4403; // @[Expression.scala 2301:18]
  assign rom_data_1060 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_1061 = 16'h4413; // @[Expression.scala 2301:18]
  assign rom_data_1062 = 16'h8222; // @[Expression.scala 2301:18]
  assign rom_data_1063 = 16'h8625; // @[Expression.scala 2301:18]
  assign rom_data_1064 = 16'h0134; // @[Expression.scala 2301:18]
  assign rom_data_1065 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_1066 = 16'h001c; // @[Expression.scala 2301:18]
  assign rom_data_1067 = 16'h1a5b; // @[Expression.scala 2301:18]
  assign rom_data_1068 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1069 = 16'h2313; // @[Expression.scala 2301:18]
  assign rom_data_1070 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_1071 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_1072 = 16'hfeed; // @[Expression.scala 2301:18]
  assign rom_data_1073 = 16'h00ec; // @[Expression.scala 2301:18]
  assign rom_data_1074 = 16'h83c2; // @[Expression.scala 2301:18]
  assign rom_data_1075 = 16'h0238; // @[Expression.scala 2301:18]
  assign rom_data_1076 = 16'h0114; // @[Expression.scala 2301:18]
  assign rom_data_1077 = 16'h09a3; // @[Expression.scala 2301:18]
  assign rom_data_1078 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1079 = 16'h070f; // @[Expression.scala 2301:18]
  assign rom_data_1080 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_1081 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_1082 = 16'hfeed; // @[Expression.scala 2301:18]
  assign rom_data_1083 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_1084 = 16'h0134; // @[Expression.scala 2301:18]
  assign rom_data_1085 = 16'h19db; // @[Expression.scala 2301:18]
  assign rom_data_1086 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1087 = 16'h1ad7; // @[Expression.scala 2301:18]
  assign rom_data_1088 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1089 = 16'h0c0f; // @[Expression.scala 2301:18]
  assign rom_data_1090 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_1091 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_1092 = 16'hfee5; // @[Expression.scala 2301:18]
  assign rom_data_1093 = 16'h0348; // @[Expression.scala 2301:18]
  assign rom_data_1094 = 16'h0134; // @[Expression.scala 2301:18]
  assign rom_data_1095 = 16'h0218; // @[Expression.scala 2301:18]
  assign rom_data_1096 = 16'h000c; // @[Expression.scala 2301:18]
  assign rom_data_1097 = 16'h1a9b; // @[Expression.scala 2301:18]
  assign rom_data_1098 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1099 = 16'h09a3; // @[Expression.scala 2301:18]
  assign rom_data_1100 = 16'h420e; // @[Expression.scala 2301:18]
  assign rom_data_1101 = 16'h0185; // @[Expression.scala 2301:18]
  assign rom_data_1102 = 16'hbfed; // @[Expression.scala 2301:18]
  assign rom_data_1103 = 16'h035c; // @[Expression.scala 2301:18]
  assign rom_data_1104 = 16'hc38c; // @[Expression.scala 2301:18]
  assign rom_data_1105 = 16'h922a; // @[Expression.scala 2301:18]
  assign rom_data_1106 = 16'he211; // @[Expression.scala 2301:18]
  assign rom_data_1107 = 16'h8232; // @[Expression.scala 2301:18]
  assign rom_data_1108 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_1109 = 16'ha0ad; // @[Expression.scala 2301:18]
  assign rom_data_1110 = 16'h021e; // @[Expression.scala 2301:18]
  assign rom_data_1111 = 16'h8192; // @[Expression.scala 2301:18]
  assign rom_data_1112 = 16'h8432; // @[Expression.scala 2301:18]
  assign rom_data_1113 = 16'h9222; // @[Expression.scala 2301:18]
  assign rom_data_1114 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_1115 = 16'h03dc; // @[Expression.scala 2301:18]
  assign rom_data_1116 = 16'h848e; // @[Expression.scala 2301:18]
  assign rom_data_1117 = 16'h0130; // @[Expression.scala 2301:18]
  assign rom_data_1118 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1119 = 16'h2227; // @[Expression.scala 2301:18]
  assign rom_data_1120 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1121 = 16'h8226; // @[Expression.scala 2301:18]
  assign rom_data_1122 = 16'h8205; // @[Expression.scala 2301:18]
  assign rom_data_1123 = 16'h8412; // @[Expression.scala 2301:18]
  assign rom_data_1124 = 16'h4130; // @[Expression.scala 2301:18]
  assign rom_data_1125 = 16'h9222; // @[Expression.scala 2301:18]
  assign rom_data_1126 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_1127 = 16'h0130; // @[Expression.scala 2301:18]
  assign rom_data_1128 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1129 = 16'h220f; // @[Expression.scala 2301:18]
  assign rom_data_1130 = 16'h0170; // @[Expression.scala 2301:18]
  assign rom_data_1131 = 16'h85a6; // @[Expression.scala 2301:18]
  assign rom_data_1132 = 16'h223b; // @[Expression.scala 2301:18]
  assign rom_data_1133 = 16'h4130; // @[Expression.scala 2301:18]
  assign rom_data_1134 = 16'h922e; // @[Expression.scala 2301:18]
  assign rom_data_1135 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_1136 = 16'h0130; // @[Expression.scala 2301:18]
  assign rom_data_1137 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1138 = 16'h220f; // @[Expression.scala 2301:18]
  assign rom_data_1139 = 16'h0170; // @[Expression.scala 2301:18]
  assign rom_data_1140 = 16'h85a6; // @[Expression.scala 2301:18]
  assign rom_data_1141 = 16'h223f; // @[Expression.scala 2301:18]
  assign rom_data_1142 = 16'h4130; // @[Expression.scala 2301:18]
  assign rom_data_1143 = 16'h922e; // @[Expression.scala 2301:18]
  assign rom_data_1144 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_1145 = 16'h034c; // @[Expression.scala 2301:18]
  assign rom_data_1146 = 16'h4190; // @[Expression.scala 2301:18]
  assign rom_data_1147 = 16'h041c; // @[Expression.scala 2301:18]
  assign rom_data_1148 = 16'h8f91; // @[Expression.scala 2301:18]
  assign rom_data_1149 = 16'h4130; // @[Expression.scala 2301:18]
  assign rom_data_1150 = 16'h9e5d; // @[Expression.scala 2301:18]
  assign rom_data_1151 = 16'hc130; // @[Expression.scala 2301:18]
  assign rom_data_1152 = 16'h0105; // @[Expression.scala 2301:18]
  assign rom_data_1153 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_1154 = 16'h0305; // @[Expression.scala 2301:18]
  assign rom_data_1155 = 16'hc289; // @[Expression.scala 2301:18]
  assign rom_data_1156 = 16'hbf11; // @[Expression.scala 2301:18]
  assign rom_data_1157 = 16'h0348; // @[Expression.scala 2301:18]
  assign rom_data_1158 = 16'h0134; // @[Expression.scala 2301:18]
  assign rom_data_1159 = 16'h000c; // @[Expression.scala 2301:18]
  assign rom_data_1160 = 16'h4130; // @[Expression.scala 2301:18]
  assign rom_data_1161 = 16'h9192; // @[Expression.scala 2301:18]
  assign rom_data_1162 = 16'h0105; // @[Expression.scala 2301:18]
  assign rom_data_1163 = 16'h12fd; // @[Expression.scala 2301:18]
  assign rom_data_1164 = 16'hc289; // @[Expression.scala 2301:18]
  assign rom_data_1165 = 16'hbfed; // @[Expression.scala 2301:18]
  assign rom_data_1166 = 16'hc94c; // @[Expression.scala 2301:18]
  assign rom_data_1167 = 16'h0344; // @[Expression.scala 2301:18]
  assign rom_data_1168 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_1169 = 16'h0348; // @[Expression.scala 2301:18]
  assign rom_data_1170 = 16'h0014; // @[Expression.scala 2301:18]
  assign rom_data_1171 = 16'h4138; // @[Expression.scala 2301:18]
  assign rom_data_1172 = 16'h00cc; // @[Expression.scala 2301:18]
  assign rom_data_1173 = 16'h0020; // @[Expression.scala 2301:18]
  assign rom_data_1174 = 16'h0105; // @[Expression.scala 2301:18]
  assign rom_data_1175 = 16'h413c; // @[Expression.scala 2301:18]
  assign rom_data_1176 = 16'h821e; // @[Expression.scala 2301:18]
  assign rom_data_1177 = 16'h8f99; // @[Expression.scala 2301:18]
  assign rom_data_1178 = 16'h438e; // @[Expression.scala 2301:18]
  assign rom_data_1179 = 16'h8312; // @[Expression.scala 2301:18]
  assign rom_data_1180 = 16'h82a2; // @[Expression.scala 2301:18]
  assign rom_data_1181 = 16'h0105; // @[Expression.scala 2301:18]
  assign rom_data_1182 = 16'h0405; // @[Expression.scala 2301:18]
  assign rom_data_1183 = 16'h11fd; // @[Expression.scala 2301:18]
  assign rom_data_1184 = 16'hfdd9; // @[Expression.scala 2301:18]
  assign rom_data_1185 = 16'h04a8; // @[Expression.scala 2301:18]
  assign rom_data_1186 = 16'hc114; // @[Expression.scala 2301:18]
  assign rom_data_1187 = 16'hc138; // @[Expression.scala 2301:18]
  assign rom_data_1188 = 16'h8196; // @[Expression.scala 2301:18]
  assign rom_data_1189 = 16'h11e5; // @[Expression.scala 2301:18]
  assign rom_data_1190 = 16'h418a; // @[Expression.scala 2301:18]
  assign rom_data_1191 = 16'ha049; // @[Expression.scala 2301:18]
  assign rom_data_1192 = 16'h0568; // @[Expression.scala 2301:18]
  assign rom_data_1193 = 16'h9116; // @[Expression.scala 2301:18]
  assign rom_data_1194 = 16'h4110; // @[Expression.scala 2301:18]
  assign rom_data_1195 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_1196 = 16'h0348; // @[Expression.scala 2301:18]
  assign rom_data_1197 = 16'h494c; // @[Expression.scala 2301:18]
  assign rom_data_1198 = 16'h011c; // @[Expression.scala 2301:18]
  assign rom_data_1199 = 16'h0111; // @[Expression.scala 2301:18]
  assign rom_data_1200 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1201 = 16'h210f; // @[Expression.scala 2301:18]
  assign rom_data_1202 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1203 = 16'h8f11; // @[Expression.scala 2301:18]
  assign rom_data_1204 = 16'h430a; // @[Expression.scala 2301:18]
  assign rom_data_1205 = 16'ha011; // @[Expression.scala 2301:18]
  assign rom_data_1206 = 16'h00f4; // @[Expression.scala 2301:18]
  assign rom_data_1207 = 16'h04a8; // @[Expression.scala 2301:18]
  assign rom_data_1208 = 16'hc114; // @[Expression.scala 2301:18]
  assign rom_data_1209 = 16'h8196; // @[Expression.scala 2301:18]
  assign rom_data_1210 = 16'h11e5; // @[Expression.scala 2301:18]
  assign rom_data_1211 = 16'h418a; // @[Expression.scala 2301:18]
  assign rom_data_1212 = 16'ha021; // @[Expression.scala 2301:18]
  assign rom_data_1213 = 16'h04a8; // @[Expression.scala 2301:18]
  assign rom_data_1214 = 16'h4170; // @[Expression.scala 2301:18]
  assign rom_data_1215 = 16'h415c; // @[Expression.scala 2301:18]
  assign rom_data_1216 = 16'h8f95; // @[Expression.scala 2301:18]
  assign rom_data_1217 = 16'he389; // @[Expression.scala 2301:18]
  assign rom_data_1218 = 16'h0205; // @[Expression.scala 2301:18]
  assign rom_data_1219 = 16'h0030; // @[Expression.scala 2301:18]
  assign rom_data_1220 = 16'h0010; // @[Expression.scala 2301:18]
  assign rom_data_1221 = 16'hc170; // @[Expression.scala 2301:18]
  assign rom_data_1222 = 16'h0568; // @[Expression.scala 2301:18]
  assign rom_data_1223 = 16'h04ac; // @[Expression.scala 2301:18]
  assign rom_data_1224 = 16'he2a5; // @[Expression.scala 2301:18]
  assign rom_data_1225 = 16'h493c; // @[Expression.scala 2301:18]
  assign rom_data_1226 = 16'h8e1d; // @[Expression.scala 2301:18]
  assign rom_data_1227 = 16'he239; // @[Expression.scala 2301:18]
  assign rom_data_1228 = 16'hc5b4; // @[Expression.scala 2301:18]
  assign rom_data_1229 = 16'h457c; // @[Expression.scala 2301:18]
  assign rom_data_1230 = 16'hc59c; // @[Expression.scala 2301:18]
  assign rom_data_1231 = 16'h001c; // @[Expression.scala 2301:18]
  assign rom_data_1232 = 16'hc1fc; // @[Expression.scala 2301:18]
  assign rom_data_1233 = 16'h495c; // @[Expression.scala 2301:18]
  assign rom_data_1234 = 16'h8e1d; // @[Expression.scala 2301:18]
  assign rom_data_1235 = 16'he219; // @[Expression.scala 2301:18]
  assign rom_data_1236 = 16'hc5b4; // @[Expression.scala 2301:18]
  assign rom_data_1237 = 16'h491c; // @[Expression.scala 2301:18]
  assign rom_data_1238 = 16'hc59c; // @[Expression.scala 2301:18]
  assign rom_data_1239 = 16'h001c; // @[Expression.scala 2301:18]
  assign rom_data_1240 = 16'hc1fc; // @[Expression.scala 2301:18]
  assign rom_data_1241 = 16'hc1d4; // @[Expression.scala 2301:18]
  assign rom_data_1242 = 16'h0364; // @[Expression.scala 2301:18]
  assign rom_data_1243 = 16'h0004; // @[Expression.scala 2301:18]
  assign rom_data_1244 = 16'h107d; // @[Expression.scala 2301:18]
  assign rom_data_1245 = 16'h9002; // @[Expression.scala 2301:18]
  assign rom_0 = rom_data_0; // @[irom.scala 32:12]
  assign rom_1 = rom_data_1; // @[irom.scala 32:12]
  assign rom_2 = rom_data_2; // @[irom.scala 32:12]
  assign rom_3 = rom_data_3; // @[irom.scala 32:12]
  assign rom_4 = rom_data_4; // @[irom.scala 32:12]
  assign rom_5 = rom_data_5; // @[irom.scala 32:12]
  assign rom_6 = rom_data_6; // @[irom.scala 32:12]
  assign rom_7 = rom_data_7; // @[irom.scala 32:12]
  assign rom_8 = rom_data_8; // @[irom.scala 32:12]
  assign rom_9 = rom_data_9; // @[irom.scala 32:12]
  assign rom_10 = rom_data_10; // @[irom.scala 32:12]
  assign rom_11 = rom_data_11; // @[irom.scala 32:12]
  assign rom_12 = rom_data_12; // @[irom.scala 32:12]
  assign rom_13 = rom_data_13; // @[irom.scala 32:12]
  assign rom_14 = rom_data_14; // @[irom.scala 32:12]
  assign rom_15 = rom_data_15; // @[irom.scala 32:12]
  assign rom_16 = rom_data_16; // @[irom.scala 32:12]
  assign rom_17 = rom_data_17; // @[irom.scala 32:12]
  assign rom_18 = rom_data_18; // @[irom.scala 32:12]
  assign rom_19 = rom_data_19; // @[irom.scala 32:12]
  assign rom_20 = rom_data_20; // @[irom.scala 32:12]
  assign rom_21 = rom_data_21; // @[irom.scala 32:12]
  assign rom_22 = rom_data_22; // @[irom.scala 32:12]
  assign rom_23 = rom_data_23; // @[irom.scala 32:12]
  assign rom_24 = rom_data_24; // @[irom.scala 32:12]
  assign rom_25 = rom_data_25; // @[irom.scala 32:12]
  assign rom_26 = rom_data_26; // @[irom.scala 32:12]
  assign rom_27 = rom_data_27; // @[irom.scala 32:12]
  assign rom_28 = rom_data_28; // @[irom.scala 32:12]
  assign rom_29 = rom_data_29; // @[irom.scala 32:12]
  assign rom_30 = rom_data_30; // @[irom.scala 32:12]
  assign rom_31 = rom_data_31; // @[irom.scala 32:12]
  assign rom_32 = rom_data_32; // @[irom.scala 32:12]
  assign rom_33 = rom_data_33; // @[irom.scala 32:12]
  assign rom_34 = rom_data_34; // @[irom.scala 32:12]
  assign rom_35 = rom_data_35; // @[irom.scala 32:12]
  assign rom_36 = rom_data_36; // @[irom.scala 32:12]
  assign rom_37 = rom_data_37; // @[irom.scala 32:12]
  assign rom_38 = rom_data_38; // @[irom.scala 32:12]
  assign rom_39 = rom_data_39; // @[irom.scala 32:12]
  assign rom_40 = rom_data_40; // @[irom.scala 32:12]
  assign rom_41 = rom_data_41; // @[irom.scala 32:12]
  assign rom_42 = rom_data_42; // @[irom.scala 32:12]
  assign rom_43 = rom_data_43; // @[irom.scala 32:12]
  assign rom_44 = rom_data_44; // @[irom.scala 32:12]
  assign rom_45 = rom_data_45; // @[irom.scala 32:12]
  assign rom_46 = rom_data_46; // @[irom.scala 32:12]
  assign rom_47 = rom_data_47; // @[irom.scala 32:12]
  assign rom_48 = rom_data_48; // @[irom.scala 32:12]
  assign rom_49 = rom_data_49; // @[irom.scala 32:12]
  assign rom_50 = rom_data_50; // @[irom.scala 32:12]
  assign rom_51 = rom_data_51; // @[irom.scala 32:12]
  assign rom_52 = rom_data_52; // @[irom.scala 32:12]
  assign rom_53 = rom_data_53; // @[irom.scala 32:12]
  assign rom_54 = rom_data_54; // @[irom.scala 32:12]
  assign rom_55 = rom_data_55; // @[irom.scala 32:12]
  assign rom_56 = rom_data_56; // @[irom.scala 32:12]
  assign rom_57 = rom_data_57; // @[irom.scala 32:12]
  assign rom_58 = rom_data_58; // @[irom.scala 32:12]
  assign rom_59 = rom_data_59; // @[irom.scala 32:12]
  assign rom_60 = rom_data_60; // @[irom.scala 32:12]
  assign rom_61 = rom_data_61; // @[irom.scala 32:12]
  assign rom_62 = rom_data_62; // @[irom.scala 32:12]
  assign rom_63 = rom_data_63; // @[irom.scala 32:12]
  assign rom_64 = rom_data_64; // @[irom.scala 32:12]
  assign rom_65 = rom_data_65; // @[irom.scala 32:12]
  assign rom_66 = rom_data_66; // @[irom.scala 32:12]
  assign rom_67 = rom_data_67; // @[irom.scala 32:12]
  assign rom_68 = rom_data_68; // @[irom.scala 32:12]
  assign rom_69 = rom_data_69; // @[irom.scala 32:12]
  assign rom_70 = rom_data_70; // @[irom.scala 32:12]
  assign rom_71 = rom_data_71; // @[irom.scala 32:12]
  assign rom_72 = rom_data_72; // @[irom.scala 32:12]
  assign rom_73 = rom_data_73; // @[irom.scala 32:12]
  assign rom_74 = rom_data_74; // @[irom.scala 32:12]
  assign rom_75 = rom_data_75; // @[irom.scala 32:12]
  assign rom_76 = rom_data_76; // @[irom.scala 32:12]
  assign rom_77 = rom_data_77; // @[irom.scala 32:12]
  assign rom_78 = rom_data_78; // @[irom.scala 32:12]
  assign rom_79 = rom_data_79; // @[irom.scala 32:12]
  assign rom_80 = rom_data_80; // @[irom.scala 32:12]
  assign rom_81 = rom_data_81; // @[irom.scala 32:12]
  assign rom_82 = rom_data_82; // @[irom.scala 32:12]
  assign rom_83 = rom_data_83; // @[irom.scala 32:12]
  assign rom_84 = rom_data_84; // @[irom.scala 32:12]
  assign rom_85 = rom_data_85; // @[irom.scala 32:12]
  assign rom_86 = rom_data_86; // @[irom.scala 32:12]
  assign rom_87 = rom_data_87; // @[irom.scala 32:12]
  assign rom_88 = rom_data_88; // @[irom.scala 32:12]
  assign rom_89 = rom_data_89; // @[irom.scala 32:12]
  assign rom_90 = rom_data_90; // @[irom.scala 32:12]
  assign rom_91 = rom_data_91; // @[irom.scala 32:12]
  assign rom_92 = rom_data_92; // @[irom.scala 32:12]
  assign rom_93 = rom_data_93; // @[irom.scala 32:12]
  assign rom_94 = rom_data_94; // @[irom.scala 32:12]
  assign rom_95 = rom_data_95; // @[irom.scala 32:12]
  assign rom_96 = rom_data_96; // @[irom.scala 32:12]
  assign rom_97 = rom_data_97; // @[irom.scala 32:12]
  assign rom_98 = rom_data_98; // @[irom.scala 32:12]
  assign rom_99 = rom_data_99; // @[irom.scala 32:12]
  assign rom_100 = rom_data_100; // @[irom.scala 32:12]
  assign rom_101 = rom_data_101; // @[irom.scala 32:12]
  assign rom_102 = rom_data_102; // @[irom.scala 32:12]
  assign rom_103 = rom_data_103; // @[irom.scala 32:12]
  assign rom_104 = rom_data_104; // @[irom.scala 32:12]
  assign rom_105 = rom_data_105; // @[irom.scala 32:12]
  assign rom_106 = rom_data_106; // @[irom.scala 32:12]
  assign rom_107 = rom_data_107; // @[irom.scala 32:12]
  assign rom_108 = rom_data_108; // @[irom.scala 32:12]
  assign rom_109 = rom_data_109; // @[irom.scala 32:12]
  assign rom_110 = rom_data_110; // @[irom.scala 32:12]
  assign rom_111 = rom_data_111; // @[irom.scala 32:12]
  assign rom_112 = rom_data_112; // @[irom.scala 32:12]
  assign rom_113 = rom_data_113; // @[irom.scala 32:12]
  assign rom_114 = rom_data_114; // @[irom.scala 32:12]
  assign rom_115 = rom_data_115; // @[irom.scala 32:12]
  assign rom_116 = rom_data_116; // @[irom.scala 32:12]
  assign rom_117 = rom_data_117; // @[irom.scala 32:12]
  assign rom_118 = rom_data_118; // @[irom.scala 32:12]
  assign rom_119 = rom_data_119; // @[irom.scala 32:12]
  assign rom_120 = rom_data_120; // @[irom.scala 32:12]
  assign rom_121 = rom_data_121; // @[irom.scala 32:12]
  assign rom_122 = rom_data_122; // @[irom.scala 32:12]
  assign rom_123 = rom_data_123; // @[irom.scala 32:12]
  assign rom_124 = rom_data_124; // @[irom.scala 32:12]
  assign rom_125 = rom_data_125; // @[irom.scala 32:12]
  assign rom_126 = rom_data_126; // @[irom.scala 32:12]
  assign rom_127 = rom_data_127; // @[irom.scala 32:12]
  assign rom_128 = rom_data_128; // @[irom.scala 32:12]
  assign rom_129 = rom_data_129; // @[irom.scala 32:12]
  assign rom_130 = rom_data_130; // @[irom.scala 32:12]
  assign rom_131 = rom_data_131; // @[irom.scala 32:12]
  assign rom_132 = rom_data_132; // @[irom.scala 32:12]
  assign rom_133 = rom_data_133; // @[irom.scala 32:12]
  assign rom_134 = rom_data_134; // @[irom.scala 32:12]
  assign rom_135 = rom_data_135; // @[irom.scala 32:12]
  assign rom_136 = rom_data_136; // @[irom.scala 32:12]
  assign rom_137 = rom_data_137; // @[irom.scala 32:12]
  assign rom_138 = rom_data_138; // @[irom.scala 32:12]
  assign rom_139 = rom_data_139; // @[irom.scala 32:12]
  assign rom_140 = rom_data_140; // @[irom.scala 32:12]
  assign rom_141 = rom_data_141; // @[irom.scala 32:12]
  assign rom_142 = rom_data_142; // @[irom.scala 32:12]
  assign rom_143 = rom_data_143; // @[irom.scala 32:12]
  assign rom_144 = rom_data_144; // @[irom.scala 32:12]
  assign rom_145 = rom_data_145; // @[irom.scala 32:12]
  assign rom_146 = rom_data_146; // @[irom.scala 32:12]
  assign rom_147 = rom_data_147; // @[irom.scala 32:12]
  assign rom_148 = rom_data_148; // @[irom.scala 32:12]
  assign rom_149 = rom_data_149; // @[irom.scala 32:12]
  assign rom_150 = rom_data_150; // @[irom.scala 32:12]
  assign rom_151 = rom_data_151; // @[irom.scala 32:12]
  assign rom_152 = rom_data_152; // @[irom.scala 32:12]
  assign rom_153 = rom_data_153; // @[irom.scala 32:12]
  assign rom_154 = rom_data_154; // @[irom.scala 32:12]
  assign rom_155 = rom_data_155; // @[irom.scala 32:12]
  assign rom_156 = rom_data_156; // @[irom.scala 32:12]
  assign rom_157 = rom_data_157; // @[irom.scala 32:12]
  assign rom_158 = rom_data_158; // @[irom.scala 32:12]
  assign rom_159 = rom_data_159; // @[irom.scala 32:12]
  assign rom_160 = rom_data_160; // @[irom.scala 32:12]
  assign rom_161 = rom_data_161; // @[irom.scala 32:12]
  assign rom_162 = rom_data_162; // @[irom.scala 32:12]
  assign rom_163 = rom_data_163; // @[irom.scala 32:12]
  assign rom_164 = rom_data_164; // @[irom.scala 32:12]
  assign rom_165 = rom_data_165; // @[irom.scala 32:12]
  assign rom_166 = rom_data_166; // @[irom.scala 32:12]
  assign rom_167 = rom_data_167; // @[irom.scala 32:12]
  assign rom_168 = rom_data_168; // @[irom.scala 32:12]
  assign rom_169 = rom_data_169; // @[irom.scala 32:12]
  assign rom_170 = rom_data_170; // @[irom.scala 32:12]
  assign rom_171 = rom_data_171; // @[irom.scala 32:12]
  assign rom_172 = rom_data_172; // @[irom.scala 32:12]
  assign rom_173 = rom_data_173; // @[irom.scala 32:12]
  assign rom_174 = rom_data_174; // @[irom.scala 32:12]
  assign rom_175 = rom_data_175; // @[irom.scala 32:12]
  assign rom_176 = rom_data_176; // @[irom.scala 32:12]
  assign rom_177 = rom_data_177; // @[irom.scala 32:12]
  assign rom_178 = rom_data_178; // @[irom.scala 32:12]
  assign rom_179 = rom_data_179; // @[irom.scala 32:12]
  assign rom_180 = rom_data_180; // @[irom.scala 32:12]
  assign rom_181 = rom_data_181; // @[irom.scala 32:12]
  assign rom_182 = rom_data_182; // @[irom.scala 32:12]
  assign rom_183 = rom_data_183; // @[irom.scala 32:12]
  assign rom_184 = rom_data_184; // @[irom.scala 32:12]
  assign rom_185 = rom_data_185; // @[irom.scala 32:12]
  assign rom_186 = rom_data_186; // @[irom.scala 32:12]
  assign rom_187 = rom_data_187; // @[irom.scala 32:12]
  assign rom_188 = rom_data_188; // @[irom.scala 32:12]
  assign rom_189 = rom_data_189; // @[irom.scala 32:12]
  assign rom_190 = rom_data_190; // @[irom.scala 32:12]
  assign rom_191 = rom_data_191; // @[irom.scala 32:12]
  assign rom_192 = rom_data_192; // @[irom.scala 32:12]
  assign rom_193 = rom_data_193; // @[irom.scala 32:12]
  assign rom_194 = rom_data_194; // @[irom.scala 32:12]
  assign rom_195 = rom_data_195; // @[irom.scala 32:12]
  assign rom_196 = rom_data_196; // @[irom.scala 32:12]
  assign rom_197 = rom_data_197; // @[irom.scala 32:12]
  assign rom_198 = rom_data_198; // @[irom.scala 32:12]
  assign rom_199 = rom_data_199; // @[irom.scala 32:12]
  assign rom_200 = rom_data_200; // @[irom.scala 32:12]
  assign rom_201 = rom_data_201; // @[irom.scala 32:12]
  assign rom_202 = rom_data_202; // @[irom.scala 32:12]
  assign rom_203 = rom_data_203; // @[irom.scala 32:12]
  assign rom_204 = rom_data_204; // @[irom.scala 32:12]
  assign rom_205 = rom_data_205; // @[irom.scala 32:12]
  assign rom_206 = rom_data_206; // @[irom.scala 32:12]
  assign rom_207 = rom_data_207; // @[irom.scala 32:12]
  assign rom_208 = rom_data_208; // @[irom.scala 32:12]
  assign rom_209 = rom_data_209; // @[irom.scala 32:12]
  assign rom_210 = rom_data_210; // @[irom.scala 32:12]
  assign rom_211 = rom_data_211; // @[irom.scala 32:12]
  assign rom_212 = rom_data_212; // @[irom.scala 32:12]
  assign rom_213 = rom_data_213; // @[irom.scala 32:12]
  assign rom_214 = rom_data_214; // @[irom.scala 32:12]
  assign rom_215 = rom_data_215; // @[irom.scala 32:12]
  assign rom_216 = rom_data_216; // @[irom.scala 32:12]
  assign rom_217 = rom_data_217; // @[irom.scala 32:12]
  assign rom_218 = rom_data_218; // @[irom.scala 32:12]
  assign rom_219 = rom_data_219; // @[irom.scala 32:12]
  assign rom_220 = rom_data_220; // @[irom.scala 32:12]
  assign rom_221 = rom_data_221; // @[irom.scala 32:12]
  assign rom_222 = rom_data_222; // @[irom.scala 32:12]
  assign rom_223 = rom_data_223; // @[irom.scala 32:12]
  assign rom_224 = rom_data_224; // @[irom.scala 32:12]
  assign rom_225 = rom_data_225; // @[irom.scala 32:12]
  assign rom_226 = rom_data_226; // @[irom.scala 32:12]
  assign rom_227 = rom_data_227; // @[irom.scala 32:12]
  assign rom_228 = rom_data_228; // @[irom.scala 32:12]
  assign rom_229 = rom_data_229; // @[irom.scala 32:12]
  assign rom_230 = rom_data_230; // @[irom.scala 32:12]
  assign rom_231 = rom_data_231; // @[irom.scala 32:12]
  assign rom_232 = rom_data_232; // @[irom.scala 32:12]
  assign rom_233 = rom_data_233; // @[irom.scala 32:12]
  assign rom_234 = rom_data_234; // @[irom.scala 32:12]
  assign rom_235 = rom_data_235; // @[irom.scala 32:12]
  assign rom_236 = rom_data_236; // @[irom.scala 32:12]
  assign rom_237 = rom_data_237; // @[irom.scala 32:12]
  assign rom_238 = rom_data_238; // @[irom.scala 32:12]
  assign rom_239 = rom_data_239; // @[irom.scala 32:12]
  assign rom_240 = rom_data_240; // @[irom.scala 32:12]
  assign rom_241 = rom_data_241; // @[irom.scala 32:12]
  assign rom_242 = rom_data_242; // @[irom.scala 32:12]
  assign rom_243 = rom_data_243; // @[irom.scala 32:12]
  assign rom_244 = rom_data_244; // @[irom.scala 32:12]
  assign rom_245 = rom_data_245; // @[irom.scala 32:12]
  assign rom_246 = rom_data_246; // @[irom.scala 32:12]
  assign rom_247 = rom_data_247; // @[irom.scala 32:12]
  assign rom_248 = rom_data_248; // @[irom.scala 32:12]
  assign rom_249 = rom_data_249; // @[irom.scala 32:12]
  assign rom_250 = rom_data_250; // @[irom.scala 32:12]
  assign rom_251 = rom_data_251; // @[irom.scala 32:12]
  assign rom_252 = rom_data_252; // @[irom.scala 32:12]
  assign rom_253 = rom_data_253; // @[irom.scala 32:12]
  assign rom_254 = rom_data_254; // @[irom.scala 32:12]
  assign rom_255 = rom_data_255; // @[irom.scala 32:12]
  assign rom_256 = rom_data_256; // @[irom.scala 32:12]
  assign rom_257 = rom_data_257; // @[irom.scala 32:12]
  assign rom_258 = rom_data_258; // @[irom.scala 32:12]
  assign rom_259 = rom_data_259; // @[irom.scala 32:12]
  assign rom_260 = rom_data_260; // @[irom.scala 32:12]
  assign rom_261 = rom_data_261; // @[irom.scala 32:12]
  assign rom_262 = rom_data_262; // @[irom.scala 32:12]
  assign rom_263 = rom_data_263; // @[irom.scala 32:12]
  assign rom_264 = rom_data_264; // @[irom.scala 32:12]
  assign rom_265 = rom_data_265; // @[irom.scala 32:12]
  assign rom_266 = rom_data_266; // @[irom.scala 32:12]
  assign rom_267 = rom_data_267; // @[irom.scala 32:12]
  assign rom_268 = rom_data_268; // @[irom.scala 32:12]
  assign rom_269 = rom_data_269; // @[irom.scala 32:12]
  assign rom_270 = rom_data_270; // @[irom.scala 32:12]
  assign rom_271 = rom_data_271; // @[irom.scala 32:12]
  assign rom_272 = rom_data_272; // @[irom.scala 32:12]
  assign rom_273 = rom_data_273; // @[irom.scala 32:12]
  assign rom_274 = rom_data_274; // @[irom.scala 32:12]
  assign rom_275 = rom_data_275; // @[irom.scala 32:12]
  assign rom_276 = rom_data_276; // @[irom.scala 32:12]
  assign rom_277 = rom_data_277; // @[irom.scala 32:12]
  assign rom_278 = rom_data_278; // @[irom.scala 32:12]
  assign rom_279 = rom_data_279; // @[irom.scala 32:12]
  assign rom_280 = rom_data_280; // @[irom.scala 32:12]
  assign rom_281 = rom_data_281; // @[irom.scala 32:12]
  assign rom_282 = rom_data_282; // @[irom.scala 32:12]
  assign rom_283 = rom_data_283; // @[irom.scala 32:12]
  assign rom_284 = rom_data_284; // @[irom.scala 32:12]
  assign rom_285 = rom_data_285; // @[irom.scala 32:12]
  assign rom_286 = rom_data_286; // @[irom.scala 32:12]
  assign rom_287 = rom_data_287; // @[irom.scala 32:12]
  assign rom_288 = rom_data_288; // @[irom.scala 32:12]
  assign rom_289 = rom_data_289; // @[irom.scala 32:12]
  assign rom_290 = rom_data_290; // @[irom.scala 32:12]
  assign rom_291 = rom_data_291; // @[irom.scala 32:12]
  assign rom_292 = rom_data_292; // @[irom.scala 32:12]
  assign rom_293 = rom_data_293; // @[irom.scala 32:12]
  assign rom_294 = rom_data_294; // @[irom.scala 32:12]
  assign rom_295 = rom_data_295; // @[irom.scala 32:12]
  assign rom_296 = rom_data_296; // @[irom.scala 32:12]
  assign rom_297 = rom_data_297; // @[irom.scala 32:12]
  assign rom_298 = rom_data_298; // @[irom.scala 32:12]
  assign rom_299 = rom_data_299; // @[irom.scala 32:12]
  assign rom_300 = rom_data_300; // @[irom.scala 32:12]
  assign rom_301 = rom_data_301; // @[irom.scala 32:12]
  assign rom_302 = rom_data_302; // @[irom.scala 32:12]
  assign rom_303 = rom_data_303; // @[irom.scala 32:12]
  assign rom_304 = rom_data_304; // @[irom.scala 32:12]
  assign rom_305 = rom_data_305; // @[irom.scala 32:12]
  assign rom_306 = rom_data_306; // @[irom.scala 32:12]
  assign rom_307 = rom_data_307; // @[irom.scala 32:12]
  assign rom_308 = rom_data_308; // @[irom.scala 32:12]
  assign rom_309 = rom_data_309; // @[irom.scala 32:12]
  assign rom_310 = rom_data_310; // @[irom.scala 32:12]
  assign rom_311 = rom_data_311; // @[irom.scala 32:12]
  assign rom_312 = rom_data_312; // @[irom.scala 32:12]
  assign rom_313 = rom_data_313; // @[irom.scala 32:12]
  assign rom_314 = rom_data_314; // @[irom.scala 32:12]
  assign rom_315 = rom_data_315; // @[irom.scala 32:12]
  assign rom_316 = rom_data_316; // @[irom.scala 32:12]
  assign rom_317 = rom_data_317; // @[irom.scala 32:12]
  assign rom_318 = rom_data_318; // @[irom.scala 32:12]
  assign rom_319 = rom_data_319; // @[irom.scala 32:12]
  assign rom_320 = rom_data_320; // @[irom.scala 32:12]
  assign rom_321 = rom_data_321; // @[irom.scala 32:12]
  assign rom_322 = rom_data_322; // @[irom.scala 32:12]
  assign rom_323 = rom_data_323; // @[irom.scala 32:12]
  assign rom_324 = rom_data_324; // @[irom.scala 32:12]
  assign rom_325 = rom_data_325; // @[irom.scala 32:12]
  assign rom_326 = rom_data_326; // @[irom.scala 32:12]
  assign rom_327 = rom_data_327; // @[irom.scala 32:12]
  assign rom_328 = rom_data_328; // @[irom.scala 32:12]
  assign rom_329 = rom_data_329; // @[irom.scala 32:12]
  assign rom_330 = rom_data_330; // @[irom.scala 32:12]
  assign rom_331 = rom_data_331; // @[irom.scala 32:12]
  assign rom_332 = rom_data_332; // @[irom.scala 32:12]
  assign rom_333 = rom_data_333; // @[irom.scala 32:12]
  assign rom_334 = rom_data_334; // @[irom.scala 32:12]
  assign rom_335 = rom_data_335; // @[irom.scala 32:12]
  assign rom_336 = rom_data_336; // @[irom.scala 32:12]
  assign rom_337 = rom_data_337; // @[irom.scala 32:12]
  assign rom_338 = rom_data_338; // @[irom.scala 32:12]
  assign rom_339 = rom_data_339; // @[irom.scala 32:12]
  assign rom_340 = rom_data_340; // @[irom.scala 32:12]
  assign rom_341 = rom_data_341; // @[irom.scala 32:12]
  assign rom_342 = rom_data_342; // @[irom.scala 32:12]
  assign rom_343 = rom_data_343; // @[irom.scala 32:12]
  assign rom_344 = rom_data_344; // @[irom.scala 32:12]
  assign rom_345 = rom_data_345; // @[irom.scala 32:12]
  assign rom_346 = rom_data_346; // @[irom.scala 32:12]
  assign rom_347 = rom_data_347; // @[irom.scala 32:12]
  assign rom_348 = rom_data_348; // @[irom.scala 32:12]
  assign rom_349 = rom_data_349; // @[irom.scala 32:12]
  assign rom_350 = rom_data_350; // @[irom.scala 32:12]
  assign rom_351 = rom_data_351; // @[irom.scala 32:12]
  assign rom_352 = rom_data_352; // @[irom.scala 32:12]
  assign rom_353 = rom_data_353; // @[irom.scala 32:12]
  assign rom_354 = rom_data_354; // @[irom.scala 32:12]
  assign rom_355 = rom_data_355; // @[irom.scala 32:12]
  assign rom_356 = rom_data_356; // @[irom.scala 32:12]
  assign rom_357 = rom_data_357; // @[irom.scala 32:12]
  assign rom_358 = rom_data_358; // @[irom.scala 32:12]
  assign rom_359 = rom_data_359; // @[irom.scala 32:12]
  assign rom_360 = rom_data_360; // @[irom.scala 32:12]
  assign rom_361 = rom_data_361; // @[irom.scala 32:12]
  assign rom_362 = rom_data_362; // @[irom.scala 32:12]
  assign rom_363 = rom_data_363; // @[irom.scala 32:12]
  assign rom_364 = rom_data_364; // @[irom.scala 32:12]
  assign rom_365 = rom_data_365; // @[irom.scala 32:12]
  assign rom_366 = rom_data_366; // @[irom.scala 32:12]
  assign rom_367 = rom_data_367; // @[irom.scala 32:12]
  assign rom_368 = rom_data_368; // @[irom.scala 32:12]
  assign rom_369 = rom_data_369; // @[irom.scala 32:12]
  assign rom_370 = rom_data_370; // @[irom.scala 32:12]
  assign rom_371 = rom_data_371; // @[irom.scala 32:12]
  assign rom_372 = rom_data_372; // @[irom.scala 32:12]
  assign rom_373 = rom_data_373; // @[irom.scala 32:12]
  assign rom_374 = rom_data_374; // @[irom.scala 32:12]
  assign rom_375 = rom_data_375; // @[irom.scala 32:12]
  assign rom_376 = rom_data_376; // @[irom.scala 32:12]
  assign rom_377 = rom_data_377; // @[irom.scala 32:12]
  assign rom_378 = rom_data_378; // @[irom.scala 32:12]
  assign rom_379 = rom_data_379; // @[irom.scala 32:12]
  assign rom_380 = rom_data_380; // @[irom.scala 32:12]
  assign rom_381 = rom_data_381; // @[irom.scala 32:12]
  assign rom_382 = rom_data_382; // @[irom.scala 32:12]
  assign rom_383 = rom_data_383; // @[irom.scala 32:12]
  assign rom_384 = rom_data_384; // @[irom.scala 32:12]
  assign rom_385 = rom_data_385; // @[irom.scala 32:12]
  assign rom_386 = rom_data_386; // @[irom.scala 32:12]
  assign rom_387 = rom_data_387; // @[irom.scala 32:12]
  assign rom_388 = rom_data_388; // @[irom.scala 32:12]
  assign rom_389 = rom_data_389; // @[irom.scala 32:12]
  assign rom_390 = rom_data_390; // @[irom.scala 32:12]
  assign rom_391 = rom_data_391; // @[irom.scala 32:12]
  assign rom_392 = rom_data_392; // @[irom.scala 32:12]
  assign rom_393 = rom_data_393; // @[irom.scala 32:12]
  assign rom_394 = rom_data_394; // @[irom.scala 32:12]
  assign rom_395 = rom_data_395; // @[irom.scala 32:12]
  assign rom_396 = rom_data_396; // @[irom.scala 32:12]
  assign rom_397 = rom_data_397; // @[irom.scala 32:12]
  assign rom_398 = rom_data_398; // @[irom.scala 32:12]
  assign rom_399 = rom_data_399; // @[irom.scala 32:12]
  assign rom_400 = rom_data_400; // @[irom.scala 32:12]
  assign rom_401 = rom_data_401; // @[irom.scala 32:12]
  assign rom_402 = rom_data_402; // @[irom.scala 32:12]
  assign rom_403 = rom_data_403; // @[irom.scala 32:12]
  assign rom_404 = rom_data_404; // @[irom.scala 32:12]
  assign rom_405 = rom_data_405; // @[irom.scala 32:12]
  assign rom_406 = rom_data_406; // @[irom.scala 32:12]
  assign rom_407 = rom_data_407; // @[irom.scala 32:12]
  assign rom_408 = rom_data_408; // @[irom.scala 32:12]
  assign rom_409 = rom_data_409; // @[irom.scala 32:12]
  assign rom_410 = rom_data_410; // @[irom.scala 32:12]
  assign rom_411 = rom_data_411; // @[irom.scala 32:12]
  assign rom_412 = rom_data_412; // @[irom.scala 32:12]
  assign rom_413 = rom_data_413; // @[irom.scala 32:12]
  assign rom_414 = rom_data_414; // @[irom.scala 32:12]
  assign rom_415 = rom_data_415; // @[irom.scala 32:12]
  assign rom_416 = rom_data_416; // @[irom.scala 32:12]
  assign rom_417 = rom_data_417; // @[irom.scala 32:12]
  assign rom_418 = rom_data_418; // @[irom.scala 32:12]
  assign rom_419 = rom_data_419; // @[irom.scala 32:12]
  assign rom_420 = rom_data_420; // @[irom.scala 32:12]
  assign rom_421 = rom_data_421; // @[irom.scala 32:12]
  assign rom_422 = rom_data_422; // @[irom.scala 32:12]
  assign rom_423 = rom_data_423; // @[irom.scala 32:12]
  assign rom_424 = rom_data_424; // @[irom.scala 32:12]
  assign rom_425 = rom_data_425; // @[irom.scala 32:12]
  assign rom_426 = rom_data_426; // @[irom.scala 32:12]
  assign rom_427 = rom_data_427; // @[irom.scala 32:12]
  assign rom_428 = rom_data_428; // @[irom.scala 32:12]
  assign rom_429 = rom_data_429; // @[irom.scala 32:12]
  assign rom_430 = rom_data_430; // @[irom.scala 32:12]
  assign rom_431 = rom_data_431; // @[irom.scala 32:12]
  assign rom_432 = rom_data_432; // @[irom.scala 32:12]
  assign rom_433 = rom_data_433; // @[irom.scala 32:12]
  assign rom_434 = rom_data_434; // @[irom.scala 32:12]
  assign rom_435 = rom_data_435; // @[irom.scala 32:12]
  assign rom_436 = rom_data_436; // @[irom.scala 32:12]
  assign rom_437 = rom_data_437; // @[irom.scala 32:12]
  assign rom_438 = rom_data_438; // @[irom.scala 32:12]
  assign rom_439 = rom_data_439; // @[irom.scala 32:12]
  assign rom_440 = rom_data_440; // @[irom.scala 32:12]
  assign rom_441 = rom_data_441; // @[irom.scala 32:12]
  assign rom_442 = rom_data_442; // @[irom.scala 32:12]
  assign rom_443 = rom_data_443; // @[irom.scala 32:12]
  assign rom_444 = rom_data_444; // @[irom.scala 32:12]
  assign rom_445 = rom_data_445; // @[irom.scala 32:12]
  assign rom_446 = rom_data_446; // @[irom.scala 32:12]
  assign rom_447 = rom_data_447; // @[irom.scala 32:12]
  assign rom_448 = rom_data_448; // @[irom.scala 32:12]
  assign rom_449 = rom_data_449; // @[irom.scala 32:12]
  assign rom_450 = rom_data_450; // @[irom.scala 32:12]
  assign rom_451 = rom_data_451; // @[irom.scala 32:12]
  assign rom_452 = rom_data_452; // @[irom.scala 32:12]
  assign rom_453 = rom_data_453; // @[irom.scala 32:12]
  assign rom_454 = rom_data_454; // @[irom.scala 32:12]
  assign rom_455 = rom_data_455; // @[irom.scala 32:12]
  assign rom_456 = rom_data_456; // @[irom.scala 32:12]
  assign rom_457 = rom_data_457; // @[irom.scala 32:12]
  assign rom_458 = rom_data_458; // @[irom.scala 32:12]
  assign rom_459 = rom_data_459; // @[irom.scala 32:12]
  assign rom_460 = rom_data_460; // @[irom.scala 32:12]
  assign rom_461 = rom_data_461; // @[irom.scala 32:12]
  assign rom_462 = rom_data_462; // @[irom.scala 32:12]
  assign rom_463 = rom_data_463; // @[irom.scala 32:12]
  assign rom_464 = rom_data_464; // @[irom.scala 32:12]
  assign rom_465 = rom_data_465; // @[irom.scala 32:12]
  assign rom_466 = rom_data_466; // @[irom.scala 32:12]
  assign rom_467 = rom_data_467; // @[irom.scala 32:12]
  assign rom_468 = rom_data_468; // @[irom.scala 32:12]
  assign rom_469 = rom_data_469; // @[irom.scala 32:12]
  assign rom_470 = rom_data_470; // @[irom.scala 32:12]
  assign rom_471 = rom_data_471; // @[irom.scala 32:12]
  assign rom_472 = rom_data_472; // @[irom.scala 32:12]
  assign rom_473 = rom_data_473; // @[irom.scala 32:12]
  assign rom_474 = rom_data_474; // @[irom.scala 32:12]
  assign rom_475 = rom_data_475; // @[irom.scala 32:12]
  assign rom_476 = rom_data_476; // @[irom.scala 32:12]
  assign rom_477 = rom_data_477; // @[irom.scala 32:12]
  assign rom_478 = rom_data_478; // @[irom.scala 32:12]
  assign rom_479 = rom_data_479; // @[irom.scala 32:12]
  assign rom_480 = rom_data_480; // @[irom.scala 32:12]
  assign rom_481 = rom_data_481; // @[irom.scala 32:12]
  assign rom_482 = rom_data_482; // @[irom.scala 32:12]
  assign rom_483 = rom_data_483; // @[irom.scala 32:12]
  assign rom_484 = rom_data_484; // @[irom.scala 32:12]
  assign rom_485 = rom_data_485; // @[irom.scala 32:12]
  assign rom_486 = rom_data_486; // @[irom.scala 32:12]
  assign rom_487 = rom_data_487; // @[irom.scala 32:12]
  assign rom_488 = rom_data_488; // @[irom.scala 32:12]
  assign rom_489 = rom_data_489; // @[irom.scala 32:12]
  assign rom_490 = rom_data_490; // @[irom.scala 32:12]
  assign rom_491 = rom_data_491; // @[irom.scala 32:12]
  assign rom_492 = rom_data_492; // @[irom.scala 32:12]
  assign rom_493 = rom_data_493; // @[irom.scala 32:12]
  assign rom_494 = rom_data_494; // @[irom.scala 32:12]
  assign rom_495 = rom_data_495; // @[irom.scala 32:12]
  assign rom_496 = rom_data_496; // @[irom.scala 32:12]
  assign rom_497 = rom_data_497; // @[irom.scala 32:12]
  assign rom_498 = rom_data_498; // @[irom.scala 32:12]
  assign rom_499 = rom_data_499; // @[irom.scala 32:12]
  assign rom_500 = rom_data_500; // @[irom.scala 32:12]
  assign rom_501 = rom_data_501; // @[irom.scala 32:12]
  assign rom_502 = rom_data_502; // @[irom.scala 32:12]
  assign rom_503 = rom_data_503; // @[irom.scala 32:12]
  assign rom_504 = rom_data_504; // @[irom.scala 32:12]
  assign rom_505 = rom_data_505; // @[irom.scala 32:12]
  assign rom_506 = rom_data_506; // @[irom.scala 32:12]
  assign rom_507 = rom_data_507; // @[irom.scala 32:12]
  assign rom_508 = rom_data_508; // @[irom.scala 32:12]
  assign rom_509 = rom_data_509; // @[irom.scala 32:12]
  assign rom_510 = rom_data_510; // @[irom.scala 32:12]
  assign rom_511 = rom_data_511; // @[irom.scala 32:12]
  assign rom_512 = rom_data_512; // @[irom.scala 32:12]
  assign rom_513 = rom_data_513; // @[irom.scala 32:12]
  assign rom_514 = rom_data_514; // @[irom.scala 32:12]
  assign rom_515 = rom_data_515; // @[irom.scala 32:12]
  assign rom_516 = rom_data_516; // @[irom.scala 32:12]
  assign rom_517 = rom_data_517; // @[irom.scala 32:12]
  assign rom_518 = rom_data_518; // @[irom.scala 32:12]
  assign rom_519 = rom_data_519; // @[irom.scala 32:12]
  assign rom_520 = rom_data_520; // @[irom.scala 32:12]
  assign rom_521 = rom_data_521; // @[irom.scala 32:12]
  assign rom_522 = rom_data_522; // @[irom.scala 32:12]
  assign rom_523 = rom_data_523; // @[irom.scala 32:12]
  assign rom_524 = rom_data_524; // @[irom.scala 32:12]
  assign rom_525 = rom_data_525; // @[irom.scala 32:12]
  assign rom_526 = rom_data_526; // @[irom.scala 32:12]
  assign rom_527 = rom_data_527; // @[irom.scala 32:12]
  assign rom_528 = rom_data_528; // @[irom.scala 32:12]
  assign rom_529 = rom_data_529; // @[irom.scala 32:12]
  assign rom_530 = rom_data_530; // @[irom.scala 32:12]
  assign rom_531 = rom_data_531; // @[irom.scala 32:12]
  assign rom_532 = rom_data_532; // @[irom.scala 32:12]
  assign rom_533 = rom_data_533; // @[irom.scala 32:12]
  assign rom_534 = rom_data_534; // @[irom.scala 32:12]
  assign rom_535 = rom_data_535; // @[irom.scala 32:12]
  assign rom_536 = rom_data_536; // @[irom.scala 32:12]
  assign rom_537 = rom_data_537; // @[irom.scala 32:12]
  assign rom_538 = rom_data_538; // @[irom.scala 32:12]
  assign rom_539 = rom_data_539; // @[irom.scala 32:12]
  assign rom_540 = rom_data_540; // @[irom.scala 32:12]
  assign rom_541 = rom_data_541; // @[irom.scala 32:12]
  assign rom_542 = rom_data_542; // @[irom.scala 32:12]
  assign rom_543 = rom_data_543; // @[irom.scala 32:12]
  assign rom_544 = rom_data_544; // @[irom.scala 32:12]
  assign rom_545 = rom_data_545; // @[irom.scala 32:12]
  assign rom_546 = rom_data_546; // @[irom.scala 32:12]
  assign rom_547 = rom_data_547; // @[irom.scala 32:12]
  assign rom_548 = rom_data_548; // @[irom.scala 32:12]
  assign rom_549 = rom_data_549; // @[irom.scala 32:12]
  assign rom_550 = rom_data_550; // @[irom.scala 32:12]
  assign rom_551 = rom_data_551; // @[irom.scala 32:12]
  assign rom_552 = rom_data_552; // @[irom.scala 32:12]
  assign rom_553 = rom_data_553; // @[irom.scala 32:12]
  assign rom_554 = rom_data_554; // @[irom.scala 32:12]
  assign rom_555 = rom_data_555; // @[irom.scala 32:12]
  assign rom_556 = rom_data_556; // @[irom.scala 32:12]
  assign rom_557 = rom_data_557; // @[irom.scala 32:12]
  assign rom_558 = rom_data_558; // @[irom.scala 32:12]
  assign rom_559 = rom_data_559; // @[irom.scala 32:12]
  assign rom_560 = rom_data_560; // @[irom.scala 32:12]
  assign rom_561 = rom_data_561; // @[irom.scala 32:12]
  assign rom_562 = rom_data_562; // @[irom.scala 32:12]
  assign rom_563 = rom_data_563; // @[irom.scala 32:12]
  assign rom_564 = rom_data_564; // @[irom.scala 32:12]
  assign rom_565 = rom_data_565; // @[irom.scala 32:12]
  assign rom_566 = rom_data_566; // @[irom.scala 32:12]
  assign rom_567 = rom_data_567; // @[irom.scala 32:12]
  assign rom_568 = rom_data_568; // @[irom.scala 32:12]
  assign rom_569 = rom_data_569; // @[irom.scala 32:12]
  assign rom_570 = rom_data_570; // @[irom.scala 32:12]
  assign rom_571 = rom_data_571; // @[irom.scala 32:12]
  assign rom_572 = rom_data_572; // @[irom.scala 32:12]
  assign rom_573 = rom_data_573; // @[irom.scala 32:12]
  assign rom_574 = rom_data_574; // @[irom.scala 32:12]
  assign rom_575 = rom_data_575; // @[irom.scala 32:12]
  assign rom_576 = rom_data_576; // @[irom.scala 32:12]
  assign rom_577 = rom_data_577; // @[irom.scala 32:12]
  assign rom_578 = rom_data_578; // @[irom.scala 32:12]
  assign rom_579 = rom_data_579; // @[irom.scala 32:12]
  assign rom_580 = rom_data_580; // @[irom.scala 32:12]
  assign rom_581 = rom_data_581; // @[irom.scala 32:12]
  assign rom_582 = rom_data_582; // @[irom.scala 32:12]
  assign rom_583 = rom_data_583; // @[irom.scala 32:12]
  assign rom_584 = rom_data_584; // @[irom.scala 32:12]
  assign rom_585 = rom_data_585; // @[irom.scala 32:12]
  assign rom_586 = rom_data_586; // @[irom.scala 32:12]
  assign rom_587 = rom_data_587; // @[irom.scala 32:12]
  assign rom_588 = rom_data_588; // @[irom.scala 32:12]
  assign rom_589 = rom_data_589; // @[irom.scala 32:12]
  assign rom_590 = rom_data_590; // @[irom.scala 32:12]
  assign rom_591 = rom_data_591; // @[irom.scala 32:12]
  assign rom_592 = rom_data_592; // @[irom.scala 32:12]
  assign rom_593 = rom_data_593; // @[irom.scala 32:12]
  assign rom_594 = rom_data_594; // @[irom.scala 32:12]
  assign rom_595 = rom_data_595; // @[irom.scala 32:12]
  assign rom_596 = rom_data_596; // @[irom.scala 32:12]
  assign rom_597 = rom_data_597; // @[irom.scala 32:12]
  assign rom_598 = rom_data_598; // @[irom.scala 32:12]
  assign rom_599 = rom_data_599; // @[irom.scala 32:12]
  assign rom_600 = rom_data_600; // @[irom.scala 32:12]
  assign rom_601 = rom_data_601; // @[irom.scala 32:12]
  assign rom_602 = rom_data_602; // @[irom.scala 32:12]
  assign rom_603 = rom_data_603; // @[irom.scala 32:12]
  assign rom_604 = rom_data_604; // @[irom.scala 32:12]
  assign rom_605 = rom_data_605; // @[irom.scala 32:12]
  assign rom_606 = rom_data_606; // @[irom.scala 32:12]
  assign rom_607 = rom_data_607; // @[irom.scala 32:12]
  assign rom_608 = rom_data_608; // @[irom.scala 32:12]
  assign rom_609 = rom_data_609; // @[irom.scala 32:12]
  assign rom_610 = rom_data_610; // @[irom.scala 32:12]
  assign rom_611 = rom_data_611; // @[irom.scala 32:12]
  assign rom_612 = rom_data_612; // @[irom.scala 32:12]
  assign rom_613 = rom_data_613; // @[irom.scala 32:12]
  assign rom_614 = rom_data_614; // @[irom.scala 32:12]
  assign rom_615 = rom_data_615; // @[irom.scala 32:12]
  assign rom_616 = rom_data_616; // @[irom.scala 32:12]
  assign rom_617 = rom_data_617; // @[irom.scala 32:12]
  assign rom_618 = rom_data_618; // @[irom.scala 32:12]
  assign rom_619 = rom_data_619; // @[irom.scala 32:12]
  assign rom_620 = rom_data_620; // @[irom.scala 32:12]
  assign rom_621 = rom_data_621; // @[irom.scala 32:12]
  assign rom_622 = rom_data_622; // @[irom.scala 32:12]
  assign rom_623 = rom_data_623; // @[irom.scala 32:12]
  assign rom_624 = rom_data_624; // @[irom.scala 32:12]
  assign rom_625 = rom_data_625; // @[irom.scala 32:12]
  assign rom_626 = rom_data_626; // @[irom.scala 32:12]
  assign rom_627 = rom_data_627; // @[irom.scala 32:12]
  assign rom_628 = rom_data_628; // @[irom.scala 32:12]
  assign rom_629 = rom_data_629; // @[irom.scala 32:12]
  assign rom_630 = rom_data_630; // @[irom.scala 32:12]
  assign rom_631 = rom_data_631; // @[irom.scala 32:12]
  assign rom_632 = rom_data_632; // @[irom.scala 32:12]
  assign rom_633 = rom_data_633; // @[irom.scala 32:12]
  assign rom_634 = rom_data_634; // @[irom.scala 32:12]
  assign rom_635 = rom_data_635; // @[irom.scala 32:12]
  assign rom_636 = rom_data_636; // @[irom.scala 32:12]
  assign rom_637 = rom_data_637; // @[irom.scala 32:12]
  assign rom_638 = rom_data_638; // @[irom.scala 32:12]
  assign rom_639 = rom_data_639; // @[irom.scala 32:12]
  assign rom_640 = rom_data_640; // @[irom.scala 32:12]
  assign rom_641 = rom_data_641; // @[irom.scala 32:12]
  assign rom_642 = rom_data_642; // @[irom.scala 32:12]
  assign rom_643 = rom_data_643; // @[irom.scala 32:12]
  assign rom_644 = rom_data_644; // @[irom.scala 32:12]
  assign rom_645 = rom_data_645; // @[irom.scala 32:12]
  assign rom_646 = rom_data_646; // @[irom.scala 32:12]
  assign rom_647 = rom_data_647; // @[irom.scala 32:12]
  assign rom_648 = rom_data_648; // @[irom.scala 32:12]
  assign rom_649 = rom_data_649; // @[irom.scala 32:12]
  assign rom_650 = rom_data_650; // @[irom.scala 32:12]
  assign rom_651 = rom_data_651; // @[irom.scala 32:12]
  assign rom_652 = rom_data_652; // @[irom.scala 32:12]
  assign rom_653 = rom_data_653; // @[irom.scala 32:12]
  assign rom_654 = rom_data_654; // @[irom.scala 32:12]
  assign rom_655 = rom_data_655; // @[irom.scala 32:12]
  assign rom_656 = rom_data_656; // @[irom.scala 32:12]
  assign rom_657 = rom_data_657; // @[irom.scala 32:12]
  assign rom_658 = rom_data_658; // @[irom.scala 32:12]
  assign rom_659 = rom_data_659; // @[irom.scala 32:12]
  assign rom_660 = rom_data_660; // @[irom.scala 32:12]
  assign rom_661 = rom_data_661; // @[irom.scala 32:12]
  assign rom_662 = rom_data_662; // @[irom.scala 32:12]
  assign rom_663 = rom_data_663; // @[irom.scala 32:12]
  assign rom_664 = rom_data_664; // @[irom.scala 32:12]
  assign rom_665 = rom_data_665; // @[irom.scala 32:12]
  assign rom_666 = rom_data_666; // @[irom.scala 32:12]
  assign rom_667 = rom_data_667; // @[irom.scala 32:12]
  assign rom_668 = rom_data_668; // @[irom.scala 32:12]
  assign rom_669 = rom_data_669; // @[irom.scala 32:12]
  assign rom_670 = rom_data_670; // @[irom.scala 32:12]
  assign rom_671 = rom_data_671; // @[irom.scala 32:12]
  assign rom_672 = rom_data_672; // @[irom.scala 32:12]
  assign rom_673 = rom_data_673; // @[irom.scala 32:12]
  assign rom_674 = rom_data_674; // @[irom.scala 32:12]
  assign rom_675 = rom_data_675; // @[irom.scala 32:12]
  assign rom_676 = rom_data_676; // @[irom.scala 32:12]
  assign rom_677 = rom_data_677; // @[irom.scala 32:12]
  assign rom_678 = rom_data_678; // @[irom.scala 32:12]
  assign rom_679 = rom_data_679; // @[irom.scala 32:12]
  assign rom_680 = rom_data_680; // @[irom.scala 32:12]
  assign rom_681 = rom_data_681; // @[irom.scala 32:12]
  assign rom_682 = rom_data_682; // @[irom.scala 32:12]
  assign rom_683 = rom_data_683; // @[irom.scala 32:12]
  assign rom_684 = rom_data_684; // @[irom.scala 32:12]
  assign rom_685 = rom_data_685; // @[irom.scala 32:12]
  assign rom_686 = rom_data_686; // @[irom.scala 32:12]
  assign rom_687 = rom_data_687; // @[irom.scala 32:12]
  assign rom_688 = rom_data_688; // @[irom.scala 32:12]
  assign rom_689 = rom_data_689; // @[irom.scala 32:12]
  assign rom_690 = rom_data_690; // @[irom.scala 32:12]
  assign rom_691 = rom_data_691; // @[irom.scala 32:12]
  assign rom_692 = rom_data_692; // @[irom.scala 32:12]
  assign rom_693 = rom_data_693; // @[irom.scala 32:12]
  assign rom_694 = rom_data_694; // @[irom.scala 32:12]
  assign rom_695 = rom_data_695; // @[irom.scala 32:12]
  assign rom_696 = rom_data_696; // @[irom.scala 32:12]
  assign rom_697 = rom_data_697; // @[irom.scala 32:12]
  assign rom_698 = rom_data_698; // @[irom.scala 32:12]
  assign rom_699 = rom_data_699; // @[irom.scala 32:12]
  assign rom_700 = rom_data_700; // @[irom.scala 32:12]
  assign rom_701 = rom_data_701; // @[irom.scala 32:12]
  assign rom_702 = rom_data_702; // @[irom.scala 32:12]
  assign rom_703 = rom_data_703; // @[irom.scala 32:12]
  assign rom_704 = rom_data_704; // @[irom.scala 32:12]
  assign rom_705 = rom_data_705; // @[irom.scala 32:12]
  assign rom_706 = rom_data_706; // @[irom.scala 32:12]
  assign rom_707 = rom_data_707; // @[irom.scala 32:12]
  assign rom_708 = rom_data_708; // @[irom.scala 32:12]
  assign rom_709 = rom_data_709; // @[irom.scala 32:12]
  assign rom_710 = rom_data_710; // @[irom.scala 32:12]
  assign rom_711 = rom_data_711; // @[irom.scala 32:12]
  assign rom_712 = rom_data_712; // @[irom.scala 32:12]
  assign rom_713 = rom_data_713; // @[irom.scala 32:12]
  assign rom_714 = rom_data_714; // @[irom.scala 32:12]
  assign rom_715 = rom_data_715; // @[irom.scala 32:12]
  assign rom_716 = rom_data_716; // @[irom.scala 32:12]
  assign rom_717 = rom_data_717; // @[irom.scala 32:12]
  assign rom_718 = rom_data_718; // @[irom.scala 32:12]
  assign rom_719 = rom_data_719; // @[irom.scala 32:12]
  assign rom_720 = rom_data_720; // @[irom.scala 32:12]
  assign rom_721 = rom_data_721; // @[irom.scala 32:12]
  assign rom_722 = rom_data_722; // @[irom.scala 32:12]
  assign rom_723 = rom_data_723; // @[irom.scala 32:12]
  assign rom_724 = rom_data_724; // @[irom.scala 32:12]
  assign rom_725 = rom_data_725; // @[irom.scala 32:12]
  assign rom_726 = rom_data_726; // @[irom.scala 32:12]
  assign rom_727 = rom_data_727; // @[irom.scala 32:12]
  assign rom_728 = rom_data_728; // @[irom.scala 32:12]
  assign rom_729 = rom_data_729; // @[irom.scala 32:12]
  assign rom_730 = rom_data_730; // @[irom.scala 32:12]
  assign rom_731 = rom_data_731; // @[irom.scala 32:12]
  assign rom_732 = rom_data_732; // @[irom.scala 32:12]
  assign rom_733 = rom_data_733; // @[irom.scala 32:12]
  assign rom_734 = rom_data_734; // @[irom.scala 32:12]
  assign rom_735 = rom_data_735; // @[irom.scala 32:12]
  assign rom_736 = rom_data_736; // @[irom.scala 32:12]
  assign rom_737 = rom_data_737; // @[irom.scala 32:12]
  assign rom_738 = rom_data_738; // @[irom.scala 32:12]
  assign rom_739 = rom_data_739; // @[irom.scala 32:12]
  assign rom_740 = rom_data_740; // @[irom.scala 32:12]
  assign rom_741 = rom_data_741; // @[irom.scala 32:12]
  assign rom_742 = rom_data_742; // @[irom.scala 32:12]
  assign rom_743 = rom_data_743; // @[irom.scala 32:12]
  assign rom_744 = rom_data_744; // @[irom.scala 32:12]
  assign rom_745 = rom_data_745; // @[irom.scala 32:12]
  assign rom_746 = rom_data_746; // @[irom.scala 32:12]
  assign rom_747 = rom_data_747; // @[irom.scala 32:12]
  assign rom_748 = rom_data_748; // @[irom.scala 32:12]
  assign rom_749 = rom_data_749; // @[irom.scala 32:12]
  assign rom_750 = rom_data_750; // @[irom.scala 32:12]
  assign rom_751 = rom_data_751; // @[irom.scala 32:12]
  assign rom_752 = rom_data_752; // @[irom.scala 32:12]
  assign rom_753 = rom_data_753; // @[irom.scala 32:12]
  assign rom_754 = rom_data_754; // @[irom.scala 32:12]
  assign rom_755 = rom_data_755; // @[irom.scala 32:12]
  assign rom_756 = rom_data_756; // @[irom.scala 32:12]
  assign rom_757 = rom_data_757; // @[irom.scala 32:12]
  assign rom_758 = rom_data_758; // @[irom.scala 32:12]
  assign rom_759 = rom_data_759; // @[irom.scala 32:12]
  assign rom_760 = rom_data_760; // @[irom.scala 32:12]
  assign rom_761 = rom_data_761; // @[irom.scala 32:12]
  assign rom_762 = rom_data_762; // @[irom.scala 32:12]
  assign rom_763 = rom_data_763; // @[irom.scala 32:12]
  assign rom_764 = rom_data_764; // @[irom.scala 32:12]
  assign rom_765 = rom_data_765; // @[irom.scala 32:12]
  assign rom_766 = rom_data_766; // @[irom.scala 32:12]
  assign rom_767 = rom_data_767; // @[irom.scala 32:12]
  assign rom_768 = rom_data_768; // @[irom.scala 32:12]
  assign rom_769 = rom_data_769; // @[irom.scala 32:12]
  assign rom_770 = rom_data_770; // @[irom.scala 32:12]
  assign rom_771 = rom_data_771; // @[irom.scala 32:12]
  assign rom_772 = rom_data_772; // @[irom.scala 32:12]
  assign rom_773 = rom_data_773; // @[irom.scala 32:12]
  assign rom_774 = rom_data_774; // @[irom.scala 32:12]
  assign rom_775 = rom_data_775; // @[irom.scala 32:12]
  assign rom_776 = rom_data_776; // @[irom.scala 32:12]
  assign rom_777 = rom_data_777; // @[irom.scala 32:12]
  assign rom_778 = rom_data_778; // @[irom.scala 32:12]
  assign rom_779 = rom_data_779; // @[irom.scala 32:12]
  assign rom_780 = rom_data_780; // @[irom.scala 32:12]
  assign rom_781 = rom_data_781; // @[irom.scala 32:12]
  assign rom_782 = rom_data_782; // @[irom.scala 32:12]
  assign rom_783 = rom_data_783; // @[irom.scala 32:12]
  assign rom_784 = rom_data_784; // @[irom.scala 32:12]
  assign rom_785 = rom_data_785; // @[irom.scala 32:12]
  assign rom_786 = rom_data_786; // @[irom.scala 32:12]
  assign rom_787 = rom_data_787; // @[irom.scala 32:12]
  assign rom_788 = rom_data_788; // @[irom.scala 32:12]
  assign rom_789 = rom_data_789; // @[irom.scala 32:12]
  assign rom_790 = rom_data_790; // @[irom.scala 32:12]
  assign rom_791 = rom_data_791; // @[irom.scala 32:12]
  assign rom_792 = rom_data_792; // @[irom.scala 32:12]
  assign rom_793 = rom_data_793; // @[irom.scala 32:12]
  assign rom_794 = rom_data_794; // @[irom.scala 32:12]
  assign rom_795 = rom_data_795; // @[irom.scala 32:12]
  assign rom_796 = rom_data_796; // @[irom.scala 32:12]
  assign rom_797 = rom_data_797; // @[irom.scala 32:12]
  assign rom_798 = rom_data_798; // @[irom.scala 32:12]
  assign rom_799 = rom_data_799; // @[irom.scala 32:12]
  assign rom_800 = rom_data_800; // @[irom.scala 32:12]
  assign rom_801 = rom_data_801; // @[irom.scala 32:12]
  assign rom_802 = rom_data_802; // @[irom.scala 32:12]
  assign rom_803 = rom_data_803; // @[irom.scala 32:12]
  assign rom_804 = rom_data_804; // @[irom.scala 32:12]
  assign rom_805 = rom_data_805; // @[irom.scala 32:12]
  assign rom_806 = rom_data_806; // @[irom.scala 32:12]
  assign rom_807 = rom_data_807; // @[irom.scala 32:12]
  assign rom_808 = rom_data_808; // @[irom.scala 32:12]
  assign rom_809 = rom_data_809; // @[irom.scala 32:12]
  assign rom_810 = rom_data_810; // @[irom.scala 32:12]
  assign rom_811 = rom_data_811; // @[irom.scala 32:12]
  assign rom_812 = rom_data_812; // @[irom.scala 32:12]
  assign rom_813 = rom_data_813; // @[irom.scala 32:12]
  assign rom_814 = rom_data_814; // @[irom.scala 32:12]
  assign rom_815 = rom_data_815; // @[irom.scala 32:12]
  assign rom_816 = rom_data_816; // @[irom.scala 32:12]
  assign rom_817 = rom_data_817; // @[irom.scala 32:12]
  assign rom_818 = rom_data_818; // @[irom.scala 32:12]
  assign rom_819 = rom_data_819; // @[irom.scala 32:12]
  assign rom_820 = rom_data_820; // @[irom.scala 32:12]
  assign rom_821 = rom_data_821; // @[irom.scala 32:12]
  assign rom_822 = rom_data_822; // @[irom.scala 32:12]
  assign rom_823 = rom_data_823; // @[irom.scala 32:12]
  assign rom_824 = rom_data_824; // @[irom.scala 32:12]
  assign rom_825 = rom_data_825; // @[irom.scala 32:12]
  assign rom_826 = rom_data_826; // @[irom.scala 32:12]
  assign rom_827 = rom_data_827; // @[irom.scala 32:12]
  assign rom_828 = rom_data_828; // @[irom.scala 32:12]
  assign rom_829 = rom_data_829; // @[irom.scala 32:12]
  assign rom_830 = rom_data_830; // @[irom.scala 32:12]
  assign rom_831 = rom_data_831; // @[irom.scala 32:12]
  assign rom_832 = rom_data_832; // @[irom.scala 32:12]
  assign rom_833 = rom_data_833; // @[irom.scala 32:12]
  assign rom_834 = rom_data_834; // @[irom.scala 32:12]
  assign rom_835 = rom_data_835; // @[irom.scala 32:12]
  assign rom_836 = rom_data_836; // @[irom.scala 32:12]
  assign rom_837 = rom_data_837; // @[irom.scala 32:12]
  assign rom_838 = rom_data_838; // @[irom.scala 32:12]
  assign rom_839 = rom_data_839; // @[irom.scala 32:12]
  assign rom_840 = rom_data_840; // @[irom.scala 32:12]
  assign rom_841 = rom_data_841; // @[irom.scala 32:12]
  assign rom_842 = rom_data_842; // @[irom.scala 32:12]
  assign rom_843 = rom_data_843; // @[irom.scala 32:12]
  assign rom_844 = rom_data_844; // @[irom.scala 32:12]
  assign rom_845 = rom_data_845; // @[irom.scala 32:12]
  assign rom_846 = rom_data_846; // @[irom.scala 32:12]
  assign rom_847 = rom_data_847; // @[irom.scala 32:12]
  assign rom_848 = rom_data_848; // @[irom.scala 32:12]
  assign rom_849 = rom_data_849; // @[irom.scala 32:12]
  assign rom_850 = rom_data_850; // @[irom.scala 32:12]
  assign rom_851 = rom_data_851; // @[irom.scala 32:12]
  assign rom_852 = rom_data_852; // @[irom.scala 32:12]
  assign rom_853 = rom_data_853; // @[irom.scala 32:12]
  assign rom_854 = rom_data_854; // @[irom.scala 32:12]
  assign rom_855 = rom_data_855; // @[irom.scala 32:12]
  assign rom_856 = rom_data_856; // @[irom.scala 32:12]
  assign rom_857 = rom_data_857; // @[irom.scala 32:12]
  assign rom_858 = rom_data_858; // @[irom.scala 32:12]
  assign rom_859 = rom_data_859; // @[irom.scala 32:12]
  assign rom_860 = rom_data_860; // @[irom.scala 32:12]
  assign rom_861 = rom_data_861; // @[irom.scala 32:12]
  assign rom_862 = rom_data_862; // @[irom.scala 32:12]
  assign rom_863 = rom_data_863; // @[irom.scala 32:12]
  assign rom_864 = rom_data_864; // @[irom.scala 32:12]
  assign rom_865 = rom_data_865; // @[irom.scala 32:12]
  assign rom_866 = rom_data_866; // @[irom.scala 32:12]
  assign rom_867 = rom_data_867; // @[irom.scala 32:12]
  assign rom_868 = rom_data_868; // @[irom.scala 32:12]
  assign rom_869 = rom_data_869; // @[irom.scala 32:12]
  assign rom_870 = rom_data_870; // @[irom.scala 32:12]
  assign rom_871 = rom_data_871; // @[irom.scala 32:12]
  assign rom_872 = rom_data_872; // @[irom.scala 32:12]
  assign rom_873 = rom_data_873; // @[irom.scala 32:12]
  assign rom_874 = rom_data_874; // @[irom.scala 32:12]
  assign rom_875 = rom_data_875; // @[irom.scala 32:12]
  assign rom_876 = rom_data_876; // @[irom.scala 32:12]
  assign rom_877 = rom_data_877; // @[irom.scala 32:12]
  assign rom_878 = rom_data_878; // @[irom.scala 32:12]
  assign rom_879 = rom_data_879; // @[irom.scala 32:12]
  assign rom_880 = rom_data_880; // @[irom.scala 32:12]
  assign rom_881 = rom_data_881; // @[irom.scala 32:12]
  assign rom_882 = rom_data_882; // @[irom.scala 32:12]
  assign rom_883 = rom_data_883; // @[irom.scala 32:12]
  assign rom_884 = rom_data_884; // @[irom.scala 32:12]
  assign rom_885 = rom_data_885; // @[irom.scala 32:12]
  assign rom_886 = rom_data_886; // @[irom.scala 32:12]
  assign rom_887 = rom_data_887; // @[irom.scala 32:12]
  assign rom_888 = rom_data_888; // @[irom.scala 32:12]
  assign rom_889 = rom_data_889; // @[irom.scala 32:12]
  assign rom_890 = rom_data_890; // @[irom.scala 32:12]
  assign rom_891 = rom_data_891; // @[irom.scala 32:12]
  assign rom_892 = rom_data_892; // @[irom.scala 32:12]
  assign rom_893 = rom_data_893; // @[irom.scala 32:12]
  assign rom_894 = rom_data_894; // @[irom.scala 32:12]
  assign rom_895 = rom_data_895; // @[irom.scala 32:12]
  assign rom_896 = rom_data_896; // @[irom.scala 32:12]
  assign rom_897 = rom_data_897; // @[irom.scala 32:12]
  assign rom_898 = rom_data_898; // @[irom.scala 32:12]
  assign rom_899 = rom_data_899; // @[irom.scala 32:12]
  assign rom_900 = rom_data_900; // @[irom.scala 32:12]
  assign rom_901 = rom_data_901; // @[irom.scala 32:12]
  assign rom_902 = rom_data_902; // @[irom.scala 32:12]
  assign rom_903 = rom_data_903; // @[irom.scala 32:12]
  assign rom_904 = rom_data_904; // @[irom.scala 32:12]
  assign rom_905 = rom_data_905; // @[irom.scala 32:12]
  assign rom_906 = rom_data_906; // @[irom.scala 32:12]
  assign rom_907 = rom_data_907; // @[irom.scala 32:12]
  assign rom_908 = rom_data_908; // @[irom.scala 32:12]
  assign rom_909 = rom_data_909; // @[irom.scala 32:12]
  assign rom_910 = rom_data_910; // @[irom.scala 32:12]
  assign rom_911 = rom_data_911; // @[irom.scala 32:12]
  assign rom_912 = rom_data_912; // @[irom.scala 32:12]
  assign rom_913 = rom_data_913; // @[irom.scala 32:12]
  assign rom_914 = rom_data_914; // @[irom.scala 32:12]
  assign rom_915 = rom_data_915; // @[irom.scala 32:12]
  assign rom_916 = rom_data_916; // @[irom.scala 32:12]
  assign rom_917 = rom_data_917; // @[irom.scala 32:12]
  assign rom_918 = rom_data_918; // @[irom.scala 32:12]
  assign rom_919 = rom_data_919; // @[irom.scala 32:12]
  assign rom_920 = rom_data_920; // @[irom.scala 32:12]
  assign rom_921 = rom_data_921; // @[irom.scala 32:12]
  assign rom_922 = rom_data_922; // @[irom.scala 32:12]
  assign rom_923 = rom_data_923; // @[irom.scala 32:12]
  assign rom_924 = rom_data_924; // @[irom.scala 32:12]
  assign rom_925 = rom_data_925; // @[irom.scala 32:12]
  assign rom_926 = rom_data_926; // @[irom.scala 32:12]
  assign rom_927 = rom_data_927; // @[irom.scala 32:12]
  assign rom_928 = rom_data_928; // @[irom.scala 32:12]
  assign rom_929 = rom_data_929; // @[irom.scala 32:12]
  assign rom_930 = rom_data_930; // @[irom.scala 32:12]
  assign rom_931 = rom_data_931; // @[irom.scala 32:12]
  assign rom_932 = rom_data_932; // @[irom.scala 32:12]
  assign rom_933 = rom_data_933; // @[irom.scala 32:12]
  assign rom_934 = rom_data_934; // @[irom.scala 32:12]
  assign rom_935 = rom_data_935; // @[irom.scala 32:12]
  assign rom_936 = rom_data_936; // @[irom.scala 32:12]
  assign rom_937 = rom_data_937; // @[irom.scala 32:12]
  assign rom_938 = rom_data_938; // @[irom.scala 32:12]
  assign rom_939 = rom_data_939; // @[irom.scala 32:12]
  assign rom_940 = rom_data_940; // @[irom.scala 32:12]
  assign rom_941 = rom_data_941; // @[irom.scala 32:12]
  assign rom_942 = rom_data_942; // @[irom.scala 32:12]
  assign rom_943 = rom_data_943; // @[irom.scala 32:12]
  assign rom_944 = rom_data_944; // @[irom.scala 32:12]
  assign rom_945 = rom_data_945; // @[irom.scala 32:12]
  assign rom_946 = rom_data_946; // @[irom.scala 32:12]
  assign rom_947 = rom_data_947; // @[irom.scala 32:12]
  assign rom_948 = rom_data_948; // @[irom.scala 32:12]
  assign rom_949 = rom_data_949; // @[irom.scala 32:12]
  assign rom_950 = rom_data_950; // @[irom.scala 32:12]
  assign rom_951 = rom_data_951; // @[irom.scala 32:12]
  assign rom_952 = rom_data_952; // @[irom.scala 32:12]
  assign rom_953 = rom_data_953; // @[irom.scala 32:12]
  assign rom_954 = rom_data_954; // @[irom.scala 32:12]
  assign rom_955 = rom_data_955; // @[irom.scala 32:12]
  assign rom_956 = rom_data_956; // @[irom.scala 32:12]
  assign rom_957 = rom_data_957; // @[irom.scala 32:12]
  assign rom_958 = rom_data_958; // @[irom.scala 32:12]
  assign rom_959 = rom_data_959; // @[irom.scala 32:12]
  assign rom_960 = rom_data_960; // @[irom.scala 32:12]
  assign rom_961 = rom_data_961; // @[irom.scala 32:12]
  assign rom_962 = rom_data_962; // @[irom.scala 32:12]
  assign rom_963 = rom_data_963; // @[irom.scala 32:12]
  assign rom_964 = rom_data_964; // @[irom.scala 32:12]
  assign rom_965 = rom_data_965; // @[irom.scala 32:12]
  assign rom_966 = rom_data_966; // @[irom.scala 32:12]
  assign rom_967 = rom_data_967; // @[irom.scala 32:12]
  assign rom_968 = rom_data_968; // @[irom.scala 32:12]
  assign rom_969 = rom_data_969; // @[irom.scala 32:12]
  assign rom_970 = rom_data_970; // @[irom.scala 32:12]
  assign rom_971 = rom_data_971; // @[irom.scala 32:12]
  assign rom_972 = rom_data_972; // @[irom.scala 32:12]
  assign rom_973 = rom_data_973; // @[irom.scala 32:12]
  assign rom_974 = rom_data_974; // @[irom.scala 32:12]
  assign rom_975 = rom_data_975; // @[irom.scala 32:12]
  assign rom_976 = rom_data_976; // @[irom.scala 32:12]
  assign rom_977 = rom_data_977; // @[irom.scala 32:12]
  assign rom_978 = rom_data_978; // @[irom.scala 32:12]
  assign rom_979 = rom_data_979; // @[irom.scala 32:12]
  assign rom_980 = rom_data_980; // @[irom.scala 32:12]
  assign rom_981 = rom_data_981; // @[irom.scala 32:12]
  assign rom_982 = rom_data_982; // @[irom.scala 32:12]
  assign rom_983 = rom_data_983; // @[irom.scala 32:12]
  assign rom_984 = rom_data_984; // @[irom.scala 32:12]
  assign rom_985 = rom_data_985; // @[irom.scala 32:12]
  assign rom_986 = rom_data_986; // @[irom.scala 32:12]
  assign rom_987 = rom_data_987; // @[irom.scala 32:12]
  assign rom_988 = rom_data_988; // @[irom.scala 32:12]
  assign rom_989 = rom_data_989; // @[irom.scala 32:12]
  assign rom_990 = rom_data_990; // @[irom.scala 32:12]
  assign rom_991 = rom_data_991; // @[irom.scala 32:12]
  assign rom_992 = rom_data_992; // @[irom.scala 32:12]
  assign rom_993 = rom_data_993; // @[irom.scala 32:12]
  assign rom_994 = rom_data_994; // @[irom.scala 32:12]
  assign rom_995 = rom_data_995; // @[irom.scala 32:12]
  assign rom_996 = rom_data_996; // @[irom.scala 32:12]
  assign rom_997 = rom_data_997; // @[irom.scala 32:12]
  assign rom_998 = rom_data_998; // @[irom.scala 32:12]
  assign rom_999 = rom_data_999; // @[irom.scala 32:12]
  assign rom_1000 = rom_data_1000; // @[irom.scala 32:12]
  assign rom_1001 = rom_data_1001; // @[irom.scala 32:12]
  assign rom_1002 = rom_data_1002; // @[irom.scala 32:12]
  assign rom_1003 = rom_data_1003; // @[irom.scala 32:12]
  assign rom_1004 = rom_data_1004; // @[irom.scala 32:12]
  assign rom_1005 = rom_data_1005; // @[irom.scala 32:12]
  assign rom_1006 = rom_data_1006; // @[irom.scala 32:12]
  assign rom_1007 = rom_data_1007; // @[irom.scala 32:12]
  assign rom_1008 = rom_data_1008; // @[irom.scala 32:12]
  assign rom_1009 = rom_data_1009; // @[irom.scala 32:12]
  assign rom_1010 = rom_data_1010; // @[irom.scala 32:12]
  assign rom_1011 = rom_data_1011; // @[irom.scala 32:12]
  assign rom_1012 = rom_data_1012; // @[irom.scala 32:12]
  assign rom_1013 = rom_data_1013; // @[irom.scala 32:12]
  assign rom_1014 = rom_data_1014; // @[irom.scala 32:12]
  assign rom_1015 = rom_data_1015; // @[irom.scala 32:12]
  assign rom_1016 = rom_data_1016; // @[irom.scala 32:12]
  assign rom_1017 = rom_data_1017; // @[irom.scala 32:12]
  assign rom_1018 = rom_data_1018; // @[irom.scala 32:12]
  assign rom_1019 = rom_data_1019; // @[irom.scala 32:12]
  assign rom_1020 = rom_data_1020; // @[irom.scala 32:12]
  assign rom_1021 = rom_data_1021; // @[irom.scala 32:12]
  assign rom_1022 = rom_data_1022; // @[irom.scala 32:12]
  assign rom_1023 = rom_data_1023; // @[irom.scala 32:12]
  assign rom_1024 = rom_data_1024; // @[irom.scala 32:12]
  assign rom_1025 = rom_data_1025; // @[irom.scala 32:12]
  assign rom_1026 = rom_data_1026; // @[irom.scala 32:12]
  assign rom_1027 = rom_data_1027; // @[irom.scala 32:12]
  assign rom_1028 = rom_data_1028; // @[irom.scala 32:12]
  assign rom_1029 = rom_data_1029; // @[irom.scala 32:12]
  assign rom_1030 = rom_data_1030; // @[irom.scala 32:12]
  assign rom_1031 = rom_data_1031; // @[irom.scala 32:12]
  assign rom_1032 = rom_data_1032; // @[irom.scala 32:12]
  assign rom_1033 = rom_data_1033; // @[irom.scala 32:12]
  assign rom_1034 = rom_data_1034; // @[irom.scala 32:12]
  assign rom_1035 = rom_data_1035; // @[irom.scala 32:12]
  assign rom_1036 = rom_data_1036; // @[irom.scala 32:12]
  assign rom_1037 = rom_data_1037; // @[irom.scala 32:12]
  assign rom_1038 = rom_data_1038; // @[irom.scala 32:12]
  assign rom_1039 = rom_data_1039; // @[irom.scala 32:12]
  assign rom_1040 = rom_data_1040; // @[irom.scala 32:12]
  assign rom_1041 = rom_data_1041; // @[irom.scala 32:12]
  assign rom_1042 = rom_data_1042; // @[irom.scala 32:12]
  assign rom_1043 = rom_data_1043; // @[irom.scala 32:12]
  assign rom_1044 = rom_data_1044; // @[irom.scala 32:12]
  assign rom_1045 = rom_data_1045; // @[irom.scala 32:12]
  assign rom_1046 = rom_data_1046; // @[irom.scala 32:12]
  assign rom_1047 = rom_data_1047; // @[irom.scala 32:12]
  assign rom_1048 = rom_data_1048; // @[irom.scala 32:12]
  assign rom_1049 = rom_data_1049; // @[irom.scala 32:12]
  assign rom_1050 = rom_data_1050; // @[irom.scala 32:12]
  assign rom_1051 = rom_data_1051; // @[irom.scala 32:12]
  assign rom_1052 = rom_data_1052; // @[irom.scala 32:12]
  assign rom_1053 = rom_data_1053; // @[irom.scala 32:12]
  assign rom_1054 = rom_data_1054; // @[irom.scala 32:12]
  assign rom_1055 = rom_data_1055; // @[irom.scala 32:12]
  assign rom_1056 = rom_data_1056; // @[irom.scala 32:12]
  assign rom_1057 = rom_data_1057; // @[irom.scala 32:12]
  assign rom_1058 = rom_data_1058; // @[irom.scala 32:12]
  assign rom_1059 = rom_data_1059; // @[irom.scala 32:12]
  assign rom_1060 = rom_data_1060; // @[irom.scala 32:12]
  assign rom_1061 = rom_data_1061; // @[irom.scala 32:12]
  assign rom_1062 = rom_data_1062; // @[irom.scala 32:12]
  assign rom_1063 = rom_data_1063; // @[irom.scala 32:12]
  assign rom_1064 = rom_data_1064; // @[irom.scala 32:12]
  assign rom_1065 = rom_data_1065; // @[irom.scala 32:12]
  assign rom_1066 = rom_data_1066; // @[irom.scala 32:12]
  assign rom_1067 = rom_data_1067; // @[irom.scala 32:12]
  assign rom_1068 = rom_data_1068; // @[irom.scala 32:12]
  assign rom_1069 = rom_data_1069; // @[irom.scala 32:12]
  assign rom_1070 = rom_data_1070; // @[irom.scala 32:12]
  assign rom_1071 = rom_data_1071; // @[irom.scala 32:12]
  assign rom_1072 = rom_data_1072; // @[irom.scala 32:12]
  assign rom_1073 = rom_data_1073; // @[irom.scala 32:12]
  assign rom_1074 = rom_data_1074; // @[irom.scala 32:12]
  assign rom_1075 = rom_data_1075; // @[irom.scala 32:12]
  assign rom_1076 = rom_data_1076; // @[irom.scala 32:12]
  assign rom_1077 = rom_data_1077; // @[irom.scala 32:12]
  assign rom_1078 = rom_data_1078; // @[irom.scala 32:12]
  assign rom_1079 = rom_data_1079; // @[irom.scala 32:12]
  assign rom_1080 = rom_data_1080; // @[irom.scala 32:12]
  assign rom_1081 = rom_data_1081; // @[irom.scala 32:12]
  assign rom_1082 = rom_data_1082; // @[irom.scala 32:12]
  assign rom_1083 = rom_data_1083; // @[irom.scala 32:12]
  assign rom_1084 = rom_data_1084; // @[irom.scala 32:12]
  assign rom_1085 = rom_data_1085; // @[irom.scala 32:12]
  assign rom_1086 = rom_data_1086; // @[irom.scala 32:12]
  assign rom_1087 = rom_data_1087; // @[irom.scala 32:12]
  assign rom_1088 = rom_data_1088; // @[irom.scala 32:12]
  assign rom_1089 = rom_data_1089; // @[irom.scala 32:12]
  assign rom_1090 = rom_data_1090; // @[irom.scala 32:12]
  assign rom_1091 = rom_data_1091; // @[irom.scala 32:12]
  assign rom_1092 = rom_data_1092; // @[irom.scala 32:12]
  assign rom_1093 = rom_data_1093; // @[irom.scala 32:12]
  assign rom_1094 = rom_data_1094; // @[irom.scala 32:12]
  assign rom_1095 = rom_data_1095; // @[irom.scala 32:12]
  assign rom_1096 = rom_data_1096; // @[irom.scala 32:12]
  assign rom_1097 = rom_data_1097; // @[irom.scala 32:12]
  assign rom_1098 = rom_data_1098; // @[irom.scala 32:12]
  assign rom_1099 = rom_data_1099; // @[irom.scala 32:12]
  assign rom_1100 = rom_data_1100; // @[irom.scala 32:12]
  assign rom_1101 = rom_data_1101; // @[irom.scala 32:12]
  assign rom_1102 = rom_data_1102; // @[irom.scala 32:12]
  assign rom_1103 = rom_data_1103; // @[irom.scala 32:12]
  assign rom_1104 = rom_data_1104; // @[irom.scala 32:12]
  assign rom_1105 = rom_data_1105; // @[irom.scala 32:12]
  assign rom_1106 = rom_data_1106; // @[irom.scala 32:12]
  assign rom_1107 = rom_data_1107; // @[irom.scala 32:12]
  assign rom_1108 = rom_data_1108; // @[irom.scala 32:12]
  assign rom_1109 = rom_data_1109; // @[irom.scala 32:12]
  assign rom_1110 = rom_data_1110; // @[irom.scala 32:12]
  assign rom_1111 = rom_data_1111; // @[irom.scala 32:12]
  assign rom_1112 = rom_data_1112; // @[irom.scala 32:12]
  assign rom_1113 = rom_data_1113; // @[irom.scala 32:12]
  assign rom_1114 = rom_data_1114; // @[irom.scala 32:12]
  assign rom_1115 = rom_data_1115; // @[irom.scala 32:12]
  assign rom_1116 = rom_data_1116; // @[irom.scala 32:12]
  assign rom_1117 = rom_data_1117; // @[irom.scala 32:12]
  assign rom_1118 = rom_data_1118; // @[irom.scala 32:12]
  assign rom_1119 = rom_data_1119; // @[irom.scala 32:12]
  assign rom_1120 = rom_data_1120; // @[irom.scala 32:12]
  assign rom_1121 = rom_data_1121; // @[irom.scala 32:12]
  assign rom_1122 = rom_data_1122; // @[irom.scala 32:12]
  assign rom_1123 = rom_data_1123; // @[irom.scala 32:12]
  assign rom_1124 = rom_data_1124; // @[irom.scala 32:12]
  assign rom_1125 = rom_data_1125; // @[irom.scala 32:12]
  assign rom_1126 = rom_data_1126; // @[irom.scala 32:12]
  assign rom_1127 = rom_data_1127; // @[irom.scala 32:12]
  assign rom_1128 = rom_data_1128; // @[irom.scala 32:12]
  assign rom_1129 = rom_data_1129; // @[irom.scala 32:12]
  assign rom_1130 = rom_data_1130; // @[irom.scala 32:12]
  assign rom_1131 = rom_data_1131; // @[irom.scala 32:12]
  assign rom_1132 = rom_data_1132; // @[irom.scala 32:12]
  assign rom_1133 = rom_data_1133; // @[irom.scala 32:12]
  assign rom_1134 = rom_data_1134; // @[irom.scala 32:12]
  assign rom_1135 = rom_data_1135; // @[irom.scala 32:12]
  assign rom_1136 = rom_data_1136; // @[irom.scala 32:12]
  assign rom_1137 = rom_data_1137; // @[irom.scala 32:12]
  assign rom_1138 = rom_data_1138; // @[irom.scala 32:12]
  assign rom_1139 = rom_data_1139; // @[irom.scala 32:12]
  assign rom_1140 = rom_data_1140; // @[irom.scala 32:12]
  assign rom_1141 = rom_data_1141; // @[irom.scala 32:12]
  assign rom_1142 = rom_data_1142; // @[irom.scala 32:12]
  assign rom_1143 = rom_data_1143; // @[irom.scala 32:12]
  assign rom_1144 = rom_data_1144; // @[irom.scala 32:12]
  assign rom_1145 = rom_data_1145; // @[irom.scala 32:12]
  assign rom_1146 = rom_data_1146; // @[irom.scala 32:12]
  assign rom_1147 = rom_data_1147; // @[irom.scala 32:12]
  assign rom_1148 = rom_data_1148; // @[irom.scala 32:12]
  assign rom_1149 = rom_data_1149; // @[irom.scala 32:12]
  assign rom_1150 = rom_data_1150; // @[irom.scala 32:12]
  assign rom_1151 = rom_data_1151; // @[irom.scala 32:12]
  assign rom_1152 = rom_data_1152; // @[irom.scala 32:12]
  assign rom_1153 = rom_data_1153; // @[irom.scala 32:12]
  assign rom_1154 = rom_data_1154; // @[irom.scala 32:12]
  assign rom_1155 = rom_data_1155; // @[irom.scala 32:12]
  assign rom_1156 = rom_data_1156; // @[irom.scala 32:12]
  assign rom_1157 = rom_data_1157; // @[irom.scala 32:12]
  assign rom_1158 = rom_data_1158; // @[irom.scala 32:12]
  assign rom_1159 = rom_data_1159; // @[irom.scala 32:12]
  assign rom_1160 = rom_data_1160; // @[irom.scala 32:12]
  assign rom_1161 = rom_data_1161; // @[irom.scala 32:12]
  assign rom_1162 = rom_data_1162; // @[irom.scala 32:12]
  assign rom_1163 = rom_data_1163; // @[irom.scala 32:12]
  assign rom_1164 = rom_data_1164; // @[irom.scala 32:12]
  assign rom_1165 = rom_data_1165; // @[irom.scala 32:12]
  assign rom_1166 = rom_data_1166; // @[irom.scala 32:12]
  assign rom_1167 = rom_data_1167; // @[irom.scala 32:12]
  assign rom_1168 = rom_data_1168; // @[irom.scala 32:12]
  assign rom_1169 = rom_data_1169; // @[irom.scala 32:12]
  assign rom_1170 = rom_data_1170; // @[irom.scala 32:12]
  assign rom_1171 = rom_data_1171; // @[irom.scala 32:12]
  assign rom_1172 = rom_data_1172; // @[irom.scala 32:12]
  assign rom_1173 = rom_data_1173; // @[irom.scala 32:12]
  assign rom_1174 = rom_data_1174; // @[irom.scala 32:12]
  assign rom_1175 = rom_data_1175; // @[irom.scala 32:12]
  assign rom_1176 = rom_data_1176; // @[irom.scala 32:12]
  assign rom_1177 = rom_data_1177; // @[irom.scala 32:12]
  assign rom_1178 = rom_data_1178; // @[irom.scala 32:12]
  assign rom_1179 = rom_data_1179; // @[irom.scala 32:12]
  assign rom_1180 = rom_data_1180; // @[irom.scala 32:12]
  assign rom_1181 = rom_data_1181; // @[irom.scala 32:12]
  assign rom_1182 = rom_data_1182; // @[irom.scala 32:12]
  assign rom_1183 = rom_data_1183; // @[irom.scala 32:12]
  assign rom_1184 = rom_data_1184; // @[irom.scala 32:12]
  assign rom_1185 = rom_data_1185; // @[irom.scala 32:12]
  assign rom_1186 = rom_data_1186; // @[irom.scala 32:12]
  assign rom_1187 = rom_data_1187; // @[irom.scala 32:12]
  assign rom_1188 = rom_data_1188; // @[irom.scala 32:12]
  assign rom_1189 = rom_data_1189; // @[irom.scala 32:12]
  assign rom_1190 = rom_data_1190; // @[irom.scala 32:12]
  assign rom_1191 = rom_data_1191; // @[irom.scala 32:12]
  assign rom_1192 = rom_data_1192; // @[irom.scala 32:12]
  assign rom_1193 = rom_data_1193; // @[irom.scala 32:12]
  assign rom_1194 = rom_data_1194; // @[irom.scala 32:12]
  assign rom_1195 = rom_data_1195; // @[irom.scala 32:12]
  assign rom_1196 = rom_data_1196; // @[irom.scala 32:12]
  assign rom_1197 = rom_data_1197; // @[irom.scala 32:12]
  assign rom_1198 = rom_data_1198; // @[irom.scala 32:12]
  assign rom_1199 = rom_data_1199; // @[irom.scala 32:12]
  assign rom_1200 = rom_data_1200; // @[irom.scala 32:12]
  assign rom_1201 = rom_data_1201; // @[irom.scala 32:12]
  assign rom_1202 = rom_data_1202; // @[irom.scala 32:12]
  assign rom_1203 = rom_data_1203; // @[irom.scala 32:12]
  assign rom_1204 = rom_data_1204; // @[irom.scala 32:12]
  assign rom_1205 = rom_data_1205; // @[irom.scala 32:12]
  assign rom_1206 = rom_data_1206; // @[irom.scala 32:12]
  assign rom_1207 = rom_data_1207; // @[irom.scala 32:12]
  assign rom_1208 = rom_data_1208; // @[irom.scala 32:12]
  assign rom_1209 = rom_data_1209; // @[irom.scala 32:12]
  assign rom_1210 = rom_data_1210; // @[irom.scala 32:12]
  assign rom_1211 = rom_data_1211; // @[irom.scala 32:12]
  assign rom_1212 = rom_data_1212; // @[irom.scala 32:12]
  assign rom_1213 = rom_data_1213; // @[irom.scala 32:12]
  assign rom_1214 = rom_data_1214; // @[irom.scala 32:12]
  assign rom_1215 = rom_data_1215; // @[irom.scala 32:12]
  assign rom_1216 = rom_data_1216; // @[irom.scala 32:12]
  assign rom_1217 = rom_data_1217; // @[irom.scala 32:12]
  assign rom_1218 = rom_data_1218; // @[irom.scala 32:12]
  assign rom_1219 = rom_data_1219; // @[irom.scala 32:12]
  assign rom_1220 = rom_data_1220; // @[irom.scala 32:12]
  assign rom_1221 = rom_data_1221; // @[irom.scala 32:12]
  assign rom_1222 = rom_data_1222; // @[irom.scala 32:12]
  assign rom_1223 = rom_data_1223; // @[irom.scala 32:12]
  assign rom_1224 = rom_data_1224; // @[irom.scala 32:12]
  assign rom_1225 = rom_data_1225; // @[irom.scala 32:12]
  assign rom_1226 = rom_data_1226; // @[irom.scala 32:12]
  assign rom_1227 = rom_data_1227; // @[irom.scala 32:12]
  assign rom_1228 = rom_data_1228; // @[irom.scala 32:12]
  assign rom_1229 = rom_data_1229; // @[irom.scala 32:12]
  assign rom_1230 = rom_data_1230; // @[irom.scala 32:12]
  assign rom_1231 = rom_data_1231; // @[irom.scala 32:12]
  assign rom_1232 = rom_data_1232; // @[irom.scala 32:12]
  assign rom_1233 = rom_data_1233; // @[irom.scala 32:12]
  assign rom_1234 = rom_data_1234; // @[irom.scala 32:12]
  assign rom_1235 = rom_data_1235; // @[irom.scala 32:12]
  assign rom_1236 = rom_data_1236; // @[irom.scala 32:12]
  assign rom_1237 = rom_data_1237; // @[irom.scala 32:12]
  assign rom_1238 = rom_data_1238; // @[irom.scala 32:12]
  assign rom_1239 = rom_data_1239; // @[irom.scala 32:12]
  assign rom_1240 = rom_data_1240; // @[irom.scala 32:12]
  assign rom_1241 = rom_data_1241; // @[irom.scala 32:12]
  assign rom_1242 = rom_data_1242; // @[irom.scala 32:12]
  assign rom_1243 = rom_data_1243; // @[irom.scala 32:12]
  assign rom_1244 = rom_data_1244; // @[irom.scala 32:12]
  assign rom_1245 = rom_data_1245; // @[irom.scala 32:12]
  assign io_irom_if_mem_rdata = rd_data_reg; // @[irom.scala 38:24]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      rd_data_reg <= 16'h0; // @[Data.scala 400:33]
    end else begin
      if(io_irom_if_mem_rd) begin
        rd_data_reg <= tmp_rd_data_reg; // @[irom.scala 36:17]
      end
    end
  end


endmodule

module tinyVcore_top (
  input               core_start,
  input               debug_en,
  input      [10:0]   debug_break_point,
  output              iram_mem_rd,
  output              iram_mem_wr,
  output     [10:0]   iram_mem_addr,
  output     [15:0]   iram_mem_wdata,
  input      [15:0]   iram_mem_rdata,
  output              highBandWidth_fb_mem_rd,
  output              highBandWidth_fb_mem_wr,
  output     [6:0]    highBandWidth_fb_mem_addr,
  output     [127:0]  highBandWidth_fb_mem_wdata,
  input      [127:0]  highBandWidth_fb_mem_rdata,
  output              highBandWidth_a_mem_rd,
  output              highBandWidth_a_mem_wr,
  output     [6:0]    highBandWidth_a_mem_addr,
  output     [127:0]  highBandWidth_a_mem_wdata,
  input      [127:0]  highBandWidth_a_mem_rdata,
  output              highBandWidth_w_mem_rd,
  output              highBandWidth_w_mem_wr,
  output     [9:0]    highBandWidth_w_mem_addr,
  output     [127:0]  highBandWidth_w_mem_wdata,
  input      [127:0]  highBandWidth_w_mem_rdata,
  output              lowBandWidth_mem_rd,
  output              lowBandWidth_mem_wr,
  output     [6:0]    lowBandWidth_mem_addr,
  output     [31:0]   lowBandWidth_mem_wdata,
  input      [31:0]   lowBandWidth_mem_rdata,
  output              core_end,
  output     [31:0]   x_0,
  output     [31:0]   x_1,
  output     [31:0]   x_2,
  output     [31:0]   x_3,
  output     [31:0]   x_4,
  output     [31:0]   x_5,
  output     [31:0]   x_6,
  output     [31:0]   x_7,
  output     [31:0]   x_8,
  output     [31:0]   x_9,
  output     [31:0]   x_10,
  output     [31:0]   x_11,
  output     [31:0]   x_12,
  output     [31:0]   x_13,
  output     [31:0]   x_14,
  output     [31:0]   x_15,
  output     [31:0]   x_16,
  output     [31:0]   x_17,
  output     [31:0]   x_18,
  output     [31:0]   x_19,
  output     [31:0]   x_20,
  output     [31:0]   x_21,
  output     [31:0]   x_22,
  output     [31:0]   x_23,
  output     [31:0]   x_24,
  output     [31:0]   x_25,
  output     [31:0]   x_26,
  output     [31:0]   x_27,
  output     [31:0]   x_28,
  output     [31:0]   x_29,
  output     [31:0]   x_30,
  output     [31:0]   x_31,
  input               clk,
  input               resetn
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
  assign iram_mem_rd = fetcher_inst_imem_rd; // @[tinyVcore_top.scala 58:18]
  assign iram_mem_addr = fetcher_inst_imem_addr; // @[tinyVcore_top.scala 59:20]
  assign pc_curr = fetcher_inst_pc_curr; // @[tinyVcore_top.scala 62:11]
  assign debug_break = ((debug_break_point == fetcher_inst_imem_addr) && debug_en); // @[tinyVcore_top.scala 65:15]
  assign iram_mem_wr = 1'b0; // @[tinyVcore_top.scala 68:18]
  assign iram_mem_wdata = 16'h0; // @[tinyVcore_top.scala 69:21]
  assign op_type = decode_inst_op_type; // @[tinyVcore_top.scala 75:11]
  assign dec_info_vld = decode_inst_dec_info_vld; // @[tinyVcore_top.scala 76:16]
  assign dec_rs1_index = decode_inst_dec_rs1_index; // @[tinyVcore_top.scala 77:7]
  assign dec_rs2_index = decode_inst_dec_rs2_index; // @[tinyVcore_top.scala 77:7]
  assign dec_rs3_index = decode_inst_dec_rs3_index; // @[tinyVcore_top.scala 77:7]
  assign dec_rd_index = decode_inst_dec_rd_index; // @[tinyVcore_top.scala 77:7]
  assign dec_imm = decode_inst_dec_imm; // @[tinyVcore_top.scala 77:7]
  assign dec_imm_is_rs2 = decode_inst_dec_imm_is_rs2; // @[tinyVcore_top.scala 77:7]
  assign dec_is_jump = decode_inst_dec_is_jump; // @[tinyVcore_top.scala 77:7]
  assign dec_is_branch = decode_inst_dec_is_branch; // @[tinyVcore_top.scala 77:7]
  assign dec_is_wload = decode_inst_dec_is_wload; // @[tinyVcore_top.scala 77:7]
  assign dec_is_wstore = decode_inst_dec_is_wstore; // @[tinyVcore_top.scala 77:7]
  assign dec_is_multi_rs1_index = decode_inst_dec_is_multi_rs1_index; // @[tinyVcore_top.scala 77:7]
  assign dec_is_multi_rd_index = decode_inst_dec_is_multi_rd_index; // @[tinyVcore_top.scala 77:7]
  assign dec_is_vector_oprand_used = decode_inst_dec_is_vector_oprand_used; // @[tinyVcore_top.scala 77:7]
  assign dec_is_vload = decode_inst_dec_is_vload; // @[tinyVcore_top.scala 77:7]
  assign dec_is_vstore1 = decode_inst_dec_is_vstore1; // @[tinyVcore_top.scala 77:7]
  assign dec_is_vstore2 = decode_inst_dec_is_vstore2; // @[tinyVcore_top.scala 77:7]
  assign fetch_break = ((((((op_type == EBREAK) || (op_type == FXMUL)) || (op_type == DIV)) || (op_type == FMSR)) || (op_type == SKIPADD)) || debug_break); // @[tinyVcore_top.scala 79:15]
  assign x_0 = regfile_inst_reg_x_0; // @[tinyVcore_top.scala 90:8]
  assign x_1 = regfile_inst_reg_x_1; // @[tinyVcore_top.scala 90:8]
  assign x_2 = regfile_inst_reg_x_2; // @[tinyVcore_top.scala 90:8]
  assign x_3 = regfile_inst_reg_x_3; // @[tinyVcore_top.scala 90:8]
  assign x_4 = regfile_inst_reg_x_4; // @[tinyVcore_top.scala 90:8]
  assign x_5 = regfile_inst_reg_x_5; // @[tinyVcore_top.scala 90:8]
  assign x_6 = regfile_inst_reg_x_6; // @[tinyVcore_top.scala 90:8]
  assign x_7 = regfile_inst_reg_x_7; // @[tinyVcore_top.scala 90:8]
  assign x_8 = regfile_inst_reg_x_8; // @[tinyVcore_top.scala 90:8]
  assign x_9 = regfile_inst_reg_x_9; // @[tinyVcore_top.scala 90:8]
  assign x_10 = regfile_inst_reg_x_10; // @[tinyVcore_top.scala 90:8]
  assign x_11 = regfile_inst_reg_x_11; // @[tinyVcore_top.scala 90:8]
  assign x_12 = regfile_inst_reg_x_12; // @[tinyVcore_top.scala 90:8]
  assign x_13 = regfile_inst_reg_x_13; // @[tinyVcore_top.scala 90:8]
  assign x_14 = regfile_inst_reg_x_14; // @[tinyVcore_top.scala 90:8]
  assign x_15 = regfile_inst_reg_x_15; // @[tinyVcore_top.scala 90:8]
  assign x_16 = regfile_inst_reg_x_16; // @[tinyVcore_top.scala 90:8]
  assign x_17 = regfile_inst_reg_x_17; // @[tinyVcore_top.scala 90:8]
  assign x_18 = regfile_inst_reg_x_18; // @[tinyVcore_top.scala 90:8]
  assign x_19 = regfile_inst_reg_x_19; // @[tinyVcore_top.scala 90:8]
  assign x_20 = regfile_inst_reg_x_20; // @[tinyVcore_top.scala 90:8]
  assign x_21 = regfile_inst_reg_x_21; // @[tinyVcore_top.scala 90:8]
  assign x_22 = regfile_inst_reg_x_22; // @[tinyVcore_top.scala 90:8]
  assign x_23 = regfile_inst_reg_x_23; // @[tinyVcore_top.scala 90:8]
  assign x_24 = regfile_inst_reg_x_24; // @[tinyVcore_top.scala 90:8]
  assign x_25 = regfile_inst_reg_x_25; // @[tinyVcore_top.scala 90:8]
  assign x_26 = regfile_inst_reg_x_26; // @[tinyVcore_top.scala 90:8]
  assign x_27 = regfile_inst_reg_x_27; // @[tinyVcore_top.scala 90:8]
  assign x_28 = regfile_inst_reg_x_28; // @[tinyVcore_top.scala 90:8]
  assign x_29 = regfile_inst_reg_x_29; // @[tinyVcore_top.scala 90:8]
  assign x_30 = regfile_inst_reg_x_30; // @[tinyVcore_top.scala 90:8]
  assign x_31 = regfile_inst_reg_x_31; // @[tinyVcore_top.scala 90:8]
  assign forwarding_id_ld_rs1 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == regfile_inst_roperand_out_rs1_index)); // @[BaseType.scala 305:24]
  assign forwarding_id_ld_rs2 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == regfile_inst_roperand_out_rs2_index)); // @[BaseType.scala 305:24]
  assign forwarding_id_ld_rs3 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == regfile_inst_roperand_out_rs3_index)); // @[BaseType.scala 305:24]
  assign forwarding_id_ld_vs1 = ((lsu_write_rd_vld && lsu_write_rd_is_vector) && (lsu_write_rd_index == regfile_inst_voperand_out_vs1_index)); // @[BaseType.scala 305:24]
  assign forwarding_id_ld_vs2 = ((lsu_write_rd_vld && lsu_write_rd_is_vector) && (lsu_write_rd_index == regfile_inst_voperand_out_vs2_index)); // @[BaseType.scala 305:24]
  assign forwarding_alu_rs1 = (alu_write_rd_vld && (alu_write_rd_index == regfile_inst_roperand_out_rs1_index)); // @[BaseType.scala 305:24]
  assign forwarding_alu_rs2 = (alu_write_rd_vld && (alu_write_rd_index == regfile_inst_roperand_out_rs2_index)); // @[BaseType.scala 305:24]
  assign forwarding_alu_rs3 = (alu_write_rd_vld && (alu_write_rd_index == regfile_inst_roperand_out_rs3_index)); // @[BaseType.scala 305:24]
  assign fd_id_roperand_reg_in_rs1 = (forwarding_alu_rs1 ? alu_write_rd_data : (forwarding_id_ld_rs1 ? lsu_write_rd_data : regfile_inst_roperand_out_rs1)); // @[tinyVcore_top.scala 116:29]
  assign fd_id_roperand_reg_in_rs2 = (forwarding_alu_rs2 ? alu_write_rd_data : (forwarding_id_ld_rs2 ? lsu_write_rd_data : regfile_inst_roperand_out_rs2)); // @[tinyVcore_top.scala 117:29]
  assign fd_id_roperand_reg_in_rs3 = (forwarding_alu_rs3 ? alu_write_rd_data : (forwarding_id_ld_rs3 ? lsu_write_rd_data : regfile_inst_roperand_out_rs3)); // @[tinyVcore_top.scala 118:29]
  assign fd_id_roperand_reg_in_rs1_index = regfile_inst_roperand_out_rs1_index; // @[tinyVcore_top.scala 119:35]
  assign fd_id_roperand_reg_in_rs2_index = regfile_inst_roperand_out_rs2_index; // @[tinyVcore_top.scala 120:35]
  assign fd_id_roperand_reg_in_rs3_index = regfile_inst_roperand_out_rs3_index; // @[tinyVcore_top.scala 121:35]
  assign fd_id_roperand_reg_in_rd_index = regfile_inst_roperand_out_rd_index; // @[tinyVcore_top.scala 122:34]
  assign fd_id_voperand_reg_in_vs2 = (forwarding_id_ld_vs2 ? lsu_write_rd_vector_data : regfile_inst_voperand_out_vs2); // @[tinyVcore_top.scala 124:29]
  assign fd_id_voperand_reg_in_vs1 = (forwarding_id_ld_vs1 ? lsu_write_rd_vector_data : regfile_inst_voperand_out_vs1); // @[tinyVcore_top.scala 125:29]
  assign fd_id_voperand_reg_in_vs1_index = regfile_inst_voperand_out_vs1_index; // @[tinyVcore_top.scala 126:35]
  assign fd_id_voperand_reg_in_vs2_index = regfile_inst_voperand_out_vs2_index; // @[tinyVcore_top.scala 127:35]
  assign forwarding_id_ex_rs1 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == s1_roperand_out_regs_rs1_index)); // @[BaseType.scala 305:24]
  assign forwarding_id_ex_rs2 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == s1_roperand_out_regs_rs2_index)); // @[BaseType.scala 305:24]
  assign forwarding_id_ex_rs3 = ((lsu_write_rd_vld && (! lsu_write_rd_is_vector)) && (lsu_write_rd_index == s1_roperand_out_regs_rs3_index)); // @[BaseType.scala 305:24]
  assign fd_ex_roperand_reg_in_rs1 = (forwarding_id_ex_rs1 ? lsu_write_rd_data : s1_roperand_out_regs_rs1); // @[tinyVcore_top.scala 137:29]
  assign fd_ex_roperand_reg_in_rs2 = (forwarding_id_ex_rs2 ? lsu_write_rd_data : s1_roperand_out_regs_rs2); // @[tinyVcore_top.scala 138:29]
  assign fd_ex_roperand_reg_in_rs3 = (forwarding_id_ex_rs3 ? lsu_write_rd_data : s1_roperand_out_regs_rs3); // @[tinyVcore_top.scala 139:29]
  assign fd_ex_roperand_reg_in_rs1_index = s1_roperand_out_regs_rs1_index; // @[tinyVcore_top.scala 140:35]
  assign fd_ex_roperand_reg_in_rs2_index = s1_roperand_out_regs_rs2_index; // @[tinyVcore_top.scala 141:35]
  assign fd_ex_roperand_reg_in_rs3_index = s1_roperand_out_regs_rs3_index; // @[tinyVcore_top.scala 142:35]
  assign fd_ex_roperand_reg_in_rd_index = s1_roperand_out_regs_rd_index; // @[tinyVcore_top.scala 143:34]
  assign fd_ex_voperand_reg_in_vs2 = s1_voperand_out_regs_vs2; // @[tinyVcore_top.scala 150:29]
  assign fd_ex_voperand_reg_in_vs1 = s1_voperand_out_regs_vs1; // @[tinyVcore_top.scala 151:29]
  assign fd_ex_voperand_reg_in_vs1_index = s1_voperand_out_regs_vs1_index; // @[tinyVcore_top.scala 152:35]
  assign fd_ex_voperand_reg_in_vs2_index = s1_voperand_out_regs_vs2_index; // @[tinyVcore_top.scala 153:35]
  assign tmp_s1_op_type_regs_1 = 6'h0; // @[Enum.scala 186:17]
  assign tmp_s1_op_type_regs = tmp_s1_op_type_regs_1; // @[Enum.scala 188:10]
  assign alu_inst_is_branch_or_jump = (s1_dec_regs_is_branch || s1_dec_regs_is_jump); // @[tinyVcore_top.scala 184:33]
  assign branch_taken_addr = alu_inst_branch_taken_addr; // @[tinyVcore_top.scala 186:16]
  assign branch_taken_vld = alu_inst_branch_taken_vld; // @[tinyVcore_top.scala 186:16]
  assign alu_write_rd_data = alu_inst_alu_write_rd_data; // @[tinyVcore_top.scala 188:16]
  assign alu_write_rd_index = alu_inst_alu_write_rd_index; // @[tinyVcore_top.scala 188:16]
  assign alu_write_rd_vld = alu_inst_alu_write_rd_vld; // @[tinyVcore_top.scala 188:16]
  assign result_vld_out = alu_inst_result_vld_out; // @[tinyVcore_top.scala 190:18]
  assign to_lsu_addr = alu_inst_to_lsu_addr; // @[tinyVcore_top.scala 191:10]
  assign to_lsu_addr_vld = alu_inst_to_lsu_addr_vld; // @[tinyVcore_top.scala 191:10]
  assign to_lsu_is_vector = alu_inst_to_lsu_is_vector; // @[tinyVcore_top.scala 191:10]
  assign core_end = alu_inst_ebreak; // @[tinyVcore_top.scala 193:15]
  assign fetch_restore = (((! fetcher_inst_instr_valid) && result_vld_out) || ((! debug_en) && debug_en_regNext)); // @[tinyVcore_top.scala 195:17]
  assign lsu_inst_is_vstore = (s1_dec_regs_is_vstore1 || s1_dec_regs_is_vstore2); // @[tinyVcore_top.scala 203:25]
  assign highBandWidth_fb_mem_rd = lsu_inst_highBandWidth_fb_mem_rd; // @[tinyVcore_top.scala 204:23]
  assign highBandWidth_fb_mem_wr = lsu_inst_highBandWidth_fb_mem_wr; // @[tinyVcore_top.scala 204:23]
  assign highBandWidth_fb_mem_addr = lsu_inst_highBandWidth_fb_mem_addr; // @[tinyVcore_top.scala 204:23]
  assign highBandWidth_fb_mem_wdata = lsu_inst_highBandWidth_fb_mem_wdata; // @[tinyVcore_top.scala 204:23]
  assign highBandWidth_a_mem_rd = lsu_inst_highBandWidth_a_mem_rd; // @[tinyVcore_top.scala 205:22]
  assign highBandWidth_a_mem_wr = lsu_inst_highBandWidth_a_mem_wr; // @[tinyVcore_top.scala 205:22]
  assign highBandWidth_a_mem_addr = lsu_inst_highBandWidth_a_mem_addr; // @[tinyVcore_top.scala 205:22]
  assign highBandWidth_a_mem_wdata = lsu_inst_highBandWidth_a_mem_wdata; // @[tinyVcore_top.scala 205:22]
  assign highBandWidth_w_mem_rd = lsu_inst_highBandWidth_w_mem_rd; // @[tinyVcore_top.scala 206:22]
  assign highBandWidth_w_mem_wr = lsu_inst_highBandWidth_w_mem_wr; // @[tinyVcore_top.scala 206:22]
  assign highBandWidth_w_mem_addr = lsu_inst_highBandWidth_w_mem_addr; // @[tinyVcore_top.scala 206:22]
  assign highBandWidth_w_mem_wdata = lsu_inst_highBandWidth_w_mem_wdata; // @[tinyVcore_top.scala 206:22]
  assign lowBandWidth_mem_rd = lsu_inst_lowBandWidth_mem_rd; // @[tinyVcore_top.scala 207:19]
  assign lowBandWidth_mem_wr = lsu_inst_lowBandWidth_mem_wr; // @[tinyVcore_top.scala 207:19]
  assign lowBandWidth_mem_addr = lsu_inst_lowBandWidth_mem_addr; // @[tinyVcore_top.scala 207:19]
  assign lowBandWidth_mem_wdata = lsu_inst_lowBandWidth_mem_wdata; // @[tinyVcore_top.scala 207:19]
  assign lsu_inst_access_mem_wr_sdata = (forwarding_alu_rs3 ? alu_write_rd_data : ((forwarding_id_ld_rs3 || forwarding_id_ex_rs3) ? lsu_write_rd_data : s1_roperand_out_regs_rs3)); // @[tinyVcore_top.scala 213:35]
  assign lsu_write_rd_data = lsu_inst_lsu_write_rd_data; // @[tinyVcore_top.scala 218:16]
  assign lsu_write_rd_index = lsu_inst_lsu_write_rd_index; // @[tinyVcore_top.scala 218:16]
  assign lsu_write_rd_vld = lsu_inst_lsu_write_rd_vld; // @[tinyVcore_top.scala 218:16]
  assign lsu_write_rd_is_vector = lsu_inst_lsu_write_rd_is_vector; // @[tinyVcore_top.scala 218:16]
  assign lsu_write_rd_vector_data = lsu_inst_lsu_write_rd_vector_data; // @[tinyVcore_top.scala 218:16]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      s1_oprand_vld_out_regs <= 1'b0; // @[Data.scala 400:33]
      s1_op_type_regs <= ILLEGAL; // @[Data.scala 400:33]
      s1_pc_curr_reg <= 11'h098; // @[Data.scala 400:33]
      s1_roperand_out_regs_rs1 <= 32'h0; // @[Data.scala 400:33]
      s1_roperand_out_regs_rs1_index <= 5'h0; // @[Data.scala 400:33]
      s1_roperand_out_regs_rs2 <= 32'h0; // @[Data.scala 400:33]
      s1_roperand_out_regs_rs2_index <= 5'h0; // @[Data.scala 400:33]
      s1_roperand_out_regs_rs3 <= 32'h0; // @[Data.scala 400:33]
      s1_roperand_out_regs_rs3_index <= 5'h0; // @[Data.scala 400:33]
      s1_roperand_out_regs_rd_index <= 5'h0; // @[Data.scala 400:33]
      s1_voperand_out_regs_vs1 <= 128'h0; // @[Data.scala 400:33]
      s1_voperand_out_regs_vs2 <= 128'h0; // @[Data.scala 400:33]
      s1_voperand_out_regs_vs1_index <= 5'h0; // @[Data.scala 400:33]
      s1_voperand_out_regs_vs2_index <= 5'h0; // @[Data.scala 400:33]
      s1_dec_regs_rs1_index <= 5'h0; // @[Data.scala 400:33]
      s1_dec_regs_rs2_index <= 5'h0; // @[Data.scala 400:33]
      s1_dec_regs_rs3_index <= 5'h0; // @[Data.scala 400:33]
      s1_dec_regs_rd_index <= 5'h0; // @[Data.scala 400:33]
      s1_dec_regs_imm <= 32'h0; // @[Data.scala 400:33]
      s1_dec_regs_imm_is_rs2 <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_jump <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_branch <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_wload <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_wstore <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_multi_rs1_index <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_multi_rd_index <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_vector_oprand_used <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_vload <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_vstore1 <= 1'b0; // @[Data.scala 400:33]
      s1_dec_regs_is_vstore2 <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(branch_taken_vld) begin
        s1_roperand_out_regs_rs1 <= 32'h0; // @[utils.scala 82:9]
        s1_roperand_out_regs_rs1_index <= 5'h0; // @[utils.scala 82:9]
        s1_roperand_out_regs_rs2 <= 32'h0; // @[utils.scala 82:9]
        s1_roperand_out_regs_rs2_index <= 5'h0; // @[utils.scala 82:9]
        s1_roperand_out_regs_rs3 <= 32'h0; // @[utils.scala 82:9]
        s1_roperand_out_regs_rs3_index <= 5'h0; // @[utils.scala 82:9]
        s1_roperand_out_regs_rd_index <= 5'h0; // @[utils.scala 82:9]
        s1_voperand_out_regs_vs1 <= 128'h0; // @[utils.scala 82:9]
        s1_voperand_out_regs_vs2 <= 128'h0; // @[utils.scala 82:9]
        s1_voperand_out_regs_vs1_index <= 5'h0; // @[utils.scala 82:9]
        s1_voperand_out_regs_vs2_index <= 5'h0; // @[utils.scala 82:9]
        s1_oprand_vld_out_regs <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_rs1_index <= 5'h0; // @[utils.scala 82:9]
        s1_dec_regs_rs2_index <= 5'h0; // @[utils.scala 82:9]
        s1_dec_regs_rs3_index <= 5'h0; // @[utils.scala 82:9]
        s1_dec_regs_rd_index <= 5'h0; // @[utils.scala 82:9]
        s1_dec_regs_imm <= 32'h0; // @[utils.scala 82:9]
        s1_dec_regs_imm_is_rs2 <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_jump <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_branch <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_wload <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_wstore <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_multi_rs1_index <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_multi_rd_index <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_vector_oprand_used <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_vload <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_vstore1 <= 1'b0; // @[utils.scala 82:9]
        s1_dec_regs_is_vstore2 <= 1'b0; // @[utils.scala 82:9]
        s1_op_type_regs <= tmp_s1_op_type_regs; // @[utils.scala 82:9]
      end else begin
        if(dec_info_vld) begin
          s1_roperand_out_regs_rs1 <= fd_id_roperand_reg_in_rs1; // @[tinyVcore_top.scala 165:26]
          s1_roperand_out_regs_rs1_index <= fd_id_roperand_reg_in_rs1_index; // @[tinyVcore_top.scala 165:26]
          s1_roperand_out_regs_rs2 <= fd_id_roperand_reg_in_rs2; // @[tinyVcore_top.scala 165:26]
          s1_roperand_out_regs_rs2_index <= fd_id_roperand_reg_in_rs2_index; // @[tinyVcore_top.scala 165:26]
          s1_roperand_out_regs_rs3 <= fd_id_roperand_reg_in_rs3; // @[tinyVcore_top.scala 165:26]
          s1_roperand_out_regs_rs3_index <= fd_id_roperand_reg_in_rs3_index; // @[tinyVcore_top.scala 165:26]
          s1_roperand_out_regs_rd_index <= fd_id_roperand_reg_in_rd_index; // @[tinyVcore_top.scala 165:26]
          s1_voperand_out_regs_vs1 <= fd_id_voperand_reg_in_vs1; // @[tinyVcore_top.scala 166:26]
          s1_voperand_out_regs_vs2 <= fd_id_voperand_reg_in_vs2; // @[tinyVcore_top.scala 166:26]
          s1_voperand_out_regs_vs1_index <= fd_id_voperand_reg_in_vs1_index; // @[tinyVcore_top.scala 166:26]
          s1_voperand_out_regs_vs2_index <= fd_id_voperand_reg_in_vs2_index; // @[tinyVcore_top.scala 166:26]
          s1_oprand_vld_out_regs <= regfile_inst_oprand_vld_out; // @[tinyVcore_top.scala 167:28]
          s1_dec_regs_rs1_index <= dec_rs1_index; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_rs2_index <= dec_rs2_index; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_rs3_index <= dec_rs3_index; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_rd_index <= dec_rd_index; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_imm <= dec_imm; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_imm_is_rs2 <= dec_imm_is_rs2; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_jump <= dec_is_jump; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_branch <= dec_is_branch; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_wload <= dec_is_wload; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_wstore <= dec_is_wstore; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_multi_rs1_index <= dec_is_multi_rs1_index; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_multi_rd_index <= dec_is_multi_rd_index; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_vector_oprand_used <= dec_is_vector_oprand_used; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_vload <= dec_is_vload; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_vstore1 <= dec_is_vstore1; // @[tinyVcore_top.scala 168:17]
          s1_dec_regs_is_vstore2 <= dec_is_vstore2; // @[tinyVcore_top.scala 168:17]
          s1_op_type_regs <= op_type; // @[tinyVcore_top.scala 169:21]
          s1_pc_curr_reg <= pc_curr; // @[tinyVcore_top.scala 170:20]
        end
      end
    end
  end

  always @(posedge clk) begin
    debug_en_regNext <= debug_en; // @[Reg.scala 39:30]
  end


endmodule

//ck_enable_gen_5 replaced by ck_enable_gen_5

//ck_enable_gen_5 replaced by ck_enable_gen_5

//ck_enable_gen_5 replaced by ck_enable_gen_5

//ck_enable_gen_5 replaced by ck_enable_gen_5

module ck_enable_gen_5 (
  input               start,
  input               finish,
  output              enable_out,
  input               clk,
  input               resetn
);

  reg                 en_reg;

  assign enable_out = (start || en_reg); // @[ck_enable_gen.scala 24:17]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      en_reg <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(start) begin
        en_reg <= 1'b1; // @[ck_enable_gen.scala 20:12]
      end else begin
        if(finish) begin
          en_reg <= 1'b0; // @[ck_enable_gen.scala 22:12]
        end
      end
    end
  end


endmodule

module quant8 (
  input               start,
  output              finish,
  input      [15:0]   rg_fbank_quant_scale,
  input      [7:0]    rg_fbank_quant_zerpoint,
  input      [4:0]    rg_fbank_quant_shift,
  output              mulif_din_vld,
  output reg [31:0]   mulif_dinA,
  output reg [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [47:0]   mulif_dout,
  output reg          pcm_memif_rd,
  output              pcm_memif_wr,
  output reg [7:0]    pcm_memif_addr,
  output     [31:0]   pcm_memif_wdata,
  input      [31:0]   pcm_memif_rdata,
  output              lmfb_memif_rd,
  output reg          lmfb_memif_wr,
  output reg [6:0]    lmfb_memif_addr,
  output reg [127:0]  lmfb_memif_wdata,
  input      [127:0]  lmfb_memif_rdata,
  output     [7:0]    lmfb_uint8_out,
  output     [6:0]    lmfb_write_addr,
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam LOADDATA = 2'd1;
  localparam QUANTMUL = 2'd2;
  localparam STOREDATA = 2'd3;

  wire       [23:0]   rdeven_dout;
  wire       [23:0]   tmp_lmfb_uint8_out;
  wire       [23:0]   tmp_lmfb_uint8_out_1;
  wire       [31:0]   tmp_mulif_dinA;
  wire       [15:0]   tmp_mulif_dinA_1;
  wire       [31:0]   tmp_mulif_dinB;
  reg        [7:0]    lmfb_buffer_0;
  reg        [7:0]    lmfb_buffer_1;
  reg        [7:0]    lmfb_buffer_2;
  reg        [7:0]    lmfb_buffer_3;
  reg        [7:0]    lmfb_buffer_4;
  reg        [7:0]    lmfb_buffer_5;
  reg        [7:0]    lmfb_buffer_6;
  reg        [7:0]    lmfb_buffer_7;
  reg        [7:0]    lmfb_buffer_8;
  reg        [7:0]    lmfb_buffer_9;
  reg        [7:0]    lmfb_buffer_10;
  reg        [7:0]    lmfb_buffer_11;
  reg        [7:0]    lmfb_buffer_12;
  reg        [7:0]    lmfb_buffer_13;
  reg        [7:0]    lmfb_buffer_14;
  reg        [7:0]    lmfb_buffer_15;
  wire       [127:0]  lmfb_mem_wr_line;
  reg        [4:0]    lmfb_cnt;
  reg        [3:0]    lmfb_line_cnt;
  reg        [1:0]    store_cnt;
  reg        [6:0]    lmfb_mem_addr;
  reg        [32:0]   unclamped_fbank;
  wire       [23:0]   shifted_fbank;
  wire                lmfb_cnt_ov;
  wire                lmfb_line_cnt_ov;
  wire                store_cnt_ov;
  wire                lmfb_mem_addr_ov;
  reg        [1:0]    next_state;
  reg        [1:0]    curr_state;
  reg                 start_mul;
  wire       [7:0]    tmp_pcm_memif_addr;
  reg        [7:0]    tmp_pcm_memif_addr_1;
  wire       [15:0]   tmp_1;
  wire       [7:0]    tmp_lmfb_buffer_0;

  assign tmp_lmfb_uint8_out = (shifted_fbank + tmp_lmfb_uint8_out_1);
  assign tmp_lmfb_uint8_out_1 = {16'd0, rg_fbank_quant_zerpoint};
  assign tmp_mulif_dinA_1 = rg_fbank_quant_scale;
  assign tmp_mulif_dinA = {16'd0, tmp_mulif_dinA_1};
  assign tmp_mulif_dinB = pcm_memif_rdata;
  Round2Even rdeven (
    .din  (unclamped_fbank[32:0]), //i
    .dout (rdeven_dout[23:0]    )  //o
  );
  assign lmfb_mem_wr_line = {{{{{{{{{{{{{{{lmfb_buffer_15,lmfb_buffer_14},lmfb_buffer_13},lmfb_buffer_12},lmfb_buffer_11},lmfb_buffer_10},lmfb_buffer_9},lmfb_buffer_8},lmfb_buffer_7},lmfb_buffer_6},lmfb_buffer_5},lmfb_buffer_4},lmfb_buffer_3},lmfb_buffer_2},lmfb_buffer_1},lmfb_buffer_0}; // @[quant8.scala 54:20]
  assign shifted_fbank = ($signed(rdeven_dout) >>> rg_fbank_quant_shift); // @[quant8.scala 64:16]
  assign lmfb_uint8_out = tmp_lmfb_uint8_out[7 : 0]; // @[quant8.scala 65:21]
  assign lmfb_write_addr = lmfb_mem_addr; // @[quant8.scala 67:22]
  assign lmfb_cnt_ov = (lmfb_cnt == 5'h1d); // @[BaseType.scala 305:24]
  assign lmfb_line_cnt_ov = ((lmfb_line_cnt == 4'b1111) || lmfb_cnt_ov); // @[BaseType.scala 305:24]
  assign store_cnt_ov = (store_cnt == 2'b01); // @[BaseType.scala 305:24]
  assign lmfb_mem_addr_ov = (lmfb_mem_addr == 7'h77); // @[BaseType.scala 305:24]
  assign lmfb_memif_rd = 1'b0; // @[quant8.scala 78:20]
  always @(*) begin
    lmfb_memif_wr = 1'b0; // @[quant8.scala 79:20]
    if(!(curr_state == LOADDATA)) begin
      if((curr_state == STOREDATA)) begin
        lmfb_memif_wr = 1'b1; // @[quant8.scala 43:22]
      end
    end
  end

  always @(*) begin
    lmfb_memif_addr = 7'h0; // @[quant8.scala 80:22]
    if(!(curr_state == LOADDATA)) begin
      if((curr_state == STOREDATA)) begin
        lmfb_memif_addr = lmfb_mem_addr; // @[quant8.scala 44:24]
      end
    end
  end

  always @(*) begin
    lmfb_memif_wdata = 128'h0; // @[quant8.scala 81:23]
    if(!(curr_state == LOADDATA)) begin
      if((curr_state == STOREDATA)) begin
        lmfb_memif_wdata = lmfb_mem_wr_line; // @[quant8.scala 45:25]
      end
    end
  end

  always @(*) begin
    pcm_memif_rd = 1'b0; // @[quant8.scala 83:19]
    if((curr_state == LOADDATA)) begin
      pcm_memif_rd = 1'b1; // @[quant8.scala 48:21]
    end
  end

  assign pcm_memif_wr = 1'b0; // @[quant8.scala 84:19]
  always @(*) begin
    pcm_memif_addr = 8'h0; // @[quant8.scala 85:21]
    if((curr_state == LOADDATA)) begin
      pcm_memif_addr = tmp_pcm_memif_addr_1; // @[quant8.scala 49:23]
    end
  end

  assign pcm_memif_wdata = 32'h0; // @[quant8.scala 86:22]
  assign tmp_pcm_memif_addr = {3'd0, lmfb_cnt}; // @[BaseType.scala 299:24]
  always @(*) begin
    tmp_pcm_memif_addr_1[0] = tmp_pcm_memif_addr[7]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[1] = tmp_pcm_memif_addr[6]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[2] = tmp_pcm_memif_addr[5]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[3] = tmp_pcm_memif_addr[4]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[4] = tmp_pcm_memif_addr[3]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[5] = tmp_pcm_memif_addr[2]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[6] = tmp_pcm_memif_addr[1]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[7] = tmp_pcm_memif_addr[0]; // @[Utils.scala 432:14]
  end

  assign mulif_din_vld = start_mul; // @[quant8.scala 93:20]
  always @(*) begin
    mulif_dinA = 32'h0; // @[quant8.scala 94:17]
    if(start_mul) begin
      mulif_dinA = tmp_mulif_dinA; // @[quant8.scala 97:19]
    end
  end

  always @(*) begin
    mulif_dinB = 16'h0; // @[quant8.scala 95:17]
    if(start_mul) begin
      mulif_dinB = tmp_mulif_dinB[15:0]; // @[quant8.scala 98:19]
    end
  end

  always @(*) begin
    unclamped_fbank = 33'h0; // @[quant8.scala 114:19]
    if(((curr_state == QUANTMUL) && mulif_dout_vld)) begin
      unclamped_fbank = mulif_dout[32 : 0]; // @[quant8.scala 116:21]
    end
  end

  assign tmp_1 = ({15'd0,1'b1} <<< lmfb_line_cnt); // @[BaseType.scala 299:24]
  assign tmp_lmfb_buffer_0 = lmfb_uint8_out; // @[BaseType.scala 318:22]
  assign finish = ((curr_state == STOREDATA) && (next_state == IDLE)); // @[quant8.scala 136:13]
  always @(*) begin
    next_state = curr_state; // @[quant8.scala 138:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = LOADDATA; // @[Enum.scala 148:67]
        end
      end
      LOADDATA : begin
        next_state = QUANTMUL; // @[Enum.scala 148:67]
      end
      QUANTMUL : begin
        if((mulif_dout_vld && (! lmfb_line_cnt_ov))) begin
          next_state = LOADDATA; // @[Enum.scala 148:67]
        end else begin
          if((mulif_dout_vld && lmfb_line_cnt_ov)) begin
            next_state = STOREDATA; // @[Enum.scala 148:67]
          end
        end
      end
      default : begin
        if(store_cnt_ov) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          next_state = LOADDATA; // @[Enum.scala 148:67]
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      lmfb_buffer_0 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_1 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_2 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_3 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_4 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_5 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_6 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_7 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_8 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_9 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_10 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_11 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_12 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_13 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_14 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_15 <= 8'h0; // @[Data.scala 400:33]
      lmfb_cnt <= 5'h0; // @[Data.scala 400:33]
      lmfb_line_cnt <= 4'b0000; // @[Data.scala 400:33]
      store_cnt <= 2'b00; // @[Data.scala 400:33]
      lmfb_mem_addr <= 7'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      start_mul <= 1'b0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      start_mul <= ((curr_state == LOADDATA) && (next_state == QUANTMUL)); // @[Reg.scala 39:30]
      if((curr_state == STOREDATA)) begin
        if(store_cnt_ov) begin
          store_cnt <= 2'b00; // @[quant8.scala 103:17]
        end else begin
          store_cnt <= (store_cnt + 2'b01); // @[quant8.scala 105:17]
        end
        if(lmfb_mem_addr_ov) begin
          lmfb_mem_addr <= 7'h0; // @[quant8.scala 108:21]
        end else begin
          lmfb_mem_addr <= (lmfb_mem_addr + 7'h01); // @[quant8.scala 110:21]
        end
      end
      if(((curr_state == QUANTMUL) && mulif_dout_vld)) begin
        if(lmfb_line_cnt_ov) begin
          lmfb_line_cnt <= 4'b0000; // @[quant8.scala 118:21]
        end else begin
          lmfb_line_cnt <= (lmfb_line_cnt + 4'b0001); // @[quant8.scala 120:21]
        end
        if(lmfb_cnt_ov) begin
          lmfb_cnt <= 5'h0; // @[quant8.scala 123:16]
        end else begin
          lmfb_cnt <= (lmfb_cnt + 5'h01); // @[quant8.scala 125:16]
        end
      end
      if(((curr_state == QUANTMUL) && mulif_dout_vld)) begin
        if(tmp_1[0]) begin
          lmfb_buffer_0 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[1]) begin
          lmfb_buffer_1 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[2]) begin
          lmfb_buffer_2 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[3]) begin
          lmfb_buffer_3 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[4]) begin
          lmfb_buffer_4 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[5]) begin
          lmfb_buffer_5 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[6]) begin
          lmfb_buffer_6 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[7]) begin
          lmfb_buffer_7 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[8]) begin
          lmfb_buffer_8 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[9]) begin
          lmfb_buffer_9 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[10]) begin
          lmfb_buffer_10 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[11]) begin
          lmfb_buffer_11 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[12]) begin
          lmfb_buffer_12 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[13]) begin
          lmfb_buffer_13 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[14]) begin
          lmfb_buffer_14 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[15]) begin
          lmfb_buffer_15 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
      end else begin
        if((curr_state == STOREDATA)) begin
          lmfb_buffer_14 <= 8'h0; // @[quant8.scala 131:21]
          lmfb_buffer_15 <= 8'h0; // @[quant8.scala 132:21]
        end
      end
    end
  end


endmodule

module cordic_ln (
  input               start,
  output              finish,
  output reg          memif_rd,
  output reg          memif_wr,
  output reg [7:0]    memif_addr,
  output reg [31:0]   memif_wdata,
  input      [31:0]   memif_rdata,
  output     [15:0]   cordic_ln_out,
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam LOADDATA = 2'd1;
  localparam CORDIC = 2'd2;
  localparam STOREDATA = 2'd3;

  wire       [15:0]   rdsat_dout;
  wire       [18:0]   tmp_tmp_ln_x_to_lg;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_5;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_5_1;
  wire       [3:0]    tmp_when;
  wire       [15:0]   tmp_tmp_ln_x_to_lg_7;
  wire       [15:0]   tmp_tmp_ln_x_to_lg_7_1;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_1;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_1_1;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  reg        [3:0]    tmp_tmp_xi;
  wire       [3:0]    tmp_tmp_xi_1;
  wire       [24:0]   tmp_xi_2;
  wire       [24:0]   tmp_xi_3;
  wire       [3:0]    tmp_tmp_yi;
  wire       [24:0]   tmp_yi_1;
  wire       [24:0]   tmp_yi_2;
  wire       [24:0]   tmp_xi_4;
  wire       [24:0]   tmp_yi_3;
  reg        [15:0]   tmp_ei;
  wire       [19:0]   tmp_tmp_z_reg;
  wire       [19:0]   tmp_tmp_z_reg_1;
  wire       [19:0]   tmp_tmp_z_reg_2;
  wire       [20:0]   tmp_tmp_z_reg_1_1;
  wire       [20:0]   tmp_tmp_z_reg_1_2;
  wire       [1:0]    tmp_when_3;
  wire       [0:0]    tmp_when_4;
  wire       [24:0]   tmp_tmp_x_reg;
  wire       [24:0]   tmp_tmp_x_reg_1;
  wire       [24:0]   tmp_tmp_x_reg_2;
  wire       [25:0]   tmp_tmp_x_reg_1_1;
  wire       [24:0]   tmp_tmp_x_reg_1_2;
  wire       [25:0]   tmp_tmp_x_reg_1_3;
  wire       [2:0]    tmp_when_5;
  wire       [1:0]    tmp_when_6;
  wire       [24:0]   tmp_tmp_y_reg;
  wire       [24:0]   tmp_tmp_y_reg_1;
  wire       [24:0]   tmp_tmp_y_reg_2;
  wire       [25:0]   tmp_tmp_y_reg_1_1;
  wire       [24:0]   tmp_tmp_y_reg_1_2;
  wire       [25:0]   tmp_tmp_y_reg_1_3;
  wire       [2:0]    tmp_when_7;
  wire       [1:0]    tmp_when_8;
  wire       [23:0]   tmp_x_reg_3;
  wire       [23:0]   tmp_x_reg_4;
  wire       [23:0]   tmp_x_reg_5;
  wire       [23:0]   tmp_x_reg_6;
  wire       [23:0]   tmp_y_reg_3;
  wire       [23:0]   tmp_y_reg_4;
  wire       [23:0]   tmp_y_reg_5;
  wire       [23:0]   tmp_y_reg_6;
  wire       [31:0]   tmp_memif_wdata;
  wire       [3:0]    iters_0;
  wire       [3:0]    iters_1;
  wire       [3:0]    iters_2;
  wire       [3:0]    iters_3;
  wire       [3:0]    iters_4;
  wire       [3:0]    iters_5;
  wire       [3:0]    iters_6;
  wire       [3:0]    iters_7;
  wire       [3:0]    iters_8;
  wire       [3:0]    iters_9;
  wire       [3:0]    iters_10;
  wire       [3:0]    iters_11;
  wire       [15:0]   e_data_0;
  wire       [15:0]   e_data_1;
  wire       [15:0]   e_data_2;
  wire       [15:0]   e_data_3;
  wire       [15:0]   e_data_4;
  wire       [15:0]   e_data_5;
  wire       [15:0]   e_data_6;
  wire       [15:0]   e_data_7;
  wire       [15:0]   e_data_8;
  wire       [15:0]   e_data_9;
  wire       [15:0]   e_data_10;
  wire       [15:0]   e_data_11;
  reg        [23:0]   x_reg;
  reg        [23:0]   y_reg;
  reg        [19:0]   z_reg;
  reg        [24:0]   xi;
  reg        [24:0]   yi;
  wire                di;
  reg        [3:0]    cnt;
  reg        [4:0]    mel_addr;
  wire       [15:0]   ln_out;
  wire       [20:0]   zreg_mul2;
  wire       [18:0]   ln_x_shift1;
  wire       [18:0]   tmp_ln_x_to_lg;
  reg        [15:0]   tmp_ln_x_to_lg_1;
  wire       [18:0]   tmp_ln_x_to_lg_2;
  wire       [18:0]   tmp_ln_x_to_lg_3;
  wire       [18:0]   tmp_ln_x_to_lg_4;
  wire       [19:0]   tmp_ln_x_to_lg_5;
  wire       [18:0]   tmp_ln_x_to_lg_6;
  reg        [15:0]   tmp_ln_x_to_lg_7;
  reg        [14:0]   ln_x_to_lg;
  wire                mel_addr_ov;
  wire                cordic_end;
  reg        [1:0]    next_state;
  reg        [1:0]    curr_state;
  wire                load_stin;
  reg                 store_en;
  reg                 store_en_delay;
  wire       [3:0]    tmp_xi;
  wire       [23:0]   tmp_xi_1;
  wire       [23:0]   tmp_yi;
  wire       [19:0]   ei;
  wire       [19:0]   tmp_z_reg;
  wire       [20:0]   tmp_z_reg_1;
  reg        [19:0]   tmp_z_reg_2;
  wire       [24:0]   tmp_x_reg;
  wire       [25:0]   tmp_x_reg_1;
  reg        [23:0]   tmp_x_reg_2;
  wire       [24:0]   tmp_y_reg;
  wire       [25:0]   tmp_y_reg_1;
  reg        [23:0]   tmp_y_reg_2;
  wire       [7:0]    tmp_memif_addr;
  reg        [7:0]    tmp_memif_addr_1;
  wire       [7:0]    tmp_memif_addr_2;
  reg        [7:0]    tmp_memif_addr_3;

  assign tmp_tmp_ln_x_to_lg = {{3{ln_out[15]}}, ln_out};
  assign tmp_tmp_ln_x_to_lg_5 = {tmp_ln_x_to_lg_4[18],tmp_ln_x_to_lg_4};
  assign tmp_tmp_ln_x_to_lg_5_1 = {tmp_ln_x_to_lg_3[18],tmp_ln_x_to_lg_3};
  assign tmp_when = tmp_ln_x_to_lg_5[3 : 0];
  assign tmp_tmp_ln_x_to_lg_7 = tmp_ln_x_to_lg_5[19 : 4];
  assign tmp_tmp_ln_x_to_lg_7_1 = 16'h0001;
  assign tmp_tmp_ln_x_to_lg_1 = ($signed(tmp_tmp_ln_x_to_lg_1_1) + $signed(tmp_tmp_ln_x_to_lg_1_2));
  assign tmp_tmp_ln_x_to_lg_1_1 = {tmp_ln_x_to_lg_6[18],tmp_ln_x_to_lg_6};
  assign tmp_tmp_ln_x_to_lg_1_2 = {tmp_ln_x_to_lg_2[18],tmp_ln_x_to_lg_2};
  assign tmp_when_1 = tmp_ln_x_to_lg_1[15 : 14];
  assign tmp_when_2 = tmp_ln_x_to_lg_1[14 : 14];
  assign tmp_tmp_xi_1 = (tmp_xi + 4'b0010);
  assign tmp_xi_2 = {x_reg[23],x_reg};
  assign tmp_xi_3 = {tmp_xi_1[23],tmp_xi_1};
  assign tmp_tmp_yi = (tmp_xi + 4'b0010);
  assign tmp_yi_1 = {y_reg[23],y_reg};
  assign tmp_yi_2 = {tmp_yi[23],tmp_yi};
  assign tmp_xi_4 = {{1{x_reg[23]}}, x_reg};
  assign tmp_yi_3 = {{1{y_reg[23]}}, y_reg};
  assign tmp_tmp_z_reg = ($signed(tmp_tmp_z_reg_1) + $signed(tmp_tmp_z_reg_2));
  assign tmp_tmp_z_reg_1 = (~ ei);
  assign tmp_tmp_z_reg_2 = 20'h00001;
  assign tmp_tmp_z_reg_1_1 = {z_reg[19],z_reg};
  assign tmp_tmp_z_reg_1_2 = {tmp_z_reg[19],tmp_z_reg};
  assign tmp_when_3 = tmp_z_reg_1[20 : 19];
  assign tmp_when_4 = tmp_z_reg_1[19 : 19];
  assign tmp_tmp_x_reg = ($signed(tmp_tmp_x_reg_1) + $signed(tmp_tmp_x_reg_2));
  assign tmp_tmp_x_reg_1 = (~ yi);
  assign tmp_tmp_x_reg_2 = 25'h0000001;
  assign tmp_tmp_x_reg_1_2 = {x_reg[23],x_reg};
  assign tmp_tmp_x_reg_1_1 = {{1{tmp_tmp_x_reg_1_2[24]}}, tmp_tmp_x_reg_1_2};
  assign tmp_tmp_x_reg_1_3 = {tmp_x_reg[24],tmp_x_reg};
  assign tmp_when_5 = tmp_x_reg_1[25 : 23];
  assign tmp_when_6 = tmp_x_reg_1[24 : 23];
  assign tmp_tmp_y_reg = ($signed(tmp_tmp_y_reg_1) + $signed(tmp_tmp_y_reg_2));
  assign tmp_tmp_y_reg_1 = (~ xi);
  assign tmp_tmp_y_reg_2 = 25'h0000001;
  assign tmp_tmp_y_reg_1_2 = {y_reg[23],y_reg};
  assign tmp_tmp_y_reg_1_1 = {{1{tmp_tmp_y_reg_1_2[24]}}, tmp_tmp_y_reg_1_2};
  assign tmp_tmp_y_reg_1_3 = {tmp_y_reg[24],tmp_y_reg};
  assign tmp_when_7 = tmp_y_reg_1[25 : 23];
  assign tmp_when_8 = tmp_y_reg_1[24 : 23];
  assign tmp_x_reg_3 = ($signed(tmp_x_reg_4) + $signed(tmp_x_reg_5));
  assign tmp_x_reg_4 = memif_rdata[23 : 0];
  assign tmp_x_reg_5 = 24'h004000;
  assign tmp_x_reg_6 = 24'h000010;
  assign tmp_y_reg_3 = ($signed(tmp_y_reg_4) - $signed(tmp_y_reg_5));
  assign tmp_y_reg_4 = memif_rdata[23 : 0];
  assign tmp_y_reg_5 = 24'h004000;
  assign tmp_y_reg_6 = 24'h000010;
  assign tmp_memif_wdata = {{16{cordic_ln_out[15]}}, cordic_ln_out};
  RoundandSat rdsat (
    .din  (zreg_mul2[20:0] ), //i
    .dout (rdsat_dout[15:0])  //o
  );
  always @(*) begin
    case(cnt)
      4'b0000 : begin
        tmp_tmp_xi = iters_0;
        tmp_ei = e_data_0;
      end
      4'b0001 : begin
        tmp_tmp_xi = iters_1;
        tmp_ei = e_data_1;
      end
      4'b0010 : begin
        tmp_tmp_xi = iters_2;
        tmp_ei = e_data_2;
      end
      4'b0011 : begin
        tmp_tmp_xi = iters_3;
        tmp_ei = e_data_3;
      end
      4'b0100 : begin
        tmp_tmp_xi = iters_4;
        tmp_ei = e_data_4;
      end
      4'b0101 : begin
        tmp_tmp_xi = iters_5;
        tmp_ei = e_data_5;
      end
      4'b0110 : begin
        tmp_tmp_xi = iters_6;
        tmp_ei = e_data_6;
      end
      4'b0111 : begin
        tmp_tmp_xi = iters_7;
        tmp_ei = e_data_7;
      end
      4'b1000 : begin
        tmp_tmp_xi = iters_8;
        tmp_ei = e_data_8;
      end
      4'b1001 : begin
        tmp_tmp_xi = iters_9;
        tmp_ei = e_data_9;
      end
      4'b1010 : begin
        tmp_tmp_xi = iters_10;
        tmp_ei = e_data_10;
      end
      default : begin
        tmp_tmp_xi = iters_11;
        tmp_ei = e_data_11;
      end
    endcase
  end

  assign iters_0 = 4'b0100; // @[cordic_ln.scala 44:16]
  assign iters_1 = 4'b0011; // @[cordic_ln.scala 44:16]
  assign iters_2 = 4'b0010; // @[cordic_ln.scala 44:16]
  assign iters_3 = 4'b0001; // @[cordic_ln.scala 44:16]
  assign iters_4 = 4'b0000; // @[cordic_ln.scala 47:16]
  assign iters_5 = 4'b0001; // @[cordic_ln.scala 47:16]
  assign iters_6 = 4'b0010; // @[cordic_ln.scala 47:16]
  assign iters_7 = 4'b0011; // @[cordic_ln.scala 47:16]
  assign iters_8 = 4'b0100; // @[cordic_ln.scala 47:16]
  assign iters_9 = 4'b0101; // @[cordic_ln.scala 47:16]
  assign iters_10 = 4'b0110; // @[cordic_ln.scala 47:16]
  assign iters_11 = 4'b0111; // @[cordic_ln.scala 47:16]
  assign e_data_0 = 16'h26c1; // @[Expression.scala 2380:18]
  assign e_data_1 = 16'h2125; // @[Expression.scala 2380:18]
  assign e_data_2 = 16'h1b79; // @[Expression.scala 2380:18]
  assign e_data_3 = 16'h15aa; // @[Expression.scala 2380:18]
  assign e_data_4 = 16'h0f91; // @[Expression.scala 2380:18]
  assign e_data_5 = 16'h08ca; // @[Expression.scala 2380:18]
  assign e_data_6 = 16'h0416; // @[Expression.scala 2380:18]
  assign e_data_7 = 16'h0203; // @[Expression.scala 2380:18]
  assign e_data_8 = 16'h0100; // @[Expression.scala 2380:18]
  assign e_data_9 = 16'h0080; // @[Expression.scala 2380:18]
  assign e_data_10 = 16'h0040; // @[Expression.scala 2380:18]
  assign e_data_11 = 16'h0020; // @[Expression.scala 2380:18]
  assign di = (y_reg[23] ? 1'b1 : 1'b0); // @[Expression.scala 1420:25]
  assign zreg_mul2 = {z_reg,1'b0}; // @[BaseType.scala 299:24]
  assign ln_out = rdsat_dout; // @[cordic_ln.scala 74:10]
  assign ln_x_shift1 = {ln_out,3'b000}; // @[cordic_ln.scala 78:15]
  assign tmp_ln_x_to_lg = ($signed(ln_x_shift1) - $signed(tmp_tmp_ln_x_to_lg)); // @[BaseType.scala 299:24]
  assign tmp_ln_x_to_lg_2 = {{15'h0,1'b1},3'b000}; // @[BaseType.scala 318:22]
  assign tmp_ln_x_to_lg_3 = {16'hffff,3'b000}; // @[BaseType.scala 318:22]
  assign tmp_ln_x_to_lg_4 = tmp_ln_x_to_lg[18 : 0]; // @[BaseType.scala 299:24]
  assign tmp_ln_x_to_lg_5 = ($signed(tmp_tmp_ln_x_to_lg_5) + $signed(tmp_tmp_ln_x_to_lg_5_1)); // @[BaseType.scala 299:24]
  assign tmp_ln_x_to_lg_6 = tmp_ln_x_to_lg[18 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_ln_x_to_lg_7 = ($signed(tmp_tmp_ln_x_to_lg_7) + $signed(tmp_tmp_ln_x_to_lg_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_ln_x_to_lg_7 = tmp_ln_x_to_lg_5[19 : 4]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_ln_x_to_lg_5[19]) begin
      tmp_ln_x_to_lg_1 = tmp_ln_x_to_lg_7; // @[SInt.scala 339:11]
    end else begin
      tmp_ln_x_to_lg_1 = (tmp_tmp_ln_x_to_lg_1 >>> 4); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_ln_x_to_lg_1[15]) begin
      if((! (&tmp_when_1))) begin
        ln_x_to_lg = 15'h4000; // @[SInt.scala 133:13]
      end else begin
        ln_x_to_lg = tmp_ln_x_to_lg_1[14 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        ln_x_to_lg = 15'h3fff; // @[SInt.scala 139:13]
      end else begin
        ln_x_to_lg = tmp_ln_x_to_lg_1[14 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign cordic_ln_out = {{1{ln_x_to_lg[14]}}, ln_x_to_lg}; // @[cordic_ln.scala 80:20]
  assign mel_addr_ov = (mel_addr == 5'h1e); // @[BaseType.scala 305:24]
  assign cordic_end = (cnt == 4'b1011); // @[BaseType.scala 305:24]
  assign load_stin = ((! (curr_state == LOADDATA)) && (next_state == LOADDATA)); // @[BaseType.scala 305:24]
  assign finish = (mel_addr_ov && (curr_state == STOREDATA)); // @[cordic_ln.scala 91:13]
  always @(*) begin
    xi = 25'h0; // @[cordic_ln.scala 101:6]
    if((curr_state == CORDIC)) begin
      if((cnt < 4'b0101)) begin
        xi = ($signed(tmp_xi_2) - $signed(tmp_xi_3)); // @[cordic_ln.scala 105:10]
      end else begin
        xi = ($signed(tmp_xi_4) >>> tmp_xi); // @[cordic_ln.scala 108:10]
      end
    end
  end

  always @(*) begin
    yi = 25'h0; // @[cordic_ln.scala 102:6]
    if((curr_state == CORDIC)) begin
      if((cnt < 4'b0101)) begin
        yi = ($signed(tmp_yi_1) - $signed(tmp_yi_2)); // @[cordic_ln.scala 106:10]
      end else begin
        yi = ($signed(tmp_yi_3) >>> tmp_xi); // @[cordic_ln.scala 109:10]
      end
    end
  end

  assign tmp_xi = tmp_tmp_xi; // @[Vec.scala 202:25]
  assign tmp_xi_1 = ($signed(x_reg) >>> tmp_tmp_xi_1); // @[BaseType.scala 299:24]
  assign tmp_yi = ($signed(y_reg) >>> tmp_tmp_yi); // @[BaseType.scala 299:24]
  assign ei = {{4{tmp_ei[15]}}, tmp_ei}; // @[BaseType.scala 299:24]
  assign tmp_z_reg = (di ? tmp_tmp_z_reg : ei); // @[Expression.scala 1420:25]
  assign tmp_z_reg_1 = ($signed(tmp_tmp_z_reg_1_1) + $signed(tmp_tmp_z_reg_1_2)); // @[BaseType.scala 299:24]
  always @(*) begin
    if(tmp_z_reg_1[20]) begin
      if((! (&tmp_when_3))) begin
        tmp_z_reg_2 = 20'h80000; // @[SInt.scala 133:13]
      end else begin
        tmp_z_reg_2 = tmp_z_reg_1[19 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_z_reg_2 = 20'h7ffff; // @[SInt.scala 139:13]
      end else begin
        tmp_z_reg_2 = tmp_z_reg_1[19 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign tmp_x_reg = (di ? yi : tmp_tmp_x_reg); // @[Expression.scala 1420:25]
  assign tmp_x_reg_1 = ($signed(tmp_tmp_x_reg_1_1) + $signed(tmp_tmp_x_reg_1_3)); // @[BaseType.scala 299:24]
  always @(*) begin
    if(tmp_x_reg_1[25]) begin
      if((! (&tmp_when_5))) begin
        tmp_x_reg_2 = 24'h800000; // @[SInt.scala 133:13]
      end else begin
        tmp_x_reg_2 = tmp_x_reg_1[23 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_6)) begin
        tmp_x_reg_2 = 24'h7fffff; // @[SInt.scala 139:13]
      end else begin
        tmp_x_reg_2 = tmp_x_reg_1[23 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign tmp_y_reg = (di ? xi : tmp_tmp_y_reg); // @[Expression.scala 1420:25]
  assign tmp_y_reg_1 = ($signed(tmp_tmp_y_reg_1_1) + $signed(tmp_tmp_y_reg_1_3)); // @[BaseType.scala 299:24]
  always @(*) begin
    if(tmp_y_reg_1[25]) begin
      if((! (&tmp_when_7))) begin
        tmp_y_reg_2 = 24'h800000; // @[SInt.scala 133:13]
      end else begin
        tmp_y_reg_2 = tmp_y_reg_1[23 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_8)) begin
        tmp_y_reg_2 = 24'h7fffff; // @[SInt.scala 139:13]
      end else begin
        tmp_y_reg_2 = tmp_y_reg_1[23 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    memif_rd = 1'b0; // @[cordic_ln.scala 132:15]
    if(load_stin) begin
      memif_rd = 1'b1; // @[cordic_ln.scala 129:17]
    end
  end

  always @(*) begin
    memif_wr = 1'b0; // @[cordic_ln.scala 133:15]
    if(!load_stin) begin
      if(store_en) begin
        memif_wr = 1'b1; // @[cordic_ln.scala 124:17]
      end
    end
  end

  always @(*) begin
    memif_addr = 8'h0; // @[cordic_ln.scala 134:17]
    if(load_stin) begin
      memif_addr = tmp_memif_addr_1; // @[cordic_ln.scala 130:19]
    end else begin
      if(store_en) begin
        memif_addr = tmp_memif_addr_3; // @[cordic_ln.scala 125:19]
      end
    end
  end

  always @(*) begin
    memif_wdata = 32'h0; // @[cordic_ln.scala 135:18]
    if(!load_stin) begin
      if(store_en) begin
        memif_wdata = tmp_memif_wdata; // @[cordic_ln.scala 126:20]
      end
    end
  end

  assign tmp_memif_addr = {3'd0, mel_addr}; // @[BaseType.scala 299:24]
  always @(*) begin
    tmp_memif_addr_1[0] = tmp_memif_addr[7]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[1] = tmp_memif_addr[6]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[2] = tmp_memif_addr[5]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[3] = tmp_memif_addr[4]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[4] = tmp_memif_addr[3]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[5] = tmp_memif_addr[2]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[6] = tmp_memif_addr[1]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[7] = tmp_memif_addr[0]; // @[Utils.scala 432:14]
  end

  assign tmp_memif_addr_2 = {3'd0, mel_addr}; // @[BaseType.scala 299:24]
  always @(*) begin
    tmp_memif_addr_3[0] = tmp_memif_addr_2[7]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[1] = tmp_memif_addr_2[6]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[2] = tmp_memif_addr_2[5]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[3] = tmp_memif_addr_2[4]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[4] = tmp_memif_addr_2[3]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[5] = tmp_memif_addr_2[2]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[6] = tmp_memif_addr_2[1]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[7] = tmp_memif_addr_2[0]; // @[Utils.scala 432:14]
  end

  always @(*) begin
    next_state = curr_state; // @[cordic_ln.scala 148:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = LOADDATA; // @[Enum.scala 148:67]
        end
      end
      LOADDATA : begin
        next_state = CORDIC; // @[Enum.scala 148:67]
      end
      CORDIC : begin
        if(cordic_end) begin
          next_state = STOREDATA; // @[Enum.scala 148:67]
        end
      end
      default : begin
        if(mel_addr_ov) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          if(store_en_delay) begin
            next_state = LOADDATA; // @[Enum.scala 148:67]
          end
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      x_reg <= 24'h0; // @[Data.scala 400:33]
      y_reg <= 24'h0; // @[Data.scala 400:33]
      z_reg <= 20'h0; // @[Data.scala 400:33]
      cnt <= 4'b0000; // @[Data.scala 400:33]
      mel_addr <= 5'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      store_en <= 1'b0; // @[Data.scala 400:33]
      store_en_delay <= 1'b0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      store_en <= ((! (curr_state == STOREDATA)) && (next_state == STOREDATA)); // @[Reg.scala 39:30]
      store_en_delay <= store_en; // @[Reg.scala 39:30]
      if((curr_state == CORDIC)) begin
        if(cordic_end) begin
          cnt <= 4'b0000; // @[cordic_ln.scala 95:11]
        end else begin
          cnt <= (cnt + 4'b0001); // @[cordic_ln.scala 97:11]
        end
      end
      if((curr_state == CORDIC)) begin
        z_reg <= tmp_z_reg_2; // @[cordic_ln.scala 114:11]
        x_reg <= tmp_x_reg_2; // @[cordic_ln.scala 115:11]
        y_reg <= tmp_y_reg_2; // @[cordic_ln.scala 116:11]
      end else begin
        if((curr_state == LOADDATA)) begin
          z_reg <= 20'h0; // @[cordic_ln.scala 118:11]
          x_reg <= ($signed(tmp_x_reg_3) + $signed(tmp_x_reg_6)); // @[cordic_ln.scala 119:11]
          y_reg <= ($signed(tmp_y_reg_3) + $signed(tmp_y_reg_6)); // @[cordic_ln.scala 120:11]
        end
      end
      if(store_en) begin
        mel_addr <= (mel_addr + 5'h01); // @[cordic_ln.scala 143:14]
      end else begin
        if(finish) begin
          mel_addr <= 5'h0; // @[cordic_ln.scala 145:14]
        end
      end
    end
  end


endmodule

module mel_dot (
  input               start,
  output              finish,
  output reg          memif_rd,
  output reg          memif_wr,
  output reg [7:0]    memif_addr,
  output reg [31:0]   memif_wdata,
  input      [31:0]   memif_rdata,
  output              mulif_din_vld,
  output     [31:0]   mulif_dinA,
  output     [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [47:0]   mulif_dout,
  output     [19:0]   mel_out,
  input               clk,
  input               resetn
);
  localparam IDLE = 3'd0;
  localparam FETCH_INDEX = 3'd1;
  localparam LOADMG = 3'd2;
  localparam MULSUM = 3'd3;
  localparam STOREMEL = 3'd4;

  wire       [31:0]   rdsat_din;
  wire       [7:0]    melrom_mel_filter;
  wire       [7:0]    melrom_mel_index;
  wire       [3:0]    melrom_mel_len;
  wire       [19:0]   rdsat_dout;
  wire       [3:0]    tmp_mel_len_cnt_ov;
  wire       [31:0]   tmp_din;
  wire       [31:0]   tmp_memif_wdata;
  wire       [15:0]   tmp_mulif_dinB;
  wire       [31:0]   tmp_sum_buffer;
  reg        [7:0]    mel_filter_addr;
  wire       [7:0]    mel_filter;
  reg        [4:0]    mel_index_addr;
  wire       [7:0]    mel_index;
  wire       [3:0]    mel_len;
  reg        [2:0]    next_state;
  reg        [2:0]    curr_state;
  reg        [31:0]   sum_buffer;
  reg        [7:0]    mel_dot_cnt;
  reg        [3:0]    mel_len_cnt;
  wire                mel_filter_addr_ov;
  wire                mel_index_addr_ov;
  wire                mel_len_cnt_ov;
  wire       [7:0]    tmp_memif_addr;
  reg        [7:0]    tmp_memif_addr_1;
  wire       [7:0]    tmp_memif_addr_2;
  reg        [7:0]    tmp_memif_addr_3;
  reg                 tmp_mulif_din_vld;

  assign tmp_mel_len_cnt_ov = (mel_len - 4'b0001);
  assign tmp_din = sum_buffer;
  assign tmp_memif_wdata = {12'd0, mel_out};
  assign tmp_mulif_dinB = {8'd0, mel_filter};
  assign tmp_sum_buffer = mulif_dout[31 : 0];
  mel_rom melrom (
    .mel_filter_addr (mel_filter_addr[7:0]  ), //i
    .mel_filter      (melrom_mel_filter[7:0]), //o
    .mel_index_addr  (mel_index_addr[4:0]   ), //i
    .mel_index       (melrom_mel_index[7:0] ), //o
    .mel_len         (melrom_mel_len[3:0]   )  //o
  );
  RoundandSat_1 rdsat (
    .din  (rdsat_din[31:0] ), //i
    .dout (rdsat_dout[19:0])  //o
  );
  assign mel_filter = melrom_mel_filter; // @[mel_dot.scala 44:14]
  assign mel_index = melrom_mel_index; // @[mel_dot.scala 45:13]
  assign mel_len = melrom_mel_len; // @[mel_dot.scala 46:11]
  assign mel_filter_addr_ov = (mel_filter_addr == 8'hca); // @[BaseType.scala 305:24]
  assign mel_index_addr_ov = (mel_index_addr == 5'h1d); // @[BaseType.scala 305:24]
  assign mel_len_cnt_ov = (mel_len_cnt == tmp_mel_len_cnt_ov); // @[BaseType.scala 305:24]
  assign rdsat_din = tmp_din; // @[mel_dot.scala 72:16]
  assign mel_out = rdsat_dout[19 : 0]; // @[mel_dot.scala 73:14]
  assign finish = (mel_index_addr_ov && (curr_state == STOREMEL)); // @[mel_dot.scala 75:13]
  always @(*) begin
    memif_rd = 1'b0; // @[mel_dot.scala 77:15]
    if((curr_state == LOADMG)) begin
      memif_rd = 1'b1; // @[mel_dot.scala 55:17]
    end
  end

  always @(*) begin
    memif_wr = 1'b0; // @[mel_dot.scala 78:15]
    if(!(curr_state == LOADMG)) begin
      if((curr_state == STOREMEL)) begin
        memif_wr = 1'b1; // @[mel_dot.scala 49:17]
      end
    end
  end

  always @(*) begin
    memif_addr = 8'h0; // @[mel_dot.scala 79:17]
    if((curr_state == LOADMG)) begin
      memif_addr = tmp_memif_addr_1; // @[mel_dot.scala 56:19]
    end else begin
      if((curr_state == STOREMEL)) begin
        memif_addr = tmp_memif_addr_3; // @[mel_dot.scala 50:19]
      end
    end
  end

  always @(*) begin
    memif_wdata = 32'h0; // @[mel_dot.scala 80:18]
    if(!(curr_state == LOADMG)) begin
      if((curr_state == STOREMEL)) begin
        memif_wdata = tmp_memif_wdata; // @[mel_dot.scala 51:20]
      end
    end
  end

  assign tmp_memif_addr = mel_dot_cnt; // @[BaseType.scala 299:24]
  always @(*) begin
    tmp_memif_addr_1[0] = tmp_memif_addr[7]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[1] = tmp_memif_addr[6]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[2] = tmp_memif_addr[5]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[3] = tmp_memif_addr[4]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[4] = tmp_memif_addr[3]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[5] = tmp_memif_addr[2]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[6] = tmp_memif_addr[1]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[7] = tmp_memif_addr[0]; // @[Utils.scala 432:14]
  end

  assign tmp_memif_addr_2 = {3'd0, mel_index_addr}; // @[BaseType.scala 299:24]
  always @(*) begin
    tmp_memif_addr_3[0] = tmp_memif_addr_2[7]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[1] = tmp_memif_addr_2[6]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[2] = tmp_memif_addr_2[5]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[3] = tmp_memif_addr_2[4]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[4] = tmp_memif_addr_2[3]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[5] = tmp_memif_addr_2[2]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[6] = tmp_memif_addr_2[1]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[7] = tmp_memif_addr_2[0]; // @[Utils.scala 432:14]
  end

  assign mulif_din_vld = tmp_mulif_din_vld; // @[mel_dot.scala 112:20]
  assign mulif_dinA = memif_rdata; // @[mel_dot.scala 113:17]
  assign mulif_dinB = tmp_mulif_dinB; // @[mel_dot.scala 114:17]
  always @(*) begin
    next_state = curr_state; // @[mel_dot.scala 121:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = FETCH_INDEX; // @[Enum.scala 148:67]
        end
      end
      FETCH_INDEX : begin
        next_state = LOADMG; // @[Enum.scala 148:67]
      end
      LOADMG : begin
        next_state = MULSUM; // @[Enum.scala 148:67]
      end
      MULSUM : begin
        if(mulif_dout_vld) begin
          if(mel_len_cnt_ov) begin
            next_state = STOREMEL; // @[Enum.scala 148:67]
          end else begin
            next_state = LOADMG; // @[Enum.scala 148:67]
          end
        end
      end
      default : begin
        if(mel_index_addr_ov) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          next_state = FETCH_INDEX; // @[Enum.scala 148:67]
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      mel_filter_addr <= 8'h0; // @[Data.scala 400:33]
      mel_index_addr <= 5'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      sum_buffer <= 32'h0; // @[Data.scala 400:33]
      mel_dot_cnt <= 8'h0; // @[Data.scala 400:33]
      mel_len_cnt <= 4'b0000; // @[Data.scala 400:33]
      tmp_mulif_din_vld <= 1'b0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      if(((curr_state == MULSUM) && mulif_dout_vld)) begin
        if(mel_filter_addr_ov) begin
          mel_filter_addr <= 8'h0; // @[mel_dot.scala 89:23]
        end else begin
          mel_filter_addr <= (mel_filter_addr + 8'h01); // @[mel_dot.scala 91:23]
        end
      end
      if((curr_state == STOREMEL)) begin
        if(mel_index_addr_ov) begin
          mel_index_addr <= 5'h0; // @[mel_dot.scala 96:22]
        end else begin
          mel_index_addr <= (mel_index_addr + 5'h01); // @[mel_dot.scala 98:22]
        end
      end
      if((curr_state == FETCH_INDEX)) begin
        mel_dot_cnt <= mel_index; // @[mel_dot.scala 103:17]
        mel_len_cnt <= 4'b0000; // @[mel_dot.scala 104:17]
      end else begin
        if(((curr_state == MULSUM) && mulif_dout_vld)) begin
          if((! mel_len_cnt_ov)) begin
            mel_dot_cnt <= (mel_dot_cnt + 8'h01); // @[mel_dot.scala 107:19]
            mel_len_cnt <= (mel_len_cnt + 4'b0001); // @[mel_dot.scala 108:19]
          end
        end
      end
      tmp_mulif_din_vld <= (curr_state == LOADMG); // @[Reg.scala 39:30]
      if(((curr_state == MULSUM) && mulif_dout_vld)) begin
        sum_buffer <= (sum_buffer + tmp_sum_buffer); // @[mel_dot.scala 116:16]
      end else begin
        if((curr_state == FETCH_INDEX)) begin
          sum_buffer <= 32'h0; // @[mel_dot.scala 118:16]
        end
      end
    end
  end


endmodule

module power (
  input               start,
  output              finish,
  output reg          memif_rd,
  output reg          memif_wr,
  output reg [7:0]    memif_addr,
  output reg [31:0]   memif_wdata,
  input      [31:0]   memif_rdata,
  output              mulif_din_vld,
  output reg [15:0]   mulif_dinA,
  output reg [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [31:0]   mulif_dout,
  output     [19:0]   mag_out,
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam MUL1 = 2'd1;
  localparam MUL2 = 2'd2;
  localparam STORE = 2'd3;

  wire       [32:0]   rdsat_din;
  wire       [19:0]   rdsat_dout;
  wire       [31:0]   tmp_memif_wdata;
  wire       [31:0]   tmp_buffer_data;
  wire       [31:0]   tmp_buffer_data_1;
  wire       [32:0]   tmp_buffer_data_2;
  wire       [31:0]   tmp_buffer_data_3;
  reg        [7:0]    index;
  reg        [32:0]   buffer_data;
  wire       [15:0]   y_real;
  wire       [15:0]   y_imag;
  reg        [1:0]    next_state;
  reg        [1:0]    curr_state;
  wire                mul1_stin;
  reg                 mul1_stin_dly1;
  reg                 mul1_stin_dly2;
  wire                mul2_start;
  wire                store_stin;
  wire                one_power_finish;
  reg                 write_mag2mem_flg;
  reg                 read_mem2mag_flg;
  wire                all_power_wr_finish;
  reg                 all_power_wr_finish_regNext;
  reg        [7:0]    tmp_memif_addr;
  reg        [7:0]    tmp_memif_addr_1;

  assign tmp_memif_wdata = {12'd0, mag_out};
  assign tmp_buffer_data = memif_rdata;
  assign tmp_buffer_data_1 = mulif_dout;
  assign tmp_buffer_data_3 = mulif_dout;
  assign tmp_buffer_data_2 = {1'd0, tmp_buffer_data_3};
  RoundandSat_2 rdsat (
    .din  (rdsat_din[32:0] ), //i
    .dout (rdsat_dout[19:0])  //o
  );
  assign y_real = buffer_data[31 : 16]; // @[power.scala 43:10]
  assign y_imag = buffer_data[15 : 0]; // @[power.scala 44:10]
  assign rdsat_din = buffer_data; // @[power.scala 46:16]
  assign mag_out = rdsat_dout; // @[power.scala 47:14]
  assign mul1_stin = ((! (curr_state == MUL1)) && (next_state == MUL1)); // @[BaseType.scala 305:24]
  assign mul2_start = ((curr_state == MUL1) && mulif_dout_vld); // @[BaseType.scala 305:24]
  assign store_stin = ((curr_state == MUL2) && (next_state == STORE)); // @[BaseType.scala 305:24]
  assign one_power_finish = ((curr_state == MUL2) && mulif_dout_vld); // @[BaseType.scala 305:24]
  assign all_power_wr_finish = ((index == 8'h80) && write_mag2mem_flg); // @[BaseType.scala 305:24]
  assign finish = all_power_wr_finish_regNext; // @[power.scala 63:13]
  always @(*) begin
    memif_rd = 1'b0; // @[power.scala 65:15]
    if(mul1_stin) begin
      memif_rd = 1'b1; // @[power.scala 34:17]
    end
  end

  always @(*) begin
    memif_wr = 1'b0; // @[power.scala 66:15]
    if(!mul1_stin) begin
      if(write_mag2mem_flg) begin
        memif_wr = 1'b1; // @[power.scala 29:17]
      end
    end
  end

  always @(*) begin
    memif_addr = 8'h0; // @[power.scala 67:17]
    if(mul1_stin) begin
      memif_addr = tmp_memif_addr; // @[power.scala 35:19]
    end else begin
      if(write_mag2mem_flg) begin
        memif_addr = tmp_memif_addr_1; // @[power.scala 30:19]
      end
    end
  end

  always @(*) begin
    memif_wdata = 32'h0; // @[power.scala 68:18]
    if(!mul1_stin) begin
      if(write_mag2mem_flg) begin
        memif_wdata = tmp_memif_wdata; // @[power.scala 31:20]
      end
    end
  end

  always @(*) begin
    tmp_memif_addr[0] = index[7]; // @[Utils.scala 432:14]
    tmp_memif_addr[1] = index[6]; // @[Utils.scala 432:14]
    tmp_memif_addr[2] = index[5]; // @[Utils.scala 432:14]
    tmp_memif_addr[3] = index[4]; // @[Utils.scala 432:14]
    tmp_memif_addr[4] = index[3]; // @[Utils.scala 432:14]
    tmp_memif_addr[5] = index[2]; // @[Utils.scala 432:14]
    tmp_memif_addr[6] = index[1]; // @[Utils.scala 432:14]
    tmp_memif_addr[7] = index[0]; // @[Utils.scala 432:14]
  end

  always @(*) begin
    tmp_memif_addr_1[0] = index[7]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[1] = index[6]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[2] = index[5]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[3] = index[4]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[4] = index[3]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[5] = index[2]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[6] = index[1]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[7] = index[0]; // @[Utils.scala 432:14]
  end

  assign mulif_din_vld = (mul1_stin_dly2 || mul2_start); // @[power.scala 82:20]
  always @(*) begin
    mulif_dinA = 16'h0; // @[power.scala 83:17]
    if(mul1_stin_dly2) begin
      mulif_dinA = y_real; // @[power.scala 86:19]
    end else begin
      if(mul2_start) begin
        mulif_dinA = y_imag; // @[power.scala 89:19]
      end
    end
  end

  always @(*) begin
    mulif_dinB = 16'h0; // @[power.scala 84:17]
    if(mul1_stin_dly2) begin
      mulif_dinB = y_real; // @[power.scala 87:19]
    end else begin
      if(mul2_start) begin
        mulif_dinB = y_imag; // @[power.scala 90:19]
      end
    end
  end

  always @(*) begin
    next_state = curr_state; // @[power.scala 101:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = MUL1; // @[Enum.scala 148:67]
        end
      end
      MUL1 : begin
        if(mulif_dout_vld) begin
          next_state = MUL2; // @[Enum.scala 148:67]
        end
      end
      MUL2 : begin
        if(mulif_dout_vld) begin
          next_state = STORE; // @[Enum.scala 148:67]
        end
      end
      default : begin
        if(all_power_wr_finish) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          if(read_mem2mag_flg) begin
            next_state = MUL1; // @[Enum.scala 148:67]
          end
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      index <= 8'h0; // @[Data.scala 400:33]
      buffer_data <= 33'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      mul1_stin_dly1 <= 1'b0; // @[Data.scala 400:33]
      mul1_stin_dly2 <= 1'b0; // @[Data.scala 400:33]
      write_mag2mem_flg <= 1'b0; // @[Data.scala 400:33]
      read_mem2mag_flg <= 1'b0; // @[Data.scala 400:33]
      all_power_wr_finish_regNext <= 1'b0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      mul1_stin_dly1 <= mul1_stin; // @[Reg.scala 39:30]
      mul1_stin_dly2 <= mul1_stin_dly1; // @[Reg.scala 39:30]
      write_mag2mem_flg <= store_stin; // @[Reg.scala 39:30]
      read_mem2mag_flg <= write_mag2mem_flg; // @[Reg.scala 39:30]
      all_power_wr_finish_regNext <= all_power_wr_finish; // @[Reg.scala 39:30]
      if(mul1_stin_dly1) begin
        buffer_data <= {1'd0, tmp_buffer_data}; // @[power.scala 75:17]
      end else begin
        if(mul2_start) begin
          buffer_data <= {1'd0, tmp_buffer_data_1}; // @[power.scala 77:17]
        end else begin
          if(one_power_finish) begin
            buffer_data <= (buffer_data + tmp_buffer_data_2); // @[power.scala 79:17]
          end
        end
      end
      if(write_mag2mem_flg) begin
        if(all_power_wr_finish) begin
          index <= 8'h0; // @[power.scala 95:13]
        end else begin
          index <= (index + 8'h01); // @[power.scala 97:13]
        end
      end
    end
  end


endmodule

module qfft (
  input               start,
  output              finish,
  output reg          memif_rd,
  output reg          memif_wr,
  output reg [7:0]    memif_addr,
  output reg [31:0]   memif_wdata,
  input      [31:0]   memif_rdata,
  output              mulif_din_vld,
  output     [15:0]   mulif_dinA,
  output     [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [31:0]   mulif_dout,
  input               clk,
  input               resetn
);
  localparam IDLE = 3'd0;
  localparam LOADXQ = 3'd1;
  localparam LOADXP = 3'd2;
  localparam WAIT_STOREYQ = 3'd3;
  localparam STOREYP = 3'd4;

  wire                butterfly_1_finish;
  wire       [15:0]   butterfly_1_yp_real;
  wire       [15:0]   butterfly_1_yp_imag;
  wire       [15:0]   butterfly_1_yq_real;
  wire       [15:0]   butterfly_1_yq_imag;
  wire                butterfly_1_mulif_din_vld;
  wire       [15:0]   butterfly_1_mulif_dinA;
  wire       [15:0]   butterfly_1_mulif_dinB;
  wire       [15:0]   Wnrom_io_wn_real;
  wire       [15:0]   Wnrom_io_wn_imag;
  wire       [0:0]    tmp_inverse_g_cnt_0;
  wire       [0:0]    tmp_inverse_g_cnt_1;
  wire       [3:0]    tmp_stage_inverse;
  wire       [7:0]    tmp_xaddr_base;
  wire       [7:0]    tmp_xp_rd_addr;
  wire       [6:0]    tmp_wn_rd_addr;
  reg        [6:0]    tmp_wn_rd_addr_1;
  wire       [6:0]    tmp_wn_rd_addr_2;
  wire       [6:0]    tmp_wn_rd_addr_3;
  wire       [6:0]    tmp_wn_rd_addr_4;
  wire       [6:0]    tmp_wn_rd_addr_5;
  wire       [6:0]    tmp_wn_rd_addr_6;
  wire       [6:0]    tmp_wn_rd_addr_7;
  wire       [6:0]    tmp_wn_rd_addr_8;
  wire       [3:0]    tmp_wn_rd_addr_9;
  wire       [7:0]    tmp_flg_cnt_btfly_done;
  wire       [7:0]    tmp_flg_cnt_btfly_done_1;
  wire       [7:0]    tmp_flg_cnt_group_done;
  wire       [7:0]    tmp_flg_cnt_group_done_1;
  wire       [15:0]   tmp_xq_imag_reg;
  wire       [15:0]   tmp_xq_imag_reg_1;
  wire       [15:0]   tmp_xp_imag_reg;
  wire       [15:0]   tmp_xp_imag_reg_1;
  reg        [2:0]    cnt_stage;
  reg        [6:0]    cnt_group;
  reg        [6:0]    cnt_butterfly;
  wire       [7:0]    max_group_num;
  wire       [7:0]    max_butfly_num;
  wire       [0:0]    inverse_g_cnt_0;
  wire       [0:0]    inverse_g_cnt_1;
  wire       [1:0]    tmp_inverse_g_cnt_2;
  reg        [1:0]    inverse_g_cnt_2;
  wire       [2:0]    tmp_inverse_g_cnt_3;
  reg        [2:0]    inverse_g_cnt_3;
  wire       [3:0]    tmp_inverse_g_cnt_4;
  reg        [3:0]    inverse_g_cnt_4;
  wire       [4:0]    tmp_inverse_g_cnt_5;
  reg        [4:0]    inverse_g_cnt_5;
  wire       [5:0]    tmp_inverse_g_cnt_6;
  reg        [5:0]    inverse_g_cnt_6;
  wire       [6:0]    tmp_inverse_g_cnt_7;
  reg        [6:0]    inverse_g_cnt_7;
  wire       [7:0]    xaddr_base;
  wire       [7:0]    xp_rd_addr;
  wire       [7:0]    xq_rd_addr;
  wire       [6:0]    wn_rd_addr;
  wire       [3:0]    stage_inverse;
  wire                butterfly_start;
  wire                butterfly_finish;
  wire       [15:0]   xp_real;
  wire       [15:0]   xp_imag;
  wire       [15:0]   xq_real;
  wire       [15:0]   xq_imag;
  wire       [15:0]   wn_real;
  wire       [15:0]   wn_imag;
  wire       [15:0]   yp_real;
  wire       [15:0]   yp_imag;
  wire       [15:0]   yq_real;
  wire       [15:0]   yq_imag;
  reg                 butfly_cnt_incr;
  reg                 butfly_done;
  wire                flg_fft_finish;
  wire                flg_cnt_btfly_done;
  wire                flg_cnt_group_done;
  wire                flg_cnt_stage_done;
  reg        [2:0]    next_state;
  reg        [2:0]    curr_state;
  reg        [6:0]    rom_wn_addr;
  reg        [15:0]   xp_real_reg;
  reg        [15:0]   xp_imag_reg;
  reg        [15:0]   xq_real_reg;
  reg        [15:0]   xq_imag_reg;
  reg                 load_xq_vld;
  reg                 load_xp_vld;
  wire                first_satge_imag_zero;

  assign tmp_inverse_g_cnt_0 = cnt_group[0 : 0];
  assign tmp_inverse_g_cnt_1 = cnt_group[0 : 0];
  assign tmp_stage_inverse = {1'd0, cnt_stage};
  assign tmp_xaddr_base = {1'd0, cnt_group};
  assign tmp_xp_rd_addr = {1'd0, cnt_butterfly};
  assign tmp_wn_rd_addr = (tmp_wn_rd_addr_1 <<< tmp_wn_rd_addr_9);
  assign tmp_wn_rd_addr_2 = {6'd0, inverse_g_cnt_0};
  assign tmp_wn_rd_addr_3 = {6'd0, inverse_g_cnt_1};
  assign tmp_wn_rd_addr_4 = {5'd0, inverse_g_cnt_2};
  assign tmp_wn_rd_addr_5 = {4'd0, inverse_g_cnt_3};
  assign tmp_wn_rd_addr_6 = {3'd0, inverse_g_cnt_4};
  assign tmp_wn_rd_addr_7 = {2'd0, inverse_g_cnt_5};
  assign tmp_wn_rd_addr_8 = {1'd0, inverse_g_cnt_6};
  assign tmp_wn_rd_addr_9 = (stage_inverse - 4'b0001);
  assign tmp_flg_cnt_btfly_done = {1'd0, cnt_butterfly};
  assign tmp_flg_cnt_btfly_done_1 = (max_butfly_num - 8'h01);
  assign tmp_flg_cnt_group_done = {1'd0, cnt_group};
  assign tmp_flg_cnt_group_done_1 = (max_group_num - 8'h01);
  assign tmp_xq_imag_reg = 16'h0;
  assign tmp_xq_imag_reg_1 = memif_rdata[15 : 0];
  assign tmp_xp_imag_reg = 16'h0;
  assign tmp_xp_imag_reg_1 = memif_rdata[15 : 0];
  butterfly_unit butterfly_1 (
    .start            (butterfly_start             ), //i
    .finish           (butterfly_1_finish          ), //o
    .xp_real          (xp_real[15:0]               ), //i
    .xp_imag          (xp_imag[15:0]               ), //i
    .xq_real          (xq_real[15:0]               ), //i
    .xq_imag          (xq_imag[15:0]               ), //i
    .wn_real          (wn_real[15:0]               ), //i
    .wn_imag          (wn_imag[15:0]               ), //i
    .yp_real          (butterfly_1_yp_real[15:0]   ), //o
    .yp_imag          (butterfly_1_yp_imag[15:0]   ), //o
    .yq_real          (butterfly_1_yq_real[15:0]   ), //o
    .yq_imag          (butterfly_1_yq_imag[15:0]   ), //o
    .mulif_din_vld    (butterfly_1_mulif_din_vld   ), //o
    .mulif_dinA       (butterfly_1_mulif_dinA[15:0]), //o
    .mulif_dinB       (butterfly_1_mulif_dinB[15:0]), //o
    .mulif_dout_vld   (mulif_dout_vld              ), //i
    .mulif_cal_finish (mulif_cal_finish            ), //i
    .mulif_dout       (mulif_dout[31:0]            ), //i
    .clk              (clk                         ), //i
    .resetn           (resetn                      )  //i
  );
  wn_rom Wnrom (
    .io_wn_addr (rom_wn_addr[6:0]      ), //i
    .io_wn_real (Wnrom_io_wn_real[15:0]), //o
    .io_wn_imag (Wnrom_io_wn_imag[15:0])  //o
  );
  always @(*) begin
    case(cnt_stage)
      3'b000 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_2;
      3'b001 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_3;
      3'b010 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_4;
      3'b011 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_5;
      3'b100 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_6;
      3'b101 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_7;
      3'b110 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_8;
      default : tmp_wn_rd_addr_1 = inverse_g_cnt_7;
    endcase
  end

  assign inverse_g_cnt_0[0] = tmp_inverse_g_cnt_0[0]; // @[Utils.scala 432:14]
  assign inverse_g_cnt_1[0] = tmp_inverse_g_cnt_1[0]; // @[Utils.scala 432:14]
  assign tmp_inverse_g_cnt_2 = cnt_group[1 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_2[0] = tmp_inverse_g_cnt_2[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_2[1] = tmp_inverse_g_cnt_2[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_3 = cnt_group[2 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_3[0] = tmp_inverse_g_cnt_3[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_3[1] = tmp_inverse_g_cnt_3[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_3[2] = tmp_inverse_g_cnt_3[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_4 = cnt_group[3 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_4[0] = tmp_inverse_g_cnt_4[3]; // @[Utils.scala 432:14]
    inverse_g_cnt_4[1] = tmp_inverse_g_cnt_4[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_4[2] = tmp_inverse_g_cnt_4[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_4[3] = tmp_inverse_g_cnt_4[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_5 = cnt_group[4 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_5[0] = tmp_inverse_g_cnt_5[4]; // @[Utils.scala 432:14]
    inverse_g_cnt_5[1] = tmp_inverse_g_cnt_5[3]; // @[Utils.scala 432:14]
    inverse_g_cnt_5[2] = tmp_inverse_g_cnt_5[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_5[3] = tmp_inverse_g_cnt_5[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_5[4] = tmp_inverse_g_cnt_5[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_6 = cnt_group[5 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_6[0] = tmp_inverse_g_cnt_6[5]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[1] = tmp_inverse_g_cnt_6[4]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[2] = tmp_inverse_g_cnt_6[3]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[3] = tmp_inverse_g_cnt_6[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[4] = tmp_inverse_g_cnt_6[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[5] = tmp_inverse_g_cnt_6[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_7 = cnt_group[6 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_7[0] = tmp_inverse_g_cnt_7[6]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[1] = tmp_inverse_g_cnt_7[5]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[2] = tmp_inverse_g_cnt_7[4]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[3] = tmp_inverse_g_cnt_7[3]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[4] = tmp_inverse_g_cnt_7[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[5] = tmp_inverse_g_cnt_7[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[6] = tmp_inverse_g_cnt_7[0]; // @[Utils.scala 432:14]
  end

  assign max_group_num = (8'h01 <<< cnt_stage); // @[qfft.scala 51:17]
  assign max_butfly_num = (8'h80 >>> cnt_stage); // @[qfft.scala 52:18]
  assign stage_inverse = (4'b1000 - tmp_stage_inverse); // @[qfft.scala 59:17]
  assign xaddr_base = (tmp_xaddr_base <<< stage_inverse); // @[qfft.scala 60:14]
  assign xp_rd_addr = (xaddr_base + tmp_xp_rd_addr); // @[qfft.scala 61:14]
  assign xq_rd_addr = (xp_rd_addr + max_butfly_num); // @[qfft.scala 62:14]
  assign wn_rd_addr = tmp_wn_rd_addr; // @[qfft.scala 63:14]
  assign butterfly_finish = butterfly_1_finish; // @[qfft.scala 75:23]
  assign yp_real = butterfly_1_yp_real; // @[qfft.scala 79:6]
  assign yp_imag = butterfly_1_yp_imag; // @[qfft.scala 79:6]
  assign yq_real = butterfly_1_yq_real; // @[qfft.scala 80:6]
  assign yq_imag = butterfly_1_yq_imag; // @[qfft.scala 80:6]
  assign mulif_din_vld = butterfly_1_mulif_din_vld; // @[qfft.scala 82:12]
  assign mulif_dinA = butterfly_1_mulif_dinA; // @[qfft.scala 82:12]
  assign mulif_dinB = butterfly_1_mulif_dinB; // @[qfft.scala 82:12]
  assign flg_cnt_btfly_done = (tmp_flg_cnt_btfly_done == tmp_flg_cnt_btfly_done_1); // @[qfft.scala 93:22]
  assign flg_cnt_group_done = (tmp_flg_cnt_group_done == tmp_flg_cnt_group_done_1); // @[qfft.scala 94:22]
  assign flg_cnt_stage_done = (cnt_stage == 3'b111); // @[qfft.scala 95:22]
  assign flg_fft_finish = ((butfly_cnt_incr && flg_cnt_btfly_done) && (flg_cnt_group_done && flg_cnt_stage_done)); // @[qfft.scala 96:18]
  assign finish = flg_fft_finish; // @[qfft.scala 98:13]
  always @(*) begin
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = LOADXQ; // @[Enum.scala 148:67]
        end else begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end
      end
      LOADXQ : begin
        next_state = LOADXP; // @[Enum.scala 148:67]
      end
      LOADXP : begin
        next_state = WAIT_STOREYQ; // @[Enum.scala 148:67]
      end
      WAIT_STOREYQ : begin
        if(butterfly_finish) begin
          next_state = STOREYP; // @[Enum.scala 148:67]
        end else begin
          next_state = WAIT_STOREYQ; // @[Enum.scala 148:67]
        end
      end
      default : begin
        if(finish) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          next_state = LOADXQ; // @[Enum.scala 148:67]
        end
      end
    endcase
  end

  always @(*) begin
    memif_rd = 1'b0; // @[qfft.scala 167:15]
    case(curr_state)
      IDLE : begin
      end
      LOADXQ : begin
        memif_rd = 1'b1; // @[qfft.scala 132:17]
      end
      LOADXP : begin
        memif_rd = 1'b1; // @[qfft.scala 132:17]
      end
      WAIT_STOREYQ : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    memif_wr = 1'b0; // @[qfft.scala 168:15]
    case(curr_state)
      IDLE : begin
      end
      LOADXQ : begin
        memif_wr = 1'b0; // @[qfft.scala 133:17]
      end
      LOADXP : begin
        memif_wr = 1'b0; // @[qfft.scala 133:17]
      end
      WAIT_STOREYQ : begin
        if(butterfly_finish) begin
          memif_wr = 1'b1; // @[qfft.scala 127:17]
        end
      end
      default : begin
        memif_wr = 1'b1; // @[qfft.scala 127:17]
      end
    endcase
  end

  always @(*) begin
    memif_wdata = 32'h0; // @[qfft.scala 169:18]
    case(curr_state)
      IDLE : begin
      end
      LOADXQ : begin
      end
      LOADXP : begin
      end
      WAIT_STOREYQ : begin
        if(butterfly_finish) begin
          memif_wdata = {yq_real,yq_imag}; // @[qfft.scala 129:20]
        end
      end
      default : begin
        memif_wdata = {yp_real,yp_imag}; // @[qfft.scala 129:20]
      end
    endcase
  end

  always @(*) begin
    memif_addr = 8'h0; // @[qfft.scala 170:17]
    case(curr_state)
      IDLE : begin
      end
      LOADXQ : begin
        memif_addr = xq_rd_addr; // @[qfft.scala 134:19]
      end
      LOADXP : begin
        memif_addr = xp_rd_addr; // @[qfft.scala 134:19]
      end
      WAIT_STOREYQ : begin
        if(butterfly_finish) begin
          memif_addr = xq_rd_addr; // @[qfft.scala 128:19]
        end
      end
      default : begin
        memif_addr = xp_rd_addr; // @[qfft.scala 128:19]
      end
    endcase
  end

  assign first_satge_imag_zero = (cnt_stage == 3'b000); // @[qfft.scala 199:25]
  assign butterfly_start = load_xp_vld; // @[qfft.scala 209:19]
  assign xp_real = xp_real_reg; // @[qfft.scala 210:11]
  assign xp_imag = xp_imag_reg; // @[qfft.scala 211:11]
  assign xq_real = xq_real_reg; // @[qfft.scala 212:11]
  assign xq_imag = xq_imag_reg; // @[qfft.scala 213:11]
  assign wn_real = Wnrom_io_wn_real; // @[qfft.scala 217:6]
  assign wn_imag = Wnrom_io_wn_imag; // @[qfft.scala 217:6]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      cnt_stage <= 3'b000; // @[Data.scala 400:33]
      cnt_group <= 7'h0; // @[Data.scala 400:33]
      cnt_butterfly <= 7'h0; // @[Data.scala 400:33]
      butfly_cnt_incr <= 1'b0; // @[Data.scala 400:33]
      butfly_done <= 1'b0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      rom_wn_addr <= 7'h0; // @[Data.scala 400:33]
      xp_real_reg <= 16'h0; // @[Data.scala 400:33]
      xp_imag_reg <= 16'h0; // @[Data.scala 400:33]
      xq_real_reg <= 16'h0; // @[Data.scala 400:33]
      xq_imag_reg <= 16'h0; // @[Data.scala 400:33]
      load_xq_vld <= 1'b0; // @[Data.scala 400:33]
      load_xp_vld <= 1'b0; // @[Data.scala 400:33]
    end else begin
      butfly_cnt_incr <= butterfly_finish; // @[Reg.scala 39:30]
      butfly_done <= butfly_cnt_incr; // @[Reg.scala 39:30]
      if(butfly_cnt_incr) begin
        if(flg_cnt_btfly_done) begin
          cnt_butterfly <= 7'h0; // @[qfft.scala 102:21]
          if(flg_cnt_group_done) begin
            cnt_group <= 7'h0; // @[qfft.scala 104:19]
            if(flg_cnt_stage_done) begin
              cnt_stage <= 3'b000; // @[qfft.scala 106:21]
            end else begin
              cnt_stage <= (cnt_stage + 3'b001); // @[qfft.scala 108:21]
            end
          end else begin
            cnt_group <= (cnt_group + 7'h01); // @[qfft.scala 111:19]
          end
        end else begin
          cnt_butterfly <= (cnt_butterfly + 7'h01); // @[qfft.scala 114:21]
        end
      end
      curr_state <= next_state; // @[Reg.scala 39:30]
      case(curr_state)
        IDLE : begin
        end
        LOADXQ : begin
          rom_wn_addr <= wn_rd_addr; // @[qfft.scala 176:19]
        end
        LOADXP : begin
        end
        WAIT_STOREYQ : begin
        end
        default : begin
        end
      endcase
      load_xq_vld <= (curr_state == LOADXQ); // @[Reg.scala 39:30]
      load_xp_vld <= load_xq_vld; // @[Reg.scala 39:30]
      if(load_xq_vld) begin
        xq_real_reg <= memif_rdata[31 : 16]; // @[qfft.scala 202:17]
        xq_imag_reg <= (first_satge_imag_zero ? tmp_xq_imag_reg : tmp_xq_imag_reg_1); // @[qfft.scala 203:17]
      end
      if(load_xp_vld) begin
        xp_real_reg <= memif_rdata[31 : 16]; // @[qfft.scala 206:17]
        xp_imag_reg <= (first_satge_imag_zero ? tmp_xp_imag_reg : tmp_xp_imag_reg_1); // @[qfft.scala 207:17]
      end
    end
  end


endmodule

module booth4 (
  input               io_din_vld,
  input      [31:0]   io_dinA,
  input      [15:0]   io_dinB,
  output              io_dout_vld,
  output              io_cal_finish,
  output     [47:0]   io_dout,
  input               clk,
  input               resetn
);

  wire       [50:0]   tmp_aftershift;
  wire       [50:0]   tmp_aftershift_1;
  reg        [15:0]   Breg;
  reg        [50:0]   shiftReg;
  wire       [2:0]    flag_bits;
  wire       [17:0]   NegativeB;
  wire       [17:0]   Negative2B;
  wire       [17:0]   PositiveB;
  wire       [17:0]   Positive2B;
  wire       [17:0]   AddB;
  wire       [17:0]   Add2B;
  wire       [17:0]   MinusB;
  wire       [17:0]   Minus2B;
  reg        [3:0]    cal_cnt;
  reg                 cal_en;
  wire       [32:0]   shiftReg_low;
  wire       [17:0]   shiftReg_high;
  wire                cal_cnt_ov_flag;
  reg        [17:0]   beforeshift;
  wire       [50:0]   aftershift;
  reg                 cal_en_regNext;

  assign tmp_aftershift = ($signed(tmp_aftershift_1) >>> 2);
  assign tmp_aftershift_1 = {beforeshift,shiftReg_low};
  assign flag_bits = shiftReg[2 : 0]; // @[booth4.scala 38:13]
  assign NegativeB = (- PositiveB); // @[booth4.scala 39:13]
  assign PositiveB = {{2{Breg[15]}}, Breg}; // @[booth4.scala 40:13]
  assign Negative2B = (NegativeB <<< 1); // @[booth4.scala 41:14]
  assign Positive2B = (PositiveB <<< 1); // @[booth4.scala 42:14]
  assign shiftReg_low = shiftReg[32 : 0]; // @[booth4.scala 46:16]
  assign shiftReg_high = shiftReg[50 : 33]; // @[booth4.scala 47:17]
  assign AddB = ($signed(shiftReg_high) + $signed(PositiveB)); // @[booth4.scala 49:8]
  assign Add2B = ($signed(shiftReg_high) + $signed(Positive2B)); // @[booth4.scala 50:9]
  assign MinusB = ($signed(shiftReg_high) + $signed(NegativeB)); // @[booth4.scala 51:10]
  assign Minus2B = ($signed(shiftReg_high) + $signed(Negative2B)); // @[booth4.scala 52:11]
  assign cal_cnt_ov_flag = (cal_cnt == 4'b1111); // @[BaseType.scala 305:24]
  assign io_cal_finish = (cal_cnt_ov_flag && cal_en); // @[booth4.scala 55:17]
  always @(*) begin
    case(flag_bits)
      3'b000, 3'b111 : begin
        beforeshift = shiftReg_high; // @[booth4.scala 71:19]
      end
      3'b001, 3'b010 : begin
        beforeshift = AddB; // @[booth4.scala 74:20]
      end
      3'b101, 3'b110 : begin
        beforeshift = MinusB; // @[booth4.scala 77:20]
      end
      3'b011 : begin
        beforeshift = Add2B; // @[booth4.scala 80:20]
      end
      default : begin
        beforeshift = Minus2B; // @[booth4.scala 83:20]
      end
    endcase
  end

  assign aftershift = tmp_aftershift; // @[booth4.scala 86:14]
  assign io_dout_vld = ((! cal_en) && cal_en_regNext); // @[booth4.scala 99:15]
  assign io_dout = shiftReg[48 : 1]; // @[booth4.scala 100:11]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      Breg <= 16'h0; // @[Data.scala 400:33]
      shiftReg <= 51'h0; // @[Data.scala 400:33]
      cal_cnt <= 4'b0000; // @[Data.scala 400:33]
      cal_en <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(io_din_vld) begin
        cal_en <= 1'b1; // @[booth4.scala 58:12]
      end else begin
        if(cal_cnt_ov_flag) begin
          cal_en <= 1'b0; // @[booth4.scala 60:12]
        end
      end
      if(cal_en) begin
        cal_cnt <= (cal_cnt + 4'b0001); // @[booth4.scala 63:13]
      end else begin
        if(io_din_vld) begin
          cal_cnt <= 4'b0000; // @[booth4.scala 65:13]
        end
      end
      if(io_din_vld) begin
        shiftReg <= {{18'h0,io_dinA},1'b0}; // @[booth4.scala 93:14]
        Breg <= io_dinB; // @[booth4.scala 94:14]
      end else begin
        if(cal_en) begin
          shiftReg <= aftershift; // @[booth4.scala 96:14]
        end
      end
    end
  end

  always @(posedge clk) begin
    cal_en_regNext <= cal_en; // @[Reg.scala 39:30]
  end


endmodule

module vad (
  input               vad_en,
  input               frame_end,
  input      [15:0]   pcm_in,
  input               pcm_vld,
  input      [15:0]   vad_energy_threshold,
  input      [7:0]    vad_hangover,
  output              vad_flag,
  input               clk,
  input               resetn
);

  wire       [15:0]   tmp_pcm_in_abs;
  wire       [15:0]   tmp_pcm_in_abs_1;
  wire       [15:0]   tmp_pcm_in_abs_2;
  wire       [0:0]    tmp_pcm_in_abs_3;
  wire       [23:0]   tmp_energy;
  reg        [7:0]    count_tail;
  reg                 vad_flag_reg;
  reg        [23:0]   energy;
  wire       [15:0]   pcm_in_abs;
  wire       [23:0]   threshold;

  assign tmp_pcm_in_abs = (pcm_in[15] ? tmp_pcm_in_abs_1 : pcm_in);
  assign tmp_pcm_in_abs_1 = (~ pcm_in);
  assign tmp_pcm_in_abs_3 = pcm_in[15];
  assign tmp_pcm_in_abs_2 = {15'd0, tmp_pcm_in_abs_3};
  assign tmp_energy = {8'd0, pcm_in_abs};
  assign pcm_in_abs = (tmp_pcm_in_abs + tmp_pcm_in_abs_2); // @[BaseType.scala 299:24]
  assign threshold = {vad_energy_threshold,8'h0}; // @[BaseType.scala 299:24]
  assign vad_flag = vad_flag_reg; // @[vad.scala 59:15]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      count_tail <= 8'h0; // @[Data.scala 400:33]
      vad_flag_reg <= 1'b0; // @[Data.scala 400:33]
      energy <= 24'h0; // @[Data.scala 400:33]
    end else begin
      if(vad_en) begin
        if(pcm_vld) begin
          energy <= (energy + tmp_energy); // @[vad.scala 32:14]
        end else begin
          if(frame_end) begin
            energy <= 24'h0; // @[vad.scala 34:14]
          end
        end
      end else begin
        energy <= 24'h0; // @[vad.scala 37:12]
      end
      if(vad_en) begin
        if(frame_end) begin
          if((threshold <= energy)) begin
            vad_flag_reg <= 1'b1; // @[vad.scala 43:20]
            count_tail <= vad_hangover; // @[vad.scala 44:18]
          end else begin
            if((8'h0 < count_tail)) begin
              count_tail <= (count_tail - 8'h01); // @[vad.scala 47:20]
              vad_flag_reg <= 1'b1; // @[vad.scala 48:22]
            end else begin
              vad_flag_reg <= 1'b0; // @[vad.scala 50:22]
            end
          end
        end
      end else begin
        vad_flag_reg <= 1'b1; // @[vad.scala 55:16]
      end
    end
  end


endmodule

module booth4_1 (
  input               io_din_vld,
  input      [15:0]   io_dinA,
  input      [8:0]    io_dinB,
  output              io_dout_vld,
  output              io_cal_finish,
  output     [24:0]   io_dout,
  input               clk,
  input               resetn
);

  wire       [27:0]   tmp_aftershift;
  wire       [27:0]   tmp_aftershift_1;
  reg        [8:0]    Breg;
  reg        [27:0]   shiftReg;
  wire       [2:0]    flag_bits;
  wire       [10:0]   NegativeB;
  wire       [10:0]   Negative2B;
  wire       [10:0]   PositiveB;
  wire       [10:0]   Positive2B;
  wire       [10:0]   AddB;
  wire       [10:0]   Add2B;
  wire       [10:0]   MinusB;
  wire       [10:0]   Minus2B;
  reg        [2:0]    cal_cnt;
  reg                 cal_en;
  wire       [16:0]   shiftReg_low;
  wire       [10:0]   shiftReg_high;
  wire                cal_cnt_ov_flag;
  reg        [10:0]   beforeshift;
  wire       [27:0]   aftershift;
  reg                 cal_en_regNext;

  assign tmp_aftershift = ($signed(tmp_aftershift_1) >>> 2);
  assign tmp_aftershift_1 = {beforeshift,shiftReg_low};
  assign flag_bits = shiftReg[2 : 0]; // @[booth4.scala 38:13]
  assign NegativeB = (- PositiveB); // @[booth4.scala 39:13]
  assign PositiveB = {{2{Breg[8]}}, Breg}; // @[booth4.scala 40:13]
  assign Negative2B = (NegativeB <<< 1); // @[booth4.scala 41:14]
  assign Positive2B = (PositiveB <<< 1); // @[booth4.scala 42:14]
  assign shiftReg_low = shiftReg[16 : 0]; // @[booth4.scala 46:16]
  assign shiftReg_high = shiftReg[27 : 17]; // @[booth4.scala 47:17]
  assign AddB = ($signed(shiftReg_high) + $signed(PositiveB)); // @[booth4.scala 49:8]
  assign Add2B = ($signed(shiftReg_high) + $signed(Positive2B)); // @[booth4.scala 50:9]
  assign MinusB = ($signed(shiftReg_high) + $signed(NegativeB)); // @[booth4.scala 51:10]
  assign Minus2B = ($signed(shiftReg_high) + $signed(Negative2B)); // @[booth4.scala 52:11]
  assign cal_cnt_ov_flag = (cal_cnt == 3'b111); // @[BaseType.scala 305:24]
  assign io_cal_finish = (cal_cnt_ov_flag && cal_en); // @[booth4.scala 55:17]
  always @(*) begin
    case(flag_bits)
      3'b000, 3'b111 : begin
        beforeshift = shiftReg_high; // @[booth4.scala 71:19]
      end
      3'b001, 3'b010 : begin
        beforeshift = AddB; // @[booth4.scala 74:20]
      end
      3'b101, 3'b110 : begin
        beforeshift = MinusB; // @[booth4.scala 77:20]
      end
      3'b011 : begin
        beforeshift = Add2B; // @[booth4.scala 80:20]
      end
      default : begin
        beforeshift = Minus2B; // @[booth4.scala 83:20]
      end
    endcase
  end

  assign aftershift = tmp_aftershift; // @[booth4.scala 86:14]
  assign io_dout_vld = ((! cal_en) && cal_en_regNext); // @[booth4.scala 99:15]
  assign io_dout = shiftReg[25 : 1]; // @[booth4.scala 100:11]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      Breg <= 9'h0; // @[Data.scala 400:33]
      shiftReg <= 28'h0; // @[Data.scala 400:33]
      cal_cnt <= 3'b000; // @[Data.scala 400:33]
      cal_en <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(io_din_vld) begin
        cal_en <= 1'b1; // @[booth4.scala 58:12]
      end else begin
        if(cal_cnt_ov_flag) begin
          cal_en <= 1'b0; // @[booth4.scala 60:12]
        end
      end
      if(cal_en) begin
        cal_cnt <= (cal_cnt + 3'b001); // @[booth4.scala 63:13]
      end else begin
        if(io_din_vld) begin
          cal_cnt <= 3'b000; // @[booth4.scala 65:13]
        end
      end
      if(io_din_vld) begin
        shiftReg <= {{11'h0,io_dinA},1'b0}; // @[booth4.scala 93:14]
        Breg <= io_dinB; // @[booth4.scala 94:14]
      end else begin
        if(cal_en) begin
          shiftReg <= aftershift; // @[booth4.scala 96:14]
        end
      end
    end
  end

  always @(posedge clk) begin
    cal_en_regNext <= cal_en; // @[Reg.scala 39:30]
  end


endmodule

module window (
  input               rg_window_en,
  input               kws_start_pos,
  input      [15:0]   pcm_in,
  input               pcm_vld,
  output     [15:0]   pcm_window_out,
  output              pcm_window_vld,
  output              pingpong_flag,
  output     [7:0]    win_addr,
  output              mulif_din_vld,
  output     [15:0]   mulif_dinA,
  output     [8:0]    mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [24:0]   mulif_dout,
  output              memif_rd,
  output              memif_wr,
  output     [7:0]    memif_addr,
  output     [15:0]   memif_wdata,
  input      [15:0]   memif_rdata,
  input               clk,
  input               resetn
);

  wire       [24:0]   rdsat_din;
  wire       [7:0]    winrom_win;
  wire       [15:0]   rdsat_dout;
  wire       [8:0]    tmp_mulif_dinB;
  wire       [15:0]   tmp_pcm_window_out;
  wire       [24:0]   product;
  reg        [8:0]    win_index;

  assign tmp_mulif_dinB = {1'd0, winrom_win};
  assign tmp_pcm_window_out = rdsat_dout;
  win_rom winrom (
    .win_addr (win_addr[7:0]  ), //i
    .win      (winrom_win[7:0])  //o
  );
  RoundandSat_3 rdsat (
    .din  (rdsat_din[24:0] ), //i
    .dout (rdsat_dout[15:0])  //o
  );
  assign win_addr = win_index[7 : 0]; // @[window.scala 37:15]
  assign pingpong_flag = win_index[8]; // @[window.scala 38:20]
  assign mulif_dinA = pcm_in; // @[window.scala 45:17]
  assign mulif_dinB = tmp_mulif_dinB; // @[window.scala 46:17]
  assign mulif_din_vld = (pcm_vld && rg_window_en); // @[window.scala 47:20]
  assign product = mulif_dout; // @[window.scala 48:17]
  assign pcm_window_vld = (rg_window_en ? mulif_dout_vld : pcm_vld); // @[window.scala 50:21]
  assign rdsat_din = ((mulif_dout_vld && rg_window_en) ? product : 25'h0); // @[window.scala 54:16]
  assign pcm_window_out = (rg_window_en ? tmp_pcm_window_out : pcm_in); // @[window.scala 55:21]
  assign memif_wr = pcm_window_vld; // @[window.scala 57:15]
  assign memif_rd = 1'b0; // @[window.scala 58:15]
  assign memif_wdata = (pcm_window_vld ? pcm_window_out : 16'h0); // @[window.scala 59:18]
  assign memif_addr = win_addr; // @[window.scala 60:17]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      win_index <= 9'h0; // @[Data.scala 400:33]
    end else begin
      if(kws_start_pos) begin
        win_index <= 9'h0; // @[window.scala 40:15]
      end else begin
        if(pcm_window_vld) begin
          win_index <= (win_index + 9'h001); // @[window.scala 42:15]
        end
      end
    end
  end


endmodule

module lowpass_filter (
  input               rg_lpfilter_en,
  input               kws_start_pos,
  output              filter_start,
  output              filter_finish,
  input      [15:0]   pcm16k_in,
  input               pcm16k_vld,
  output reg [15:0]   pcm_filter_out,
  output reg          pcm_filter_vld,
  output reg          mulif_din_vld,
  output reg [15:0]   mulif_dinA,
  output reg [8:0]    mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [24:0]   mulif_dout,
  input               clk,
  input               resetn
);

  wire       [28:0]   rdsat_din;
  wire       [15:0]   rdsat_dout;
  wire       [15:0]   tmp_pcm_filter_out_stable;
  wire       [15:0]   tmp_pcm_filter_out_stable_1;
  wire       [15:0]   tmp_pcm_filter_out;
  wire       [28:0]   tmp_filter_out;
  wire       [28:0]   tmp_filter_out_1;
  wire       [28:0]   tmp_filter_out_2;
  wire       [28:0]   tmp_filter_out_3;
  reg        [15:0]   bufferi0;
  reg        [15:0]   bufferi1;
  reg        [15:0]   bufferi2;
  reg        [28:0]   filter_out;
  reg        [1:0]    cnt;
  reg        [2:0]    mul_state;
  reg                 downsample_flag;
  wire                filter_cal_active;
  reg                 pcm16k_vld_delay;
  wire                filter_cal_start;
  reg                 pcm_filter_vld_stable;
  wire       [15:0]   pcm_filter_out_stable;

  assign tmp_pcm_filter_out_stable = rdsat_dout;
  assign tmp_pcm_filter_out_stable_1 = 16'h0;
  assign tmp_pcm_filter_out = 16'h0;
  assign tmp_filter_out = {{4{mulif_dout[24]}}, mulif_dout};
  assign tmp_filter_out_1 = {{4{mulif_dout[24]}}, mulif_dout};
  assign tmp_filter_out_2 = {{4{mulif_dout[24]}}, mulif_dout};
  assign tmp_filter_out_3 = {{4{mulif_dout[24]}}, mulif_dout};
  RoundandSat_4 rdsat (
    .din  (rdsat_din[28:0] ), //i
    .dout (rdsat_dout[15:0])  //o
  );
  assign rdsat_din = filter_out; // @[lowpass_filter.scala 45:16]
  assign filter_cal_active = (cnt == 2'b11); // @[BaseType.scala 305:24]
  assign filter_cal_start = ((rg_lpfilter_en && filter_cal_active) && pcm16k_vld_delay); // @[BaseType.scala 305:24]
  assign pcm_filter_out_stable = (pcm_filter_vld ? tmp_pcm_filter_out_stable : tmp_pcm_filter_out_stable_1); // @[Expression.scala 1420:25]
  always @(*) begin
    pcm_filter_vld = 1'b0; // @[lowpass_filter.scala 84:21]
    if(rg_lpfilter_en) begin
      if((cnt < 2'b10)) begin
        pcm_filter_vld = (pcm16k_vld && downsample_flag); // @[lowpass_filter.scala 88:25]
      end else begin
        if((2'b10 <= cnt)) begin
          pcm_filter_vld = (pcm_filter_vld_stable && downsample_flag); // @[lowpass_filter.scala 91:25]
        end
      end
    end else begin
      pcm_filter_vld = pcm16k_vld; // @[lowpass_filter.scala 95:23]
    end
  end

  always @(*) begin
    pcm_filter_out = 16'h0; // @[lowpass_filter.scala 85:21]
    if(rg_lpfilter_en) begin
      if((cnt < 2'b10)) begin
        pcm_filter_out = 16'h0; // @[lowpass_filter.scala 89:25]
      end else begin
        if((2'b10 <= cnt)) begin
          pcm_filter_out = (pcm_filter_vld ? pcm_filter_out_stable : tmp_pcm_filter_out); // @[lowpass_filter.scala 92:25]
        end
      end
    end else begin
      pcm_filter_out = pcm16k_in; // @[lowpass_filter.scala 96:23]
    end
  end

  always @(*) begin
    mulif_dinA = 16'h0; // @[lowpass_filter.scala 100:17]
    if((mul_state == 3'b000)) begin
      if(filter_cal_start) begin
        mulif_dinA = bufferi0; // @[lowpass_filter.scala 106:21]
      end else begin
        if(mulif_dout_vld) begin
          mulif_dinA = bufferi1; // @[lowpass_filter.scala 110:21]
        end
      end
    end else begin
      if((mul_state == 3'b001)) begin
        if(mulif_dout_vld) begin
          mulif_dinA = bufferi2; // @[lowpass_filter.scala 119:21]
        end
      end else begin
        if((mul_state == 3'b010)) begin
          if(mulif_dout_vld) begin
            mulif_dinA = bufferi1; // @[lowpass_filter.scala 127:21]
          end
        end else begin
          if((mul_state == 3'b011)) begin
            if(mulif_dout_vld) begin
              mulif_dinA = bufferi2; // @[lowpass_filter.scala 135:21]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mulif_dinB = 9'h0; // @[lowpass_filter.scala 101:17]
    if((mul_state == 3'b000)) begin
      if(filter_cal_start) begin
        mulif_dinB = 9'h0a6; // @[lowpass_filter.scala 107:21]
      end else begin
        if(mulif_dout_vld) begin
          mulif_dinB = 9'h089; // @[lowpass_filter.scala 111:21]
        end
      end
    end else begin
      if((mul_state == 3'b001)) begin
        if(mulif_dout_vld) begin
          mulif_dinB = 9'h040; // @[lowpass_filter.scala 120:21]
        end
      end else begin
        if((mul_state == 3'b010)) begin
          if(mulif_dout_vld) begin
            mulif_dinB = 9'h026; // @[lowpass_filter.scala 128:21]
          end
        end else begin
          if((mul_state == 3'b011)) begin
            if(mulif_dout_vld) begin
              mulif_dinB = 9'h04a; // @[lowpass_filter.scala 136:21]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mulif_din_vld = 1'b0; // @[lowpass_filter.scala 102:20]
    if((mul_state == 3'b000)) begin
      if(filter_cal_start) begin
        mulif_din_vld = 1'b1; // @[lowpass_filter.scala 105:24]
      end else begin
        if(mulif_dout_vld) begin
          mulif_din_vld = 1'b1; // @[lowpass_filter.scala 109:24]
        end
      end
    end else begin
      if((mul_state == 3'b001)) begin
        if(mulif_dout_vld) begin
          mulif_din_vld = 1'b1; // @[lowpass_filter.scala 118:24]
        end
      end else begin
        if((mul_state == 3'b010)) begin
          if(mulif_dout_vld) begin
            mulif_din_vld = 1'b1; // @[lowpass_filter.scala 126:24]
          end
        end else begin
          if((mul_state == 3'b011)) begin
            if(mulif_dout_vld) begin
              mulif_din_vld = 1'b1; // @[lowpass_filter.scala 134:24]
            end
          end
        end
      end
    end
  end

  assign filter_finish = (rg_lpfilter_en ? ((cnt < 2'b11) ? pcm16k_vld_delay : ((mul_state == 3'b100) && mulif_dout_vld)) : pcm16k_vld_delay); // @[lowpass_filter.scala 169:20]
  assign filter_start = pcm16k_vld; // @[lowpass_filter.scala 170:19]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      bufferi0 <= 16'h0; // @[Data.scala 400:33]
      bufferi1 <= 16'h0; // @[Data.scala 400:33]
      bufferi2 <= 16'h0; // @[Data.scala 400:33]
      filter_out <= 29'h0; // @[Data.scala 400:33]
      cnt <= 2'b00; // @[Data.scala 400:33]
      mul_state <= 3'b000; // @[Data.scala 400:33]
      downsample_flag <= 1'b0; // @[Data.scala 400:33]
      pcm16k_vld_delay <= 1'b0; // @[Data.scala 400:33]
      pcm_filter_vld_stable <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(rg_lpfilter_en) begin
        if(pcm16k_vld) begin
          bufferi0 <= pcm16k_in; // @[lowpass_filter.scala 50:16]
          bufferi1 <= bufferi0; // @[lowpass_filter.scala 51:16]
          bufferi2 <= bufferi1; // @[lowpass_filter.scala 52:16]
        end
      end
      if(rg_lpfilter_en) begin
        if(kws_start_pos) begin
          cnt <= 2'b00; // @[lowpass_filter.scala 58:11]
        end else begin
          if((cnt < 2'b11)) begin
            if(pcm16k_vld) begin
              cnt <= (cnt + 2'b01); // @[lowpass_filter.scala 61:13]
            end
          end
        end
      end
      pcm16k_vld_delay <= pcm16k_vld; // @[Reg.scala 39:30]
      pcm_filter_vld_stable <= ((mul_state == 3'b100) && mulif_dout_vld); // @[Reg.scala 39:30]
      if(kws_start_pos) begin
        downsample_flag <= 1'b1; // @[lowpass_filter.scala 73:21]
      end else begin
        if((cnt < 2'b10)) begin
          if(pcm16k_vld) begin
            downsample_flag <= (! downsample_flag); // @[lowpass_filter.scala 76:23]
          end
        end else begin
          if((2'b10 <= cnt)) begin
            if(pcm_filter_vld_stable) begin
              downsample_flag <= (! downsample_flag); // @[lowpass_filter.scala 80:23]
            end
          end
        end
      end
      if((mul_state == 3'b000)) begin
        if(!filter_cal_start) begin
          if(mulif_dout_vld) begin
            filter_out <= {{4{mulif_dout[24]}}, mulif_dout}; // @[lowpass_filter.scala 114:18]
          end
        end
      end else begin
        if((mul_state == 3'b001)) begin
          if(mulif_dout_vld) begin
            filter_out <= ($signed(filter_out) + $signed(tmp_filter_out)); // @[lowpass_filter.scala 122:18]
          end
        end else begin
          if((mul_state == 3'b010)) begin
            if(mulif_dout_vld) begin
              filter_out <= ($signed(filter_out) + $signed(tmp_filter_out_1)); // @[lowpass_filter.scala 130:18]
            end
          end else begin
            if((mul_state == 3'b011)) begin
              if(mulif_dout_vld) begin
                filter_out <= ($signed(filter_out) - $signed(tmp_filter_out_2)); // @[lowpass_filter.scala 138:18]
              end
            end else begin
              if((mul_state == 3'b100)) begin
                if(mulif_dout_vld) begin
                  filter_out <= ($signed(filter_out) - $signed(tmp_filter_out_3)); // @[lowpass_filter.scala 143:18]
                end
              end
            end
          end
        end
      end
      if((mul_state == 3'b000)) begin
        if(mulif_dout_vld) begin
          mul_state <= 3'b001; // @[lowpass_filter.scala 149:17]
        end
      end else begin
        if((mul_state == 3'b001)) begin
          if(mulif_dout_vld) begin
            mul_state <= 3'b010; // @[lowpass_filter.scala 153:17]
          end
        end else begin
          if((mul_state == 3'b010)) begin
            if(mulif_dout_vld) begin
              mul_state <= 3'b011; // @[lowpass_filter.scala 157:17]
            end
          end else begin
            if((mul_state == 3'b011)) begin
              if(mulif_dout_vld) begin
                mul_state <= 3'b100; // @[lowpass_filter.scala 161:17]
              end
            end else begin
              if((mul_state == 3'b100)) begin
                if(mulif_dout_vld) begin
                  mul_state <= 3'b000; // @[lowpass_filter.scala 165:17]
                end
              end
            end
          end
        end
      end
    end
  end


endmodule

module lsu (
  input               is_wstore,
  input               is_wload,
  input               is_vload,
  input               is_vstore,
  input               access_mem_vld,
  input      [31:0]   access_mem_addr,
  input      [31:0]   access_mem_wr_sdata,
  input      [127:0]  access_mem_wr_vdata,
  input      [4:0]    rd_load_index_in,
  output     [31:0]   lsu_write_rd_data,
  output     [4:0]    lsu_write_rd_index,
  output              lsu_write_rd_vld,
  output              lsu_write_rd_is_vector,
  output     [127:0]  lsu_write_rd_vector_data,
  output reg          highBandWidth_fb_mem_rd,
  output reg          highBandWidth_fb_mem_wr,
  output reg [6:0]    highBandWidth_fb_mem_addr,
  output reg [127:0]  highBandWidth_fb_mem_wdata,
  input      [127:0]  highBandWidth_fb_mem_rdata,
  output reg          highBandWidth_a_mem_rd,
  output reg          highBandWidth_a_mem_wr,
  output reg [6:0]    highBandWidth_a_mem_addr,
  output reg [127:0]  highBandWidth_a_mem_wdata,
  input      [127:0]  highBandWidth_a_mem_rdata,
  output reg          highBandWidth_w_mem_rd,
  output reg          highBandWidth_w_mem_wr,
  output reg [9:0]    highBandWidth_w_mem_addr,
  output reg [127:0]  highBandWidth_w_mem_wdata,
  input      [127:0]  highBandWidth_w_mem_rdata,
  output reg          lowBandWidth_mem_rd,
  output reg          lowBandWidth_mem_wr,
  output reg [6:0]    lowBandWidth_mem_addr,
  output reg [31:0]   lowBandWidth_mem_wdata,
  input      [31:0]   lowBandWidth_mem_rdata,
  input               clk,
  input               resetn
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
  assign is_load = (access_mem_vld && (is_vload || is_wload)); // @[BaseType.scala 305:24]
  assign lsu_write_rd_vld = is_load_regNext; // @[lsu.scala 80:23]
  assign lsu_write_rd_is_vector = is_vload_regNext; // @[lsu.scala 81:29]
  assign lsu_write_rd_data = access_mem_rd_sdata; // @[lsu.scala 82:24]
  assign lsu_write_rd_vector_data = access_mem_rd_vdata; // @[lsu.scala 83:31]
  assign lsu_write_rd_index = load_index; // @[lsu.scala 85:25]
  assign lowBandWidth_sel = (access_mem_addr < 32'h00000080); // @[BaseType.scala 305:24]
  assign highBandWidth_fb_sel = ((! lowBandWidth_sel) && (access_mem_addr < 32'h000000f8)); // @[BaseType.scala 305:24]
  assign highBandWidth_a_sel = (((! lowBandWidth_sel) && (! highBandWidth_fb_sel)) && (access_mem_addr < 32'h0000015c)); // @[BaseType.scala 305:24]
  assign highBandWidth_w_sel = (((! lowBandWidth_sel) && (! highBandWidth_fb_sel)) && (! highBandWidth_a_sel)); // @[BaseType.scala 305:24]
  assign mem_sel = {{{lowBandWidth_sel,highBandWidth_fb_sel},highBandWidth_a_sel},highBandWidth_w_sel}; // @[BaseType.scala 299:24]
  always @(*) begin
    highBandWidth_fb_mem_rd = 1'b0; // @[lsu.scala 96:30]
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_rd = (is_vload && access_mem_vld); // @[lsu.scala 123:34]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_fb_mem_wr = 1'b0; // @[lsu.scala 97:30]
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_wr = (is_vstore && access_mem_vld); // @[lsu.scala 124:34]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_fb_mem_addr = 7'h0; // @[lsu.scala 98:32]
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_addr = tmp_highBandWidth_fb_mem_addr[6 : 0]; // @[lsu.scala 125:36]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_fb_mem_wdata = 128'h0; // @[lsu.scala 99:33]
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_wdata = access_mem_wr_vdata; // @[lsu.scala 126:37]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_rd = 1'b0; // @[lsu.scala 101:29]
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_rd = (is_vload && access_mem_vld); // @[lsu.scala 129:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_wr = 1'b0; // @[lsu.scala 102:29]
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_wr = (is_vstore && access_mem_vld); // @[lsu.scala 130:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_addr = 7'h0; // @[lsu.scala 103:31]
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_addr = tmp_highBandWidth_a_mem_addr[6 : 0]; // @[lsu.scala 131:35]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_wdata = 128'h0; // @[lsu.scala 104:32]
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_wdata = access_mem_wr_vdata; // @[lsu.scala 132:36]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_rd = 1'b0; // @[lsu.scala 106:29]
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_rd = (is_vload && access_mem_vld); // @[lsu.scala 135:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_wr = 1'b0; // @[lsu.scala 107:29]
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_wr = (is_vstore && access_mem_vld); // @[lsu.scala 136:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_addr = 10'h0; // @[lsu.scala 108:31]
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_addr = tmp_highBandWidth_w_mem_addr[9 : 0]; // @[lsu.scala 137:35]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_wdata = 128'h0; // @[lsu.scala 109:32]
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_wdata = access_mem_wr_vdata; // @[lsu.scala 138:36]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_rd = 1'b0; // @[lsu.scala 111:26]
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_rd = (is_wload && access_mem_vld); // @[lsu.scala 117:30]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_wr = 1'b0; // @[lsu.scala 112:26]
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_wr = (is_wstore && access_mem_vld); // @[lsu.scala 118:30]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_addr = 7'h0; // @[lsu.scala 113:28]
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_addr = access_mem_addr[6 : 0]; // @[lsu.scala 119:32]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_wdata = 32'h0; // @[lsu.scala 114:29]
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_wdata = access_mem_wr_sdata; // @[lsu.scala 120:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    access_mem_rd_vdata = 128'h0; // @[lsu.scala 143:25]
    case(mem_sel_regNext)
      4'b0100 : begin
        access_mem_rd_vdata = highBandWidth_fb_mem_rdata; // @[lsu.scala 150:29]
      end
      4'b0010 : begin
        access_mem_rd_vdata = highBandWidth_a_mem_rdata; // @[lsu.scala 153:29]
      end
      4'b0001 : begin
        access_mem_rd_vdata = highBandWidth_w_mem_rdata; // @[lsu.scala 156:29]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    access_mem_rd_sdata = 32'h0; // @[lsu.scala 144:25]
    case(mem_sel_regNext)
      4'b1000 : begin
        access_mem_rd_sdata = lowBandWidth_mem_rdata; // @[lsu.scala 147:29]
      end
      default : begin
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      is_load_regNext <= 1'b0; // @[Data.scala 400:33]
      is_vload_regNext <= 1'b0; // @[Data.scala 400:33]
      load_index <= 5'h0; // @[Data.scala 400:33]
      mem_sel_regNext <= 4'b0000; // @[Data.scala 400:33]
    end else begin
      is_load_regNext <= is_load; // @[Reg.scala 39:30]
      is_vload_regNext <= is_vload; // @[Reg.scala 39:30]
      if(is_load) begin
        load_index <= rd_load_index_in; // @[lsu.scala 87:16]
      end
      mem_sel_regNext <= mem_sel; // @[Reg.scala 39:30]
    end
  end


endmodule

module alu (
  input      [5:0]    op_type,
  input               oprand_vld_in,
  input      [127:0]  voperand_in_vs1,
  input      [127:0]  voperand_in_vs2,
  input      [4:0]    voperand_in_vs1_index,
  input      [4:0]    voperand_in_vs2_index,
  input      [31:0]   roperand_in_rs1,
  input      [4:0]    roperand_in_rs1_index,
  input      [31:0]   roperand_in_rs2,
  input      [4:0]    roperand_in_rs2_index,
  input      [31:0]   roperand_in_rs3,
  input      [4:0]    roperand_in_rs3_index,
  input      [4:0]    roperand_in_rd_index,
  output reg [31:0]   alu_write_rd_data,
  output reg [4:0]    alu_write_rd_index,
  output reg          alu_write_rd_vld,
  input               is_branch_or_jump,
  input      [10:0]   pc_in,
  output reg [10:0]   branch_taken_addr,
  output reg          branch_taken_vld,
  output reg          result_vld_out,
  output     [31:0]   to_lsu_addr,
  output reg          to_lsu_addr_vld,
  output reg          to_lsu_is_vector,
  output reg          ebreak,
  input               clk,
  input               resetn
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
  wire       [63:0]   round2even_1_din;
  wire       [5:0]    round2even_1_right_shift;
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
  wire       [31:0]   round2even_1_dout;
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
  wire       [63:0]   tmp_din_2;
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
  reg                 tmp_start_regNext;
  wire                tmp_io_din_vld;
  reg                 tmp_io_din_vld_regNext;
  wire                tmp_din_vld;
  reg                 tmp_din_vld_regNext;
  wire       [31:0]   fmsr_result;

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
  assign tmp_din_1 = ((is_fmsr && scalar_mul_io_dout_vld) ? scalar_mul_io_dout : tmp_din_2);
  assign tmp_din_2 = 64'h0;
  assign tmp_fmsr_result = round2even_1_dout[31 : 0];
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
  mul_1cycle_15 multipliers_0 (
    .dinA (element_in_a_0[8:0]     ), //i
    .dinB (element_in_b_0[7:0]     ), //i
    .dout (multipliers_0_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_1 (
    .dinA (element_in_a_1[8:0]     ), //i
    .dinB (element_in_b_1[7:0]     ), //i
    .dout (multipliers_1_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_2 (
    .dinA (element_in_a_2[8:0]     ), //i
    .dinB (element_in_b_2[7:0]     ), //i
    .dout (multipliers_2_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_3 (
    .dinA (element_in_a_3[8:0]     ), //i
    .dinB (element_in_b_3[7:0]     ), //i
    .dout (multipliers_3_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_4 (
    .dinA (element_in_a_4[8:0]     ), //i
    .dinB (element_in_b_4[7:0]     ), //i
    .dout (multipliers_4_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_5 (
    .dinA (element_in_a_5[8:0]     ), //i
    .dinB (element_in_b_5[7:0]     ), //i
    .dout (multipliers_5_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_6 (
    .dinA (element_in_a_6[8:0]     ), //i
    .dinB (element_in_b_6[7:0]     ), //i
    .dout (multipliers_6_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_7 (
    .dinA (element_in_a_7[8:0]     ), //i
    .dinB (element_in_b_7[7:0]     ), //i
    .dout (multipliers_7_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_8 (
    .dinA (element_in_a_8[8:0]     ), //i
    .dinB (element_in_b_8[7:0]     ), //i
    .dout (multipliers_8_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_9 (
    .dinA (element_in_a_9[8:0]     ), //i
    .dinB (element_in_b_9[7:0]     ), //i
    .dout (multipliers_9_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_10 (
    .dinA (element_in_a_10[8:0]     ), //i
    .dinB (element_in_b_10[7:0]     ), //i
    .dout (multipliers_10_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_11 (
    .dinA (element_in_a_11[8:0]     ), //i
    .dinB (element_in_b_11[7:0]     ), //i
    .dout (multipliers_11_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_12 (
    .dinA (element_in_a_12[8:0]     ), //i
    .dinB (element_in_b_12[7:0]     ), //i
    .dout (multipliers_12_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_13 (
    .dinA (element_in_a_13[8:0]     ), //i
    .dinB (element_in_b_13[7:0]     ), //i
    .dout (multipliers_13_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_14 (
    .dinA (element_in_a_14[8:0]     ), //i
    .dinB (element_in_b_14[7:0]     ), //i
    .dout (multipliers_14_dout[16:0])  //o
  );
  mul_1cycle_15 multipliers_15 (
    .dinA (element_in_a_15[8:0]     ), //i
    .dinB (element_in_b_15[7:0]     ), //i
    .dout (multipliers_15_dout[16:0])  //o
  );
  adder_1cycle_14 adder_1cycle_15 (
    .dinA (mul_out_0[16:0]           ), //i
    .dinB (mul_out_1[16:0]           ), //i
    .dout (adder_1cycle_15_dout[17:0])  //o
  );
  adder_1cycle_14 adder_1cycle_16 (
    .dinA (mul_out_2[16:0]           ), //i
    .dinB (mul_out_3[16:0]           ), //i
    .dout (adder_1cycle_16_dout[17:0])  //o
  );
  adder_1cycle_14 adder_1cycle_17 (
    .dinA (mul_out_4[16:0]           ), //i
    .dinB (mul_out_5[16:0]           ), //i
    .dout (adder_1cycle_17_dout[17:0])  //o
  );
  adder_1cycle_14 adder_1cycle_18 (
    .dinA (mul_out_6[16:0]           ), //i
    .dinB (mul_out_7[16:0]           ), //i
    .dout (adder_1cycle_18_dout[17:0])  //o
  );
  adder_1cycle_14 adder_1cycle_19 (
    .dinA (mul_out_8[16:0]           ), //i
    .dinB (mul_out_9[16:0]           ), //i
    .dout (adder_1cycle_19_dout[17:0])  //o
  );
  adder_1cycle_14 adder_1cycle_20 (
    .dinA (mul_out_10[16:0]          ), //i
    .dinB (mul_out_11[16:0]          ), //i
    .dout (adder_1cycle_20_dout[17:0])  //o
  );
  adder_1cycle_14 adder_1cycle_21 (
    .dinA (mul_out_12[16:0]          ), //i
    .dinB (mul_out_13[16:0]          ), //i
    .dout (adder_1cycle_21_dout[17:0])  //o
  );
  adder_1cycle_14 adder_1cycle_22 (
    .dinA (mul_out_14[16:0]          ), //i
    .dinB (mul_out_15[16:0]          ), //i
    .dout (adder_1cycle_22_dout[17:0])  //o
  );
  adder_1cycle_6 adder_1cycle_23 (
    .dinA (adder_1cycle_15_dout[17:0]), //i
    .dinB (adder_1cycle_16_dout[17:0]), //i
    .dout (adder_1cycle_23_dout[18:0])  //o
  );
  adder_1cycle_6 adder_1cycle_24 (
    .dinA (adder_1cycle_17_dout[17:0]), //i
    .dinB (adder_1cycle_18_dout[17:0]), //i
    .dout (adder_1cycle_24_dout[18:0])  //o
  );
  adder_1cycle_6 adder_1cycle_25 (
    .dinA (adder_1cycle_19_dout[17:0]), //i
    .dinB (adder_1cycle_20_dout[17:0]), //i
    .dout (adder_1cycle_25_dout[18:0])  //o
  );
  adder_1cycle_6 adder_1cycle_26 (
    .dinA (adder_1cycle_21_dout[17:0]), //i
    .dinB (adder_1cycle_22_dout[17:0]), //i
    .dout (adder_1cycle_26_dout[18:0])  //o
  );
  adder_1cycle_2 adder_1cycle_27 (
    .dinA (adder_1cycle_23_dout[18:0]), //i
    .dinB (adder_1cycle_24_dout[18:0]), //i
    .dout (adder_1cycle_27_dout[19:0])  //o
  );
  adder_1cycle_2 adder_1cycle_28 (
    .dinA (adder_1cycle_25_dout[18:0]), //i
    .dinB (adder_1cycle_26_dout[18:0]), //i
    .dout (adder_1cycle_28_dout[19:0])  //o
  );
  adder_1cycle adder_1cycle_29 (
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
  booth4_2 scalar_mul (
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
  Round2EvenSW round2even_1 (
    .din         (round2even_1_din[63:0]       ), //i
    .dout        (round2even_1_dout[31:0]      ), //o
    .right_shift (round2even_1_right_shift[5:0])  //i
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

  assign element_in_a_0 = tmp_element_in_a_0; // @[alu.scala 82:21]
  assign element_in_b_0 = voperand_in_vs2[7 : 0]; // @[alu.scala 83:21]
  assign mul_out_0 = multipliers_0_dout; // @[alu.scala 86:16]
  assign element_in_a_1 = tmp_element_in_a_1; // @[alu.scala 82:21]
  assign element_in_b_1 = voperand_in_vs2[15 : 8]; // @[alu.scala 83:21]
  assign mul_out_1 = multipliers_1_dout; // @[alu.scala 86:16]
  assign element_in_a_2 = tmp_element_in_a_2; // @[alu.scala 82:21]
  assign element_in_b_2 = voperand_in_vs2[23 : 16]; // @[alu.scala 83:21]
  assign mul_out_2 = multipliers_2_dout; // @[alu.scala 86:16]
  assign element_in_a_3 = tmp_element_in_a_3; // @[alu.scala 82:21]
  assign element_in_b_3 = voperand_in_vs2[31 : 24]; // @[alu.scala 83:21]
  assign mul_out_3 = multipliers_3_dout; // @[alu.scala 86:16]
  assign element_in_a_4 = tmp_element_in_a_4; // @[alu.scala 82:21]
  assign element_in_b_4 = voperand_in_vs2[39 : 32]; // @[alu.scala 83:21]
  assign mul_out_4 = multipliers_4_dout; // @[alu.scala 86:16]
  assign element_in_a_5 = tmp_element_in_a_5; // @[alu.scala 82:21]
  assign element_in_b_5 = voperand_in_vs2[47 : 40]; // @[alu.scala 83:21]
  assign mul_out_5 = multipliers_5_dout; // @[alu.scala 86:16]
  assign element_in_a_6 = tmp_element_in_a_6; // @[alu.scala 82:21]
  assign element_in_b_6 = voperand_in_vs2[55 : 48]; // @[alu.scala 83:21]
  assign mul_out_6 = multipliers_6_dout; // @[alu.scala 86:16]
  assign element_in_a_7 = tmp_element_in_a_7; // @[alu.scala 82:21]
  assign element_in_b_7 = voperand_in_vs2[63 : 56]; // @[alu.scala 83:21]
  assign mul_out_7 = multipliers_7_dout; // @[alu.scala 86:16]
  assign element_in_a_8 = tmp_element_in_a_8; // @[alu.scala 82:21]
  assign element_in_b_8 = voperand_in_vs2[71 : 64]; // @[alu.scala 83:21]
  assign mul_out_8 = multipliers_8_dout; // @[alu.scala 86:16]
  assign element_in_a_9 = tmp_element_in_a_9; // @[alu.scala 82:21]
  assign element_in_b_9 = voperand_in_vs2[79 : 72]; // @[alu.scala 83:21]
  assign mul_out_9 = multipliers_9_dout; // @[alu.scala 86:16]
  assign element_in_a_10 = tmp_element_in_a_10; // @[alu.scala 82:21]
  assign element_in_b_10 = voperand_in_vs2[87 : 80]; // @[alu.scala 83:21]
  assign mul_out_10 = multipliers_10_dout; // @[alu.scala 86:16]
  assign element_in_a_11 = tmp_element_in_a_11; // @[alu.scala 82:21]
  assign element_in_b_11 = voperand_in_vs2[95 : 88]; // @[alu.scala 83:21]
  assign mul_out_11 = multipliers_11_dout; // @[alu.scala 86:16]
  assign element_in_a_12 = tmp_element_in_a_12; // @[alu.scala 82:21]
  assign element_in_b_12 = voperand_in_vs2[103 : 96]; // @[alu.scala 83:21]
  assign mul_out_12 = multipliers_12_dout; // @[alu.scala 86:16]
  assign element_in_a_13 = tmp_element_in_a_13; // @[alu.scala 82:21]
  assign element_in_b_13 = voperand_in_vs2[111 : 104]; // @[alu.scala 83:21]
  assign mul_out_13 = multipliers_13_dout; // @[alu.scala 86:16]
  assign element_in_a_14 = tmp_element_in_a_14; // @[alu.scala 82:21]
  assign element_in_b_14 = voperand_in_vs2[119 : 112]; // @[alu.scala 83:21]
  assign mul_out_14 = multipliers_14_dout; // @[alu.scala 86:16]
  assign element_in_a_15 = tmp_element_in_a_15; // @[alu.scala 82:21]
  assign element_in_b_15 = voperand_in_vs2[127 : 120]; // @[alu.scala 83:21]
  assign mul_out_15 = multipliers_15_dout; // @[alu.scala 86:16]
  assign sub_en = ((((op_type == SUB) || (op_type == SUBX)) || is_max) || is_min); // @[BaseType.scala 305:24]
  assign rs2minus16 = (roperand_in_rs2 - 32'h00000010); // @[BaseType.scala 299:24]
  always @(*) begin
    if(is_branch_or_jump) begin
      alu_adder_dinA = tmp_dinA; // @[alu.scala 121:23]
    end else begin
      alu_adder_dinA = roperand_in_rs1; // @[alu.scala 123:23]
    end
  end

  always @(*) begin
    if(is_vector_mul_sum) begin
      alu_adder_dinB = {{11{adder_1cycle_29_dout[20]}}, adder_1cycle_29_dout}; // @[alu.scala 126:23]
    end else begin
      if(is_vmac8) begin
        alu_adder_dinB = {{15{tmp_dinB[16]}}, tmp_dinB}; // @[alu.scala 128:23]
      end else begin
        alu_adder_dinB = roperand_in_rs2; // @[alu.scala 130:23]
      end
    end
  end

  assign to_lsu_addr = alu_adder_dout; // @[alu.scala 133:18]
  assign tmp_start = ((op_type == SKIPADD) && oprand_vld_in); // @[BaseType.scala 305:24]
  assign skip_add_start = (tmp_start && (! tmp_start_regNext)); // @[alu.scala 148:21]
  assign skip_add_finish = skip_add_end_1; // @[alu.scala 149:19]
  assign mul_start_out = skip_add_mul_start_out; // @[alu.scala 159:17]
  assign mul_pinA_out = skip_add_mul_pinA_out; // @[alu.scala 160:16]
  assign mul_pinB_out = skip_add_mul_pinB_out; // @[alu.scala 161:16]
  assign shift_out = skip_add_shift_out; // @[alu.scala 162:13]
  assign skipadd_out = skip_add_skipadd_out; // @[alu.scala 163:15]
  assign scalar_mul_io_dinA = ((op_type == SKIPADD) ? mul_pinA_out : tmp_io_dinA); // @[alu.scala 166:22]
  assign scalar_mul_io_dinB = ((op_type == SKIPADD) ? mul_pinB_out : tmp_io_dinB); // @[alu.scala 167:22]
  assign tmp_io_din_vld = (((op_type == FXMUL) || is_fmsr) && oprand_vld_in); // @[BaseType.scala 305:24]
  assign scalar_mul_io_din_vld = ((tmp_io_din_vld && (! tmp_io_din_vld_regNext)) || mul_start_out); // @[alu.scala 168:25]
  assign scalar_div_dinA = roperand_in_rs1[15 : 0]; // @[alu.scala 170:22]
  assign scalar_div_dinB = roperand_in_rs2[7 : 0]; // @[alu.scala 171:22]
  assign tmp_din_vld = ((op_type == DIV) && oprand_vld_in); // @[BaseType.scala 305:24]
  assign scalar_div_din_vld = (tmp_din_vld && (! tmp_din_vld_regNext)); // @[alu.scala 172:25]
  assign round2even_1_right_shift = (skip_add_finish ? shift_out[5 : 0] : ((is_fmsr && scalar_mul_io_dout_vld) ? roperand_in_rs3[5 : 0] : 6'h0)); // @[alu.scala 182:29]
  assign round2even_1_din = (skip_add_finish ? tmp_din : tmp_din_1); // @[alu.scala 184:21]
  assign fmsr_result = tmp_fmsr_result; // @[alu.scala 185:15]
  always @(*) begin
    alu_write_rd_data = 32'h0; // @[alu.scala 188:24]
    case(op_type)
      VMUL_SUM : begin
        alu_write_rd_data = tmp_alu_write_rd_data; // @[alu.scala 225:28]
      end
      VMAC8 : begin
        alu_write_rd_data = tmp_alu_write_rd_data_1; // @[alu.scala 232:28]
      end
      FMSR : begin
        alu_write_rd_data = fmsr_result; // @[alu.scala 239:28]
      end
      SKIPADD : begin
        alu_write_rd_data = fmsr_result; // @[alu.scala 246:28]
      end
      MAX : begin
        alu_write_rd_data = (alu_adder_dout[31] ? roperand_in_rs2 : roperand_in_rs1); // @[alu.scala 254:28]
      end
      MIN : begin
        alu_write_rd_data = (alu_adder_dout[31] ? roperand_in_rs1 : roperand_in_rs2); // @[alu.scala 261:28]
      end
      ADD, SUB, ADDI, ADDX, SUBX : begin
        alu_write_rd_data = alu_adder_dout; // @[alu.scala 267:28]
      end
      ADDI4SPN : begin
        alu_write_rd_data = alu_adder_dout; // @[alu.scala 274:28]
      end
      MVIMMX4 : begin
        alu_write_rd_data = roperand_in_rs2; // @[alu.scala 280:28]
      end
      LUIL8 : begin
        alu_write_rd_data = {24'h0,roperand_in_rs2[7 : 0]}; // @[alu.scala 286:28]
      end
      LUIH8 : begin
        alu_write_rd_data = {{16'h0,roperand_in_rs2[7 : 0]},roperand_in_rs1[7 : 0]}; // @[alu.scala 292:28]
      end
      FXMUL : begin
        alu_write_rd_data = tmp_alu_write_rd_data_2; // @[alu.scala 298:28]
      end
      DIV : begin
        alu_write_rd_data = tmp_alu_write_rd_data_4; // @[alu.scala 304:28]
      end
      SLL_1, SLLI : begin
        alu_write_rd_data = tmp_alu_write_rd_data_5; // @[alu.scala 310:28]
      end
      SRL_1, SRLI : begin
        alu_write_rd_data = tmp_alu_write_rd_data_7; // @[alu.scala 316:28]
      end
      SRAI : begin
        alu_write_rd_data = tmp_alu_write_rd_data_8; // @[alu.scala 322:28]
      end
      MV : begin
        alu_write_rd_data = roperand_in_rs2; // @[alu.scala 328:28]
      end
      MVX : begin
        alu_write_rd_data = roperand_in_rs1; // @[alu.scala 334:28]
      end
      JAL : begin
        alu_write_rd_data = tmp_alu_write_rd_data_9; // @[alu.scala 348:28]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    alu_write_rd_index = 5'h0; // @[alu.scala 189:25]
    case(op_type)
      VMUL_SUM : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 226:29]
      end
      VMAC8 : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 233:29]
      end
      FMSR : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 240:29]
      end
      SKIPADD : begin
        alu_write_rd_index = (roperand_in_rd_index + 5'h10); // @[alu.scala 247:29]
      end
      MAX : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 255:29]
      end
      MIN : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 262:29]
      end
      ADD, SUB, ADDI, ADDX, SUBX : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 268:29]
      end
      ADDI4SPN : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 275:29]
      end
      MVIMMX4 : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 281:29]
      end
      LUIL8 : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 287:29]
      end
      LUIH8 : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 293:29]
      end
      FXMUL : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 299:29]
      end
      DIV : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 305:29]
      end
      SLL_1, SLLI : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 311:29]
      end
      SRL_1, SRLI : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 317:29]
      end
      SRAI : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 323:29]
      end
      MV : begin
        alu_write_rd_index = roperand_in_rs1_index; // @[alu.scala 329:29]
      end
      MVX : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 335:29]
      end
      JAL : begin
        alu_write_rd_index = roperand_in_rd_index; // @[alu.scala 349:29]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    alu_write_rd_vld = 1'b0; // @[alu.scala 190:23]
    case(op_type)
      VMUL_SUM : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 228:27]
      end
      VMAC8 : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 235:27]
      end
      FMSR : begin
        alu_write_rd_vld = scalar_mul_io_dout_vld; // @[alu.scala 243:27]
      end
      SKIPADD : begin
        alu_write_rd_vld = skip_add_finish; // @[alu.scala 250:27]
      end
      MAX : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 257:27]
      end
      MIN : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 264:27]
      end
      ADD, SUB, ADDI, ADDX, SUBX : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 270:27]
      end
      ADDI4SPN : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 277:27]
      end
      MVIMMX4 : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 283:27]
      end
      LUIL8 : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 289:27]
      end
      LUIH8 : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 295:27]
      end
      FXMUL : begin
        alu_write_rd_vld = scalar_mul_io_dout_vld; // @[alu.scala 301:27]
      end
      DIV : begin
        alu_write_rd_vld = scalar_div_dout_vld; // @[alu.scala 307:27]
      end
      SLL_1, SLLI : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 313:27]
      end
      SRL_1, SRLI : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 319:27]
      end
      SRAI : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 325:27]
      end
      MV : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 331:27]
      end
      MVX : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 337:27]
      end
      JAL : begin
        alu_write_rd_vld = oprand_vld_in; // @[alu.scala 350:27]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    to_lsu_addr_vld = 1'b0; // @[alu.scala 192:22]
    case(op_type)
      LW, SW : begin
        to_lsu_addr_vld = oprand_vld_in; // @[alu.scala 216:26]
      end
      LV, SV1, SV2 : begin
        to_lsu_addr_vld = oprand_vld_in; // @[alu.scala 220:26]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    to_lsu_is_vector = 1'b0; // @[alu.scala 193:23]
    case(op_type)
      LV, SV1, SV2 : begin
        to_lsu_is_vector = 1'b1; // @[alu.scala 221:27]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    result_vld_out = 1'b0; // @[alu.scala 196:21]
    case(op_type)
      NOP : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 209:25]
      end
      VMUL_SUM : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 227:25]
      end
      VMAC8 : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 234:25]
      end
      FMSR : begin
        result_vld_out = scalar_mul_io_dout_vld; // @[alu.scala 242:25]
      end
      SKIPADD : begin
        result_vld_out = skip_add_finish; // @[alu.scala 249:25]
      end
      MAX : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 256:25]
      end
      MIN : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 263:25]
      end
      ADD, SUB, ADDI, ADDX, SUBX : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 269:25]
      end
      ADDI4SPN : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 276:25]
      end
      MVIMMX4 : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 282:25]
      end
      LUIL8 : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 288:25]
      end
      LUIH8 : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 294:25]
      end
      FXMUL : begin
        result_vld_out = scalar_mul_io_dout_vld; // @[alu.scala 300:25]
      end
      DIV : begin
        result_vld_out = scalar_div_dout_vld; // @[alu.scala 306:25]
      end
      SLL_1, SLLI : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 312:25]
      end
      SRL_1, SRLI : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 318:25]
      end
      SRAI : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 324:25]
      end
      MV : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 330:25]
      end
      MVX : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 336:25]
      end
      J : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 342:25]
      end
      JAL : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 347:25]
      end
      JR : begin
        result_vld_out = oprand_vld_in; // @[alu.scala 356:25]
      end
      BEQZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          result_vld_out = oprand_vld_in; // @[alu.scala 362:27]
        end else begin
          result_vld_out = oprand_vld_in; // @[alu.scala 365:27]
        end
      end
      BNEZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          result_vld_out = oprand_vld_in; // @[alu.scala 371:27]
        end else begin
          result_vld_out = oprand_vld_in; // @[alu.scala 375:27]
        end
      end
      BLTZ : begin
        if(roperand_in_rs1[31]) begin
          result_vld_out = oprand_vld_in; // @[alu.scala 382:27]
        end else begin
          result_vld_out = oprand_vld_in; // @[alu.scala 385:25]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_vector_mul_sum = 1'b0; // @[alu.scala 197:21]
    case(op_type)
      VMUL_SUM : begin
        is_vector_mul_sum = 1'b1; // @[alu.scala 224:25]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_vmac8 = 1'b0; // @[alu.scala 198:12]
    case(op_type)
      VMAC8 : begin
        is_vmac8 = 1'b1; // @[alu.scala 231:16]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_max = 1'b0; // @[alu.scala 199:10]
    case(op_type)
      MAX : begin
        is_max = 1'b1; // @[alu.scala 253:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_min = 1'b0; // @[alu.scala 200:10]
    case(op_type)
      MIN : begin
        is_min = 1'b1; // @[alu.scala 260:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    is_fmsr = 1'b0; // @[alu.scala 201:11]
    case(op_type)
      FMSR : begin
        is_fmsr = 1'b1; // @[alu.scala 238:15]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    branch_taken_vld = 1'b0; // @[alu.scala 203:23]
    case(op_type)
      J : begin
        branch_taken_vld = 1'b1; // @[alu.scala 341:27]
      end
      JAL : begin
        branch_taken_vld = 1'b1; // @[alu.scala 346:27]
      end
      JR : begin
        branch_taken_vld = 1'b1; // @[alu.scala 355:27]
      end
      BEQZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          branch_taken_vld = 1'b1; // @[alu.scala 361:29]
        end else begin
          branch_taken_vld = 1'b0; // @[alu.scala 364:29]
        end
      end
      BNEZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          branch_taken_vld = 1'b0; // @[alu.scala 370:29]
        end else begin
          branch_taken_vld = 1'b1; // @[alu.scala 374:29]
        end
      end
      BLTZ : begin
        if(roperand_in_rs1[31]) begin
          branch_taken_vld = 1'b1; // @[alu.scala 381:29]
        end else begin
          branch_taken_vld = 1'b0; // @[alu.scala 384:27]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    branch_taken_addr = 11'h0; // @[alu.scala 204:24]
    case(op_type)
      J : begin
        branch_taken_addr = tmp_branch_taken_addr; // @[alu.scala 340:28]
      end
      JAL : begin
        branch_taken_addr = tmp_branch_taken_addr_1; // @[alu.scala 345:28]
      end
      JR : begin
        branch_taken_addr = roperand_in_rs1[10 : 0]; // @[alu.scala 354:28]
      end
      BEQZ : begin
        if((roperand_in_rs1 == 32'h0)) begin
          branch_taken_addr = tmp_branch_taken_addr_2; // @[alu.scala 360:30]
        end
      end
      BNEZ : begin
        if(!(roperand_in_rs1 == 32'h0)) begin
          branch_taken_addr = tmp_branch_taken_addr_3; // @[alu.scala 373:30]
        end
      end
      BLTZ : begin
        if(roperand_in_rs1[31]) begin
          branch_taken_addr = tmp_branch_taken_addr_4; // @[alu.scala 380:30]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    ebreak = 1'b0; // @[alu.scala 206:13]
    case(op_type)
      EBREAK : begin
        ebreak = 1'b1; // @[alu.scala 212:17]
      end
      default : begin
      end
    endcase
  end

  always @(posedge clk) begin
    tmp_start_regNext <= tmp_start; // @[Reg.scala 39:30]
    tmp_io_din_vld_regNext <= tmp_io_din_vld; // @[Reg.scala 39:30]
    tmp_din_vld_regNext <= tmp_din_vld; // @[Reg.scala 39:30]
  end


endmodule

module registers (
  input      [4:0]    dec_rs1_index,
  input      [4:0]    dec_rs2_index,
  input      [4:0]    dec_rs3_index,
  input      [4:0]    dec_rd_index,
  input      [31:0]   dec_imm,
  input               dec_imm_is_rs2,
  input               dec_is_jump,
  input               dec_is_branch,
  input               dec_is_wload,
  input               dec_is_wstore,
  input               dec_is_multi_rs1_index,
  input               dec_is_multi_rd_index,
  input               dec_is_vector_oprand_used,
  input               dec_is_vload,
  input               dec_is_vstore1,
  input               dec_is_vstore2,
  input               dec_info_vld,
  input      [31:0]   alu_write_rd_data,
  input      [4:0]    alu_write_rd_index,
  input               alu_write_rd_vld,
  input      [31:0]   lsu_write_rd_data,
  input      [4:0]    lsu_write_rd_index,
  input               lsu_write_rd_vld,
  input               lsu_write_rd_is_vector,
  input      [127:0]  lsu_write_rd_vector_data,
  output     [31:0]   roperand_out_rs1,
  output     [4:0]    roperand_out_rs1_index,
  output     [31:0]   roperand_out_rs2,
  output     [4:0]    roperand_out_rs2_index,
  output     [31:0]   roperand_out_rs3,
  output     [4:0]    roperand_out_rs3_index,
  output     [4:0]    roperand_out_rd_index,
  output reg [127:0]  voperand_out_vs1,
  output reg [127:0]  voperand_out_vs2,
  output     [4:0]    voperand_out_vs1_index,
  output     [4:0]    voperand_out_vs2_index,
  output              oprand_vld_out,
  output     [31:0]   reg_x_0,
  output     [31:0]   reg_x_1,
  output     [31:0]   reg_x_2,
  output     [31:0]   reg_x_3,
  output     [31:0]   reg_x_4,
  output     [31:0]   reg_x_5,
  output     [31:0]   reg_x_6,
  output     [31:0]   reg_x_7,
  output     [31:0]   reg_x_8,
  output     [31:0]   reg_x_9,
  output     [31:0]   reg_x_10,
  output     [31:0]   reg_x_11,
  output     [31:0]   reg_x_12,
  output     [31:0]   reg_x_13,
  output     [31:0]   reg_x_14,
  output     [31:0]   reg_x_15,
  output     [31:0]   reg_x_16,
  output     [31:0]   reg_x_17,
  output     [31:0]   reg_x_18,
  output     [31:0]   reg_x_19,
  output     [31:0]   reg_x_20,
  output     [31:0]   reg_x_21,
  output     [31:0]   reg_x_22,
  output     [31:0]   reg_x_23,
  output     [31:0]   reg_x_24,
  output     [31:0]   reg_x_25,
  output     [31:0]   reg_x_26,
  output     [31:0]   reg_x_27,
  output     [31:0]   reg_x_28,
  output     [31:0]   reg_x_29,
  output     [31:0]   reg_x_30,
  output     [31:0]   reg_x_31,
  input               clk,
  input               resetn
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

  assign lsu_write_normal_regfile_vld = (lsu_write_rd_vld && (! lsu_write_rd_is_vector)); // @[BaseType.scala 305:24]
  assign lsu_write_vector_regfile_vld = (lsu_write_rd_vld && lsu_write_rd_is_vector); // @[BaseType.scala 305:24]
  assign lsu_write_normal_rd_index = (lsu_write_normal_regfile_vld ? lsu_write_rd_index : 5'h0); // @[Expression.scala 1420:25]
  assign lsu_write_normal_rd_data = (lsu_write_normal_regfile_vld ? lsu_write_rd_data : 32'h0); // @[Expression.scala 1420:25]
  assign write_vector_rd_index_0 = (lsu_write_rd_index + 5'h0); // @[registers.scala 52:30]
  assign write_vector_rd_data_0 = lsu_write_rd_vector_data[31 : 0]; // @[registers.scala 53:29]
  assign write_vector_rd_index_1 = (lsu_write_rd_index + 5'h01); // @[registers.scala 52:30]
  assign write_vector_rd_data_1 = lsu_write_rd_vector_data[63 : 32]; // @[registers.scala 53:29]
  assign write_vector_rd_index_2 = (lsu_write_rd_index + 5'h02); // @[registers.scala 52:30]
  assign write_vector_rd_data_2 = lsu_write_rd_vector_data[95 : 64]; // @[registers.scala 53:29]
  assign write_vector_rd_index_3 = (lsu_write_rd_index + 5'h03); // @[registers.scala 52:30]
  assign write_vector_rd_data_3 = lsu_write_rd_vector_data[127 : 96]; // @[registers.scala 53:29]
  assign vs2_index = (dec_rs2_index + 5'h04); // @[BaseType.scala 299:24]
  assign voperand_out_vs1_index = dec_rs2_index; // @[registers.scala 109:29]
  assign voperand_out_vs2_index = vs2_index; // @[registers.scala 110:29]
  assign tmp_roperand_out_rs1 = tmp_tmp_roperand_out_rs1; // @[Vec.scala 202:25]
  assign roperand_out_rs1_index = (dec_is_multi_rs1_index ? tmp_roperand_out_rs1[4 : 0] : dec_rs1_index); // @[registers.scala 112:29]
  assign roperand_out_rs2_index = (dec_imm_is_rs2 ? 5'h0 : dec_rs2_index); // @[registers.scala 113:29]
  assign roperand_out_rs1 = (dec_is_multi_rs1_index ? tmp_roperand_out_rs1_1 : tmp_roperand_out_rs1); // @[registers.scala 114:23]
  assign roperand_out_rs2 = (dec_imm_is_rs2 ? dec_imm : tmp_roperand_out_rs2); // @[registers.scala 115:23]
  assign roperand_out_rd_index = (dec_is_multi_rd_index ? tmp_roperand_out_rd_index[4 : 0] : dec_rd_index); // @[registers.scala 116:28]
  assign roperand_out_rs3 = tmp_roperand_out_rs3; // @[registers.scala 117:23]
  assign roperand_out_rs3_index = dec_rs3_index; // @[registers.scala 118:29]
  assign oprand_vld_out = dec_info_vld; // @[registers.scala 125:21]
  assign is_vector_instr = (dec_is_vector_oprand_used || dec_is_vload); // @[BaseType.scala 305:24]
  always @(*) begin
    if(is_vector_instr) begin
      voperand_out_vs1[31 : 0] = x_8; // @[registers.scala 133:59]
      voperand_out_vs1[63 : 32] = x_9; // @[registers.scala 133:59]
      voperand_out_vs1[95 : 64] = x_10; // @[registers.scala 133:59]
      voperand_out_vs1[127 : 96] = x_11; // @[registers.scala 133:59]
    end else begin
      voperand_out_vs1 = 128'h0; // @[registers.scala 136:25]
    end
  end

  always @(*) begin
    if(is_vector_instr) begin
      voperand_out_vs2[31 : 0] = x_12; // @[registers.scala 144:59]
      voperand_out_vs2[63 : 32] = x_13; // @[registers.scala 144:59]
      voperand_out_vs2[95 : 64] = x_14; // @[registers.scala 144:59]
      voperand_out_vs2[127 : 96] = x_15; // @[registers.scala 144:59]
    end else begin
      if(dec_is_vstore1) begin
        voperand_out_vs2[7 : 0] = x_16[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[15 : 8] = x_17[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[23 : 16] = x_18[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[31 : 24] = x_19[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[39 : 32] = x_20[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[47 : 40] = x_21[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[55 : 48] = x_22[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[63 : 56] = x_23[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[71 : 64] = x_24[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[79 : 72] = x_25[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[87 : 80] = x_26[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[95 : 88] = x_27[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[103 : 96] = x_28[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[111 : 104] = x_29[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[119 : 112] = x_30[7 : 0]; // @[registers.scala 148:73]
        voperand_out_vs2[127 : 120] = x_31[7 : 0]; // @[registers.scala 148:73]
      end else begin
        voperand_out_vs2 = 128'h0; // @[registers.scala 157:25]
      end
    end
  end

  assign reg_x_0 = x_0; // @[registers.scala 162:17]
  assign reg_x_1 = x_1; // @[registers.scala 162:17]
  assign reg_x_2 = x_2; // @[registers.scala 162:17]
  assign reg_x_3 = x_3; // @[registers.scala 162:17]
  assign reg_x_4 = x_4; // @[registers.scala 162:17]
  assign reg_x_5 = x_5; // @[registers.scala 162:17]
  assign reg_x_6 = x_6; // @[registers.scala 162:17]
  assign reg_x_7 = x_7; // @[registers.scala 162:17]
  assign reg_x_8 = x_8; // @[registers.scala 162:17]
  assign reg_x_9 = x_9; // @[registers.scala 162:17]
  assign reg_x_10 = x_10; // @[registers.scala 162:17]
  assign reg_x_11 = x_11; // @[registers.scala 162:17]
  assign reg_x_12 = x_12; // @[registers.scala 162:17]
  assign reg_x_13 = x_13; // @[registers.scala 162:17]
  assign reg_x_14 = x_14; // @[registers.scala 162:17]
  assign reg_x_15 = x_15; // @[registers.scala 162:17]
  assign reg_x_16 = x_16; // @[registers.scala 162:17]
  assign reg_x_17 = x_17; // @[registers.scala 162:17]
  assign reg_x_18 = x_18; // @[registers.scala 162:17]
  assign reg_x_19 = x_19; // @[registers.scala 162:17]
  assign reg_x_20 = x_20; // @[registers.scala 162:17]
  assign reg_x_21 = x_21; // @[registers.scala 162:17]
  assign reg_x_22 = x_22; // @[registers.scala 162:17]
  assign reg_x_23 = x_23; // @[registers.scala 162:17]
  assign reg_x_24 = x_24; // @[registers.scala 162:17]
  assign reg_x_25 = x_25; // @[registers.scala 162:17]
  assign reg_x_26 = x_26; // @[registers.scala 162:17]
  assign reg_x_27 = x_27; // @[registers.scala 162:17]
  assign reg_x_28 = x_28; // @[registers.scala 162:17]
  assign reg_x_29 = x_29; // @[registers.scala 162:17]
  assign reg_x_30 = x_30; // @[registers.scala 162:17]
  assign reg_x_31 = x_31; // @[registers.scala 162:17]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      x_0 <= 32'h0; // @[Data.scala 400:33]
      x_1 <= 32'h0; // @[Data.scala 400:33]
      x_2 <= 32'h0; // @[Data.scala 400:33]
      x_3 <= 32'h0; // @[Data.scala 400:33]
      x_4 <= 32'h0; // @[Data.scala 400:33]
      x_5 <= 32'h0; // @[Data.scala 400:33]
      x_6 <= 32'h0; // @[Data.scala 400:33]
      x_7 <= 32'h0; // @[Data.scala 400:33]
      x_8 <= 32'h0; // @[Data.scala 400:33]
      x_9 <= 32'h0; // @[Data.scala 400:33]
      x_10 <= 32'h0; // @[Data.scala 400:33]
      x_11 <= 32'h0; // @[Data.scala 400:33]
      x_12 <= 32'h0; // @[Data.scala 400:33]
      x_13 <= 32'h0; // @[Data.scala 400:33]
      x_14 <= 32'h0; // @[Data.scala 400:33]
      x_15 <= 32'h0; // @[Data.scala 400:33]
      x_16 <= 32'h0; // @[Data.scala 400:33]
      x_17 <= 32'h0; // @[Data.scala 400:33]
      x_18 <= 32'h0; // @[Data.scala 400:33]
      x_19 <= 32'h0; // @[Data.scala 400:33]
      x_20 <= 32'h0; // @[Data.scala 400:33]
      x_21 <= 32'h0; // @[Data.scala 400:33]
      x_22 <= 32'h0; // @[Data.scala 400:33]
      x_23 <= 32'h0; // @[Data.scala 400:33]
      x_24 <= 32'h0; // @[Data.scala 400:33]
      x_25 <= 32'h0; // @[Data.scala 400:33]
      x_26 <= 32'h0; // @[Data.scala 400:33]
      x_27 <= 32'h0; // @[Data.scala 400:33]
      x_28 <= 32'h0; // @[Data.scala 400:33]
      x_29 <= 32'h0; // @[Data.scala 400:33]
      x_30 <= 32'h0; // @[Data.scala 400:33]
      x_31 <= 32'h0; // @[Data.scala 400:33]
    end else begin
      x_0 <= 32'h0; // @[registers.scala 58:8]
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h01))) begin
        x_1 <= alu_write_rd_data; // @[registers.scala 75:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h01))) begin
          x_1 <= lsu_write_normal_rd_data; // @[registers.scala 77:14]
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h02))) begin
        x_2 <= alu_write_rd_data; // @[registers.scala 75:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h02))) begin
          x_2 <= lsu_write_normal_rd_data; // @[registers.scala 77:14]
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h03))) begin
        x_3 <= alu_write_rd_data; // @[registers.scala 75:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h03))) begin
          x_3 <= lsu_write_normal_rd_data; // @[registers.scala 77:14]
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h04))) begin
        x_4 <= alu_write_rd_data; // @[registers.scala 75:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h04))) begin
          x_4 <= lsu_write_normal_rd_data; // @[registers.scala 77:14]
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h05))) begin
        x_5 <= alu_write_rd_data; // @[registers.scala 75:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h05))) begin
          x_5 <= lsu_write_normal_rd_data; // @[registers.scala 77:14]
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h06))) begin
        x_6 <= alu_write_rd_data; // @[registers.scala 75:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h06))) begin
          x_6 <= lsu_write_normal_rd_data; // @[registers.scala 77:14]
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h07))) begin
        x_7 <= alu_write_rd_data; // @[registers.scala 75:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h07))) begin
          x_7 <= lsu_write_normal_rd_data; // @[registers.scala 77:14]
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h08))) begin
        x_8 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h08))) begin
          x_8 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h08)) begin
              x_8 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h08)) begin
              x_8 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h08)) begin
              x_8 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h08)) begin
              x_8 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h09))) begin
        x_9 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h09))) begin
          x_9 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h09)) begin
              x_9 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h09)) begin
              x_9 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h09)) begin
              x_9 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h09)) begin
              x_9 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0a))) begin
        x_10 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0a))) begin
          x_10 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0a)) begin
              x_10 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h0a)) begin
              x_10 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h0a)) begin
              x_10 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h0a)) begin
              x_10 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0b))) begin
        x_11 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0b))) begin
          x_11 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0b)) begin
              x_11 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h0b)) begin
              x_11 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h0b)) begin
              x_11 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h0b)) begin
              x_11 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0c))) begin
        x_12 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0c))) begin
          x_12 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0c)) begin
              x_12 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h0c)) begin
              x_12 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h0c)) begin
              x_12 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h0c)) begin
              x_12 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0d))) begin
        x_13 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0d))) begin
          x_13 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0d)) begin
              x_13 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h0d)) begin
              x_13 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h0d)) begin
              x_13 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h0d)) begin
              x_13 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0e))) begin
        x_14 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0e))) begin
          x_14 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0e)) begin
              x_14 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h0e)) begin
              x_14 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h0e)) begin
              x_14 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h0e)) begin
              x_14 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h0f))) begin
        x_15 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h0f))) begin
          x_15 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h0f)) begin
              x_15 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h0f)) begin
              x_15 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h0f)) begin
              x_15 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h0f)) begin
              x_15 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h10))) begin
        x_16 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h10))) begin
          x_16 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h10)) begin
              x_16 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h10)) begin
              x_16 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h10)) begin
              x_16 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h10)) begin
              x_16 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h11))) begin
        x_17 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h11))) begin
          x_17 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h11)) begin
              x_17 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h11)) begin
              x_17 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h11)) begin
              x_17 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h11)) begin
              x_17 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h12))) begin
        x_18 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h12))) begin
          x_18 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h12)) begin
              x_18 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h12)) begin
              x_18 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h12)) begin
              x_18 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h12)) begin
              x_18 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h13))) begin
        x_19 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h13))) begin
          x_19 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h13)) begin
              x_19 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h13)) begin
              x_19 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h13)) begin
              x_19 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h13)) begin
              x_19 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h14))) begin
        x_20 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h14))) begin
          x_20 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h14)) begin
              x_20 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h14)) begin
              x_20 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h14)) begin
              x_20 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h14)) begin
              x_20 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h15))) begin
        x_21 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h15))) begin
          x_21 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h15)) begin
              x_21 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h15)) begin
              x_21 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h15)) begin
              x_21 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h15)) begin
              x_21 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h16))) begin
        x_22 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h16))) begin
          x_22 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h16)) begin
              x_22 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h16)) begin
              x_22 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h16)) begin
              x_22 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h16)) begin
              x_22 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h17))) begin
        x_23 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h17))) begin
          x_23 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h17)) begin
              x_23 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h17)) begin
              x_23 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h17)) begin
              x_23 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h17)) begin
              x_23 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h18))) begin
        x_24 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h18))) begin
          x_24 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h18)) begin
              x_24 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h18)) begin
              x_24 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h18)) begin
              x_24 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h18)) begin
              x_24 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h19))) begin
        x_25 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h19))) begin
          x_25 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h19)) begin
              x_25 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h19)) begin
              x_25 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h19)) begin
              x_25 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h19)) begin
              x_25 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1a))) begin
        x_26 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1a))) begin
          x_26 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1a)) begin
              x_26 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h1a)) begin
              x_26 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h1a)) begin
              x_26 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h1a)) begin
              x_26 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1b))) begin
        x_27 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1b))) begin
          x_27 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1b)) begin
              x_27 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h1b)) begin
              x_27 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h1b)) begin
              x_27 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h1b)) begin
              x_27 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1c))) begin
        x_28 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1c))) begin
          x_28 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1c)) begin
              x_28 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h1c)) begin
              x_28 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h1c)) begin
              x_28 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h1c)) begin
              x_28 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1d))) begin
        x_29 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1d))) begin
          x_29 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1d)) begin
              x_29 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h1d)) begin
              x_29 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h1d)) begin
              x_29 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h1d)) begin
              x_29 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1e))) begin
        x_30 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1e))) begin
          x_30 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1e)) begin
              x_30 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h1e)) begin
              x_30 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h1e)) begin
              x_30 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h1e)) begin
              x_30 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
      if((alu_write_rd_vld && (alu_write_rd_index == 5'h1f))) begin
        x_31 <= alu_write_rd_data; // @[registers.scala 82:14]
      end else begin
        if((lsu_write_normal_regfile_vld && (lsu_write_normal_rd_index == 5'h1f))) begin
          x_31 <= lsu_write_normal_rd_data; // @[registers.scala 84:14]
        end else begin
          if(lsu_write_vector_regfile_vld) begin
            if((write_vector_rd_index_0 == 5'h1f)) begin
              x_31 <= write_vector_rd_data_0; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_1 == 5'h1f)) begin
              x_31 <= write_vector_rd_data_1; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_2 == 5'h1f)) begin
              x_31 <= write_vector_rd_data_2; // @[registers.scala 88:18]
            end
            if((write_vector_rd_index_3 == 5'h1f)) begin
              x_31 <= write_vector_rd_data_3; // @[registers.scala 88:18]
            end
          end
        end
      end
    end
  end


endmodule

module decoder (
  input               instr_valid,
  input      [15:0]   instr_payload,
  output reg [4:0]    dec_rs1_index,
  output reg [4:0]    dec_rs2_index,
  output reg [4:0]    dec_rs3_index,
  output reg [4:0]    dec_rd_index,
  output reg [31:0]   dec_imm,
  output reg          dec_imm_is_rs2,
  output reg          dec_is_jump,
  output reg          dec_is_branch,
  output reg          dec_is_wload,
  output reg          dec_is_wstore,
  output reg          dec_is_multi_rs1_index,
  output reg          dec_is_multi_rd_index,
  output reg          dec_is_vector_oprand_used,
  output reg          dec_is_vload,
  output reg          dec_is_vstore1,
  output reg          dec_is_vstore2,
  output              dec_info_vld,
  output reg [5:0]    op_type
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
  wire       [4:0]    tmp_dec_rs2_index_10;
  wire       [1:0]    op;
  wire       [2:0]    funct3;
  wire       [4:0]    rs1_index_short;
  wire       [4:0]    rs1_index;
  wire       [4:0]    rs2_index_short;
  wire       [4:0]    rs2_index;
  wire       [31:0]   imm_op00;
  wire       [34:0]   imm_op11;

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
  assign tmp_dec_rs2_index_10 = instr_payload[6 : 2];
  assign op = instr_payload[1 : 0]; // @[BaseType.scala 299:24]
  assign funct3 = instr_payload[15 : 13]; // @[BaseType.scala 299:24]
  assign rs1_index_short = {2'd0, tmp_rs1_index_short}; // @[BaseType.scala 299:24]
  assign rs1_index = instr_payload[11 : 7]; // @[BaseType.scala 318:22]
  assign rs2_index_short = {2'd0, tmp_rs2_index_short}; // @[BaseType.scala 299:24]
  assign rs2_index = instr_payload[6 : 2]; // @[BaseType.scala 318:22]
  assign imm_op00 = {{27{tmp_imm_op00[4]}}, tmp_imm_op00}; // @[BaseType.scala 299:24]
  assign imm_op11 = {instr_payload[14 : 12],tmp_imm_op11}; // @[BaseType.scala 299:24]
  always @(*) begin
    dec_rs1_index = 5'h0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 59:28]
          end
          3'b001 : begin
            dec_rs1_index = 5'h0; // @[decoder.scala 67:28]
          end
          3'b110 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 74:28]
          end
          3'b000 : begin
            if(!(instr_payload[13 : 0] == 14'h0)) begin
              dec_rs1_index = 5'h0; // @[decoder.scala 85:30]
            end
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            dec_rs1_index = rs1_index; // @[decoder.scala 97:28]
          end
          3'b001 : begin
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                dec_rs1_index = rs1_index_short; // @[decoder.scala 118:32]
              end
              2'b01 : begin
                dec_rs1_index = rs1_index_short; // @[decoder.scala 124:32]
              end
              2'b11 : begin
                case(instr_payload[6 : 5])
                  2'b00 : begin
                    dec_rs1_index = rs1_index_short; // @[decoder.scala 131:36]
                  end
                  2'b10 : begin
                    dec_rs1_index = rs1_index_short; // @[decoder.scala 136:36]
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
            dec_rs1_index = dec_rd_index; // @[decoder.scala 147:28]
          end
          3'b011 : begin
            dec_rs1_index = dec_rd_index; // @[decoder.scala 154:28]
          end
          3'b101 : begin
            dec_rs1_index = 5'h0; // @[decoder.scala 163:28]
          end
          3'b110 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 170:28]
          end
          default : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 177:28]
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 189:28]
          end
          3'b010 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 194:28]
          end
          3'b100 : begin
            dec_rs1_index = rs1_index; // @[decoder.scala 202:28]
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_rs1_index = {2'd0, tmp_dec_rs1_index}; // @[decoder.scala 232:30]
            end else begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      dec_rs1_index = dec_rd_index; // @[decoder.scala 245:38]
                    end
                    4'b0001 : begin
                      dec_rs1_index = dec_rd_index; // @[decoder.scala 254:38]
                    end
                    4'b0010 : begin
                      dec_rs1_index = dec_rd_index; // @[decoder.scala 263:38]
                    end
                    4'b0011 : begin
                      dec_rs1_index = dec_rd_index; // @[decoder.scala 272:38]
                    end
                    4'b0100 : begin
                      dec_rs1_index = dec_rd_index; // @[decoder.scala 280:38]
                    end
                    4'b0101 : begin
                      dec_rs1_index = dec_rd_index; // @[decoder.scala 288:38]
                    end
                    4'b0110 : begin
                      dec_rs1_index = dec_rd_index; // @[decoder.scala 296:38]
                    end
                    4'b0111 : begin
                      dec_rs1_index = {1'd0, tmp_dec_rs1_index_1}; // @[decoder.scala 305:38]
                    end
                    4'b1000 : begin
                      dec_rs1_index = {2'd0, tmp_dec_rs1_index_2}; // @[decoder.scala 313:38]
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rs1_index = dec_rd_index; // @[decoder.scala 324:38]
                    end
                    default : begin
                      dec_rs1_index = instr_payload[11 : 7]; // @[decoder.scala 332:38]
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            dec_rs1_index = {2'd0, tmp_dec_rs1_index_3}; // @[decoder.scala 344:28]
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_rs2_index = 5'h0; // @[utils.scala 82:9]
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
                    dec_rs2_index = rs2_index_short; // @[decoder.scala 132:36]
                  end
                  2'b10 : begin
                    dec_rs2_index = rs2_index_short; // @[decoder.scala 137:36]
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
            dec_rs2_index = rs2_index; // @[decoder.scala 203:28]
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
                      dec_rs2_index = (tmp_dec_rs2_index + 5'h08); // @[decoder.scala 244:38]
                    end
                    4'b0001 : begin
                      dec_rs2_index = {1'd0, tmp_dec_rs2_index_2}; // @[decoder.scala 253:38]
                    end
                    4'b0010 : begin
                      dec_rs2_index = {2'd0, tmp_dec_rs2_index_3}; // @[decoder.scala 262:38]
                    end
                    4'b0011 : begin
                      dec_rs2_index = {2'd0, tmp_dec_rs2_index_4}; // @[decoder.scala 271:38]
                    end
                    4'b0100 : begin
                      dec_rs2_index = {2'd0, tmp_dec_rs2_index_5}; // @[decoder.scala 279:38]
                    end
                    4'b0101 : begin
                      dec_rs2_index = {1'd0, tmp_dec_rs2_index_6}; // @[decoder.scala 287:38]
                    end
                    4'b0110 : begin
                      dec_rs2_index = {1'd0, tmp_dec_rs2_index_7}; // @[decoder.scala 295:38]
                    end
                    4'b0111 : begin
                      dec_rs2_index = (tmp_dec_rs2_index_8 + 5'h01); // @[decoder.scala 304:38]
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rs2_index = instr_payload[6 : 2]; // @[decoder.scala 325:38]
                    end
                    default : begin
                      dec_rs2_index = instr_payload[6 : 2]; // @[decoder.scala 333:38]
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            dec_rs2_index = tmp_dec_rs2_index_10; // @[decoder.scala 346:28]
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_rs3_index = 5'h0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b110 : begin
            dec_rs3_index = rs2_index_short; // @[decoder.scala 76:28]
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
                      dec_rs3_index = 5'h07; // @[decoder.scala 255:38]
                    end
                    4'b0111 : begin
                      dec_rs3_index = (tmp_dec_rs3_index + 5'h02); // @[decoder.scala 303:38]
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rs3_index = 5'h07; // @[decoder.scala 326:38]
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
    dec_rd_index = 5'h0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_rd_index = rs2_index_short; // @[decoder.scala 61:27]
          end
          3'b001 : begin
            dec_rd_index = 5'h04; // @[decoder.scala 68:27]
          end
          3'b000 : begin
            if(!(instr_payload[13 : 0] == 14'h0)) begin
              dec_rd_index = {2'd0, tmp_dec_rd_index}; // @[decoder.scala 86:29]
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
            dec_rd_index = 5'h01; // @[decoder.scala 109:27]
          end
          3'b100 : begin
          end
          3'b010 : begin
            dec_rd_index = {2'd0, tmp_dec_rd_index_1}; // @[decoder.scala 146:27]
          end
          3'b011 : begin
            dec_rd_index = {2'd0, tmp_dec_rd_index_2}; // @[decoder.scala 153:27]
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
            dec_rd_index = rs1_index; // @[decoder.scala 201:27]
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_rd_index = (instr_payload[6 : 2] + 5'h08); // @[decoder.scala 231:29]
            end else begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_3}; // @[decoder.scala 243:37]
                    end
                    4'b0001 : begin
                      dec_rd_index = {2'd0, tmp_dec_rd_index_4}; // @[decoder.scala 252:37]
                    end
                    4'b0010 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_5}; // @[decoder.scala 261:37]
                    end
                    4'b0011 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_6}; // @[decoder.scala 270:37]
                    end
                    4'b0100 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_7}; // @[decoder.scala 278:37]
                    end
                    4'b0101 : begin
                      dec_rd_index = {2'd0, tmp_dec_rd_index_8}; // @[decoder.scala 286:37]
                    end
                    4'b0110 : begin
                      dec_rd_index = {2'd0, tmp_dec_rd_index_9}; // @[decoder.scala 294:37]
                    end
                    4'b0111 : begin
                      dec_rd_index = {2'd0, tmp_dec_rd_index_10}; // @[decoder.scala 302:37]
                    end
                    4'b1000 : begin
                      dec_rd_index = {1'd0, tmp_dec_rd_index_11}; // @[decoder.scala 312:37]
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rd_index = instr_payload[11 : 7]; // @[decoder.scala 323:37]
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
    dec_imm = 32'h0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_imm = imm_op00; // @[decoder.scala 60:22]
          end
          3'b001 : begin
            dec_imm = tmp_dec_imm; // @[decoder.scala 69:22]
          end
          3'b110 : begin
            dec_imm = imm_op00; // @[decoder.scala 75:22]
          end
          3'b000 : begin
            if(!(instr_payload[13 : 0] == 14'h0)) begin
              dec_imm = tmp_dec_imm_2; // @[decoder.scala 87:24]
            end
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            dec_imm = tmp_dec_imm_4; // @[decoder.scala 98:22]
          end
          3'b001 : begin
            dec_imm = tmp_dec_imm_6; // @[decoder.scala 107:22]
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                dec_imm = tmp_dec_imm_8; // @[decoder.scala 117:26]
              end
              2'b01 : begin
                dec_imm = tmp_dec_imm_10; // @[decoder.scala 123:26]
              end
              default : begin
              end
            endcase
          end
          3'b010 : begin
            dec_imm = tmp_dec_imm_12; // @[decoder.scala 148:22]
          end
          3'b011 : begin
            dec_imm = tmp_dec_imm_14; // @[decoder.scala 155:22]
          end
          3'b101 : begin
            dec_imm = tmp_dec_imm_16; // @[decoder.scala 161:22]
          end
          3'b110 : begin
            dec_imm = tmp_dec_imm_18; // @[decoder.scala 171:22]
          end
          default : begin
            dec_imm = tmp_dec_imm_20; // @[decoder.scala 178:22]
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            dec_imm = tmp_dec_imm_22; // @[decoder.scala 188:22]
          end
          3'b010 : begin
            dec_imm = tmp_dec_imm_24; // @[decoder.scala 195:22]
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_imm = tmp_dec_imm_26; // @[decoder.scala 233:24]
            end
          end
          default : begin
            dec_imm = tmp_dec_imm_28; // @[decoder.scala 345:22]
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_imm_is_rs2 = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 64:29]
          end
          3'b001 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 71:29]
          end
          3'b110 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 79:29]
          end
          3'b000 : begin
            if(!(instr_payload[13 : 0] == 14'h0)) begin
              dec_imm_is_rs2 = 1'b1; // @[decoder.scala 89:31]
            end
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            if(!((rs1_index == 5'h0) && ({instr_payload[12],rs2_index} == 6'h3f))) begin
              dec_imm_is_rs2 = 1'b1; // @[decoder.scala 103:31]
            end
          end
          3'b001 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 110:29]
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                dec_imm_is_rs2 = 1'b1; // @[decoder.scala 119:33]
              end
              2'b01 : begin
                dec_imm_is_rs2 = 1'b1; // @[decoder.scala 125:33]
              end
              default : begin
              end
            endcase
          end
          3'b010 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 150:29]
          end
          3'b011 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 157:29]
          end
          3'b101 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 164:29]
          end
          3'b110 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 172:29]
          end
          default : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 179:29]
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 190:29]
          end
          3'b010 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 196:29]
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_imm_is_rs2 = 1'b1; // @[decoder.scala 237:31]
            end
          end
          default : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 348:29]
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_jump = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
          end
          3'b001 : begin
            dec_is_jump = 1'b1; // @[decoder.scala 112:26]
          end
          3'b100 : begin
          end
          3'b010 : begin
          end
          3'b011 : begin
          end
          3'b101 : begin
            dec_is_jump = 1'b1; // @[decoder.scala 166:26]
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
    dec_is_branch = 1'b0; // @[utils.scala 82:9]
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
            dec_is_branch = 1'b1; // @[decoder.scala 173:28]
          end
          default : begin
            dec_is_branch = 1'b1; // @[decoder.scala 180:28]
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b010 : begin
            dec_is_branch = 1'b1; // @[decoder.scala 197:28]
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
    dec_is_wload = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_is_wload = 1'b1; // @[decoder.scala 62:27]
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
    dec_is_wstore = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b110 : begin
            dec_is_wstore = 1'b1; // @[decoder.scala 77:28]
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
    dec_is_multi_rs1_index = 1'b0; // @[utils.scala 82:9]
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
                      dec_is_multi_rs1_index = 1'b1; // @[decoder.scala 248:47]
                    end
                    4'b0001 : begin
                      dec_is_multi_rs1_index = 1'b1; // @[decoder.scala 257:47]
                    end
                    4'b0010 : begin
                      dec_is_multi_rs1_index = 1'b1; // @[decoder.scala 266:47]
                    end
                    4'b0011 : begin
                      dec_is_multi_rs1_index = 1'b1; // @[decoder.scala 274:47]
                    end
                    4'b0100 : begin
                      dec_is_multi_rs1_index = 1'b1; // @[decoder.scala 282:47]
                    end
                    4'b0101 : begin
                      dec_is_multi_rs1_index = 1'b1; // @[decoder.scala 290:47]
                    end
                    4'b0110 : begin
                      dec_is_multi_rs1_index = 1'b1; // @[decoder.scala 298:47]
                    end
                    4'b0111 : begin
                      dec_is_multi_rs1_index = 1'b0; // @[decoder.scala 308:47]
                    end
                    4'b1000 : begin
                      dec_is_multi_rs1_index = 1'b1; // @[decoder.scala 315:47]
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_is_multi_rs1_index = 1'b1; // @[decoder.scala 328:47]
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
    dec_is_multi_rd_index = 1'b0; // @[utils.scala 82:9]
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
                      dec_is_multi_rd_index = 1'b1; // @[decoder.scala 249:46]
                    end
                    4'b0001 : begin
                      dec_is_multi_rd_index = 1'b1; // @[decoder.scala 258:46]
                    end
                    4'b0010 : begin
                      dec_is_multi_rd_index = 1'b1; // @[decoder.scala 267:46]
                    end
                    4'b0011 : begin
                      dec_is_multi_rd_index = 1'b1; // @[decoder.scala 275:46]
                    end
                    4'b0100 : begin
                      dec_is_multi_rd_index = 1'b1; // @[decoder.scala 283:46]
                    end
                    4'b0101 : begin
                      dec_is_multi_rd_index = 1'b1; // @[decoder.scala 291:46]
                    end
                    4'b0110 : begin
                      dec_is_multi_rd_index = 1'b1; // @[decoder.scala 299:46]
                    end
                    4'b0111 : begin
                      dec_is_multi_rd_index = 1'b1; // @[decoder.scala 309:46]
                    end
                    4'b1000 : begin
                      dec_is_multi_rd_index = 1'b0; // @[decoder.scala 316:46]
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_is_multi_rd_index = 1'b1; // @[decoder.scala 327:46]
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
    dec_is_vector_oprand_used = 1'b0; // @[utils.scala 82:9]
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
                      dec_is_vector_oprand_used = 1'b1; // @[decoder.scala 247:50]
                    end
                    4'b0010 : begin
                      dec_is_vector_oprand_used = 1'b1; // @[decoder.scala 265:50]
                    end
                    4'b0111 : begin
                      dec_is_vector_oprand_used = 1'b1; // @[decoder.scala 307:50]
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
    dec_is_vload = 1'b0; // @[utils.scala 82:9]
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
              dec_is_vload = 1'b1; // @[decoder.scala 236:29]
            end
          end
          default : begin
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_vstore1 = 1'b0; // @[utils.scala 82:9]
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
            if((dec_rs2_index == 5'h0)) begin
              dec_is_vstore1 = 1'b1; // @[decoder.scala 351:31]
            end
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_vstore2 = 1'b0; // @[utils.scala 82:9]
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
            if(!(dec_rs2_index == 5'h0)) begin
              dec_is_vstore2 = 1'b1; // @[decoder.scala 354:31]
            end
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    op_type = ILLEGAL; // @[Enum.scala 148:67]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            op_type = LW; // @[Enum.scala 148:67]
          end
          3'b001 : begin
            op_type = MVIMMX4; // @[Enum.scala 148:67]
          end
          3'b110 : begin
            op_type = SW; // @[Enum.scala 148:67]
          end
          3'b000 : begin
            if((instr_payload[13 : 0] == 14'h0)) begin
              op_type = ILLEGAL; // @[Enum.scala 148:67]
            end else begin
              op_type = ADDI4SPN; // @[Enum.scala 148:67]
            end
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            if(((rs1_index == 5'h0) && ({instr_payload[12],rs2_index} == 6'h3f))) begin
              op_type = NOP; // @[Enum.scala 148:67]
            end else begin
              op_type = ADDI; // @[Enum.scala 148:67]
            end
          end
          3'b001 : begin
            op_type = JAL; // @[Enum.scala 148:67]
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                op_type = SRLI; // @[Enum.scala 148:67]
              end
              2'b01 : begin
                op_type = SRAI; // @[Enum.scala 148:67]
              end
              2'b11 : begin
                case(instr_payload[6 : 5])
                  2'b00 : begin
                    op_type = SUB; // @[Enum.scala 148:67]
                  end
                  2'b10 : begin
                    op_type = SRL_1; // @[Enum.scala 148:67]
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
            op_type = LUIH8; // @[Enum.scala 148:67]
          end
          3'b011 : begin
            op_type = LUIL8; // @[Enum.scala 148:67]
          end
          3'b101 : begin
            op_type = J; // @[Enum.scala 148:67]
          end
          3'b110 : begin
            op_type = BEQZ; // @[Enum.scala 148:67]
          end
          default : begin
            op_type = BNEZ; // @[Enum.scala 148:67]
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            op_type = SLLI; // @[Enum.scala 148:67]
          end
          3'b010 : begin
            op_type = BLTZ; // @[Enum.scala 148:67]
          end
          3'b100 : begin
            case(instr_payload[12])
              1'b0 : begin
                if(((! (rs1_index == 5'h0)) && (rs2_index == 5'h0))) begin
                  op_type = JR; // @[Enum.scala 148:67]
                end else begin
                  op_type = MV; // @[Enum.scala 148:67]
                end
              end
              default : begin
                if(((rs1_index == 5'h0) && (rs2_index == 5'h0))) begin
                  op_type = EBREAK; // @[Enum.scala 148:67]
                end else begin
                  if(((! (rs1_index == 5'h0)) && (! (rs2_index == 5'h0)))) begin
                    op_type = ADD; // @[Enum.scala 148:67]
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
              op_type = LV; // @[Enum.scala 148:67]
            end else begin
              case(funct3)
                3'b000 : begin
                  case(instr_payload[5 : 2])
                    4'b0000 : begin
                      op_type = VMUL_SUM; // @[Enum.scala 148:67]
                    end
                    4'b0001 : begin
                      op_type = FMSR; // @[Enum.scala 148:67]
                    end
                    4'b0010 : begin
                      op_type = VMAC8; // @[Enum.scala 148:67]
                    end
                    4'b0011 : begin
                      op_type = MAX; // @[Enum.scala 148:67]
                    end
                    4'b0100 : begin
                      op_type = MIN; // @[Enum.scala 148:67]
                    end
                    4'b0101 : begin
                      op_type = ADDX; // @[Enum.scala 148:67]
                    end
                    4'b0110 : begin
                      op_type = SUBX; // @[Enum.scala 148:67]
                    end
                    4'b0111 : begin
                      op_type = SKIPADD; // @[Enum.scala 148:67]
                    end
                    4'b1000 : begin
                      op_type = MVX; // @[Enum.scala 148:67]
                    end
                    default : begin
                    end
                  endcase
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      op_type = FXMUL; // @[Enum.scala 148:67]
                    end
                    default : begin
                      op_type = DIV; // @[Enum.scala 148:67]
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            if((dec_rs2_index == 5'h0)) begin
              op_type = SV1; // @[Enum.scala 148:67]
            end else begin
              op_type = SV2; // @[Enum.scala 148:67]
            end
          end
        endcase
      end
    endcase
  end

  assign dec_info_vld = instr_valid; // @[decoder.scala 53:19]

endmodule

module fetch (
  output              imem_rd,
  output     [10:0]   imem_addr,
  input      [15:0]   imem_rdata,
  input               fetch_start,
  input               fetch_break,
  input               fetch_restore,
  input      [10:0]   branch_addr,
  input               branch_vld,
  output              instr_valid,
  output     [15:0]   instr_payload,
  output     [10:0]   pc_curr,
  input               clk,
  input               resetn
);

  reg                 fetch_going;
  reg        [10:0]   pc_reg;
  reg        [10:0]   pc_next;
  reg                 imem_rd_regNext;

  assign imem_rd = ((fetch_start || fetch_restore) || (fetch_going && (! fetch_break))); // @[fetch.scala 42:14]
  assign pc_curr = pc_reg; // @[fetch.scala 45:14]
  always @(*) begin
    if(fetch_start) begin
      pc_next = 11'h098; // @[fetch.scala 48:13]
    end else begin
      if(branch_vld) begin
        pc_next = branch_addr[10 : 0]; // @[fetch.scala 50:13]
      end else begin
        pc_next = (pc_reg + 11'h001); // @[fetch.scala 52:13]
      end
    end
  end

  assign imem_addr = pc_next; // @[fetch.scala 59:16]
  assign instr_payload = imem_rdata; // @[fetch.scala 61:20]
  assign instr_valid = imem_rd_regNext; // @[fetch.scala 62:18]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      fetch_going <= 1'b0; // @[Data.scala 400:33]
      pc_reg <= 11'h098; // @[Data.scala 400:33]
      imem_rd_regNext <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(fetch_start) begin
        fetch_going <= 1'b1; // @[fetch.scala 36:17]
      end else begin
        if(fetch_restore) begin
          fetch_going <= 1'b1; // @[fetch.scala 38:17]
        end else begin
          if(fetch_break) begin
            fetch_going <= 1'b0; // @[fetch.scala 40:17]
          end
        end
      end
      if(imem_rd) begin
        pc_reg <= pc_next; // @[fetch.scala 56:12]
      end
      imem_rd_regNext <= imem_rd; // @[Reg.scala 39:30]
    end
  end


endmodule

module Round2Even (
  input      [32:0]   din,
  output     [23:0]   dout
);

  wire       [33:0]   tmp_tmp_dout_4;
  wire       [33:0]   tmp_tmp_dout_4_1;
  wire       [9:0]    tmp_when;
  wire       [23:0]   tmp_tmp_dout_5;
  wire       [23:0]   tmp_tmp_dout_5_1;
  wire       [31:0]   tmp_tmp_dout_6;
  wire       [32:0]   tmp_tmp_dout_6_1;
  wire       [22:0]   tmp_tmp_dout_7;
  wire       [1:0]    tmp_tmp_dout_7_1;
  wire       [21:0]   tmp_tmp_dout_7_2;
  wire       [24:0]   tmp_tmp_dout;
  wire       [24:0]   tmp_tmp_dout_1;
  wire       [24:0]   tmp_tmp_dout_2;
  reg        [23:0]   tmp_dout;
  reg        [23:0]   tmp_dout_1;
  wire       [32:0]   tmp_dout_2;
  wire       [32:0]   tmp_dout_3;
  wire       [33:0]   tmp_dout_4;
  reg        [23:0]   tmp_dout_5;
  wire       [31:0]   tmp_dout_6;
  reg        [22:0]   tmp_dout_7;
  wire       [23:0]   tmp_dout_8;
  wire       [23:0]   tmp_dout_9;

  assign tmp_tmp_dout_4 = {tmp_dout_3[32],tmp_dout_3};
  assign tmp_tmp_dout_4_1 = {tmp_dout_2[32],tmp_dout_2};
  assign tmp_when = tmp_dout_4[9 : 0];
  assign tmp_tmp_dout_5 = tmp_dout_4[33 : 10];
  assign tmp_tmp_dout_5_1 = 24'h000001;
  assign tmp_tmp_dout_6_1 = tmp_dout_4[32 : 0];
  assign tmp_tmp_dout_6 = tmp_tmp_dout_6_1[31 : 0];
  assign tmp_tmp_dout_7_1 = {1'b0,1'b1};
  assign tmp_tmp_dout_7 = {21'd0, tmp_tmp_dout_7_1};
  assign tmp_tmp_dout_7_2 = tmp_dout_6[31 : 10];
  assign tmp_tmp_dout = ($signed(tmp_tmp_dout_1) + $signed(tmp_tmp_dout_2));
  assign tmp_tmp_dout_1 = {tmp_dout_9[23],tmp_dout_9};
  assign tmp_tmp_dout_2 = {tmp_dout_8[23],tmp_dout_8};
  assign tmp_dout_2 = {24'hffffff,9'h0}; // @[BaseType.scala 318:22]
  assign tmp_dout_3 = din[32 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dout_4 = ($signed(tmp_tmp_dout_4) + $signed(tmp_tmp_dout_4_1)); // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dout_5 = ($signed(tmp_tmp_dout_5) + $signed(tmp_tmp_dout_5_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dout_5 = tmp_dout_4[33 : 10]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dout_4[33]) begin
      tmp_dout_1 = tmp_dout_5; // @[SInt.scala 286:11]
    end else begin
      tmp_dout_1 = {1'b0,tmp_dout_7}; // @[SInt.scala 288:11]
    end
  end

  assign tmp_dout_6 = tmp_tmp_dout_6; // @[BaseType.scala 318:22]
  always @(*) begin
    if((|tmp_dout_6[9 : 0])) begin
      tmp_dout_7 = ({1'b0,tmp_dout_6[31 : 10]} + tmp_tmp_dout_7); // @[UInt.scala 171:11]
    end else begin
      tmp_dout_7 = {1'd0, tmp_tmp_dout_7_2}; // @[UInt.scala 173:11]
    end
  end

  always @(*) begin
    if((! din[10])) begin
      tmp_dout = tmp_dout_1; // @[SInt.scala 358:11]
    end else begin
      tmp_dout = (tmp_tmp_dout >>> 1); // @[SInt.scala 360:11]
    end
  end

  assign tmp_dout_8 = {23'h0,1'b1}; // @[BaseType.scala 318:22]
  assign tmp_dout_9 = din[32 : 9]; // @[BaseType.scala 299:24]
  assign dout = tmp_dout; // @[Round2Even.scala 13:11]

endmodule

module RoundandSat (
  input      [20:0]   din,
  output     [15:0]   dout
);

  wire       [21:0]   tmp_tmp_dataOut_5;
  wire       [21:0]   tmp_tmp_dataOut_5_1;
  wire       [1:0]    tmp_when;
  wire       [19:0]   tmp_tmp_dataOut_7;
  wire       [19:0]   tmp_tmp_dataOut_7_1;
  wire       [21:0]   tmp_tmp_dataOut_1;
  wire       [21:0]   tmp_tmp_dataOut_1_1;
  wire       [21:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  wire       [3:0]    tmp_when_3;
  wire       [2:0]    tmp_when_4;
  (* keep *) wire       [15:0]   dataOut;
  wire       [20:0]   tmp_dataOut;
  reg        [19:0]   tmp_dataOut_1;
  wire       [20:0]   tmp_dataOut_2;
  wire       [20:0]   tmp_dataOut_3;
  wire       [20:0]   tmp_dataOut_4;
  wire       [21:0]   tmp_dataOut_5;
  wire       [20:0]   tmp_dataOut_6;
  reg        [19:0]   tmp_dataOut_7;
  reg        [18:0]   tmp_dataOut_8;
  reg        [15:0]   tmp_dataOut_9;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[20],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[20],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[1 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[21 : 2];
  assign tmp_tmp_dataOut_7_1 = 20'h00001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[20],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[20],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[19 : 18];
  assign tmp_when_2 = tmp_dataOut_1[18 : 18];
  assign tmp_when_3 = tmp_dataOut_8[18 : 15];
  assign tmp_when_4 = tmp_dataOut_8[17 : 15];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{19'h0,1'b1},1'b0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {20'hfffff,1'b0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[20 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[20 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[21 : 2]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[21]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 2); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_1[19]) begin
      if((! (&tmp_when_1))) begin
        tmp_dataOut_8 = 19'h40000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[18 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_dataOut_8 = 19'h3ffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[18 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    if(tmp_dataOut_8[18]) begin
      if((! (&tmp_when_3))) begin
        tmp_dataOut_9 = 16'h8000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[15 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_dataOut_9 = 16'h7fff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[15 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign dataOut = tmp_dataOut_9; // @[RoundandSat.scala 22:13]
  assign dout = dataOut; // @[RoundandSat.scala 26:11]

endmodule

module RoundandSat_1 (
  input      [31:0]   din,
  output     [19:0]   dout
);

  wire       [32:0]   tmp_tmp_dataOut_5;
  wire       [32:0]   tmp_tmp_dataOut_5_1;
  wire       [3:0]    tmp_when;
  wire       [28:0]   tmp_tmp_dataOut_7;
  wire       [28:0]   tmp_tmp_dataOut_7_1;
  wire       [32:0]   tmp_tmp_dataOut_1;
  wire       [32:0]   tmp_tmp_dataOut_1_1;
  wire       [32:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  wire       [8:0]    tmp_when_3;
  wire       [7:0]    tmp_when_4;
  (* keep *) wire       [19:0]   dataOut;
  wire       [31:0]   tmp_dataOut;
  reg        [28:0]   tmp_dataOut_1;
  wire       [31:0]   tmp_dataOut_2;
  wire       [31:0]   tmp_dataOut_3;
  wire       [31:0]   tmp_dataOut_4;
  wire       [32:0]   tmp_dataOut_5;
  wire       [31:0]   tmp_dataOut_6;
  reg        [28:0]   tmp_dataOut_7;
  reg        [27:0]   tmp_dataOut_8;
  reg        [19:0]   tmp_dataOut_9;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[31],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[31],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[3 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[32 : 4];
  assign tmp_tmp_dataOut_7_1 = 29'h00000001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[31],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[31],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[28 : 27];
  assign tmp_when_2 = tmp_dataOut_1[27 : 27];
  assign tmp_when_3 = tmp_dataOut_8[27 : 19];
  assign tmp_when_4 = tmp_dataOut_8[26 : 19];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{28'h0,1'b1},3'b000}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {29'h1fffffff,3'b000}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[31 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[31 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[32 : 4]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[32]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 4); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_1[28]) begin
      if((! (&tmp_when_1))) begin
        tmp_dataOut_8 = 28'h8000000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[27 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_dataOut_8 = 28'h7ffffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[27 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    if(tmp_dataOut_8[27]) begin
      if((! (&tmp_when_3))) begin
        tmp_dataOut_9 = 20'h80000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[19 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_dataOut_9 = 20'h7ffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[19 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign dataOut = tmp_dataOut_9; // @[RoundandSat.scala 22:13]
  assign dout = dataOut; // @[RoundandSat.scala 26:11]

endmodule

module mel_rom (
  input      [7:0]    mel_filter_addr,
  output     [7:0]    mel_filter,
  input      [4:0]    mel_index_addr,
  output     [7:0]    mel_index,
  output     [3:0]    mel_len
);

  reg        [7:0]    tmp_mel_filter;
  reg        [11:0]   tmp_mel_len;
  reg        [11:0]   tmp_mel_index;
  wire       [7:0]    mel_data_0;
  wire       [7:0]    mel_data_1;
  wire       [7:0]    mel_data_2;
  wire       [7:0]    mel_data_3;
  wire       [7:0]    mel_data_4;
  wire       [7:0]    mel_data_5;
  wire       [7:0]    mel_data_6;
  wire       [7:0]    mel_data_7;
  wire       [7:0]    mel_data_8;
  wire       [7:0]    mel_data_9;
  wire       [7:0]    mel_data_10;
  wire       [7:0]    mel_data_11;
  wire       [7:0]    mel_data_12;
  wire       [7:0]    mel_data_13;
  wire       [7:0]    mel_data_14;
  wire       [7:0]    mel_data_15;
  wire       [7:0]    mel_data_16;
  wire       [7:0]    mel_data_17;
  wire       [7:0]    mel_data_18;
  wire       [7:0]    mel_data_19;
  wire       [7:0]    mel_data_20;
  wire       [7:0]    mel_data_21;
  wire       [7:0]    mel_data_22;
  wire       [7:0]    mel_data_23;
  wire       [7:0]    mel_data_24;
  wire       [7:0]    mel_data_25;
  wire       [7:0]    mel_data_26;
  wire       [7:0]    mel_data_27;
  wire       [7:0]    mel_data_28;
  wire       [7:0]    mel_data_29;
  wire       [7:0]    mel_data_30;
  wire       [7:0]    mel_data_31;
  wire       [7:0]    mel_data_32;
  wire       [7:0]    mel_data_33;
  wire       [7:0]    mel_data_34;
  wire       [7:0]    mel_data_35;
  wire       [7:0]    mel_data_36;
  wire       [7:0]    mel_data_37;
  wire       [7:0]    mel_data_38;
  wire       [7:0]    mel_data_39;
  wire       [7:0]    mel_data_40;
  wire       [7:0]    mel_data_41;
  wire       [7:0]    mel_data_42;
  wire       [7:0]    mel_data_43;
  wire       [7:0]    mel_data_44;
  wire       [7:0]    mel_data_45;
  wire       [7:0]    mel_data_46;
  wire       [7:0]    mel_data_47;
  wire       [7:0]    mel_data_48;
  wire       [7:0]    mel_data_49;
  wire       [7:0]    mel_data_50;
  wire       [7:0]    mel_data_51;
  wire       [7:0]    mel_data_52;
  wire       [7:0]    mel_data_53;
  wire       [7:0]    mel_data_54;
  wire       [7:0]    mel_data_55;
  wire       [7:0]    mel_data_56;
  wire       [7:0]    mel_data_57;
  wire       [7:0]    mel_data_58;
  wire       [7:0]    mel_data_59;
  wire       [7:0]    mel_data_60;
  wire       [7:0]    mel_data_61;
  wire       [7:0]    mel_data_62;
  wire       [7:0]    mel_data_63;
  wire       [7:0]    mel_data_64;
  wire       [7:0]    mel_data_65;
  wire       [7:0]    mel_data_66;
  wire       [7:0]    mel_data_67;
  wire       [7:0]    mel_data_68;
  wire       [7:0]    mel_data_69;
  wire       [7:0]    mel_data_70;
  wire       [7:0]    mel_data_71;
  wire       [7:0]    mel_data_72;
  wire       [7:0]    mel_data_73;
  wire       [7:0]    mel_data_74;
  wire       [7:0]    mel_data_75;
  wire       [7:0]    mel_data_76;
  wire       [7:0]    mel_data_77;
  wire       [7:0]    mel_data_78;
  wire       [7:0]    mel_data_79;
  wire       [7:0]    mel_data_80;
  wire       [7:0]    mel_data_81;
  wire       [7:0]    mel_data_82;
  wire       [7:0]    mel_data_83;
  wire       [7:0]    mel_data_84;
  wire       [7:0]    mel_data_85;
  wire       [7:0]    mel_data_86;
  wire       [7:0]    mel_data_87;
  wire       [7:0]    mel_data_88;
  wire       [7:0]    mel_data_89;
  wire       [7:0]    mel_data_90;
  wire       [7:0]    mel_data_91;
  wire       [7:0]    mel_data_92;
  wire       [7:0]    mel_data_93;
  wire       [7:0]    mel_data_94;
  wire       [7:0]    mel_data_95;
  wire       [7:0]    mel_data_96;
  wire       [7:0]    mel_data_97;
  wire       [7:0]    mel_data_98;
  wire       [7:0]    mel_data_99;
  wire       [7:0]    mel_data_100;
  wire       [7:0]    mel_data_101;
  wire       [7:0]    mel_data_102;
  wire       [7:0]    mel_data_103;
  wire       [7:0]    mel_data_104;
  wire       [7:0]    mel_data_105;
  wire       [7:0]    mel_data_106;
  wire       [7:0]    mel_data_107;
  wire       [7:0]    mel_data_108;
  wire       [7:0]    mel_data_109;
  wire       [7:0]    mel_data_110;
  wire       [7:0]    mel_data_111;
  wire       [7:0]    mel_data_112;
  wire       [7:0]    mel_data_113;
  wire       [7:0]    mel_data_114;
  wire       [7:0]    mel_data_115;
  wire       [7:0]    mel_data_116;
  wire       [7:0]    mel_data_117;
  wire       [7:0]    mel_data_118;
  wire       [7:0]    mel_data_119;
  wire       [7:0]    mel_data_120;
  wire       [7:0]    mel_data_121;
  wire       [7:0]    mel_data_122;
  wire       [7:0]    mel_data_123;
  wire       [7:0]    mel_data_124;
  wire       [7:0]    mel_data_125;
  wire       [7:0]    mel_data_126;
  wire       [7:0]    mel_data_127;
  wire       [7:0]    mel_data_128;
  wire       [7:0]    mel_data_129;
  wire       [7:0]    mel_data_130;
  wire       [7:0]    mel_data_131;
  wire       [7:0]    mel_data_132;
  wire       [7:0]    mel_data_133;
  wire       [7:0]    mel_data_134;
  wire       [7:0]    mel_data_135;
  wire       [7:0]    mel_data_136;
  wire       [7:0]    mel_data_137;
  wire       [7:0]    mel_data_138;
  wire       [7:0]    mel_data_139;
  wire       [7:0]    mel_data_140;
  wire       [7:0]    mel_data_141;
  wire       [7:0]    mel_data_142;
  wire       [7:0]    mel_data_143;
  wire       [7:0]    mel_data_144;
  wire       [7:0]    mel_data_145;
  wire       [7:0]    mel_data_146;
  wire       [7:0]    mel_data_147;
  wire       [7:0]    mel_data_148;
  wire       [7:0]    mel_data_149;
  wire       [7:0]    mel_data_150;
  wire       [7:0]    mel_data_151;
  wire       [7:0]    mel_data_152;
  wire       [7:0]    mel_data_153;
  wire       [7:0]    mel_data_154;
  wire       [7:0]    mel_data_155;
  wire       [7:0]    mel_data_156;
  wire       [7:0]    mel_data_157;
  wire       [7:0]    mel_data_158;
  wire       [7:0]    mel_data_159;
  wire       [7:0]    mel_data_160;
  wire       [7:0]    mel_data_161;
  wire       [7:0]    mel_data_162;
  wire       [7:0]    mel_data_163;
  wire       [7:0]    mel_data_164;
  wire       [7:0]    mel_data_165;
  wire       [7:0]    mel_data_166;
  wire       [7:0]    mel_data_167;
  wire       [7:0]    mel_data_168;
  wire       [7:0]    mel_data_169;
  wire       [7:0]    mel_data_170;
  wire       [7:0]    mel_data_171;
  wire       [7:0]    mel_data_172;
  wire       [7:0]    mel_data_173;
  wire       [7:0]    mel_data_174;
  wire       [7:0]    mel_data_175;
  wire       [7:0]    mel_data_176;
  wire       [7:0]    mel_data_177;
  wire       [7:0]    mel_data_178;
  wire       [7:0]    mel_data_179;
  wire       [7:0]    mel_data_180;
  wire       [7:0]    mel_data_181;
  wire       [7:0]    mel_data_182;
  wire       [7:0]    mel_data_183;
  wire       [7:0]    mel_data_184;
  wire       [7:0]    mel_data_185;
  wire       [7:0]    mel_data_186;
  wire       [7:0]    mel_data_187;
  wire       [7:0]    mel_data_188;
  wire       [7:0]    mel_data_189;
  wire       [7:0]    mel_data_190;
  wire       [7:0]    mel_data_191;
  wire       [7:0]    mel_data_192;
  wire       [7:0]    mel_data_193;
  wire       [7:0]    mel_data_194;
  wire       [7:0]    mel_data_195;
  wire       [7:0]    mel_data_196;
  wire       [7:0]    mel_data_197;
  wire       [7:0]    mel_data_198;
  wire       [7:0]    mel_data_199;
  wire       [7:0]    mel_data_200;
  wire       [7:0]    mel_data_201;
  wire       [7:0]    mel_data_202;
  wire       [11:0]   mel_index_data_0;
  wire       [11:0]   mel_index_data_1;
  wire       [11:0]   mel_index_data_2;
  wire       [11:0]   mel_index_data_3;
  wire       [11:0]   mel_index_data_4;
  wire       [11:0]   mel_index_data_5;
  wire       [11:0]   mel_index_data_6;
  wire       [11:0]   mel_index_data_7;
  wire       [11:0]   mel_index_data_8;
  wire       [11:0]   mel_index_data_9;
  wire       [11:0]   mel_index_data_10;
  wire       [11:0]   mel_index_data_11;
  wire       [11:0]   mel_index_data_12;
  wire       [11:0]   mel_index_data_13;
  wire       [11:0]   mel_index_data_14;
  wire       [11:0]   mel_index_data_15;
  wire       [11:0]   mel_index_data_16;
  wire       [11:0]   mel_index_data_17;
  wire       [11:0]   mel_index_data_18;
  wire       [11:0]   mel_index_data_19;
  wire       [11:0]   mel_index_data_20;
  wire       [11:0]   mel_index_data_21;
  wire       [11:0]   mel_index_data_22;
  wire       [11:0]   mel_index_data_23;
  wire       [11:0]   mel_index_data_24;
  wire       [11:0]   mel_index_data_25;
  wire       [11:0]   mel_index_data_26;
  wire       [11:0]   mel_index_data_27;
  wire       [11:0]   mel_index_data_28;
  wire       [11:0]   mel_index_data_29;

  always @(*) begin
    case(mel_filter_addr)
      8'b00000000 : tmp_mel_filter = mel_data_0;
      8'b00000001 : tmp_mel_filter = mel_data_1;
      8'b00000010 : tmp_mel_filter = mel_data_2;
      8'b00000011 : tmp_mel_filter = mel_data_3;
      8'b00000100 : tmp_mel_filter = mel_data_4;
      8'b00000101 : tmp_mel_filter = mel_data_5;
      8'b00000110 : tmp_mel_filter = mel_data_6;
      8'b00000111 : tmp_mel_filter = mel_data_7;
      8'b00001000 : tmp_mel_filter = mel_data_8;
      8'b00001001 : tmp_mel_filter = mel_data_9;
      8'b00001010 : tmp_mel_filter = mel_data_10;
      8'b00001011 : tmp_mel_filter = mel_data_11;
      8'b00001100 : tmp_mel_filter = mel_data_12;
      8'b00001101 : tmp_mel_filter = mel_data_13;
      8'b00001110 : tmp_mel_filter = mel_data_14;
      8'b00001111 : tmp_mel_filter = mel_data_15;
      8'b00010000 : tmp_mel_filter = mel_data_16;
      8'b00010001 : tmp_mel_filter = mel_data_17;
      8'b00010010 : tmp_mel_filter = mel_data_18;
      8'b00010011 : tmp_mel_filter = mel_data_19;
      8'b00010100 : tmp_mel_filter = mel_data_20;
      8'b00010101 : tmp_mel_filter = mel_data_21;
      8'b00010110 : tmp_mel_filter = mel_data_22;
      8'b00010111 : tmp_mel_filter = mel_data_23;
      8'b00011000 : tmp_mel_filter = mel_data_24;
      8'b00011001 : tmp_mel_filter = mel_data_25;
      8'b00011010 : tmp_mel_filter = mel_data_26;
      8'b00011011 : tmp_mel_filter = mel_data_27;
      8'b00011100 : tmp_mel_filter = mel_data_28;
      8'b00011101 : tmp_mel_filter = mel_data_29;
      8'b00011110 : tmp_mel_filter = mel_data_30;
      8'b00011111 : tmp_mel_filter = mel_data_31;
      8'b00100000 : tmp_mel_filter = mel_data_32;
      8'b00100001 : tmp_mel_filter = mel_data_33;
      8'b00100010 : tmp_mel_filter = mel_data_34;
      8'b00100011 : tmp_mel_filter = mel_data_35;
      8'b00100100 : tmp_mel_filter = mel_data_36;
      8'b00100101 : tmp_mel_filter = mel_data_37;
      8'b00100110 : tmp_mel_filter = mel_data_38;
      8'b00100111 : tmp_mel_filter = mel_data_39;
      8'b00101000 : tmp_mel_filter = mel_data_40;
      8'b00101001 : tmp_mel_filter = mel_data_41;
      8'b00101010 : tmp_mel_filter = mel_data_42;
      8'b00101011 : tmp_mel_filter = mel_data_43;
      8'b00101100 : tmp_mel_filter = mel_data_44;
      8'b00101101 : tmp_mel_filter = mel_data_45;
      8'b00101110 : tmp_mel_filter = mel_data_46;
      8'b00101111 : tmp_mel_filter = mel_data_47;
      8'b00110000 : tmp_mel_filter = mel_data_48;
      8'b00110001 : tmp_mel_filter = mel_data_49;
      8'b00110010 : tmp_mel_filter = mel_data_50;
      8'b00110011 : tmp_mel_filter = mel_data_51;
      8'b00110100 : tmp_mel_filter = mel_data_52;
      8'b00110101 : tmp_mel_filter = mel_data_53;
      8'b00110110 : tmp_mel_filter = mel_data_54;
      8'b00110111 : tmp_mel_filter = mel_data_55;
      8'b00111000 : tmp_mel_filter = mel_data_56;
      8'b00111001 : tmp_mel_filter = mel_data_57;
      8'b00111010 : tmp_mel_filter = mel_data_58;
      8'b00111011 : tmp_mel_filter = mel_data_59;
      8'b00111100 : tmp_mel_filter = mel_data_60;
      8'b00111101 : tmp_mel_filter = mel_data_61;
      8'b00111110 : tmp_mel_filter = mel_data_62;
      8'b00111111 : tmp_mel_filter = mel_data_63;
      8'b01000000 : tmp_mel_filter = mel_data_64;
      8'b01000001 : tmp_mel_filter = mel_data_65;
      8'b01000010 : tmp_mel_filter = mel_data_66;
      8'b01000011 : tmp_mel_filter = mel_data_67;
      8'b01000100 : tmp_mel_filter = mel_data_68;
      8'b01000101 : tmp_mel_filter = mel_data_69;
      8'b01000110 : tmp_mel_filter = mel_data_70;
      8'b01000111 : tmp_mel_filter = mel_data_71;
      8'b01001000 : tmp_mel_filter = mel_data_72;
      8'b01001001 : tmp_mel_filter = mel_data_73;
      8'b01001010 : tmp_mel_filter = mel_data_74;
      8'b01001011 : tmp_mel_filter = mel_data_75;
      8'b01001100 : tmp_mel_filter = mel_data_76;
      8'b01001101 : tmp_mel_filter = mel_data_77;
      8'b01001110 : tmp_mel_filter = mel_data_78;
      8'b01001111 : tmp_mel_filter = mel_data_79;
      8'b01010000 : tmp_mel_filter = mel_data_80;
      8'b01010001 : tmp_mel_filter = mel_data_81;
      8'b01010010 : tmp_mel_filter = mel_data_82;
      8'b01010011 : tmp_mel_filter = mel_data_83;
      8'b01010100 : tmp_mel_filter = mel_data_84;
      8'b01010101 : tmp_mel_filter = mel_data_85;
      8'b01010110 : tmp_mel_filter = mel_data_86;
      8'b01010111 : tmp_mel_filter = mel_data_87;
      8'b01011000 : tmp_mel_filter = mel_data_88;
      8'b01011001 : tmp_mel_filter = mel_data_89;
      8'b01011010 : tmp_mel_filter = mel_data_90;
      8'b01011011 : tmp_mel_filter = mel_data_91;
      8'b01011100 : tmp_mel_filter = mel_data_92;
      8'b01011101 : tmp_mel_filter = mel_data_93;
      8'b01011110 : tmp_mel_filter = mel_data_94;
      8'b01011111 : tmp_mel_filter = mel_data_95;
      8'b01100000 : tmp_mel_filter = mel_data_96;
      8'b01100001 : tmp_mel_filter = mel_data_97;
      8'b01100010 : tmp_mel_filter = mel_data_98;
      8'b01100011 : tmp_mel_filter = mel_data_99;
      8'b01100100 : tmp_mel_filter = mel_data_100;
      8'b01100101 : tmp_mel_filter = mel_data_101;
      8'b01100110 : tmp_mel_filter = mel_data_102;
      8'b01100111 : tmp_mel_filter = mel_data_103;
      8'b01101000 : tmp_mel_filter = mel_data_104;
      8'b01101001 : tmp_mel_filter = mel_data_105;
      8'b01101010 : tmp_mel_filter = mel_data_106;
      8'b01101011 : tmp_mel_filter = mel_data_107;
      8'b01101100 : tmp_mel_filter = mel_data_108;
      8'b01101101 : tmp_mel_filter = mel_data_109;
      8'b01101110 : tmp_mel_filter = mel_data_110;
      8'b01101111 : tmp_mel_filter = mel_data_111;
      8'b01110000 : tmp_mel_filter = mel_data_112;
      8'b01110001 : tmp_mel_filter = mel_data_113;
      8'b01110010 : tmp_mel_filter = mel_data_114;
      8'b01110011 : tmp_mel_filter = mel_data_115;
      8'b01110100 : tmp_mel_filter = mel_data_116;
      8'b01110101 : tmp_mel_filter = mel_data_117;
      8'b01110110 : tmp_mel_filter = mel_data_118;
      8'b01110111 : tmp_mel_filter = mel_data_119;
      8'b01111000 : tmp_mel_filter = mel_data_120;
      8'b01111001 : tmp_mel_filter = mel_data_121;
      8'b01111010 : tmp_mel_filter = mel_data_122;
      8'b01111011 : tmp_mel_filter = mel_data_123;
      8'b01111100 : tmp_mel_filter = mel_data_124;
      8'b01111101 : tmp_mel_filter = mel_data_125;
      8'b01111110 : tmp_mel_filter = mel_data_126;
      8'b01111111 : tmp_mel_filter = mel_data_127;
      8'b10000000 : tmp_mel_filter = mel_data_128;
      8'b10000001 : tmp_mel_filter = mel_data_129;
      8'b10000010 : tmp_mel_filter = mel_data_130;
      8'b10000011 : tmp_mel_filter = mel_data_131;
      8'b10000100 : tmp_mel_filter = mel_data_132;
      8'b10000101 : tmp_mel_filter = mel_data_133;
      8'b10000110 : tmp_mel_filter = mel_data_134;
      8'b10000111 : tmp_mel_filter = mel_data_135;
      8'b10001000 : tmp_mel_filter = mel_data_136;
      8'b10001001 : tmp_mel_filter = mel_data_137;
      8'b10001010 : tmp_mel_filter = mel_data_138;
      8'b10001011 : tmp_mel_filter = mel_data_139;
      8'b10001100 : tmp_mel_filter = mel_data_140;
      8'b10001101 : tmp_mel_filter = mel_data_141;
      8'b10001110 : tmp_mel_filter = mel_data_142;
      8'b10001111 : tmp_mel_filter = mel_data_143;
      8'b10010000 : tmp_mel_filter = mel_data_144;
      8'b10010001 : tmp_mel_filter = mel_data_145;
      8'b10010010 : tmp_mel_filter = mel_data_146;
      8'b10010011 : tmp_mel_filter = mel_data_147;
      8'b10010100 : tmp_mel_filter = mel_data_148;
      8'b10010101 : tmp_mel_filter = mel_data_149;
      8'b10010110 : tmp_mel_filter = mel_data_150;
      8'b10010111 : tmp_mel_filter = mel_data_151;
      8'b10011000 : tmp_mel_filter = mel_data_152;
      8'b10011001 : tmp_mel_filter = mel_data_153;
      8'b10011010 : tmp_mel_filter = mel_data_154;
      8'b10011011 : tmp_mel_filter = mel_data_155;
      8'b10011100 : tmp_mel_filter = mel_data_156;
      8'b10011101 : tmp_mel_filter = mel_data_157;
      8'b10011110 : tmp_mel_filter = mel_data_158;
      8'b10011111 : tmp_mel_filter = mel_data_159;
      8'b10100000 : tmp_mel_filter = mel_data_160;
      8'b10100001 : tmp_mel_filter = mel_data_161;
      8'b10100010 : tmp_mel_filter = mel_data_162;
      8'b10100011 : tmp_mel_filter = mel_data_163;
      8'b10100100 : tmp_mel_filter = mel_data_164;
      8'b10100101 : tmp_mel_filter = mel_data_165;
      8'b10100110 : tmp_mel_filter = mel_data_166;
      8'b10100111 : tmp_mel_filter = mel_data_167;
      8'b10101000 : tmp_mel_filter = mel_data_168;
      8'b10101001 : tmp_mel_filter = mel_data_169;
      8'b10101010 : tmp_mel_filter = mel_data_170;
      8'b10101011 : tmp_mel_filter = mel_data_171;
      8'b10101100 : tmp_mel_filter = mel_data_172;
      8'b10101101 : tmp_mel_filter = mel_data_173;
      8'b10101110 : tmp_mel_filter = mel_data_174;
      8'b10101111 : tmp_mel_filter = mel_data_175;
      8'b10110000 : tmp_mel_filter = mel_data_176;
      8'b10110001 : tmp_mel_filter = mel_data_177;
      8'b10110010 : tmp_mel_filter = mel_data_178;
      8'b10110011 : tmp_mel_filter = mel_data_179;
      8'b10110100 : tmp_mel_filter = mel_data_180;
      8'b10110101 : tmp_mel_filter = mel_data_181;
      8'b10110110 : tmp_mel_filter = mel_data_182;
      8'b10110111 : tmp_mel_filter = mel_data_183;
      8'b10111000 : tmp_mel_filter = mel_data_184;
      8'b10111001 : tmp_mel_filter = mel_data_185;
      8'b10111010 : tmp_mel_filter = mel_data_186;
      8'b10111011 : tmp_mel_filter = mel_data_187;
      8'b10111100 : tmp_mel_filter = mel_data_188;
      8'b10111101 : tmp_mel_filter = mel_data_189;
      8'b10111110 : tmp_mel_filter = mel_data_190;
      8'b10111111 : tmp_mel_filter = mel_data_191;
      8'b11000000 : tmp_mel_filter = mel_data_192;
      8'b11000001 : tmp_mel_filter = mel_data_193;
      8'b11000010 : tmp_mel_filter = mel_data_194;
      8'b11000011 : tmp_mel_filter = mel_data_195;
      8'b11000100 : tmp_mel_filter = mel_data_196;
      8'b11000101 : tmp_mel_filter = mel_data_197;
      8'b11000110 : tmp_mel_filter = mel_data_198;
      8'b11000111 : tmp_mel_filter = mel_data_199;
      8'b11001000 : tmp_mel_filter = mel_data_200;
      8'b11001001 : tmp_mel_filter = mel_data_201;
      default : tmp_mel_filter = mel_data_202;
    endcase
  end

  always @(*) begin
    case(mel_index_addr)
      5'b00000 : begin
        tmp_mel_len = mel_index_data_0;
        tmp_mel_index = mel_index_data_0;
      end
      5'b00001 : begin
        tmp_mel_len = mel_index_data_1;
        tmp_mel_index = mel_index_data_1;
      end
      5'b00010 : begin
        tmp_mel_len = mel_index_data_2;
        tmp_mel_index = mel_index_data_2;
      end
      5'b00011 : begin
        tmp_mel_len = mel_index_data_3;
        tmp_mel_index = mel_index_data_3;
      end
      5'b00100 : begin
        tmp_mel_len = mel_index_data_4;
        tmp_mel_index = mel_index_data_4;
      end
      5'b00101 : begin
        tmp_mel_len = mel_index_data_5;
        tmp_mel_index = mel_index_data_5;
      end
      5'b00110 : begin
        tmp_mel_len = mel_index_data_6;
        tmp_mel_index = mel_index_data_6;
      end
      5'b00111 : begin
        tmp_mel_len = mel_index_data_7;
        tmp_mel_index = mel_index_data_7;
      end
      5'b01000 : begin
        tmp_mel_len = mel_index_data_8;
        tmp_mel_index = mel_index_data_8;
      end
      5'b01001 : begin
        tmp_mel_len = mel_index_data_9;
        tmp_mel_index = mel_index_data_9;
      end
      5'b01010 : begin
        tmp_mel_len = mel_index_data_10;
        tmp_mel_index = mel_index_data_10;
      end
      5'b01011 : begin
        tmp_mel_len = mel_index_data_11;
        tmp_mel_index = mel_index_data_11;
      end
      5'b01100 : begin
        tmp_mel_len = mel_index_data_12;
        tmp_mel_index = mel_index_data_12;
      end
      5'b01101 : begin
        tmp_mel_len = mel_index_data_13;
        tmp_mel_index = mel_index_data_13;
      end
      5'b01110 : begin
        tmp_mel_len = mel_index_data_14;
        tmp_mel_index = mel_index_data_14;
      end
      5'b01111 : begin
        tmp_mel_len = mel_index_data_15;
        tmp_mel_index = mel_index_data_15;
      end
      5'b10000 : begin
        tmp_mel_len = mel_index_data_16;
        tmp_mel_index = mel_index_data_16;
      end
      5'b10001 : begin
        tmp_mel_len = mel_index_data_17;
        tmp_mel_index = mel_index_data_17;
      end
      5'b10010 : begin
        tmp_mel_len = mel_index_data_18;
        tmp_mel_index = mel_index_data_18;
      end
      5'b10011 : begin
        tmp_mel_len = mel_index_data_19;
        tmp_mel_index = mel_index_data_19;
      end
      5'b10100 : begin
        tmp_mel_len = mel_index_data_20;
        tmp_mel_index = mel_index_data_20;
      end
      5'b10101 : begin
        tmp_mel_len = mel_index_data_21;
        tmp_mel_index = mel_index_data_21;
      end
      5'b10110 : begin
        tmp_mel_len = mel_index_data_22;
        tmp_mel_index = mel_index_data_22;
      end
      5'b10111 : begin
        tmp_mel_len = mel_index_data_23;
        tmp_mel_index = mel_index_data_23;
      end
      5'b11000 : begin
        tmp_mel_len = mel_index_data_24;
        tmp_mel_index = mel_index_data_24;
      end
      5'b11001 : begin
        tmp_mel_len = mel_index_data_25;
        tmp_mel_index = mel_index_data_25;
      end
      5'b11010 : begin
        tmp_mel_len = mel_index_data_26;
        tmp_mel_index = mel_index_data_26;
      end
      5'b11011 : begin
        tmp_mel_len = mel_index_data_27;
        tmp_mel_index = mel_index_data_27;
      end
      5'b11100 : begin
        tmp_mel_len = mel_index_data_28;
        tmp_mel_index = mel_index_data_28;
      end
      default : begin
        tmp_mel_len = mel_index_data_29;
        tmp_mel_index = mel_index_data_29;
      end
    endcase
  end

  assign mel_data_0 = 8'h52; // @[Expression.scala 2342:18]
  assign mel_data_1 = 8'hf3; // @[Expression.scala 2342:18]
  assign mel_data_2 = 8'h43; // @[Expression.scala 2342:18]
  assign mel_data_3 = 8'h0c; // @[Expression.scala 2342:18]
  assign mel_data_4 = 8'hbc; // @[Expression.scala 2342:18]
  assign mel_data_5 = 8'h98; // @[Expression.scala 2342:18]
  assign mel_data_6 = 8'h67; // @[Expression.scala 2342:18]
  assign mel_data_7 = 8'hf0; // @[Expression.scala 2342:18]
  assign mel_data_8 = 8'h52; // @[Expression.scala 2342:18]
  assign mel_data_9 = 8'h0f; // @[Expression.scala 2342:18]
  assign mel_data_10 = 8'had; // @[Expression.scala 2342:18]
  assign mel_data_11 = 8'hb7; // @[Expression.scala 2342:18]
  assign mel_data_12 = 8'h21; // @[Expression.scala 2342:18]
  assign mel_data_13 = 8'h48; // @[Expression.scala 2342:18]
  assign mel_data_14 = 8'hde; // @[Expression.scala 2342:18]
  assign mel_data_15 = 8'h90; // @[Expression.scala 2342:18]
  assign mel_data_16 = 8'h02; // @[Expression.scala 2342:18]
  assign mel_data_17 = 8'h6f; // @[Expression.scala 2342:18]
  assign mel_data_18 = 8'hfd; // @[Expression.scala 2342:18]
  assign mel_data_19 = 8'h7a; // @[Expression.scala 2342:18]
  assign mel_data_20 = 8'h85; // @[Expression.scala 2342:18]
  assign mel_data_21 = 8'hf3; // @[Expression.scala 2342:18]
  assign mel_data_22 = 8'h73; // @[Expression.scala 2342:18]
  assign mel_data_23 = 8'h0c; // @[Expression.scala 2342:18]
  assign mel_data_24 = 8'h8c; // @[Expression.scala 2342:18]
  assign mel_data_25 = 8'hf3; // @[Expression.scala 2342:18]
  assign mel_data_26 = 8'h7a; // @[Expression.scala 2342:18]
  assign mel_data_27 = 8'h01; // @[Expression.scala 2342:18]
  assign mel_data_28 = 8'h0c; // @[Expression.scala 2342:18]
  assign mel_data_29 = 8'h85; // @[Expression.scala 2342:18]
  assign mel_data_30 = 8'hfe; // @[Expression.scala 2342:18]
  assign mel_data_31 = 8'h8d; // @[Expression.scala 2342:18]
  assign mel_data_32 = 8'h1b; // @[Expression.scala 2342:18]
  assign mel_data_33 = 8'h72; // @[Expression.scala 2342:18]
  assign mel_data_34 = 8'he4; // @[Expression.scala 2342:18]
  assign mel_data_35 = 8'hab; // @[Expression.scala 2342:18]
  assign mel_data_36 = 8'h3f; // @[Expression.scala 2342:18]
  assign mel_data_37 = 8'h54; // @[Expression.scala 2342:18]
  assign mel_data_38 = 8'hc0; // @[Expression.scala 2342:18]
  assign mel_data_39 = 8'hd3; // @[Expression.scala 2342:18]
  assign mel_data_40 = 8'h6c; // @[Expression.scala 2342:18]
  assign mel_data_41 = 8'h05; // @[Expression.scala 2342:18]
  assign mel_data_42 = 8'h2c; // @[Expression.scala 2342:18]
  assign mel_data_43 = 8'h93; // @[Expression.scala 2342:18]
  assign mel_data_44 = 8'hfa; // @[Expression.scala 2342:18]
  assign mel_data_45 = 8'ha2; // @[Expression.scala 2342:18]
  assign mel_data_46 = 8'h40; // @[Expression.scala 2342:18]
  assign mel_data_47 = 8'h5d; // @[Expression.scala 2342:18]
  assign mel_data_48 = 8'hbf; // @[Expression.scala 2342:18]
  assign mel_data_49 = 8'hdf; // @[Expression.scala 2342:18]
  assign mel_data_50 = 8'h83; // @[Expression.scala 2342:18]
  assign mel_data_51 = 8'h26; // @[Expression.scala 2342:18]
  assign mel_data_52 = 8'h20; // @[Expression.scala 2342:18]
  assign mel_data_53 = 8'h7c; // @[Expression.scala 2342:18]
  assign mel_data_54 = 8'hd9; // @[Expression.scala 2342:18]
  assign mel_data_55 = 8'hcb; // @[Expression.scala 2342:18]
  assign mel_data_56 = 8'h73; // @[Expression.scala 2342:18]
  assign mel_data_57 = 8'h1c; // @[Expression.scala 2342:18]
  assign mel_data_58 = 8'h34; // @[Expression.scala 2342:18]
  assign mel_data_59 = 8'h8c; // @[Expression.scala 2342:18]
  assign mel_data_60 = 8'he3; // @[Expression.scala 2342:18]
  assign mel_data_61 = 8'hc6; // @[Expression.scala 2342:18]
  assign mel_data_62 = 8'h73; // @[Expression.scala 2342:18]
  assign mel_data_63 = 8'h1f; // @[Expression.scala 2342:18]
  assign mel_data_64 = 8'h39; // @[Expression.scala 2342:18]
  assign mel_data_65 = 8'h8c; // @[Expression.scala 2342:18]
  assign mel_data_66 = 8'he0; // @[Expression.scala 2342:18]
  assign mel_data_67 = 8'hce; // @[Expression.scala 2342:18]
  assign mel_data_68 = 8'h7f; // @[Expression.scala 2342:18]
  assign mel_data_69 = 8'h30; // @[Expression.scala 2342:18]
  assign mel_data_70 = 8'h31; // @[Expression.scala 2342:18]
  assign mel_data_71 = 8'h80; // @[Expression.scala 2342:18]
  assign mel_data_72 = 8'hcf; // @[Expression.scala 2342:18]
  assign mel_data_73 = 8'he2; // @[Expression.scala 2342:18]
  assign mel_data_74 = 8'h97; // @[Expression.scala 2342:18]
  assign mel_data_75 = 8'h4c; // @[Expression.scala 2342:18]
  assign mel_data_76 = 8'h01; // @[Expression.scala 2342:18]
  assign mel_data_77 = 8'h1d; // @[Expression.scala 2342:18]
  assign mel_data_78 = 8'h68; // @[Expression.scala 2342:18]
  assign mel_data_79 = 8'hb3; // @[Expression.scala 2342:18]
  assign mel_data_80 = 8'hfe; // @[Expression.scala 2342:18]
  assign mel_data_81 = 8'hba; // @[Expression.scala 2342:18]
  assign mel_data_82 = 8'h73; // @[Expression.scala 2342:18]
  assign mel_data_83 = 8'h2c; // @[Expression.scala 2342:18]
  assign mel_data_84 = 8'h45; // @[Expression.scala 2342:18]
  assign mel_data_85 = 8'h8c; // @[Expression.scala 2342:18]
  assign mel_data_86 = 8'hd3; // @[Expression.scala 2342:18]
  assign mel_data_87 = 8'he5; // @[Expression.scala 2342:18]
  assign mel_data_88 = 8'ha2; // @[Expression.scala 2342:18]
  assign mel_data_89 = 8'h5f; // @[Expression.scala 2342:18]
  assign mel_data_90 = 8'h1c; // @[Expression.scala 2342:18]
  assign mel_data_91 = 8'h1a; // @[Expression.scala 2342:18]
  assign mel_data_92 = 8'h5d; // @[Expression.scala 2342:18]
  assign mel_data_93 = 8'ha0; // @[Expression.scala 2342:18]
  assign mel_data_94 = 8'he3; // @[Expression.scala 2342:18]
  assign mel_data_95 = 8'hda; // @[Expression.scala 2342:18]
  assign mel_data_96 = 8'h9a; // @[Expression.scala 2342:18]
  assign mel_data_97 = 8'h5a; // @[Expression.scala 2342:18]
  assign mel_data_98 = 8'h1b; // @[Expression.scala 2342:18]
  assign mel_data_99 = 8'h25; // @[Expression.scala 2342:18]
  assign mel_data_100 = 8'h65; // @[Expression.scala 2342:18]
  assign mel_data_101 = 8'ha5; // @[Expression.scala 2342:18]
  assign mel_data_102 = 8'he4; // @[Expression.scala 2342:18]
  assign mel_data_103 = 8'hdc; // @[Expression.scala 2342:18]
  assign mel_data_104 = 8'h9f; // @[Expression.scala 2342:18]
  assign mel_data_105 = 8'h63; // @[Expression.scala 2342:18]
  assign mel_data_106 = 8'h27; // @[Expression.scala 2342:18]
  assign mel_data_107 = 8'h23; // @[Expression.scala 2342:18]
  assign mel_data_108 = 8'h60; // @[Expression.scala 2342:18]
  assign mel_data_109 = 8'h9c; // @[Expression.scala 2342:18]
  assign mel_data_110 = 8'hd8; // @[Expression.scala 2342:18]
  assign mel_data_111 = 8'hea; // @[Expression.scala 2342:18]
  assign mel_data_112 = 8'hb1; // @[Expression.scala 2342:18]
  assign mel_data_113 = 8'h78; // @[Expression.scala 2342:18]
  assign mel_data_114 = 8'h3f; // @[Expression.scala 2342:18]
  assign mel_data_115 = 8'h06; // @[Expression.scala 2342:18]
  assign mel_data_116 = 8'h15; // @[Expression.scala 2342:18]
  assign mel_data_117 = 8'h4e; // @[Expression.scala 2342:18]
  assign mel_data_118 = 8'h87; // @[Expression.scala 2342:18]
  assign mel_data_119 = 8'hc0; // @[Expression.scala 2342:18]
  assign mel_data_120 = 8'hf9; // @[Expression.scala 2342:18]
  assign mel_data_121 = 8'hce; // @[Expression.scala 2342:18]
  assign mel_data_122 = 8'h98; // @[Expression.scala 2342:18]
  assign mel_data_123 = 8'h62; // @[Expression.scala 2342:18]
  assign mel_data_124 = 8'h2b; // @[Expression.scala 2342:18]
  assign mel_data_125 = 8'h31; // @[Expression.scala 2342:18]
  assign mel_data_126 = 8'h67; // @[Expression.scala 2342:18]
  assign mel_data_127 = 8'h9d; // @[Expression.scala 2342:18]
  assign mel_data_128 = 8'hd4; // @[Expression.scala 2342:18]
  assign mel_data_129 = 8'hf5; // @[Expression.scala 2342:18]
  assign mel_data_130 = 8'hc1; // @[Expression.scala 2342:18]
  assign mel_data_131 = 8'h8e; // @[Expression.scala 2342:18]
  assign mel_data_132 = 8'h5a; // @[Expression.scala 2342:18]
  assign mel_data_133 = 8'h27; // @[Expression.scala 2342:18]
  assign mel_data_134 = 8'h0a; // @[Expression.scala 2342:18]
  assign mel_data_135 = 8'h3e; // @[Expression.scala 2342:18]
  assign mel_data_136 = 8'h71; // @[Expression.scala 2342:18]
  assign mel_data_137 = 8'ha5; // @[Expression.scala 2342:18]
  assign mel_data_138 = 8'hd8; // @[Expression.scala 2342:18]
  assign mel_data_139 = 8'hf3; // @[Expression.scala 2342:18]
  assign mel_data_140 = 8'hc2; // @[Expression.scala 2342:18]
  assign mel_data_141 = 8'h92; // @[Expression.scala 2342:18]
  assign mel_data_142 = 8'h61; // @[Expression.scala 2342:18]
  assign mel_data_143 = 8'h30; // @[Expression.scala 2342:18]
  assign mel_data_144 = 8'h0c; // @[Expression.scala 2342:18]
  assign mel_data_145 = 8'h3d; // @[Expression.scala 2342:18]
  assign mel_data_146 = 8'h6d; // @[Expression.scala 2342:18]
  assign mel_data_147 = 8'h9e; // @[Expression.scala 2342:18]
  assign mel_data_148 = 8'hcf; // @[Expression.scala 2342:18]
  assign mel_data_149 = 8'hff; // @[Expression.scala 2342:18]
  assign mel_data_150 = 8'hd0; // @[Expression.scala 2342:18]
  assign mel_data_151 = 8'ha2; // @[Expression.scala 2342:18]
  assign mel_data_152 = 8'h74; // @[Expression.scala 2342:18]
  assign mel_data_153 = 8'h46; // @[Expression.scala 2342:18]
  assign mel_data_154 = 8'h18; // @[Expression.scala 2342:18]
  assign mel_data_155 = 8'h2f; // @[Expression.scala 2342:18]
  assign mel_data_156 = 8'h5d; // @[Expression.scala 2342:18]
  assign mel_data_157 = 8'h8b; // @[Expression.scala 2342:18]
  assign mel_data_158 = 8'hb9; // @[Expression.scala 2342:18]
  assign mel_data_159 = 8'he7; // @[Expression.scala 2342:18]
  assign mel_data_160 = 8'hea; // @[Expression.scala 2342:18]
  assign mel_data_161 = 8'hbe; // @[Expression.scala 2342:18]
  assign mel_data_162 = 8'h92; // @[Expression.scala 2342:18]
  assign mel_data_163 = 8'h66; // @[Expression.scala 2342:18]
  assign mel_data_164 = 8'h3a; // @[Expression.scala 2342:18]
  assign mel_data_165 = 8'h0f; // @[Expression.scala 2342:18]
  assign mel_data_166 = 8'h15; // @[Expression.scala 2342:18]
  assign mel_data_167 = 8'h41; // @[Expression.scala 2342:18]
  assign mel_data_168 = 8'h6d; // @[Expression.scala 2342:18]
  assign mel_data_169 = 8'h99; // @[Expression.scala 2342:18]
  assign mel_data_170 = 8'hc5; // @[Expression.scala 2342:18]
  assign mel_data_171 = 8'hf0; // @[Expression.scala 2342:18]
  assign mel_data_172 = 8'he3; // @[Expression.scala 2342:18]
  assign mel_data_173 = 8'hba; // @[Expression.scala 2342:18]
  assign mel_data_174 = 8'h90; // @[Expression.scala 2342:18]
  assign mel_data_175 = 8'h67; // @[Expression.scala 2342:18]
  assign mel_data_176 = 8'h3d; // @[Expression.scala 2342:18]
  assign mel_data_177 = 8'h14; // @[Expression.scala 2342:18]
  assign mel_data_178 = 8'h1c; // @[Expression.scala 2342:18]
  assign mel_data_179 = 8'h45; // @[Expression.scala 2342:18]
  assign mel_data_180 = 8'h6f; // @[Expression.scala 2342:18]
  assign mel_data_181 = 8'h98; // @[Expression.scala 2342:18]
  assign mel_data_182 = 8'hc2; // @[Expression.scala 2342:18]
  assign mel_data_183 = 8'heb; // @[Expression.scala 2342:18]
  assign mel_data_184 = 8'heb; // @[Expression.scala 2342:18]
  assign mel_data_185 = 8'hc3; // @[Expression.scala 2342:18]
  assign mel_data_186 = 8'h9c; // @[Expression.scala 2342:18]
  assign mel_data_187 = 8'h75; // @[Expression.scala 2342:18]
  assign mel_data_188 = 8'h4d; // @[Expression.scala 2342:18]
  assign mel_data_189 = 8'h26; // @[Expression.scala 2342:18]
  assign mel_data_190 = 8'h14; // @[Expression.scala 2342:18]
  assign mel_data_191 = 8'h3c; // @[Expression.scala 2342:18]
  assign mel_data_192 = 8'h63; // @[Expression.scala 2342:18]
  assign mel_data_193 = 8'h8a; // @[Expression.scala 2342:18]
  assign mel_data_194 = 8'hb2; // @[Expression.scala 2342:18]
  assign mel_data_195 = 8'hd9; // @[Expression.scala 2342:18]
  assign mel_data_196 = 8'hfe; // @[Expression.scala 2342:18]
  assign mel_data_197 = 8'hd8; // @[Expression.scala 2342:18]
  assign mel_data_198 = 8'hb3; // @[Expression.scala 2342:18]
  assign mel_data_199 = 8'h8e; // @[Expression.scala 2342:18]
  assign mel_data_200 = 8'h68; // @[Expression.scala 2342:18]
  assign mel_data_201 = 8'h43; // @[Expression.scala 2342:18]
  assign mel_data_202 = 8'h1e; // @[Expression.scala 2342:18]
  assign mel_filter = tmp_mel_filter; // @[mel_rom.scala 36:17]
  assign mel_index_data_0 = 12'h033; // @[Expression.scala 2342:18]
  assign mel_index_data_1 = 12'h043; // @[Expression.scala 2342:18]
  assign mel_index_data_2 = 12'h063; // @[Expression.scala 2342:18]
  assign mel_index_data_3 = 12'h074; // @[Expression.scala 2342:18]
  assign mel_index_data_4 = 12'h094; // @[Expression.scala 2342:18]
  assign mel_index_data_5 = 12'h0b3; // @[Expression.scala 2342:18]
  assign mel_index_data_6 = 12'h0d3; // @[Expression.scala 2342:18]
  assign mel_index_data_7 = 12'h0e5; // @[Expression.scala 2342:18]
  assign mel_index_data_8 = 12'h105; // @[Expression.scala 2342:18]
  assign mel_index_data_9 = 12'h134; // @[Expression.scala 2342:18]
  assign mel_index_data_10 = 12'h155; // @[Expression.scala 2342:18]
  assign mel_index_data_11 = 12'h175; // @[Expression.scala 2342:18]
  assign mel_index_data_12 = 12'h1a5; // @[Expression.scala 2342:18]
  assign mel_index_data_13 = 12'h1c6; // @[Expression.scala 2342:18]
  assign mel_index_data_14 = 12'h1f6; // @[Expression.scala 2342:18]
  assign mel_index_data_15 = 12'h226; // @[Expression.scala 2342:18]
  assign mel_index_data_16 = 12'h257; // @[Expression.scala 2342:18]
  assign mel_index_data_17 = 12'h287; // @[Expression.scala 2342:18]
  assign mel_index_data_18 = 12'h2c7; // @[Expression.scala 2342:18]
  assign mel_index_data_19 = 12'h2f8; // @[Expression.scala 2342:18]
  assign mel_index_data_20 = 12'h338; // @[Expression.scala 2342:18]
  assign mel_index_data_21 = 12'h379; // @[Expression.scala 2342:18]
  assign mel_index_data_22 = 12'h3b9; // @[Expression.scala 2342:18]
  assign mel_index_data_23 = 12'h409; // @[Expression.scala 2342:18]
  assign mel_index_data_24 = 12'h44a; // @[Expression.scala 2342:18]
  assign mel_index_data_25 = 12'h49b; // @[Expression.scala 2342:18]
  assign mel_index_data_26 = 12'h4fb; // @[Expression.scala 2342:18]
  assign mel_index_data_27 = 12'h54c; // @[Expression.scala 2342:18]
  assign mel_index_data_28 = 12'h5ac; // @[Expression.scala 2342:18]
  assign mel_index_data_29 = 12'h60d; // @[Expression.scala 2342:18]
  assign mel_len = tmp_mel_len[3 : 0]; // @[mel_rom.scala 40:14]
  assign mel_index = tmp_mel_index[11 : 4]; // @[mel_rom.scala 41:16]

endmodule

module RoundandSat_2 (
  input      [32:0]   din,
  output     [19:0]   dout
);

  wire       [33:0]   tmp_tmp_dataOut_5;
  wire       [33:0]   tmp_tmp_dataOut_5_1;
  wire       [9:0]    tmp_when;
  wire       [23:0]   tmp_tmp_dataOut_7;
  wire       [23:0]   tmp_tmp_dataOut_7_1;
  wire       [33:0]   tmp_tmp_dataOut_1;
  wire       [33:0]   tmp_tmp_dataOut_1_1;
  wire       [33:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  wire       [3:0]    tmp_when_3;
  wire       [2:0]    tmp_when_4;
  (* keep *) wire       [19:0]   dataOut;
  wire       [32:0]   tmp_dataOut;
  reg        [23:0]   tmp_dataOut_1;
  wire       [32:0]   tmp_dataOut_2;
  wire       [32:0]   tmp_dataOut_3;
  wire       [32:0]   tmp_dataOut_4;
  wire       [33:0]   tmp_dataOut_5;
  wire       [32:0]   tmp_dataOut_6;
  reg        [23:0]   tmp_dataOut_7;
  reg        [22:0]   tmp_dataOut_8;
  reg        [19:0]   tmp_dataOut_9;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[32],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[32],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[9 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[33 : 10];
  assign tmp_tmp_dataOut_7_1 = 24'h000001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[32],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[32],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[23 : 22];
  assign tmp_when_2 = tmp_dataOut_1[22 : 22];
  assign tmp_when_3 = tmp_dataOut_8[22 : 19];
  assign tmp_when_4 = tmp_dataOut_8[21 : 19];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{23'h0,1'b1},9'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {24'hffffff,9'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[32 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[32 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[33 : 10]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[33]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 10); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_1[23]) begin
      if((! (&tmp_when_1))) begin
        tmp_dataOut_8 = 23'h400000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[22 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_dataOut_8 = 23'h3fffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[22 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    if(tmp_dataOut_8[22]) begin
      if((! (&tmp_when_3))) begin
        tmp_dataOut_9 = 20'h80000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[19 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_dataOut_9 = 20'h7ffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[19 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign dataOut = tmp_dataOut_9; // @[RoundandSat.scala 22:13]
  assign dout = dataOut; // @[RoundandSat.scala 26:11]

endmodule

module wn_rom (
  input      [6:0]    io_wn_addr,
  output     [15:0]   io_wn_real,
  output     [15:0]   io_wn_imag
);

  reg        [15:0]   tmp_io_wn_real;
  reg        [15:0]   tmp_io_wn_imag;
  wire       [15:0]   wnreal_0;
  wire       [15:0]   wnreal_1;
  wire       [15:0]   wnreal_2;
  wire       [15:0]   wnreal_3;
  wire       [15:0]   wnreal_4;
  wire       [15:0]   wnreal_5;
  wire       [15:0]   wnreal_6;
  wire       [15:0]   wnreal_7;
  wire       [15:0]   wnreal_8;
  wire       [15:0]   wnreal_9;
  wire       [15:0]   wnreal_10;
  wire       [15:0]   wnreal_11;
  wire       [15:0]   wnreal_12;
  wire       [15:0]   wnreal_13;
  wire       [15:0]   wnreal_14;
  wire       [15:0]   wnreal_15;
  wire       [15:0]   wnreal_16;
  wire       [15:0]   wnreal_17;
  wire       [15:0]   wnreal_18;
  wire       [15:0]   wnreal_19;
  wire       [15:0]   wnreal_20;
  wire       [15:0]   wnreal_21;
  wire       [15:0]   wnreal_22;
  wire       [15:0]   wnreal_23;
  wire       [15:0]   wnreal_24;
  wire       [15:0]   wnreal_25;
  wire       [15:0]   wnreal_26;
  wire       [15:0]   wnreal_27;
  wire       [15:0]   wnreal_28;
  wire       [15:0]   wnreal_29;
  wire       [15:0]   wnreal_30;
  wire       [15:0]   wnreal_31;
  wire       [15:0]   wnreal_32;
  wire       [15:0]   wnreal_33;
  wire       [15:0]   wnreal_34;
  wire       [15:0]   wnreal_35;
  wire       [15:0]   wnreal_36;
  wire       [15:0]   wnreal_37;
  wire       [15:0]   wnreal_38;
  wire       [15:0]   wnreal_39;
  wire       [15:0]   wnreal_40;
  wire       [15:0]   wnreal_41;
  wire       [15:0]   wnreal_42;
  wire       [15:0]   wnreal_43;
  wire       [15:0]   wnreal_44;
  wire       [15:0]   wnreal_45;
  wire       [15:0]   wnreal_46;
  wire       [15:0]   wnreal_47;
  wire       [15:0]   wnreal_48;
  wire       [15:0]   wnreal_49;
  wire       [15:0]   wnreal_50;
  wire       [15:0]   wnreal_51;
  wire       [15:0]   wnreal_52;
  wire       [15:0]   wnreal_53;
  wire       [15:0]   wnreal_54;
  wire       [15:0]   wnreal_55;
  wire       [15:0]   wnreal_56;
  wire       [15:0]   wnreal_57;
  wire       [15:0]   wnreal_58;
  wire       [15:0]   wnreal_59;
  wire       [15:0]   wnreal_60;
  wire       [15:0]   wnreal_61;
  wire       [15:0]   wnreal_62;
  wire       [15:0]   wnreal_63;
  wire       [15:0]   wnreal_64;
  wire       [15:0]   wnreal_65;
  wire       [15:0]   wnreal_66;
  wire       [15:0]   wnreal_67;
  wire       [15:0]   wnreal_68;
  wire       [15:0]   wnreal_69;
  wire       [15:0]   wnreal_70;
  wire       [15:0]   wnreal_71;
  wire       [15:0]   wnreal_72;
  wire       [15:0]   wnreal_73;
  wire       [15:0]   wnreal_74;
  wire       [15:0]   wnreal_75;
  wire       [15:0]   wnreal_76;
  wire       [15:0]   wnreal_77;
  wire       [15:0]   wnreal_78;
  wire       [15:0]   wnreal_79;
  wire       [15:0]   wnreal_80;
  wire       [15:0]   wnreal_81;
  wire       [15:0]   wnreal_82;
  wire       [15:0]   wnreal_83;
  wire       [15:0]   wnreal_84;
  wire       [15:0]   wnreal_85;
  wire       [15:0]   wnreal_86;
  wire       [15:0]   wnreal_87;
  wire       [15:0]   wnreal_88;
  wire       [15:0]   wnreal_89;
  wire       [15:0]   wnreal_90;
  wire       [15:0]   wnreal_91;
  wire       [15:0]   wnreal_92;
  wire       [15:0]   wnreal_93;
  wire       [15:0]   wnreal_94;
  wire       [15:0]   wnreal_95;
  wire       [15:0]   wnreal_96;
  wire       [15:0]   wnreal_97;
  wire       [15:0]   wnreal_98;
  wire       [15:0]   wnreal_99;
  wire       [15:0]   wnreal_100;
  wire       [15:0]   wnreal_101;
  wire       [15:0]   wnreal_102;
  wire       [15:0]   wnreal_103;
  wire       [15:0]   wnreal_104;
  wire       [15:0]   wnreal_105;
  wire       [15:0]   wnreal_106;
  wire       [15:0]   wnreal_107;
  wire       [15:0]   wnreal_108;
  wire       [15:0]   wnreal_109;
  wire       [15:0]   wnreal_110;
  wire       [15:0]   wnreal_111;
  wire       [15:0]   wnreal_112;
  wire       [15:0]   wnreal_113;
  wire       [15:0]   wnreal_114;
  wire       [15:0]   wnreal_115;
  wire       [15:0]   wnreal_116;
  wire       [15:0]   wnreal_117;
  wire       [15:0]   wnreal_118;
  wire       [15:0]   wnreal_119;
  wire       [15:0]   wnreal_120;
  wire       [15:0]   wnreal_121;
  wire       [15:0]   wnreal_122;
  wire       [15:0]   wnreal_123;
  wire       [15:0]   wnreal_124;
  wire       [15:0]   wnreal_125;
  wire       [15:0]   wnreal_126;
  wire       [15:0]   wnreal_127;
  wire       [15:0]   wnimag_0;
  wire       [15:0]   wnimag_1;
  wire       [15:0]   wnimag_2;
  wire       [15:0]   wnimag_3;
  wire       [15:0]   wnimag_4;
  wire       [15:0]   wnimag_5;
  wire       [15:0]   wnimag_6;
  wire       [15:0]   wnimag_7;
  wire       [15:0]   wnimag_8;
  wire       [15:0]   wnimag_9;
  wire       [15:0]   wnimag_10;
  wire       [15:0]   wnimag_11;
  wire       [15:0]   wnimag_12;
  wire       [15:0]   wnimag_13;
  wire       [15:0]   wnimag_14;
  wire       [15:0]   wnimag_15;
  wire       [15:0]   wnimag_16;
  wire       [15:0]   wnimag_17;
  wire       [15:0]   wnimag_18;
  wire       [15:0]   wnimag_19;
  wire       [15:0]   wnimag_20;
  wire       [15:0]   wnimag_21;
  wire       [15:0]   wnimag_22;
  wire       [15:0]   wnimag_23;
  wire       [15:0]   wnimag_24;
  wire       [15:0]   wnimag_25;
  wire       [15:0]   wnimag_26;
  wire       [15:0]   wnimag_27;
  wire       [15:0]   wnimag_28;
  wire       [15:0]   wnimag_29;
  wire       [15:0]   wnimag_30;
  wire       [15:0]   wnimag_31;
  wire       [15:0]   wnimag_32;
  wire       [15:0]   wnimag_33;
  wire       [15:0]   wnimag_34;
  wire       [15:0]   wnimag_35;
  wire       [15:0]   wnimag_36;
  wire       [15:0]   wnimag_37;
  wire       [15:0]   wnimag_38;
  wire       [15:0]   wnimag_39;
  wire       [15:0]   wnimag_40;
  wire       [15:0]   wnimag_41;
  wire       [15:0]   wnimag_42;
  wire       [15:0]   wnimag_43;
  wire       [15:0]   wnimag_44;
  wire       [15:0]   wnimag_45;
  wire       [15:0]   wnimag_46;
  wire       [15:0]   wnimag_47;
  wire       [15:0]   wnimag_48;
  wire       [15:0]   wnimag_49;
  wire       [15:0]   wnimag_50;
  wire       [15:0]   wnimag_51;
  wire       [15:0]   wnimag_52;
  wire       [15:0]   wnimag_53;
  wire       [15:0]   wnimag_54;
  wire       [15:0]   wnimag_55;
  wire       [15:0]   wnimag_56;
  wire       [15:0]   wnimag_57;
  wire       [15:0]   wnimag_58;
  wire       [15:0]   wnimag_59;
  wire       [15:0]   wnimag_60;
  wire       [15:0]   wnimag_61;
  wire       [15:0]   wnimag_62;
  wire       [15:0]   wnimag_63;
  wire       [15:0]   wnimag_64;
  wire       [15:0]   wnimag_65;
  wire       [15:0]   wnimag_66;
  wire       [15:0]   wnimag_67;
  wire       [15:0]   wnimag_68;
  wire       [15:0]   wnimag_69;
  wire       [15:0]   wnimag_70;
  wire       [15:0]   wnimag_71;
  wire       [15:0]   wnimag_72;
  wire       [15:0]   wnimag_73;
  wire       [15:0]   wnimag_74;
  wire       [15:0]   wnimag_75;
  wire       [15:0]   wnimag_76;
  wire       [15:0]   wnimag_77;
  wire       [15:0]   wnimag_78;
  wire       [15:0]   wnimag_79;
  wire       [15:0]   wnimag_80;
  wire       [15:0]   wnimag_81;
  wire       [15:0]   wnimag_82;
  wire       [15:0]   wnimag_83;
  wire       [15:0]   wnimag_84;
  wire       [15:0]   wnimag_85;
  wire       [15:0]   wnimag_86;
  wire       [15:0]   wnimag_87;
  wire       [15:0]   wnimag_88;
  wire       [15:0]   wnimag_89;
  wire       [15:0]   wnimag_90;
  wire       [15:0]   wnimag_91;
  wire       [15:0]   wnimag_92;
  wire       [15:0]   wnimag_93;
  wire       [15:0]   wnimag_94;
  wire       [15:0]   wnimag_95;
  wire       [15:0]   wnimag_96;
  wire       [15:0]   wnimag_97;
  wire       [15:0]   wnimag_98;
  wire       [15:0]   wnimag_99;
  wire       [15:0]   wnimag_100;
  wire       [15:0]   wnimag_101;
  wire       [15:0]   wnimag_102;
  wire       [15:0]   wnimag_103;
  wire       [15:0]   wnimag_104;
  wire       [15:0]   wnimag_105;
  wire       [15:0]   wnimag_106;
  wire       [15:0]   wnimag_107;
  wire       [15:0]   wnimag_108;
  wire       [15:0]   wnimag_109;
  wire       [15:0]   wnimag_110;
  wire       [15:0]   wnimag_111;
  wire       [15:0]   wnimag_112;
  wire       [15:0]   wnimag_113;
  wire       [15:0]   wnimag_114;
  wire       [15:0]   wnimag_115;
  wire       [15:0]   wnimag_116;
  wire       [15:0]   wnimag_117;
  wire       [15:0]   wnimag_118;
  wire       [15:0]   wnimag_119;
  wire       [15:0]   wnimag_120;
  wire       [15:0]   wnimag_121;
  wire       [15:0]   wnimag_122;
  wire       [15:0]   wnimag_123;
  wire       [15:0]   wnimag_124;
  wire       [15:0]   wnimag_125;
  wire       [15:0]   wnimag_126;
  wire       [15:0]   wnimag_127;

  always @(*) begin
    case(io_wn_addr)
      7'b0000000 : begin
        tmp_io_wn_real = wnreal_0;
        tmp_io_wn_imag = wnimag_0;
      end
      7'b0000001 : begin
        tmp_io_wn_real = wnreal_1;
        tmp_io_wn_imag = wnimag_1;
      end
      7'b0000010 : begin
        tmp_io_wn_real = wnreal_2;
        tmp_io_wn_imag = wnimag_2;
      end
      7'b0000011 : begin
        tmp_io_wn_real = wnreal_3;
        tmp_io_wn_imag = wnimag_3;
      end
      7'b0000100 : begin
        tmp_io_wn_real = wnreal_4;
        tmp_io_wn_imag = wnimag_4;
      end
      7'b0000101 : begin
        tmp_io_wn_real = wnreal_5;
        tmp_io_wn_imag = wnimag_5;
      end
      7'b0000110 : begin
        tmp_io_wn_real = wnreal_6;
        tmp_io_wn_imag = wnimag_6;
      end
      7'b0000111 : begin
        tmp_io_wn_real = wnreal_7;
        tmp_io_wn_imag = wnimag_7;
      end
      7'b0001000 : begin
        tmp_io_wn_real = wnreal_8;
        tmp_io_wn_imag = wnimag_8;
      end
      7'b0001001 : begin
        tmp_io_wn_real = wnreal_9;
        tmp_io_wn_imag = wnimag_9;
      end
      7'b0001010 : begin
        tmp_io_wn_real = wnreal_10;
        tmp_io_wn_imag = wnimag_10;
      end
      7'b0001011 : begin
        tmp_io_wn_real = wnreal_11;
        tmp_io_wn_imag = wnimag_11;
      end
      7'b0001100 : begin
        tmp_io_wn_real = wnreal_12;
        tmp_io_wn_imag = wnimag_12;
      end
      7'b0001101 : begin
        tmp_io_wn_real = wnreal_13;
        tmp_io_wn_imag = wnimag_13;
      end
      7'b0001110 : begin
        tmp_io_wn_real = wnreal_14;
        tmp_io_wn_imag = wnimag_14;
      end
      7'b0001111 : begin
        tmp_io_wn_real = wnreal_15;
        tmp_io_wn_imag = wnimag_15;
      end
      7'b0010000 : begin
        tmp_io_wn_real = wnreal_16;
        tmp_io_wn_imag = wnimag_16;
      end
      7'b0010001 : begin
        tmp_io_wn_real = wnreal_17;
        tmp_io_wn_imag = wnimag_17;
      end
      7'b0010010 : begin
        tmp_io_wn_real = wnreal_18;
        tmp_io_wn_imag = wnimag_18;
      end
      7'b0010011 : begin
        tmp_io_wn_real = wnreal_19;
        tmp_io_wn_imag = wnimag_19;
      end
      7'b0010100 : begin
        tmp_io_wn_real = wnreal_20;
        tmp_io_wn_imag = wnimag_20;
      end
      7'b0010101 : begin
        tmp_io_wn_real = wnreal_21;
        tmp_io_wn_imag = wnimag_21;
      end
      7'b0010110 : begin
        tmp_io_wn_real = wnreal_22;
        tmp_io_wn_imag = wnimag_22;
      end
      7'b0010111 : begin
        tmp_io_wn_real = wnreal_23;
        tmp_io_wn_imag = wnimag_23;
      end
      7'b0011000 : begin
        tmp_io_wn_real = wnreal_24;
        tmp_io_wn_imag = wnimag_24;
      end
      7'b0011001 : begin
        tmp_io_wn_real = wnreal_25;
        tmp_io_wn_imag = wnimag_25;
      end
      7'b0011010 : begin
        tmp_io_wn_real = wnreal_26;
        tmp_io_wn_imag = wnimag_26;
      end
      7'b0011011 : begin
        tmp_io_wn_real = wnreal_27;
        tmp_io_wn_imag = wnimag_27;
      end
      7'b0011100 : begin
        tmp_io_wn_real = wnreal_28;
        tmp_io_wn_imag = wnimag_28;
      end
      7'b0011101 : begin
        tmp_io_wn_real = wnreal_29;
        tmp_io_wn_imag = wnimag_29;
      end
      7'b0011110 : begin
        tmp_io_wn_real = wnreal_30;
        tmp_io_wn_imag = wnimag_30;
      end
      7'b0011111 : begin
        tmp_io_wn_real = wnreal_31;
        tmp_io_wn_imag = wnimag_31;
      end
      7'b0100000 : begin
        tmp_io_wn_real = wnreal_32;
        tmp_io_wn_imag = wnimag_32;
      end
      7'b0100001 : begin
        tmp_io_wn_real = wnreal_33;
        tmp_io_wn_imag = wnimag_33;
      end
      7'b0100010 : begin
        tmp_io_wn_real = wnreal_34;
        tmp_io_wn_imag = wnimag_34;
      end
      7'b0100011 : begin
        tmp_io_wn_real = wnreal_35;
        tmp_io_wn_imag = wnimag_35;
      end
      7'b0100100 : begin
        tmp_io_wn_real = wnreal_36;
        tmp_io_wn_imag = wnimag_36;
      end
      7'b0100101 : begin
        tmp_io_wn_real = wnreal_37;
        tmp_io_wn_imag = wnimag_37;
      end
      7'b0100110 : begin
        tmp_io_wn_real = wnreal_38;
        tmp_io_wn_imag = wnimag_38;
      end
      7'b0100111 : begin
        tmp_io_wn_real = wnreal_39;
        tmp_io_wn_imag = wnimag_39;
      end
      7'b0101000 : begin
        tmp_io_wn_real = wnreal_40;
        tmp_io_wn_imag = wnimag_40;
      end
      7'b0101001 : begin
        tmp_io_wn_real = wnreal_41;
        tmp_io_wn_imag = wnimag_41;
      end
      7'b0101010 : begin
        tmp_io_wn_real = wnreal_42;
        tmp_io_wn_imag = wnimag_42;
      end
      7'b0101011 : begin
        tmp_io_wn_real = wnreal_43;
        tmp_io_wn_imag = wnimag_43;
      end
      7'b0101100 : begin
        tmp_io_wn_real = wnreal_44;
        tmp_io_wn_imag = wnimag_44;
      end
      7'b0101101 : begin
        tmp_io_wn_real = wnreal_45;
        tmp_io_wn_imag = wnimag_45;
      end
      7'b0101110 : begin
        tmp_io_wn_real = wnreal_46;
        tmp_io_wn_imag = wnimag_46;
      end
      7'b0101111 : begin
        tmp_io_wn_real = wnreal_47;
        tmp_io_wn_imag = wnimag_47;
      end
      7'b0110000 : begin
        tmp_io_wn_real = wnreal_48;
        tmp_io_wn_imag = wnimag_48;
      end
      7'b0110001 : begin
        tmp_io_wn_real = wnreal_49;
        tmp_io_wn_imag = wnimag_49;
      end
      7'b0110010 : begin
        tmp_io_wn_real = wnreal_50;
        tmp_io_wn_imag = wnimag_50;
      end
      7'b0110011 : begin
        tmp_io_wn_real = wnreal_51;
        tmp_io_wn_imag = wnimag_51;
      end
      7'b0110100 : begin
        tmp_io_wn_real = wnreal_52;
        tmp_io_wn_imag = wnimag_52;
      end
      7'b0110101 : begin
        tmp_io_wn_real = wnreal_53;
        tmp_io_wn_imag = wnimag_53;
      end
      7'b0110110 : begin
        tmp_io_wn_real = wnreal_54;
        tmp_io_wn_imag = wnimag_54;
      end
      7'b0110111 : begin
        tmp_io_wn_real = wnreal_55;
        tmp_io_wn_imag = wnimag_55;
      end
      7'b0111000 : begin
        tmp_io_wn_real = wnreal_56;
        tmp_io_wn_imag = wnimag_56;
      end
      7'b0111001 : begin
        tmp_io_wn_real = wnreal_57;
        tmp_io_wn_imag = wnimag_57;
      end
      7'b0111010 : begin
        tmp_io_wn_real = wnreal_58;
        tmp_io_wn_imag = wnimag_58;
      end
      7'b0111011 : begin
        tmp_io_wn_real = wnreal_59;
        tmp_io_wn_imag = wnimag_59;
      end
      7'b0111100 : begin
        tmp_io_wn_real = wnreal_60;
        tmp_io_wn_imag = wnimag_60;
      end
      7'b0111101 : begin
        tmp_io_wn_real = wnreal_61;
        tmp_io_wn_imag = wnimag_61;
      end
      7'b0111110 : begin
        tmp_io_wn_real = wnreal_62;
        tmp_io_wn_imag = wnimag_62;
      end
      7'b0111111 : begin
        tmp_io_wn_real = wnreal_63;
        tmp_io_wn_imag = wnimag_63;
      end
      7'b1000000 : begin
        tmp_io_wn_real = wnreal_64;
        tmp_io_wn_imag = wnimag_64;
      end
      7'b1000001 : begin
        tmp_io_wn_real = wnreal_65;
        tmp_io_wn_imag = wnimag_65;
      end
      7'b1000010 : begin
        tmp_io_wn_real = wnreal_66;
        tmp_io_wn_imag = wnimag_66;
      end
      7'b1000011 : begin
        tmp_io_wn_real = wnreal_67;
        tmp_io_wn_imag = wnimag_67;
      end
      7'b1000100 : begin
        tmp_io_wn_real = wnreal_68;
        tmp_io_wn_imag = wnimag_68;
      end
      7'b1000101 : begin
        tmp_io_wn_real = wnreal_69;
        tmp_io_wn_imag = wnimag_69;
      end
      7'b1000110 : begin
        tmp_io_wn_real = wnreal_70;
        tmp_io_wn_imag = wnimag_70;
      end
      7'b1000111 : begin
        tmp_io_wn_real = wnreal_71;
        tmp_io_wn_imag = wnimag_71;
      end
      7'b1001000 : begin
        tmp_io_wn_real = wnreal_72;
        tmp_io_wn_imag = wnimag_72;
      end
      7'b1001001 : begin
        tmp_io_wn_real = wnreal_73;
        tmp_io_wn_imag = wnimag_73;
      end
      7'b1001010 : begin
        tmp_io_wn_real = wnreal_74;
        tmp_io_wn_imag = wnimag_74;
      end
      7'b1001011 : begin
        tmp_io_wn_real = wnreal_75;
        tmp_io_wn_imag = wnimag_75;
      end
      7'b1001100 : begin
        tmp_io_wn_real = wnreal_76;
        tmp_io_wn_imag = wnimag_76;
      end
      7'b1001101 : begin
        tmp_io_wn_real = wnreal_77;
        tmp_io_wn_imag = wnimag_77;
      end
      7'b1001110 : begin
        tmp_io_wn_real = wnreal_78;
        tmp_io_wn_imag = wnimag_78;
      end
      7'b1001111 : begin
        tmp_io_wn_real = wnreal_79;
        tmp_io_wn_imag = wnimag_79;
      end
      7'b1010000 : begin
        tmp_io_wn_real = wnreal_80;
        tmp_io_wn_imag = wnimag_80;
      end
      7'b1010001 : begin
        tmp_io_wn_real = wnreal_81;
        tmp_io_wn_imag = wnimag_81;
      end
      7'b1010010 : begin
        tmp_io_wn_real = wnreal_82;
        tmp_io_wn_imag = wnimag_82;
      end
      7'b1010011 : begin
        tmp_io_wn_real = wnreal_83;
        tmp_io_wn_imag = wnimag_83;
      end
      7'b1010100 : begin
        tmp_io_wn_real = wnreal_84;
        tmp_io_wn_imag = wnimag_84;
      end
      7'b1010101 : begin
        tmp_io_wn_real = wnreal_85;
        tmp_io_wn_imag = wnimag_85;
      end
      7'b1010110 : begin
        tmp_io_wn_real = wnreal_86;
        tmp_io_wn_imag = wnimag_86;
      end
      7'b1010111 : begin
        tmp_io_wn_real = wnreal_87;
        tmp_io_wn_imag = wnimag_87;
      end
      7'b1011000 : begin
        tmp_io_wn_real = wnreal_88;
        tmp_io_wn_imag = wnimag_88;
      end
      7'b1011001 : begin
        tmp_io_wn_real = wnreal_89;
        tmp_io_wn_imag = wnimag_89;
      end
      7'b1011010 : begin
        tmp_io_wn_real = wnreal_90;
        tmp_io_wn_imag = wnimag_90;
      end
      7'b1011011 : begin
        tmp_io_wn_real = wnreal_91;
        tmp_io_wn_imag = wnimag_91;
      end
      7'b1011100 : begin
        tmp_io_wn_real = wnreal_92;
        tmp_io_wn_imag = wnimag_92;
      end
      7'b1011101 : begin
        tmp_io_wn_real = wnreal_93;
        tmp_io_wn_imag = wnimag_93;
      end
      7'b1011110 : begin
        tmp_io_wn_real = wnreal_94;
        tmp_io_wn_imag = wnimag_94;
      end
      7'b1011111 : begin
        tmp_io_wn_real = wnreal_95;
        tmp_io_wn_imag = wnimag_95;
      end
      7'b1100000 : begin
        tmp_io_wn_real = wnreal_96;
        tmp_io_wn_imag = wnimag_96;
      end
      7'b1100001 : begin
        tmp_io_wn_real = wnreal_97;
        tmp_io_wn_imag = wnimag_97;
      end
      7'b1100010 : begin
        tmp_io_wn_real = wnreal_98;
        tmp_io_wn_imag = wnimag_98;
      end
      7'b1100011 : begin
        tmp_io_wn_real = wnreal_99;
        tmp_io_wn_imag = wnimag_99;
      end
      7'b1100100 : begin
        tmp_io_wn_real = wnreal_100;
        tmp_io_wn_imag = wnimag_100;
      end
      7'b1100101 : begin
        tmp_io_wn_real = wnreal_101;
        tmp_io_wn_imag = wnimag_101;
      end
      7'b1100110 : begin
        tmp_io_wn_real = wnreal_102;
        tmp_io_wn_imag = wnimag_102;
      end
      7'b1100111 : begin
        tmp_io_wn_real = wnreal_103;
        tmp_io_wn_imag = wnimag_103;
      end
      7'b1101000 : begin
        tmp_io_wn_real = wnreal_104;
        tmp_io_wn_imag = wnimag_104;
      end
      7'b1101001 : begin
        tmp_io_wn_real = wnreal_105;
        tmp_io_wn_imag = wnimag_105;
      end
      7'b1101010 : begin
        tmp_io_wn_real = wnreal_106;
        tmp_io_wn_imag = wnimag_106;
      end
      7'b1101011 : begin
        tmp_io_wn_real = wnreal_107;
        tmp_io_wn_imag = wnimag_107;
      end
      7'b1101100 : begin
        tmp_io_wn_real = wnreal_108;
        tmp_io_wn_imag = wnimag_108;
      end
      7'b1101101 : begin
        tmp_io_wn_real = wnreal_109;
        tmp_io_wn_imag = wnimag_109;
      end
      7'b1101110 : begin
        tmp_io_wn_real = wnreal_110;
        tmp_io_wn_imag = wnimag_110;
      end
      7'b1101111 : begin
        tmp_io_wn_real = wnreal_111;
        tmp_io_wn_imag = wnimag_111;
      end
      7'b1110000 : begin
        tmp_io_wn_real = wnreal_112;
        tmp_io_wn_imag = wnimag_112;
      end
      7'b1110001 : begin
        tmp_io_wn_real = wnreal_113;
        tmp_io_wn_imag = wnimag_113;
      end
      7'b1110010 : begin
        tmp_io_wn_real = wnreal_114;
        tmp_io_wn_imag = wnimag_114;
      end
      7'b1110011 : begin
        tmp_io_wn_real = wnreal_115;
        tmp_io_wn_imag = wnimag_115;
      end
      7'b1110100 : begin
        tmp_io_wn_real = wnreal_116;
        tmp_io_wn_imag = wnimag_116;
      end
      7'b1110101 : begin
        tmp_io_wn_real = wnreal_117;
        tmp_io_wn_imag = wnimag_117;
      end
      7'b1110110 : begin
        tmp_io_wn_real = wnreal_118;
        tmp_io_wn_imag = wnimag_118;
      end
      7'b1110111 : begin
        tmp_io_wn_real = wnreal_119;
        tmp_io_wn_imag = wnimag_119;
      end
      7'b1111000 : begin
        tmp_io_wn_real = wnreal_120;
        tmp_io_wn_imag = wnimag_120;
      end
      7'b1111001 : begin
        tmp_io_wn_real = wnreal_121;
        tmp_io_wn_imag = wnimag_121;
      end
      7'b1111010 : begin
        tmp_io_wn_real = wnreal_122;
        tmp_io_wn_imag = wnimag_122;
      end
      7'b1111011 : begin
        tmp_io_wn_real = wnreal_123;
        tmp_io_wn_imag = wnimag_123;
      end
      7'b1111100 : begin
        tmp_io_wn_real = wnreal_124;
        tmp_io_wn_imag = wnimag_124;
      end
      7'b1111101 : begin
        tmp_io_wn_real = wnreal_125;
        tmp_io_wn_imag = wnimag_125;
      end
      7'b1111110 : begin
        tmp_io_wn_real = wnreal_126;
        tmp_io_wn_imag = wnimag_126;
      end
      default : begin
        tmp_io_wn_real = wnreal_127;
        tmp_io_wn_imag = wnimag_127;
      end
    endcase
  end

  assign wnreal_0 = 16'h7fff; // @[Expression.scala 2380:18]
  assign wnreal_1 = 16'h7ff6; // @[Expression.scala 2380:18]
  assign wnreal_2 = 16'h7fd9; // @[Expression.scala 2380:18]
  assign wnreal_3 = 16'h7fa7; // @[Expression.scala 2380:18]
  assign wnreal_4 = 16'h7f62; // @[Expression.scala 2380:18]
  assign wnreal_5 = 16'h7f0a; // @[Expression.scala 2380:18]
  assign wnreal_6 = 16'h7e9d; // @[Expression.scala 2380:18]
  assign wnreal_7 = 16'h7e1e; // @[Expression.scala 2380:18]
  assign wnreal_8 = 16'h7d8a; // @[Expression.scala 2380:18]
  assign wnreal_9 = 16'h7ce4; // @[Expression.scala 2380:18]
  assign wnreal_10 = 16'h7c2a; // @[Expression.scala 2380:18]
  assign wnreal_11 = 16'h7b5d; // @[Expression.scala 2380:18]
  assign wnreal_12 = 16'h7a7d; // @[Expression.scala 2380:18]
  assign wnreal_13 = 16'h798a; // @[Expression.scala 2380:18]
  assign wnreal_14 = 16'h7885; // @[Expression.scala 2380:18]
  assign wnreal_15 = 16'h776c; // @[Expression.scala 2380:18]
  assign wnreal_16 = 16'h7642; // @[Expression.scala 2380:18]
  assign wnreal_17 = 16'h7505; // @[Expression.scala 2380:18]
  assign wnreal_18 = 16'h73b6; // @[Expression.scala 2380:18]
  assign wnreal_19 = 16'h7255; // @[Expression.scala 2380:18]
  assign wnreal_20 = 16'h70e3; // @[Expression.scala 2380:18]
  assign wnreal_21 = 16'h6f5f; // @[Expression.scala 2380:18]
  assign wnreal_22 = 16'h6dca; // @[Expression.scala 2380:18]
  assign wnreal_23 = 16'h6c24; // @[Expression.scala 2380:18]
  assign wnreal_24 = 16'h6a6e; // @[Expression.scala 2380:18]
  assign wnreal_25 = 16'h68a7; // @[Expression.scala 2380:18]
  assign wnreal_26 = 16'h66d0; // @[Expression.scala 2380:18]
  assign wnreal_27 = 16'h64e9; // @[Expression.scala 2380:18]
  assign wnreal_28 = 16'h62f2; // @[Expression.scala 2380:18]
  assign wnreal_29 = 16'h60ec; // @[Expression.scala 2380:18]
  assign wnreal_30 = 16'h5ed7; // @[Expression.scala 2380:18]
  assign wnreal_31 = 16'h5cb4; // @[Expression.scala 2380:18]
  assign wnreal_32 = 16'h5a82; // @[Expression.scala 2380:18]
  assign wnreal_33 = 16'h5843; // @[Expression.scala 2380:18]
  assign wnreal_34 = 16'h55f6; // @[Expression.scala 2380:18]
  assign wnreal_35 = 16'h539b; // @[Expression.scala 2380:18]
  assign wnreal_36 = 16'h5134; // @[Expression.scala 2380:18]
  assign wnreal_37 = 16'h4ec0; // @[Expression.scala 2380:18]
  assign wnreal_38 = 16'h4c40; // @[Expression.scala 2380:18]
  assign wnreal_39 = 16'h49b4; // @[Expression.scala 2380:18]
  assign wnreal_40 = 16'h471d; // @[Expression.scala 2380:18]
  assign wnreal_41 = 16'h447b; // @[Expression.scala 2380:18]
  assign wnreal_42 = 16'h41ce; // @[Expression.scala 2380:18]
  assign wnreal_43 = 16'h3f17; // @[Expression.scala 2380:18]
  assign wnreal_44 = 16'h3c57; // @[Expression.scala 2380:18]
  assign wnreal_45 = 16'h398d; // @[Expression.scala 2380:18]
  assign wnreal_46 = 16'h36ba; // @[Expression.scala 2380:18]
  assign wnreal_47 = 16'h33df; // @[Expression.scala 2380:18]
  assign wnreal_48 = 16'h30fc; // @[Expression.scala 2380:18]
  assign wnreal_49 = 16'h2e11; // @[Expression.scala 2380:18]
  assign wnreal_50 = 16'h2b1f; // @[Expression.scala 2380:18]
  assign wnreal_51 = 16'h2827; // @[Expression.scala 2380:18]
  assign wnreal_52 = 16'h2528; // @[Expression.scala 2380:18]
  assign wnreal_53 = 16'h2224; // @[Expression.scala 2380:18]
  assign wnreal_54 = 16'h1f1a; // @[Expression.scala 2380:18]
  assign wnreal_55 = 16'h1c0c; // @[Expression.scala 2380:18]
  assign wnreal_56 = 16'h18f9; // @[Expression.scala 2380:18]
  assign wnreal_57 = 16'h15e2; // @[Expression.scala 2380:18]
  assign wnreal_58 = 16'h12c8; // @[Expression.scala 2380:18]
  assign wnreal_59 = 16'h0fab; // @[Expression.scala 2380:18]
  assign wnreal_60 = 16'h0c8c; // @[Expression.scala 2380:18]
  assign wnreal_61 = 16'h096b; // @[Expression.scala 2380:18]
  assign wnreal_62 = 16'h0648; // @[Expression.scala 2380:18]
  assign wnreal_63 = 16'h0324; // @[Expression.scala 2380:18]
  assign wnreal_64 = 16'h0; // @[Expression.scala 2380:18]
  assign wnreal_65 = 16'hfcdc; // @[Expression.scala 2380:18]
  assign wnreal_66 = 16'hf9b8; // @[Expression.scala 2380:18]
  assign wnreal_67 = 16'hf695; // @[Expression.scala 2380:18]
  assign wnreal_68 = 16'hf374; // @[Expression.scala 2380:18]
  assign wnreal_69 = 16'hf055; // @[Expression.scala 2380:18]
  assign wnreal_70 = 16'hed38; // @[Expression.scala 2380:18]
  assign wnreal_71 = 16'hea1e; // @[Expression.scala 2380:18]
  assign wnreal_72 = 16'he707; // @[Expression.scala 2380:18]
  assign wnreal_73 = 16'he3f4; // @[Expression.scala 2380:18]
  assign wnreal_74 = 16'he0e6; // @[Expression.scala 2380:18]
  assign wnreal_75 = 16'hdddc; // @[Expression.scala 2380:18]
  assign wnreal_76 = 16'hdad8; // @[Expression.scala 2380:18]
  assign wnreal_77 = 16'hd7d9; // @[Expression.scala 2380:18]
  assign wnreal_78 = 16'hd4e1; // @[Expression.scala 2380:18]
  assign wnreal_79 = 16'hd1ef; // @[Expression.scala 2380:18]
  assign wnreal_80 = 16'hcf04; // @[Expression.scala 2380:18]
  assign wnreal_81 = 16'hcc21; // @[Expression.scala 2380:18]
  assign wnreal_82 = 16'hc946; // @[Expression.scala 2380:18]
  assign wnreal_83 = 16'hc673; // @[Expression.scala 2380:18]
  assign wnreal_84 = 16'hc3a9; // @[Expression.scala 2380:18]
  assign wnreal_85 = 16'hc0e9; // @[Expression.scala 2380:18]
  assign wnreal_86 = 16'hbe32; // @[Expression.scala 2380:18]
  assign wnreal_87 = 16'hbb85; // @[Expression.scala 2380:18]
  assign wnreal_88 = 16'hb8e3; // @[Expression.scala 2380:18]
  assign wnreal_89 = 16'hb64c; // @[Expression.scala 2380:18]
  assign wnreal_90 = 16'hb3c0; // @[Expression.scala 2380:18]
  assign wnreal_91 = 16'hb140; // @[Expression.scala 2380:18]
  assign wnreal_92 = 16'haecc; // @[Expression.scala 2380:18]
  assign wnreal_93 = 16'hac65; // @[Expression.scala 2380:18]
  assign wnreal_94 = 16'haa0a; // @[Expression.scala 2380:18]
  assign wnreal_95 = 16'ha7bd; // @[Expression.scala 2380:18]
  assign wnreal_96 = 16'ha57e; // @[Expression.scala 2380:18]
  assign wnreal_97 = 16'ha34c; // @[Expression.scala 2380:18]
  assign wnreal_98 = 16'ha129; // @[Expression.scala 2380:18]
  assign wnreal_99 = 16'h9f14; // @[Expression.scala 2380:18]
  assign wnreal_100 = 16'h9d0e; // @[Expression.scala 2380:18]
  assign wnreal_101 = 16'h9b17; // @[Expression.scala 2380:18]
  assign wnreal_102 = 16'h9930; // @[Expression.scala 2380:18]
  assign wnreal_103 = 16'h9759; // @[Expression.scala 2380:18]
  assign wnreal_104 = 16'h9592; // @[Expression.scala 2380:18]
  assign wnreal_105 = 16'h93dc; // @[Expression.scala 2380:18]
  assign wnreal_106 = 16'h9236; // @[Expression.scala 2380:18]
  assign wnreal_107 = 16'h90a1; // @[Expression.scala 2380:18]
  assign wnreal_108 = 16'h8f1d; // @[Expression.scala 2380:18]
  assign wnreal_109 = 16'h8dab; // @[Expression.scala 2380:18]
  assign wnreal_110 = 16'h8c4a; // @[Expression.scala 2380:18]
  assign wnreal_111 = 16'h8afb; // @[Expression.scala 2380:18]
  assign wnreal_112 = 16'h89be; // @[Expression.scala 2380:18]
  assign wnreal_113 = 16'h8894; // @[Expression.scala 2380:18]
  assign wnreal_114 = 16'h877b; // @[Expression.scala 2380:18]
  assign wnreal_115 = 16'h8676; // @[Expression.scala 2380:18]
  assign wnreal_116 = 16'h8583; // @[Expression.scala 2380:18]
  assign wnreal_117 = 16'h84a3; // @[Expression.scala 2380:18]
  assign wnreal_118 = 16'h83d6; // @[Expression.scala 2380:18]
  assign wnreal_119 = 16'h831c; // @[Expression.scala 2380:18]
  assign wnreal_120 = 16'h8276; // @[Expression.scala 2380:18]
  assign wnreal_121 = 16'h81e2; // @[Expression.scala 2380:18]
  assign wnreal_122 = 16'h8163; // @[Expression.scala 2380:18]
  assign wnreal_123 = 16'h80f6; // @[Expression.scala 2380:18]
  assign wnreal_124 = 16'h809e; // @[Expression.scala 2380:18]
  assign wnreal_125 = 16'h8059; // @[Expression.scala 2380:18]
  assign wnreal_126 = 16'h8027; // @[Expression.scala 2380:18]
  assign wnreal_127 = 16'h800a; // @[Expression.scala 2380:18]
  assign wnimag_0 = 16'h0; // @[Expression.scala 2380:18]
  assign wnimag_1 = 16'hfcdc; // @[Expression.scala 2380:18]
  assign wnimag_2 = 16'hf9b8; // @[Expression.scala 2380:18]
  assign wnimag_3 = 16'hf695; // @[Expression.scala 2380:18]
  assign wnimag_4 = 16'hf374; // @[Expression.scala 2380:18]
  assign wnimag_5 = 16'hf055; // @[Expression.scala 2380:18]
  assign wnimag_6 = 16'hed38; // @[Expression.scala 2380:18]
  assign wnimag_7 = 16'hea1e; // @[Expression.scala 2380:18]
  assign wnimag_8 = 16'he707; // @[Expression.scala 2380:18]
  assign wnimag_9 = 16'he3f4; // @[Expression.scala 2380:18]
  assign wnimag_10 = 16'he0e6; // @[Expression.scala 2380:18]
  assign wnimag_11 = 16'hdddc; // @[Expression.scala 2380:18]
  assign wnimag_12 = 16'hdad8; // @[Expression.scala 2380:18]
  assign wnimag_13 = 16'hd7d9; // @[Expression.scala 2380:18]
  assign wnimag_14 = 16'hd4e1; // @[Expression.scala 2380:18]
  assign wnimag_15 = 16'hd1ef; // @[Expression.scala 2380:18]
  assign wnimag_16 = 16'hcf04; // @[Expression.scala 2380:18]
  assign wnimag_17 = 16'hcc21; // @[Expression.scala 2380:18]
  assign wnimag_18 = 16'hc946; // @[Expression.scala 2380:18]
  assign wnimag_19 = 16'hc673; // @[Expression.scala 2380:18]
  assign wnimag_20 = 16'hc3a9; // @[Expression.scala 2380:18]
  assign wnimag_21 = 16'hc0e9; // @[Expression.scala 2380:18]
  assign wnimag_22 = 16'hbe32; // @[Expression.scala 2380:18]
  assign wnimag_23 = 16'hbb85; // @[Expression.scala 2380:18]
  assign wnimag_24 = 16'hb8e3; // @[Expression.scala 2380:18]
  assign wnimag_25 = 16'hb64c; // @[Expression.scala 2380:18]
  assign wnimag_26 = 16'hb3c0; // @[Expression.scala 2380:18]
  assign wnimag_27 = 16'hb140; // @[Expression.scala 2380:18]
  assign wnimag_28 = 16'haecc; // @[Expression.scala 2380:18]
  assign wnimag_29 = 16'hac65; // @[Expression.scala 2380:18]
  assign wnimag_30 = 16'haa0a; // @[Expression.scala 2380:18]
  assign wnimag_31 = 16'ha7bd; // @[Expression.scala 2380:18]
  assign wnimag_32 = 16'ha57e; // @[Expression.scala 2380:18]
  assign wnimag_33 = 16'ha34c; // @[Expression.scala 2380:18]
  assign wnimag_34 = 16'ha129; // @[Expression.scala 2380:18]
  assign wnimag_35 = 16'h9f14; // @[Expression.scala 2380:18]
  assign wnimag_36 = 16'h9d0e; // @[Expression.scala 2380:18]
  assign wnimag_37 = 16'h9b17; // @[Expression.scala 2380:18]
  assign wnimag_38 = 16'h9930; // @[Expression.scala 2380:18]
  assign wnimag_39 = 16'h9759; // @[Expression.scala 2380:18]
  assign wnimag_40 = 16'h9592; // @[Expression.scala 2380:18]
  assign wnimag_41 = 16'h93dc; // @[Expression.scala 2380:18]
  assign wnimag_42 = 16'h9236; // @[Expression.scala 2380:18]
  assign wnimag_43 = 16'h90a1; // @[Expression.scala 2380:18]
  assign wnimag_44 = 16'h8f1d; // @[Expression.scala 2380:18]
  assign wnimag_45 = 16'h8dab; // @[Expression.scala 2380:18]
  assign wnimag_46 = 16'h8c4a; // @[Expression.scala 2380:18]
  assign wnimag_47 = 16'h8afb; // @[Expression.scala 2380:18]
  assign wnimag_48 = 16'h89be; // @[Expression.scala 2380:18]
  assign wnimag_49 = 16'h8894; // @[Expression.scala 2380:18]
  assign wnimag_50 = 16'h877b; // @[Expression.scala 2380:18]
  assign wnimag_51 = 16'h8676; // @[Expression.scala 2380:18]
  assign wnimag_52 = 16'h8583; // @[Expression.scala 2380:18]
  assign wnimag_53 = 16'h84a3; // @[Expression.scala 2380:18]
  assign wnimag_54 = 16'h83d6; // @[Expression.scala 2380:18]
  assign wnimag_55 = 16'h831c; // @[Expression.scala 2380:18]
  assign wnimag_56 = 16'h8276; // @[Expression.scala 2380:18]
  assign wnimag_57 = 16'h81e2; // @[Expression.scala 2380:18]
  assign wnimag_58 = 16'h8163; // @[Expression.scala 2380:18]
  assign wnimag_59 = 16'h80f6; // @[Expression.scala 2380:18]
  assign wnimag_60 = 16'h809e; // @[Expression.scala 2380:18]
  assign wnimag_61 = 16'h8059; // @[Expression.scala 2380:18]
  assign wnimag_62 = 16'h8027; // @[Expression.scala 2380:18]
  assign wnimag_63 = 16'h800a; // @[Expression.scala 2380:18]
  assign wnimag_64 = 16'h8000; // @[Expression.scala 2380:18]
  assign wnimag_65 = 16'h800a; // @[Expression.scala 2380:18]
  assign wnimag_66 = 16'h8027; // @[Expression.scala 2380:18]
  assign wnimag_67 = 16'h8059; // @[Expression.scala 2380:18]
  assign wnimag_68 = 16'h809e; // @[Expression.scala 2380:18]
  assign wnimag_69 = 16'h80f6; // @[Expression.scala 2380:18]
  assign wnimag_70 = 16'h8163; // @[Expression.scala 2380:18]
  assign wnimag_71 = 16'h81e2; // @[Expression.scala 2380:18]
  assign wnimag_72 = 16'h8276; // @[Expression.scala 2380:18]
  assign wnimag_73 = 16'h831c; // @[Expression.scala 2380:18]
  assign wnimag_74 = 16'h83d6; // @[Expression.scala 2380:18]
  assign wnimag_75 = 16'h84a3; // @[Expression.scala 2380:18]
  assign wnimag_76 = 16'h8583; // @[Expression.scala 2380:18]
  assign wnimag_77 = 16'h8676; // @[Expression.scala 2380:18]
  assign wnimag_78 = 16'h877b; // @[Expression.scala 2380:18]
  assign wnimag_79 = 16'h8894; // @[Expression.scala 2380:18]
  assign wnimag_80 = 16'h89be; // @[Expression.scala 2380:18]
  assign wnimag_81 = 16'h8afb; // @[Expression.scala 2380:18]
  assign wnimag_82 = 16'h8c4a; // @[Expression.scala 2380:18]
  assign wnimag_83 = 16'h8dab; // @[Expression.scala 2380:18]
  assign wnimag_84 = 16'h8f1d; // @[Expression.scala 2380:18]
  assign wnimag_85 = 16'h90a1; // @[Expression.scala 2380:18]
  assign wnimag_86 = 16'h9236; // @[Expression.scala 2380:18]
  assign wnimag_87 = 16'h93dc; // @[Expression.scala 2380:18]
  assign wnimag_88 = 16'h9592; // @[Expression.scala 2380:18]
  assign wnimag_89 = 16'h9759; // @[Expression.scala 2380:18]
  assign wnimag_90 = 16'h9930; // @[Expression.scala 2380:18]
  assign wnimag_91 = 16'h9b17; // @[Expression.scala 2380:18]
  assign wnimag_92 = 16'h9d0e; // @[Expression.scala 2380:18]
  assign wnimag_93 = 16'h9f14; // @[Expression.scala 2380:18]
  assign wnimag_94 = 16'ha129; // @[Expression.scala 2380:18]
  assign wnimag_95 = 16'ha34c; // @[Expression.scala 2380:18]
  assign wnimag_96 = 16'ha57e; // @[Expression.scala 2380:18]
  assign wnimag_97 = 16'ha7bd; // @[Expression.scala 2380:18]
  assign wnimag_98 = 16'haa0a; // @[Expression.scala 2380:18]
  assign wnimag_99 = 16'hac65; // @[Expression.scala 2380:18]
  assign wnimag_100 = 16'haecc; // @[Expression.scala 2380:18]
  assign wnimag_101 = 16'hb140; // @[Expression.scala 2380:18]
  assign wnimag_102 = 16'hb3c0; // @[Expression.scala 2380:18]
  assign wnimag_103 = 16'hb64c; // @[Expression.scala 2380:18]
  assign wnimag_104 = 16'hb8e3; // @[Expression.scala 2380:18]
  assign wnimag_105 = 16'hbb85; // @[Expression.scala 2380:18]
  assign wnimag_106 = 16'hbe32; // @[Expression.scala 2380:18]
  assign wnimag_107 = 16'hc0e9; // @[Expression.scala 2380:18]
  assign wnimag_108 = 16'hc3a9; // @[Expression.scala 2380:18]
  assign wnimag_109 = 16'hc673; // @[Expression.scala 2380:18]
  assign wnimag_110 = 16'hc946; // @[Expression.scala 2380:18]
  assign wnimag_111 = 16'hcc21; // @[Expression.scala 2380:18]
  assign wnimag_112 = 16'hcf04; // @[Expression.scala 2380:18]
  assign wnimag_113 = 16'hd1ef; // @[Expression.scala 2380:18]
  assign wnimag_114 = 16'hd4e1; // @[Expression.scala 2380:18]
  assign wnimag_115 = 16'hd7d9; // @[Expression.scala 2380:18]
  assign wnimag_116 = 16'hdad8; // @[Expression.scala 2380:18]
  assign wnimag_117 = 16'hdddc; // @[Expression.scala 2380:18]
  assign wnimag_118 = 16'he0e6; // @[Expression.scala 2380:18]
  assign wnimag_119 = 16'he3f4; // @[Expression.scala 2380:18]
  assign wnimag_120 = 16'he707; // @[Expression.scala 2380:18]
  assign wnimag_121 = 16'hea1e; // @[Expression.scala 2380:18]
  assign wnimag_122 = 16'hed38; // @[Expression.scala 2380:18]
  assign wnimag_123 = 16'hf055; // @[Expression.scala 2380:18]
  assign wnimag_124 = 16'hf374; // @[Expression.scala 2380:18]
  assign wnimag_125 = 16'hf695; // @[Expression.scala 2380:18]
  assign wnimag_126 = 16'hf9b8; // @[Expression.scala 2380:18]
  assign wnimag_127 = 16'hfcdc; // @[Expression.scala 2380:18]
  assign io_wn_real = tmp_io_wn_real; // @[wn_rom.scala 39:14]
  assign io_wn_imag = tmp_io_wn_imag; // @[wn_rom.scala 40:14]

endmodule

module butterfly_unit (
  input               start,
  output              finish,
  input      [15:0]   xp_real,
  input      [15:0]   xp_imag,
  input      [15:0]   xq_real,
  input      [15:0]   xq_imag,
  input      [15:0]   wn_real,
  input      [15:0]   wn_imag,
  output     [15:0]   yp_real,
  output     [15:0]   yp_imag,
  output     [15:0]   yq_real,
  output     [15:0]   yq_imag,
  output              mulif_din_vld,
  output reg [15:0]   mulif_dinA,
  output reg [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [31:0]   mulif_dout,
  input               clk,
  input               resetn
);
  localparam IDLE = 3'd0;
  localparam XQ_WN_MUL_AC = 3'd1;
  localparam XQ_WN_MUL_BD = 3'd2;
  localparam XQ_WN_MUL_AD = 3'd3;
  localparam XQ_WN_MUL_BC = 3'd4;

  wire       [33:0]   rdsat0_din;
  wire       [33:0]   rdsat1_din;
  wire       [15:0]   rdsat0_dout;
  wire       [15:0]   rdsat1_dout;
  wire       [33:0]   tmp_sumbuff1;
  wire       [33:0]   tmp_sumbuff1_1;
  wire       [25:0]   tmp_adder_pinB;
  wire       [25:0]   tmp_minus_pinA;
  wire       [25:0]   tmp_adder_pinB_1;
  wire       [25:0]   tmp_minus_pinA_1;
  reg        [2:0]    next_state;
  reg        [2:0]    curr_state;
  reg                 MUL_AC_IN;
  reg                 MUL_BD_IN;
  reg                 MUL_AD_IN;
  reg                 MUL_BC_IN;
  reg                 MUL_END;
  reg                 MUL_END_regNext;
  reg        [33:0]   sumbuff1;
  reg        [15:0]   yp_real_reg;
  reg        [15:0]   yp_imag_reg;
  reg        [15:0]   yq_real_reg;
  reg        [15:0]   yq_imag_reg;
  wire       [33:0]   adder_pinA;
  reg        [33:0]   adder_pinB;
  wire       [33:0]   adder_out;
  reg        [33:0]   minus_pinA;
  wire       [33:0]   minus_pinB;
  wire       [33:0]   minus_out;
  wire       [15:0]   adder_clip_out;
  wire       [15:0]   minus_clip_out;

  assign tmp_sumbuff1 = {{2{mulif_dout[31]}}, mulif_dout};
  assign tmp_sumbuff1_1 = {{2{mulif_dout[31]}}, mulif_dout};
  assign tmp_adder_pinB = {xp_real,10'h0};
  assign tmp_minus_pinA = {xp_real,10'h0};
  assign tmp_adder_pinB_1 = {xp_imag,10'h0};
  assign tmp_minus_pinA_1 = {xp_imag,10'h0};
  RoundandSat_6 rdsat0 (
    .din  (rdsat0_din[33:0] ), //i
    .dout (rdsat0_dout[15:0])  //o
  );
  RoundandSat_6 rdsat1 (
    .din  (rdsat1_din[33:0] ), //i
    .dout (rdsat1_dout[15:0])  //o
  );
  assign finish = MUL_END_regNext; // @[butterfly_unit.scala 81:13]
  assign mulif_din_vld = (((MUL_AC_IN || MUL_BD_IN) || MUL_AD_IN) || MUL_BC_IN); // @[butterfly_unit.scala 82:20]
  always @(*) begin
    next_state = curr_state; // @[butterfly_unit.scala 87:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = XQ_WN_MUL_AC; // @[Enum.scala 148:67]
        end
      end
      XQ_WN_MUL_AC : begin
        if(mulif_dout_vld) begin
          next_state = XQ_WN_MUL_BD; // @[Enum.scala 148:67]
        end
      end
      XQ_WN_MUL_BD : begin
        if(mulif_dout_vld) begin
          next_state = XQ_WN_MUL_AD; // @[Enum.scala 148:67]
        end
      end
      XQ_WN_MUL_AD : begin
        if(mulif_dout_vld) begin
          next_state = XQ_WN_MUL_BC; // @[Enum.scala 148:67]
        end
      end
      default : begin
        if(mulif_dout_vld) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end
      end
    endcase
  end

  always @(*) begin
    mulif_dinA = 16'h0; // @[butterfly_unit.scala 88:17]
    case(curr_state)
      IDLE : begin
      end
      XQ_WN_MUL_AC : begin
        mulif_dinA = xq_real; // @[butterfly_unit.scala 97:21]
      end
      XQ_WN_MUL_BD : begin
        mulif_dinA = xq_imag; // @[butterfly_unit.scala 105:21]
      end
      XQ_WN_MUL_AD : begin
        mulif_dinA = xq_real; // @[butterfly_unit.scala 113:21]
      end
      default : begin
        mulif_dinA = xq_imag; // @[butterfly_unit.scala 121:21]
      end
    endcase
  end

  always @(*) begin
    mulif_dinB = 16'h0; // @[butterfly_unit.scala 89:17]
    case(curr_state)
      IDLE : begin
      end
      XQ_WN_MUL_AC : begin
        mulif_dinB = wn_real; // @[butterfly_unit.scala 98:21]
      end
      XQ_WN_MUL_BD : begin
        mulif_dinB = wn_imag; // @[butterfly_unit.scala 106:21]
      end
      XQ_WN_MUL_AD : begin
        mulif_dinB = wn_imag; // @[butterfly_unit.scala 114:21]
      end
      default : begin
        mulif_dinB = wn_real; // @[butterfly_unit.scala 122:21]
      end
    endcase
  end

  assign adder_out = ($signed(adder_pinA) + $signed(adder_pinB)); // @[BaseType.scala 299:24]
  assign minus_out = ($signed(minus_pinA) - $signed(minus_pinB)); // @[BaseType.scala 299:24]
  assign rdsat0_din = adder_out; // @[butterfly_unit.scala 145:17]
  assign adder_clip_out = rdsat0_dout; // @[BaseType.scala 318:22]
  assign rdsat1_din = minus_out; // @[butterfly_unit.scala 147:17]
  assign minus_clip_out = rdsat1_dout; // @[BaseType.scala 318:22]
  assign adder_pinA = sumbuff1; // @[butterfly_unit.scala 151:14]
  assign minus_pinB = sumbuff1; // @[butterfly_unit.scala 152:14]
  always @(*) begin
    adder_pinB = 34'h0; // @[butterfly_unit.scala 153:14]
    if(MUL_AD_IN) begin
      adder_pinB = {{8{tmp_adder_pinB[25]}}, tmp_adder_pinB}; // @[butterfly_unit.scala 156:16]
    end
    if(MUL_END) begin
      adder_pinB = {{8{tmp_adder_pinB_1[25]}}, tmp_adder_pinB_1}; // @[butterfly_unit.scala 162:16]
    end
  end

  always @(*) begin
    minus_pinA = 34'h0; // @[butterfly_unit.scala 154:14]
    if(MUL_AD_IN) begin
      minus_pinA = {{8{tmp_minus_pinA[25]}}, tmp_minus_pinA}; // @[butterfly_unit.scala 158:16]
    end
    if(MUL_END) begin
      minus_pinA = {{8{tmp_minus_pinA_1[25]}}, tmp_minus_pinA_1}; // @[butterfly_unit.scala 164:16]
    end
  end

  assign yp_real = yp_real_reg; // @[butterfly_unit.scala 169:14]
  assign yp_imag = yp_imag_reg; // @[butterfly_unit.scala 170:14]
  assign yq_real = yq_real_reg; // @[butterfly_unit.scala 171:14]
  assign yq_imag = yq_imag_reg; // @[butterfly_unit.scala 172:14]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      curr_state <= IDLE; // @[Data.scala 400:33]
      MUL_AC_IN <= 1'b0; // @[Data.scala 400:33]
      MUL_BD_IN <= 1'b0; // @[Data.scala 400:33]
      MUL_AD_IN <= 1'b0; // @[Data.scala 400:33]
      MUL_BC_IN <= 1'b0; // @[Data.scala 400:33]
      MUL_END <= 1'b0; // @[Data.scala 400:33]
      MUL_END_regNext <= 1'b0; // @[Data.scala 400:33]
      sumbuff1 <= 34'h0; // @[Data.scala 400:33]
      yp_real_reg <= 16'h0; // @[Data.scala 400:33]
      yp_imag_reg <= 16'h0; // @[Data.scala 400:33]
      yq_real_reg <= 16'h0; // @[Data.scala 400:33]
      yq_imag_reg <= 16'h0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      MUL_AC_IN <= ((curr_state == IDLE) && (next_state == XQ_WN_MUL_AC)); // @[Reg.scala 39:30]
      MUL_BD_IN <= ((curr_state == XQ_WN_MUL_AC) && (next_state == XQ_WN_MUL_BD)); // @[Reg.scala 39:30]
      MUL_AD_IN <= ((curr_state == XQ_WN_MUL_BD) && (next_state == XQ_WN_MUL_AD)); // @[Reg.scala 39:30]
      MUL_BC_IN <= ((curr_state == XQ_WN_MUL_AD) && (next_state == XQ_WN_MUL_BC)); // @[Reg.scala 39:30]
      MUL_END <= ((curr_state == XQ_WN_MUL_BC) && (next_state == IDLE)); // @[Reg.scala 39:30]
      MUL_END_regNext <= MUL_END; // @[Reg.scala 39:30]
      case(curr_state)
        IDLE : begin
        end
        XQ_WN_MUL_AC : begin
          if(mulif_dout_vld) begin
            sumbuff1 <= {{2{mulif_dout[31]}}, mulif_dout}; // @[butterfly_unit.scala 101:18]
          end
        end
        XQ_WN_MUL_BD : begin
          if(mulif_dout_vld) begin
            sumbuff1 <= ($signed(sumbuff1) - $signed(tmp_sumbuff1)); // @[butterfly_unit.scala 109:18]
          end
        end
        XQ_WN_MUL_AD : begin
          if(mulif_dout_vld) begin
            sumbuff1 <= {{2{mulif_dout[31]}}, mulif_dout}; // @[butterfly_unit.scala 117:18]
          end
        end
        default : begin
          if(mulif_dout_vld) begin
            sumbuff1 <= ($signed(sumbuff1) + $signed(tmp_sumbuff1_1)); // @[butterfly_unit.scala 125:18]
          end
        end
      endcase
      if(MUL_AD_IN) begin
        yp_real_reg <= adder_clip_out; // @[butterfly_unit.scala 157:17]
        yq_real_reg <= minus_clip_out; // @[butterfly_unit.scala 159:17]
      end
      if(MUL_END) begin
        yp_imag_reg <= adder_clip_out; // @[butterfly_unit.scala 163:17]
        yq_imag_reg <= minus_clip_out; // @[butterfly_unit.scala 165:17]
      end
    end
  end


endmodule

module RoundandSat_3 (
  input      [24:0]   din,
  output     [15:0]   dout
);

  wire       [25:0]   tmp_tmp_dataOut_5;
  wire       [25:0]   tmp_tmp_dataOut_5_1;
  wire       [12:0]   tmp_when;
  wire       [12:0]   tmp_tmp_dataOut_7;
  wire       [12:0]   tmp_tmp_dataOut_7_1;
  wire       [25:0]   tmp_tmp_dataOut_1;
  wire       [25:0]   tmp_tmp_dataOut_1_1;
  wire       [25:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  (* keep *) wire       [15:0]   dataOut;
  wire       [24:0]   tmp_dataOut;
  reg        [12:0]   tmp_dataOut_1;
  wire       [24:0]   tmp_dataOut_2;
  wire       [24:0]   tmp_dataOut_3;
  wire       [24:0]   tmp_dataOut_4;
  wire       [25:0]   tmp_dataOut_5;
  wire       [24:0]   tmp_dataOut_6;
  reg        [12:0]   tmp_dataOut_7;
  reg        [11:0]   tmp_dataOut_8;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[24],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[24],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[12 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[25 : 13];
  assign tmp_tmp_dataOut_7_1 = 13'h0001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[24],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[24],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[12 : 11];
  assign tmp_when_2 = tmp_dataOut_1[11 : 11];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{12'h0,1'b1},12'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {13'h1fff,12'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[24 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[24 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[25 : 13]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[25]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 13); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_1[12]) begin
      if((! (&tmp_when_1))) begin
        tmp_dataOut_8 = 12'h800; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[11 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_dataOut_8 = 12'h7ff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[11 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign dataOut = {{tmp_dataOut_8[11],{tmp_dataOut_8[11],{tmp_dataOut_8[11],tmp_dataOut_8[11]}}},tmp_dataOut_8}; // @[RoundandSat.scala 22:13]
  assign dout = dataOut; // @[RoundandSat.scala 26:11]

endmodule

module win_rom (
  input      [7:0]    win_addr,
  output     [7:0]    win
);

  reg        [7:0]    tmp_win;
  wire       [7:0]    win_data_0;
  wire       [7:0]    win_data_1;
  wire       [7:0]    win_data_2;
  wire       [7:0]    win_data_3;
  wire       [7:0]    win_data_4;
  wire       [7:0]    win_data_5;
  wire       [7:0]    win_data_6;
  wire       [7:0]    win_data_7;
  wire       [7:0]    win_data_8;
  wire       [7:0]    win_data_9;
  wire       [7:0]    win_data_10;
  wire       [7:0]    win_data_11;
  wire       [7:0]    win_data_12;
  wire       [7:0]    win_data_13;
  wire       [7:0]    win_data_14;
  wire       [7:0]    win_data_15;
  wire       [7:0]    win_data_16;
  wire       [7:0]    win_data_17;
  wire       [7:0]    win_data_18;
  wire       [7:0]    win_data_19;
  wire       [7:0]    win_data_20;
  wire       [7:0]    win_data_21;
  wire       [7:0]    win_data_22;
  wire       [7:0]    win_data_23;
  wire       [7:0]    win_data_24;
  wire       [7:0]    win_data_25;
  wire       [7:0]    win_data_26;
  wire       [7:0]    win_data_27;
  wire       [7:0]    win_data_28;
  wire       [7:0]    win_data_29;
  wire       [7:0]    win_data_30;
  wire       [7:0]    win_data_31;
  wire       [7:0]    win_data_32;
  wire       [7:0]    win_data_33;
  wire       [7:0]    win_data_34;
  wire       [7:0]    win_data_35;
  wire       [7:0]    win_data_36;
  wire       [7:0]    win_data_37;
  wire       [7:0]    win_data_38;
  wire       [7:0]    win_data_39;
  wire       [7:0]    win_data_40;
  wire       [7:0]    win_data_41;
  wire       [7:0]    win_data_42;
  wire       [7:0]    win_data_43;
  wire       [7:0]    win_data_44;
  wire       [7:0]    win_data_45;
  wire       [7:0]    win_data_46;
  wire       [7:0]    win_data_47;
  wire       [7:0]    win_data_48;
  wire       [7:0]    win_data_49;
  wire       [7:0]    win_data_50;
  wire       [7:0]    win_data_51;
  wire       [7:0]    win_data_52;
  wire       [7:0]    win_data_53;
  wire       [7:0]    win_data_54;
  wire       [7:0]    win_data_55;
  wire       [7:0]    win_data_56;
  wire       [7:0]    win_data_57;
  wire       [7:0]    win_data_58;
  wire       [7:0]    win_data_59;
  wire       [7:0]    win_data_60;
  wire       [7:0]    win_data_61;
  wire       [7:0]    win_data_62;
  wire       [7:0]    win_data_63;
  wire       [7:0]    win_data_64;
  wire       [7:0]    win_data_65;
  wire       [7:0]    win_data_66;
  wire       [7:0]    win_data_67;
  wire       [7:0]    win_data_68;
  wire       [7:0]    win_data_69;
  wire       [7:0]    win_data_70;
  wire       [7:0]    win_data_71;
  wire       [7:0]    win_data_72;
  wire       [7:0]    win_data_73;
  wire       [7:0]    win_data_74;
  wire       [7:0]    win_data_75;
  wire       [7:0]    win_data_76;
  wire       [7:0]    win_data_77;
  wire       [7:0]    win_data_78;
  wire       [7:0]    win_data_79;
  wire       [7:0]    win_data_80;
  wire       [7:0]    win_data_81;
  wire       [7:0]    win_data_82;
  wire       [7:0]    win_data_83;
  wire       [7:0]    win_data_84;
  wire       [7:0]    win_data_85;
  wire       [7:0]    win_data_86;
  wire       [7:0]    win_data_87;
  wire       [7:0]    win_data_88;
  wire       [7:0]    win_data_89;
  wire       [7:0]    win_data_90;
  wire       [7:0]    win_data_91;
  wire       [7:0]    win_data_92;
  wire       [7:0]    win_data_93;
  wire       [7:0]    win_data_94;
  wire       [7:0]    win_data_95;
  wire       [7:0]    win_data_96;
  wire       [7:0]    win_data_97;
  wire       [7:0]    win_data_98;
  wire       [7:0]    win_data_99;
  wire       [7:0]    win_data_100;
  wire       [7:0]    win_data_101;
  wire       [7:0]    win_data_102;
  wire       [7:0]    win_data_103;
  wire       [7:0]    win_data_104;
  wire       [7:0]    win_data_105;
  wire       [7:0]    win_data_106;
  wire       [7:0]    win_data_107;
  wire       [7:0]    win_data_108;
  wire       [7:0]    win_data_109;
  wire       [7:0]    win_data_110;
  wire       [7:0]    win_data_111;
  wire       [7:0]    win_data_112;
  wire       [7:0]    win_data_113;
  wire       [7:0]    win_data_114;
  wire       [7:0]    win_data_115;
  wire       [7:0]    win_data_116;
  wire       [7:0]    win_data_117;
  wire       [7:0]    win_data_118;
  wire       [7:0]    win_data_119;
  wire       [7:0]    win_data_120;
  wire       [7:0]    win_data_121;
  wire       [7:0]    win_data_122;
  wire       [7:0]    win_data_123;
  wire       [7:0]    win_data_124;
  wire       [7:0]    win_data_125;
  wire       [7:0]    win_data_126;
  wire       [7:0]    win_data_127;
  wire       [7:0]    win_data_128;
  wire       [7:0]    win_data_129;
  wire       [7:0]    win_data_130;
  wire       [7:0]    win_data_131;
  wire       [7:0]    win_data_132;
  wire       [7:0]    win_data_133;
  wire       [7:0]    win_data_134;
  wire       [7:0]    win_data_135;
  wire       [7:0]    win_data_136;
  wire       [7:0]    win_data_137;
  wire       [7:0]    win_data_138;
  wire       [7:0]    win_data_139;
  wire       [7:0]    win_data_140;
  wire       [7:0]    win_data_141;
  wire       [7:0]    win_data_142;
  wire       [7:0]    win_data_143;
  wire       [7:0]    win_data_144;
  wire       [7:0]    win_data_145;
  wire       [7:0]    win_data_146;
  wire       [7:0]    win_data_147;
  wire       [7:0]    win_data_148;
  wire       [7:0]    win_data_149;
  wire       [7:0]    win_data_150;
  wire       [7:0]    win_data_151;
  wire       [7:0]    win_data_152;
  wire       [7:0]    win_data_153;
  wire       [7:0]    win_data_154;
  wire       [7:0]    win_data_155;
  wire       [7:0]    win_data_156;
  wire       [7:0]    win_data_157;
  wire       [7:0]    win_data_158;
  wire       [7:0]    win_data_159;
  wire       [7:0]    win_data_160;
  wire       [7:0]    win_data_161;
  wire       [7:0]    win_data_162;
  wire       [7:0]    win_data_163;
  wire       [7:0]    win_data_164;
  wire       [7:0]    win_data_165;
  wire       [7:0]    win_data_166;
  wire       [7:0]    win_data_167;
  wire       [7:0]    win_data_168;
  wire       [7:0]    win_data_169;
  wire       [7:0]    win_data_170;
  wire       [7:0]    win_data_171;
  wire       [7:0]    win_data_172;
  wire       [7:0]    win_data_173;
  wire       [7:0]    win_data_174;
  wire       [7:0]    win_data_175;
  wire       [7:0]    win_data_176;
  wire       [7:0]    win_data_177;
  wire       [7:0]    win_data_178;
  wire       [7:0]    win_data_179;
  wire       [7:0]    win_data_180;
  wire       [7:0]    win_data_181;
  wire       [7:0]    win_data_182;
  wire       [7:0]    win_data_183;
  wire       [7:0]    win_data_184;
  wire       [7:0]    win_data_185;
  wire       [7:0]    win_data_186;
  wire       [7:0]    win_data_187;
  wire       [7:0]    win_data_188;
  wire       [7:0]    win_data_189;
  wire       [7:0]    win_data_190;
  wire       [7:0]    win_data_191;
  wire       [7:0]    win_data_192;
  wire       [7:0]    win_data_193;
  wire       [7:0]    win_data_194;
  wire       [7:0]    win_data_195;
  wire       [7:0]    win_data_196;
  wire       [7:0]    win_data_197;
  wire       [7:0]    win_data_198;
  wire       [7:0]    win_data_199;
  wire       [7:0]    win_data_200;
  wire       [7:0]    win_data_201;
  wire       [7:0]    win_data_202;
  wire       [7:0]    win_data_203;
  wire       [7:0]    win_data_204;
  wire       [7:0]    win_data_205;
  wire       [7:0]    win_data_206;
  wire       [7:0]    win_data_207;
  wire       [7:0]    win_data_208;
  wire       [7:0]    win_data_209;
  wire       [7:0]    win_data_210;
  wire       [7:0]    win_data_211;
  wire       [7:0]    win_data_212;
  wire       [7:0]    win_data_213;
  wire       [7:0]    win_data_214;
  wire       [7:0]    win_data_215;
  wire       [7:0]    win_data_216;
  wire       [7:0]    win_data_217;
  wire       [7:0]    win_data_218;
  wire       [7:0]    win_data_219;
  wire       [7:0]    win_data_220;
  wire       [7:0]    win_data_221;
  wire       [7:0]    win_data_222;
  wire       [7:0]    win_data_223;
  wire       [7:0]    win_data_224;
  wire       [7:0]    win_data_225;
  wire       [7:0]    win_data_226;
  wire       [7:0]    win_data_227;
  wire       [7:0]    win_data_228;
  wire       [7:0]    win_data_229;
  wire       [7:0]    win_data_230;
  wire       [7:0]    win_data_231;
  wire       [7:0]    win_data_232;
  wire       [7:0]    win_data_233;
  wire       [7:0]    win_data_234;
  wire       [7:0]    win_data_235;
  wire       [7:0]    win_data_236;
  wire       [7:0]    win_data_237;
  wire       [7:0]    win_data_238;
  wire       [7:0]    win_data_239;
  wire       [7:0]    win_data_240;
  wire       [7:0]    win_data_241;
  wire       [7:0]    win_data_242;
  wire       [7:0]    win_data_243;
  wire       [7:0]    win_data_244;
  wire       [7:0]    win_data_245;
  wire       [7:0]    win_data_246;
  wire       [7:0]    win_data_247;
  wire       [7:0]    win_data_248;
  wire       [7:0]    win_data_249;
  wire       [7:0]    win_data_250;
  wire       [7:0]    win_data_251;
  wire       [7:0]    win_data_252;
  wire       [7:0]    win_data_253;
  wire       [7:0]    win_data_254;
  wire       [7:0]    win_data_255;

  always @(*) begin
    case(win_addr)
      8'b00000000 : tmp_win = win_data_0;
      8'b00000001 : tmp_win = win_data_1;
      8'b00000010 : tmp_win = win_data_2;
      8'b00000011 : tmp_win = win_data_3;
      8'b00000100 : tmp_win = win_data_4;
      8'b00000101 : tmp_win = win_data_5;
      8'b00000110 : tmp_win = win_data_6;
      8'b00000111 : tmp_win = win_data_7;
      8'b00001000 : tmp_win = win_data_8;
      8'b00001001 : tmp_win = win_data_9;
      8'b00001010 : tmp_win = win_data_10;
      8'b00001011 : tmp_win = win_data_11;
      8'b00001100 : tmp_win = win_data_12;
      8'b00001101 : tmp_win = win_data_13;
      8'b00001110 : tmp_win = win_data_14;
      8'b00001111 : tmp_win = win_data_15;
      8'b00010000 : tmp_win = win_data_16;
      8'b00010001 : tmp_win = win_data_17;
      8'b00010010 : tmp_win = win_data_18;
      8'b00010011 : tmp_win = win_data_19;
      8'b00010100 : tmp_win = win_data_20;
      8'b00010101 : tmp_win = win_data_21;
      8'b00010110 : tmp_win = win_data_22;
      8'b00010111 : tmp_win = win_data_23;
      8'b00011000 : tmp_win = win_data_24;
      8'b00011001 : tmp_win = win_data_25;
      8'b00011010 : tmp_win = win_data_26;
      8'b00011011 : tmp_win = win_data_27;
      8'b00011100 : tmp_win = win_data_28;
      8'b00011101 : tmp_win = win_data_29;
      8'b00011110 : tmp_win = win_data_30;
      8'b00011111 : tmp_win = win_data_31;
      8'b00100000 : tmp_win = win_data_32;
      8'b00100001 : tmp_win = win_data_33;
      8'b00100010 : tmp_win = win_data_34;
      8'b00100011 : tmp_win = win_data_35;
      8'b00100100 : tmp_win = win_data_36;
      8'b00100101 : tmp_win = win_data_37;
      8'b00100110 : tmp_win = win_data_38;
      8'b00100111 : tmp_win = win_data_39;
      8'b00101000 : tmp_win = win_data_40;
      8'b00101001 : tmp_win = win_data_41;
      8'b00101010 : tmp_win = win_data_42;
      8'b00101011 : tmp_win = win_data_43;
      8'b00101100 : tmp_win = win_data_44;
      8'b00101101 : tmp_win = win_data_45;
      8'b00101110 : tmp_win = win_data_46;
      8'b00101111 : tmp_win = win_data_47;
      8'b00110000 : tmp_win = win_data_48;
      8'b00110001 : tmp_win = win_data_49;
      8'b00110010 : tmp_win = win_data_50;
      8'b00110011 : tmp_win = win_data_51;
      8'b00110100 : tmp_win = win_data_52;
      8'b00110101 : tmp_win = win_data_53;
      8'b00110110 : tmp_win = win_data_54;
      8'b00110111 : tmp_win = win_data_55;
      8'b00111000 : tmp_win = win_data_56;
      8'b00111001 : tmp_win = win_data_57;
      8'b00111010 : tmp_win = win_data_58;
      8'b00111011 : tmp_win = win_data_59;
      8'b00111100 : tmp_win = win_data_60;
      8'b00111101 : tmp_win = win_data_61;
      8'b00111110 : tmp_win = win_data_62;
      8'b00111111 : tmp_win = win_data_63;
      8'b01000000 : tmp_win = win_data_64;
      8'b01000001 : tmp_win = win_data_65;
      8'b01000010 : tmp_win = win_data_66;
      8'b01000011 : tmp_win = win_data_67;
      8'b01000100 : tmp_win = win_data_68;
      8'b01000101 : tmp_win = win_data_69;
      8'b01000110 : tmp_win = win_data_70;
      8'b01000111 : tmp_win = win_data_71;
      8'b01001000 : tmp_win = win_data_72;
      8'b01001001 : tmp_win = win_data_73;
      8'b01001010 : tmp_win = win_data_74;
      8'b01001011 : tmp_win = win_data_75;
      8'b01001100 : tmp_win = win_data_76;
      8'b01001101 : tmp_win = win_data_77;
      8'b01001110 : tmp_win = win_data_78;
      8'b01001111 : tmp_win = win_data_79;
      8'b01010000 : tmp_win = win_data_80;
      8'b01010001 : tmp_win = win_data_81;
      8'b01010010 : tmp_win = win_data_82;
      8'b01010011 : tmp_win = win_data_83;
      8'b01010100 : tmp_win = win_data_84;
      8'b01010101 : tmp_win = win_data_85;
      8'b01010110 : tmp_win = win_data_86;
      8'b01010111 : tmp_win = win_data_87;
      8'b01011000 : tmp_win = win_data_88;
      8'b01011001 : tmp_win = win_data_89;
      8'b01011010 : tmp_win = win_data_90;
      8'b01011011 : tmp_win = win_data_91;
      8'b01011100 : tmp_win = win_data_92;
      8'b01011101 : tmp_win = win_data_93;
      8'b01011110 : tmp_win = win_data_94;
      8'b01011111 : tmp_win = win_data_95;
      8'b01100000 : tmp_win = win_data_96;
      8'b01100001 : tmp_win = win_data_97;
      8'b01100010 : tmp_win = win_data_98;
      8'b01100011 : tmp_win = win_data_99;
      8'b01100100 : tmp_win = win_data_100;
      8'b01100101 : tmp_win = win_data_101;
      8'b01100110 : tmp_win = win_data_102;
      8'b01100111 : tmp_win = win_data_103;
      8'b01101000 : tmp_win = win_data_104;
      8'b01101001 : tmp_win = win_data_105;
      8'b01101010 : tmp_win = win_data_106;
      8'b01101011 : tmp_win = win_data_107;
      8'b01101100 : tmp_win = win_data_108;
      8'b01101101 : tmp_win = win_data_109;
      8'b01101110 : tmp_win = win_data_110;
      8'b01101111 : tmp_win = win_data_111;
      8'b01110000 : tmp_win = win_data_112;
      8'b01110001 : tmp_win = win_data_113;
      8'b01110010 : tmp_win = win_data_114;
      8'b01110011 : tmp_win = win_data_115;
      8'b01110100 : tmp_win = win_data_116;
      8'b01110101 : tmp_win = win_data_117;
      8'b01110110 : tmp_win = win_data_118;
      8'b01110111 : tmp_win = win_data_119;
      8'b01111000 : tmp_win = win_data_120;
      8'b01111001 : tmp_win = win_data_121;
      8'b01111010 : tmp_win = win_data_122;
      8'b01111011 : tmp_win = win_data_123;
      8'b01111100 : tmp_win = win_data_124;
      8'b01111101 : tmp_win = win_data_125;
      8'b01111110 : tmp_win = win_data_126;
      8'b01111111 : tmp_win = win_data_127;
      8'b10000000 : tmp_win = win_data_128;
      8'b10000001 : tmp_win = win_data_129;
      8'b10000010 : tmp_win = win_data_130;
      8'b10000011 : tmp_win = win_data_131;
      8'b10000100 : tmp_win = win_data_132;
      8'b10000101 : tmp_win = win_data_133;
      8'b10000110 : tmp_win = win_data_134;
      8'b10000111 : tmp_win = win_data_135;
      8'b10001000 : tmp_win = win_data_136;
      8'b10001001 : tmp_win = win_data_137;
      8'b10001010 : tmp_win = win_data_138;
      8'b10001011 : tmp_win = win_data_139;
      8'b10001100 : tmp_win = win_data_140;
      8'b10001101 : tmp_win = win_data_141;
      8'b10001110 : tmp_win = win_data_142;
      8'b10001111 : tmp_win = win_data_143;
      8'b10010000 : tmp_win = win_data_144;
      8'b10010001 : tmp_win = win_data_145;
      8'b10010010 : tmp_win = win_data_146;
      8'b10010011 : tmp_win = win_data_147;
      8'b10010100 : tmp_win = win_data_148;
      8'b10010101 : tmp_win = win_data_149;
      8'b10010110 : tmp_win = win_data_150;
      8'b10010111 : tmp_win = win_data_151;
      8'b10011000 : tmp_win = win_data_152;
      8'b10011001 : tmp_win = win_data_153;
      8'b10011010 : tmp_win = win_data_154;
      8'b10011011 : tmp_win = win_data_155;
      8'b10011100 : tmp_win = win_data_156;
      8'b10011101 : tmp_win = win_data_157;
      8'b10011110 : tmp_win = win_data_158;
      8'b10011111 : tmp_win = win_data_159;
      8'b10100000 : tmp_win = win_data_160;
      8'b10100001 : tmp_win = win_data_161;
      8'b10100010 : tmp_win = win_data_162;
      8'b10100011 : tmp_win = win_data_163;
      8'b10100100 : tmp_win = win_data_164;
      8'b10100101 : tmp_win = win_data_165;
      8'b10100110 : tmp_win = win_data_166;
      8'b10100111 : tmp_win = win_data_167;
      8'b10101000 : tmp_win = win_data_168;
      8'b10101001 : tmp_win = win_data_169;
      8'b10101010 : tmp_win = win_data_170;
      8'b10101011 : tmp_win = win_data_171;
      8'b10101100 : tmp_win = win_data_172;
      8'b10101101 : tmp_win = win_data_173;
      8'b10101110 : tmp_win = win_data_174;
      8'b10101111 : tmp_win = win_data_175;
      8'b10110000 : tmp_win = win_data_176;
      8'b10110001 : tmp_win = win_data_177;
      8'b10110010 : tmp_win = win_data_178;
      8'b10110011 : tmp_win = win_data_179;
      8'b10110100 : tmp_win = win_data_180;
      8'b10110101 : tmp_win = win_data_181;
      8'b10110110 : tmp_win = win_data_182;
      8'b10110111 : tmp_win = win_data_183;
      8'b10111000 : tmp_win = win_data_184;
      8'b10111001 : tmp_win = win_data_185;
      8'b10111010 : tmp_win = win_data_186;
      8'b10111011 : tmp_win = win_data_187;
      8'b10111100 : tmp_win = win_data_188;
      8'b10111101 : tmp_win = win_data_189;
      8'b10111110 : tmp_win = win_data_190;
      8'b10111111 : tmp_win = win_data_191;
      8'b11000000 : tmp_win = win_data_192;
      8'b11000001 : tmp_win = win_data_193;
      8'b11000010 : tmp_win = win_data_194;
      8'b11000011 : tmp_win = win_data_195;
      8'b11000100 : tmp_win = win_data_196;
      8'b11000101 : tmp_win = win_data_197;
      8'b11000110 : tmp_win = win_data_198;
      8'b11000111 : tmp_win = win_data_199;
      8'b11001000 : tmp_win = win_data_200;
      8'b11001001 : tmp_win = win_data_201;
      8'b11001010 : tmp_win = win_data_202;
      8'b11001011 : tmp_win = win_data_203;
      8'b11001100 : tmp_win = win_data_204;
      8'b11001101 : tmp_win = win_data_205;
      8'b11001110 : tmp_win = win_data_206;
      8'b11001111 : tmp_win = win_data_207;
      8'b11010000 : tmp_win = win_data_208;
      8'b11010001 : tmp_win = win_data_209;
      8'b11010010 : tmp_win = win_data_210;
      8'b11010011 : tmp_win = win_data_211;
      8'b11010100 : tmp_win = win_data_212;
      8'b11010101 : tmp_win = win_data_213;
      8'b11010110 : tmp_win = win_data_214;
      8'b11010111 : tmp_win = win_data_215;
      8'b11011000 : tmp_win = win_data_216;
      8'b11011001 : tmp_win = win_data_217;
      8'b11011010 : tmp_win = win_data_218;
      8'b11011011 : tmp_win = win_data_219;
      8'b11011100 : tmp_win = win_data_220;
      8'b11011101 : tmp_win = win_data_221;
      8'b11011110 : tmp_win = win_data_222;
      8'b11011111 : tmp_win = win_data_223;
      8'b11100000 : tmp_win = win_data_224;
      8'b11100001 : tmp_win = win_data_225;
      8'b11100010 : tmp_win = win_data_226;
      8'b11100011 : tmp_win = win_data_227;
      8'b11100100 : tmp_win = win_data_228;
      8'b11100101 : tmp_win = win_data_229;
      8'b11100110 : tmp_win = win_data_230;
      8'b11100111 : tmp_win = win_data_231;
      8'b11101000 : tmp_win = win_data_232;
      8'b11101001 : tmp_win = win_data_233;
      8'b11101010 : tmp_win = win_data_234;
      8'b11101011 : tmp_win = win_data_235;
      8'b11101100 : tmp_win = win_data_236;
      8'b11101101 : tmp_win = win_data_237;
      8'b11101110 : tmp_win = win_data_238;
      8'b11101111 : tmp_win = win_data_239;
      8'b11110000 : tmp_win = win_data_240;
      8'b11110001 : tmp_win = win_data_241;
      8'b11110010 : tmp_win = win_data_242;
      8'b11110011 : tmp_win = win_data_243;
      8'b11110100 : tmp_win = win_data_244;
      8'b11110101 : tmp_win = win_data_245;
      8'b11110110 : tmp_win = win_data_246;
      8'b11110111 : tmp_win = win_data_247;
      8'b11111000 : tmp_win = win_data_248;
      8'b11111001 : tmp_win = win_data_249;
      8'b11111010 : tmp_win = win_data_250;
      8'b11111011 : tmp_win = win_data_251;
      8'b11111100 : tmp_win = win_data_252;
      8'b11111101 : tmp_win = win_data_253;
      8'b11111110 : tmp_win = win_data_254;
      default : tmp_win = win_data_255;
    endcase
  end

  assign win_data_0 = 8'h0; // @[Expression.scala 2342:18]
  assign win_data_1 = 8'h0; // @[Expression.scala 2342:18]
  assign win_data_2 = 8'h0; // @[Expression.scala 2342:18]
  assign win_data_3 = 8'h0; // @[Expression.scala 2342:18]
  assign win_data_4 = 8'h01; // @[Expression.scala 2342:18]
  assign win_data_5 = 8'h01; // @[Expression.scala 2342:18]
  assign win_data_6 = 8'h01; // @[Expression.scala 2342:18]
  assign win_data_7 = 8'h02; // @[Expression.scala 2342:18]
  assign win_data_8 = 8'h02; // @[Expression.scala 2342:18]
  assign win_data_9 = 8'h03; // @[Expression.scala 2342:18]
  assign win_data_10 = 8'h04; // @[Expression.scala 2342:18]
  assign win_data_11 = 8'h05; // @[Expression.scala 2342:18]
  assign win_data_12 = 8'h05; // @[Expression.scala 2342:18]
  assign win_data_13 = 8'h06; // @[Expression.scala 2342:18]
  assign win_data_14 = 8'h07; // @[Expression.scala 2342:18]
  assign win_data_15 = 8'h09; // @[Expression.scala 2342:18]
  assign win_data_16 = 8'h0a; // @[Expression.scala 2342:18]
  assign win_data_17 = 8'h0b; // @[Expression.scala 2342:18]
  assign win_data_18 = 8'h0c; // @[Expression.scala 2342:18]
  assign win_data_19 = 8'h0e; // @[Expression.scala 2342:18]
  assign win_data_20 = 8'h0f; // @[Expression.scala 2342:18]
  assign win_data_21 = 8'h11; // @[Expression.scala 2342:18]
  assign win_data_22 = 8'h12; // @[Expression.scala 2342:18]
  assign win_data_23 = 8'h14; // @[Expression.scala 2342:18]
  assign win_data_24 = 8'h15; // @[Expression.scala 2342:18]
  assign win_data_25 = 8'h17; // @[Expression.scala 2342:18]
  assign win_data_26 = 8'h19; // @[Expression.scala 2342:18]
  assign win_data_27 = 8'h1b; // @[Expression.scala 2342:18]
  assign win_data_28 = 8'h1d; // @[Expression.scala 2342:18]
  assign win_data_29 = 8'h1f; // @[Expression.scala 2342:18]
  assign win_data_30 = 8'h21; // @[Expression.scala 2342:18]
  assign win_data_31 = 8'h23; // @[Expression.scala 2342:18]
  assign win_data_32 = 8'h25; // @[Expression.scala 2342:18]
  assign win_data_33 = 8'h28; // @[Expression.scala 2342:18]
  assign win_data_34 = 8'h2a; // @[Expression.scala 2342:18]
  assign win_data_35 = 8'h2c; // @[Expression.scala 2342:18]
  assign win_data_36 = 8'h2f; // @[Expression.scala 2342:18]
  assign win_data_37 = 8'h31; // @[Expression.scala 2342:18]
  assign win_data_38 = 8'h34; // @[Expression.scala 2342:18]
  assign win_data_39 = 8'h36; // @[Expression.scala 2342:18]
  assign win_data_40 = 8'h39; // @[Expression.scala 2342:18]
  assign win_data_41 = 8'h3b; // @[Expression.scala 2342:18]
  assign win_data_42 = 8'h3e; // @[Expression.scala 2342:18]
  assign win_data_43 = 8'h41; // @[Expression.scala 2342:18]
  assign win_data_44 = 8'h43; // @[Expression.scala 2342:18]
  assign win_data_45 = 8'h46; // @[Expression.scala 2342:18]
  assign win_data_46 = 8'h49; // @[Expression.scala 2342:18]
  assign win_data_47 = 8'h4c; // @[Expression.scala 2342:18]
  assign win_data_48 = 8'h4f; // @[Expression.scala 2342:18]
  assign win_data_49 = 8'h52; // @[Expression.scala 2342:18]
  assign win_data_50 = 8'h55; // @[Expression.scala 2342:18]
  assign win_data_51 = 8'h58; // @[Expression.scala 2342:18]
  assign win_data_52 = 8'h5a; // @[Expression.scala 2342:18]
  assign win_data_53 = 8'h5d; // @[Expression.scala 2342:18]
  assign win_data_54 = 8'h61; // @[Expression.scala 2342:18]
  assign win_data_55 = 8'h64; // @[Expression.scala 2342:18]
  assign win_data_56 = 8'h67; // @[Expression.scala 2342:18]
  assign win_data_57 = 8'h6a; // @[Expression.scala 2342:18]
  assign win_data_58 = 8'h6d; // @[Expression.scala 2342:18]
  assign win_data_59 = 8'h70; // @[Expression.scala 2342:18]
  assign win_data_60 = 8'h73; // @[Expression.scala 2342:18]
  assign win_data_61 = 8'h76; // @[Expression.scala 2342:18]
  assign win_data_62 = 8'h79; // @[Expression.scala 2342:18]
  assign win_data_63 = 8'h7c; // @[Expression.scala 2342:18]
  assign win_data_64 = 8'h80; // @[Expression.scala 2342:18]
  assign win_data_65 = 8'h83; // @[Expression.scala 2342:18]
  assign win_data_66 = 8'h86; // @[Expression.scala 2342:18]
  assign win_data_67 = 8'h89; // @[Expression.scala 2342:18]
  assign win_data_68 = 8'h8c; // @[Expression.scala 2342:18]
  assign win_data_69 = 8'h8f; // @[Expression.scala 2342:18]
  assign win_data_70 = 8'h92; // @[Expression.scala 2342:18]
  assign win_data_71 = 8'h95; // @[Expression.scala 2342:18]
  assign win_data_72 = 8'h98; // @[Expression.scala 2342:18]
  assign win_data_73 = 8'h9b; // @[Expression.scala 2342:18]
  assign win_data_74 = 8'h9e; // @[Expression.scala 2342:18]
  assign win_data_75 = 8'ha2; // @[Expression.scala 2342:18]
  assign win_data_76 = 8'ha5; // @[Expression.scala 2342:18]
  assign win_data_77 = 8'ha7; // @[Expression.scala 2342:18]
  assign win_data_78 = 8'haa; // @[Expression.scala 2342:18]
  assign win_data_79 = 8'had; // @[Expression.scala 2342:18]
  assign win_data_80 = 8'hb0; // @[Expression.scala 2342:18]
  assign win_data_81 = 8'hb3; // @[Expression.scala 2342:18]
  assign win_data_82 = 8'hb6; // @[Expression.scala 2342:18]
  assign win_data_83 = 8'hb9; // @[Expression.scala 2342:18]
  assign win_data_84 = 8'hbc; // @[Expression.scala 2342:18]
  assign win_data_85 = 8'hbe; // @[Expression.scala 2342:18]
  assign win_data_86 = 8'hc1; // @[Expression.scala 2342:18]
  assign win_data_87 = 8'hc4; // @[Expression.scala 2342:18]
  assign win_data_88 = 8'hc6; // @[Expression.scala 2342:18]
  assign win_data_89 = 8'hc9; // @[Expression.scala 2342:18]
  assign win_data_90 = 8'hcb; // @[Expression.scala 2342:18]
  assign win_data_91 = 8'hce; // @[Expression.scala 2342:18]
  assign win_data_92 = 8'hd0; // @[Expression.scala 2342:18]
  assign win_data_93 = 8'hd3; // @[Expression.scala 2342:18]
  assign win_data_94 = 8'hd5; // @[Expression.scala 2342:18]
  assign win_data_95 = 8'hd7; // @[Expression.scala 2342:18]
  assign win_data_96 = 8'hda; // @[Expression.scala 2342:18]
  assign win_data_97 = 8'hdc; // @[Expression.scala 2342:18]
  assign win_data_98 = 8'hde; // @[Expression.scala 2342:18]
  assign win_data_99 = 8'he0; // @[Expression.scala 2342:18]
  assign win_data_100 = 8'he2; // @[Expression.scala 2342:18]
  assign win_data_101 = 8'he4; // @[Expression.scala 2342:18]
  assign win_data_102 = 8'he6; // @[Expression.scala 2342:18]
  assign win_data_103 = 8'he8; // @[Expression.scala 2342:18]
  assign win_data_104 = 8'hea; // @[Expression.scala 2342:18]
  assign win_data_105 = 8'heb; // @[Expression.scala 2342:18]
  assign win_data_106 = 8'hed; // @[Expression.scala 2342:18]
  assign win_data_107 = 8'hee; // @[Expression.scala 2342:18]
  assign win_data_108 = 8'hf0; // @[Expression.scala 2342:18]
  assign win_data_109 = 8'hf1; // @[Expression.scala 2342:18]
  assign win_data_110 = 8'hf3; // @[Expression.scala 2342:18]
  assign win_data_111 = 8'hf4; // @[Expression.scala 2342:18]
  assign win_data_112 = 8'hf5; // @[Expression.scala 2342:18]
  assign win_data_113 = 8'hf6; // @[Expression.scala 2342:18]
  assign win_data_114 = 8'hf8; // @[Expression.scala 2342:18]
  assign win_data_115 = 8'hf9; // @[Expression.scala 2342:18]
  assign win_data_116 = 8'hfa; // @[Expression.scala 2342:18]
  assign win_data_117 = 8'hfa; // @[Expression.scala 2342:18]
  assign win_data_118 = 8'hfb; // @[Expression.scala 2342:18]
  assign win_data_119 = 8'hfc; // @[Expression.scala 2342:18]
  assign win_data_120 = 8'hfd; // @[Expression.scala 2342:18]
  assign win_data_121 = 8'hfd; // @[Expression.scala 2342:18]
  assign win_data_122 = 8'hfe; // @[Expression.scala 2342:18]
  assign win_data_123 = 8'hfe; // @[Expression.scala 2342:18]
  assign win_data_124 = 8'hfe; // @[Expression.scala 2342:18]
  assign win_data_125 = 8'hff; // @[Expression.scala 2342:18]
  assign win_data_126 = 8'hff; // @[Expression.scala 2342:18]
  assign win_data_127 = 8'hff; // @[Expression.scala 2342:18]
  assign win_data_128 = 8'hff; // @[Expression.scala 2342:18]
  assign win_data_129 = 8'hff; // @[Expression.scala 2342:18]
  assign win_data_130 = 8'hff; // @[Expression.scala 2342:18]
  assign win_data_131 = 8'hff; // @[Expression.scala 2342:18]
  assign win_data_132 = 8'hfe; // @[Expression.scala 2342:18]
  assign win_data_133 = 8'hfe; // @[Expression.scala 2342:18]
  assign win_data_134 = 8'hfe; // @[Expression.scala 2342:18]
  assign win_data_135 = 8'hfd; // @[Expression.scala 2342:18]
  assign win_data_136 = 8'hfd; // @[Expression.scala 2342:18]
  assign win_data_137 = 8'hfc; // @[Expression.scala 2342:18]
  assign win_data_138 = 8'hfb; // @[Expression.scala 2342:18]
  assign win_data_139 = 8'hfa; // @[Expression.scala 2342:18]
  assign win_data_140 = 8'hfa; // @[Expression.scala 2342:18]
  assign win_data_141 = 8'hf9; // @[Expression.scala 2342:18]
  assign win_data_142 = 8'hf8; // @[Expression.scala 2342:18]
  assign win_data_143 = 8'hf6; // @[Expression.scala 2342:18]
  assign win_data_144 = 8'hf5; // @[Expression.scala 2342:18]
  assign win_data_145 = 8'hf4; // @[Expression.scala 2342:18]
  assign win_data_146 = 8'hf3; // @[Expression.scala 2342:18]
  assign win_data_147 = 8'hf1; // @[Expression.scala 2342:18]
  assign win_data_148 = 8'hf0; // @[Expression.scala 2342:18]
  assign win_data_149 = 8'hee; // @[Expression.scala 2342:18]
  assign win_data_150 = 8'hed; // @[Expression.scala 2342:18]
  assign win_data_151 = 8'heb; // @[Expression.scala 2342:18]
  assign win_data_152 = 8'hea; // @[Expression.scala 2342:18]
  assign win_data_153 = 8'he8; // @[Expression.scala 2342:18]
  assign win_data_154 = 8'he6; // @[Expression.scala 2342:18]
  assign win_data_155 = 8'he4; // @[Expression.scala 2342:18]
  assign win_data_156 = 8'he2; // @[Expression.scala 2342:18]
  assign win_data_157 = 8'he0; // @[Expression.scala 2342:18]
  assign win_data_158 = 8'hde; // @[Expression.scala 2342:18]
  assign win_data_159 = 8'hdc; // @[Expression.scala 2342:18]
  assign win_data_160 = 8'hda; // @[Expression.scala 2342:18]
  assign win_data_161 = 8'hd7; // @[Expression.scala 2342:18]
  assign win_data_162 = 8'hd5; // @[Expression.scala 2342:18]
  assign win_data_163 = 8'hd3; // @[Expression.scala 2342:18]
  assign win_data_164 = 8'hd0; // @[Expression.scala 2342:18]
  assign win_data_165 = 8'hce; // @[Expression.scala 2342:18]
  assign win_data_166 = 8'hcb; // @[Expression.scala 2342:18]
  assign win_data_167 = 8'hc9; // @[Expression.scala 2342:18]
  assign win_data_168 = 8'hc6; // @[Expression.scala 2342:18]
  assign win_data_169 = 8'hc4; // @[Expression.scala 2342:18]
  assign win_data_170 = 8'hc1; // @[Expression.scala 2342:18]
  assign win_data_171 = 8'hbe; // @[Expression.scala 2342:18]
  assign win_data_172 = 8'hbc; // @[Expression.scala 2342:18]
  assign win_data_173 = 8'hb9; // @[Expression.scala 2342:18]
  assign win_data_174 = 8'hb6; // @[Expression.scala 2342:18]
  assign win_data_175 = 8'hb3; // @[Expression.scala 2342:18]
  assign win_data_176 = 8'hb0; // @[Expression.scala 2342:18]
  assign win_data_177 = 8'had; // @[Expression.scala 2342:18]
  assign win_data_178 = 8'haa; // @[Expression.scala 2342:18]
  assign win_data_179 = 8'ha7; // @[Expression.scala 2342:18]
  assign win_data_180 = 8'ha5; // @[Expression.scala 2342:18]
  assign win_data_181 = 8'ha2; // @[Expression.scala 2342:18]
  assign win_data_182 = 8'h9e; // @[Expression.scala 2342:18]
  assign win_data_183 = 8'h9b; // @[Expression.scala 2342:18]
  assign win_data_184 = 8'h98; // @[Expression.scala 2342:18]
  assign win_data_185 = 8'h95; // @[Expression.scala 2342:18]
  assign win_data_186 = 8'h92; // @[Expression.scala 2342:18]
  assign win_data_187 = 8'h8f; // @[Expression.scala 2342:18]
  assign win_data_188 = 8'h8c; // @[Expression.scala 2342:18]
  assign win_data_189 = 8'h89; // @[Expression.scala 2342:18]
  assign win_data_190 = 8'h86; // @[Expression.scala 2342:18]
  assign win_data_191 = 8'h83; // @[Expression.scala 2342:18]
  assign win_data_192 = 8'h80; // @[Expression.scala 2342:18]
  assign win_data_193 = 8'h7c; // @[Expression.scala 2342:18]
  assign win_data_194 = 8'h79; // @[Expression.scala 2342:18]
  assign win_data_195 = 8'h76; // @[Expression.scala 2342:18]
  assign win_data_196 = 8'h73; // @[Expression.scala 2342:18]
  assign win_data_197 = 8'h70; // @[Expression.scala 2342:18]
  assign win_data_198 = 8'h6d; // @[Expression.scala 2342:18]
  assign win_data_199 = 8'h6a; // @[Expression.scala 2342:18]
  assign win_data_200 = 8'h67; // @[Expression.scala 2342:18]
  assign win_data_201 = 8'h64; // @[Expression.scala 2342:18]
  assign win_data_202 = 8'h61; // @[Expression.scala 2342:18]
  assign win_data_203 = 8'h5d; // @[Expression.scala 2342:18]
  assign win_data_204 = 8'h5a; // @[Expression.scala 2342:18]
  assign win_data_205 = 8'h58; // @[Expression.scala 2342:18]
  assign win_data_206 = 8'h55; // @[Expression.scala 2342:18]
  assign win_data_207 = 8'h52; // @[Expression.scala 2342:18]
  assign win_data_208 = 8'h4f; // @[Expression.scala 2342:18]
  assign win_data_209 = 8'h4c; // @[Expression.scala 2342:18]
  assign win_data_210 = 8'h49; // @[Expression.scala 2342:18]
  assign win_data_211 = 8'h46; // @[Expression.scala 2342:18]
  assign win_data_212 = 8'h43; // @[Expression.scala 2342:18]
  assign win_data_213 = 8'h41; // @[Expression.scala 2342:18]
  assign win_data_214 = 8'h3e; // @[Expression.scala 2342:18]
  assign win_data_215 = 8'h3b; // @[Expression.scala 2342:18]
  assign win_data_216 = 8'h39; // @[Expression.scala 2342:18]
  assign win_data_217 = 8'h36; // @[Expression.scala 2342:18]
  assign win_data_218 = 8'h34; // @[Expression.scala 2342:18]
  assign win_data_219 = 8'h31; // @[Expression.scala 2342:18]
  assign win_data_220 = 8'h2f; // @[Expression.scala 2342:18]
  assign win_data_221 = 8'h2c; // @[Expression.scala 2342:18]
  assign win_data_222 = 8'h2a; // @[Expression.scala 2342:18]
  assign win_data_223 = 8'h28; // @[Expression.scala 2342:18]
  assign win_data_224 = 8'h25; // @[Expression.scala 2342:18]
  assign win_data_225 = 8'h23; // @[Expression.scala 2342:18]
  assign win_data_226 = 8'h21; // @[Expression.scala 2342:18]
  assign win_data_227 = 8'h1f; // @[Expression.scala 2342:18]
  assign win_data_228 = 8'h1d; // @[Expression.scala 2342:18]
  assign win_data_229 = 8'h1b; // @[Expression.scala 2342:18]
  assign win_data_230 = 8'h19; // @[Expression.scala 2342:18]
  assign win_data_231 = 8'h17; // @[Expression.scala 2342:18]
  assign win_data_232 = 8'h15; // @[Expression.scala 2342:18]
  assign win_data_233 = 8'h14; // @[Expression.scala 2342:18]
  assign win_data_234 = 8'h12; // @[Expression.scala 2342:18]
  assign win_data_235 = 8'h11; // @[Expression.scala 2342:18]
  assign win_data_236 = 8'h0f; // @[Expression.scala 2342:18]
  assign win_data_237 = 8'h0e; // @[Expression.scala 2342:18]
  assign win_data_238 = 8'h0c; // @[Expression.scala 2342:18]
  assign win_data_239 = 8'h0b; // @[Expression.scala 2342:18]
  assign win_data_240 = 8'h0a; // @[Expression.scala 2342:18]
  assign win_data_241 = 8'h09; // @[Expression.scala 2342:18]
  assign win_data_242 = 8'h07; // @[Expression.scala 2342:18]
  assign win_data_243 = 8'h06; // @[Expression.scala 2342:18]
  assign win_data_244 = 8'h05; // @[Expression.scala 2342:18]
  assign win_data_245 = 8'h05; // @[Expression.scala 2342:18]
  assign win_data_246 = 8'h04; // @[Expression.scala 2342:18]
  assign win_data_247 = 8'h03; // @[Expression.scala 2342:18]
  assign win_data_248 = 8'h02; // @[Expression.scala 2342:18]
  assign win_data_249 = 8'h02; // @[Expression.scala 2342:18]
  assign win_data_250 = 8'h01; // @[Expression.scala 2342:18]
  assign win_data_251 = 8'h01; // @[Expression.scala 2342:18]
  assign win_data_252 = 8'h01; // @[Expression.scala 2342:18]
  assign win_data_253 = 8'h0; // @[Expression.scala 2342:18]
  assign win_data_254 = 8'h0; // @[Expression.scala 2342:18]
  assign win_data_255 = 8'h0; // @[Expression.scala 2342:18]
  assign win = tmp_win; // @[win_rom.scala 26:10]

endmodule

module RoundandSat_4 (
  input      [28:0]   din,
  output     [15:0]   dout
);

  wire       [29:0]   tmp_tmp_dataOut_5;
  wire       [29:0]   tmp_tmp_dataOut_5_1;
  wire       [7:0]    tmp_when;
  wire       [21:0]   tmp_tmp_dataOut_7;
  wire       [21:0]   tmp_tmp_dataOut_7_1;
  wire       [29:0]   tmp_tmp_dataOut_1;
  wire       [29:0]   tmp_tmp_dataOut_1_1;
  wire       [29:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  wire       [5:0]    tmp_when_3;
  wire       [4:0]    tmp_when_4;
  (* keep *) wire       [15:0]   dataOut;
  wire       [28:0]   tmp_dataOut;
  reg        [21:0]   tmp_dataOut_1;
  wire       [28:0]   tmp_dataOut_2;
  wire       [28:0]   tmp_dataOut_3;
  wire       [28:0]   tmp_dataOut_4;
  wire       [29:0]   tmp_dataOut_5;
  wire       [28:0]   tmp_dataOut_6;
  reg        [21:0]   tmp_dataOut_7;
  reg        [20:0]   tmp_dataOut_8;
  reg        [15:0]   tmp_dataOut_9;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[28],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[28],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[7 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[29 : 8];
  assign tmp_tmp_dataOut_7_1 = 22'h000001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[28],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[28],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[21 : 20];
  assign tmp_when_2 = tmp_dataOut_1[20 : 20];
  assign tmp_when_3 = tmp_dataOut_8[20 : 15];
  assign tmp_when_4 = tmp_dataOut_8[19 : 15];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{21'h0,1'b1},7'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {22'h3fffff,7'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[28 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[28 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[29 : 8]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[29]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 8); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_1[21]) begin
      if((! (&tmp_when_1))) begin
        tmp_dataOut_8 = 21'h100000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[20 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_dataOut_8 = 21'h0fffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[20 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    if(tmp_dataOut_8[20]) begin
      if((! (&tmp_when_3))) begin
        tmp_dataOut_9 = 16'h8000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[15 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_dataOut_9 = 16'h7fff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[15 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign dataOut = tmp_dataOut_9; // @[RoundandSat.scala 22:13]
  assign dout = dataOut; // @[RoundandSat.scala 26:11]

endmodule

module Round2EvenSW (
  input      [63:0]   din,
  output     [31:0]   dout,
  input      [5:0]    right_shift
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
  assign signbit = din[63]; // @[BaseType.scala 305:24]
  assign din_abs = (tmp_din_abs + tmp_din_abs_2); // @[BaseType.scala 299:24]
  assign decimal_part = (din_abs & tmp_decimal_part); // @[BaseType.scala 299:24]
  assign decide_value = tmp_decide_value; // @[Round2EvenSW.scala 18:16]
  assign cond = (decimal_part == decimal_part); // @[BaseType.scala 305:24]
  assign result = (tmp_result + tmp_result_1); // @[Round2EvenSW.scala 21:10]
  assign result_clip = result[31 : 0]; // @[BaseType.scala 299:24]
  assign dout = tmp_dout; // @[Round2EvenSW.scala 24:11]

endmodule

module skipadd (
  input               start,
  output              end_1,
  input      [31:0]   rs1,
  input      [31:0]   rs2,
  input      [31:0]   rs3,
  input      [4:0]    rd_index,
  input      [127:0]  vs1,
  input      [127:0]  vs2,
  output              mul_start_out,
  output reg [31:0]   mul_pinA_out,
  output reg [31:0]   mul_pinB_out,
  input      [63:0]   mul_dout_in,
  input               mul_end_in,
  output     [7:0]    shift_out,
  output     [31:0]   skipadd_out,
  input               clk,
  input               resetn
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
  wire       [31:0]   tmp_skipadd_out;
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
  reg                 tmp_mul1_state_in_regNext;
  wire                mul1_state_in;
  wire                tmp_mul2_state_in;
  reg                 tmp_mul2_state_in_regNext;
  wire                mul2_state_in;
  wire                mul1_mul_end;
  wire                mul2_mul_end;

  assign tmp_offset1 = rs3[15 : 8];
  assign tmp_offset2 = rs3[23 : 16];
  assign tmp_skipadd_out = 32'h0;
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

  assign input_data1_vec_0 = vs1[7 : 0]; // @[BaseType.scala 299:24]
  assign input_data1_vec_1 = vs1[15 : 8]; // @[BaseType.scala 299:24]
  assign input_data1_vec_2 = vs1[23 : 16]; // @[BaseType.scala 299:24]
  assign input_data1_vec_3 = vs1[31 : 24]; // @[BaseType.scala 299:24]
  assign input_data1_vec_4 = vs1[39 : 32]; // @[BaseType.scala 299:24]
  assign input_data1_vec_5 = vs1[47 : 40]; // @[BaseType.scala 299:24]
  assign input_data1_vec_6 = vs1[55 : 48]; // @[BaseType.scala 299:24]
  assign input_data1_vec_7 = vs1[63 : 56]; // @[BaseType.scala 299:24]
  assign input_data1_vec_8 = vs1[71 : 64]; // @[BaseType.scala 299:24]
  assign input_data1_vec_9 = vs1[79 : 72]; // @[BaseType.scala 299:24]
  assign input_data1_vec_10 = vs1[87 : 80]; // @[BaseType.scala 299:24]
  assign input_data1_vec_11 = vs1[95 : 88]; // @[BaseType.scala 299:24]
  assign input_data1_vec_12 = vs1[103 : 96]; // @[BaseType.scala 299:24]
  assign input_data1_vec_13 = vs1[111 : 104]; // @[BaseType.scala 299:24]
  assign input_data1_vec_14 = vs1[119 : 112]; // @[BaseType.scala 299:24]
  assign input_data1_vec_15 = vs1[127 : 120]; // @[BaseType.scala 299:24]
  assign input_data2_vec_0 = vs2[7 : 0]; // @[BaseType.scala 299:24]
  assign input_data2_vec_1 = vs2[15 : 8]; // @[BaseType.scala 299:24]
  assign input_data2_vec_2 = vs2[23 : 16]; // @[BaseType.scala 299:24]
  assign input_data2_vec_3 = vs2[31 : 24]; // @[BaseType.scala 299:24]
  assign input_data2_vec_4 = vs2[39 : 32]; // @[BaseType.scala 299:24]
  assign input_data2_vec_5 = vs2[47 : 40]; // @[BaseType.scala 299:24]
  assign input_data2_vec_6 = vs2[55 : 48]; // @[BaseType.scala 299:24]
  assign input_data2_vec_7 = vs2[63 : 56]; // @[BaseType.scala 299:24]
  assign input_data2_vec_8 = vs2[71 : 64]; // @[BaseType.scala 299:24]
  assign input_data2_vec_9 = vs2[79 : 72]; // @[BaseType.scala 299:24]
  assign input_data2_vec_10 = vs2[87 : 80]; // @[BaseType.scala 299:24]
  assign input_data2_vec_11 = vs2[95 : 88]; // @[BaseType.scala 299:24]
  assign input_data2_vec_12 = vs2[103 : 96]; // @[BaseType.scala 299:24]
  assign input_data2_vec_13 = vs2[111 : 104]; // @[BaseType.scala 299:24]
  assign input_data2_vec_14 = vs2[119 : 112]; // @[BaseType.scala 299:24]
  assign input_data2_vec_15 = vs2[127 : 120]; // @[BaseType.scala 299:24]
  assign input_data1_val = {1'b0,tmp_input_data1_val}; // @[BaseType.scala 299:24]
  assign input_data2_val = {1'b0,tmp_input_data2_val}; // @[BaseType.scala 299:24]
  assign offset1 = {1'd0, tmp_offset1}; // @[BaseType.scala 299:24]
  assign offset2 = {1'd0, tmp_offset2}; // @[BaseType.scala 299:24]
  assign shift_out = rs3[7 : 0]; // @[skipadd.scala 42:16]
  assign tmp_mul1_state_in = (curr_state == MUL1); // @[BaseType.scala 305:24]
  assign mul1_state_in = (tmp_mul1_state_in && (! tmp_mul1_state_in_regNext)); // @[BaseType.scala 305:24]
  assign tmp_mul2_state_in = (curr_state == MUL2); // @[BaseType.scala 305:24]
  assign mul2_state_in = (tmp_mul2_state_in && (! tmp_mul2_state_in_regNext)); // @[BaseType.scala 305:24]
  assign mul1_mul_end = ((curr_state == MUL1) && mul_end_in); // @[BaseType.scala 305:24]
  assign mul2_mul_end = ((curr_state == MUL2) && mul_end_in); // @[BaseType.scala 305:24]
  assign mul_start_out = (mul1_state_in || mul2_state_in); // @[skipadd.scala 54:20]
  assign end_1 = (curr_state == ADD); // @[skipadd.scala 55:10]
  assign skipadd_out = (end_1 ? sum_reg : tmp_skipadd_out); // @[skipadd.scala 56:18]
  always @(*) begin
    next_state = curr_state; // @[skipadd.scala 64:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = MUL1; // @[Enum.scala 148:67]
        end
      end
      MUL1 : begin
        if(mul_end_in) begin
          next_state = MUL2; // @[Enum.scala 148:67]
        end
      end
      MUL2 : begin
        if(mul_end_in) begin
          next_state = ADD; // @[Enum.scala 148:67]
        end
      end
      default : begin
        next_state = IDLE; // @[Enum.scala 148:67]
      end
    endcase
  end

  always @(*) begin
    mul_pinA_out = 32'h0; // @[skipadd.scala 86:19]
    case(curr_state)
      MUL1 : begin
        mul_pinA_out = {{23{tmp_mul_pinA_out[8]}}, tmp_mul_pinA_out}; // @[skipadd.scala 90:23]
      end
      MUL2 : begin
        mul_pinA_out = {{23{tmp_mul_pinA_out_3[8]}}, tmp_mul_pinA_out_3}; // @[skipadd.scala 94:23]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mul_pinB_out = 32'h0; // @[skipadd.scala 87:19]
    case(curr_state)
      MUL1 : begin
        mul_pinB_out = rs1; // @[skipadd.scala 91:23]
      end
      MUL2 : begin
        mul_pinB_out = rs2; // @[skipadd.scala 95:23]
      end
      default : begin
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      sum_reg <= 32'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      if(mul1_mul_end) begin
        sum_reg <= mul_dout_in[31 : 0]; // @[skipadd.scala 59:13]
      end else begin
        if(mul2_mul_end) begin
          sum_reg <= ($signed(tmp_sum_reg) + $signed(sum_reg)); // @[skipadd.scala 61:13]
        end
      end
    end
  end

  always @(posedge clk) begin
    tmp_mul1_state_in_regNext <= tmp_mul1_state_in; // @[Reg.scala 39:30]
    tmp_mul2_state_in_regNext <= tmp_mul2_state_in; // @[Reg.scala 39:30]
  end


endmodule

module restoring_div_radix4 (
  input               din_vld,
  input      [15:0]   dinA,
  input      [7:0]    dinB,
  output              dout_vld,
  output     [16:0]   quot,
  output     [7:0]    remainder,
  input               clk,
  input               resetn
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
  assign sign_out = (dinA[15] ^ dinB[7]); // @[restoring_div_radix4.scala 21:11]
  assign dinA_abs = (tmp_dinA_abs + tmp_dinA_abs_2); // @[restoring_div_radix4.scala 24:11]
  assign dinB_abs = (tmp_dinB_abs + tmp_dinB_abs_2); // @[restoring_div_radix4.scala 25:11]
  assign p_r_shift = (p_remainder <<< 2); // @[BaseType.scala 299:24]
  assign p_r_calpart = p_r_shift[25 : 16]; // @[restoring_div_radix4.scala 47:13]
  assign p_r_minus_d = tmp_p_r_minus_d; // @[restoring_div_radix4.scala 48:13]
  assign p_r_minus_2d = tmp_p_r_minus_2d; // @[restoring_div_radix4.scala 49:14]
  assign p_r_minus_3d = tmp_p_r_minus_3d; // @[restoring_div_radix4.scala 50:14]
  assign deside_bits = {{p_r_minus_d[9],p_r_minus_2d[9]},p_r_minus_3d[9]}; // @[BaseType.scala 299:24]
  always @(*) begin
    case(deside_bits)
      3'b000 : begin
        p_r_part_next = p_r_minus_3d; // @[restoring_div_radix4.scala 56:23]
      end
      3'b001 : begin
        p_r_part_next = p_r_minus_2d; // @[restoring_div_radix4.scala 60:23]
      end
      3'b010, 3'b011 : begin
        p_r_part_next = p_r_minus_d; // @[restoring_div_radix4.scala 64:23]
      end
      default : begin
        p_r_part_next = p_r_calpart; // @[restoring_div_radix4.scala 69:23]
      end
    endcase
  end

  always @(*) begin
    case(deside_bits)
      3'b000 : begin
        quot_updata_bits = 2'b11; // @[restoring_div_radix4.scala 57:26]
      end
      3'b001 : begin
        quot_updata_bits = 2'b10; // @[restoring_div_radix4.scala 61:26]
      end
      3'b010, 3'b011 : begin
        quot_updata_bits = 2'b01; // @[restoring_div_radix4.scala 65:26]
      end
      default : begin
        quot_updata_bits = 2'b00; // @[restoring_div_radix4.scala 70:26]
      end
    endcase
  end

  assign finish_pulse = (control_cnt == 3'b111); // @[BaseType.scala 305:24]
  assign remainder_abs = p_remainder[23 : 16]; // @[BaseType.scala 299:24]
  assign remainder = (dinB[7] ? tmp_remainder : tmp_remainder_2); // @[restoring_div_radix4.scala 110:14]
  assign quot = (sign_out ? tmp_quot : tmp_quot_2); // @[restoring_div_radix4.scala 111:9]
  assign dout_vld = finish_pulse_regNext; // @[restoring_div_radix4.scala 112:13]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      quotient <= 16'h0; // @[Data.scala 400:33]
      divisior <= 10'h0; // @[Data.scala 400:33]
      p_remainder <= 26'h0; // @[Data.scala 400:33]
      control_cnt <= 3'b000; // @[Data.scala 400:33]
      doing <= 1'b0; // @[Data.scala 400:33]
      finish_pulse_regNext <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(din_vld) begin
        divisior <= {2'd0, tmp_divisior}; // @[restoring_div_radix4.scala 34:14]
      end
      if(din_vld) begin
        doing <= 1'b1; // @[Bool.scala 88:26]
      end else begin
        if(finish_pulse) begin
          doing <= 1'b0; // @[Bool.scala 90:28]
        end
      end
      if(din_vld) begin
        control_cnt <= 3'b000; // @[restoring_div_radix4.scala 84:17]
      end else begin
        if(doing) begin
          control_cnt <= (control_cnt + 3'b001); // @[restoring_div_radix4.scala 86:17]
        end else begin
          if(finish_pulse) begin
            control_cnt <= 3'b000; // @[restoring_div_radix4.scala 88:17]
          end
        end
      end
      if(din_vld) begin
        p_remainder <= {10'h0,dinA_abs}; // @[restoring_div_radix4.scala 92:17]
      end else begin
        if(doing) begin
          p_remainder <= {p_r_part_next,p_r_shift[15 : 0]}; // @[restoring_div_radix4.scala 94:17]
        end
      end
      if(din_vld) begin
        quotient[15 : 14] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b000)) begin
            quotient[15 : 14] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[13 : 12] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b001)) begin
            quotient[13 : 12] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[11 : 10] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b010)) begin
            quotient[11 : 10] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[9 : 8] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b011)) begin
            quotient[9 : 8] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[7 : 6] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b100)) begin
            quotient[7 : 6] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[5 : 4] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b101)) begin
            quotient[5 : 4] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[3 : 2] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b110)) begin
            quotient[3 : 2] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[1 : 0] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b111)) begin
            quotient[1 : 0] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      finish_pulse_regNext <= finish_pulse; // @[Reg.scala 39:30]
    end
  end


endmodule

module booth4_2 (
  input               io_din_vld,
  input      [31:0]   io_dinA,
  input      [31:0]   io_dinB,
  output              io_dout_vld,
  output              io_cal_finish,
  output     [63:0]   io_dout,
  input               clk,
  input               resetn
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
  assign flag_bits = shiftReg[2 : 0]; // @[booth4.scala 38:13]
  assign NegativeB = (- PositiveB); // @[booth4.scala 39:13]
  assign PositiveB = {{2{Breg[31]}}, Breg}; // @[booth4.scala 40:13]
  assign Negative2B = (NegativeB <<< 1); // @[booth4.scala 41:14]
  assign Positive2B = (PositiveB <<< 1); // @[booth4.scala 42:14]
  assign shiftReg_low = shiftReg[32 : 0]; // @[booth4.scala 46:16]
  assign shiftReg_high = shiftReg[66 : 33]; // @[booth4.scala 47:17]
  assign AddB = ($signed(shiftReg_high) + $signed(PositiveB)); // @[booth4.scala 49:8]
  assign Add2B = ($signed(shiftReg_high) + $signed(Positive2B)); // @[booth4.scala 50:9]
  assign MinusB = ($signed(shiftReg_high) + $signed(NegativeB)); // @[booth4.scala 51:10]
  assign Minus2B = ($signed(shiftReg_high) + $signed(Negative2B)); // @[booth4.scala 52:11]
  assign cal_cnt_ov_flag = (cal_cnt == 4'b1111); // @[BaseType.scala 305:24]
  assign io_cal_finish = (cal_cnt_ov_flag && cal_en); // @[booth4.scala 55:17]
  always @(*) begin
    case(flag_bits)
      3'b000, 3'b111 : begin
        beforeshift = shiftReg_high; // @[booth4.scala 71:19]
      end
      3'b001, 3'b010 : begin
        beforeshift = AddB; // @[booth4.scala 74:20]
      end
      3'b101, 3'b110 : begin
        beforeshift = MinusB; // @[booth4.scala 77:20]
      end
      3'b011 : begin
        beforeshift = Add2B; // @[booth4.scala 80:20]
      end
      default : begin
        beforeshift = Minus2B; // @[booth4.scala 83:20]
      end
    endcase
  end

  assign aftershift = tmp_aftershift; // @[booth4.scala 86:14]
  assign io_dout_vld = ((! cal_en) && cal_en_regNext); // @[booth4.scala 99:15]
  assign io_dout = shiftReg[64 : 1]; // @[booth4.scala 100:11]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      Breg <= 32'h0; // @[Data.scala 400:33]
      shiftReg <= 67'h0; // @[Data.scala 400:33]
      cal_cnt <= 4'b0000; // @[Data.scala 400:33]
      cal_en <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(io_din_vld) begin
        cal_en <= 1'b1; // @[booth4.scala 58:12]
      end else begin
        if(cal_cnt_ov_flag) begin
          cal_en <= 1'b0; // @[booth4.scala 60:12]
        end
      end
      if(cal_en) begin
        cal_cnt <= (cal_cnt + 4'b0001); // @[booth4.scala 63:13]
      end else begin
        if(io_din_vld) begin
          cal_cnt <= 4'b0000; // @[booth4.scala 65:13]
        end
      end
      if(io_din_vld) begin
        shiftReg <= {{34'h0,io_dinA},1'b0}; // @[booth4.scala 93:14]
        Breg <= io_dinB; // @[booth4.scala 94:14]
      end else begin
        if(cal_en) begin
          shiftReg <= aftershift; // @[booth4.scala 96:14]
        end
      end
    end
  end

  always @(posedge clk) begin
    cal_en_regNext <= cal_en; // @[Reg.scala 39:30]
  end


endmodule

module AdderWithSub_1cycle (
  input               sub_en,
  input      [31:0]   dinA,
  input      [31:0]   dinB,
  output     [31:0]   dout
);

  wire       [31:0]   tmp_dinB_tmp;
  wire       [31:0]   tmp_dinB_tmp_1;
  wire       [31:0]   tmp_dinB_tmp_2;
  wire       [31:0]   dinB_tmp;

  assign tmp_dinB_tmp = ($signed(tmp_dinB_tmp_1) + $signed(tmp_dinB_tmp_2));
  assign tmp_dinB_tmp_1 = (~ dinB);
  assign tmp_dinB_tmp_2 = 32'h00000001;
  assign dinB_tmp = (sub_en ? tmp_dinB_tmp : dinB); // @[Expression.scala 1420:25]
  assign dout = ($signed(dinA) + $signed(dinB_tmp)); // @[AdderWithSub_1cycle.scala 18:11]

endmodule

module adder_1cycle (
  input      [19:0]   dinA,
  input      [19:0]   dinB,
  output     [20:0]   dout
);

  wire       [20:0]   tmp_dout;
  wire       [20:0]   tmp_dout_1;

  assign tmp_dout = {dinA[19],dinA};
  assign tmp_dout_1 = {dinB[19],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1)); // @[adder_1cycle.scala 17:11]

endmodule

//adder_1cycle_2 replaced by adder_1cycle_2

module adder_1cycle_2 (
  input      [18:0]   dinA,
  input      [18:0]   dinB,
  output     [19:0]   dout
);

  wire       [19:0]   tmp_dout;
  wire       [19:0]   tmp_dout_1;

  assign tmp_dout = {dinA[18],dinA};
  assign tmp_dout_1 = {dinB[18],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1)); // @[adder_1cycle.scala 17:11]

endmodule

//adder_1cycle_6 replaced by adder_1cycle_6

//adder_1cycle_6 replaced by adder_1cycle_6

//adder_1cycle_6 replaced by adder_1cycle_6

module adder_1cycle_6 (
  input      [17:0]   dinA,
  input      [17:0]   dinB,
  output     [18:0]   dout
);

  wire       [18:0]   tmp_dout;
  wire       [18:0]   tmp_dout_1;

  assign tmp_dout = {dinA[17],dinA};
  assign tmp_dout_1 = {dinB[17],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1)); // @[adder_1cycle.scala 17:11]

endmodule

//adder_1cycle_14 replaced by adder_1cycle_14

//adder_1cycle_14 replaced by adder_1cycle_14

//adder_1cycle_14 replaced by adder_1cycle_14

//adder_1cycle_14 replaced by adder_1cycle_14

//adder_1cycle_14 replaced by adder_1cycle_14

//adder_1cycle_14 replaced by adder_1cycle_14

//adder_1cycle_14 replaced by adder_1cycle_14

module adder_1cycle_14 (
  input      [16:0]   dinA,
  input      [16:0]   dinB,
  output     [17:0]   dout
);

  wire       [17:0]   tmp_dout;
  wire       [17:0]   tmp_dout_1;

  assign tmp_dout = {dinA[16],dinA};
  assign tmp_dout_1 = {dinB[16],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1)); // @[adder_1cycle.scala 17:11]

endmodule

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

//mul_1cycle_15 replaced by mul_1cycle_15

module mul_1cycle_15 (
  input      [8:0]    dinA,
  input      [7:0]    dinB,
  output     [16:0]   dout
);


  assign dout = ($signed(dinA) * $signed(dinB)); // @[mul_1cycle.scala 17:11]

endmodule

//RoundandSat_6 replaced by RoundandSat_6

module RoundandSat_6 (
  input      [33:0]   din,
  output     [15:0]   dout
);

  wire       [34:0]   tmp_tmp_dataOut_5;
  wire       [34:0]   tmp_tmp_dataOut_5_1;
  wire       [9:0]    tmp_when;
  wire       [24:0]   tmp_tmp_dataOut_7;
  wire       [24:0]   tmp_tmp_dataOut_7_1;
  wire       [34:0]   tmp_tmp_dataOut_1;
  wire       [34:0]   tmp_tmp_dataOut_1_1;
  wire       [34:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  wire       [8:0]    tmp_when_3;
  wire       [7:0]    tmp_when_4;
  (* keep *) wire       [15:0]   dataOut;
  wire       [33:0]   tmp_dataOut;
  reg        [24:0]   tmp_dataOut_1;
  wire       [33:0]   tmp_dataOut_2;
  wire       [33:0]   tmp_dataOut_3;
  wire       [33:0]   tmp_dataOut_4;
  wire       [34:0]   tmp_dataOut_5;
  wire       [33:0]   tmp_dataOut_6;
  reg        [24:0]   tmp_dataOut_7;
  reg        [23:0]   tmp_dataOut_8;
  reg        [15:0]   tmp_dataOut_9;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[33],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[33],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[9 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[34 : 10];
  assign tmp_tmp_dataOut_7_1 = 25'h0000001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[33],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[33],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[24 : 23];
  assign tmp_when_2 = tmp_dataOut_1[23 : 23];
  assign tmp_when_3 = tmp_dataOut_8[23 : 15];
  assign tmp_when_4 = tmp_dataOut_8[22 : 15];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{24'h0,1'b1},9'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {25'h1ffffff,9'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[33 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[33 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[34 : 10]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[34]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 10); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_1[24]) begin
      if((! (&tmp_when_1))) begin
        tmp_dataOut_8 = 24'h800000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[23 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_dataOut_8 = 24'h7fffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[23 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    if(tmp_dataOut_8[23]) begin
      if((! (&tmp_when_3))) begin
        tmp_dataOut_9 = 16'h8000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[15 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_dataOut_9 = 16'h7fff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[15 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign dataOut = tmp_dataOut_9; // @[RoundandSat.scala 22:13]
  assign dout = dataOut; // @[RoundandSat.scala 26:11]

endmodule

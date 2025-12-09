// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : fdt_ctrl

`timescale 1ns/1ps 
module fdt_ctrl (
  input  wire          clk_sys,
  input  wire          rstn_sys,
  input  wire          clk_80m,
  input  wire          rstn_80m,
  input  wire          scan_mode,
  input  wire          fdt_sampling,
  input  wire          fdt_adc_in_mode,
  input  wire          fdt_adc_in_vld,
  input  wire [11:0]   fdt_adc_in_0,
  input  wire [11:0]   fdt_adc_in_1,
  input  wire [4:0]    fdt_therm_comp_one_hot,
  input  wire          rg_fdt_en,
  input  wire          rg_fdt_init_seq,
  input  wire [2:0]    rg_fdt_area_en_one_hot,
  input  wire          rg_fdt_detect_mode,
  input  wire          rg_fdt_wait_up,
  input  wire          rg_fdt_wait_down,
  input  wire          rg_fdt_wait_heavy,
  input  wire          rg_fdt_auto_exit_en,
  input  wire          rg_fdt_heavy_auto_exit_en,
  input  wire          rg_fdt_pre_proc_ckgt_sw_en,
  input  wire          rg_fdt_rnn_ckgt_sw_en,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_0,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_1,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_2,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_3,
  input  wire [2:0]    rg_amp_therm_comp_amp_ratio_4,
  input  wire [2:0]    rg_amp_data_ratio,
  input  wire [8:0]    rg_amp_downsamp_row_onehot,
  input  wire [3:0]    rg_amp_sample_num,
  input  wire [2:0]    rg_norm_mean_pad_smp_num_log2,
  input  wire [6:0]    rg_norm_mean_base_addr,
  input  wire [2:0]    rg_norm_mean_num_log2,
  input  wire [10:0]   rg_norm_cali_base_0,
  input  wire [10:0]   rg_norm_cali_base_1,
  input  wire [10:0]   rg_norm_cali_base_2,
  input  wire [10:0]   rg_norm_cali_touch_0,
  input  wire [10:0]   rg_norm_cali_touch_1,
  input  wire [10:0]   rg_norm_cali_touch_2,
  input  wire [2:0]    rg_nn_data_ratio,
  input  wire [0:0]    rg_nn_layer_num,
  input  wire [6:0]    rg_nn_input_base_addr,
  input  wire [6:0]    rg_nn_cache_ofmap_base_addr,
  input  wire [2:0]    rg_nn_ifmap_groupnum,
  input  wire [2:0]    rg_nn_hidden_groupnum_layer_0,
  input  wire [2:0]    rg_nn_hidden_groupnum_layer_1,
  input  wire [9:0]    rg_nn_bias_addr_layer_0,
  input  wire [9:0]    rg_nn_bias_addr_layer_1,
  input  wire [9:0]    rg_nn_whi_addr_layer_0,
  input  wire [9:0]    rg_nn_whi_addr_layer_1,
  input  wire [9:0]    rg_nn_whh_addr_layer_0,
  input  wire [9:0]    rg_nn_whh_addr_layer_1,
  input  wire [9:0]    rg_nn_fc_bias_addr,
  input  wire [9:0]    rg_nn_fc_weight_addr,
  input  wire [9:0]    rg_nn_gate_w_bias_addr,
  input  wire [9:0]    rg_nn_gate_w_weight_addr,
  input  wire [9:0]    rg_nn_fcn1_bias_addr,
  input  wire [9:0]    rg_nn_fcn1_weight_addr,
  input  wire [9:0]    rg_nn_fcn2_bias_addr,
  input  wire [9:0]    rg_nn_fcn2_weight_addr,
  input  wire [1:0]    rg_nn_label_num,
  input  wire          rg_label_seq_en,
  input  wire [2:0]    rg_label_seq_length,
  input  wire [1:0]    rg_label_Updown_TH,
  input  wire [1:0]    rg_label_Heavy_TH,
  output reg           rg_fdt_result_up,
  output reg           rg_fdt_result_down,
  output reg           rg_fdt_result_Heavy,
  output wire          fdt_up_int,
  output wire          fdt_down_int,
  output wire          fdt_Heavy_int,
  output wire          fdt_auto_exit_pulse,
  output wire          fdt_done,
  output wire          nn_clk_en,
  output wire          cache_clk_sel,
  input  wire          fdtmem_rd,
  input  wire          fdtmem_wr,
  input  wire [15:0]   fdtmem_addr,
  input  wire [15:0]   fdtmem_wdata,
  output wire [15:0]   fdtmem_rdata,
  output reg           cache_ena,
  output reg           cache_wena,
  output reg  [6:0]    cache_addr,
  output reg  [63:0]   cache_wdata,
  input  wire [63:0]   cache_rdata,
  output wire          coef_ena,
  output wire          coef_wena,
  output wire [9:0]    coef_addr,
  output wire [63:0]   coef_wdata,
  output wire [3:0]    coef_wsel,
  input  wire [63:0]   coef_rdata,
  input  wire [2:0]    rg_pre_mpx_sel,
  output wire          pre_mpx_pin_0,
  output wire          pre_mpx_pin_1,
  output wire          pre_mpx_pin_2,
  input  wire          resetn,
  input  wire          clk
);
  localparam FDTSTATE_IDLE = 2'd0;
  localparam FDTSTATE_NeuNet_WORK = 2'd1;
  localparam FDTSTATE_LABEL_DEC = 2'd2;

  wire                u_clk_icg_pre_proc_inner_enable;
  wire                amp_cal_unit_fdt_adc_in_vld;
  wire                u_clk_icg_rnn_inner_enable;
  wire       [6:0]    NN_layer_unit_rg_NN_input_base_addr;
  wire       [6:0]    NN_layer_unit_rg_NN_cache_ofmap_base_addr;
  wire       [9:0]    NN_layer_unit_rg_NN_bias_addr_layer_0;
  wire       [9:0]    NN_layer_unit_rg_NN_bias_addr_layer_1;
  wire       [9:0]    NN_layer_unit_rg_NN_whi_addr_layer_0;
  wire       [9:0]    NN_layer_unit_rg_NN_whi_addr_layer_1;
  wire       [9:0]    NN_layer_unit_rg_NN_whh_addr_layer_0;
  wire       [9:0]    NN_layer_unit_rg_NN_whh_addr_layer_1;
  wire       [9:0]    NN_layer_unit_rg_NN_fc_bias_addr;
  wire       [9:0]    NN_layer_unit_rg_NN_fc_weight_addr;
  wire       [9:0]    NN_layer_unit_rg_NN_gate_w_bias_addr;
  wire       [9:0]    NN_layer_unit_rg_NN_gate_w_weight_addr;
  wire       [9:0]    NN_layer_unit_rg_NN_fcn1_bias_addr;
  wire       [9:0]    NN_layer_unit_rg_NN_fcn1_weight_addr;
  wire       [9:0]    NN_layer_unit_rg_NN_fcn2_bias_addr;
  wire       [9:0]    NN_layer_unit_rg_NN_fcn2_weight_addr;
  wire                NN_layer_unit_is_first_seq;
  wire       [63:0]   NN_layer_unit_coef_rdata;
  wire                u_clk_icg_pre_proc_inner_clkout;
  wire                amp_cal_unit_iq_ready_pulse;
  wire                amp_cal_unit_amp_cal_end;
  wire       [10:0]   amp_cal_unit_amp_mean_0;
  wire       [10:0]   amp_cal_unit_amp_mean_1;
  wire       [10:0]   amp_cal_unit_amp_mean_2;
  wire                amp_cal_unit_amp_mean_vld_0;
  wire                amp_cal_unit_amp_mean_vld_1;
  wire                amp_cal_unit_amp_mean_vld_2;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_0;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_1;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_2;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_3;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_4;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_5;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_6;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_7;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_8;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_9;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_10;
  wire       [11:0]   amp_cal_unit_smpArrayI_0_11;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_0;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_1;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_2;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_3;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_4;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_5;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_6;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_7;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_8;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_9;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_10;
  wire       [11:0]   amp_cal_unit_smpArrayI_1_11;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_0;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_1;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_2;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_3;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_4;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_5;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_6;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_7;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_8;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_9;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_10;
  wire       [11:0]   amp_cal_unit_smpArrayI_2_11;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_0;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_1;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_2;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_3;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_4;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_5;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_6;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_7;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_8;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_9;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_10;
  wire       [11:0]   amp_cal_unit_smpArrayQ_0_11;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_0;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_1;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_2;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_3;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_4;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_5;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_6;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_7;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_8;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_9;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_10;
  wire       [11:0]   amp_cal_unit_smpArrayQ_1_11;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_0;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_1;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_2;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_3;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_4;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_5;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_6;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_7;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_8;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_9;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_10;
  wire       [11:0]   amp_cal_unit_smpArrayQ_2_11;
  wire                norm_unit_samp_done;
  wire                norm_unit_norm_done;
  wire                norm_unit_norm_done_20M;
  wire                norm_unit_cache_ena;
  wire                norm_unit_cache_wena;
  wire       [6:0]    norm_unit_cache_addr;
  wire       [63:0]   norm_unit_cache_wdata;
  wire                u_clk_icg_rnn_inner_clkout;
  wire                NN_layer_unit_coef_ena;
  wire                NN_layer_unit_coef_wena;
  wire       [9:0]    NN_layer_unit_coef_addr;
  wire       [63:0]   NN_layer_unit_coef_wdata;
  wire                NN_layer_unit_cache_ena;
  wire                NN_layer_unit_cache_wena;
  wire       [6:0]    NN_layer_unit_cache_addr;
  wire       [63:0]   NN_layer_unit_cache_wdata;
  wire                NN_layer_unit_matmul_done_once;
  wire                NN_layer_unit_UpDown_label_result_vld;
  wire       [7:0]    NN_layer_unit_UpDown_label_result_0;
  wire       [7:0]    NN_layer_unit_UpDown_label_result_1;
  wire       [7:0]    NN_layer_unit_UpDown_label_result_2;
  wire                NN_layer_unit_Heavy_label_result_vld;
  wire       [15:0]   NN_layer_unit_Heavy_label_result_0;
  wire       [15:0]   NN_layer_unit_Heavy_label_result_1;
  wire       [15:0]   NN_layer_unit_Heavy_label_result_2;
  wire                NN_layer_unit_done;
  wire                label_unit_done;
  wire                label_unit_UpDown;
  wire                label_unit_Heavy;
  wire                fdt_pre_mpx_pre_mpx_pin_0;
  wire                fdt_pre_mpx_pre_mpx_pin_1;
  wire                fdt_pre_mpx_pre_mpx_pin_2;
  wire       [1:0]    tmp_area_roi_num;
  wire       [1:0]    tmp_area_roi_num_1;
  wire       [0:0]    tmp_area_roi_num_2;
  wire       [1:0]    tmp_area_roi_num_3;
  wire       [0:0]    tmp_area_roi_num_4;
  wire       [1:0]    tmp_area_roi_num_5;
  wire       [0:0]    tmp_area_roi_num_6;
  wire       [1:0]    tmp_rg_label_Updown_TH_1;
  wire       [1:0]    tmp_rg_label_Heavy_TH_1;
  wire       [6:0]    tmp_norm_base_addr_2;
  wire       [6:0]    tmp_ofmap_base_addr_2;
  reg        [6:0]    tmp_rg_NN_input_base_addr;
  reg        [6:0]    tmp_rg_NN_cache_ofmap_base_addr;
  reg        [9:0]    tmp_rg_NN_bias_addr_layer_0;
  reg        [9:0]    tmp_rg_NN_bias_addr_layer_1;
  reg        [9:0]    tmp_rg_NN_whi_addr_layer_0;
  reg        [9:0]    tmp_rg_NN_whi_addr_layer_1;
  reg        [9:0]    tmp_rg_NN_whh_addr_layer_0;
  reg        [9:0]    tmp_rg_NN_whh_addr_layer_1;
  reg        [9:0]    tmp_rg_NN_fc_bias_addr;
  reg        [9:0]    tmp_rg_NN_fc_weight_addr;
  reg        [9:0]    tmp_rg_NN_gate_w_bias_addr;
  reg        [9:0]    tmp_rg_NN_gate_w_weight_addr;
  reg        [9:0]    tmp_rg_NN_fcn1_bias_addr;
  reg        [9:0]    tmp_rg_NN_fcn1_weight_addr;
  reg        [9:0]    tmp_rg_NN_fcn2_bias_addr;
  reg        [9:0]    tmp_rg_NN_fcn2_weight_addr;
  reg                 tmp_is_first_seq;
  wire       [63:0]   tmp_wdata_sel;
  wire       [63:0]   tmp_wdata_sel_1;
  wire       [63:0]   tmp_wdata_sel_2;
  wire                fdt_samp;
  reg        [1:0]    curr_state;
  reg        [1:0]    next_state;
  wire                state_in_NN_work;
  wire                state_is_NN_work;
  wire                state_is_LAB_work;
  wire                state_in_nxt_area_NN_work;
  reg        [1:0]    area_cnt;
  wire                area_cnt_incr;
  wire                area_cnt_ov;
  wire                area_work_flag;
  wire                area_skip_flag;
  reg                 state_is_NN_work_regNext;
  wire                area_NN_start;
  reg                 label_seq_done_delay1;
  reg                 label_seq_done_delay2;
  wire                all_area_NN_done;
  reg                 area_is_not_first_seq_0;
  reg                 area_is_not_first_seq_1;
  reg                 area_is_not_first_seq_2;
  wire                area_is_first_seq_0;
  wire                area_is_first_seq_1;
  wire                area_is_first_seq_2;
  wire       [6:0]    norm_base_addr_0;
  wire       [6:0]    norm_base_addr_1;
  wire       [6:0]    norm_base_addr_2;
  wire       [6:0]    ofmap_base_addr_0;
  wire       [6:0]    ofmap_base_addr_1;
  wire       [6:0]    ofmap_base_addr_2;
  wire       [9:0]    area_bias_addr_lyer_0_0;
  wire       [9:0]    area_bias_addr_lyer_0_1;
  wire       [9:0]    area_bias_addr_lyer_1_0;
  wire       [9:0]    area_bias_addr_lyer_1_1;
  wire       [9:0]    area_bias_addr_lyer_2_0;
  wire       [9:0]    area_bias_addr_lyer_2_1;
  wire       [9:0]    area_whi_addr_layer_0_0;
  wire       [9:0]    area_whi_addr_layer_0_1;
  wire       [9:0]    area_whi_addr_layer_1_0;
  wire       [9:0]    area_whi_addr_layer_1_1;
  wire       [9:0]    area_whi_addr_layer_2_0;
  wire       [9:0]    area_whi_addr_layer_2_1;
  wire       [9:0]    area_whh_addr_layer_0_0;
  wire       [9:0]    area_whh_addr_layer_0_1;
  wire       [9:0]    area_whh_addr_layer_1_0;
  wire       [9:0]    area_whh_addr_layer_1_1;
  wire       [9:0]    area_whh_addr_layer_2_0;
  wire       [9:0]    area_whh_addr_layer_2_1;
  wire       [9:0]    area_fc_bias_addr_0;
  wire       [9:0]    area_fc_bias_addr_1;
  wire       [9:0]    area_fc_bias_addr_2;
  wire       [9:0]    area_fc_weight_addr_0;
  wire       [9:0]    area_fc_weight_addr_1;
  wire       [9:0]    area_fc_weight_addr_2;
  wire       [9:0]    area_gate_w_bias_addr_0;
  wire       [9:0]    area_gate_w_bias_addr_1;
  wire       [9:0]    area_gate_w_bias_addr_2;
  wire       [9:0]    area_gate_w_weight_addr_0;
  wire       [9:0]    area_gate_w_weight_addr_1;
  wire       [9:0]    area_gate_w_weight_addr_2;
  wire       [9:0]    area_fcn1_bias_addr_0;
  wire       [9:0]    area_fcn1_bias_addr_1;
  wire       [9:0]    area_fcn1_bias_addr_2;
  wire       [9:0]    area_fcn1_weight_addr_0;
  wire       [9:0]    area_fcn1_weight_addr_1;
  wire       [9:0]    area_fcn1_weight_addr_2;
  wire       [9:0]    area_fcn2_bias_addr_0;
  wire       [9:0]    area_fcn2_bias_addr_1;
  wire       [9:0]    area_fcn2_bias_addr_2;
  wire       [9:0]    area_fcn2_weight_addr_0;
  wire       [9:0]    area_fcn2_weight_addr_1;
  wire       [9:0]    area_fcn2_weight_addr_2;
  wire       [1:0]    area_roi_num;
  wire       [1:0]    rg_label_Updown_TH_1;
  wire       [1:0]    rg_label_Heavy_TH_1;
  reg                 fdt_init_seq_lock;
  reg                 fdt_samp_regNext;
  wire                fdt_init_seq_unlock;
  wire                fdt_init_seq_inter;
  wire                iq_ready_pulse;
  wire                pre_proc_end_pulse;
  wire                pre_proc_clk_en;
  reg                 pre_proc_en_reg;
  reg                 fdt_samp_regNext_1;
  wire                fdt_start_pulse_80m;
  reg                 fdt_adc_in_vld_dly;
  wire                tmp_pre_proc_end_pulse;
  reg                 tmp_pre_proc_end_pulse_1;
  wire                rnn_ck_en;
  reg                 rnn_cal_en_reg;
  wire                fdt_result_up_pulse;
  wire                fdt_result_down_pulse;
  wire                fdt_result_heavy_pulse;
  wire                tmp_fdt_up_int;
  reg                 tmp_fdt_up_int_1;
  reg                 tmp_fdt_up_int_2;
  reg                 tmp_fdt_up_int_3;
  wire                tmp_fdt_down_int;
  reg                 tmp_fdt_down_int_1;
  reg                 tmp_fdt_down_int_2;
  reg                 tmp_fdt_down_int_3;
  wire                tmp_fdt_Heavy_int;
  reg                 tmp_fdt_Heavy_int_1;
  reg                 tmp_fdt_Heavy_int_2;
  reg                 tmp_fdt_Heavy_int_3;
  wire                fdt_auto_exit_pulse_inter;
  wire                tmp_fdt_done;
  reg                 tmp_fdt_done_1;
  reg                 tmp_fdt_done_2;
  reg                 tmp_fdt_done_3;
  reg                 tmp_fdt_done_4;
  wire       [3:0]    tmp_1;
  reg                 fdt_auto_exit_pulse_inter_reg;
  wire       [11:0]   coef_addr_1;
  reg        [3:0]    bitsel;
  reg        [63:0]   wdata_sel;
  reg        [15:0]   rdata_sel;
  reg        [1:0]    coef_addr_low10bits_delay;
  wire       [15:0]   coef_rdata_slice_0;
  wire       [15:0]   coef_rdata_slice_1;
  wire       [15:0]   coef_rdata_slice_2;
  wire       [15:0]   coef_rdata_slice_3;
  `ifndef SYNTHESIS
  reg [87:0] curr_state_string;
  reg [87:0] next_state_string;
  `endif


  assign tmp_area_roi_num = (tmp_area_roi_num_1 + tmp_area_roi_num_3);
  assign tmp_area_roi_num_2 = rg_fdt_area_en_one_hot[0];
  assign tmp_area_roi_num_1 = {1'd0, tmp_area_roi_num_2};
  assign tmp_area_roi_num_4 = rg_fdt_area_en_one_hot[1];
  assign tmp_area_roi_num_3 = {1'd0, tmp_area_roi_num_4};
  assign tmp_area_roi_num_6 = rg_fdt_area_en_one_hot[2];
  assign tmp_area_roi_num_5 = {1'd0, tmp_area_roi_num_6};
  assign tmp_rg_label_Updown_TH_1 = (area_roi_num - 2'b01);
  assign tmp_rg_label_Heavy_TH_1 = (area_roi_num - 2'b01);
  assign tmp_norm_base_addr_2 = (rg_nn_input_base_addr + 7'h1c);
  assign tmp_ofmap_base_addr_2 = (rg_nn_cache_ofmap_base_addr + 7'h1c);
  assign tmp_wdata_sel = {48'd0, fdtmem_wdata};
  assign tmp_wdata_sel_1 = {48'd0, fdtmem_wdata};
  assign tmp_wdata_sel_2 = {48'd0, fdtmem_wdata};
  clkGate_func u_clk_icg_pre_proc_inner (
    .scan_en (scan_mode                      ), //i
    .enable  (u_clk_icg_pre_proc_inner_enable), //i
    .clkout  (u_clk_icg_pre_proc_inner_clkout), //o
    .clk_80m (clk_80m                        )  //i
  );
  amp_cal amp_cal_unit (
    .fdt_start_pulse               (fdt_start_pulse_80m               ), //i
    .fdt_adc_in_mode               (fdt_adc_in_mode                   ), //i
    .fdt_adc_in_vld                (amp_cal_unit_fdt_adc_in_vld       ), //i
    .fdt_adc_in_0                  (fdt_adc_in_0[11:0]                ), //i
    .fdt_adc_in_1                  (fdt_adc_in_1[11:0]                ), //i
    .fdt_therm_comp_one_hot        (fdt_therm_comp_one_hot[4:0]       ), //i
    .rg_amp_therm_comp_amp_ratio_0 (rg_amp_therm_comp_amp_ratio_0[2:0]), //i
    .rg_amp_therm_comp_amp_ratio_1 (rg_amp_therm_comp_amp_ratio_1[2:0]), //i
    .rg_amp_therm_comp_amp_ratio_2 (rg_amp_therm_comp_amp_ratio_2[2:0]), //i
    .rg_amp_therm_comp_amp_ratio_3 (rg_amp_therm_comp_amp_ratio_3[2:0]), //i
    .rg_amp_therm_comp_amp_ratio_4 (rg_amp_therm_comp_amp_ratio_4[2:0]), //i
    .rg_amp_data_ratio             (rg_amp_data_ratio[2:0]            ), //i
    .rg_amp_downsamp_row_onehot    (rg_amp_downsamp_row_onehot[8:0]   ), //i
    .rg_amp_sample_num             (rg_amp_sample_num[3:0]            ), //i
    .iq_ready_pulse                (amp_cal_unit_iq_ready_pulse       ), //o
    .amp_cal_end                   (amp_cal_unit_amp_cal_end          ), //o
    .amp_mean_0                    (amp_cal_unit_amp_mean_0[10:0]     ), //o
    .amp_mean_1                    (amp_cal_unit_amp_mean_1[10:0]     ), //o
    .amp_mean_2                    (amp_cal_unit_amp_mean_2[10:0]     ), //o
    .amp_mean_vld_0                (amp_cal_unit_amp_mean_vld_0       ), //o
    .amp_mean_vld_1                (amp_cal_unit_amp_mean_vld_1       ), //o
    .amp_mean_vld_2                (amp_cal_unit_amp_mean_vld_2       ), //o
    .smpArrayI_0_0                 (amp_cal_unit_smpArrayI_0_0[11:0]  ), //o
    .smpArrayI_0_1                 (amp_cal_unit_smpArrayI_0_1[11:0]  ), //o
    .smpArrayI_0_2                 (amp_cal_unit_smpArrayI_0_2[11:0]  ), //o
    .smpArrayI_0_3                 (amp_cal_unit_smpArrayI_0_3[11:0]  ), //o
    .smpArrayI_0_4                 (amp_cal_unit_smpArrayI_0_4[11:0]  ), //o
    .smpArrayI_0_5                 (amp_cal_unit_smpArrayI_0_5[11:0]  ), //o
    .smpArrayI_0_6                 (amp_cal_unit_smpArrayI_0_6[11:0]  ), //o
    .smpArrayI_0_7                 (amp_cal_unit_smpArrayI_0_7[11:0]  ), //o
    .smpArrayI_0_8                 (amp_cal_unit_smpArrayI_0_8[11:0]  ), //o
    .smpArrayI_0_9                 (amp_cal_unit_smpArrayI_0_9[11:0]  ), //o
    .smpArrayI_0_10                (amp_cal_unit_smpArrayI_0_10[11:0] ), //o
    .smpArrayI_0_11                (amp_cal_unit_smpArrayI_0_11[11:0] ), //o
    .smpArrayI_1_0                 (amp_cal_unit_smpArrayI_1_0[11:0]  ), //o
    .smpArrayI_1_1                 (amp_cal_unit_smpArrayI_1_1[11:0]  ), //o
    .smpArrayI_1_2                 (amp_cal_unit_smpArrayI_1_2[11:0]  ), //o
    .smpArrayI_1_3                 (amp_cal_unit_smpArrayI_1_3[11:0]  ), //o
    .smpArrayI_1_4                 (amp_cal_unit_smpArrayI_1_4[11:0]  ), //o
    .smpArrayI_1_5                 (amp_cal_unit_smpArrayI_1_5[11:0]  ), //o
    .smpArrayI_1_6                 (amp_cal_unit_smpArrayI_1_6[11:0]  ), //o
    .smpArrayI_1_7                 (amp_cal_unit_smpArrayI_1_7[11:0]  ), //o
    .smpArrayI_1_8                 (amp_cal_unit_smpArrayI_1_8[11:0]  ), //o
    .smpArrayI_1_9                 (amp_cal_unit_smpArrayI_1_9[11:0]  ), //o
    .smpArrayI_1_10                (amp_cal_unit_smpArrayI_1_10[11:0] ), //o
    .smpArrayI_1_11                (amp_cal_unit_smpArrayI_1_11[11:0] ), //o
    .smpArrayI_2_0                 (amp_cal_unit_smpArrayI_2_0[11:0]  ), //o
    .smpArrayI_2_1                 (amp_cal_unit_smpArrayI_2_1[11:0]  ), //o
    .smpArrayI_2_2                 (amp_cal_unit_smpArrayI_2_2[11:0]  ), //o
    .smpArrayI_2_3                 (amp_cal_unit_smpArrayI_2_3[11:0]  ), //o
    .smpArrayI_2_4                 (amp_cal_unit_smpArrayI_2_4[11:0]  ), //o
    .smpArrayI_2_5                 (amp_cal_unit_smpArrayI_2_5[11:0]  ), //o
    .smpArrayI_2_6                 (amp_cal_unit_smpArrayI_2_6[11:0]  ), //o
    .smpArrayI_2_7                 (amp_cal_unit_smpArrayI_2_7[11:0]  ), //o
    .smpArrayI_2_8                 (amp_cal_unit_smpArrayI_2_8[11:0]  ), //o
    .smpArrayI_2_9                 (amp_cal_unit_smpArrayI_2_9[11:0]  ), //o
    .smpArrayI_2_10                (amp_cal_unit_smpArrayI_2_10[11:0] ), //o
    .smpArrayI_2_11                (amp_cal_unit_smpArrayI_2_11[11:0] ), //o
    .smpArrayQ_0_0                 (amp_cal_unit_smpArrayQ_0_0[11:0]  ), //o
    .smpArrayQ_0_1                 (amp_cal_unit_smpArrayQ_0_1[11:0]  ), //o
    .smpArrayQ_0_2                 (amp_cal_unit_smpArrayQ_0_2[11:0]  ), //o
    .smpArrayQ_0_3                 (amp_cal_unit_smpArrayQ_0_3[11:0]  ), //o
    .smpArrayQ_0_4                 (amp_cal_unit_smpArrayQ_0_4[11:0]  ), //o
    .smpArrayQ_0_5                 (amp_cal_unit_smpArrayQ_0_5[11:0]  ), //o
    .smpArrayQ_0_6                 (amp_cal_unit_smpArrayQ_0_6[11:0]  ), //o
    .smpArrayQ_0_7                 (amp_cal_unit_smpArrayQ_0_7[11:0]  ), //o
    .smpArrayQ_0_8                 (amp_cal_unit_smpArrayQ_0_8[11:0]  ), //o
    .smpArrayQ_0_9                 (amp_cal_unit_smpArrayQ_0_9[11:0]  ), //o
    .smpArrayQ_0_10                (amp_cal_unit_smpArrayQ_0_10[11:0] ), //o
    .smpArrayQ_0_11                (amp_cal_unit_smpArrayQ_0_11[11:0] ), //o
    .smpArrayQ_1_0                 (amp_cal_unit_smpArrayQ_1_0[11:0]  ), //o
    .smpArrayQ_1_1                 (amp_cal_unit_smpArrayQ_1_1[11:0]  ), //o
    .smpArrayQ_1_2                 (amp_cal_unit_smpArrayQ_1_2[11:0]  ), //o
    .smpArrayQ_1_3                 (amp_cal_unit_smpArrayQ_1_3[11:0]  ), //o
    .smpArrayQ_1_4                 (amp_cal_unit_smpArrayQ_1_4[11:0]  ), //o
    .smpArrayQ_1_5                 (amp_cal_unit_smpArrayQ_1_5[11:0]  ), //o
    .smpArrayQ_1_6                 (amp_cal_unit_smpArrayQ_1_6[11:0]  ), //o
    .smpArrayQ_1_7                 (amp_cal_unit_smpArrayQ_1_7[11:0]  ), //o
    .smpArrayQ_1_8                 (amp_cal_unit_smpArrayQ_1_8[11:0]  ), //o
    .smpArrayQ_1_9                 (amp_cal_unit_smpArrayQ_1_9[11:0]  ), //o
    .smpArrayQ_1_10                (amp_cal_unit_smpArrayQ_1_10[11:0] ), //o
    .smpArrayQ_1_11                (amp_cal_unit_smpArrayQ_1_11[11:0] ), //o
    .smpArrayQ_2_0                 (amp_cal_unit_smpArrayQ_2_0[11:0]  ), //o
    .smpArrayQ_2_1                 (amp_cal_unit_smpArrayQ_2_1[11:0]  ), //o
    .smpArrayQ_2_2                 (amp_cal_unit_smpArrayQ_2_2[11:0]  ), //o
    .smpArrayQ_2_3                 (amp_cal_unit_smpArrayQ_2_3[11:0]  ), //o
    .smpArrayQ_2_4                 (amp_cal_unit_smpArrayQ_2_4[11:0]  ), //o
    .smpArrayQ_2_5                 (amp_cal_unit_smpArrayQ_2_5[11:0]  ), //o
    .smpArrayQ_2_6                 (amp_cal_unit_smpArrayQ_2_6[11:0]  ), //o
    .smpArrayQ_2_7                 (amp_cal_unit_smpArrayQ_2_7[11:0]  ), //o
    .smpArrayQ_2_8                 (amp_cal_unit_smpArrayQ_2_8[11:0]  ), //o
    .smpArrayQ_2_9                 (amp_cal_unit_smpArrayQ_2_9[11:0]  ), //o
    .smpArrayQ_2_10                (amp_cal_unit_smpArrayQ_2_10[11:0] ), //o
    .smpArrayQ_2_11                (amp_cal_unit_smpArrayQ_2_11[11:0] ), //o
    .clkout                        (u_clk_icg_pre_proc_inner_clkout   ), //i
    .rstn_80m                      (rstn_80m                          )  //i
  );
  normalizer norm_unit (
    .data_ratio                    (rg_nn_data_ratio[2:0]             ), //i
    .rg_norm_mean_pad_smp_num_log2 (rg_norm_mean_pad_smp_num_log2[2:0]), //i
    .rg_norm_mean_base_addr        (rg_norm_mean_base_addr[6:0]       ), //i
    .rg_norm_mean_num_log2         (rg_norm_mean_num_log2[2:0]        ), //i
    .rg_norm_cali_base_0           (rg_norm_cali_base_0[10:0]         ), //i
    .rg_norm_cali_base_1           (rg_norm_cali_base_1[10:0]         ), //i
    .rg_norm_cali_base_2           (rg_norm_cali_base_2[10:0]         ), //i
    .rg_norm_cali_touch_0          (rg_norm_cali_touch_0[10:0]        ), //i
    .rg_norm_cali_touch_1          (rg_norm_cali_touch_1[10:0]        ), //i
    .rg_norm_cali_touch_2          (rg_norm_cali_touch_2[10:0]        ), //i
    .rg_norm_base_addr_0           (norm_base_addr_0[6:0]             ), //i
    .rg_norm_base_addr_1           (norm_base_addr_1[6:0]             ), //i
    .rg_norm_base_addr_2           (norm_base_addr_2[6:0]             ), //i
    .amp_mean_0                    (amp_cal_unit_amp_mean_0[10:0]     ), //i
    .amp_mean_1                    (amp_cal_unit_amp_mean_1[10:0]     ), //i
    .amp_mean_2                    (amp_cal_unit_amp_mean_2[10:0]     ), //i
    .amp_mean_vld_0                (amp_cal_unit_amp_mean_vld_0       ), //i
    .amp_mean_vld_1                (amp_cal_unit_amp_mean_vld_1       ), //i
    .amp_mean_vld_2                (amp_cal_unit_amp_mean_vld_2       ), //i
    .samp_done                     (norm_unit_samp_done               ), //o
    .norm_done                     (norm_unit_norm_done               ), //o
    .norm_done_20M                 (norm_unit_norm_done_20M           ), //o
    .cache_ena                     (norm_unit_cache_ena               ), //o
    .cache_wena                    (norm_unit_cache_wena              ), //o
    .cache_addr                    (norm_unit_cache_addr[6:0]         ), //o
    .cache_wdata                   (norm_unit_cache_wdata[63:0]       ), //o
    .cache_rdata                   (cache_rdata[63:0]                 ), //i
    .clkout                        (u_clk_icg_pre_proc_inner_clkout   ), //i
    .rstn_80m                      (rstn_80m                          )  //i
  );
  clkGate_func_1 u_clk_icg_rnn_inner (
    .scan_en (scan_mode                 ), //i
    .enable  (u_clk_icg_rnn_inner_enable), //i
    .clkout  (u_clk_icg_rnn_inner_clkout), //o
    .clk     (clk                       )  //i
  );
  NN_layer NN_layer_unit (
    .rg_NN_data_ratio              (rg_nn_data_ratio[2:0]                         ), //i
    .rg_NN_layer_num               (rg_nn_layer_num                               ), //i
    .rg_NN_input_base_addr         (NN_layer_unit_rg_NN_input_base_addr[6:0]      ), //i
    .rg_NN_cache_ofmap_base_addr   (NN_layer_unit_rg_NN_cache_ofmap_base_addr[6:0]), //i
    .rg_NN_ifmap_groupnum          (rg_nn_ifmap_groupnum[2:0]                     ), //i
    .rg_NN_hidden_groupnum_layer_0 (rg_nn_hidden_groupnum_layer_0[2:0]            ), //i
    .rg_NN_hidden_groupnum_layer_1 (rg_nn_hidden_groupnum_layer_1[2:0]            ), //i
    .rg_NN_bias_addr_layer_0       (NN_layer_unit_rg_NN_bias_addr_layer_0[9:0]    ), //i
    .rg_NN_bias_addr_layer_1       (NN_layer_unit_rg_NN_bias_addr_layer_1[9:0]    ), //i
    .rg_NN_whi_addr_layer_0        (NN_layer_unit_rg_NN_whi_addr_layer_0[9:0]     ), //i
    .rg_NN_whi_addr_layer_1        (NN_layer_unit_rg_NN_whi_addr_layer_1[9:0]     ), //i
    .rg_NN_whh_addr_layer_0        (NN_layer_unit_rg_NN_whh_addr_layer_0[9:0]     ), //i
    .rg_NN_whh_addr_layer_1        (NN_layer_unit_rg_NN_whh_addr_layer_1[9:0]     ), //i
    .rg_NN_fc_bias_addr            (NN_layer_unit_rg_NN_fc_bias_addr[9:0]         ), //i
    .rg_NN_fc_weight_addr          (NN_layer_unit_rg_NN_fc_weight_addr[9:0]       ), //i
    .rg_NN_gate_w_bias_addr        (NN_layer_unit_rg_NN_gate_w_bias_addr[9:0]     ), //i
    .rg_NN_gate_w_weight_addr      (NN_layer_unit_rg_NN_gate_w_weight_addr[9:0]   ), //i
    .rg_NN_fcn1_bias_addr          (NN_layer_unit_rg_NN_fcn1_bias_addr[9:0]       ), //i
    .rg_NN_fcn1_weight_addr        (NN_layer_unit_rg_NN_fcn1_weight_addr[9:0]     ), //i
    .rg_NN_fcn2_bias_addr          (NN_layer_unit_rg_NN_fcn2_bias_addr[9:0]       ), //i
    .rg_NN_fcn2_weight_addr        (NN_layer_unit_rg_NN_fcn2_weight_addr[9:0]     ), //i
    .start_once                    (area_NN_start                                 ), //i
    .is_first_seq                  (NN_layer_unit_is_first_seq                    ), //i
    .coef_ena                      (NN_layer_unit_coef_ena                        ), //o
    .coef_wena                     (NN_layer_unit_coef_wena                       ), //o
    .coef_addr                     (NN_layer_unit_coef_addr[9:0]                  ), //o
    .coef_wdata                    (NN_layer_unit_coef_wdata[63:0]                ), //o
    .coef_rdata                    (NN_layer_unit_coef_rdata[63:0]                ), //i
    .cache_ena                     (NN_layer_unit_cache_ena                       ), //o
    .cache_wena                    (NN_layer_unit_cache_wena                      ), //o
    .cache_addr                    (NN_layer_unit_cache_addr[6:0]                 ), //o
    .cache_wdata                   (NN_layer_unit_cache_wdata[63:0]               ), //o
    .cache_rdata                   (cache_rdata[63:0]                             ), //i
    .matmul_done_once              (NN_layer_unit_matmul_done_once                ), //o
    .UpDown_label_result_vld       (NN_layer_unit_UpDown_label_result_vld         ), //o
    .UpDown_label_result_0         (NN_layer_unit_UpDown_label_result_0[7:0]      ), //o
    .UpDown_label_result_1         (NN_layer_unit_UpDown_label_result_1[7:0]      ), //o
    .UpDown_label_result_2         (NN_layer_unit_UpDown_label_result_2[7:0]      ), //o
    .Heavy_label_result_vld        (NN_layer_unit_Heavy_label_result_vld          ), //o
    .Heavy_label_result_0          (NN_layer_unit_Heavy_label_result_0[15:0]      ), //o
    .Heavy_label_result_1          (NN_layer_unit_Heavy_label_result_1[15:0]      ), //o
    .Heavy_label_result_2          (NN_layer_unit_Heavy_label_result_2[15:0]      ), //o
    .done                          (NN_layer_unit_done                            ), //o
    .clkout                        (u_clk_icg_rnn_inner_clkout                    ), //i
    .resetn                        (resetn                                        )  //i
  );
  label_seq_decide label_unit (
    .detect_mode             (rg_fdt_detect_mode                      ), //i
    .rg_nn_label_num         (rg_nn_label_num[1:0]                    ), //i
    .rg_label_seq_en         (rg_label_seq_en                         ), //i
    .rg_label_seq_length     (rg_label_seq_length[2:0]                ), //i
    .rg_label_Updown_TH      (rg_label_Updown_TH_1[1:0]               ), //i
    .rg_label_Heavy_TH       (rg_label_Heavy_TH_1[1:0]                ), //i
    .area_cnt                (area_cnt[1:0]                           ), //i
    .UpDown_label_result_vld (NN_layer_unit_UpDown_label_result_vld   ), //i
    .UpDown_label_result_0   (NN_layer_unit_UpDown_label_result_0[7:0]), //i
    .UpDown_label_result_1   (NN_layer_unit_UpDown_label_result_1[7:0]), //i
    .UpDown_label_result_2   (NN_layer_unit_UpDown_label_result_2[7:0]), //i
    .Heavy_label_result_vld  (NN_layer_unit_Heavy_label_result_vld    ), //i
    .Heavy_label_result_0    (NN_layer_unit_Heavy_label_result_0[15:0]), //i
    .Heavy_label_result_1    (NN_layer_unit_Heavy_label_result_1[15:0]), //i
    .Heavy_label_result_2    (NN_layer_unit_Heavy_label_result_2[15:0]), //i
    .done                    (label_unit_done                         ), //o
    .UpDown                  (label_unit_UpDown                       ), //o
    .Heavy                   (label_unit_Heavy                        ), //o
    .clk                     (clk                                     ), //i
    .resetn                  (resetn                                  )  //i
  );
  pre_mpx fdt_pre_mpx (
    .rg_pre_mpx_sel             (rg_pre_mpx_sel[2:0]                  ), //i
    .fdt_sampling               (fdt_sampling                         ), //i
    .fdt_adc_in_vld             (fdt_adc_in_vld                       ), //i
    .fdt_done                   (fdt_done                             ), //i
    .amp_mean_vld_0             (amp_cal_unit_amp_mean_vld_0          ), //i
    .amp_mean_vld_1             (amp_cal_unit_amp_mean_vld_1          ), //i
    .amp_mean_vld_2             (amp_cal_unit_amp_mean_vld_2          ), //i
    .norm_samp_done             (norm_unit_samp_done                  ), //i
    .norm_norm_done_20M         (norm_unit_norm_done_20M              ), //i
    .NN_start_once              (area_NN_start                        ), //i
    .NN_matmul_done_once        (NN_layer_unit_matmul_done_once       ), //i
    .NN_UpDown_label_result_vld (NN_layer_unit_UpDown_label_result_vld), //i
    .NN_Heavy_label_result_vld  (NN_layer_unit_Heavy_label_result_vld ), //i
    .NN_done                    (NN_layer_unit_done                   ), //i
    .label_UpDown               (label_unit_UpDown                    ), //i
    .label_Heavy                (label_unit_Heavy                     ), //i
    .fdt_start_pulse            (fdt_start_pulse_80m                  ), //i
    .fdt_area_cnt               (area_cnt[1:0]                        ), //i
    .fdt_area_skip_flag         (area_skip_flag                       ), //i
    .fdt_all_area_NN_done       (all_area_NN_done                     ), //i
    .pre_mpx_pin_0              (fdt_pre_mpx_pre_mpx_pin_0            ), //o
    .pre_mpx_pin_1              (fdt_pre_mpx_pre_mpx_pin_1            ), //o
    .pre_mpx_pin_2              (fdt_pre_mpx_pre_mpx_pin_2            )  //o
  );
  always @(*) begin
    case(area_cnt)
      2'b00 : begin
        tmp_rg_NN_input_base_addr = norm_base_addr_0;
        tmp_rg_NN_cache_ofmap_base_addr = ofmap_base_addr_0;
        tmp_rg_NN_bias_addr_layer_0 = area_bias_addr_lyer_0_0;
        tmp_rg_NN_bias_addr_layer_1 = area_bias_addr_lyer_0_1;
        tmp_rg_NN_whi_addr_layer_0 = area_whi_addr_layer_0_0;
        tmp_rg_NN_whi_addr_layer_1 = area_whi_addr_layer_0_1;
        tmp_rg_NN_whh_addr_layer_0 = area_whh_addr_layer_0_0;
        tmp_rg_NN_whh_addr_layer_1 = area_whh_addr_layer_0_1;
        tmp_rg_NN_fc_bias_addr = area_fc_bias_addr_0;
        tmp_rg_NN_fc_weight_addr = area_fc_weight_addr_0;
        tmp_rg_NN_gate_w_bias_addr = area_gate_w_bias_addr_0;
        tmp_rg_NN_gate_w_weight_addr = area_gate_w_weight_addr_0;
        tmp_rg_NN_fcn1_bias_addr = area_fcn1_bias_addr_0;
        tmp_rg_NN_fcn1_weight_addr = area_fcn1_weight_addr_0;
        tmp_rg_NN_fcn2_bias_addr = area_fcn2_bias_addr_0;
        tmp_rg_NN_fcn2_weight_addr = area_fcn2_weight_addr_0;
        tmp_is_first_seq = area_is_first_seq_0;
      end
      2'b01 : begin
        tmp_rg_NN_input_base_addr = norm_base_addr_1;
        tmp_rg_NN_cache_ofmap_base_addr = ofmap_base_addr_1;
        tmp_rg_NN_bias_addr_layer_0 = area_bias_addr_lyer_1_0;
        tmp_rg_NN_bias_addr_layer_1 = area_bias_addr_lyer_1_1;
        tmp_rg_NN_whi_addr_layer_0 = area_whi_addr_layer_1_0;
        tmp_rg_NN_whi_addr_layer_1 = area_whi_addr_layer_1_1;
        tmp_rg_NN_whh_addr_layer_0 = area_whh_addr_layer_1_0;
        tmp_rg_NN_whh_addr_layer_1 = area_whh_addr_layer_1_1;
        tmp_rg_NN_fc_bias_addr = area_fc_bias_addr_1;
        tmp_rg_NN_fc_weight_addr = area_fc_weight_addr_1;
        tmp_rg_NN_gate_w_bias_addr = area_gate_w_bias_addr_1;
        tmp_rg_NN_gate_w_weight_addr = area_gate_w_weight_addr_1;
        tmp_rg_NN_fcn1_bias_addr = area_fcn1_bias_addr_1;
        tmp_rg_NN_fcn1_weight_addr = area_fcn1_weight_addr_1;
        tmp_rg_NN_fcn2_bias_addr = area_fcn2_bias_addr_1;
        tmp_rg_NN_fcn2_weight_addr = area_fcn2_weight_addr_1;
        tmp_is_first_seq = area_is_first_seq_1;
      end
      default : begin
        tmp_rg_NN_input_base_addr = norm_base_addr_2;
        tmp_rg_NN_cache_ofmap_base_addr = ofmap_base_addr_2;
        tmp_rg_NN_bias_addr_layer_0 = area_bias_addr_lyer_2_0;
        tmp_rg_NN_bias_addr_layer_1 = area_bias_addr_lyer_2_1;
        tmp_rg_NN_whi_addr_layer_0 = area_whi_addr_layer_2_0;
        tmp_rg_NN_whi_addr_layer_1 = area_whi_addr_layer_2_1;
        tmp_rg_NN_whh_addr_layer_0 = area_whh_addr_layer_2_0;
        tmp_rg_NN_whh_addr_layer_1 = area_whh_addr_layer_2_1;
        tmp_rg_NN_fc_bias_addr = area_fc_bias_addr_2;
        tmp_rg_NN_fc_weight_addr = area_fc_weight_addr_2;
        tmp_rg_NN_gate_w_bias_addr = area_gate_w_bias_addr_2;
        tmp_rg_NN_gate_w_weight_addr = area_gate_w_weight_addr_2;
        tmp_rg_NN_fcn1_bias_addr = area_fcn1_bias_addr_2;
        tmp_rg_NN_fcn1_weight_addr = area_fcn1_weight_addr_2;
        tmp_rg_NN_fcn2_bias_addr = area_fcn2_bias_addr_2;
        tmp_rg_NN_fcn2_weight_addr = area_fcn2_weight_addr_2;
        tmp_is_first_seq = area_is_first_seq_2;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(curr_state)
      FDTSTATE_IDLE : curr_state_string = "IDLE       ";
      FDTSTATE_NeuNet_WORK : curr_state_string = "NeuNet_WORK";
      FDTSTATE_LABEL_DEC : curr_state_string = "LABEL_DEC  ";
      default : curr_state_string = "???????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      FDTSTATE_IDLE : next_state_string = "IDLE       ";
      FDTSTATE_NeuNet_WORK : next_state_string = "NeuNet_WORK";
      FDTSTATE_LABEL_DEC : next_state_string = "LABEL_DEC  ";
      default : next_state_string = "???????????";
    endcase
  end
  `endif

  assign fdt_samp = (fdt_sampling && rg_fdt_en);
  assign state_in_NN_work = ((curr_state != FDTSTATE_NeuNet_WORK) && (next_state == FDTSTATE_NeuNet_WORK));
  assign state_is_NN_work = (curr_state == FDTSTATE_NeuNet_WORK);
  assign state_is_LAB_work = (curr_state == FDTSTATE_LABEL_DEC);
  assign state_in_nxt_area_NN_work = ((curr_state == FDTSTATE_LABEL_DEC) && (next_state == FDTSTATE_NeuNet_WORK));
  assign area_cnt_ov = (area_cnt == 2'b10);
  assign area_work_flag = rg_fdt_area_en_one_hot[area_cnt];
  assign area_skip_flag = (! area_work_flag);
  assign area_NN_start = (area_work_flag && (state_is_NN_work && (! state_is_NN_work_regNext)));
  assign all_area_NN_done = ((state_is_LAB_work && area_cnt_ov) && (label_seq_done_delay2 || area_skip_flag));
  assign area_roi_num = (tmp_area_roi_num + tmp_area_roi_num_5);
  assign rg_label_Updown_TH_1 = ((area_roi_num <= rg_label_Updown_TH) ? tmp_rg_label_Updown_TH_1 : rg_label_Updown_TH);
  assign rg_label_Heavy_TH_1 = ((area_roi_num <= rg_label_Heavy_TH) ? tmp_rg_label_Heavy_TH_1 : rg_label_Heavy_TH);
  assign fdt_init_seq_unlock = (fdt_samp && (! fdt_samp_regNext));
  assign fdt_init_seq_inter = (fdt_init_seq_lock && fdt_init_seq_unlock);
  assign cache_clk_sel = state_is_NN_work;
  assign nn_clk_en = (state_is_NN_work || state_is_LAB_work);
  assign fdt_start_pulse_80m = (fdt_samp && (! fdt_samp_regNext_1));
  assign pre_proc_clk_en = (((pre_proc_en_reg || iq_ready_pulse) || fdt_adc_in_vld) || fdt_adc_in_vld_dly);
  assign u_clk_icg_pre_proc_inner_enable = (pre_proc_clk_en || rg_fdt_pre_proc_ckgt_sw_en);
  assign amp_cal_unit_fdt_adc_in_vld = (fdt_adc_in_vld && fdt_samp);
  assign iq_ready_pulse = amp_cal_unit_iq_ready_pulse;
  assign tmp_pre_proc_end_pulse = (norm_unit_samp_done || norm_unit_norm_done_20M);
  assign pre_proc_end_pulse = ((! tmp_pre_proc_end_pulse) && tmp_pre_proc_end_pulse_1);
  assign u_clk_icg_rnn_inner_enable = (rnn_ck_en || rg_fdt_rnn_ckgt_sw_en);
  assign rnn_ck_en = rnn_cal_en_reg;
  assign fdt_result_up_pulse = (all_area_NN_done && rg_fdt_result_up);
  assign fdt_result_down_pulse = (all_area_NN_done && rg_fdt_result_down);
  assign fdt_result_heavy_pulse = (all_area_NN_done && rg_fdt_result_Heavy);
  assign tmp_fdt_up_int = (rg_fdt_wait_up && fdt_result_up_pulse);
  assign fdt_up_int = (|{tmp_fdt_up_int_3,{tmp_fdt_up_int_2,{tmp_fdt_up_int_1,tmp_fdt_up_int}}});
  assign tmp_fdt_down_int = (rg_fdt_wait_down && fdt_result_down_pulse);
  assign fdt_down_int = (|{tmp_fdt_down_int_3,{tmp_fdt_down_int_2,{tmp_fdt_down_int_1,tmp_fdt_down_int}}});
  assign tmp_fdt_Heavy_int = (rg_fdt_wait_heavy && fdt_result_heavy_pulse);
  assign fdt_Heavy_int = (|{tmp_fdt_Heavy_int_3,{tmp_fdt_Heavy_int_2,{tmp_fdt_Heavy_int_1,tmp_fdt_Heavy_int}}});
  assign fdt_auto_exit_pulse_inter = ((rg_fdt_auto_exit_en && (fdt_up_int || fdt_down_int)) || (fdt_Heavy_int && rg_fdt_heavy_auto_exit_en));
  assign tmp_fdt_done = (norm_unit_samp_done || all_area_NN_done);
  assign fdt_done = tmp_fdt_done_4;
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      FDTSTATE_IDLE : begin
        if(norm_unit_norm_done_20M) begin
          next_state = FDTSTATE_NeuNet_WORK;
        end
      end
      FDTSTATE_NeuNet_WORK : begin
        if(area_skip_flag) begin
          next_state = FDTSTATE_LABEL_DEC;
        end else begin
          if(NN_layer_unit_done) begin
            next_state = FDTSTATE_LABEL_DEC;
          end
        end
      end
      default : begin
        if(all_area_NN_done) begin
          next_state = FDTSTATE_IDLE;
        end else begin
          if(area_skip_flag) begin
            next_state = FDTSTATE_NeuNet_WORK;
          end else begin
            if(label_seq_done_delay2) begin
              next_state = FDTSTATE_NeuNet_WORK;
            end
          end
        end
      end
    endcase
  end

  assign tmp_1 = ({3'd0,1'b1} <<< area_cnt);
  assign norm_base_addr_0 = rg_nn_input_base_addr;
  assign ofmap_base_addr_0 = rg_nn_cache_ofmap_base_addr;
  assign norm_base_addr_1 = (rg_nn_input_base_addr + 7'h1c);
  assign ofmap_base_addr_1 = (rg_nn_cache_ofmap_base_addr + 7'h1c);
  assign norm_base_addr_2 = (tmp_norm_base_addr_2 + 7'h14);
  assign ofmap_base_addr_2 = (tmp_ofmap_base_addr_2 + 7'h14);
  assign area_is_first_seq_0 = (! area_is_not_first_seq_0);
  assign area_bias_addr_lyer_0_0 = (rg_nn_bias_addr_layer_0 + 10'h0);
  assign area_whi_addr_layer_0_0 = (rg_nn_whi_addr_layer_0 + 10'h0);
  assign area_whh_addr_layer_0_0 = (rg_nn_whh_addr_layer_0 + 10'h0);
  assign area_bias_addr_lyer_0_1 = (rg_nn_bias_addr_layer_1 + 10'h0);
  assign area_whi_addr_layer_0_1 = (rg_nn_whi_addr_layer_1 + 10'h0);
  assign area_whh_addr_layer_0_1 = (rg_nn_whh_addr_layer_1 + 10'h0);
  assign area_fc_bias_addr_0 = (rg_nn_fc_bias_addr + 10'h0);
  assign area_fc_weight_addr_0 = (rg_nn_fc_weight_addr + 10'h0);
  assign area_gate_w_bias_addr_0 = (rg_nn_gate_w_bias_addr + 10'h0);
  assign area_gate_w_weight_addr_0 = (rg_nn_gate_w_weight_addr + 10'h0);
  assign area_fcn1_bias_addr_0 = (rg_nn_fcn1_bias_addr + 10'h0);
  assign area_fcn1_weight_addr_0 = (rg_nn_fcn1_weight_addr + 10'h0);
  assign area_fcn2_bias_addr_0 = (rg_nn_fcn2_bias_addr + 10'h0);
  assign area_fcn2_weight_addr_0 = (rg_nn_fcn2_weight_addr + 10'h0);
  assign area_is_first_seq_1 = (! area_is_not_first_seq_1);
  assign area_bias_addr_lyer_1_0 = (rg_nn_bias_addr_layer_0 + 10'h129);
  assign area_whi_addr_layer_1_0 = (rg_nn_whi_addr_layer_0 + 10'h129);
  assign area_whh_addr_layer_1_0 = (rg_nn_whh_addr_layer_0 + 10'h129);
  assign area_bias_addr_lyer_1_1 = (rg_nn_bias_addr_layer_1 + 10'h129);
  assign area_whi_addr_layer_1_1 = (rg_nn_whi_addr_layer_1 + 10'h129);
  assign area_whh_addr_layer_1_1 = (rg_nn_whh_addr_layer_1 + 10'h129);
  assign area_fc_bias_addr_1 = (rg_nn_fc_bias_addr + 10'h129);
  assign area_fc_weight_addr_1 = (rg_nn_fc_weight_addr + 10'h129);
  assign area_gate_w_bias_addr_1 = (rg_nn_gate_w_bias_addr + 10'h129);
  assign area_gate_w_weight_addr_1 = (rg_nn_gate_w_weight_addr + 10'h129);
  assign area_fcn1_bias_addr_1 = (rg_nn_fcn1_bias_addr + 10'h129);
  assign area_fcn1_weight_addr_1 = (rg_nn_fcn1_weight_addr + 10'h129);
  assign area_fcn2_bias_addr_1 = (rg_nn_fcn2_bias_addr + 10'h129);
  assign area_fcn2_weight_addr_1 = (rg_nn_fcn2_weight_addr + 10'h129);
  assign area_is_first_seq_2 = (! area_is_not_first_seq_2);
  assign area_bias_addr_lyer_2_0 = (rg_nn_bias_addr_layer_0 + 10'h252);
  assign area_whi_addr_layer_2_0 = (rg_nn_whi_addr_layer_0 + 10'h252);
  assign area_whh_addr_layer_2_0 = (rg_nn_whh_addr_layer_0 + 10'h252);
  assign area_bias_addr_lyer_2_1 = (rg_nn_bias_addr_layer_1 + 10'h252);
  assign area_whi_addr_layer_2_1 = (rg_nn_whi_addr_layer_1 + 10'h252);
  assign area_whh_addr_layer_2_1 = (rg_nn_whh_addr_layer_1 + 10'h252);
  assign area_fc_bias_addr_2 = (rg_nn_fc_bias_addr + 10'h252);
  assign area_fc_weight_addr_2 = (rg_nn_fc_weight_addr + 10'h252);
  assign area_gate_w_bias_addr_2 = (rg_nn_gate_w_bias_addr + 10'h252);
  assign area_gate_w_weight_addr_2 = (rg_nn_gate_w_weight_addr + 10'h252);
  assign area_fcn1_bias_addr_2 = (rg_nn_fcn1_bias_addr + 10'h252);
  assign area_fcn1_weight_addr_2 = (rg_nn_fcn1_weight_addr + 10'h252);
  assign area_fcn2_bias_addr_2 = (rg_nn_fcn2_bias_addr + 10'h252);
  assign area_fcn2_weight_addr_2 = (rg_nn_fcn2_weight_addr + 10'h252);
  assign area_cnt_incr = state_in_nxt_area_NN_work;
  assign NN_layer_unit_rg_NN_input_base_addr = tmp_rg_NN_input_base_addr;
  assign NN_layer_unit_rg_NN_cache_ofmap_base_addr = tmp_rg_NN_cache_ofmap_base_addr;
  assign NN_layer_unit_rg_NN_bias_addr_layer_0 = tmp_rg_NN_bias_addr_layer_0;
  assign NN_layer_unit_rg_NN_bias_addr_layer_1 = tmp_rg_NN_bias_addr_layer_1;
  assign NN_layer_unit_rg_NN_whi_addr_layer_0 = tmp_rg_NN_whi_addr_layer_0;
  assign NN_layer_unit_rg_NN_whi_addr_layer_1 = tmp_rg_NN_whi_addr_layer_1;
  assign NN_layer_unit_rg_NN_whh_addr_layer_0 = tmp_rg_NN_whh_addr_layer_0;
  assign NN_layer_unit_rg_NN_whh_addr_layer_1 = tmp_rg_NN_whh_addr_layer_1;
  assign NN_layer_unit_rg_NN_fc_bias_addr = tmp_rg_NN_fc_bias_addr;
  assign NN_layer_unit_rg_NN_fc_weight_addr = tmp_rg_NN_fc_weight_addr;
  assign NN_layer_unit_rg_NN_gate_w_bias_addr = tmp_rg_NN_gate_w_bias_addr;
  assign NN_layer_unit_rg_NN_gate_w_weight_addr = tmp_rg_NN_gate_w_weight_addr;
  assign NN_layer_unit_rg_NN_fcn1_bias_addr = tmp_rg_NN_fcn1_bias_addr;
  assign NN_layer_unit_rg_NN_fcn1_weight_addr = tmp_rg_NN_fcn1_weight_addr;
  assign NN_layer_unit_rg_NN_fcn2_bias_addr = tmp_rg_NN_fcn2_bias_addr;
  assign NN_layer_unit_rg_NN_fcn2_weight_addr = tmp_rg_NN_fcn2_weight_addr;
  assign NN_layer_unit_is_first_seq = tmp_is_first_seq;
  always @(*) begin
    if(state_is_NN_work) begin
      cache_ena = NN_layer_unit_cache_ena;
    end else begin
      cache_ena = norm_unit_cache_ena;
    end
  end

  always @(*) begin
    if(state_is_NN_work) begin
      cache_wena = NN_layer_unit_cache_wena;
    end else begin
      cache_wena = norm_unit_cache_wena;
    end
  end

  always @(*) begin
    if(state_is_NN_work) begin
      cache_addr = NN_layer_unit_cache_addr;
    end else begin
      cache_addr = norm_unit_cache_addr;
    end
  end

  always @(*) begin
    if(state_is_NN_work) begin
      cache_wdata = NN_layer_unit_cache_wdata;
    end else begin
      cache_wdata = norm_unit_cache_wdata;
    end
  end

  assign fdt_auto_exit_pulse = fdt_auto_exit_pulse_inter_reg;
  assign coef_addr_1 = fdtmem_addr[12 : 1];
  assign coef_rdata_slice_0 = coef_rdata[15 : 0];
  assign coef_rdata_slice_1 = coef_rdata[31 : 16];
  assign coef_rdata_slice_2 = coef_rdata[47 : 32];
  assign coef_rdata_slice_3 = coef_rdata[63 : 48];
  always @(*) begin
    case(coef_addr_1[1 : 0])
      2'b00 : begin
        bitsel = 4'b0001;
      end
      2'b01 : begin
        bitsel = 4'b0010;
      end
      2'b10 : begin
        bitsel = 4'b0100;
      end
      default : begin
        bitsel = 4'b1000;
      end
    endcase
  end

  always @(*) begin
    case(coef_addr_1[1 : 0])
      2'b00 : begin
        wdata_sel = {48'd0, fdtmem_wdata};
      end
      2'b01 : begin
        wdata_sel = (tmp_wdata_sel <<< 16);
      end
      2'b10 : begin
        wdata_sel = (tmp_wdata_sel_1 <<< 32);
      end
      default : begin
        wdata_sel = (tmp_wdata_sel_2 <<< 48);
      end
    endcase
  end

  always @(*) begin
    case(coef_addr_low10bits_delay)
      2'b00 : begin
        rdata_sel = coef_rdata_slice_0;
      end
      2'b01 : begin
        rdata_sel = coef_rdata_slice_1;
      end
      2'b10 : begin
        rdata_sel = coef_rdata_slice_2;
      end
      default : begin
        rdata_sel = coef_rdata_slice_3;
      end
    endcase
  end

  assign NN_layer_unit_coef_rdata = (nn_clk_en ? coef_rdata : 64'h0);
  assign fdtmem_rdata = (nn_clk_en ? 16'h0 : rdata_sel);
  assign coef_ena = (nn_clk_en ? NN_layer_unit_coef_ena : (fdtmem_wr || fdtmem_rd));
  assign coef_wena = (nn_clk_en ? NN_layer_unit_coef_wena : (fdtmem_wr && (! fdtmem_rd)));
  assign coef_addr = (nn_clk_en ? NN_layer_unit_coef_addr : coef_addr_1[11 : 2]);
  assign coef_wsel = (nn_clk_en ? 4'b0000 : bitsel);
  assign coef_wdata = (nn_clk_en ? NN_layer_unit_coef_wdata : wdata_sel);
  assign pre_mpx_pin_0 = fdt_pre_mpx_pre_mpx_pin_0;
  assign pre_mpx_pin_1 = fdt_pre_mpx_pre_mpx_pin_1;
  assign pre_mpx_pin_2 = fdt_pre_mpx_pre_mpx_pin_2;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      rg_fdt_result_up <= 1'b0;
      rg_fdt_result_down <= 1'b0;
      rg_fdt_result_Heavy <= 1'b0;
      curr_state <= FDTSTATE_IDLE;
      area_cnt <= 2'b00;
      state_is_NN_work_regNext <= 1'b0;
      label_seq_done_delay1 <= 1'b0;
      label_seq_done_delay2 <= 1'b0;
      area_is_not_first_seq_0 <= 1'b0;
      area_is_not_first_seq_1 <= 1'b0;
      area_is_not_first_seq_2 <= 1'b0;
      tmp_pre_proc_end_pulse_1 <= 1'b0;
      rnn_cal_en_reg <= 1'b0;
      tmp_fdt_up_int_1 <= 1'b0;
      tmp_fdt_up_int_2 <= 1'b0;
      tmp_fdt_up_int_3 <= 1'b0;
      tmp_fdt_down_int_1 <= 1'b0;
      tmp_fdt_down_int_2 <= 1'b0;
      tmp_fdt_down_int_3 <= 1'b0;
      tmp_fdt_Heavy_int_1 <= 1'b0;
      tmp_fdt_Heavy_int_2 <= 1'b0;
      tmp_fdt_Heavy_int_3 <= 1'b0;
      tmp_fdt_done_1 <= 1'b0;
      tmp_fdt_done_2 <= 1'b0;
      tmp_fdt_done_3 <= 1'b0;
      tmp_fdt_done_4 <= 1'b0;
    end else begin
      state_is_NN_work_regNext <= state_is_NN_work;
      tmp_pre_proc_end_pulse_1 <= tmp_pre_proc_end_pulse;
      if(norm_unit_norm_done_20M) begin
        rnn_cal_en_reg <= 1'b1;
      end else begin
        if(all_area_NN_done) begin
          rnn_cal_en_reg <= 1'b0;
        end
      end
      label_seq_done_delay1 <= label_unit_done;
      label_seq_done_delay2 <= label_seq_done_delay1;
      tmp_fdt_up_int_1 <= tmp_fdt_up_int;
      tmp_fdt_up_int_2 <= tmp_fdt_up_int_1;
      tmp_fdt_up_int_3 <= tmp_fdt_up_int_2;
      tmp_fdt_down_int_1 <= tmp_fdt_down_int;
      tmp_fdt_down_int_2 <= tmp_fdt_down_int_1;
      tmp_fdt_down_int_3 <= tmp_fdt_down_int_2;
      tmp_fdt_Heavy_int_1 <= tmp_fdt_Heavy_int;
      tmp_fdt_Heavy_int_2 <= tmp_fdt_Heavy_int_1;
      tmp_fdt_Heavy_int_3 <= tmp_fdt_Heavy_int_2;
      if(label_seq_done_delay1) begin
        rg_fdt_result_up <= (label_unit_UpDown == 1'b0);
        rg_fdt_result_down <= (label_unit_UpDown == 1'b1);
        rg_fdt_result_Heavy <= (label_unit_Heavy == 1'b1);
      end
      tmp_fdt_done_1 <= tmp_fdt_done;
      tmp_fdt_done_2 <= tmp_fdt_done_1;
      tmp_fdt_done_3 <= tmp_fdt_done_2;
      tmp_fdt_done_4 <= (|{tmp_fdt_done_3,{tmp_fdt_done_2,{tmp_fdt_done_1,tmp_fdt_done}}});
      curr_state <= next_state;
      if(fdt_init_seq_inter) begin
        area_is_not_first_seq_0 <= 1'b0;
        area_is_not_first_seq_1 <= 1'b0;
        area_is_not_first_seq_2 <= 1'b0;
      end else begin
        if(NN_layer_unit_done) begin
          if(tmp_1[0]) begin
            area_is_not_first_seq_0 <= 1'b1;
          end
          if(tmp_1[1]) begin
            area_is_not_first_seq_1 <= 1'b1;
          end
          if(tmp_1[2]) begin
            area_is_not_first_seq_2 <= 1'b1;
          end
        end
      end
      if((state_in_NN_work && (! area_cnt_incr))) begin
        area_cnt <= 2'b00;
      end else begin
        if(area_cnt_incr) begin
          if(area_cnt_ov) begin
            area_cnt <= 2'b00;
          end else begin
            area_cnt <= (area_cnt + 2'b01);
          end
        end
      end
    end
  end

  always @(posedge clk_sys or negedge rstn_sys) begin
    if(!rstn_sys) begin
      fdt_init_seq_lock <= 1'b0;
      fdt_samp_regNext <= 1'b0;
      fdt_auto_exit_pulse_inter_reg <= 1'b0;
      coef_addr_low10bits_delay <= 2'b00;
    end else begin
      fdt_samp_regNext <= fdt_samp;
      if(rg_fdt_init_seq) begin
        fdt_init_seq_lock <= 1'b1;
      end else begin
        if(fdt_init_seq_unlock) begin
          fdt_init_seq_lock <= 1'b0;
        end
      end
      fdt_auto_exit_pulse_inter_reg <= fdt_auto_exit_pulse_inter;
      if(fdtmem_rd) begin
        coef_addr_low10bits_delay <= coef_addr_1[1 : 0];
      end
    end
  end

  always @(posedge clk_80m or negedge rstn_80m) begin
    if(!rstn_80m) begin
      pre_proc_en_reg <= 1'b0;
      fdt_samp_regNext_1 <= 1'b0;
      fdt_adc_in_vld_dly <= 1'b0;
    end else begin
      fdt_samp_regNext_1 <= fdt_samp;
      fdt_adc_in_vld_dly <= fdt_adc_in_vld;
      if(iq_ready_pulse) begin
        pre_proc_en_reg <= 1'b1;
      end else begin
        if(pre_proc_end_pulse) begin
          pre_proc_en_reg <= 1'b0;
        end
      end
    end
  end


endmodule

// Generator : SpinalHDL v1.10.0    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : fdt_ctrl
// Git hash  : a7f9623e0f7bfe62cd0861f8b0fee287e3b73482

`timescale 1ns/1ps

module fdt_ctrl (
  input  wire          clk_80m,
  input  wire          rstn_80m,
  input  wire          scan_mode,
  input  wire          fdt_sampling,
  input  wire [11:0]   fdt_adc_in,
  input  wire          fdt_adc_in_vld,
  input  wire          fdtmem_rd,
  input  wire          fdtmem_wr,
  input  wire [15:0]   fdtmem_addr,
  input  wire [15:0]   fdtmem_wdata,
  output wire [15:0]   fdtmem_rdata,
  output reg           cache_ena,
  output reg           cache_wena,
  output reg  [6:0]    cache_addr,
  output reg  [31:0]   cache_wdata,
  input  wire [31:0]   cache_rdata,
  output wire          coef_ena,
  output wire          coef_wena,
  output wire [6:0]    coef_addr,
  output wire [31:0]   coef_wdata,
  output wire [3:0]    coef_wsel,
  input  wire [31:0]   coef_rdata,
  input  wire          rg_fdt_en,
  input  wire          rg_fdt_wait_up,
  input  wire          rg_fdt_wait_down,
  input  wire          rg_fdt_auto_exit_en,
  input  wire [2:0]    rg_amp_data_ratio,
  input  wire          rg_amp_global_norm_mode,
  input  wire          rg_amp_multi_seq_norm_mode,
  input  wire [4:0]    rg_amp_samp_start_num,
  input  wire [2:0]    rg_amp_sample_num_log2,
  input  wire [3:0]    rg_amp_samp_gap_num,
  input  wire          rg_rnn_single_step_mode,
  input  wire          rg_rnn_single_step_init,
  input  wire [2:0]    rg_rnn_data_ratio,
  input  wire [6:0]    rg_cache_ofmap_base_addr,
  input  wire [3:0]    rg_rnn_seq_num,
  input  wire [1:0]    rg_rnn_layer_num,
  input  wire [1:0]    rg_rnn_ifmap_groupnum,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_0,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_1,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_2,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_3,
  input  wire [6:0]    rg_rnn_bias_addr_layer_0,
  input  wire [6:0]    rg_rnn_bias_addr_layer_1,
  input  wire [6:0]    rg_rnn_bias_addr_layer_2,
  input  wire [6:0]    rg_rnn_bias_addr_layer_3,
  input  wire [6:0]    rg_rnn_whi_addr_layer_0,
  input  wire [6:0]    rg_rnn_whi_addr_layer_1,
  input  wire [6:0]    rg_rnn_whi_addr_layer_2,
  input  wire [6:0]    rg_rnn_whi_addr_layer_3,
  input  wire [6:0]    rg_rnn_whh_addr_layer_0,
  input  wire [6:0]    rg_rnn_whh_addr_layer_1,
  input  wire [6:0]    rg_rnn_whh_addr_layer_2,
  input  wire [6:0]    rg_rnn_whh_addr_layer_3,
  input  wire [6:0]    rg_rnn_fc_bias_addr,
  input  wire [6:0]    rg_rnn_fc_weight_addr,
  input  wire [1:0]    rg_rnn_fc_label_num,
  input  wire          rg_fdt_label_seq_en,
  input  wire [2:0]    rg_fdt_label_seq_length,
  input  wire [4:0]    fdt_therm_comp_one_hot,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_0,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_1,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_2,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_3,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_4,
  output wire          write_ifmap_once_done,
  output wire          matmul_done_once,
  output wire          rnn_done,
  output wire          fdt_once_done,
  output wire          amp_cal_clk_en,
  output wire          rnn_clk_en,
  output wire          fdt_up_int,
  output wire          fdt_down_int,
  output reg           rg_fdt_result_up,
  output reg           rg_fdt_result_down,
  output wire [7:0]    rg_fdt_label_seq_buffer,
  output wire [1:0]    rg_fdt_pred_index,
  output wire [15:0]   label_result_0,
  output wire [15:0]   label_result_1,
  output wire [15:0]   label_result_2,
  output wire [15:0]   label_result_3,
  output reg           fdt_auto_exit_pulse,
  output wire          single_step_every_done,
  input  wire          resetn,
  input  wire          clk
);
  localparam FDTSTATE_IDLE = 3'd0;
  localparam FDTSTATE_STORE_AMP = 3'd1;
  localparam FDTSTATE_STORE_MEAN = 3'd2;
  localparam FDTSTATE_CAL_MEAN = 3'd3;
  localparam FDTSTATE_CAL_NORM = 3'd4;
  localparam FDTSTATE_STORE_NORM = 3'd5;

  wire       [31:0]   rnn_coef_rdata;
  wire       [7:0]    norm_cal_unit_datain;
  wire       [3:0]    norm_cal_unit_mean_num_log;
  wire                u_clk_icg_amp_inner_clkout;
  wire                post_process_unit_amp_cal_end;
  wire                post_process_unit_norm_cal_end_pulse;
  wire                post_process_unit_norm_cal_end_req;
  wire                post_process_unit_iq_ready_pulse;
  wire       [12:0]   post_process_unit_smpArrayI_0;
  wire       [12:0]   post_process_unit_smpArrayI_1;
  wire       [12:0]   post_process_unit_smpArrayI_2;
  wire       [12:0]   post_process_unit_smpArrayI_3;
  wire       [12:0]   post_process_unit_smpArrayI_4;
  wire       [12:0]   post_process_unit_smpArrayI_5;
  wire       [12:0]   post_process_unit_smpArrayI_6;
  wire       [12:0]   post_process_unit_smpArrayI_7;
  wire       [12:0]   post_process_unit_smpArrayI_8;
  wire       [12:0]   post_process_unit_smpArrayI_9;
  wire       [12:0]   post_process_unit_smpArrayI_10;
  wire       [12:0]   post_process_unit_smpArrayI_11;
  wire       [12:0]   post_process_unit_smpArrayI_12;
  wire       [12:0]   post_process_unit_smpArrayI_13;
  wire       [12:0]   post_process_unit_smpArrayI_14;
  wire       [12:0]   post_process_unit_smpArrayI_15;
  wire       [12:0]   post_process_unit_smpArrayQ_0;
  wire       [12:0]   post_process_unit_smpArrayQ_1;
  wire       [12:0]   post_process_unit_smpArrayQ_2;
  wire       [12:0]   post_process_unit_smpArrayQ_3;
  wire       [12:0]   post_process_unit_smpArrayQ_4;
  wire       [12:0]   post_process_unit_smpArrayQ_5;
  wire       [12:0]   post_process_unit_smpArrayQ_6;
  wire       [12:0]   post_process_unit_smpArrayQ_7;
  wire       [12:0]   post_process_unit_smpArrayQ_8;
  wire       [12:0]   post_process_unit_smpArrayQ_9;
  wire       [12:0]   post_process_unit_smpArrayQ_10;
  wire       [12:0]   post_process_unit_smpArrayQ_11;
  wire       [12:0]   post_process_unit_smpArrayQ_12;
  wire       [12:0]   post_process_unit_smpArrayQ_13;
  wire       [12:0]   post_process_unit_smpArrayQ_14;
  wire       [12:0]   post_process_unit_smpArrayQ_15;
  wire                rnn_all_ifmap_ready_flag_clear;
  wire                rnn_coef_ena;
  wire                rnn_coef_wena;
  wire       [6:0]    rnn_coef_addr;
  wire       [31:0]   rnn_coef_wdata;
  wire                rnn_cache_ena;
  wire                rnn_cache_wena;
  wire       [6:0]    rnn_cache_addr;
  wire       [31:0]   rnn_cache_wdata;
  wire       [1:0]    rnn_rnn_pred_index;
  wire                rnn_done_1;
  wire       [15:0]   rnn_label_result_0;
  wire       [15:0]   rnn_label_result_1;
  wire       [15:0]   rnn_label_result_2;
  wire       [15:0]   rnn_label_result_3;
  wire                rnn_single_step_every_done;
  wire                rnn_matmul_done_once;
  wire                label_seq_decide_unit_done;
  wire                label_seq_decide_unit_pred_index_out;
  wire       [7:0]    label_seq_decide_unit_label_seq_buffer;
  wire       [7:0]    norm_cal_unit_norm_out;
  wire       [7:0]    tmp_norm_data_gather_0;
  wire       [7:0]    tmp_norm_data_gather_0_1;
  wire       [7:0]    tmp_norm_data_gather_0_2;
  wire       [7:0]    tmp_norm_data_gather_0_3;
  wire       [7:0]    tmp_norm_data_gather_0_4;
  wire       [7:0]    tmp_norm_data_gather_0_5;
  wire       [7:0]    tmp_norm_data_gather_0_6;
  wire       [7:0]    tmp_norm_data_gather_0_7;
  wire       [7:0]    tmp_norm_data_gather_1;
  wire       [7:0]    tmp_norm_data_gather_1_1;
  wire       [7:0]    tmp_norm_data_gather_1_2;
  wire       [7:0]    tmp_norm_data_gather_1_3;
  wire       [7:0]    tmp_norm_data_gather_1_4;
  wire       [7:0]    tmp_norm_data_gather_1_5;
  wire       [7:0]    tmp_norm_data_gather_1_6;
  wire       [7:0]    tmp_norm_data_gather_1_7;
  wire       [7:0]    tmp_norm_data_gather_2;
  wire       [7:0]    tmp_norm_data_gather_2_1;
  wire       [7:0]    tmp_norm_data_gather_2_2;
  wire       [7:0]    tmp_norm_data_gather_2_3;
  wire       [7:0]    tmp_norm_data_gather_2_4;
  wire       [7:0]    tmp_norm_data_gather_2_5;
  wire       [7:0]    tmp_norm_data_gather_2_6;
  wire       [7:0]    tmp_norm_data_gather_2_7;
  wire       [7:0]    tmp_norm_data_gather_3;
  wire       [7:0]    tmp_norm_data_gather_3_1;
  wire       [7:0]    tmp_norm_data_gather_3_2;
  wire       [7:0]    tmp_norm_data_gather_3_3;
  wire       [7:0]    tmp_norm_data_gather_3_4;
  wire       [7:0]    tmp_norm_data_gather_3_5;
  wire       [7:0]    tmp_norm_data_gather_3_6;
  wire       [7:0]    tmp_norm_data_gather_3_7;
  wire       [4:0]    tmp_fdt_time_cnt_max;
  wire       [4:0]    tmp_fdt_time_cnt_max_1;
  wire       [4:0]    tmp_fdt_time_cnt_max_2;
  wire       [6:0]    tmp_write_ifmap_addr;
  wire       [6:0]    tmp_write_ifmap_max_addr;
  wire       [7:0]    tmp_write_ifmap_base_pointer_next;
  wire       [3:0]    tmp_write_ifmap_base_pointer_next_1;
  wire       [2:0]    tmp_write_ifmap_base_pointer_next_2;
  wire       [2:0]    tmp_write_ifmap_base_pointer_next_3;
  wire       [1:0]    tmp_write_ifmap_base_pointer_next_4;
  wire       [7:0]    tmp_when;
  wire       [7:0]    tmp_write_mean_addr_next;
  wire       [1:0]    tmp_write_mean_addr_next_1;
  wire       [7:0]    tmp_write_mean_addr_max;
  wire       [5:0]    tmp_write_mean_addr_max_1;
  wire       [7:0]    tmp_when_1;
  wire       [27:0]   tmp_write_mean_data;
  wire       [6:0]    tmp_read_mean_addr_ov;
  wire       [6:0]    tmp_read_mean_addr_ov_1;
  wire       [6:0]    tmp_read_mean_addr_ov_2;
  wire       [11:0]   tmp_read_out_min_selected;
  wire       [15:0]   tmp_mean_cal_sum_buffer;
  wire       [8:0]    tmp_read_norm_cnt_max;
  wire       [11:0]   tmp_read_norm_cnt_max_1;
  wire       [8:0]    tmp_read_norm_cnt_max_2;
  wire       [7:0]    tmp_read_norm_cnt_ov;
  wire       [7:0]    tmp_multi_seq_addr_max;
  wire       [5:0]    tmp_multi_seq_addr_max_1;
  wire       [7:0]    tmp_read_norm_addr_stored_next;
  wire       [1:0]    tmp_read_norm_addr_stored_next_1;
  wire       [7:0]    tmp_multi_seq_addr_base;
  wire       [7:0]    tmp_cal_norm_read_addr;
  wire       [7:0]    tmp_cal_norm_read_addr_1;
  wire       [6:0]    tmp_cal_norm_read_addr_2;
  wire       [5:0]    tmp_cal_norm_read_addr_3;
  reg        [7:0]    tmp_datain;
  wire       [3:0]    tmp_mean_num_log;
  wire       [6:0]    tmp_store_norm_write_cnt_ov;
  wire       [6:0]    tmp_store_norm_write_cnt_ov_1;
  wire       [8:0]    tmp_store_norm_write_cnt_ov_2;
  wire       [7:0]    tmp_read_ifmap_base_pointer_next;
  wire       [3:0]    tmp_read_ifmap_base_pointer_next_1;
  wire       [2:0]    tmp_read_ifmap_base_pointer_next_2;
  wire       [2:0]    tmp_read_ifmap_base_pointer_next_3;
  wire       [1:0]    tmp_read_ifmap_base_pointer_next_4;
  wire       [7:0]    tmp_when_2;
  reg        [31:0]   tmp_cache_wdata;
  wire       [31:0]   tmp_wdata_sel;
  wire       [6:0]    tmp_coef_addr;
  wire       [13:0]   tmp_coef_addr_1;
  reg                 norm_cal_end_ack;
  wire                postprocess_end_pulse;
  wire                iq_ready_pulse;
  reg                 iq_cal_en_reg;
  reg                 fdt_sampling_regNext;
  wire                fdt_start_pulse_80m;
  reg        [31:0]   norm_data_gather_0;
  reg        [31:0]   norm_data_gather_1;
  reg        [31:0]   norm_data_gather_2;
  reg        [31:0]   norm_data_gather_3;
  reg        [2:0]    curr_state;
  reg        [2:0]    next_state;
  reg        [4:0]    fdt_sample_time_cnt;
  wire       [4:0]    fdt_time_cnt_max;
  wire                fdt_sample_time_cnt_ov;
  reg                 fdt_sampling_regNext_1;
  wire                fdt_start_once;
  wire                seq_num_is_zero_flag;
  reg                 rnn_start_once;
  reg                 rg_fdt_en_regNext;
  wire                fdt_en_pos;
  reg                 all_ifmap_ready_flag;
  reg        [6:0]    read_ifmap_base_pointer;
  reg        [6:0]    write_ifmap_base_pointer;
  wire       [6:0]    write_ifmap_addr;
  reg        [6:0]    write_mean_addr;
  reg        [6:0]    read_mean_addr;
  wire                read_mean_addr_ov;
  reg                 read_mean_addr_ov_delay;
  reg        [6:0]    cal_norm_read_addr;
  reg        [6:0]    store_norm_write_cnt;
  wire       [6:0]    store_norm_write_addr;
  wire                store_norm_write_cnt_ov;
  wire                read_norm_quarter_ov;
  reg                 read_norm_quarter_ov_delay;
  wire                store_norm_state_out_pulse;
  reg        [1:0]    write_ifmap_cnt;
  wire                write_ifmap_cnt_incr;
  reg                 write_ifmap_doing;
  wire                write_ifmap_cnt_ov;
  reg                 write_ifmap_cnt_ov_delay;
  reg                 label_seq_decide_unit_delay;
  wire                fdt_result_up_pulse;
  wire                fdt_result_down_pulse;
  reg                 norm_cal_end_ack_regNext;
  wire                post_process_done;
  wire                normal_rnn_start;
  wire                state_is_cal_mean;
  wire                state_is_cal_norm;
  wire                state_is_store_norm;
  wire                statein_store_amp;
  wire                statein_store_mean;
  wire                statein_cal_mean;
  wire                statein_cal_norm;
  wire                stateout_cal_mean;
  wire                stateout_cal_norm;
  reg                 fdt_once_done_comp;
  reg                 fdt_once_done_comp_regNext;
  wire       [6:0]    write_ifmap_base_init;
  wire       [6:0]    write_ifmap_max_addr;
  wire       [7:0]    write_ifmap_base_pointer_next;
  wire       [2:0]    mean_log2_num;
  reg        [2:0]    seq_num_log2;
  wire       [3:0]    global_mean_log2_num;
  wire       [4:0]    mean_num;
  wire       [7:0]    write_mean_addr_next;
  wire       [7:0]    write_mean_addr_max;
  wire       [11:0]   amp_mean_data;
  wire       [7:0]    amp_max_data;
  wire       [7:0]    amp_min_data;
  wire       [31:0]   write_mean_data;
  wire                read_mean_addr_incr;
  reg        [15:0]   mean_cal_sum_buffer;
  reg        [7:0]    mean_cal_max_buffer;
  reg        [7:0]    mean_cal_min_buffer;
  wire       [11:0]   read_out_mean;
  wire       [7:0]    read_out_min;
  wire       [7:0]    read_out_max;
  wire       [7:0]    read_out_mean_multiseq_mode;
  wire       [11:0]   read_out_min_selected;
  reg        [7:0]    norm_store_buffer_0;
  reg        [7:0]    norm_store_buffer_1;
  reg        [7:0]    norm_store_buffer_2;
  reg        [7:0]    norm_store_buffer_3;
  wire       [8:0]    read_norm_cnt_max;
  reg        [7:0]    read_norm_cnt;
  wire                read_norm_cnt_ov;
  wire       [1:0]    read_norm_quarter_cnt;
  wire                read_norm_cnt_incr;
  reg        [6:0]    read_norm_addr_stored;
  wire       [7:0]    read_norm_addr_stored_next;
  wire       [7:0]    multi_seq_addr_max;
  wire       [7:0]    multi_seq_addr_base;
  reg        [1:0]    read_norm_quarter_cnt_delay;
  reg                 norm_store_buffer_store_en;
  wire       [7:0]    norm_rdata_split_0;
  wire       [7:0]    norm_rdata_split_1;
  wire       [7:0]    norm_rdata_split_2;
  wire       [7:0]    norm_rdata_split_3;
  wire       [3:0]    tmp_1;
  wire       [7:0]    tmp_norm_store_buffer_0;
  wire       [31:0]   store_norm_data;
  reg                 state_is_store_norm_regNext;
  wire                store_norm_ena;
  reg                 store_norm_ena_regNext;
  wire       [7:0]    read_ifmap_base_pointer_next;
  wire       [14:0]   coef_addr_1;
  reg        [3:0]    bitsel;
  reg        [31:0]   wdata_sel;
  reg        [15:0]   rdata_sel;
  reg                 tmp_2;
  reg                 rnn_en_reg;
  `ifndef SYNTHESIS
  reg [79:0] curr_state_string;
  reg [79:0] next_state_string;
  `endif


  assign tmp_norm_data_gather_0 = post_process_unit_smpArrayQ_0[7 : 0];
  assign tmp_norm_data_gather_0_1 = post_process_unit_smpArrayI_0[7 : 0];
  assign tmp_norm_data_gather_0_2 = post_process_unit_smpArrayQ_1[7 : 0];
  assign tmp_norm_data_gather_0_3 = post_process_unit_smpArrayI_1[7 : 0];
  assign tmp_norm_data_gather_0_4 = post_process_unit_smpArrayQ_2[7 : 0];
  assign tmp_norm_data_gather_0_5 = post_process_unit_smpArrayI_2[7 : 0];
  assign tmp_norm_data_gather_0_6 = post_process_unit_smpArrayQ_3[7 : 0];
  assign tmp_norm_data_gather_0_7 = post_process_unit_smpArrayI_3[7 : 0];
  assign tmp_norm_data_gather_1 = post_process_unit_smpArrayQ_4[7 : 0];
  assign tmp_norm_data_gather_1_1 = post_process_unit_smpArrayI_4[7 : 0];
  assign tmp_norm_data_gather_1_2 = post_process_unit_smpArrayQ_5[7 : 0];
  assign tmp_norm_data_gather_1_3 = post_process_unit_smpArrayI_5[7 : 0];
  assign tmp_norm_data_gather_1_4 = post_process_unit_smpArrayQ_6[7 : 0];
  assign tmp_norm_data_gather_1_5 = post_process_unit_smpArrayI_6[7 : 0];
  assign tmp_norm_data_gather_1_6 = post_process_unit_smpArrayQ_7[7 : 0];
  assign tmp_norm_data_gather_1_7 = post_process_unit_smpArrayI_7[7 : 0];
  assign tmp_norm_data_gather_2 = post_process_unit_smpArrayQ_8[7 : 0];
  assign tmp_norm_data_gather_2_1 = post_process_unit_smpArrayI_8[7 : 0];
  assign tmp_norm_data_gather_2_2 = post_process_unit_smpArrayQ_9[7 : 0];
  assign tmp_norm_data_gather_2_3 = post_process_unit_smpArrayI_9[7 : 0];
  assign tmp_norm_data_gather_2_4 = post_process_unit_smpArrayQ_10[7 : 0];
  assign tmp_norm_data_gather_2_5 = post_process_unit_smpArrayI_10[7 : 0];
  assign tmp_norm_data_gather_2_6 = post_process_unit_smpArrayQ_11[7 : 0];
  assign tmp_norm_data_gather_2_7 = post_process_unit_smpArrayI_11[7 : 0];
  assign tmp_norm_data_gather_3 = post_process_unit_smpArrayQ_12[7 : 0];
  assign tmp_norm_data_gather_3_1 = post_process_unit_smpArrayI_12[7 : 0];
  assign tmp_norm_data_gather_3_2 = post_process_unit_smpArrayQ_13[7 : 0];
  assign tmp_norm_data_gather_3_3 = post_process_unit_smpArrayI_13[7 : 0];
  assign tmp_norm_data_gather_3_4 = post_process_unit_smpArrayQ_14[7 : 0];
  assign tmp_norm_data_gather_3_5 = post_process_unit_smpArrayI_14[7 : 0];
  assign tmp_norm_data_gather_3_6 = post_process_unit_smpArrayQ_15[7 : 0];
  assign tmp_norm_data_gather_3_7 = post_process_unit_smpArrayI_15[7 : 0];
  assign tmp_fdt_time_cnt_max = (tmp_fdt_time_cnt_max_1 - 5'h01);
  assign tmp_fdt_time_cnt_max_1 = (5'h01 <<< rg_amp_sample_num_log2);
  assign tmp_fdt_time_cnt_max_2 = {1'd0, rg_rnn_seq_num};
  assign tmp_write_ifmap_addr = {5'd0, write_ifmap_cnt};
  assign tmp_write_ifmap_max_addr = (7'h38 + rg_cache_ofmap_base_addr);
  assign tmp_write_ifmap_base_pointer_next_1 = {1'b0,tmp_write_ifmap_base_pointer_next_2};
  assign tmp_write_ifmap_base_pointer_next = {4'd0, tmp_write_ifmap_base_pointer_next_1};
  assign tmp_write_ifmap_base_pointer_next_2 = ({1'b0,rg_rnn_ifmap_groupnum} + tmp_write_ifmap_base_pointer_next_3);
  assign tmp_write_ifmap_base_pointer_next_4 = {1'b0,1'b1};
  assign tmp_write_ifmap_base_pointer_next_3 = {1'd0, tmp_write_ifmap_base_pointer_next_4};
  assign tmp_when = {1'd0, write_ifmap_max_addr};
  assign tmp_write_mean_addr_next_1 = {1'b0,1'b1};
  assign tmp_write_mean_addr_next = {6'd0, tmp_write_mean_addr_next_1};
  assign tmp_write_mean_addr_max_1 = {1'b0,mean_num};
  assign tmp_write_mean_addr_max = {2'd0, tmp_write_mean_addr_max_1};
  assign tmp_when_1 = {1'd0, write_mean_addr};
  assign tmp_write_mean_data = {amp_max_data,{amp_min_data,amp_mean_data}};
  assign tmp_read_mean_addr_ov = (tmp_read_mean_addr_ov_1 - 7'h01);
  assign tmp_read_mean_addr_ov_1 = (7'h58 + tmp_read_mean_addr_ov_2);
  assign tmp_read_mean_addr_ov_2 = {2'd0, mean_num};
  assign tmp_read_out_min_selected = {4'd0, read_out_mean_multiseq_mode};
  assign tmp_mean_cal_sum_buffer = {4'd0, read_out_min_selected};
  assign tmp_read_norm_cnt_max_1 = ({7'd0,mean_num} <<< rg_amp_sample_num_log2);
  assign tmp_read_norm_cnt_max = tmp_read_norm_cnt_max_1[8:0];
  assign tmp_read_norm_cnt_max_2 = {4'd0, mean_num};
  assign tmp_read_norm_cnt_ov = read_norm_cnt_max[7:0];
  assign tmp_multi_seq_addr_max_1 = {1'b0,mean_num};
  assign tmp_multi_seq_addr_max = {2'd0, tmp_multi_seq_addr_max_1};
  assign tmp_read_norm_addr_stored_next_1 = {1'b0,1'b1};
  assign tmp_read_norm_addr_stored_next = {6'd0, tmp_read_norm_addr_stored_next_1};
  assign tmp_multi_seq_addr_base = {1'd0, read_norm_addr_stored};
  assign tmp_cal_norm_read_addr = (multi_seq_addr_base - tmp_cal_norm_read_addr_1);
  assign tmp_cal_norm_read_addr_1 = {3'd0, mean_num};
  assign tmp_cal_norm_read_addr_3 = read_norm_cnt[7 : 2];
  assign tmp_cal_norm_read_addr_2 = {1'd0, tmp_cal_norm_read_addr_3};
  assign tmp_mean_num_log = {1'd0, mean_log2_num};
  assign tmp_store_norm_write_cnt_ov = (tmp_store_norm_write_cnt_ov_1 - 7'h01);
  assign tmp_store_norm_write_cnt_ov_1 = (tmp_store_norm_write_cnt_ov_2 >>> 2'd2);
  assign tmp_store_norm_write_cnt_ov_2 = (read_norm_cnt_max + 9'h001);
  assign tmp_read_ifmap_base_pointer_next_1 = {1'b0,tmp_read_ifmap_base_pointer_next_2};
  assign tmp_read_ifmap_base_pointer_next = {4'd0, tmp_read_ifmap_base_pointer_next_1};
  assign tmp_read_ifmap_base_pointer_next_2 = ({1'b0,rg_rnn_ifmap_groupnum} + tmp_read_ifmap_base_pointer_next_3);
  assign tmp_read_ifmap_base_pointer_next_4 = {1'b0,1'b1};
  assign tmp_read_ifmap_base_pointer_next_3 = {1'd0, tmp_read_ifmap_base_pointer_next_4};
  assign tmp_when_2 = {1'd0, rg_cache_ofmap_base_addr};
  assign tmp_wdata_sel = {16'd0, fdtmem_wdata};
  assign tmp_coef_addr_1 = coef_addr_1[14 : 1];
  assign tmp_coef_addr = tmp_coef_addr_1[6:0];
  clkGate_func u_clk_icg_amp_inner (
    .scan_en (scan_mode                 ), //i
    .enable  (amp_cal_clk_en            ), //i
    .clkout  (u_clk_icg_amp_inner_clkout), //o
    .clk_80m (clk_80m                   )  //i
  );
  amp_cal post_process_unit (
    .fdt_start_pulse                (fdt_start_pulse_80m                 ), //i
    .fdt_adc_in                     (fdt_adc_in[11:0]                    ), //i
    .fdt_adc_in_vld                 (fdt_adc_in_vld                      ), //i
    .fdt_therm_comp_one_hot         (fdt_therm_comp_one_hot[4:0]         ), //i
    .rg_fdt_therm_comp_amp_ratio_0  (rg_fdt_therm_comp_amp_ratio_0[2:0]  ), //i
    .rg_fdt_therm_comp_amp_ratio_1  (rg_fdt_therm_comp_amp_ratio_1[2:0]  ), //i
    .rg_fdt_therm_comp_amp_ratio_2  (rg_fdt_therm_comp_amp_ratio_2[2:0]  ), //i
    .rg_fdt_therm_comp_amp_ratio_3  (rg_fdt_therm_comp_amp_ratio_3[2:0]  ), //i
    .rg_fdt_therm_comp_amp_ratio_4  (rg_fdt_therm_comp_amp_ratio_4[2:0]  ), //i
    .amp_cal_end                    (post_process_unit_amp_cal_end       ), //o
    .norm_cal_end_pulse             (post_process_unit_norm_cal_end_pulse), //o
    .norm_cal_end_req               (post_process_unit_norm_cal_end_req  ), //o
    .norm_cal_end_ack               (norm_cal_end_ack                    ), //i
    .iq_ready_pulse                 (post_process_unit_iq_ready_pulse    ), //o
    .rg_fdt_en                      (rg_fdt_en                           ), //i
    .rg_fdt_wait_up                 (rg_fdt_wait_up                      ), //i
    .rg_fdt_wait_down               (rg_fdt_wait_down                    ), //i
    .rg_fdt_auto_exit_en            (rg_fdt_auto_exit_en                 ), //i
    .rg_amp_data_ratio              (rg_amp_data_ratio[2:0]              ), //i
    .rg_amp_global_norm_mode        (rg_amp_global_norm_mode             ), //i
    .rg_amp_multi_seq_norm_mode     (rg_amp_multi_seq_norm_mode          ), //i
    .rg_amp_samp_start_num          (rg_amp_samp_start_num[4:0]          ), //i
    .rg_amp_sample_num_log2         (rg_amp_sample_num_log2[2:0]         ), //i
    .rg_amp_samp_gap_num            (rg_amp_samp_gap_num[3:0]            ), //i
    .rg_rnn_single_step_mode        (rg_rnn_single_step_mode             ), //i
    .rg_rnn_single_step_init        (rg_rnn_single_step_init             ), //i
    .rg_rnn_data_ratio              (rg_rnn_data_ratio[2:0]              ), //i
    .rg_cache_ofmap_base_addr       (rg_cache_ofmap_base_addr[6:0]       ), //i
    .rg_rnn_seq_num                 (rg_rnn_seq_num[3:0]                 ), //i
    .rg_rnn_layer_num               (rg_rnn_layer_num[1:0]               ), //i
    .rg_rnn_ifmap_groupnum          (rg_rnn_ifmap_groupnum[1:0]          ), //i
    .rg_rnn_hidden_groupnum_layer_0 (rg_rnn_hidden_groupnum_layer_0[1:0] ), //i
    .rg_rnn_hidden_groupnum_layer_1 (rg_rnn_hidden_groupnum_layer_1[1:0] ), //i
    .rg_rnn_hidden_groupnum_layer_2 (rg_rnn_hidden_groupnum_layer_2[1:0] ), //i
    .rg_rnn_hidden_groupnum_layer_3 (rg_rnn_hidden_groupnum_layer_3[1:0] ), //i
    .rg_rnn_bias_addr_layer_0       (rg_rnn_bias_addr_layer_0[6:0]       ), //i
    .rg_rnn_bias_addr_layer_1       (rg_rnn_bias_addr_layer_1[6:0]       ), //i
    .rg_rnn_bias_addr_layer_2       (rg_rnn_bias_addr_layer_2[6:0]       ), //i
    .rg_rnn_bias_addr_layer_3       (rg_rnn_bias_addr_layer_3[6:0]       ), //i
    .rg_rnn_whi_addr_layer_0        (rg_rnn_whi_addr_layer_0[6:0]        ), //i
    .rg_rnn_whi_addr_layer_1        (rg_rnn_whi_addr_layer_1[6:0]        ), //i
    .rg_rnn_whi_addr_layer_2        (rg_rnn_whi_addr_layer_2[6:0]        ), //i
    .rg_rnn_whi_addr_layer_3        (rg_rnn_whi_addr_layer_3[6:0]        ), //i
    .rg_rnn_whh_addr_layer_0        (rg_rnn_whh_addr_layer_0[6:0]        ), //i
    .rg_rnn_whh_addr_layer_1        (rg_rnn_whh_addr_layer_1[6:0]        ), //i
    .rg_rnn_whh_addr_layer_2        (rg_rnn_whh_addr_layer_2[6:0]        ), //i
    .rg_rnn_whh_addr_layer_3        (rg_rnn_whh_addr_layer_3[6:0]        ), //i
    .rg_rnn_fc_bias_addr            (rg_rnn_fc_bias_addr[6:0]            ), //i
    .rg_rnn_fc_weight_addr          (rg_rnn_fc_weight_addr[6:0]          ), //i
    .rg_rnn_fc_label_num            (rg_rnn_fc_label_num[1:0]            ), //i
    .rg_fdt_label_seq_en            (rg_fdt_label_seq_en                 ), //i
    .rg_fdt_label_seq_length        (rg_fdt_label_seq_length[2:0]        ), //i
    .smpArrayI_0                    (post_process_unit_smpArrayI_0[12:0] ), //o
    .smpArrayI_1                    (post_process_unit_smpArrayI_1[12:0] ), //o
    .smpArrayI_2                    (post_process_unit_smpArrayI_2[12:0] ), //o
    .smpArrayI_3                    (post_process_unit_smpArrayI_3[12:0] ), //o
    .smpArrayI_4                    (post_process_unit_smpArrayI_4[12:0] ), //o
    .smpArrayI_5                    (post_process_unit_smpArrayI_5[12:0] ), //o
    .smpArrayI_6                    (post_process_unit_smpArrayI_6[12:0] ), //o
    .smpArrayI_7                    (post_process_unit_smpArrayI_7[12:0] ), //o
    .smpArrayI_8                    (post_process_unit_smpArrayI_8[12:0] ), //o
    .smpArrayI_9                    (post_process_unit_smpArrayI_9[12:0] ), //o
    .smpArrayI_10                   (post_process_unit_smpArrayI_10[12:0]), //o
    .smpArrayI_11                   (post_process_unit_smpArrayI_11[12:0]), //o
    .smpArrayI_12                   (post_process_unit_smpArrayI_12[12:0]), //o
    .smpArrayI_13                   (post_process_unit_smpArrayI_13[12:0]), //o
    .smpArrayI_14                   (post_process_unit_smpArrayI_14[12:0]), //o
    .smpArrayI_15                   (post_process_unit_smpArrayI_15[12:0]), //o
    .smpArrayQ_0                    (post_process_unit_smpArrayQ_0[12:0] ), //o
    .smpArrayQ_1                    (post_process_unit_smpArrayQ_1[12:0] ), //o
    .smpArrayQ_2                    (post_process_unit_smpArrayQ_2[12:0] ), //o
    .smpArrayQ_3                    (post_process_unit_smpArrayQ_3[12:0] ), //o
    .smpArrayQ_4                    (post_process_unit_smpArrayQ_4[12:0] ), //o
    .smpArrayQ_5                    (post_process_unit_smpArrayQ_5[12:0] ), //o
    .smpArrayQ_6                    (post_process_unit_smpArrayQ_6[12:0] ), //o
    .smpArrayQ_7                    (post_process_unit_smpArrayQ_7[12:0] ), //o
    .smpArrayQ_8                    (post_process_unit_smpArrayQ_8[12:0] ), //o
    .smpArrayQ_9                    (post_process_unit_smpArrayQ_9[12:0] ), //o
    .smpArrayQ_10                   (post_process_unit_smpArrayQ_10[12:0]), //o
    .smpArrayQ_11                   (post_process_unit_smpArrayQ_11[12:0]), //o
    .smpArrayQ_12                   (post_process_unit_smpArrayQ_12[12:0]), //o
    .smpArrayQ_13                   (post_process_unit_smpArrayQ_13[12:0]), //o
    .smpArrayQ_14                   (post_process_unit_smpArrayQ_14[12:0]), //o
    .smpArrayQ_15                   (post_process_unit_smpArrayQ_15[12:0]), //o
    .clkout                         (u_clk_icg_amp_inner_clkout          ), //i
    .rstn_80m                       (rstn_80m                            )  //i
  );
  rnn_layer rnn (
    .start_once                     (rnn_start_once                     ), //i
    .all_ifmap_ready_flag           (all_ifmap_ready_flag               ), //i
    .all_ifmap_ready_flag_clear     (rnn_all_ifmap_ready_flag_clear     ), //o
    .read_ifmap_base_pointer        (read_ifmap_base_pointer[6:0]       ), //i
    .coef_ena                       (rnn_coef_ena                       ), //o
    .coef_wena                      (rnn_coef_wena                      ), //o
    .coef_addr                      (rnn_coef_addr[6:0]                 ), //o
    .coef_wdata                     (rnn_coef_wdata[31:0]               ), //o
    .coef_rdata                     (rnn_coef_rdata[31:0]               ), //i
    .cache_ena                      (rnn_cache_ena                      ), //o
    .cache_wena                     (rnn_cache_wena                     ), //o
    .cache_addr                     (rnn_cache_addr[6:0]                ), //o
    .cache_wdata                    (rnn_cache_wdata[31:0]              ), //o
    .cache_rdata                    (cache_rdata[31:0]                  ), //i
    .rnn_pred_index                 (rnn_rnn_pred_index[1:0]            ), //o
    .done                           (rnn_done_1                         ), //o
    .rg_fdt_en                      (rg_fdt_en                          ), //i
    .rg_fdt_wait_up                 (rg_fdt_wait_up                     ), //i
    .rg_fdt_wait_down               (rg_fdt_wait_down                   ), //i
    .rg_fdt_auto_exit_en            (rg_fdt_auto_exit_en                ), //i
    .rg_amp_data_ratio              (rg_amp_data_ratio[2:0]             ), //i
    .rg_amp_global_norm_mode        (rg_amp_global_norm_mode            ), //i
    .rg_amp_multi_seq_norm_mode     (rg_amp_multi_seq_norm_mode         ), //i
    .rg_amp_samp_start_num          (rg_amp_samp_start_num[4:0]         ), //i
    .rg_amp_sample_num_log2         (rg_amp_sample_num_log2[2:0]        ), //i
    .rg_amp_samp_gap_num            (rg_amp_samp_gap_num[3:0]           ), //i
    .rg_rnn_single_step_mode        (rg_rnn_single_step_mode            ), //i
    .rg_rnn_single_step_init        (rg_rnn_single_step_init            ), //i
    .rg_rnn_data_ratio              (rg_rnn_data_ratio[2:0]             ), //i
    .rg_cache_ofmap_base_addr       (rg_cache_ofmap_base_addr[6:0]      ), //i
    .rg_rnn_seq_num                 (rg_rnn_seq_num[3:0]                ), //i
    .rg_rnn_layer_num               (rg_rnn_layer_num[1:0]              ), //i
    .rg_rnn_ifmap_groupnum          (rg_rnn_ifmap_groupnum[1:0]         ), //i
    .rg_rnn_hidden_groupnum_layer_0 (rg_rnn_hidden_groupnum_layer_0[1:0]), //i
    .rg_rnn_hidden_groupnum_layer_1 (rg_rnn_hidden_groupnum_layer_1[1:0]), //i
    .rg_rnn_hidden_groupnum_layer_2 (rg_rnn_hidden_groupnum_layer_2[1:0]), //i
    .rg_rnn_hidden_groupnum_layer_3 (rg_rnn_hidden_groupnum_layer_3[1:0]), //i
    .rg_rnn_bias_addr_layer_0       (rg_rnn_bias_addr_layer_0[6:0]      ), //i
    .rg_rnn_bias_addr_layer_1       (rg_rnn_bias_addr_layer_1[6:0]      ), //i
    .rg_rnn_bias_addr_layer_2       (rg_rnn_bias_addr_layer_2[6:0]      ), //i
    .rg_rnn_bias_addr_layer_3       (rg_rnn_bias_addr_layer_3[6:0]      ), //i
    .rg_rnn_whi_addr_layer_0        (rg_rnn_whi_addr_layer_0[6:0]       ), //i
    .rg_rnn_whi_addr_layer_1        (rg_rnn_whi_addr_layer_1[6:0]       ), //i
    .rg_rnn_whi_addr_layer_2        (rg_rnn_whi_addr_layer_2[6:0]       ), //i
    .rg_rnn_whi_addr_layer_3        (rg_rnn_whi_addr_layer_3[6:0]       ), //i
    .rg_rnn_whh_addr_layer_0        (rg_rnn_whh_addr_layer_0[6:0]       ), //i
    .rg_rnn_whh_addr_layer_1        (rg_rnn_whh_addr_layer_1[6:0]       ), //i
    .rg_rnn_whh_addr_layer_2        (rg_rnn_whh_addr_layer_2[6:0]       ), //i
    .rg_rnn_whh_addr_layer_3        (rg_rnn_whh_addr_layer_3[6:0]       ), //i
    .rg_rnn_fc_bias_addr            (rg_rnn_fc_bias_addr[6:0]           ), //i
    .rg_rnn_fc_weight_addr          (rg_rnn_fc_weight_addr[6:0]         ), //i
    .rg_rnn_fc_label_num            (rg_rnn_fc_label_num[1:0]           ), //i
    .rg_fdt_label_seq_en            (rg_fdt_label_seq_en                ), //i
    .rg_fdt_label_seq_length        (rg_fdt_label_seq_length[2:0]       ), //i
    .label_result_0                 (rnn_label_result_0[15:0]           ), //o
    .label_result_1                 (rnn_label_result_1[15:0]           ), //o
    .label_result_2                 (rnn_label_result_2[15:0]           ), //o
    .label_result_3                 (rnn_label_result_3[15:0]           ), //o
    .rnn_clk_en                     (rnn_clk_en                         ), //i
    .single_step_every_done         (rnn_single_step_every_done         ), //o
    .matmul_done_once               (rnn_matmul_done_once               ), //o
    .clk                            (clk                                ), //i
    .resetn                         (resetn                             )  //i
  );
  label_seq_decide label_seq_decide_unit (
    .label_vld                      (rnn_done_1                                 ), //i
    .rnn_pred_index                 (rnn_rnn_pred_index[1:0]                    ), //i
    .done                           (label_seq_decide_unit_done                 ), //o
    .pred_index_out                 (label_seq_decide_unit_pred_index_out       ), //o
    .rg_fdt_en                      (rg_fdt_en                                  ), //i
    .rg_fdt_wait_up                 (rg_fdt_wait_up                             ), //i
    .rg_fdt_wait_down               (rg_fdt_wait_down                           ), //i
    .rg_fdt_auto_exit_en            (rg_fdt_auto_exit_en                        ), //i
    .rg_amp_data_ratio              (rg_amp_data_ratio[2:0]                     ), //i
    .rg_amp_global_norm_mode        (rg_amp_global_norm_mode                    ), //i
    .rg_amp_multi_seq_norm_mode     (rg_amp_multi_seq_norm_mode                 ), //i
    .rg_amp_samp_start_num          (rg_amp_samp_start_num[4:0]                 ), //i
    .rg_amp_sample_num_log2         (rg_amp_sample_num_log2[2:0]                ), //i
    .rg_amp_samp_gap_num            (rg_amp_samp_gap_num[3:0]                   ), //i
    .rg_rnn_single_step_mode        (rg_rnn_single_step_mode                    ), //i
    .rg_rnn_single_step_init        (rg_rnn_single_step_init                    ), //i
    .rg_rnn_data_ratio              (rg_rnn_data_ratio[2:0]                     ), //i
    .rg_cache_ofmap_base_addr       (rg_cache_ofmap_base_addr[6:0]              ), //i
    .rg_rnn_seq_num                 (rg_rnn_seq_num[3:0]                        ), //i
    .rg_rnn_layer_num               (rg_rnn_layer_num[1:0]                      ), //i
    .rg_rnn_ifmap_groupnum          (rg_rnn_ifmap_groupnum[1:0]                 ), //i
    .rg_rnn_hidden_groupnum_layer_0 (rg_rnn_hidden_groupnum_layer_0[1:0]        ), //i
    .rg_rnn_hidden_groupnum_layer_1 (rg_rnn_hidden_groupnum_layer_1[1:0]        ), //i
    .rg_rnn_hidden_groupnum_layer_2 (rg_rnn_hidden_groupnum_layer_2[1:0]        ), //i
    .rg_rnn_hidden_groupnum_layer_3 (rg_rnn_hidden_groupnum_layer_3[1:0]        ), //i
    .rg_rnn_bias_addr_layer_0       (rg_rnn_bias_addr_layer_0[6:0]              ), //i
    .rg_rnn_bias_addr_layer_1       (rg_rnn_bias_addr_layer_1[6:0]              ), //i
    .rg_rnn_bias_addr_layer_2       (rg_rnn_bias_addr_layer_2[6:0]              ), //i
    .rg_rnn_bias_addr_layer_3       (rg_rnn_bias_addr_layer_3[6:0]              ), //i
    .rg_rnn_whi_addr_layer_0        (rg_rnn_whi_addr_layer_0[6:0]               ), //i
    .rg_rnn_whi_addr_layer_1        (rg_rnn_whi_addr_layer_1[6:0]               ), //i
    .rg_rnn_whi_addr_layer_2        (rg_rnn_whi_addr_layer_2[6:0]               ), //i
    .rg_rnn_whi_addr_layer_3        (rg_rnn_whi_addr_layer_3[6:0]               ), //i
    .rg_rnn_whh_addr_layer_0        (rg_rnn_whh_addr_layer_0[6:0]               ), //i
    .rg_rnn_whh_addr_layer_1        (rg_rnn_whh_addr_layer_1[6:0]               ), //i
    .rg_rnn_whh_addr_layer_2        (rg_rnn_whh_addr_layer_2[6:0]               ), //i
    .rg_rnn_whh_addr_layer_3        (rg_rnn_whh_addr_layer_3[6:0]               ), //i
    .rg_rnn_fc_bias_addr            (rg_rnn_fc_bias_addr[6:0]                   ), //i
    .rg_rnn_fc_weight_addr          (rg_rnn_fc_weight_addr[6:0]                 ), //i
    .rg_rnn_fc_label_num            (rg_rnn_fc_label_num[1:0]                   ), //i
    .rg_fdt_label_seq_en            (rg_fdt_label_seq_en                        ), //i
    .rg_fdt_label_seq_length        (rg_fdt_label_seq_length[2:0]               ), //i
    .label_seq_buffer               (label_seq_decide_unit_label_seq_buffer[7:0]), //o
    .clk                            (clk                                        ), //i
    .resetn                         (resetn                                     )  //i
  );
  norm_unit norm_cal_unit (
    .datain       (norm_cal_unit_datain[7:0]      ), //i
    .data_ratio   (rg_rnn_data_ratio[2:0]         ), //i
    .sum          (mean_cal_sum_buffer[15:0]      ), //i
    .mean_num_log (norm_cal_unit_mean_num_log[3:0]), //i
    .max          (mean_cal_max_buffer[7:0]       ), //i
    .min          (mean_cal_min_buffer[7:0]       ), //i
    .norm_out     (norm_cal_unit_norm_out[7:0]    )  //o
  );
  always @(*) begin
    case(read_norm_quarter_cnt_delay)
      2'b00 : tmp_datain = norm_rdata_split_0;
      2'b01 : tmp_datain = norm_rdata_split_1;
      2'b10 : tmp_datain = norm_rdata_split_2;
      default : tmp_datain = norm_rdata_split_3;
    endcase
  end

  always @(*) begin
    case(write_ifmap_cnt)
      2'b00 : tmp_cache_wdata = norm_data_gather_0;
      2'b01 : tmp_cache_wdata = norm_data_gather_1;
      2'b10 : tmp_cache_wdata = norm_data_gather_2;
      default : tmp_cache_wdata = norm_data_gather_3;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(curr_state)
      FDTSTATE_IDLE : curr_state_string = "IDLE      ";
      FDTSTATE_STORE_AMP : curr_state_string = "STORE_AMP ";
      FDTSTATE_STORE_MEAN : curr_state_string = "STORE_MEAN";
      FDTSTATE_CAL_MEAN : curr_state_string = "CAL_MEAN  ";
      FDTSTATE_CAL_NORM : curr_state_string = "CAL_NORM  ";
      FDTSTATE_STORE_NORM : curr_state_string = "STORE_NORM";
      default : curr_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      FDTSTATE_IDLE : next_state_string = "IDLE      ";
      FDTSTATE_STORE_AMP : next_state_string = "STORE_AMP ";
      FDTSTATE_STORE_MEAN : next_state_string = "STORE_MEAN";
      FDTSTATE_CAL_MEAN : next_state_string = "CAL_MEAN  ";
      FDTSTATE_CAL_NORM : next_state_string = "CAL_NORM  ";
      FDTSTATE_STORE_NORM : next_state_string = "STORE_NORM";
      default : next_state_string = "??????????";
    endcase
  end
  `endif

  assign fdt_start_pulse_80m = (fdt_sampling && (! fdt_sampling_regNext));
  assign amp_cal_clk_en = ((iq_cal_en_reg || iq_ready_pulse) || fdt_adc_in_vld);
  assign iq_ready_pulse = post_process_unit_iq_ready_pulse;
  assign postprocess_end_pulse = post_process_unit_norm_cal_end_pulse;
  always @(*) begin
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_0[7 : 0] = tmp_norm_data_gather_0;
    end else begin
      norm_data_gather_0[7 : 0] = tmp_norm_data_gather_0_1;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_0[15 : 8] = tmp_norm_data_gather_0_2;
    end else begin
      norm_data_gather_0[15 : 8] = tmp_norm_data_gather_0_3;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_0[23 : 16] = tmp_norm_data_gather_0_4;
    end else begin
      norm_data_gather_0[23 : 16] = tmp_norm_data_gather_0_5;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_0[31 : 24] = tmp_norm_data_gather_0_6;
    end else begin
      norm_data_gather_0[31 : 24] = tmp_norm_data_gather_0_7;
    end
  end

  always @(*) begin
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_1[7 : 0] = tmp_norm_data_gather_1;
    end else begin
      norm_data_gather_1[7 : 0] = tmp_norm_data_gather_1_1;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_1[15 : 8] = tmp_norm_data_gather_1_2;
    end else begin
      norm_data_gather_1[15 : 8] = tmp_norm_data_gather_1_3;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_1[23 : 16] = tmp_norm_data_gather_1_4;
    end else begin
      norm_data_gather_1[23 : 16] = tmp_norm_data_gather_1_5;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_1[31 : 24] = tmp_norm_data_gather_1_6;
    end else begin
      norm_data_gather_1[31 : 24] = tmp_norm_data_gather_1_7;
    end
  end

  always @(*) begin
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_2[7 : 0] = tmp_norm_data_gather_2;
    end else begin
      norm_data_gather_2[7 : 0] = tmp_norm_data_gather_2_1;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_2[15 : 8] = tmp_norm_data_gather_2_2;
    end else begin
      norm_data_gather_2[15 : 8] = tmp_norm_data_gather_2_3;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_2[23 : 16] = tmp_norm_data_gather_2_4;
    end else begin
      norm_data_gather_2[23 : 16] = tmp_norm_data_gather_2_5;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_2[31 : 24] = tmp_norm_data_gather_2_6;
    end else begin
      norm_data_gather_2[31 : 24] = tmp_norm_data_gather_2_7;
    end
  end

  always @(*) begin
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_3[7 : 0] = tmp_norm_data_gather_3;
    end else begin
      norm_data_gather_3[7 : 0] = tmp_norm_data_gather_3_1;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_3[15 : 8] = tmp_norm_data_gather_3_2;
    end else begin
      norm_data_gather_3[15 : 8] = tmp_norm_data_gather_3_3;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_3[23 : 16] = tmp_norm_data_gather_3_4;
    end else begin
      norm_data_gather_3[23 : 16] = tmp_norm_data_gather_3_5;
    end
    if(rg_amp_global_norm_mode) begin
      norm_data_gather_3[31 : 24] = tmp_norm_data_gather_3_6;
    end else begin
      norm_data_gather_3[31 : 24] = tmp_norm_data_gather_3_7;
    end
  end

  assign fdt_time_cnt_max = (rg_amp_multi_seq_norm_mode ? tmp_fdt_time_cnt_max : tmp_fdt_time_cnt_max_2);
  assign fdt_sample_time_cnt_ov = (fdt_sample_time_cnt == fdt_time_cnt_max);
  assign fdt_start_once = (fdt_sampling && (! fdt_sampling_regNext_1));
  assign seq_num_is_zero_flag = (rg_rnn_seq_num == 4'b0000);
  assign fdt_en_pos = (rg_fdt_en && (! rg_fdt_en_regNext));
  assign write_ifmap_once_done = write_ifmap_cnt_ov;
  assign matmul_done_once = rnn_matmul_done_once;
  assign rnn_done = label_seq_decide_unit_done;
  assign rg_fdt_label_seq_buffer = label_seq_decide_unit_label_seq_buffer;
  assign fdt_result_up_pulse = (label_seq_decide_unit_delay && rg_fdt_result_up);
  assign fdt_result_down_pulse = (label_seq_decide_unit_delay && rg_fdt_result_down);
  assign rg_fdt_pred_index = rnn_rnn_pred_index;
  assign fdt_up_int = (rg_fdt_wait_up && fdt_result_up_pulse);
  assign fdt_down_int = (rg_fdt_wait_down && fdt_result_down_pulse);
  always @(*) begin
    if(rg_fdt_auto_exit_en) begin
      fdt_auto_exit_pulse = (fdt_up_int || fdt_down_int);
    end else begin
      fdt_auto_exit_pulse = 1'b0;
    end
  end

  assign label_result_0 = rnn_label_result_0;
  assign label_result_1 = rnn_label_result_1;
  assign label_result_2 = rnn_label_result_2;
  assign label_result_3 = rnn_label_result_3;
  assign post_process_done = ((! norm_cal_end_ack) && norm_cal_end_ack_regNext);
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      FDTSTATE_IDLE : begin
        if(post_process_done) begin
          if(rg_amp_global_norm_mode) begin
            next_state = FDTSTATE_STORE_AMP;
          end else begin
            if(rg_amp_multi_seq_norm_mode) begin
              next_state = FDTSTATE_STORE_MEAN;
            end else begin
              next_state = FDTSTATE_STORE_AMP;
            end
          end
        end
      end
      FDTSTATE_STORE_AMP : begin
        if(write_ifmap_cnt_ov_delay) begin
          if(rg_amp_global_norm_mode) begin
            next_state = FDTSTATE_STORE_MEAN;
          end else begin
            next_state = FDTSTATE_IDLE;
          end
        end
      end
      FDTSTATE_STORE_MEAN : begin
        if(fdt_sample_time_cnt_ov) begin
          next_state = FDTSTATE_CAL_MEAN;
        end else begin
          next_state = FDTSTATE_IDLE;
        end
      end
      FDTSTATE_CAL_MEAN : begin
        if(read_mean_addr_ov_delay) begin
          next_state = FDTSTATE_CAL_NORM;
        end
      end
      FDTSTATE_CAL_NORM : begin
        if(read_norm_quarter_ov_delay) begin
          next_state = FDTSTATE_STORE_NORM;
        end
      end
      default : begin
        if(store_norm_state_out_pulse) begin
          if(store_norm_write_cnt_ov) begin
            next_state = FDTSTATE_IDLE;
          end else begin
            next_state = FDTSTATE_CAL_NORM;
          end
        end
      end
    endcase
  end

  assign normal_rnn_start = (fdt_start_once && fdt_sample_time_cnt_ov);
  assign state_is_cal_mean = (curr_state == FDTSTATE_CAL_MEAN);
  assign state_is_cal_norm = (curr_state == FDTSTATE_CAL_NORM);
  assign state_is_store_norm = (curr_state == FDTSTATE_STORE_NORM);
  assign statein_store_amp = ((curr_state != FDTSTATE_STORE_AMP) && (next_state == FDTSTATE_STORE_AMP));
  assign statein_store_mean = ((curr_state != FDTSTATE_STORE_MEAN) && (next_state == FDTSTATE_STORE_MEAN));
  assign statein_cal_mean = ((curr_state != FDTSTATE_CAL_MEAN) && (next_state == FDTSTATE_CAL_MEAN));
  assign statein_cal_norm = ((curr_state != FDTSTATE_CAL_NORM) && (next_state == FDTSTATE_CAL_NORM));
  assign stateout_cal_mean = ((curr_state == FDTSTATE_CAL_MEAN) && (next_state != FDTSTATE_CAL_MEAN));
  assign stateout_cal_norm = ((curr_state == FDTSTATE_CAL_NORM) && (next_state != FDTSTATE_CAL_NORM));
  always @(*) begin
    rnn_start_once = 1'b0;
    if((rg_amp_global_norm_mode || rg_amp_multi_seq_norm_mode)) begin
      rnn_start_once = ((curr_state == FDTSTATE_STORE_NORM) && (next_state == FDTSTATE_IDLE));
    end else begin
      if(seq_num_is_zero_flag) begin
        rnn_start_once = write_ifmap_once_done;
      end else begin
        rnn_start_once = normal_rnn_start;
      end
    end
  end

  always @(*) begin
    if(fdt_sample_time_cnt_ov) begin
      fdt_once_done_comp = rnn_done;
    end else begin
      if((rg_amp_global_norm_mode || rg_amp_multi_seq_norm_mode)) begin
        fdt_once_done_comp = ((curr_state == FDTSTATE_STORE_MEAN) && (next_state == FDTSTATE_IDLE));
      end else begin
        fdt_once_done_comp = ((curr_state == FDTSTATE_STORE_AMP) && (next_state == FDTSTATE_IDLE));
      end
    end
  end

  assign fdt_once_done = fdt_once_done_comp_regNext;
  assign single_step_every_done = rnn_single_step_every_done;
  assign write_ifmap_cnt_incr = (write_ifmap_doing && (! rnn_cache_ena));
  assign write_ifmap_cnt_ov = ((write_ifmap_cnt == rg_rnn_ifmap_groupnum) && write_ifmap_cnt_incr);
  assign write_ifmap_addr = (write_ifmap_base_pointer + tmp_write_ifmap_addr);
  assign write_ifmap_base_init = (rg_amp_global_norm_mode ? 7'h38 : 7'h00);
  assign write_ifmap_max_addr = (rg_amp_global_norm_mode ? tmp_write_ifmap_max_addr : rg_cache_ofmap_base_addr);
  assign write_ifmap_base_pointer_next = ({1'b0,write_ifmap_base_pointer} + tmp_write_ifmap_base_pointer_next);
  always @(*) begin
    if((rg_rnn_seq_num == 4'b1111)) begin
      seq_num_log2 = 3'b100;
    end else begin
      if((rg_rnn_seq_num == 4'b0111)) begin
        seq_num_log2 = 3'b011;
      end else begin
        if((rg_rnn_seq_num == 4'b0011)) begin
          seq_num_log2 = 3'b010;
        end else begin
          if((rg_rnn_seq_num == 4'b0001)) begin
            seq_num_log2 = 3'b001;
          end else begin
            if((rg_rnn_seq_num == 4'b0000)) begin
              seq_num_log2 = 3'b000;
            end else begin
              seq_num_log2 = 3'b100;
            end
          end
        end
      end
    end
  end

  assign mean_log2_num = (rg_amp_global_norm_mode ? seq_num_log2 : rg_amp_sample_num_log2);
  assign global_mean_log2_num = ({1'b0,rg_amp_sample_num_log2} + {1'b0,seq_num_log2});
  assign mean_num = (5'h01 <<< mean_log2_num);
  assign write_mean_addr_next = ({1'b0,write_mean_addr} + tmp_write_mean_addr_next);
  assign write_mean_addr_max = (tmp_write_mean_addr_max + {1'b0,7'h57});
  assign amp_mean_data = post_process_unit_smpArrayI_0[11 : 0];
  assign amp_max_data = post_process_unit_smpArrayI_1[7 : 0];
  assign amp_min_data = post_process_unit_smpArrayI_2[7 : 0];
  assign write_mean_data = {4'd0, tmp_write_mean_data};
  assign read_mean_addr_ov = (read_mean_addr == tmp_read_mean_addr_ov);
  assign read_mean_addr_incr = ((state_is_cal_mean || statein_cal_mean) && (! stateout_cal_mean));
  assign read_out_mean = cache_rdata[11 : 0];
  assign read_out_min = cache_rdata[19 : 12];
  assign read_out_max = cache_rdata[27 : 20];
  assign read_out_mean_multiseq_mode = read_out_mean[7 : 0];
  assign read_out_min_selected = (rg_amp_multi_seq_norm_mode ? tmp_read_out_min_selected : read_out_mean);
  assign read_norm_cnt_max = ((rg_amp_global_norm_mode ? tmp_read_norm_cnt_max : tmp_read_norm_cnt_max_2) - 9'h001);
  assign read_norm_cnt_ov = (read_norm_cnt == tmp_read_norm_cnt_ov);
  assign read_norm_quarter_cnt = read_norm_cnt[1 : 0];
  assign read_norm_quarter_ov = (read_norm_quarter_cnt == 2'b11);
  assign read_norm_cnt_incr = ((statein_cal_norm || state_is_cal_norm) && (! stateout_cal_norm));
  assign multi_seq_addr_max = (tmp_multi_seq_addr_max + {1'b0,7'h58});
  assign read_norm_addr_stored_next = ({1'b0,read_norm_addr_stored} + tmp_read_norm_addr_stored_next);
  assign multi_seq_addr_base = (read_norm_cnt + tmp_multi_seq_addr_base);
  always @(*) begin
    cal_norm_read_addr = 7'h00;
    if(read_norm_cnt_incr) begin
      if(rg_amp_multi_seq_norm_mode) begin
        if((multi_seq_addr_max <= multi_seq_addr_base)) begin
          cal_norm_read_addr = tmp_cal_norm_read_addr[6:0];
        end else begin
          cal_norm_read_addr = multi_seq_addr_base[6:0];
        end
      end else begin
        if(rg_amp_global_norm_mode) begin
          cal_norm_read_addr = (tmp_cal_norm_read_addr_2 + 7'h38);
        end
      end
    end
  end

  assign norm_rdata_split_0 = cache_rdata[7 : 0];
  assign norm_rdata_split_1 = cache_rdata[15 : 8];
  assign norm_rdata_split_2 = cache_rdata[23 : 16];
  assign norm_rdata_split_3 = cache_rdata[31 : 24];
  assign norm_cal_unit_datain = (rg_amp_multi_seq_norm_mode ? cache_rdata[7 : 0] : tmp_datain);
  assign norm_cal_unit_mean_num_log = (rg_amp_global_norm_mode ? global_mean_log2_num : tmp_mean_num_log);
  assign tmp_1 = ({3'd0,1'b1} <<< read_norm_quarter_cnt_delay);
  assign tmp_norm_store_buffer_0 = norm_cal_unit_norm_out;
  assign store_norm_data = {norm_store_buffer_3,{norm_store_buffer_2,{norm_store_buffer_1,norm_store_buffer_0}}};
  assign store_norm_ena = (state_is_store_norm && (! state_is_store_norm_regNext));
  assign store_norm_state_out_pulse = store_norm_ena_regNext;
  assign store_norm_write_cnt_ov = (store_norm_write_cnt == tmp_store_norm_write_cnt_ov);
  assign store_norm_write_addr = store_norm_write_cnt;
  assign read_ifmap_base_pointer_next = ({1'b0,read_ifmap_base_pointer} + tmp_read_ifmap_base_pointer_next);
  always @(*) begin
    if(write_ifmap_cnt_incr) begin
      cache_ena = 1'b1;
    end else begin
      if(statein_store_mean) begin
        cache_ena = 1'b1;
      end else begin
        if(read_mean_addr_incr) begin
          cache_ena = 1'b1;
        end else begin
          if(read_norm_cnt_incr) begin
            cache_ena = 1'b1;
          end else begin
            if(store_norm_ena) begin
              cache_ena = 1'b1;
            end else begin
              cache_ena = rnn_cache_ena;
            end
          end
        end
      end
    end
  end

  always @(*) begin
    if(write_ifmap_cnt_incr) begin
      cache_wena = 1'b1;
    end else begin
      if(statein_store_mean) begin
        cache_wena = 1'b1;
      end else begin
        if(read_mean_addr_incr) begin
          cache_wena = 1'b0;
        end else begin
          if(read_norm_cnt_incr) begin
            cache_wena = 1'b0;
          end else begin
            if(store_norm_ena) begin
              cache_wena = 1'b1;
            end else begin
              cache_wena = rnn_cache_wena;
            end
          end
        end
      end
    end
  end

  always @(*) begin
    if(write_ifmap_cnt_incr) begin
      cache_wdata = tmp_cache_wdata;
    end else begin
      if(statein_store_mean) begin
        cache_wdata = write_mean_data;
      end else begin
        if(read_mean_addr_incr) begin
          cache_wdata = 32'h00000000;
        end else begin
          if(read_norm_cnt_incr) begin
            cache_wdata = 32'h00000000;
          end else begin
            if(store_norm_ena) begin
              cache_wdata = store_norm_data;
            end else begin
              cache_wdata = rnn_cache_wdata;
            end
          end
        end
      end
    end
  end

  always @(*) begin
    if(write_ifmap_cnt_incr) begin
      cache_addr = write_ifmap_addr;
    end else begin
      if(statein_store_mean) begin
        cache_addr = write_mean_addr;
      end else begin
        if(read_mean_addr_incr) begin
          cache_addr = read_mean_addr;
        end else begin
          if(read_norm_cnt_incr) begin
            cache_addr = cal_norm_read_addr;
          end else begin
            if(store_norm_ena) begin
              cache_addr = store_norm_write_addr;
            end else begin
              cache_addr = rnn_cache_addr;
            end
          end
        end
      end
    end
  end

  assign coef_addr_1 = fdtmem_addr[15 : 1];
  always @(*) begin
    if((! coef_addr_1[0])) begin
      bitsel = 4'b0011;
    end else begin
      bitsel = 4'b1100;
    end
  end

  always @(*) begin
    if((! coef_addr_1[0])) begin
      wdata_sel = {16'd0, fdtmem_wdata};
    end else begin
      wdata_sel = (tmp_wdata_sel <<< 16);
    end
  end

  always @(*) begin
    if((! tmp_2)) begin
      rdata_sel = coef_rdata[15 : 0];
    end else begin
      rdata_sel = coef_rdata[31 : 16];
    end
  end

  assign coef_ena = (rnn_clk_en ? rnn_coef_ena : (fdtmem_wr || fdtmem_rd));
  assign coef_wena = (rnn_clk_en ? rnn_coef_wena : (fdtmem_wr && (! fdtmem_rd)));
  assign coef_addr = (rnn_clk_en ? rnn_coef_addr : tmp_coef_addr);
  assign coef_wsel = (rnn_clk_en ? 4'b0000 : bitsel);
  assign coef_wdata = (rnn_clk_en ? rnn_coef_wdata : wdata_sel);
  assign rnn_coef_rdata = (rnn_clk_en ? coef_rdata : 32'h00000000);
  assign fdtmem_rdata = (rnn_clk_en ? 16'h0000 : rdata_sel);
  assign rnn_clk_en = (rnn_start_once || rnn_en_reg);
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      norm_cal_end_ack <= 1'b0;
      curr_state <= FDTSTATE_IDLE;
      fdt_sample_time_cnt <= 5'h00;
      fdt_sampling_regNext_1 <= 1'b0;
      rg_fdt_en_regNext <= 1'b0;
      all_ifmap_ready_flag <= 1'b0;
      read_ifmap_base_pointer <= 7'h00;
      write_ifmap_base_pointer <= 7'h00;
      write_mean_addr <= 7'h58;
      read_mean_addr <= 7'h58;
      read_mean_addr_ov_delay <= 1'b0;
      store_norm_write_cnt <= 7'h00;
      read_norm_quarter_ov_delay <= 1'b0;
      write_ifmap_cnt <= 2'b00;
      write_ifmap_doing <= 1'b0;
      write_ifmap_cnt_ov_delay <= 1'b0;
      rg_fdt_result_up <= 1'b0;
      rg_fdt_result_down <= 1'b0;
      label_seq_decide_unit_delay <= 1'b0;
      norm_cal_end_ack_regNext <= 1'b0;
      fdt_once_done_comp_regNext <= 1'b0;
      mean_cal_sum_buffer <= 16'h0000;
      mean_cal_max_buffer <= 8'h00;
      mean_cal_min_buffer <= 8'h00;
      norm_store_buffer_0 <= 8'h00;
      norm_store_buffer_1 <= 8'h00;
      norm_store_buffer_2 <= 8'h00;
      norm_store_buffer_3 <= 8'h00;
      read_norm_cnt <= 8'h00;
      read_norm_addr_stored <= 7'h58;
      read_norm_quarter_cnt_delay <= 2'b00;
      norm_store_buffer_store_en <= 1'b0;
      state_is_store_norm_regNext <= 1'b0;
      store_norm_ena_regNext <= 1'b0;
      tmp_2 <= 1'b0;
      rnn_en_reg <= 1'b0;
    end else begin
      if(post_process_unit_norm_cal_end_req) begin
        norm_cal_end_ack <= 1'b1;
      end else begin
        norm_cal_end_ack <= 1'b0;
      end
      fdt_sampling_regNext_1 <= fdt_sampling;
      rg_fdt_en_regNext <= rg_fdt_en;
      read_mean_addr_ov_delay <= read_mean_addr_ov;
      read_norm_quarter_ov_delay <= read_norm_quarter_ov;
      write_ifmap_cnt_ov_delay <= write_ifmap_cnt_ov;
      if(label_seq_decide_unit_done) begin
        rg_fdt_result_up <= (label_seq_decide_unit_pred_index_out == 1'b0);
        rg_fdt_result_down <= (label_seq_decide_unit_pred_index_out == 1'b1);
      end
      label_seq_decide_unit_delay <= label_seq_decide_unit_done;
      norm_cal_end_ack_regNext <= norm_cal_end_ack;
      curr_state <= next_state;
      if(rg_fdt_en) begin
        if(fdt_once_done_comp) begin
          if((! fdt_sample_time_cnt_ov)) begin
            fdt_sample_time_cnt <= (fdt_sample_time_cnt + 5'h01);
          end
        end
      end
      fdt_once_done_comp_regNext <= fdt_once_done_comp;
      if(statein_store_amp) begin
        write_ifmap_doing <= 1'b1;
      end else begin
        if(write_ifmap_cnt_ov) begin
          write_ifmap_doing <= 1'b0;
        end
      end
      if(write_ifmap_cnt_incr) begin
        if(write_ifmap_cnt_ov) begin
          write_ifmap_cnt <= 2'b00;
        end else begin
          write_ifmap_cnt <= (write_ifmap_cnt + 2'b01);
        end
      end
      if((fdt_en_pos && ((! fdt_sample_time_cnt_ov) || (fdt_time_cnt_max == 5'h00)))) begin
        write_ifmap_base_pointer <= write_ifmap_base_init;
      end else begin
        if(write_ifmap_once_done) begin
          if((tmp_when <= write_ifmap_base_pointer_next)) begin
            write_ifmap_base_pointer <= write_ifmap_base_init;
          end else begin
            write_ifmap_base_pointer <= write_ifmap_base_pointer_next[6:0];
          end
        end
      end
      if(statein_store_mean) begin
        if((write_mean_addr_max <= tmp_when_1)) begin
          write_mean_addr <= 7'h58;
        end else begin
          write_mean_addr <= write_mean_addr_next[6:0];
        end
      end
      if(read_mean_addr_incr) begin
        if(read_mean_addr_ov) begin
          read_mean_addr <= 7'h58;
        end else begin
          read_mean_addr <= (read_mean_addr + 7'h01);
        end
      end
      if(statein_cal_mean) begin
        mean_cal_sum_buffer <= 16'h0000;
      end else begin
        if(state_is_cal_mean) begin
          mean_cal_sum_buffer <= (mean_cal_sum_buffer + tmp_mean_cal_sum_buffer);
        end
      end
      if(statein_cal_mean) begin
        mean_cal_max_buffer <= 8'h00;
        mean_cal_min_buffer <= 8'hff;
      end else begin
        if(state_is_cal_mean) begin
          if(rg_amp_global_norm_mode) begin
            if((mean_cal_max_buffer < read_out_max)) begin
              mean_cal_max_buffer <= read_out_max;
            end
            if((read_out_min < mean_cal_min_buffer)) begin
              mean_cal_min_buffer <= read_out_min;
            end
          end else begin
            if(rg_amp_multi_seq_norm_mode) begin
              if((mean_cal_max_buffer < read_out_mean_multiseq_mode)) begin
                mean_cal_max_buffer <= read_out_mean_multiseq_mode;
              end
              if((read_out_mean_multiseq_mode < mean_cal_min_buffer)) begin
                mean_cal_min_buffer <= read_out_mean_multiseq_mode;
              end
            end
          end
        end
      end
      if(read_norm_cnt_incr) begin
        if(read_norm_cnt_ov) begin
          read_norm_cnt <= 8'h00;
        end else begin
          read_norm_cnt <= (read_norm_cnt + 8'h01);
        end
      end
      if(((rg_amp_multi_seq_norm_mode && fdt_sample_time_cnt_ov) && rnn_start_once)) begin
        if((multi_seq_addr_max <= read_norm_addr_stored_next)) begin
          read_norm_addr_stored <= 7'h58;
        end else begin
          read_norm_addr_stored <= (read_norm_addr_stored + 7'h01);
        end
      end
      read_norm_quarter_cnt_delay <= read_norm_quarter_cnt;
      norm_store_buffer_store_en <= read_norm_cnt_incr;
      if(norm_store_buffer_store_en) begin
        if(tmp_1[0]) begin
          norm_store_buffer_0 <= tmp_norm_store_buffer_0;
        end
        if(tmp_1[1]) begin
          norm_store_buffer_1 <= tmp_norm_store_buffer_0;
        end
        if(tmp_1[2]) begin
          norm_store_buffer_2 <= tmp_norm_store_buffer_0;
        end
        if(tmp_1[3]) begin
          norm_store_buffer_3 <= tmp_norm_store_buffer_0;
        end
      end
      state_is_store_norm_regNext <= state_is_store_norm;
      store_norm_ena_regNext <= store_norm_ena;
      if(store_norm_state_out_pulse) begin
        if(store_norm_write_cnt_ov) begin
          store_norm_write_cnt <= 7'h00;
        end else begin
          store_norm_write_cnt <= (store_norm_write_cnt + 7'h01);
        end
      end
      if(rnn_done) begin
        if((tmp_when_2 <= read_ifmap_base_pointer_next)) begin
          read_ifmap_base_pointer <= 7'h00;
        end else begin
          read_ifmap_base_pointer <= read_ifmap_base_pointer_next[6:0];
        end
      end
      if((fdt_sample_time_cnt_ov && write_ifmap_once_done)) begin
        all_ifmap_ready_flag <= 1'b1;
      end else begin
        if(rnn_all_ifmap_ready_flag_clear) begin
          all_ifmap_ready_flag <= 1'b0;
        end
      end
      if(fdtmem_rd) begin
        tmp_2 <= coef_addr_1[0];
      end
      if(rnn_start_once) begin
        rnn_en_reg <= 1'b1;
      end else begin
        if(rnn_done_1) begin
          rnn_en_reg <= 1'b0;
        end
      end
    end
  end

  always @(posedge clk_80m or negedge rstn_80m) begin
    if(!rstn_80m) begin
      iq_cal_en_reg <= 1'b0;
      fdt_sampling_regNext <= 1'b0;
    end else begin
      fdt_sampling_regNext <= fdt_sampling;
      if(iq_ready_pulse) begin
        iq_cal_en_reg <= 1'b1;
      end else begin
        if(postprocess_end_pulse) begin
          iq_cal_en_reg <= 1'b0;
        end
      end
    end
  end


endmodule

module norm_unit (
  input  wire [7:0]    datain,
  input  wire [2:0]    data_ratio,
  input  wire [15:0]   sum,
  input  wire [3:0]    mean_num_log,
  input  wire [7:0]    max,
  input  wire [7:0]    min,
  output wire [7:0]    norm_out
);

  wire                lzc_unit_mode;
  wire                lzc_unit_lead;
  wire                lzc_unit_trail;
  wire       [15:0]   lzc_unit_data_in;
  wire       [4:0]    lzc_unit_cnt_out;
  wire       [15:0]   tmp_data_in;
  wire       [22:0]   tmp_norm_out;
  wire       [22:0]   tmp_norm_out_1;
  wire       [15:0]   tmp_norm_out_2;
  wire       [15:0]   tmp_norm_out_3;
  wire       [7:0]    tmp_norm_out_4;
  wire       [15:0]   tmp_norm_out_5;
  wire       [7:0]    max_minux_min;
  wire       [2:0]    most_signifi_num;
  wire       [15:0]   mean_num;

  assign tmp_data_in = {8'd0, max_minux_min};
  assign tmp_norm_out = ($signed(tmp_norm_out_1) >>> most_signifi_num);
  assign tmp_norm_out_1 = ({{7{tmp_norm_out_2[15]}},tmp_norm_out_2} <<< data_ratio);
  assign tmp_norm_out_2 = ($signed(tmp_norm_out_3) - $signed(tmp_norm_out_5));
  assign tmp_norm_out_4 = datain;
  assign tmp_norm_out_3 = {{8{tmp_norm_out_4[7]}}, tmp_norm_out_4};
  assign tmp_norm_out_5 = mean_num;
  lzc_1 lzc_unit (
    .mode    (lzc_unit_mode         ), //i
    .lead    (lzc_unit_lead         ), //i
    .trail   (lzc_unit_trail        ), //i
    .data_in (lzc_unit_data_in[15:0]), //i
    .cnt_out (lzc_unit_cnt_out[4:0] )  //o
  );
  assign max_minux_min = (max - min);
  assign lzc_unit_mode = 1'b1;
  assign lzc_unit_lead = 1'b1;
  assign lzc_unit_trail = 1'b0;
  assign lzc_unit_data_in = tmp_data_in;
  assign most_signifi_num = ((lzc_unit_cnt_out == 5'h10) ? 3'b000 : lzc_unit_cnt_out[2 : 0]);
  assign mean_num = (sum >>> mean_num_log);
  assign norm_out = tmp_norm_out[7:0];

endmodule

module label_seq_decide (
  input  wire          label_vld,
  input  wire [1:0]    rnn_pred_index,
  output wire          done,
  output wire          pred_index_out,
  input  wire          rg_fdt_en,
  input  wire          rg_fdt_wait_up,
  input  wire          rg_fdt_wait_down,
  input  wire          rg_fdt_auto_exit_en,
  input  wire [2:0]    rg_amp_data_ratio,
  input  wire          rg_amp_global_norm_mode,
  input  wire          rg_amp_multi_seq_norm_mode,
  input  wire [4:0]    rg_amp_samp_start_num,
  input  wire [2:0]    rg_amp_sample_num_log2,
  input  wire [3:0]    rg_amp_samp_gap_num,
  input  wire          rg_rnn_single_step_mode,
  input  wire          rg_rnn_single_step_init,
  input  wire [2:0]    rg_rnn_data_ratio,
  input  wire [6:0]    rg_cache_ofmap_base_addr,
  input  wire [3:0]    rg_rnn_seq_num,
  input  wire [1:0]    rg_rnn_layer_num,
  input  wire [1:0]    rg_rnn_ifmap_groupnum,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_0,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_1,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_2,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_3,
  input  wire [6:0]    rg_rnn_bias_addr_layer_0,
  input  wire [6:0]    rg_rnn_bias_addr_layer_1,
  input  wire [6:0]    rg_rnn_bias_addr_layer_2,
  input  wire [6:0]    rg_rnn_bias_addr_layer_3,
  input  wire [6:0]    rg_rnn_whi_addr_layer_0,
  input  wire [6:0]    rg_rnn_whi_addr_layer_1,
  input  wire [6:0]    rg_rnn_whi_addr_layer_2,
  input  wire [6:0]    rg_rnn_whi_addr_layer_3,
  input  wire [6:0]    rg_rnn_whh_addr_layer_0,
  input  wire [6:0]    rg_rnn_whh_addr_layer_1,
  input  wire [6:0]    rg_rnn_whh_addr_layer_2,
  input  wire [6:0]    rg_rnn_whh_addr_layer_3,
  input  wire [6:0]    rg_rnn_fc_bias_addr,
  input  wire [6:0]    rg_rnn_fc_weight_addr,
  input  wire [1:0]    rg_rnn_fc_label_num,
  input  wire          rg_fdt_label_seq_en,
  input  wire [2:0]    rg_fdt_label_seq_length,
  output reg  [7:0]    label_seq_buffer,
  input  wire          clk,
  input  wire          resetn
);

  wire       [2:0]    tmp_label_0_num_fake_1;
  wire       [1:0]    tmp_label_0_num_fake_2;
  wire       [1:0]    tmp_label_0_num_fake_3;
  wire       [0:0]    tmp_label_0_num_fake_4;
  wire       [2:0]    tmp_label_0_num_fake_5;
  wire       [1:0]    tmp_label_0_num_fake_6;
  wire       [1:0]    tmp_label_0_num_fake_7;
  wire       [0:0]    tmp_label_0_num_fake_8;
  wire       [3:0]    tmp_label_0_num_fake_9;
  wire       [2:0]    tmp_label_0_num_fake_10;
  wire       [1:0]    tmp_label_0_num_fake_11;
  wire       [1:0]    tmp_label_0_num_fake_12;
  wire       [0:0]    tmp_label_0_num_fake_13;
  wire       [2:0]    tmp_label_0_num_fake_14;
  wire       [1:0]    tmp_label_0_num_fake_15;
  wire       [1:0]    tmp_label_0_num_fake_16;
  wire       [0:0]    tmp_label_0_num_fake_17;
  wire       [2:0]    tmp_label_1_num_1;
  wire       [1:0]    tmp_label_1_num_2;
  wire       [1:0]    tmp_label_1_num_3;
  wire       [0:0]    tmp_label_1_num_4;
  wire       [2:0]    tmp_label_1_num_5;
  wire       [1:0]    tmp_label_1_num_6;
  wire       [1:0]    tmp_label_1_num_7;
  wire       [0:0]    tmp_label_1_num_8;
  wire       [3:0]    tmp_label_1_num_9;
  wire       [2:0]    tmp_label_1_num_10;
  wire       [1:0]    tmp_label_1_num_11;
  wire       [1:0]    tmp_label_1_num_12;
  wire       [0:0]    tmp_label_1_num_13;
  wire       [2:0]    tmp_label_1_num_14;
  wire       [1:0]    tmp_label_1_num_15;
  wire       [1:0]    tmp_label_1_num_16;
  wire       [0:0]    tmp_label_1_num_17;
  wire       [3:0]    tmp_label_0_num;
  wire       [2:0]    tmp_label_0_num_1;
  reg                 label_vld_delay;
  wire                label_seq_vec_0;
  wire                label_seq_vec_1;
  wire                label_seq_vec_2;
  wire                label_seq_vec_3;
  wire                label_seq_vec_4;
  wire                label_seq_vec_5;
  wire                label_seq_vec_6;
  wire                label_seq_vec_7;
  wire                tmp_label_0_num_fake;
  wire       [3:0]    label_0_num_fake;
  wire                tmp_label_1_num;
  wire       [3:0]    label_1_num;
  wire       [3:0]    label_0_num;
  wire                label0_is_more;
  reg                 pre_trans_label;

  assign tmp_label_0_num_fake_1 = ({1'b0,tmp_label_0_num_fake_2} + tmp_label_0_num_fake_5);
  assign tmp_label_0_num_fake_2 = ({1'b0,(label_seq_vec_0 == tmp_label_0_num_fake)} + tmp_label_0_num_fake_3);
  assign tmp_label_0_num_fake_4 = (label_seq_vec_1 == tmp_label_0_num_fake);
  assign tmp_label_0_num_fake_3 = {1'd0, tmp_label_0_num_fake_4};
  assign tmp_label_0_num_fake_6 = ({1'b0,(label_seq_vec_2 == tmp_label_0_num_fake)} + tmp_label_0_num_fake_7);
  assign tmp_label_0_num_fake_5 = {1'd0, tmp_label_0_num_fake_6};
  assign tmp_label_0_num_fake_8 = (label_seq_vec_3 == tmp_label_0_num_fake);
  assign tmp_label_0_num_fake_7 = {1'd0, tmp_label_0_num_fake_8};
  assign tmp_label_0_num_fake_10 = ({1'b0,tmp_label_0_num_fake_11} + tmp_label_0_num_fake_14);
  assign tmp_label_0_num_fake_9 = {1'd0, tmp_label_0_num_fake_10};
  assign tmp_label_0_num_fake_11 = ({1'b0,(label_seq_vec_4 == tmp_label_0_num_fake)} + tmp_label_0_num_fake_12);
  assign tmp_label_0_num_fake_13 = (label_seq_vec_5 == tmp_label_0_num_fake);
  assign tmp_label_0_num_fake_12 = {1'd0, tmp_label_0_num_fake_13};
  assign tmp_label_0_num_fake_15 = ({1'b0,(label_seq_vec_6 == tmp_label_0_num_fake)} + tmp_label_0_num_fake_16);
  assign tmp_label_0_num_fake_14 = {1'd0, tmp_label_0_num_fake_15};
  assign tmp_label_0_num_fake_17 = (label_seq_vec_7 == tmp_label_0_num_fake);
  assign tmp_label_0_num_fake_16 = {1'd0, tmp_label_0_num_fake_17};
  assign tmp_label_1_num_1 = ({1'b0,tmp_label_1_num_2} + tmp_label_1_num_5);
  assign tmp_label_1_num_2 = ({1'b0,(label_seq_vec_0 == tmp_label_1_num)} + tmp_label_1_num_3);
  assign tmp_label_1_num_4 = (label_seq_vec_1 == tmp_label_1_num);
  assign tmp_label_1_num_3 = {1'd0, tmp_label_1_num_4};
  assign tmp_label_1_num_6 = ({1'b0,(label_seq_vec_2 == tmp_label_1_num)} + tmp_label_1_num_7);
  assign tmp_label_1_num_5 = {1'd0, tmp_label_1_num_6};
  assign tmp_label_1_num_8 = (label_seq_vec_3 == tmp_label_1_num);
  assign tmp_label_1_num_7 = {1'd0, tmp_label_1_num_8};
  assign tmp_label_1_num_10 = ({1'b0,tmp_label_1_num_11} + tmp_label_1_num_14);
  assign tmp_label_1_num_9 = {1'd0, tmp_label_1_num_10};
  assign tmp_label_1_num_11 = ({1'b0,(label_seq_vec_4 == tmp_label_1_num)} + tmp_label_1_num_12);
  assign tmp_label_1_num_13 = (label_seq_vec_5 == tmp_label_1_num);
  assign tmp_label_1_num_12 = {1'd0, tmp_label_1_num_13};
  assign tmp_label_1_num_15 = ({1'b0,(label_seq_vec_6 == tmp_label_1_num)} + tmp_label_1_num_16);
  assign tmp_label_1_num_14 = {1'd0, tmp_label_1_num_15};
  assign tmp_label_1_num_17 = (label_seq_vec_7 == tmp_label_1_num);
  assign tmp_label_1_num_16 = {1'd0, tmp_label_1_num_17};
  assign tmp_label_0_num_1 = (3'b111 - rg_fdt_label_seq_length);
  assign tmp_label_0_num = {1'd0, tmp_label_0_num_1};
  assign label_seq_vec_0 = label_seq_buffer[0];
  assign label_seq_vec_1 = label_seq_buffer[1];
  assign label_seq_vec_2 = label_seq_buffer[2];
  assign label_seq_vec_3 = label_seq_buffer[3];
  assign label_seq_vec_4 = label_seq_buffer[4];
  assign label_seq_vec_5 = label_seq_buffer[5];
  assign label_seq_vec_6 = label_seq_buffer[6];
  assign label_seq_vec_7 = label_seq_buffer[7];
  assign tmp_label_0_num_fake = 1'b0;
  assign label_0_num_fake = ({1'b0,tmp_label_0_num_fake_1} + tmp_label_0_num_fake_9);
  assign tmp_label_1_num = 1'b1;
  assign label_1_num = ({1'b0,tmp_label_1_num_1} + tmp_label_1_num_9);
  assign label_0_num = (label_0_num_fake - tmp_label_0_num);
  assign label0_is_more = (label_1_num <= label_0_num);
  assign pred_index_out = pre_trans_label;
  assign done = label_vld_delay;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      label_vld_delay <= 1'b0;
      label_seq_buffer <= 8'h00;
      pre_trans_label <= 1'b0;
    end else begin
      label_vld_delay <= label_vld;
      if((label_vld && rg_fdt_label_seq_en)) begin
        if((rnn_pred_index == 2'b10)) begin
          if((label_seq_buffer[rg_fdt_label_seq_length] == 1'b0)) begin
            pre_trans_label <= 1'b0;
          end else begin
            if(label0_is_more) begin
              pre_trans_label <= 1'b0;
            end else begin
              pre_trans_label <= 1'b1;
            end
          end
        end else begin
          pre_trans_label <= (rnn_pred_index == 2'b01);
        end
      end else begin
        if(label_vld) begin
          if((rnn_pred_index == 2'b00)) begin
            pre_trans_label <= 1'b0;
          end else begin
            if((rnn_pred_index == 2'b01)) begin
              pre_trans_label <= 1'b1;
            end else begin
              pre_trans_label <= 1'b0;
            end
          end
        end
      end
      if((label_vld_delay && rg_fdt_label_seq_en)) begin
        case(rg_fdt_label_seq_length)
          3'b000 : begin
            label_seq_buffer[0] <= pre_trans_label;
          end
          3'b001 : begin
            label_seq_buffer[0 : 0] <= label_seq_buffer[1 : 1];
            label_seq_buffer[1] <= pre_trans_label;
          end
          3'b010 : begin
            label_seq_buffer[1 : 0] <= label_seq_buffer[2 : 1];
            label_seq_buffer[2] <= pre_trans_label;
          end
          3'b011 : begin
            label_seq_buffer[2 : 0] <= label_seq_buffer[3 : 1];
            label_seq_buffer[3] <= pre_trans_label;
          end
          3'b100 : begin
            label_seq_buffer[3 : 0] <= label_seq_buffer[4 : 1];
            label_seq_buffer[4] <= pre_trans_label;
          end
          3'b101 : begin
            label_seq_buffer[4 : 0] <= label_seq_buffer[5 : 1];
            label_seq_buffer[5] <= pre_trans_label;
          end
          3'b110 : begin
            label_seq_buffer[5 : 0] <= label_seq_buffer[6 : 1];
            label_seq_buffer[6] <= pre_trans_label;
          end
          default : begin
            label_seq_buffer[6 : 0] <= label_seq_buffer[7 : 1];
            label_seq_buffer[7] <= pre_trans_label;
          end
        endcase
      end
    end
  end


endmodule

module rnn_layer (
  input  wire          start_once,
  input  wire          all_ifmap_ready_flag,
  output wire          all_ifmap_ready_flag_clear,
  input  wire [6:0]    read_ifmap_base_pointer,
  output wire          coef_ena,
  output wire          coef_wena,
  output wire [6:0]    coef_addr,
  output wire [31:0]   coef_wdata,
  input  wire [31:0]   coef_rdata,
  output wire          cache_ena,
  output wire          cache_wena,
  output wire [6:0]    cache_addr,
  output wire [31:0]   cache_wdata,
  input  wire [31:0]   cache_rdata,
  output wire [1:0]    rnn_pred_index,
  output wire          done,
  input  wire          rg_fdt_en,
  input  wire          rg_fdt_wait_up,
  input  wire          rg_fdt_wait_down,
  input  wire          rg_fdt_auto_exit_en,
  input  wire [2:0]    rg_amp_data_ratio,
  input  wire          rg_amp_global_norm_mode,
  input  wire          rg_amp_multi_seq_norm_mode,
  input  wire [4:0]    rg_amp_samp_start_num,
  input  wire [2:0]    rg_amp_sample_num_log2,
  input  wire [3:0]    rg_amp_samp_gap_num,
  input  wire          rg_rnn_single_step_mode,
  input  wire          rg_rnn_single_step_init,
  input  wire [2:0]    rg_rnn_data_ratio,
  input  wire [6:0]    rg_cache_ofmap_base_addr,
  input  wire [3:0]    rg_rnn_seq_num,
  input  wire [1:0]    rg_rnn_layer_num,
  input  wire [1:0]    rg_rnn_ifmap_groupnum,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_0,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_1,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_2,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_3,
  input  wire [6:0]    rg_rnn_bias_addr_layer_0,
  input  wire [6:0]    rg_rnn_bias_addr_layer_1,
  input  wire [6:0]    rg_rnn_bias_addr_layer_2,
  input  wire [6:0]    rg_rnn_bias_addr_layer_3,
  input  wire [6:0]    rg_rnn_whi_addr_layer_0,
  input  wire [6:0]    rg_rnn_whi_addr_layer_1,
  input  wire [6:0]    rg_rnn_whi_addr_layer_2,
  input  wire [6:0]    rg_rnn_whi_addr_layer_3,
  input  wire [6:0]    rg_rnn_whh_addr_layer_0,
  input  wire [6:0]    rg_rnn_whh_addr_layer_1,
  input  wire [6:0]    rg_rnn_whh_addr_layer_2,
  input  wire [6:0]    rg_rnn_whh_addr_layer_3,
  input  wire [6:0]    rg_rnn_fc_bias_addr,
  input  wire [6:0]    rg_rnn_fc_weight_addr,
  input  wire [1:0]    rg_rnn_fc_label_num,
  input  wire          rg_fdt_label_seq_en,
  input  wire [2:0]    rg_fdt_label_seq_length,
  output reg  [15:0]   label_result_0,
  output reg  [15:0]   label_result_1,
  output reg  [15:0]   label_result_2,
  output reg  [15:0]   label_result_3,
  input  wire          rnn_clk_en,
  output wire          single_step_every_done,
  output wire          matmul_done_once,
  input  wire          clk,
  input  wire          resetn
);
  localparam LAYER_STATE_IDLE = 3'd0;
  localparam LAYER_STATE_MATMUL_H = 3'd1;
  localparam LAYER_STATE_MATMUL_I = 3'd2;
  localparam LAYER_STATE_WAIT_SAMPLE = 3'd3;
  localparam LAYER_STATE_MATMUL_OUT = 3'd4;
  localparam LAYER_STATE_PRED_COMP = 3'd5;

  wire                matmul_unit_need_relu;
  wire                matmul_unit_need_scale;
  wire                matmul_unit_is_fc_layer;
  reg        [1:0]    matmul_unit_ifmap_loop_num;
  reg        [1:0]    matmul_unit_ofmap_loop_num;
  wire       [6:0]    matmul_unit_curr_layer_line_num;
  reg        [6:0]    matmul_unit_psum_base_addr;
  reg        [6:0]    matmul_unit_weight_base_addr;
  reg        [6:0]    matmul_unit_ifmap_base_addr;
  reg                 matmul_unit_psum_come_from_coef;
  wire                matmul_unit_coef_ena;
  wire                matmul_unit_coef_wena;
  wire       [6:0]    matmul_unit_coef_addr;
  wire       [31:0]   matmul_unit_coef_wdata;
  wire                matmul_unit_cache_ena;
  wire                matmul_unit_cache_wena;
  wire       [6:0]    matmul_unit_cache_addr;
  wire       [31:0]   matmul_unit_cache_wdata;
  wire                matmul_unit_done;
  wire       [3:0]    tmp_seqCnt_next_ov_flag;
  reg        [1:0]    tmp_ifmap_loop_num;
  wire       [1:0]    tmp_ifmap_loop_num_1;
  reg        [1:0]    tmp_tmp_curr_layer_line_num;
  reg        [1:0]    tmp_ifmap_loop_num_2;
  wire       [1:0]    tmp_ifmap_loop_num_3;
  reg        [1:0]    tmp_last_layer_line_num;
  wire       [1:0]    tmp_last_layer_line_num_1;
  wire       [2:0]    tmp_curr_hidden_layer_mem_line_num;
  wire       [2:0]    tmp_curr_hidden_layer_mem_line_num_1;
  wire       [2:0]    tmp_last_hidden_layer_mem_line_num;
  wire       [2:0]    tmp_last_hidden_layer_mem_line_num_1;
  wire       [6:0]    tmp_curr_layer_ofmap_base;
  wire       [6:0]    tmp_last_layer_ofmap_base;
  wire       [7:0]    tmp_next_read_ifmap_pointer;
  wire       [3:0]    tmp_next_read_ifmap_pointer_1;
  wire       [2:0]    tmp_next_read_ifmap_pointer_2;
  wire       [2:0]    tmp_next_read_ifmap_pointer_3;
  wire       [1:0]    tmp_next_read_ifmap_pointer_4;
  wire       [7:0]    tmp_when;
  reg        [6:0]    tmp_tmp_psum_base_addr;
  wire       [6:0]    tmp_psum_base_addr_1;
  reg        [6:0]    tmp_weight_base_addr;
  reg        [6:0]    tmp_weight_base_addr_1;
  wire       [0:0]    tmp_result_out_cnt_ov;
  reg        [15:0]   tmp_tmp_max_pred;
  reg        [2:0]    curr_state;
  reg        [2:0]    next_state;
  reg        [1:0]    layerCnt;
  reg        [3:0]    seqCnt;
  wire                layerCnt_ov_flag;
  wire                seqCnt_ov_flag;
  wire                seqCnt_next_ov_flag;
  wire                pred_cnt_incr;
  reg        [1:0]    pred_cnt;
  wire                pred_cnt_ov;
  wire                statein_matmulI;
  wire                statein_matmulH;
  wire                statein_matmulOut;
  wire                stateout_matmulI;
  wire                stateout_waitsamp;
  wire                stateout_predComp;
  wire                state_is_matmulOut;
  wire                is_first_seq;
  reg                 single_step_enable;
  reg                 rg_rnn_single_step_init_regNext;
  wire                sing_step_init_pos;
  reg                 all_statein_pulse;
  reg                 matmul_start_once;
  reg                 tmp_matmul_start_once;
  wire                out_layer_in_pulse;
  wire                wait_sample_in_pulse;
  wire       [1:0]    tmp_curr_layer_line_num;
  reg        [6:0]    curr_layer_ofmap_base;
  reg        [6:0]    last_layer_ofmap_base;
  reg        [6:0]    read_ifmap_pointer;
  wire       [1:0]    curr_layer_line_num;
  wire       [1:0]    last_layer_line_num;
  wire       [2:0]    curr_hidden_layer_mem_line_num;
  wire       [2:0]    last_hidden_layer_mem_line_num;
  wire                layerCnt_incr_when_ov_pulse;
  wire       [7:0]    next_read_ifmap_pointer;
  wire       [6:0]    tmp_psum_base_addr;
  reg        [0:0]    result_out_cnt;
  wire                result_out_cnt_ov;
  reg        [15:0]   max_pred;
  reg        [1:0]    pred_index;
  wire       [15:0]   tmp_max_pred;
  reg                 stateout_predComp_regNext;
  `ifndef SYNTHESIS
  reg [87:0] curr_state_string;
  reg [87:0] next_state_string;
  `endif


  assign tmp_seqCnt_next_ov_flag = (rg_rnn_seq_num - 4'b0001);
  assign tmp_ifmap_loop_num_1 = (layerCnt - 2'b01);
  assign tmp_ifmap_loop_num_3 = (rg_rnn_layer_num - 2'b01);
  assign tmp_last_layer_line_num_1 = (layerCnt - 2'b01);
  assign tmp_curr_hidden_layer_mem_line_num = ({1'd0,curr_layer_line_num} <<< 1'd1);
  assign tmp_curr_hidden_layer_mem_line_num_1 = {1'd0, curr_layer_line_num};
  assign tmp_last_hidden_layer_mem_line_num = ({1'd0,last_layer_line_num} <<< 1'd1);
  assign tmp_last_hidden_layer_mem_line_num_1 = {1'd0, last_layer_line_num};
  assign tmp_curr_layer_ofmap_base = {4'd0, curr_hidden_layer_mem_line_num};
  assign tmp_last_layer_ofmap_base = {4'd0, last_hidden_layer_mem_line_num};
  assign tmp_next_read_ifmap_pointer_1 = {1'b0,tmp_next_read_ifmap_pointer_2};
  assign tmp_next_read_ifmap_pointer = {4'd0, tmp_next_read_ifmap_pointer_1};
  assign tmp_next_read_ifmap_pointer_2 = ({1'b0,rg_rnn_ifmap_groupnum} + tmp_next_read_ifmap_pointer_3);
  assign tmp_next_read_ifmap_pointer_4 = {1'b0,1'b1};
  assign tmp_next_read_ifmap_pointer_3 = {1'd0, tmp_next_read_ifmap_pointer_4};
  assign tmp_when = {1'd0, rg_cache_ofmap_base_addr};
  assign tmp_psum_base_addr_1 = {5'd0, curr_layer_line_num};
  assign tmp_result_out_cnt_ov = (rg_rnn_fc_label_num >>> 1'd1);
  matmul matmul_unit (
    .start_once          (matmul_start_once                   ), //i
    .need_relu           (matmul_unit_need_relu               ), //i
    .need_scale          (matmul_unit_need_scale              ), //i
    .is_fc_layer         (matmul_unit_is_fc_layer             ), //i
    .label_num           (rg_rnn_fc_label_num[1:0]            ), //i
    .rg_rnn_data_ratio   (rg_rnn_data_ratio[2:0]              ), //i
    .ifmap_loop_num      (matmul_unit_ifmap_loop_num[1:0]     ), //i
    .ofmap_loop_num      (matmul_unit_ofmap_loop_num[1:0]     ), //i
    .curr_layer_line_num (matmul_unit_curr_layer_line_num[6:0]), //i
    .psum_base_addr      (matmul_unit_psum_base_addr[6:0]     ), //i
    .weight_base_addr    (matmul_unit_weight_base_addr[6:0]   ), //i
    .ifmap_base_addr     (matmul_unit_ifmap_base_addr[6:0]    ), //i
    .ofmap_base_addr     (curr_layer_ofmap_base[6:0]          ), //i
    .psum_come_from_coef (matmul_unit_psum_come_from_coef     ), //i
    .coef_ena            (matmul_unit_coef_ena                ), //o
    .coef_wena           (matmul_unit_coef_wena               ), //o
    .coef_addr           (matmul_unit_coef_addr[6:0]          ), //o
    .coef_wdata          (matmul_unit_coef_wdata[31:0]        ), //o
    .coef_rdata          (coef_rdata[31:0]                    ), //i
    .cache_ena           (matmul_unit_cache_ena               ), //o
    .cache_wena          (matmul_unit_cache_wena              ), //o
    .cache_addr          (matmul_unit_cache_addr[6:0]         ), //o
    .cache_wdata         (matmul_unit_cache_wdata[31:0]       ), //o
    .cache_rdata         (cache_rdata[31:0]                   ), //i
    .done                (matmul_unit_done                    ), //o
    .clk                 (clk                                 ), //i
    .resetn              (resetn                              )  //i
  );
  always @(*) begin
    case(tmp_ifmap_loop_num_1)
      2'b00 : tmp_ifmap_loop_num = rg_rnn_hidden_groupnum_layer_0;
      2'b01 : tmp_ifmap_loop_num = rg_rnn_hidden_groupnum_layer_1;
      2'b10 : tmp_ifmap_loop_num = rg_rnn_hidden_groupnum_layer_2;
      default : tmp_ifmap_loop_num = rg_rnn_hidden_groupnum_layer_3;
    endcase
  end

  always @(*) begin
    case(layerCnt)
      2'b00 : begin
        tmp_tmp_curr_layer_line_num = rg_rnn_hidden_groupnum_layer_0;
        tmp_tmp_psum_base_addr = rg_rnn_bias_addr_layer_0;
        tmp_weight_base_addr = rg_rnn_whh_addr_layer_0;
        tmp_weight_base_addr_1 = rg_rnn_whi_addr_layer_0;
      end
      2'b01 : begin
        tmp_tmp_curr_layer_line_num = rg_rnn_hidden_groupnum_layer_1;
        tmp_tmp_psum_base_addr = rg_rnn_bias_addr_layer_1;
        tmp_weight_base_addr = rg_rnn_whh_addr_layer_1;
        tmp_weight_base_addr_1 = rg_rnn_whi_addr_layer_1;
      end
      2'b10 : begin
        tmp_tmp_curr_layer_line_num = rg_rnn_hidden_groupnum_layer_2;
        tmp_tmp_psum_base_addr = rg_rnn_bias_addr_layer_2;
        tmp_weight_base_addr = rg_rnn_whh_addr_layer_2;
        tmp_weight_base_addr_1 = rg_rnn_whi_addr_layer_2;
      end
      default : begin
        tmp_tmp_curr_layer_line_num = rg_rnn_hidden_groupnum_layer_3;
        tmp_tmp_psum_base_addr = rg_rnn_bias_addr_layer_3;
        tmp_weight_base_addr = rg_rnn_whh_addr_layer_3;
        tmp_weight_base_addr_1 = rg_rnn_whi_addr_layer_3;
      end
    endcase
  end

  always @(*) begin
    case(tmp_ifmap_loop_num_3)
      2'b00 : tmp_ifmap_loop_num_2 = rg_rnn_hidden_groupnum_layer_0;
      2'b01 : tmp_ifmap_loop_num_2 = rg_rnn_hidden_groupnum_layer_1;
      2'b10 : tmp_ifmap_loop_num_2 = rg_rnn_hidden_groupnum_layer_2;
      default : tmp_ifmap_loop_num_2 = rg_rnn_hidden_groupnum_layer_3;
    endcase
  end

  always @(*) begin
    case(tmp_last_layer_line_num_1)
      2'b00 : tmp_last_layer_line_num = rg_rnn_hidden_groupnum_layer_0;
      2'b01 : tmp_last_layer_line_num = rg_rnn_hidden_groupnum_layer_1;
      2'b10 : tmp_last_layer_line_num = rg_rnn_hidden_groupnum_layer_2;
      default : tmp_last_layer_line_num = rg_rnn_hidden_groupnum_layer_3;
    endcase
  end

  always @(*) begin
    case(pred_cnt)
      2'b00 : tmp_tmp_max_pred = label_result_0;
      2'b01 : tmp_tmp_max_pred = label_result_1;
      2'b10 : tmp_tmp_max_pred = label_result_2;
      default : tmp_tmp_max_pred = label_result_3;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(curr_state)
      LAYER_STATE_IDLE : curr_state_string = "IDLE       ";
      LAYER_STATE_MATMUL_H : curr_state_string = "MATMUL_H   ";
      LAYER_STATE_MATMUL_I : curr_state_string = "MATMUL_I   ";
      LAYER_STATE_WAIT_SAMPLE : curr_state_string = "WAIT_SAMPLE";
      LAYER_STATE_MATMUL_OUT : curr_state_string = "MATMUL_OUT ";
      LAYER_STATE_PRED_COMP : curr_state_string = "PRED_COMP  ";
      default : curr_state_string = "???????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      LAYER_STATE_IDLE : next_state_string = "IDLE       ";
      LAYER_STATE_MATMUL_H : next_state_string = "MATMUL_H   ";
      LAYER_STATE_MATMUL_I : next_state_string = "MATMUL_I   ";
      LAYER_STATE_WAIT_SAMPLE : next_state_string = "WAIT_SAMPLE";
      LAYER_STATE_MATMUL_OUT : next_state_string = "MATMUL_OUT ";
      LAYER_STATE_PRED_COMP : next_state_string = "PRED_COMP  ";
      default : next_state_string = "???????????";
    endcase
  end
  `endif

  assign layerCnt_ov_flag = (layerCnt == rg_rnn_layer_num);
  assign seqCnt_ov_flag = (seqCnt == rg_rnn_seq_num);
  assign seqCnt_next_ov_flag = (seqCnt == tmp_seqCnt_next_ov_flag);
  assign pred_cnt_incr = (curr_state == LAYER_STATE_PRED_COMP);
  assign pred_cnt_ov = (pred_cnt == rg_rnn_fc_label_num);
  assign statein_matmulI = ((curr_state != LAYER_STATE_MATMUL_I) && (next_state == LAYER_STATE_MATMUL_I));
  assign statein_matmulH = ((curr_state != LAYER_STATE_MATMUL_H) && (next_state == LAYER_STATE_MATMUL_H));
  assign statein_matmulOut = ((curr_state != LAYER_STATE_MATMUL_OUT) && (next_state == LAYER_STATE_MATMUL_OUT));
  assign stateout_matmulI = ((curr_state == LAYER_STATE_MATMUL_I) && (next_state != LAYER_STATE_MATMUL_I));
  assign stateout_waitsamp = ((curr_state == LAYER_STATE_WAIT_SAMPLE) && (next_state != LAYER_STATE_WAIT_SAMPLE));
  assign stateout_predComp = ((curr_state == LAYER_STATE_PRED_COMP) && (next_state != LAYER_STATE_PRED_COMP));
  assign state_is_matmulOut = (curr_state == LAYER_STATE_MATMUL_OUT);
  assign is_first_seq = ((seqCnt == 4'b0000) && ((curr_state == LAYER_STATE_MATMUL_I) || (curr_state == LAYER_STATE_MATMUL_H)));
  assign single_step_every_done = (curr_state == LAYER_STATE_MATMUL_OUT);
  assign sing_step_init_pos = (rg_rnn_single_step_init && (! rg_rnn_single_step_init_regNext));
  always @(*) begin
    if((! is_first_seq)) begin
      matmul_start_once = all_statein_pulse;
    end else begin
      if(single_step_enable) begin
        matmul_start_once = all_statein_pulse;
      end else begin
        matmul_start_once = tmp_matmul_start_once;
      end
    end
  end

  assign out_layer_in_pulse = (layerCnt_ov_flag && seqCnt_ov_flag);
  assign wait_sample_in_pulse = (layerCnt_ov_flag && seqCnt_next_ov_flag);
  assign all_ifmap_ready_flag_clear = stateout_waitsamp;
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      LAYER_STATE_IDLE : begin
        if(start_once) begin
          next_state = LAYER_STATE_MATMUL_H;
        end
      end
      LAYER_STATE_MATMUL_H : begin
        if((is_first_seq && (! single_step_enable))) begin
          next_state = LAYER_STATE_MATMUL_I;
        end else begin
          if(matmul_done_once) begin
            next_state = LAYER_STATE_MATMUL_I;
          end
        end
      end
      LAYER_STATE_MATMUL_I : begin
        if(matmul_done_once) begin
          if(out_layer_in_pulse) begin
            next_state = LAYER_STATE_MATMUL_OUT;
          end else begin
            if(wait_sample_in_pulse) begin
              next_state = LAYER_STATE_WAIT_SAMPLE;
            end else begin
              next_state = LAYER_STATE_MATMUL_H;
            end
          end
        end
      end
      LAYER_STATE_WAIT_SAMPLE : begin
        if(all_ifmap_ready_flag) begin
          next_state = LAYER_STATE_MATMUL_H;
        end
      end
      LAYER_STATE_MATMUL_OUT : begin
        if(matmul_done_once) begin
          next_state = LAYER_STATE_PRED_COMP;
        end
      end
      default : begin
        if(pred_cnt_ov) begin
          next_state = LAYER_STATE_IDLE;
        end
      end
    endcase
  end

  assign matmul_done_once = matmul_unit_done;
  assign matmul_unit_need_relu = (curr_state == LAYER_STATE_MATMUL_I);
  assign matmul_unit_need_scale = ((curr_state == LAYER_STATE_MATMUL_I) || (curr_state == LAYER_STATE_MATMUL_OUT));
  assign matmul_unit_is_fc_layer = (curr_state == LAYER_STATE_MATMUL_OUT);
  always @(*) begin
    matmul_unit_ifmap_loop_num = 2'b00;
    if((curr_state == LAYER_STATE_MATMUL_I)) begin
      if((layerCnt == 2'b00)) begin
        matmul_unit_ifmap_loop_num = rg_rnn_ifmap_groupnum;
      end else begin
        matmul_unit_ifmap_loop_num = tmp_ifmap_loop_num;
      end
    end else begin
      if((curr_state == LAYER_STATE_MATMUL_H)) begin
        matmul_unit_ifmap_loop_num = tmp_curr_layer_line_num;
      end else begin
        if((curr_state == LAYER_STATE_MATMUL_OUT)) begin
          matmul_unit_ifmap_loop_num = tmp_ifmap_loop_num_2;
        end
      end
    end
  end

  assign tmp_curr_layer_line_num = tmp_tmp_curr_layer_line_num;
  always @(*) begin
    matmul_unit_ofmap_loop_num = 2'b00;
    if((curr_state == LAYER_STATE_MATMUL_OUT)) begin
      matmul_unit_ofmap_loop_num = 2'b00;
    end else begin
      matmul_unit_ofmap_loop_num = tmp_curr_layer_line_num;
    end
  end

  assign curr_layer_line_num = (tmp_curr_layer_line_num + 2'b01);
  assign last_layer_line_num = (tmp_last_layer_line_num + 2'b01);
  assign curr_hidden_layer_mem_line_num = (tmp_curr_hidden_layer_mem_line_num + tmp_curr_hidden_layer_mem_line_num_1);
  assign last_hidden_layer_mem_line_num = (tmp_last_hidden_layer_mem_line_num + tmp_last_hidden_layer_mem_line_num_1);
  assign layerCnt_incr_when_ov_pulse = (layerCnt_ov_flag && stateout_matmulI);
  assign next_read_ifmap_pointer = ({1'b0,read_ifmap_pointer} + tmp_next_read_ifmap_pointer);
  assign matmul_unit_curr_layer_line_num = {5'd0, curr_layer_line_num};
  always @(*) begin
    if((layerCnt == 2'b00)) begin
      if((curr_state == LAYER_STATE_MATMUL_I)) begin
        matmul_unit_ifmap_base_addr = read_ifmap_pointer;
      end else begin
        if((curr_state == LAYER_STATE_MATMUL_OUT)) begin
          matmul_unit_ifmap_base_addr = last_layer_ofmap_base;
        end else begin
          matmul_unit_ifmap_base_addr = curr_layer_ofmap_base;
        end
      end
    end else begin
      if((curr_state == LAYER_STATE_MATMUL_I)) begin
        matmul_unit_ifmap_base_addr = last_layer_ofmap_base;
      end else begin
        matmul_unit_ifmap_base_addr = curr_layer_ofmap_base;
      end
    end
  end

  always @(*) begin
    matmul_unit_psum_base_addr = 7'h00;
    if((curr_state == LAYER_STATE_MATMUL_H)) begin
      matmul_unit_psum_base_addr = tmp_psum_base_addr;
    end else begin
      if((curr_state == LAYER_STATE_MATMUL_I)) begin
        if((is_first_seq && (! single_step_enable))) begin
          matmul_unit_psum_base_addr = tmp_psum_base_addr;
        end else begin
          matmul_unit_psum_base_addr = (curr_layer_ofmap_base + tmp_psum_base_addr_1);
        end
      end else begin
        if((curr_state == LAYER_STATE_MATMUL_OUT)) begin
          matmul_unit_psum_base_addr = rg_rnn_fc_bias_addr;
        end
      end
    end
  end

  assign tmp_psum_base_addr = tmp_tmp_psum_base_addr;
  always @(*) begin
    matmul_unit_weight_base_addr = 7'h00;
    if((curr_state == LAYER_STATE_MATMUL_H)) begin
      matmul_unit_weight_base_addr = tmp_weight_base_addr;
    end else begin
      if((curr_state == LAYER_STATE_MATMUL_I)) begin
        matmul_unit_weight_base_addr = tmp_weight_base_addr_1;
      end else begin
        if((curr_state == LAYER_STATE_MATMUL_OUT)) begin
          matmul_unit_weight_base_addr = rg_rnn_fc_weight_addr;
        end
      end
    end
  end

  always @(*) begin
    matmul_unit_psum_come_from_coef = 1'b0;
    if(((curr_state == LAYER_STATE_MATMUL_H) || (curr_state == LAYER_STATE_MATMUL_OUT))) begin
      matmul_unit_psum_come_from_coef = 1'b1;
    end else begin
      if(((curr_state == LAYER_STATE_MATMUL_I) && (is_first_seq && (! single_step_enable)))) begin
        matmul_unit_psum_come_from_coef = 1'b1;
      end else begin
        if((curr_state == LAYER_STATE_MATMUL_I)) begin
          matmul_unit_psum_come_from_coef = 1'b0;
        end
      end
    end
  end

  assign coef_ena = matmul_unit_coef_ena;
  assign coef_wena = matmul_unit_coef_wena;
  assign coef_addr = matmul_unit_coef_addr;
  assign coef_wdata = matmul_unit_coef_wdata;
  assign cache_ena = matmul_unit_cache_ena;
  assign cache_wena = matmul_unit_cache_wena;
  assign cache_addr = matmul_unit_cache_addr;
  assign cache_wdata = matmul_unit_cache_wdata;
  assign result_out_cnt_ov = (result_out_cnt == tmp_result_out_cnt_ov);
  assign tmp_max_pred = tmp_tmp_max_pred;
  assign rnn_pred_index = pred_index;
  assign done = stateout_predComp_regNext;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      label_result_0 <= 16'h0000;
      label_result_1 <= 16'h0000;
      label_result_2 <= 16'h0000;
      label_result_3 <= 16'h0000;
      curr_state <= LAYER_STATE_IDLE;
      layerCnt <= 2'b00;
      seqCnt <= 4'b0000;
      pred_cnt <= 2'b00;
      single_step_enable <= 1'b0;
      rg_rnn_single_step_init_regNext <= 1'b0;
      all_statein_pulse <= 1'b0;
      curr_layer_ofmap_base <= 7'h00;
      last_layer_ofmap_base <= 7'h00;
      read_ifmap_pointer <= 7'h00;
      result_out_cnt <= 1'b0;
      max_pred <= 16'h0000;
      pred_index <= 2'b00;
      stateout_predComp_regNext <= 1'b0;
    end else begin
      curr_state <= next_state;
      rg_rnn_single_step_init_regNext <= rg_rnn_single_step_init;
      if(((! rnn_clk_en) && sing_step_init_pos)) begin
        single_step_enable <= 1'b0;
      end else begin
        if((rg_rnn_single_step_mode && single_step_every_done)) begin
          single_step_enable <= 1'b1;
        end else begin
          if(((! rg_rnn_single_step_mode) && single_step_every_done)) begin
            single_step_enable <= 1'b0;
          end
        end
      end
      all_statein_pulse <= ((statein_matmulI || statein_matmulH) || statein_matmulOut);
      if(stateout_matmulI) begin
        if(layerCnt_ov_flag) begin
          layerCnt <= 2'b00;
          if(seqCnt_ov_flag) begin
            seqCnt <= 4'b0000;
          end else begin
            seqCnt <= (seqCnt + 4'b0001);
          end
        end else begin
          layerCnt <= (layerCnt + 2'b01);
        end
      end
      if((start_once || layerCnt_incr_when_ov_pulse)) begin
        curr_layer_ofmap_base <= rg_cache_ofmap_base_addr;
      end else begin
        if(stateout_matmulI) begin
          curr_layer_ofmap_base <= (curr_layer_ofmap_base + tmp_curr_layer_ofmap_base);
        end
      end
      if(((start_once || (((! out_layer_in_pulse) && layerCnt_ov_flag) && stateout_matmulI)) || ((layerCnt == 2'b00) && stateout_matmulI))) begin
        last_layer_ofmap_base <= rg_cache_ofmap_base_addr;
      end else begin
        if(stateout_matmulI) begin
          last_layer_ofmap_base <= (last_layer_ofmap_base + tmp_last_layer_ofmap_base);
        end
      end
      if(start_once) begin
        read_ifmap_pointer <= read_ifmap_base_pointer;
      end else begin
        if((layerCnt_ov_flag && stateout_matmulI)) begin
          if((tmp_when <= next_read_ifmap_pointer)) begin
            read_ifmap_pointer <= 7'h00;
          end else begin
            read_ifmap_pointer <= next_read_ifmap_pointer[6:0];
          end
        end
      end
      if(((state_is_matmulOut && cache_wena) && cache_ena)) begin
        if(result_out_cnt_ov) begin
          result_out_cnt <= 1'b0;
        end else begin
          result_out_cnt <= (result_out_cnt + 1'b1);
        end
        if((result_out_cnt == 1'b0)) begin
          label_result_0 <= cache_wdata[15 : 0];
          label_result_1 <= cache_wdata[31 : 16];
        end else begin
          if((result_out_cnt == 1'b1)) begin
            label_result_2 <= cache_wdata[15 : 0];
            label_result_3 <= cache_wdata[31 : 16];
          end
        end
      end
      if(pred_cnt_incr) begin
        if(pred_cnt_ov) begin
          pred_cnt <= 2'b00;
        end else begin
          pred_cnt <= (pred_cnt + 2'b01);
        end
      end
      if(((pred_cnt == 2'b00) && pred_cnt_incr)) begin
        max_pred <= label_result_0;
        pred_index <= 2'b00;
      end else begin
        if(pred_cnt_incr) begin
          if(($signed(max_pred) < $signed(tmp_max_pred))) begin
            max_pred <= tmp_max_pred;
            pred_index <= pred_cnt;
          end
        end
      end
      stateout_predComp_regNext <= stateout_predComp;
    end
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      tmp_matmul_start_once <= 1'b0;
    end else begin
      tmp_matmul_start_once <= (statein_matmulI || statein_matmulOut);
    end
  end


endmodule

module amp_cal (
  input  wire          fdt_start_pulse,
  input  wire [11:0]   fdt_adc_in,
  input  wire          fdt_adc_in_vld,
  input  wire [4:0]    fdt_therm_comp_one_hot,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_0,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_1,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_2,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_3,
  input  wire [2:0]    rg_fdt_therm_comp_amp_ratio_4,
  output wire          amp_cal_end,
  output wire          norm_cal_end_pulse,
  output reg           norm_cal_end_req,
  input  wire          norm_cal_end_ack,
  output wire          iq_ready_pulse,
  input  wire          rg_fdt_en,
  input  wire          rg_fdt_wait_up,
  input  wire          rg_fdt_wait_down,
  input  wire          rg_fdt_auto_exit_en,
  input  wire [2:0]    rg_amp_data_ratio,
  input  wire          rg_amp_global_norm_mode,
  input  wire          rg_amp_multi_seq_norm_mode,
  input  wire [4:0]    rg_amp_samp_start_num,
  input  wire [2:0]    rg_amp_sample_num_log2,
  input  wire [3:0]    rg_amp_samp_gap_num,
  input  wire          rg_rnn_single_step_mode,
  input  wire          rg_rnn_single_step_init,
  input  wire [2:0]    rg_rnn_data_ratio,
  input  wire [6:0]    rg_cache_ofmap_base_addr,
  input  wire [3:0]    rg_rnn_seq_num,
  input  wire [1:0]    rg_rnn_layer_num,
  input  wire [1:0]    rg_rnn_ifmap_groupnum,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_0,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_1,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_2,
  input  wire [1:0]    rg_rnn_hidden_groupnum_layer_3,
  input  wire [6:0]    rg_rnn_bias_addr_layer_0,
  input  wire [6:0]    rg_rnn_bias_addr_layer_1,
  input  wire [6:0]    rg_rnn_bias_addr_layer_2,
  input  wire [6:0]    rg_rnn_bias_addr_layer_3,
  input  wire [6:0]    rg_rnn_whi_addr_layer_0,
  input  wire [6:0]    rg_rnn_whi_addr_layer_1,
  input  wire [6:0]    rg_rnn_whi_addr_layer_2,
  input  wire [6:0]    rg_rnn_whi_addr_layer_3,
  input  wire [6:0]    rg_rnn_whh_addr_layer_0,
  input  wire [6:0]    rg_rnn_whh_addr_layer_1,
  input  wire [6:0]    rg_rnn_whh_addr_layer_2,
  input  wire [6:0]    rg_rnn_whh_addr_layer_3,
  input  wire [6:0]    rg_rnn_fc_bias_addr,
  input  wire [6:0]    rg_rnn_fc_weight_addr,
  input  wire [1:0]    rg_rnn_fc_label_num,
  input  wire          rg_fdt_label_seq_en,
  input  wire [2:0]    rg_fdt_label_seq_length,
  output reg  [12:0]   smpArrayI_0,
  output reg  [12:0]   smpArrayI_1,
  output reg  [12:0]   smpArrayI_2,
  output reg  [12:0]   smpArrayI_3,
  output reg  [12:0]   smpArrayI_4,
  output reg  [12:0]   smpArrayI_5,
  output reg  [12:0]   smpArrayI_6,
  output reg  [12:0]   smpArrayI_7,
  output reg  [12:0]   smpArrayI_8,
  output reg  [12:0]   smpArrayI_9,
  output reg  [12:0]   smpArrayI_10,
  output reg  [12:0]   smpArrayI_11,
  output reg  [12:0]   smpArrayI_12,
  output reg  [12:0]   smpArrayI_13,
  output reg  [12:0]   smpArrayI_14,
  output reg  [12:0]   smpArrayI_15,
  output reg  [12:0]   smpArrayQ_0,
  output reg  [12:0]   smpArrayQ_1,
  output reg  [12:0]   smpArrayQ_2,
  output reg  [12:0]   smpArrayQ_3,
  output reg  [12:0]   smpArrayQ_4,
  output reg  [12:0]   smpArrayQ_5,
  output reg  [12:0]   smpArrayQ_6,
  output reg  [12:0]   smpArrayQ_7,
  output reg  [12:0]   smpArrayQ_8,
  output reg  [12:0]   smpArrayQ_9,
  output reg  [12:0]   smpArrayQ_10,
  output reg  [12:0]   smpArrayQ_11,
  output reg  [12:0]   smpArrayQ_12,
  output reg  [12:0]   smpArrayQ_13,
  output reg  [12:0]   smpArrayQ_14,
  output reg  [12:0]   smpArrayQ_15,
  input  wire          clkout,
  input  wire          rstn_80m
);
  localparam AMPSTATE_IDLE = 3'd0;
  localparam AMPSTATE_WAIT_SQUARE1 = 3'd1;
  localparam AMPSTATE_SQUARE2 = 3'd2;
  localparam AMPSTATE_SQRT = 3'd3;
  localparam AMPSTATE_NORM = 3'd4;

  wire       [12:0]   multiplier_dinA;
  wire                multiplier_din_vld;
  wire       [31:0]   sqrt_din;
  wire                lzc_unit_mode;
  wire                lzc_unit_lead;
  wire                lzc_unit_trail;
  wire       [15:0]   lzc_unit_data_in;
  wire       [25:0]   multiplier_dout;
  wire                multiplier_dout_vld;
  wire                sqrt_dout_vld;
  wire       [15:0]   sqrt_dout;
  wire       [4:0]    lzc_unit_cnt_out;
  wire       [1:0]    tmp_FrameCnt_valueNext;
  wire       [0:0]    tmp_FrameCnt_valueNext_1;
  wire       [4:0]    tmp_sampCnt_valueNext;
  wire       [0:0]    tmp_sampCnt_valueNext_1;
  wire       [4:0]    tmp_storeCnt_ov;
  wire       [4:0]    tmp_storeCnt_ov_1;
  wire       [4:0]    tmp_storeCnt_ov_2;
  wire       [4:0]    tmp_refCnt;
  wire       [4:0]    tmp_refCnt_1;
  reg        [12:0]   tmp_tmp_raw0_raw180_result;
  wire       [12:0]   tmp_raw0_raw180_result_1;
  wire       [12:0]   tmp_raw0_raw180_result_2;
  reg        [12:0]   tmp_tmp_raw90_raw270_result;
  wire       [12:0]   tmp_raw90_raw270_result_1;
  wire       [12:0]   tmp_raw90_raw270_result_2;
  wire       [12:0]   tmp_dinA;
  wire       [25:0]   tmp_sum_buffer;
  wire       [24:0]   tmp_sum_buffer_1;
  wire       [25:0]   tmp_sum_buffer_2;
  wire       [15:0]   tmp_amp_out;
  wire       [3:0]    tmp_amp_out_1;
  wire       [3:0]    tmp_amp_out_2;
  wire       [1:0]    tmp_amp_out_3;
  wire       [11:0]   tmp_mean_buffer;
  wire       [15:0]   tmp_data_in;
  wire       [11:0]   tmp_mean_num;
  wire       [19:0]   tmp_normValue;
  wire       [19:0]   tmp_normValue_1;
  wire       [12:0]   tmp_normValue_2;
  wire       [12:0]   tmp_normValue_3;
  wire       [12:0]   tmp_tmp_smpArrayQ_0;
  wire       [12:0]   tmp_smpArrayI_0_2;
  wire       [12:0]   tmp_smpArrayI_1;
  wire       [12:0]   tmp_smpArrayI_2;
  wire       [12:0]   tmp_tmp_smpArrayI_0_1;
  wire       [12:0]   tmp_tmp_smpArrayQ_0_1;
  reg                 FrameCnt_willIncrement;
  reg                 FrameCnt_willClear;
  reg        [1:0]    FrameCnt_valueNext;
  reg        [1:0]    FrameCnt_value;
  wire                FrameCnt_willOverflowIfInc;
  wire                FrameCnt_willOverflow;
  reg                 sampCnt_willIncrement;
  reg                 sampCnt_willClear;
  reg        [4:0]    sampCnt_valueNext;
  reg        [4:0]    sampCnt_value;
  wire                sampCnt_willOverflowIfInc;
  wire                sampCnt_willOverflow;
  reg        [4:0]    refCnt;
  reg        [3:0]    storeCnt;
  reg        [2:0]    curr_state;
  reg        [2:0]    next_state;
  reg                 tmp_iq_ready_pulse;
  wire                storeCnt_ov;
  wire                refCnt_inc;
  wire                one_cal_end;
  wire                one_frame_end;
  wire                samp_in_last_frame;
  wire                statein_square2;
  wire                stateout_square1;
  wire                stateout_square2;
  wire                state_is_norm;
  wire                stateout_norm;
  reg                 norm_cal_end_req_regNext;
  reg                 last_frame_cal_flag;
  reg        [24:0]   sum_buffer;
  wire       [12:0]   tmp_raw0_raw180_result;
  wire       [15:0]   tmp_1;
  wire                tmp_2;
  wire                tmp_3;
  wire                tmp_4;
  wire                tmp_5;
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
  wire       [12:0]   raw0_raw180_result;
  wire       [12:0]   tmp_raw90_raw270_result;
  wire       [15:0]   tmp_18;
  wire                tmp_19;
  wire                tmp_20;
  wire                tmp_21;
  wire                tmp_22;
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
  wire       [12:0]   raw90_raw270_result;
  reg                 stateout_square2_regNext;
  reg        [15:0]   amp_before_therm_comp;
  reg        [2:0]    therm_comp_ratio;
  wire       [7:0]    amp_out;
  reg        [7:0]    minValue;
  reg        [7:0]    maxValue;
  reg        [11:0]   mean_buffer;
  wire       [7:0]    max_minux_min;
  reg        [7:0]    normValue;
  wire       [2:0]    most_signifi_num;
  wire       [12:0]   mean_num;
  wire       [12:0]   tmp_smpArrayQ_0;
  wire       [7:0]    tmp_smpArrayI_0;
  wire       [12:0]   tmp_smpArrayI_0_1;
  wire       [12:0]   tmp_smpArrayQ_0_1;
  `ifndef SYNTHESIS
  reg [95:0] curr_state_string;
  reg [95:0] next_state_string;
  `endif


  assign tmp_FrameCnt_valueNext_1 = FrameCnt_willIncrement;
  assign tmp_FrameCnt_valueNext = {1'd0, tmp_FrameCnt_valueNext_1};
  assign tmp_sampCnt_valueNext_1 = sampCnt_willIncrement;
  assign tmp_sampCnt_valueNext = {4'd0, tmp_sampCnt_valueNext_1};
  assign tmp_storeCnt_ov = {1'd0, storeCnt};
  assign tmp_storeCnt_ov_1 = (tmp_storeCnt_ov_2 - 5'h01);
  assign tmp_storeCnt_ov_2 = (5'h01 <<< rg_amp_sample_num_log2);
  assign tmp_refCnt = (refCnt + tmp_refCnt_1);
  assign tmp_refCnt_1 = {1'd0, rg_amp_samp_gap_num};
  assign tmp_raw0_raw180_result_1 = tmp_raw0_raw180_result_2;
  assign tmp_raw0_raw180_result_2 = {1'd0, fdt_adc_in};
  assign tmp_raw90_raw270_result_1 = tmp_raw90_raw270_result_2;
  assign tmp_raw90_raw270_result_2 = {1'd0, fdt_adc_in};
  assign tmp_dinA = (statein_square2 ? tmp_raw0_raw180_result : 13'h0000);
  assign tmp_sum_buffer = multiplier_dout;
  assign tmp_sum_buffer_2 = multiplier_dout;
  assign tmp_sum_buffer_1 = tmp_sum_buffer_2[24:0];
  assign tmp_amp_out = (amp_before_therm_comp >>> tmp_amp_out_1);
  assign tmp_amp_out_1 = (tmp_amp_out_2 + {1'b0,rg_amp_data_ratio});
  assign tmp_amp_out_3 = {1'b0,1'b1};
  assign tmp_amp_out_2 = {2'd0, tmp_amp_out_3};
  assign tmp_mean_buffer = {4'd0, amp_out};
  assign tmp_data_in = {8'd0, max_minux_min};
  assign tmp_mean_num = (mean_buffer >>> rg_amp_sample_num_log2);
  assign tmp_normValue = ($signed(tmp_normValue_1) >>> most_signifi_num);
  assign tmp_normValue_1 = ({{7{tmp_normValue_2[12]}},tmp_normValue_2} <<< rg_rnn_data_ratio);
  assign tmp_normValue_2 = ($signed(tmp_raw90_raw270_result) - $signed(tmp_normValue_3));
  assign tmp_normValue_3 = mean_num;
  assign tmp_tmp_smpArrayQ_0 = {5'd0, amp_out};
  assign tmp_smpArrayI_0_2 = {1'd0, mean_buffer};
  assign tmp_smpArrayI_1 = {5'd0, maxValue};
  assign tmp_smpArrayI_2 = {5'd0, minValue};
  assign tmp_tmp_smpArrayI_0_1 = {1'd0, fdt_adc_in};
  assign tmp_tmp_smpArrayQ_0_1 = {1'd0, fdt_adc_in};
  SignMultiplier multiplier (
    .dinA     (multiplier_dinA[12:0]), //i
    .dinB     (multiplier_dinA[12:0]), //i
    .din_vld  (multiplier_din_vld   ), //i
    .dout     (multiplier_dout[25:0]), //o
    .dout_vld (multiplier_dout_vld  ), //o
    .clkout   (clkout               ), //i
    .rstn_80m (rstn_80m             )  //i
  );
  Sqrt_unsigned sqrt (
    .din_vld  (stateout_square2_regNext), //i
    .din      (sqrt_din[31:0]          ), //i
    .dout_vld (sqrt_dout_vld           ), //o
    .dout     (sqrt_dout[15:0]         ), //o
    .clkout   (clkout                  ), //i
    .rstn_80m (rstn_80m                )  //i
  );
  lzc_1 lzc_unit (
    .mode    (lzc_unit_mode         ), //i
    .lead    (lzc_unit_lead         ), //i
    .trail   (lzc_unit_trail        ), //i
    .data_in (lzc_unit_data_in[15:0]), //i
    .cnt_out (lzc_unit_cnt_out[4:0] )  //o
  );
  always @(*) begin
    case(storeCnt)
      4'b0000 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_0;
        tmp_tmp_raw90_raw270_result = smpArrayQ_0;
      end
      4'b0001 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_1;
        tmp_tmp_raw90_raw270_result = smpArrayQ_1;
      end
      4'b0010 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_2;
        tmp_tmp_raw90_raw270_result = smpArrayQ_2;
      end
      4'b0011 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_3;
        tmp_tmp_raw90_raw270_result = smpArrayQ_3;
      end
      4'b0100 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_4;
        tmp_tmp_raw90_raw270_result = smpArrayQ_4;
      end
      4'b0101 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_5;
        tmp_tmp_raw90_raw270_result = smpArrayQ_5;
      end
      4'b0110 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_6;
        tmp_tmp_raw90_raw270_result = smpArrayQ_6;
      end
      4'b0111 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_7;
        tmp_tmp_raw90_raw270_result = smpArrayQ_7;
      end
      4'b1000 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_8;
        tmp_tmp_raw90_raw270_result = smpArrayQ_8;
      end
      4'b1001 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_9;
        tmp_tmp_raw90_raw270_result = smpArrayQ_9;
      end
      4'b1010 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_10;
        tmp_tmp_raw90_raw270_result = smpArrayQ_10;
      end
      4'b1011 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_11;
        tmp_tmp_raw90_raw270_result = smpArrayQ_11;
      end
      4'b1100 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_12;
        tmp_tmp_raw90_raw270_result = smpArrayQ_12;
      end
      4'b1101 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_13;
        tmp_tmp_raw90_raw270_result = smpArrayQ_13;
      end
      4'b1110 : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_14;
        tmp_tmp_raw90_raw270_result = smpArrayQ_14;
      end
      default : begin
        tmp_tmp_raw0_raw180_result = smpArrayI_15;
        tmp_tmp_raw90_raw270_result = smpArrayQ_15;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(curr_state)
      AMPSTATE_IDLE : curr_state_string = "IDLE        ";
      AMPSTATE_WAIT_SQUARE1 : curr_state_string = "WAIT_SQUARE1";
      AMPSTATE_SQUARE2 : curr_state_string = "SQUARE2     ";
      AMPSTATE_SQRT : curr_state_string = "SQRT        ";
      AMPSTATE_NORM : curr_state_string = "NORM        ";
      default : curr_state_string = "????????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      AMPSTATE_IDLE : next_state_string = "IDLE        ";
      AMPSTATE_WAIT_SQUARE1 : next_state_string = "WAIT_SQUARE1";
      AMPSTATE_SQUARE2 : next_state_string = "SQUARE2     ";
      AMPSTATE_SQRT : next_state_string = "SQRT        ";
      AMPSTATE_NORM : next_state_string = "NORM        ";
      default : next_state_string = "????????????";
    endcase
  end
  `endif

  always @(*) begin
    FrameCnt_willIncrement = 1'b0;
    if(fdt_adc_in_vld) begin
      if(sampCnt_willOverflowIfInc) begin
        if(!FrameCnt_willOverflowIfInc) begin
          FrameCnt_willIncrement = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    FrameCnt_willClear = 1'b0;
    if(fdt_start_pulse) begin
      FrameCnt_willClear = 1'b1;
    end
    if(fdt_adc_in_vld) begin
      if(sampCnt_willOverflowIfInc) begin
        if(FrameCnt_willOverflowIfInc) begin
          FrameCnt_willClear = 1'b1;
        end
      end
    end
  end

  assign FrameCnt_willOverflowIfInc = (FrameCnt_value == 2'b11);
  assign FrameCnt_willOverflow = (FrameCnt_willOverflowIfInc && FrameCnt_willIncrement);
  always @(*) begin
    FrameCnt_valueNext = (FrameCnt_value + tmp_FrameCnt_valueNext);
    if(FrameCnt_willClear) begin
      FrameCnt_valueNext = 2'b00;
    end
  end

  always @(*) begin
    sampCnt_willIncrement = 1'b0;
    if(fdt_adc_in_vld) begin
      if(!sampCnt_willOverflowIfInc) begin
        sampCnt_willIncrement = 1'b1;
      end
    end
  end

  always @(*) begin
    sampCnt_willClear = 1'b0;
    if(fdt_start_pulse) begin
      sampCnt_willClear = 1'b1;
    end
    if(fdt_adc_in_vld) begin
      if(sampCnt_willOverflowIfInc) begin
        sampCnt_willClear = 1'b1;
      end
    end
  end

  assign sampCnt_willOverflowIfInc = (sampCnt_value == 5'h1f);
  assign sampCnt_willOverflow = (sampCnt_willOverflowIfInc && sampCnt_willIncrement);
  always @(*) begin
    sampCnt_valueNext = (sampCnt_value + tmp_sampCnt_valueNext);
    if(sampCnt_willClear) begin
      sampCnt_valueNext = 5'h00;
    end
  end

  assign iq_ready_pulse = tmp_iq_ready_pulse;
  assign storeCnt_ov = (tmp_storeCnt_ov == tmp_storeCnt_ov_1);
  assign refCnt_inc = ((refCnt == sampCnt_value) && fdt_adc_in_vld);
  assign one_frame_end = (fdt_adc_in_vld && sampCnt_willOverflowIfInc);
  assign samp_in_last_frame = (refCnt_inc && (curr_state == AMPSTATE_WAIT_SQUARE1));
  assign statein_square2 = ((curr_state != AMPSTATE_SQUARE2) && (next_state == AMPSTATE_SQUARE2));
  assign stateout_square1 = ((curr_state == AMPSTATE_WAIT_SQUARE1) && (next_state != AMPSTATE_WAIT_SQUARE1));
  assign stateout_square2 = ((curr_state == AMPSTATE_SQUARE2) && (next_state != AMPSTATE_SQUARE2));
  assign state_is_norm = (curr_state == AMPSTATE_NORM);
  assign stateout_norm = ((curr_state == AMPSTATE_NORM) && (next_state != AMPSTATE_NORM));
  assign amp_cal_end = (one_cal_end && storeCnt_ov);
  assign norm_cal_end_pulse = ((! norm_cal_end_req) && norm_cal_end_req_regNext);
  assign one_cal_end = sqrt_dout_vld;
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      AMPSTATE_IDLE : begin
        if(iq_ready_pulse) begin
          next_state = AMPSTATE_WAIT_SQUARE1;
        end
      end
      AMPSTATE_WAIT_SQUARE1 : begin
        if(multiplier_dout_vld) begin
          next_state = AMPSTATE_SQUARE2;
        end
      end
      AMPSTATE_SQUARE2 : begin
        if(multiplier_dout_vld) begin
          next_state = AMPSTATE_SQRT;
        end
      end
      AMPSTATE_SQRT : begin
        if(sqrt_dout_vld) begin
          if(storeCnt_ov) begin
            next_state = AMPSTATE_NORM;
          end else begin
            next_state = AMPSTATE_WAIT_SQUARE1;
          end
        end
      end
      default : begin
        if(storeCnt_ov) begin
          next_state = AMPSTATE_IDLE;
        end
      end
    endcase
  end

  assign tmp_raw0_raw180_result = tmp_tmp_raw0_raw180_result;
  assign tmp_1 = ({15'd0,1'b1} <<< storeCnt);
  assign tmp_2 = tmp_1[0];
  assign tmp_3 = tmp_1[1];
  assign tmp_4 = tmp_1[2];
  assign tmp_5 = tmp_1[3];
  assign tmp_6 = tmp_1[4];
  assign tmp_7 = tmp_1[5];
  assign tmp_8 = tmp_1[6];
  assign tmp_9 = tmp_1[7];
  assign tmp_10 = tmp_1[8];
  assign tmp_11 = tmp_1[9];
  assign tmp_12 = tmp_1[10];
  assign tmp_13 = tmp_1[11];
  assign tmp_14 = tmp_1[12];
  assign tmp_15 = tmp_1[13];
  assign tmp_16 = tmp_1[14];
  assign tmp_17 = tmp_1[15];
  assign raw0_raw180_result = ($signed(tmp_raw0_raw180_result) - $signed(tmp_raw0_raw180_result_1));
  assign tmp_raw90_raw270_result = tmp_tmp_raw90_raw270_result;
  assign tmp_18 = ({15'd0,1'b1} <<< storeCnt);
  assign tmp_19 = tmp_18[0];
  assign tmp_20 = tmp_18[1];
  assign tmp_21 = tmp_18[2];
  assign tmp_22 = tmp_18[3];
  assign tmp_23 = tmp_18[4];
  assign tmp_24 = tmp_18[5];
  assign tmp_25 = tmp_18[6];
  assign tmp_26 = tmp_18[7];
  assign tmp_27 = tmp_18[8];
  assign tmp_28 = tmp_18[9];
  assign tmp_29 = tmp_18[10];
  assign tmp_30 = tmp_18[11];
  assign tmp_31 = tmp_18[12];
  assign tmp_32 = tmp_18[13];
  assign tmp_33 = tmp_18[14];
  assign tmp_34 = tmp_18[15];
  assign raw90_raw270_result = ($signed(tmp_raw90_raw270_result) - $signed(tmp_raw90_raw270_result_1));
  assign multiplier_din_vld = (samp_in_last_frame || statein_square2);
  assign multiplier_dinA = (samp_in_last_frame ? raw90_raw270_result : tmp_dinA);
  assign sqrt_din = {7'd0, sum_buffer};
  always @(*) begin
    therm_comp_ratio = 3'b010;
    case(fdt_therm_comp_one_hot)
      5'h10 : begin
        therm_comp_ratio = rg_fdt_therm_comp_amp_ratio_0;
      end
      5'h08 : begin
        therm_comp_ratio = rg_fdt_therm_comp_amp_ratio_1;
      end
      5'h04 : begin
        therm_comp_ratio = rg_fdt_therm_comp_amp_ratio_2;
      end
      5'h02 : begin
        therm_comp_ratio = rg_fdt_therm_comp_amp_ratio_3;
      end
      5'h01 : begin
        therm_comp_ratio = rg_fdt_therm_comp_amp_ratio_4;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    amp_before_therm_comp = sqrt_dout;
    case(therm_comp_ratio)
      3'b000 : begin
        amp_before_therm_comp = (sqrt_dout >>> 2);
      end
      3'b001 : begin
        amp_before_therm_comp = (sqrt_dout >>> 1);
      end
      3'b010 : begin
        amp_before_therm_comp = sqrt_dout;
      end
      3'b011 : begin
        amp_before_therm_comp = (sqrt_dout <<< 1);
      end
      3'b100 : begin
        amp_before_therm_comp = (sqrt_dout <<< 2);
      end
      default : begin
      end
    endcase
  end

  assign amp_out = tmp_amp_out[7:0];
  assign max_minux_min = (maxValue - minValue);
  assign lzc_unit_mode = 1'b1;
  assign lzc_unit_lead = 1'b1;
  assign lzc_unit_trail = 1'b0;
  assign lzc_unit_data_in = tmp_data_in;
  assign most_signifi_num = ((lzc_unit_cnt_out == 5'h10) ? 3'b000 : lzc_unit_cnt_out[2 : 0]);
  assign mean_num = {1'd0, tmp_mean_num};
  always @(*) begin
    normValue = 8'h00;
    if(state_is_norm) begin
      if(rg_amp_global_norm_mode) begin
        normValue = amp_out;
      end else begin
        if(rg_amp_multi_seq_norm_mode) begin
          normValue = 8'h00;
        end else begin
          normValue = tmp_normValue[7:0];
        end
      end
    end
  end

  assign tmp_smpArrayQ_0 = tmp_tmp_smpArrayQ_0;
  assign tmp_smpArrayI_0 = normValue;
  assign tmp_smpArrayI_0_1 = tmp_tmp_smpArrayI_0_1;
  assign tmp_smpArrayQ_0_1 = tmp_tmp_smpArrayQ_0_1;
  always @(posedge clkout or negedge rstn_80m) begin
    if(!rstn_80m) begin
      norm_cal_end_req <= 1'b0;
      smpArrayI_0 <= 13'h0000;
      smpArrayI_1 <= 13'h0000;
      smpArrayI_2 <= 13'h0000;
      smpArrayI_3 <= 13'h0000;
      smpArrayI_4 <= 13'h0000;
      smpArrayI_5 <= 13'h0000;
      smpArrayI_6 <= 13'h0000;
      smpArrayI_7 <= 13'h0000;
      smpArrayI_8 <= 13'h0000;
      smpArrayI_9 <= 13'h0000;
      smpArrayI_10 <= 13'h0000;
      smpArrayI_11 <= 13'h0000;
      smpArrayI_12 <= 13'h0000;
      smpArrayI_13 <= 13'h0000;
      smpArrayI_14 <= 13'h0000;
      smpArrayI_15 <= 13'h0000;
      smpArrayQ_0 <= 13'h0000;
      smpArrayQ_1 <= 13'h0000;
      smpArrayQ_2 <= 13'h0000;
      smpArrayQ_3 <= 13'h0000;
      smpArrayQ_4 <= 13'h0000;
      smpArrayQ_5 <= 13'h0000;
      smpArrayQ_6 <= 13'h0000;
      smpArrayQ_7 <= 13'h0000;
      smpArrayQ_8 <= 13'h0000;
      smpArrayQ_9 <= 13'h0000;
      smpArrayQ_10 <= 13'h0000;
      smpArrayQ_11 <= 13'h0000;
      smpArrayQ_12 <= 13'h0000;
      smpArrayQ_13 <= 13'h0000;
      smpArrayQ_14 <= 13'h0000;
      smpArrayQ_15 <= 13'h0000;
      FrameCnt_value <= 2'b00;
      sampCnt_value <= 5'h00;
      refCnt <= 5'h00;
      storeCnt <= 4'b0000;
      curr_state <= AMPSTATE_IDLE;
      tmp_iq_ready_pulse <= 1'b0;
      norm_cal_end_req_regNext <= 1'b0;
      last_frame_cal_flag <= 1'b0;
      sum_buffer <= 25'h0000000;
      stateout_square2_regNext <= 1'b0;
      minValue <= 8'h00;
      maxValue <= 8'h00;
      mean_buffer <= 12'h000;
    end else begin
      FrameCnt_value <= FrameCnt_valueNext;
      sampCnt_value <= sampCnt_valueNext;
      tmp_iq_ready_pulse <= ((sampCnt_willOverflowIfInc && (FrameCnt_value == 2'b10)) && fdt_adc_in_vld);
      if(stateout_norm) begin
        norm_cal_end_req <= 1'b1;
      end else begin
        if(norm_cal_end_ack) begin
          norm_cal_end_req <= 1'b0;
        end
      end
      norm_cal_end_req_regNext <= norm_cal_end_req;
      if((fdt_start_pulse || one_frame_end)) begin
        refCnt <= rg_amp_samp_start_num;
      end else begin
        if(refCnt_inc) begin
          refCnt <= (tmp_refCnt + 5'h01);
        end
      end
      if(iq_ready_pulse) begin
        last_frame_cal_flag <= 1'b1;
      end else begin
        if(amp_cal_end) begin
          last_frame_cal_flag <= 1'b0;
        end
      end
      if(last_frame_cal_flag) begin
        if(one_cal_end) begin
          if(storeCnt_ov) begin
            storeCnt <= 4'b0000;
          end else begin
            storeCnt <= (storeCnt + 4'b0001);
          end
        end
      end else begin
        if(state_is_norm) begin
          if(storeCnt_ov) begin
            storeCnt <= 4'b0000;
          end else begin
            storeCnt <= (storeCnt + 4'b0001);
          end
        end else begin
          if(refCnt_inc) begin
            if(storeCnt_ov) begin
              storeCnt <= 4'b0000;
            end else begin
              storeCnt <= (storeCnt + 4'b0001);
            end
          end
        end
      end
      curr_state <= next_state;
      if(stateout_square1) begin
        sum_buffer <= tmp_sum_buffer[24:0];
      end else begin
        if(stateout_square2) begin
          sum_buffer <= (sum_buffer + tmp_sum_buffer_1);
        end
      end
      stateout_square2_regNext <= stateout_square2;
      if(last_frame_cal_flag) begin
        if(one_cal_end) begin
          if((storeCnt == 4'b0000)) begin
            minValue <= amp_out;
            maxValue <= amp_out;
            mean_buffer <= {4'd0, amp_out};
          end else begin
            mean_buffer <= (mean_buffer + tmp_mean_buffer);
            if((amp_out < minValue)) begin
              minValue <= amp_out;
            end
            if((maxValue < amp_out)) begin
              maxValue <= amp_out;
            end
          end
        end
      end
      if(last_frame_cal_flag) begin
        if(sqrt_dout_vld) begin
          if(tmp_19) begin
            smpArrayQ_0 <= tmp_smpArrayQ_0;
          end
          if(tmp_20) begin
            smpArrayQ_1 <= tmp_smpArrayQ_0;
          end
          if(tmp_21) begin
            smpArrayQ_2 <= tmp_smpArrayQ_0;
          end
          if(tmp_22) begin
            smpArrayQ_3 <= tmp_smpArrayQ_0;
          end
          if(tmp_23) begin
            smpArrayQ_4 <= tmp_smpArrayQ_0;
          end
          if(tmp_24) begin
            smpArrayQ_5 <= tmp_smpArrayQ_0;
          end
          if(tmp_25) begin
            smpArrayQ_6 <= tmp_smpArrayQ_0;
          end
          if(tmp_26) begin
            smpArrayQ_7 <= tmp_smpArrayQ_0;
          end
          if(tmp_27) begin
            smpArrayQ_8 <= tmp_smpArrayQ_0;
          end
          if(tmp_28) begin
            smpArrayQ_9 <= tmp_smpArrayQ_0;
          end
          if(tmp_29) begin
            smpArrayQ_10 <= tmp_smpArrayQ_0;
          end
          if(tmp_30) begin
            smpArrayQ_11 <= tmp_smpArrayQ_0;
          end
          if(tmp_31) begin
            smpArrayQ_12 <= tmp_smpArrayQ_0;
          end
          if(tmp_32) begin
            smpArrayQ_13 <= tmp_smpArrayQ_0;
          end
          if(tmp_33) begin
            smpArrayQ_14 <= tmp_smpArrayQ_0;
          end
          if(tmp_34) begin
            smpArrayQ_15 <= tmp_smpArrayQ_0;
          end
        end
      end else begin
        if(state_is_norm) begin
          if(rg_amp_global_norm_mode) begin
            smpArrayI_0 <= tmp_smpArrayI_0_2;
            smpArrayI_1 <= tmp_smpArrayI_1;
            smpArrayI_2 <= tmp_smpArrayI_2;
          end else begin
            if(rg_amp_multi_seq_norm_mode) begin
              smpArrayI_0 <= mean_num;
            end else begin
              if(tmp_2) begin
                smpArrayI_0 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_3) begin
                smpArrayI_1 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_4) begin
                smpArrayI_2 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_5) begin
                smpArrayI_3 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_6) begin
                smpArrayI_4 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_7) begin
                smpArrayI_5 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_8) begin
                smpArrayI_6 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_9) begin
                smpArrayI_7 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_10) begin
                smpArrayI_8 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_11) begin
                smpArrayI_9 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_12) begin
                smpArrayI_10 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_13) begin
                smpArrayI_11 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_14) begin
                smpArrayI_12 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_15) begin
                smpArrayI_13 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_16) begin
                smpArrayI_14 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
              if(tmp_17) begin
                smpArrayI_15 <= {{5{tmp_smpArrayI_0[7]}}, tmp_smpArrayI_0};
              end
            end
          end
        end else begin
          if(refCnt_inc) begin
            case(FrameCnt_value)
              2'b00 : begin
                if(tmp_2) begin
                  smpArrayI_0 <= tmp_smpArrayI_0_1;
                end
                if(tmp_3) begin
                  smpArrayI_1 <= tmp_smpArrayI_0_1;
                end
                if(tmp_4) begin
                  smpArrayI_2 <= tmp_smpArrayI_0_1;
                end
                if(tmp_5) begin
                  smpArrayI_3 <= tmp_smpArrayI_0_1;
                end
                if(tmp_6) begin
                  smpArrayI_4 <= tmp_smpArrayI_0_1;
                end
                if(tmp_7) begin
                  smpArrayI_5 <= tmp_smpArrayI_0_1;
                end
                if(tmp_8) begin
                  smpArrayI_6 <= tmp_smpArrayI_0_1;
                end
                if(tmp_9) begin
                  smpArrayI_7 <= tmp_smpArrayI_0_1;
                end
                if(tmp_10) begin
                  smpArrayI_8 <= tmp_smpArrayI_0_1;
                end
                if(tmp_11) begin
                  smpArrayI_9 <= tmp_smpArrayI_0_1;
                end
                if(tmp_12) begin
                  smpArrayI_10 <= tmp_smpArrayI_0_1;
                end
                if(tmp_13) begin
                  smpArrayI_11 <= tmp_smpArrayI_0_1;
                end
                if(tmp_14) begin
                  smpArrayI_12 <= tmp_smpArrayI_0_1;
                end
                if(tmp_15) begin
                  smpArrayI_13 <= tmp_smpArrayI_0_1;
                end
                if(tmp_16) begin
                  smpArrayI_14 <= tmp_smpArrayI_0_1;
                end
                if(tmp_17) begin
                  smpArrayI_15 <= tmp_smpArrayI_0_1;
                end
              end
              2'b01 : begin
                if(tmp_19) begin
                  smpArrayQ_0 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_20) begin
                  smpArrayQ_1 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_21) begin
                  smpArrayQ_2 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_22) begin
                  smpArrayQ_3 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_23) begin
                  smpArrayQ_4 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_24) begin
                  smpArrayQ_5 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_25) begin
                  smpArrayQ_6 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_26) begin
                  smpArrayQ_7 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_27) begin
                  smpArrayQ_8 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_28) begin
                  smpArrayQ_9 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_29) begin
                  smpArrayQ_10 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_30) begin
                  smpArrayQ_11 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_31) begin
                  smpArrayQ_12 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_32) begin
                  smpArrayQ_13 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_33) begin
                  smpArrayQ_14 <= tmp_smpArrayQ_0_1;
                end
                if(tmp_34) begin
                  smpArrayQ_15 <= tmp_smpArrayQ_0_1;
                end
              end
              2'b10 : begin
                if(tmp_2) begin
                  smpArrayI_0 <= raw0_raw180_result;
                end
                if(tmp_3) begin
                  smpArrayI_1 <= raw0_raw180_result;
                end
                if(tmp_4) begin
                  smpArrayI_2 <= raw0_raw180_result;
                end
                if(tmp_5) begin
                  smpArrayI_3 <= raw0_raw180_result;
                end
                if(tmp_6) begin
                  smpArrayI_4 <= raw0_raw180_result;
                end
                if(tmp_7) begin
                  smpArrayI_5 <= raw0_raw180_result;
                end
                if(tmp_8) begin
                  smpArrayI_6 <= raw0_raw180_result;
                end
                if(tmp_9) begin
                  smpArrayI_7 <= raw0_raw180_result;
                end
                if(tmp_10) begin
                  smpArrayI_8 <= raw0_raw180_result;
                end
                if(tmp_11) begin
                  smpArrayI_9 <= raw0_raw180_result;
                end
                if(tmp_12) begin
                  smpArrayI_10 <= raw0_raw180_result;
                end
                if(tmp_13) begin
                  smpArrayI_11 <= raw0_raw180_result;
                end
                if(tmp_14) begin
                  smpArrayI_12 <= raw0_raw180_result;
                end
                if(tmp_15) begin
                  smpArrayI_13 <= raw0_raw180_result;
                end
                if(tmp_16) begin
                  smpArrayI_14 <= raw0_raw180_result;
                end
                if(tmp_17) begin
                  smpArrayI_15 <= raw0_raw180_result;
                end
              end
              default : begin
              end
            endcase
          end
        end
      end
    end
  end


endmodule

module clkGate_func (
  input  wire          scan_en,
  input  wire          enable,
  output wire          clkout,
  input  wire          clk_80m
);

  /* verilator lint_off LATCH */ reg                 ck_latch;

  always @(*) begin
    if((! clk_80m)) begin
      ck_latch = (scan_en || enable);
    end
  end

  assign clkout = (ck_latch && clk_80m);

endmodule

//lzc replaced by lzc_1

module matmul (
  input  wire          start_once,
  input  wire          need_relu,
  input  wire          need_scale,
  input  wire          is_fc_layer,
  input  wire [1:0]    label_num,
  input  wire [2:0]    rg_rnn_data_ratio,
  input  wire [1:0]    ifmap_loop_num,
  input  wire [1:0]    ofmap_loop_num,
  input  wire [6:0]    curr_layer_line_num,
  input  wire [6:0]    psum_base_addr,
  input  wire [6:0]    weight_base_addr,
  input  wire [6:0]    ifmap_base_addr,
  input  wire [6:0]    ofmap_base_addr,
  input  wire          psum_come_from_coef,
  output reg           coef_ena,
  output reg           coef_wena,
  output reg  [6:0]    coef_addr,
  output reg  [31:0]   coef_wdata,
  input  wire [31:0]   coef_rdata,
  output reg           cache_ena,
  output reg           cache_wena,
  output reg  [6:0]    cache_addr,
  output reg  [31:0]   cache_wdata,
  input  wire [31:0]   cache_rdata,
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
  wire       [20:0]   mac_psum_in;
  wire       [20:0]   mac_psum_out;
  wire                mac_psum_acc_valid;
  wire       [2:0]    tmp_outLoopCnt_ov_flag;
  wire       [2:0]    tmp_outLoopCnt_ov_flag_1;
  wire       [1:0]    tmp_outLoopCnt_ov_flag_2;
  wire       [5:0]    tmp_when;
  wire       [4:0]    tmp_when_1;
  wire       [5:0]    tmp_when_2;
  wire       [4:0]    tmp_when_3;
  wire       [5:0]    tmp_when_4;
  wire       [4:0]    tmp_when_5;
  wire       [5:0]    tmp_when_6;
  wire       [4:0]    tmp_when_7;
  wire       [5:0]    tmp_when_8;
  wire       [4:0]    tmp_when_9;
  wire       [8:0]    tmp_when_10;
  wire       [7:0]    tmp_when_11;
  wire       [7:0]    tmp_when_12;
  wire       [5:0]    tmp_when_13;
  wire       [4:0]    tmp_when_14;
  wire       [8:0]    tmp_when_15;
  wire       [7:0]    tmp_when_16;
  wire       [7:0]    tmp_when_17;
  wire       [5:0]    tmp_when_18;
  wire       [4:0]    tmp_when_19;
  wire       [8:0]    tmp_when_20;
  wire       [7:0]    tmp_when_21;
  wire       [7:0]    tmp_when_22;
  wire       [5:0]    tmp_when_23;
  wire       [4:0]    tmp_when_24;
  wire       [8:0]    tmp_when_25;
  wire       [7:0]    tmp_when_26;
  wire       [7:0]    tmp_when_27;
  wire       [6:0]    tmp_coef_addr;
  wire       [3:0]    tmp_coef_addr_1;
  wire       [6:0]    tmp_coef_addr_2;
  wire       [6:0]    tmp_coef_addr_3;
  wire       [3:0]    tmp_coef_addr_4;
  wire       [6:0]    tmp_cache_addr;
  wire       [3:0]    tmp_cache_addr_1;
  wire       [6:0]    tmp_cache_addr_2;
  wire       [6:0]    tmp_cache_addr_3;
  wire       [3:0]    tmp_cache_addr_4;
  wire       [6:0]    tmp_cache_addr_5;
  wire       [6:0]    tmp_cache_addr_6;
  wire       [6:0]    tmp_cache_addr_7;
  wire       [6:0]    tmp_cache_addr_8;
  wire       [3:0]    tmp_cache_addr_9;
  wire       [6:0]    tmp_cache_addr_10;
  wire       [6:0]    tmp_cache_addr_11;
  wire       [6:0]    tmp_cache_addr_12;
  wire       [3:0]    tmp_cache_addr_13;
  reg        [20:0]   tmp_psum_in;
  wire       [20:0]   tmp_mac_psum_buffer_2;
  wire       [22:0]   tmp_mac_psum_buffer_2_1;
  wire       [15:0]   tmp_mac_psum_buffer_2_2;
  wire       [20:0]   tmp_mac_psum_buffer_3;
  wire       [22:0]   tmp_mac_psum_buffer_3_1;
  wire       [15:0]   tmp_mac_psum_buffer_3_2;
  wire       [20:0]   tmp_mac_psum_buffer_0;
  wire       [22:0]   tmp_mac_psum_buffer_0_1;
  wire       [15:0]   tmp_mac_psum_buffer_0_2;
  wire       [20:0]   tmp_mac_psum_buffer_1;
  wire       [22:0]   tmp_mac_psum_buffer_1_1;
  wire       [15:0]   tmp_mac_psum_buffer_1_2;
  wire       [20:0]   tmp_mac_psum_buffer_2_3;
  wire       [15:0]   tmp_mac_psum_buffer_2_4;
  wire       [20:0]   tmp_mac_psum_buffer_3_3;
  wire       [15:0]   tmp_mac_psum_buffer_3_4;
  wire       [20:0]   tmp_mac_psum_buffer_0_3;
  wire       [15:0]   tmp_mac_psum_buffer_0_4;
  wire       [20:0]   tmp_mac_psum_buffer_1_3;
  wire       [15:0]   tmp_mac_psum_buffer_1_4;
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
  reg                 mac_once_finish;
  reg                 write_psum_pulse1;
  reg                 write_psum_pulse2;
  reg        [20:0]   mac_psum_buffer_0;
  reg        [20:0]   mac_psum_buffer_1;
  reg        [20:0]   mac_psum_buffer_2;
  reg        [20:0]   mac_psum_buffer_3;
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
  reg        [15:0]   mac_psum_out_16b_0_0;
  reg        [15:0]   mac_psum_out_16b_0_1;
  reg        [15:0]   mac_psum_out_16b_1_0;
  reg        [15:0]   mac_psum_out_16b_1_1;
  wire       [20:0]   tmp_mac_psum_out_16b_0_0;
  reg        [15:0]   tmp_mac_psum_out_16b_0_0_1;
  wire       [20:0]   tmp_mac_psum_out_16b_1_0;
  reg        [15:0]   tmp_mac_psum_out_16b_1_0_1;
  wire       [20:0]   tmp_mac_psum_out_16b_0_1;
  reg        [15:0]   tmp_mac_psum_out_16b_0_1_1;
  wire       [20:0]   tmp_mac_psum_out_16b_1_1;
  reg        [15:0]   tmp_mac_psum_out_16b_1_1_1;
  wire       [20:0]   tmp_mac_psum_buffer_scale_0;
  reg        [15:0]   tmp_mac_psum_buffer_scale_0_1;
  reg        [7:0]    tmp_mac_psum_buffer_cut_0;
  wire       [20:0]   tmp_mac_psum_buffer_scale_1;
  reg        [15:0]   tmp_mac_psum_buffer_scale_1_1;
  reg        [7:0]    tmp_mac_psum_buffer_cut_1;
  wire       [20:0]   tmp_mac_psum_buffer_scale_2;
  reg        [15:0]   tmp_mac_psum_buffer_scale_2_1;
  reg        [7:0]    tmp_mac_psum_buffer_cut_2;
  wire       [20:0]   tmp_mac_psum_buffer_scale_3;
  reg        [15:0]   tmp_mac_psum_buffer_scale_3_1;
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
  reg        [6:0]    weight_read_addr;
  reg                 incnt_inc_flag_true_regNext;
  wire                read_mac_input_end;
  wire                fc_layer_write_psum_en_pulse1;
  wire                fc_layer_write_psum_en_pulse2;
  reg                 tmp_switch_psum_pulse;
  reg                 tmp_switch_psum_pulse_1;
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
  assign tmp_when = tmp_mac_psum_out_16b_0_0[20 : 15];
  assign tmp_when_1 = tmp_mac_psum_out_16b_0_0[19 : 15];
  assign tmp_when_2 = tmp_mac_psum_out_16b_1_0[20 : 15];
  assign tmp_when_3 = tmp_mac_psum_out_16b_1_0[19 : 15];
  assign tmp_when_4 = tmp_mac_psum_out_16b_0_1[20 : 15];
  assign tmp_when_5 = tmp_mac_psum_out_16b_0_1[19 : 15];
  assign tmp_when_6 = tmp_mac_psum_out_16b_1_1[20 : 15];
  assign tmp_when_7 = tmp_mac_psum_out_16b_1_1[19 : 15];
  assign tmp_when_8 = tmp_mac_psum_buffer_scale_0[20 : 15];
  assign tmp_when_9 = tmp_mac_psum_buffer_scale_0[19 : 15];
  assign tmp_when_10 = mac_psum_buffer_scale_0[15 : 7];
  assign tmp_when_11 = mac_psum_buffer_scale_0[14 : 7];
  assign tmp_when_12 = mac_psum_buffer_cut_0;
  assign tmp_when_13 = tmp_mac_psum_buffer_scale_1[20 : 15];
  assign tmp_when_14 = tmp_mac_psum_buffer_scale_1[19 : 15];
  assign tmp_when_15 = mac_psum_buffer_scale_1[15 : 7];
  assign tmp_when_16 = mac_psum_buffer_scale_1[14 : 7];
  assign tmp_when_17 = mac_psum_buffer_cut_1;
  assign tmp_when_18 = tmp_mac_psum_buffer_scale_2[20 : 15];
  assign tmp_when_19 = tmp_mac_psum_buffer_scale_2[19 : 15];
  assign tmp_when_20 = mac_psum_buffer_scale_2[15 : 7];
  assign tmp_when_21 = mac_psum_buffer_scale_2[14 : 7];
  assign tmp_when_22 = mac_psum_buffer_cut_2;
  assign tmp_when_23 = tmp_mac_psum_buffer_scale_3[20 : 15];
  assign tmp_when_24 = tmp_mac_psum_buffer_scale_3[19 : 15];
  assign tmp_when_25 = mac_psum_buffer_scale_3[15 : 7];
  assign tmp_when_26 = mac_psum_buffer_scale_3[14 : 7];
  assign tmp_when_27 = mac_psum_buffer_cut_3;
  assign tmp_coef_addr_1 = ({1'd0,outLoopCnt} <<< 1'd1);
  assign tmp_coef_addr = {3'd0, tmp_coef_addr_1};
  assign tmp_coef_addr_2 = (psum_base_addr + tmp_coef_addr_3);
  assign tmp_coef_addr_4 = ({1'd0,outLoopCnt} <<< 1'd1);
  assign tmp_coef_addr_3 = {3'd0, tmp_coef_addr_4};
  assign tmp_cache_addr_1 = ({1'd0,outLoopCnt} <<< 1'd1);
  assign tmp_cache_addr = {3'd0, tmp_cache_addr_1};
  assign tmp_cache_addr_2 = (psum_base_addr + tmp_cache_addr_3);
  assign tmp_cache_addr_4 = ({1'd0,outLoopCnt} <<< 1'd1);
  assign tmp_cache_addr_3 = {3'd0, tmp_cache_addr_4};
  assign tmp_cache_addr_5 = {5'd0, inCnt};
  assign tmp_cache_addr_6 = {4'd0, outLoopCnt};
  assign tmp_cache_addr_7 = (ofmap_base_addr + curr_layer_line_num);
  assign tmp_cache_addr_9 = ({1'd0,outLoopCnt} <<< 1'd1);
  assign tmp_cache_addr_8 = {3'd0, tmp_cache_addr_9};
  assign tmp_cache_addr_10 = (tmp_cache_addr_11 + tmp_cache_addr_12);
  assign tmp_cache_addr_11 = (ofmap_base_addr + curr_layer_line_num);
  assign tmp_cache_addr_13 = ({1'd0,outLoopCnt} <<< 1'd1);
  assign tmp_cache_addr_12 = {3'd0, tmp_cache_addr_13};
  assign tmp_mac_psum_buffer_2_1 = ({{7{tmp_mac_psum_buffer_2_2[15]}},tmp_mac_psum_buffer_2_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_2 = tmp_mac_psum_buffer_2_1[20:0];
  assign tmp_mac_psum_buffer_2_2 = coef_rdata[15 : 0];
  assign tmp_mac_psum_buffer_3_1 = ({{7{tmp_mac_psum_buffer_3_2[15]}},tmp_mac_psum_buffer_3_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_3 = tmp_mac_psum_buffer_3_1[20:0];
  assign tmp_mac_psum_buffer_3_2 = coef_rdata[31 : 16];
  assign tmp_mac_psum_buffer_0_1 = ({{7{tmp_mac_psum_buffer_0_2[15]}},tmp_mac_psum_buffer_0_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_0 = tmp_mac_psum_buffer_0_1[20:0];
  assign tmp_mac_psum_buffer_0_2 = coef_rdata[15 : 0];
  assign tmp_mac_psum_buffer_1_1 = ({{7{tmp_mac_psum_buffer_1_2[15]}},tmp_mac_psum_buffer_1_2} <<< rg_rnn_data_ratio);
  assign tmp_mac_psum_buffer_1 = tmp_mac_psum_buffer_1_1[20:0];
  assign tmp_mac_psum_buffer_1_2 = coef_rdata[31 : 16];
  assign tmp_mac_psum_buffer_2_4 = cache_rdata[15 : 0];
  assign tmp_mac_psum_buffer_2_3 = {{5{tmp_mac_psum_buffer_2_4[15]}}, tmp_mac_psum_buffer_2_4};
  assign tmp_mac_psum_buffer_3_4 = cache_rdata[31 : 16];
  assign tmp_mac_psum_buffer_3_3 = {{5{tmp_mac_psum_buffer_3_4[15]}}, tmp_mac_psum_buffer_3_4};
  assign tmp_mac_psum_buffer_0_4 = cache_rdata[15 : 0];
  assign tmp_mac_psum_buffer_0_3 = {{5{tmp_mac_psum_buffer_0_4[15]}}, tmp_mac_psum_buffer_0_4};
  assign tmp_mac_psum_buffer_1_4 = cache_rdata[31 : 16];
  assign tmp_mac_psum_buffer_1_3 = {{5{tmp_mac_psum_buffer_1_4[15]}}, tmp_mac_psum_buffer_1_4};
  mac_unit mac (
    .clka           (mac_clka            ), //i
    .rstn_a         (mac_rstn_a          ), //i
    .valid          (mac_input_valid_flag), //i
    .A_0            (mac_weight_in_0[7:0]), //i
    .A_1            (mac_weight_in_1[7:0]), //i
    .A_2            (mac_weight_in_2[7:0]), //i
    .A_3            (mac_weight_in_3[7:0]), //i
    .B_0            (mac_ifmap_in_0[7:0] ), //i
    .B_1            (mac_ifmap_in_1[7:0] ), //i
    .B_2            (mac_ifmap_in_2[7:0] ), //i
    .B_3            (mac_ifmap_in_3[7:0] ), //i
    .psum_in        (mac_psum_in[20:0]   ), //i
    .psum_out       (mac_psum_out[20:0]  ), //o
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

  assign outCnt_ov_flag = (outCnt == 2'b11);
  assign inCnt_ov_flag = (inCnt == ifmap_loop_num);
  assign outLoopCnt_ov_flag = (outLoopCnt == tmp_outLoopCnt_ov_flag);
  assign mac_pipe_last2_valid_fall = ((! mac_input_valid_flag) && mac_input_valid_flag_regNext);
  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_16b_0_0 = mac_psum_buffer_scale_0;
    end else begin
      mac_psum_out_16b_0_0 = tmp_mac_psum_out_16b_0_0_1;
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_16b_1_0 = mac_psum_buffer_scale_2;
    end else begin
      mac_psum_out_16b_1_0 = tmp_mac_psum_out_16b_1_0_1;
    end
  end

  assign tmp_mac_psum_out_16b_0_0 = mac_psum_buffer_0;
  always @(*) begin
    if(tmp_mac_psum_out_16b_0_0[20]) begin
      if((! (&tmp_when))) begin
        tmp_mac_psum_out_16b_0_0_1 = 16'h8000;
      end else begin
        tmp_mac_psum_out_16b_0_0_1 = tmp_mac_psum_out_16b_0_0[15 : 0];
      end
    end else begin
      if((|tmp_when_1)) begin
        tmp_mac_psum_out_16b_0_0_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_out_16b_0_0_1 = tmp_mac_psum_out_16b_0_0[15 : 0];
      end
    end
  end

  assign tmp_mac_psum_out_16b_1_0 = mac_psum_buffer_2;
  always @(*) begin
    if(tmp_mac_psum_out_16b_1_0[20]) begin
      if((! (&tmp_when_2))) begin
        tmp_mac_psum_out_16b_1_0_1 = 16'h8000;
      end else begin
        tmp_mac_psum_out_16b_1_0_1 = tmp_mac_psum_out_16b_1_0[15 : 0];
      end
    end else begin
      if((|tmp_when_3)) begin
        tmp_mac_psum_out_16b_1_0_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_out_16b_1_0_1 = tmp_mac_psum_out_16b_1_0[15 : 0];
      end
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_16b_0_1 = mac_psum_buffer_scale_1;
    end else begin
      mac_psum_out_16b_0_1 = tmp_mac_psum_out_16b_0_1_1;
    end
  end

  always @(*) begin
    if(is_fc_layer) begin
      mac_psum_out_16b_1_1 = mac_psum_buffer_scale_3;
    end else begin
      mac_psum_out_16b_1_1 = tmp_mac_psum_out_16b_1_1_1;
    end
  end

  assign tmp_mac_psum_out_16b_0_1 = mac_psum_buffer_1;
  always @(*) begin
    if(tmp_mac_psum_out_16b_0_1[20]) begin
      if((! (&tmp_when_4))) begin
        tmp_mac_psum_out_16b_0_1_1 = 16'h8000;
      end else begin
        tmp_mac_psum_out_16b_0_1_1 = tmp_mac_psum_out_16b_0_1[15 : 0];
      end
    end else begin
      if((|tmp_when_5)) begin
        tmp_mac_psum_out_16b_0_1_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_out_16b_0_1_1 = tmp_mac_psum_out_16b_0_1[15 : 0];
      end
    end
  end

  assign tmp_mac_psum_out_16b_1_1 = mac_psum_buffer_3;
  always @(*) begin
    if(tmp_mac_psum_out_16b_1_1[20]) begin
      if((! (&tmp_when_6))) begin
        tmp_mac_psum_out_16b_1_1_1 = 16'h8000;
      end else begin
        tmp_mac_psum_out_16b_1_1_1 = tmp_mac_psum_out_16b_1_1[15 : 0];
      end
    end else begin
      if((|tmp_when_7)) begin
        tmp_mac_psum_out_16b_1_1_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_out_16b_1_1_1 = tmp_mac_psum_out_16b_1_1[15 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_0 = 16'h0000;
    if((need_scale && ((mac_once_finish || write_psum_pulse1) || write_psum_pulse2))) begin
      mac_psum_buffer_scale_0 = ($signed(tmp_mac_psum_buffer_scale_0_1) >>> rg_rnn_data_ratio);
    end
  end

  always @(*) begin
    mac_psum_buffer_cut_0 = 8'h00;
    if((need_scale && ((mac_once_finish || write_psum_pulse1) || write_psum_pulse2))) begin
      mac_psum_buffer_cut_0 = tmp_mac_psum_buffer_cut_0;
    end
  end

  always @(*) begin
    mac_psum_out_8b_0 = 8'h00;
    if(((mac_once_finish || write_psum_pulse1) || write_psum_pulse2)) begin
      if(need_relu) begin
        if(($signed(8'h00) < $signed(tmp_when_12))) begin
          mac_psum_out_8b_0 = mac_psum_buffer_cut_0;
        end else begin
          mac_psum_out_8b_0 = 8'h00;
        end
      end else begin
        mac_psum_out_8b_0 = mac_psum_buffer_cut_0;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_0 = mac_psum_buffer_0;
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_0[20]) begin
      if((! (&tmp_when_8))) begin
        tmp_mac_psum_buffer_scale_0_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_0_1 = tmp_mac_psum_buffer_scale_0[15 : 0];
      end
    end else begin
      if((|tmp_when_9)) begin
        tmp_mac_psum_buffer_scale_0_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_0_1 = tmp_mac_psum_buffer_scale_0[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_0[15]) begin
      if((! (&tmp_when_10))) begin
        tmp_mac_psum_buffer_cut_0 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_cut_0 = mac_psum_buffer_scale_0[7 : 0];
      end
    end else begin
      if((|tmp_when_11)) begin
        tmp_mac_psum_buffer_cut_0 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_cut_0 = mac_psum_buffer_scale_0[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_1 = 16'h0000;
    if((need_scale && ((mac_once_finish || write_psum_pulse1) || write_psum_pulse2))) begin
      mac_psum_buffer_scale_1 = ($signed(tmp_mac_psum_buffer_scale_1_1) >>> rg_rnn_data_ratio);
    end
  end

  always @(*) begin
    mac_psum_buffer_cut_1 = 8'h00;
    if((need_scale && ((mac_once_finish || write_psum_pulse1) || write_psum_pulse2))) begin
      mac_psum_buffer_cut_1 = tmp_mac_psum_buffer_cut_1;
    end
  end

  always @(*) begin
    mac_psum_out_8b_1 = 8'h00;
    if(((mac_once_finish || write_psum_pulse1) || write_psum_pulse2)) begin
      if(need_relu) begin
        if(($signed(8'h00) < $signed(tmp_when_17))) begin
          mac_psum_out_8b_1 = mac_psum_buffer_cut_1;
        end else begin
          mac_psum_out_8b_1 = 8'h00;
        end
      end else begin
        mac_psum_out_8b_1 = mac_psum_buffer_cut_1;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_1 = mac_psum_buffer_1;
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_1[20]) begin
      if((! (&tmp_when_13))) begin
        tmp_mac_psum_buffer_scale_1_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_1_1 = tmp_mac_psum_buffer_scale_1[15 : 0];
      end
    end else begin
      if((|tmp_when_14)) begin
        tmp_mac_psum_buffer_scale_1_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_1_1 = tmp_mac_psum_buffer_scale_1[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_1[15]) begin
      if((! (&tmp_when_15))) begin
        tmp_mac_psum_buffer_cut_1 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_cut_1 = mac_psum_buffer_scale_1[7 : 0];
      end
    end else begin
      if((|tmp_when_16)) begin
        tmp_mac_psum_buffer_cut_1 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_cut_1 = mac_psum_buffer_scale_1[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_2 = 16'h0000;
    if((need_scale && ((mac_once_finish || write_psum_pulse1) || write_psum_pulse2))) begin
      mac_psum_buffer_scale_2 = ($signed(tmp_mac_psum_buffer_scale_2_1) >>> rg_rnn_data_ratio);
    end
  end

  always @(*) begin
    mac_psum_buffer_cut_2 = 8'h00;
    if((need_scale && ((mac_once_finish || write_psum_pulse1) || write_psum_pulse2))) begin
      mac_psum_buffer_cut_2 = tmp_mac_psum_buffer_cut_2;
    end
  end

  always @(*) begin
    mac_psum_out_8b_2 = 8'h00;
    if(((mac_once_finish || write_psum_pulse1) || write_psum_pulse2)) begin
      if(need_relu) begin
        if(($signed(8'h00) < $signed(tmp_when_22))) begin
          mac_psum_out_8b_2 = mac_psum_buffer_cut_2;
        end else begin
          mac_psum_out_8b_2 = 8'h00;
        end
      end else begin
        mac_psum_out_8b_2 = mac_psum_buffer_cut_2;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_2 = mac_psum_buffer_2;
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_2[20]) begin
      if((! (&tmp_when_18))) begin
        tmp_mac_psum_buffer_scale_2_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_2_1 = tmp_mac_psum_buffer_scale_2[15 : 0];
      end
    end else begin
      if((|tmp_when_19)) begin
        tmp_mac_psum_buffer_scale_2_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_2_1 = tmp_mac_psum_buffer_scale_2[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_2[15]) begin
      if((! (&tmp_when_20))) begin
        tmp_mac_psum_buffer_cut_2 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_cut_2 = mac_psum_buffer_scale_2[7 : 0];
      end
    end else begin
      if((|tmp_when_21)) begin
        tmp_mac_psum_buffer_cut_2 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_cut_2 = mac_psum_buffer_scale_2[7 : 0];
      end
    end
  end

  always @(*) begin
    mac_psum_buffer_scale_3 = 16'h0000;
    if((need_scale && ((mac_once_finish || write_psum_pulse1) || write_psum_pulse2))) begin
      mac_psum_buffer_scale_3 = ($signed(tmp_mac_psum_buffer_scale_3_1) >>> rg_rnn_data_ratio);
    end
  end

  always @(*) begin
    mac_psum_buffer_cut_3 = 8'h00;
    if((need_scale && ((mac_once_finish || write_psum_pulse1) || write_psum_pulse2))) begin
      mac_psum_buffer_cut_3 = tmp_mac_psum_buffer_cut_3;
    end
  end

  always @(*) begin
    mac_psum_out_8b_3 = 8'h00;
    if(((mac_once_finish || write_psum_pulse1) || write_psum_pulse2)) begin
      if(need_relu) begin
        if(($signed(8'h00) < $signed(tmp_when_27))) begin
          mac_psum_out_8b_3 = mac_psum_buffer_cut_3;
        end else begin
          mac_psum_out_8b_3 = 8'h00;
        end
      end else begin
        mac_psum_out_8b_3 = mac_psum_buffer_cut_3;
      end
    end
  end

  assign tmp_mac_psum_buffer_scale_3 = mac_psum_buffer_3;
  always @(*) begin
    if(tmp_mac_psum_buffer_scale_3[20]) begin
      if((! (&tmp_when_23))) begin
        tmp_mac_psum_buffer_scale_3_1 = 16'h8000;
      end else begin
        tmp_mac_psum_buffer_scale_3_1 = tmp_mac_psum_buffer_scale_3[15 : 0];
      end
    end else begin
      if((|tmp_when_24)) begin
        tmp_mac_psum_buffer_scale_3_1 = 16'h7fff;
      end else begin
        tmp_mac_psum_buffer_scale_3_1 = tmp_mac_psum_buffer_scale_3[15 : 0];
      end
    end
  end

  always @(*) begin
    if(mac_psum_buffer_scale_3[15]) begin
      if((! (&tmp_when_25))) begin
        tmp_mac_psum_buffer_cut_3 = 8'h80;
      end else begin
        tmp_mac_psum_buffer_cut_3 = mac_psum_buffer_scale_3[7 : 0];
      end
    end else begin
      if((|tmp_when_26)) begin
        tmp_mac_psum_buffer_cut_3 = 8'h7f;
      end else begin
        tmp_mac_psum_buffer_cut_3 = mac_psum_buffer_scale_3[7 : 0];
      end
    end
  end

  assign mac_psum_gather_8b = {{{mac_psum_out_8b_3,mac_psum_out_8b_2},mac_psum_out_8b_1},mac_psum_out_8b_0};
  assign mac_psum_gather_16b_0 = {mac_psum_out_16b_0_1,mac_psum_out_16b_0_0};
  assign mac_psum_gather_16b_1 = {mac_psum_out_16b_1_1,mac_psum_out_16b_1_0};
  assign state_is_idle = (curr_state == MATMUL_STATE_IDLE);
  assign state_is_load_psum1 = (curr_state == MATMUL_STATE_LOAD_PSUM1);
  assign statein_load_psum1 = ((curr_state != MATMUL_STATE_LOAD_PSUM1) && (next_state == MATMUL_STATE_LOAD_PSUM1));
  assign state_is_load_psum2 = (curr_state == MATMUL_STATE_LOAD_PSUM2);
  assign statein_load_psum2 = ((curr_state != MATMUL_STATE_LOAD_PSUM2) && (next_state == MATMUL_STATE_LOAD_PSUM2));
  assign done = ((curr_state == MATMUL_STATE_MAC) && (next_state == MATMUL_STATE_IDLE));
  always @(*) begin
    coef_wdata = 32'h00000000;
    if(!(statein_load_psum1 && psum_come_from_coef)) begin
      if(!(statein_load_psum2 && psum_come_from_coef)) begin
        if(!incnt_inc_flag_true) begin
          if(read_mac_input_end) begin
            coef_wdata = 32'h00000000;
          end
        end
      end
    end
  end

  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      MATMUL_STATE_IDLE : begin
        if(start_once) begin
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
        if((write_psum_pulse2 && (! outLoopCnt_ov_flag))) begin
          next_state = MATMUL_STATE_LOAD_PSUM1;
        end else begin
          if((write_psum_pulse2 && outLoopCnt_ov_flag)) begin
            next_state = MATMUL_STATE_IDLE;
          end
        end
      end
    endcase
  end

  assign incnt_inc_flag_true = incnt_inc_flag_notrue;
  assign read_mac_input_end = ((! incnt_inc_flag_true) && incnt_inc_flag_true_regNext);
  assign fc_layer_write_psum_en_pulse1 = (need_scale && is_fc_layer);
  assign fc_layer_write_psum_en_pulse2 = ((need_scale && is_fc_layer) && (label_num[1] == 1'b1));
  always @(*) begin
    mac_weight_in_0 = 8'h00;
    if(mac_input_valid_flag) begin
      mac_weight_in_0 = coef_rdata[7 : 0];
    end
  end

  always @(*) begin
    mac_ifmap_in_0 = 8'h00;
    if(mac_input_valid_flag) begin
      mac_ifmap_in_0 = cache_rdata[7 : 0];
    end
  end

  always @(*) begin
    mac_weight_in_1 = 8'h00;
    if(mac_input_valid_flag) begin
      mac_weight_in_1 = coef_rdata[15 : 8];
    end
  end

  always @(*) begin
    mac_ifmap_in_1 = 8'h00;
    if(mac_input_valid_flag) begin
      mac_ifmap_in_1 = cache_rdata[15 : 8];
    end
  end

  always @(*) begin
    mac_weight_in_2 = 8'h00;
    if(mac_input_valid_flag) begin
      mac_weight_in_2 = coef_rdata[23 : 16];
    end
  end

  always @(*) begin
    mac_ifmap_in_2 = 8'h00;
    if(mac_input_valid_flag) begin
      mac_ifmap_in_2 = cache_rdata[23 : 16];
    end
  end

  always @(*) begin
    mac_weight_in_3 = 8'h00;
    if(mac_input_valid_flag) begin
      mac_weight_in_3 = coef_rdata[31 : 24];
    end
  end

  always @(*) begin
    mac_ifmap_in_3 = 8'h00;
    if(mac_input_valid_flag) begin
      mac_ifmap_in_3 = cache_rdata[31 : 24];
    end
  end

  assign switch_psum_index_ov = (switch_psum_index == 2'b11);
  assign tmp_1 = ({3'd0,1'b1} <<< switch_psum_index);
  assign mac_psum_in = tmp_psum_in;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      curr_state <= MATMUL_STATE_IDLE;
      inCnt <= 2'b00;
      outCnt <= 2'b00;
      outLoopCnt <= 3'b000;
      incnt_inc_flag_notrue <= 1'b0;
      read_mac_input_flag <= 1'b0;
      mac_input_valid_flag <= 1'b0;
      mac_input_valid_flag_regNext <= 1'b0;
      mac_once_finish <= 1'b0;
      write_psum_pulse1 <= 1'b0;
      write_psum_pulse2 <= 1'b0;
      mac_psum_buffer_0 <= 21'h000000;
      mac_psum_buffer_1 <= 21'h000000;
      mac_psum_buffer_2 <= 21'h000000;
      mac_psum_buffer_3 <= 21'h000000;
      psum1_read_out_flag <= 1'b0;
      psum2_read_out_flag <= 1'b0;
      coef_addr <= 7'h00;
      coef_wena <= 1'b0;
      coef_ena <= 1'b0;
      cache_addr <= 7'h00;
      cache_wena <= 1'b0;
      cache_ena <= 1'b0;
      cache_wdata <= 32'h00000000;
      weight_read_addr <= 7'h00;
      incnt_inc_flag_true_regNext <= 1'b0;
      tmp_switch_psum_pulse <= 1'b0;
      tmp_switch_psum_pulse_1 <= 1'b0;
      switch_psum_pulse <= 1'b0;
      switch_psum_index <= 2'b00;
    end else begin
      curr_state <= next_state;
      read_mac_input_flag <= incnt_inc_flag_true;
      mac_input_valid_flag <= read_mac_input_flag;
      mac_input_valid_flag_regNext <= mac_input_valid_flag;
      mac_once_finish <= mac_pipe_last2_valid_fall;
      write_psum_pulse1 <= mac_once_finish;
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
      if((outLoopCnt_ov_flag || done)) begin
        outLoopCnt <= 3'b000;
      end else begin
        if(write_psum_pulse1) begin
          outLoopCnt <= (outLoopCnt + 3'b001);
        end
      end
      incnt_inc_flag_true_regNext <= incnt_inc_flag_true;
      if(start_once) begin
        weight_read_addr <= weight_base_addr;
      end else begin
        if(incnt_inc_flag_true) begin
          weight_read_addr <= (weight_read_addr + 7'h01);
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
          coef_addr <= (tmp_coef_addr_2 + 7'h01);
        end else begin
          if(incnt_inc_flag_true) begin
            coef_ena <= 1'b1;
            coef_wena <= 1'b0;
            coef_addr <= weight_read_addr;
          end else begin
            if(read_mac_input_end) begin
              coef_ena <= 1'b0;
              coef_wena <= 1'b0;
              coef_addr <= 7'h00;
            end
          end
        end
      end
      if((statein_load_psum1 && (! psum_come_from_coef))) begin
        cache_ena <= 1'b1;
        cache_wena <= 1'b0;
        cache_addr <= (psum_base_addr + tmp_cache_addr);
      end else begin
        if((statein_load_psum2 && (! psum_come_from_coef))) begin
          cache_ena <= 1'b1;
          cache_wena <= 1'b0;
          cache_addr <= (tmp_cache_addr_2 + 7'h01);
        end else begin
          if(incnt_inc_flag_true) begin
            cache_ena <= 1'b1;
            cache_wena <= 1'b0;
            cache_addr <= (ifmap_base_addr + tmp_cache_addr_5);
          end else begin
            if((write_psum_pulse1 && (need_scale && (! is_fc_layer)))) begin
              cache_ena <= 1'b1;
              cache_wena <= 1'b1;
              cache_addr <= (ofmap_base_addr + tmp_cache_addr_6);
              cache_wdata <= mac_psum_gather_8b;
            end else begin
              if((mac_once_finish && ((! need_scale) || fc_layer_write_psum_en_pulse1))) begin
                cache_ena <= 1'b1;
                cache_wena <= 1'b1;
                cache_addr <= (tmp_cache_addr_7 + tmp_cache_addr_8);
                cache_wdata <= mac_psum_gather_16b_0;
              end else begin
                if((write_psum_pulse1 && ((! need_scale) || fc_layer_write_psum_en_pulse2))) begin
                  cache_ena <= 1'b1;
                  cache_wena <= 1'b1;
                  cache_addr <= (tmp_cache_addr_10 + 7'h01);
                  cache_wdata <= mac_psum_gather_16b_1;
                end else begin
                  if((write_psum_pulse2 || read_mac_input_end)) begin
                    cache_ena <= 1'b0;
                    cache_wena <= 1'b0;
                    cache_addr <= 7'h00;
                    cache_wdata <= 32'h00000000;
                  end
                end
              end
            end
          end
        end
      end
      tmp_switch_psum_pulse <= (inCnt_ov_flag && incnt_inc_flag_true);
      tmp_switch_psum_pulse_1 <= tmp_switch_psum_pulse;
      switch_psum_pulse <= tmp_switch_psum_pulse_1;
      if(switch_psum_pulse) begin
        if(switch_psum_index_ov) begin
          switch_psum_index <= 2'b00;
        end else begin
          switch_psum_index <= (switch_psum_index + 2'b01);
        end
      end
      if((psum2_read_out_flag && psum_come_from_coef)) begin
        mac_psum_buffer_2 <= tmp_mac_psum_buffer_2;
        mac_psum_buffer_3 <= tmp_mac_psum_buffer_3;
      end else begin
        if((psum1_read_out_flag && psum_come_from_coef)) begin
          mac_psum_buffer_0 <= tmp_mac_psum_buffer_0;
          mac_psum_buffer_1 <= tmp_mac_psum_buffer_1;
        end else begin
          if((psum2_read_out_flag && (! psum_come_from_coef))) begin
            mac_psum_buffer_2 <= tmp_mac_psum_buffer_2_3;
            mac_psum_buffer_3 <= tmp_mac_psum_buffer_3_3;
          end else begin
            if((psum1_read_out_flag && (! psum_come_from_coef))) begin
              mac_psum_buffer_0 <= tmp_mac_psum_buffer_0_3;
              mac_psum_buffer_1 <= tmp_mac_psum_buffer_1_3;
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

module lzc_1 (
  input  wire          mode,
  input  wire          lead,
  input  wire          trail,
  input  wire [15:0]   data_in,
  output wire [4:0]    cnt_out
);

  wire                tmp_datain_reverse;
  wire       [0:0]    tmp_datain_reverse_1;
  wire       [6:0]    tmp_datain_reverse_2;
  wire       [4:0]    tmp_cnt_out;
  reg        [15:0]   data_s;
  wire       [15:0]   datain_reverse;
  wire       [15:0]   stage_node_0;
  reg        [7:0]    stage_node_1;
  reg        [3:0]    stage_node_2;
  reg        [1:0]    stage_node_3;
  wire       [3:0]    stage_index1_0;
  wire       [3:0]    stage_index1_1;
  wire       [3:0]    stage_index1_2;
  wire       [3:0]    stage_index1_3;
  wire       [3:0]    stage_index1_4;
  wire       [3:0]    stage_index1_5;
  wire       [3:0]    stage_index1_6;
  wire       [3:0]    stage_index1_7;
  wire       [3:0]    stage_index2_0;
  wire       [3:0]    stage_index2_1;
  wire       [3:0]    stage_index2_2;
  wire       [3:0]    stage_index2_3;
  wire       [3:0]    stage_index3_0;
  wire       [3:0]    stage_index3_1;
  wire       [3:0]    stage_index4_0;
  wire                empty;
  reg        [3:0]    out_remap;

  assign tmp_cnt_out = {1'd0, out_remap};
  assign tmp_datain_reverse = data_in[7];
  assign tmp_datain_reverse_1 = data_in[8];
  assign tmp_datain_reverse_2 = {data_in[9],{data_in[10],{data_in[11],{data_in[12],{data_in[13],{data_in[14],data_in[15]}}}}}};
  assign datain_reverse = {data_in[0],{data_in[1],{data_in[2],{data_in[3],{data_in[4],{data_in[5],{data_in[6],{tmp_datain_reverse,{tmp_datain_reverse_1,tmp_datain_reverse_2}}}}}}}}};
  always @(*) begin
    data_s = 16'h0000;
    if(mode) begin
      if(lead) begin
        data_s = datain_reverse;
      end else begin
        if(trail) begin
          data_s = data_in;
        end
      end
    end else begin
      if(lead) begin
        data_s = (~ datain_reverse);
      end else begin
        if(trail) begin
          data_s = (~ data_in);
        end
      end
    end
  end

  assign stage_node_0 = data_s;
  always @(*) begin
    stage_node_1[0] = (stage_node_0[0] || stage_node_0[1]);
    stage_node_1[1] = (stage_node_0[2] || stage_node_0[3]);
    stage_node_1[2] = (stage_node_0[4] || stage_node_0[5]);
    stage_node_1[3] = (stage_node_0[6] || stage_node_0[7]);
    stage_node_1[4] = (stage_node_0[8] || stage_node_0[9]);
    stage_node_1[5] = (stage_node_0[10] || stage_node_0[11]);
    stage_node_1[6] = (stage_node_0[12] || stage_node_0[13]);
    stage_node_1[7] = (stage_node_0[14] || stage_node_0[15]);
  end

  assign stage_index1_0 = (stage_node_0[0] ? 4'b0000 : 4'b0001);
  assign stage_index1_1 = (stage_node_0[2] ? 4'b0010 : 4'b0011);
  assign stage_index1_2 = (stage_node_0[4] ? 4'b0100 : 4'b0101);
  assign stage_index1_3 = (stage_node_0[6] ? 4'b0110 : 4'b0111);
  assign stage_index1_4 = (stage_node_0[8] ? 4'b1000 : 4'b1001);
  assign stage_index1_5 = (stage_node_0[10] ? 4'b1010 : 4'b1011);
  assign stage_index1_6 = (stage_node_0[12] ? 4'b1100 : 4'b1101);
  assign stage_index1_7 = (stage_node_0[14] ? 4'b1110 : 4'b1111);
  always @(*) begin
    stage_node_2[0] = (stage_node_1[0] || stage_node_1[1]);
    stage_node_2[1] = (stage_node_1[2] || stage_node_1[3]);
    stage_node_2[2] = (stage_node_1[4] || stage_node_1[5]);
    stage_node_2[3] = (stage_node_1[6] || stage_node_1[7]);
  end

  assign stage_index2_0 = (stage_node_1[0] ? stage_index1_0 : stage_index1_1);
  assign stage_index2_1 = (stage_node_1[2] ? stage_index1_2 : stage_index1_3);
  assign stage_index2_2 = (stage_node_1[4] ? stage_index1_4 : stage_index1_5);
  assign stage_index2_3 = (stage_node_1[6] ? stage_index1_6 : stage_index1_7);
  always @(*) begin
    stage_node_3[0] = (stage_node_2[0] || stage_node_2[1]);
    stage_node_3[1] = (stage_node_2[2] || stage_node_2[3]);
  end

  assign stage_index3_0 = (stage_node_2[0] ? stage_index2_0 : stage_index2_1);
  assign stage_index3_1 = (stage_node_2[2] ? stage_index2_2 : stage_index2_3);
  assign stage_index4_0 = (stage_node_3[0] ? stage_index3_0 : stage_index3_1);
  assign empty = ((lead || trail) ? (! (|data_s)) : 1'b0);
  always @(*) begin
    out_remap = 4'b0000;
    if(lead) begin
      out_remap = (4'b1111 - stage_index4_0);
    end else begin
      if(trail) begin
        out_remap = stage_index4_0;
      end
    end
  end

  assign cnt_out = ((lead && empty) ? 5'h10 : tmp_cnt_out);

endmodule

module Sqrt_unsigned (
  input  wire          din_vld,
  input  wire [31:0]   din,
  output wire          dout_vld,
  output reg  [15:0]   dout,
  input  wire          clkout,
  input  wire          rstn_80m
);

  wire       [15:0]   tmp_temp_rem;
  wire       [15:0]   tmp_temp_rem_1;
  wire       [31:0]   tmp_temp_rem_2;
  wire       [15:0]   tmp_if1;
  wire       [15:0]   tmp_root;
  reg        [15:0]   root;
  reg        [15:0]   rem_1;
  reg        [3:0]    cnt;
  wire                cnt_ov;
  reg                 work;
  reg        [31:0]   datain;
  reg                 work_regNext;
  wire                work_neg;
  wire       [15:0]   if1;
  wire       [15:0]   temp_rem;
  reg                 work_neg_regNext;

  assign tmp_temp_rem = (rem_1 <<< 2);
  assign tmp_temp_rem_2 = (datain >>> 30);
  assign tmp_temp_rem_1 = tmp_temp_rem_2[15:0];
  assign tmp_if1 = (root <<< 2);
  assign tmp_root = (root <<< 1);
  assign cnt_ov = (cnt == 4'b1111);
  assign work_neg = ((! work) && work_regNext);
  assign temp_rem = (tmp_temp_rem | tmp_temp_rem_1);
  assign if1 = (tmp_if1 + 16'h0001);
  assign dout_vld = work_neg_regNext;
  always @(posedge clkout or negedge rstn_80m) begin
    if(!rstn_80m) begin
      root <= 16'h0000;
      rem_1 <= 16'h0000;
      cnt <= 4'b0000;
      work <= 1'b0;
      datain <= 32'h00000000;
      work_regNext <= 1'b0;
      work_neg_regNext <= 1'b0;
      dout <= 16'h0000;
    end else begin
      if(din_vld) begin
        datain <= din;
      end
      if(din_vld) begin
        work <= 1'b1;
      end else begin
        if(cnt_ov) begin
          work <= 1'b0;
        end
      end
      if(work) begin
        if(cnt_ov) begin
          cnt <= 4'b0000;
        end else begin
          cnt <= (cnt + 4'b0001);
        end
      end
      work_regNext <= work;
      if(work) begin
        datain <= (datain <<< 2);
        if((if1 <= temp_rem)) begin
          root <= (tmp_root | 16'h0001);
          rem_1 <= (temp_rem - if1);
        end else begin
          root <= (root <<< 1);
          rem_1 <= temp_rem;
        end
      end else begin
        if(work_neg) begin
          root <= 16'h0000;
          rem_1 <= 16'h0000;
        end
      end
      work_neg_regNext <= work_neg;
      if(work_neg) begin
        dout <= root;
      end
    end
  end


endmodule

module SignMultiplier (
  input  wire [12:0]   dinA,
  input  wire [12:0]   dinB,
  input  wire          din_vld,
  output wire [25:0]   dout,
  output wire          dout_vld,
  input  wire          clkout,
  input  wire          rstn_80m
);

  reg        [25:0]   Result;
  wire                din_vld_1;
  reg                 dout_vld_reg;
  reg        [12:0]   dinA_reg;
  reg        [12:0]   dinB_reg;
  reg                 din_vld_regNext;

  assign din_vld_1 = din_vld_regNext;
  always @(*) begin
    Result = 26'h0000000;
    if(din_vld_1) begin
      Result = ($signed(dinA_reg) * $signed(dinB_reg));
    end
  end

  always @(*) begin
    dout_vld_reg = 1'b0;
    if(din_vld_1) begin
      dout_vld_reg = 1'b1;
    end else begin
      dout_vld_reg = 1'b0;
    end
  end

  assign dout = Result;
  assign dout_vld = dout_vld_reg;
  always @(posedge clkout or negedge rstn_80m) begin
    if(!rstn_80m) begin
      dinA_reg <= 13'h0000;
      dinB_reg <= 13'h0000;
      din_vld_regNext <= 1'b0;
    end else begin
      if(din_vld) begin
        dinA_reg <= dinA;
        dinB_reg <= dinB;
      end
      din_vld_regNext <= din_vld;
    end
  end


endmodule

module mac_unit (
  input  wire          clka,
  input  wire          rstn_a,
  input  wire          valid,
  input  wire [7:0]    A_0,
  input  wire [7:0]    A_1,
  input  wire [7:0]    A_2,
  input  wire [7:0]    A_3,
  input  wire [7:0]    B_0,
  input  wire [7:0]    B_1,
  input  wire [7:0]    B_2,
  input  wire [7:0]    B_3,
  input  wire [20:0]   psum_in,
  output wire [20:0]   psum_out,
  output wire          psum_acc_valid,
  input  wire          clk,
  input  wire          resetn
);

  wire       [7:0]    tmp_product_0;
  wire       [7:0]    tmp_product_0_1;
  wire       [7:0]    tmp_product_1;
  wire       [7:0]    tmp_product_1_1;
  wire       [7:0]    tmp_product_2;
  wire       [7:0]    tmp_product_2_1;
  wire       [7:0]    tmp_product_3;
  wire       [7:0]    tmp_product_3_1;
  wire       [16:0]   tmp_tmp_sum;
  wire       [16:0]   tmp_tmp_sum_1;
  wire       [16:0]   tmp_tmp_sum_1_1;
  wire       [16:0]   tmp_tmp_sum_1_2;
  wire       [17:0]   tmp_sum_2;
  wire       [17:0]   tmp_sum_3;
  wire       [17:0]   tmp_sum_4;
  wire       [20:0]   tmp_psum_out;
  wire       [20:0]   tmp_psum_out_1;
  reg        [15:0]   product_0;
  reg        [15:0]   product_1;
  reg        [15:0]   product_2;
  reg        [15:0]   product_3;
  reg        [20:0]   sum;
  wire       [16:0]   tmp_sum;
  wire       [16:0]   tmp_sum_1;
  reg                 stage1_valid;

  assign tmp_product_0 = A_0;
  assign tmp_product_0_1 = B_0;
  assign tmp_product_1 = A_1;
  assign tmp_product_1_1 = B_1;
  assign tmp_product_2 = A_2;
  assign tmp_product_2_1 = B_2;
  assign tmp_product_3 = A_3;
  assign tmp_product_3_1 = B_3;
  assign tmp_tmp_sum = {product_0[15],product_0};
  assign tmp_tmp_sum_1 = {product_1[15],product_1};
  assign tmp_tmp_sum_1_1 = {product_2[15],product_2};
  assign tmp_tmp_sum_1_2 = {product_3[15],product_3};
  assign tmp_sum_2 = ($signed(tmp_sum_3) + $signed(tmp_sum_4));
  assign tmp_sum_3 = {tmp_sum[16],tmp_sum};
  assign tmp_sum_4 = {tmp_sum_1[16],tmp_sum_1};
  assign tmp_psum_out = ($signed(sum) + $signed(tmp_psum_out_1));
  assign tmp_psum_out_1 = psum_in;
  always @(*) begin
    product_0 = 16'h0000;
    if(valid) begin
      product_0 = ($signed(tmp_product_0) * $signed(tmp_product_0_1));
    end
  end

  always @(*) begin
    product_1 = 16'h0000;
    if(valid) begin
      product_1 = ($signed(tmp_product_1) * $signed(tmp_product_1_1));
    end
  end

  always @(*) begin
    product_2 = 16'h0000;
    if(valid) begin
      product_2 = ($signed(tmp_product_2) * $signed(tmp_product_2_1));
    end
  end

  always @(*) begin
    product_3 = 16'h0000;
    if(valid) begin
      product_3 = ($signed(tmp_product_3) * $signed(tmp_product_3_1));
    end
  end

  assign tmp_sum = ($signed(tmp_tmp_sum) + $signed(tmp_tmp_sum_1));
  assign tmp_sum_1 = ($signed(tmp_tmp_sum_1_1) + $signed(tmp_tmp_sum_1_2));
  assign psum_out = tmp_psum_out;
  assign psum_acc_valid = stage1_valid;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      sum <= 21'h000000;
      stage1_valid <= 1'b0;
    end else begin
      if(valid) begin
        sum <= {{3{tmp_sum_2[17]}}, tmp_sum_2};
      end
      stage1_valid <= valid;
    end
  end


endmodule

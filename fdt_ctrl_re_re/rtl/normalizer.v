// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : normalizer

`timescale 1ns/1ps 
module normalizer (
  input  wire [2:0]    data_ratio,
  input  wire [2:0]    rg_norm_mean_pad_smp_num_log2,
  input  wire [6:0]    rg_norm_mean_base_addr,
  input  wire [2:0]    rg_norm_mean_num_log2,
  input  wire [10:0]   rg_norm_cali_base_0,
  input  wire [10:0]   rg_norm_cali_base_1,
  input  wire [10:0]   rg_norm_cali_base_2,
  input  wire [10:0]   rg_norm_cali_touch_0,
  input  wire [10:0]   rg_norm_cali_touch_1,
  input  wire [10:0]   rg_norm_cali_touch_2,
  input  wire [6:0]    rg_norm_base_addr_0,
  input  wire [6:0]    rg_norm_base_addr_1,
  input  wire [6:0]    rg_norm_base_addr_2,
  input  wire [10:0]   amp_mean_0,
  input  wire [10:0]   amp_mean_1,
  input  wire [10:0]   amp_mean_2,
  input  wire          amp_mean_vld_0,
  input  wire          amp_mean_vld_1,
  input  wire          amp_mean_vld_2,
  output wire          samp_done,
  output wire          norm_done,
  output wire          norm_done_20M,
  output reg           cache_ena,
  output reg           cache_wena,
  output reg  [6:0]    cache_addr,
  output reg  [63:0]   cache_wdata,
  input  wire [63:0]   cache_rdata,
  input  wire          clkout,
  input  wire          rstn_80m
);
  localparam NORMSTATE_IDLE = 2'd0;
  localparam NORMSTATE_STORE_MEAN = 2'd1;
  localparam NORMSTATE_SEARCH_PTP = 2'd2;
  localparam NORMSTATE_CAL_NORM = 2'd3;

  wire       [15:0]   lzc_unit_data_in;
  wire       [4:0]    lzc_unit_cnt_out;
  wire       [5:0]    tmp_mean_num;
  wire       [5:0]    tmp_pad_aready_smp_num;
  reg        [10:0]   tmp_search_pad_data;
  reg        [15:0]   tmp_data_in;
  wire       [3:0]    tmp_most_signifi_num;
  wire       [2:0]    tmp_most_signifi_num_1;
  reg        [15:0]   tmp_norm_read_mean_mem;
  reg        [10:0]   tmp_tmp_pre_cali_ptp;
  reg        [10:0]   tmp_pre_cali_ptp_1;
  reg        [15:0]   tmp_tmp_pre_cali_diff;
  wire       [15:0]   tmp_pre_cali_diff_1;
  wire       [15:0]   tmp_pre_cali_diff_2;
  wire       [15:0]   tmp_pre_cali_diff_3;
  wire       [10:0]   tmp_pre_cali_diff_4;
  wire       [15:0]   tmp_pre_cali_diff_5;
  wire       [15:0]   tmp_pre_cali_diff_6;
  wire       [15:0]   tmp_pre_cali_diff_7;
  wire       [1:0]    tmp_search_area_inc;
  reg        [15:0]   tmp_tmp_mean_cache_read_slice;
  reg        [15:0]   tmp_tmp_mean_cache_read_slice_1;
  reg        [15:0]   tmp_tmp_mean_cache_read_slice_2;
  reg        [15:0]   tmp_tmp_mean_cache_read_slice_3;
  reg        [15:0]   tmp_tmp_mean_cache_read_slice_4;
  reg        [15:0]   tmp_mean_cache_read_slice_1;
  wire       [15:0]   tmp_cal_norm_ptp_0;
  wire       [15:0]   tmp_cal_norm_ptp_0_1;
  wire       [15:0]   tmp_cal_norm_ptp_1;
  wire       [15:0]   tmp_cal_norm_ptp_1_1;
  wire       [15:0]   tmp_cal_norm_ptp_2;
  wire       [15:0]   tmp_cal_norm_ptp_2_1;
  reg        [15:0]   tmp_when;
  wire       [22:0]   tmp_tmp_cal_norm_Value_0;
  wire       [15:0]   tmp_when_1;
  wire       [14:0]   tmp_when_2;
  reg        [7:0]    tmp_tmp_norm_gather_buffer_0;
  wire       [3:0]    tmp_search_cache_addr_bias_0;
  wire       [4:0]    tmp_when_3;
  wire       [4:0]    tmp_when_4;
  wire       [3:0]    tmp_search_cache_addr_bias_0_1;
  wire       [3:0]    tmp_search_cache_addr_bias_0_2;
  wire       [3:0]    tmp_search_cache_addr_bias_0_3;
  wire       [3:0]    tmp_search_cache_addr_bias_0_4;
  wire       [3:0]    tmp_search_cache_addr_bias_0_5;
  wire       [3:0]    tmp_search_cache_addr_bias_0_6;
  wire       [6:0]    tmp_norm_gather_word_write_base_0;
  wire       [4:0]    tmp_search_cache_addr_bias_1;
  wire       [4:0]    tmp_search_cache_addr_bias_1_1;
  wire       [4:0]    tmp_when_5;
  wire       [4:0]    tmp_when_6;
  wire       [4:0]    tmp_search_cache_addr_bias_1_2;
  wire       [4:0]    tmp_search_cache_addr_bias_1_3;
  wire       [4:0]    tmp_search_cache_addr_bias_1_4;
  wire       [4:0]    tmp_search_cache_addr_bias_1_5;
  wire       [4:0]    tmp_search_cache_addr_bias_1_6;
  wire       [4:0]    tmp_search_cache_addr_bias_1_7;
  wire       [4:0]    tmp_search_cache_addr_bias_1_8;
  wire       [4:0]    tmp_search_cache_addr_bias_1_9;
  wire       [4:0]    tmp_search_cache_addr_bias_1_10;
  wire       [4:0]    tmp_search_cache_addr_bias_1_11;
  wire       [4:0]    tmp_search_cache_addr_bias_1_12;
  wire       [6:0]    tmp_norm_gather_word_write_base_1;
  wire       [5:0]    tmp_search_cache_addr_bias_2;
  wire       [5:0]    tmp_search_cache_addr_bias_2_1;
  wire       [4:0]    tmp_when_7;
  wire       [4:0]    tmp_when_8;
  wire       [5:0]    tmp_search_cache_addr_bias_2_2;
  wire       [5:0]    tmp_search_cache_addr_bias_2_3;
  wire       [5:0]    tmp_search_cache_addr_bias_2_4;
  wire       [5:0]    tmp_search_cache_addr_bias_2_5;
  wire       [5:0]    tmp_search_cache_addr_bias_2_6;
  wire       [5:0]    tmp_search_cache_addr_bias_2_7;
  wire       [5:0]    tmp_search_cache_addr_bias_2_8;
  wire       [5:0]    tmp_search_cache_addr_bias_2_9;
  wire       [5:0]    tmp_search_cache_addr_bias_2_10;
  wire       [5:0]    tmp_search_cache_addr_bias_2_11;
  wire       [5:0]    tmp_search_cache_addr_bias_2_12;
  wire       [6:0]    tmp_norm_gather_word_write_base_2;
  wire       [6:0]    tmp_cache_addr;
  wire       [6:0]    tmp_cache_addr_1;
  wire       [6:0]    tmp_cache_addr_2;
  wire       [6:0]    tmp_cache_addr_3;
  wire       [6:0]    tmp_cache_addr_4;
  reg        [1:0]    curr_state;
  reg        [1:0]    next_state;
  reg                 norm_is_not_first_seq;
  wire                norm_is_first_seq;
  wire                state_is_storemean;
  wire                state_in_searchptp;
  wire                state_is_searchptp;
  wire                state_in_calnorm;
  wire                state_is_calnorm;
  wire       [5:0]    mean_num;
  wire       [3:0]    mean_cahe_word_num;
  wire       [2:0]    norm_cahe_word_num;
  wire       [5:0]    pad_aready_smp_num;
  wire       [3:0]    pad_start_cahe_word_num;
  reg        [15:0]   mean_gather_buffer_0_0;
  reg        [15:0]   mean_gather_buffer_0_1;
  reg        [15:0]   mean_gather_buffer_0_2;
  reg        [15:0]   mean_gather_buffer_0_3;
  reg        [15:0]   mean_gather_buffer_1_0;
  reg        [15:0]   mean_gather_buffer_1_1;
  reg        [15:0]   mean_gather_buffer_1_2;
  reg        [15:0]   mean_gather_buffer_1_3;
  reg        [15:0]   mean_gather_buffer_2_0;
  reg        [15:0]   mean_gather_buffer_2_1;
  reg        [15:0]   mean_gather_buffer_2_2;
  reg        [15:0]   mean_gather_buffer_2_3;
  wire       [63:0]   mean_gather_word_0;
  wire       [63:0]   mean_gather_word_1;
  wire       [63:0]   mean_gather_word_2;
  reg        [1:0]    mean_gather_buffer_ptr;
  wire                mean_gather_buffer_ptr_ov;
  reg                 mean_gather_done_0;
  reg                 mean_gather_done_1;
  reg                 mean_gather_done_2;
  wire                mean_cache_write_0;
  wire                mean_cache_write_1;
  wire                mean_cache_write_2;
  reg                 amp_mean_vld_2_dly;
  reg        [3:0]    cache_ptr;
  wire                cache_ptr_ov;
  wire                frist_64_smp_done;
  reg                 frist_64_smp_done_latch;
  wire                pad_smp_en;
  wire                pad_mean_store_done;
  reg                 pad_is_not_frist_seq;
  wire                pad_is_frist_seq;
  wire                pad_seq_start;
  wire                mean_store_done;
  reg                 state_is_searchptp_delay_1;
  reg                 state_is_searchptp_delay_2;
  wire                search_ptp_inc;
  reg        [1:0]    search_cache_slice_ptr;
  wire                search_cache_slice_ptr_ov;
  wire       [15:0]   search_cache_slice_0;
  wire       [15:0]   search_cache_slice_1;
  wire       [15:0]   search_cache_slice_2;
  wire       [15:0]   search_cache_slice_3;
  wire                search_cache_read_0;
  wire                search_cache_read_1;
  wire                search_cache_read_2;
  reg                 search_cache_1st_read;
  reg                 search_cache_oth_read;
  reg        [3:0]    search_cache_ptr;
  wire                search_cache_ptr_ov;
  reg        [3:0]    pad_word_ref_ptr;
  wire                pad_word_ref_ptr_ov;
  reg                 search_area_inc;
  reg        [1:0]    search_area_num;
  reg        [1:0]    search_area_num_pre;
  reg        [1:0]    search_area_num_dly;
  wire                search_area_num_ov;
  wire                need_search_from_buffer;
  reg                 search_ptp_done;
  reg        [15:0]   search_min_buf_0;
  reg        [15:0]   search_min_buf_1;
  reg        [15:0]   search_min_buf_2;
  reg        [15:0]   search_max_buf_0;
  reg        [15:0]   search_max_buf_1;
  reg        [15:0]   search_max_buf_2;
  reg        [6:0]    search_cache_addr_bias_0;
  reg        [6:0]    search_cache_addr_bias_1;
  reg        [6:0]    search_cache_addr_bias_2;
  reg                 pad_search_from_buffer;
  reg                 search_pad_data_vld;
  wire       [10:0]   search_pad_data;
  reg                 state_is_calnorm_delay_1;
  reg                 state_is_calnorm_delay_2;
  wire                cal_norm_inc;
  reg                 tmp_search_inc_dly;
  wire                search_inc_dly;
  wire                cal_norm_done;
  wire                cal_norm_cache_read_0;
  wire                cal_norm_cache_read_1;
  wire                cal_norm_cache_read_2;
  reg                 cal_norm_cache_1st_read;
  reg                 cal_norm_cache_oth_read;
  reg        [7:0]    cal_norm_Value_0;
  reg        [7:0]    cal_norm_Value_1;
  reg        [7:0]    cal_norm_Value_2;
  wire       [15:0]   cal_norm_ptp_0;
  wire       [15:0]   cal_norm_ptp_1;
  wire       [15:0]   cal_norm_ptp_2;
  wire       [3:0]    most_signifi_num;
  reg        [15:0]   mean_cache_read_slice;
  reg                 mean_cache_read_slice_from_buffer;
  wire                norm_read_mean_real;
  wire                norm_write_mean_real;
  reg                 norm_read_mean_from_buffer;
  reg                 norm_read_mean_mem_buffer_refresh;
  reg        [63:0]   norm_read_mean_mem_buffer;
  wire       [15:0]   norm_read_mean_mem_buffer_slice_0;
  wire       [15:0]   norm_read_mean_mem_buffer_slice_1;
  wire       [15:0]   norm_read_mean_mem_buffer_slice_2;
  wire       [15:0]   norm_read_mean_mem_buffer_slice_3;
  wire       [15:0]   norm_read_mean_mem;
  reg        [7:0]    norm_gather_buffer_0;
  reg        [7:0]    norm_gather_buffer_1;
  reg        [7:0]    norm_gather_buffer_2;
  reg        [7:0]    norm_gather_buffer_3;
  reg        [7:0]    norm_gather_buffer_4;
  reg        [7:0]    norm_gather_buffer_5;
  reg        [7:0]    norm_gather_buffer_6;
  reg        [7:0]    norm_gather_buffer_7;
  reg        [2:0]    norm_gather_buffer_ptr;
  wire                norm_gather_buffer_ptr_ov;
  reg                 norm_gather_buffer_ptr_ov_delay_1;
  wire                norm_gather_done;
  wire       [63:0]   norm_gather_word;
  wire                norm_gather_word_write_0;
  wire                norm_gather_word_write_1;
  wire                norm_gather_word_write_2;
  wire       [6:0]    norm_gather_word_write_base_0;
  wire       [6:0]    norm_gather_word_write_base_1;
  wire       [6:0]    norm_gather_word_write_base_2;
  reg        [2:0]    norm_gather_cache_ptr;
  wire                norm_gather_cache_ptr_ov;
  wire                norm_gather_write_read_conflict;
  reg                 norm_gather_write_conflict_vld_buf;
  reg        [6:0]    norm_gather_write_conflict_addr_buf;
  reg        [63:0]   norm_gather_write_conflict_data_buf;
  wire       [10:0]   tmp_pre_cali_ptp;
  wire       [10:0]   pre_cali_ptp;
  wire                pre_cali_ptp_en;
  wire       [15:0]   tmp_pre_cali_diff;
  wire       [3:0]    tmp_1;
  wire       [15:0]   pre_cali_diff;
  wire                cal_norm_done_his_0;
  reg                 cal_norm_done_his_1;
  reg                 cal_norm_done_his_2;
  reg                 cal_norm_done_his_3;
  wire                tmp_samp_done;
  reg                 tmp_samp_done_1;
  reg                 tmp_samp_done_2;
  reg                 tmp_samp_done_3;
  reg                 cal_norm_cache_1st_read_delay_1;
  reg                 search_cache_1st_read_delay_1;
  wire       [15:0]   tmp_mean_cache_read_slice;
  wire       [3:0]    tmp_2;
  wire       [10:0]   tmp_mean_gather_buffer_0_0;
  wire       [3:0]    tmp_3;
  wire       [10:0]   tmp_mean_gather_buffer_1_0;
  wire       [3:0]    tmp_4;
  wire       [10:0]   tmp_mean_gather_buffer_2_0;
  wire       [3:0]    tmp_5;
  wire       [3:0]    tmp_6;
  wire       [22:0]   tmp_cal_norm_Value_0;
  reg        [7:0]    tmp_cal_norm_Value_0_1;
  wire       [7:0]    tmp_cal_norm_Value_0_2;
  wire       [7:0]    tmp_7;
  wire       [7:0]    tmp_norm_gather_buffer_0;
  `ifndef SYNTHESIS
  reg [79:0] curr_state_string;
  reg [79:0] next_state_string;
  `endif


  assign tmp_mean_num = (6'h01 <<< rg_norm_mean_num_log2);
  assign tmp_pad_aready_smp_num = (6'h01 <<< rg_norm_mean_pad_smp_num_log2);
  assign tmp_most_signifi_num_1 = 3'b000;
  assign tmp_most_signifi_num = {1'd0, tmp_most_signifi_num_1};
  assign tmp_pre_cali_diff_1 = ($signed(tmp_pre_cali_diff_2) - $signed(tmp_pre_cali_diff_3));
  assign tmp_pre_cali_diff_2 = mean_cache_read_slice;
  assign tmp_pre_cali_diff_4 = tmp_pre_cali_ptp;
  assign tmp_pre_cali_diff_3 = {{5{tmp_pre_cali_diff_4[10]}}, tmp_pre_cali_diff_4};
  assign tmp_pre_cali_diff_5 = ($signed(tmp_pre_cali_diff_6) - $signed(tmp_pre_cali_diff_7));
  assign tmp_pre_cali_diff_6 = mean_cache_read_slice;
  assign tmp_pre_cali_diff_7 = tmp_pre_cali_diff;
  assign tmp_search_area_inc = (mean_gather_buffer_ptr - 2'b01);
  assign tmp_cal_norm_ptp_0 = {5'd0, pre_cali_ptp};
  assign tmp_cal_norm_ptp_0_1 = (search_max_buf_0 - search_min_buf_0);
  assign tmp_cal_norm_ptp_1 = {5'd0, pre_cali_ptp};
  assign tmp_cal_norm_ptp_1_1 = (search_max_buf_1 - search_min_buf_1);
  assign tmp_cal_norm_ptp_2 = {5'd0, pre_cali_ptp};
  assign tmp_cal_norm_ptp_2_1 = (search_max_buf_2 - search_min_buf_2);
  assign tmp_tmp_cal_norm_Value_0 = ({{7{pre_cali_diff[15]}},pre_cali_diff} <<< data_ratio);
  assign tmp_when_1 = tmp_cal_norm_Value_0[22 : 7];
  assign tmp_when_2 = tmp_cal_norm_Value_0[21 : 7];
  assign tmp_search_cache_addr_bias_0 = (search_cache_ptr + 4'b0000);
  assign tmp_when_3 = {1'd0, mean_cahe_word_num};
  assign tmp_when_4 = ({1'b0,search_cache_ptr} + {1'b0,cache_ptr});
  assign tmp_search_cache_addr_bias_0_1 = (tmp_search_cache_addr_bias_0_2 - 4'b0001);
  assign tmp_search_cache_addr_bias_0_2 = (tmp_search_cache_addr_bias_0_3 - mean_cahe_word_num);
  assign tmp_search_cache_addr_bias_0_3 = (tmp_search_cache_addr_bias_0_4 + cache_ptr);
  assign tmp_search_cache_addr_bias_0_4 = (4'b0000 + search_cache_ptr);
  assign tmp_search_cache_addr_bias_0_5 = (tmp_search_cache_addr_bias_0_6 + cache_ptr);
  assign tmp_search_cache_addr_bias_0_6 = (search_cache_ptr + 4'b0000);
  assign tmp_norm_gather_word_write_base_0 = {4'd0, norm_gather_cache_ptr};
  assign tmp_search_cache_addr_bias_1 = (tmp_search_cache_addr_bias_1_1 + 5'h10);
  assign tmp_search_cache_addr_bias_1_1 = {1'd0, search_cache_ptr};
  assign tmp_when_5 = {1'd0, mean_cahe_word_num};
  assign tmp_when_6 = ({1'b0,search_cache_ptr} + {1'b0,cache_ptr});
  assign tmp_search_cache_addr_bias_1_2 = (tmp_search_cache_addr_bias_1_3 - 5'h01);
  assign tmp_search_cache_addr_bias_1_3 = (tmp_search_cache_addr_bias_1_4 - tmp_search_cache_addr_bias_1_8);
  assign tmp_search_cache_addr_bias_1_4 = (tmp_search_cache_addr_bias_1_5 + tmp_search_cache_addr_bias_1_7);
  assign tmp_search_cache_addr_bias_1_5 = (5'h10 + tmp_search_cache_addr_bias_1_6);
  assign tmp_search_cache_addr_bias_1_6 = {1'd0, search_cache_ptr};
  assign tmp_search_cache_addr_bias_1_7 = {1'd0, cache_ptr};
  assign tmp_search_cache_addr_bias_1_8 = {1'd0, mean_cahe_word_num};
  assign tmp_search_cache_addr_bias_1_9 = (tmp_search_cache_addr_bias_1_10 + tmp_search_cache_addr_bias_1_12);
  assign tmp_search_cache_addr_bias_1_10 = (tmp_search_cache_addr_bias_1_11 + 5'h10);
  assign tmp_search_cache_addr_bias_1_11 = {1'd0, search_cache_ptr};
  assign tmp_search_cache_addr_bias_1_12 = {1'd0, cache_ptr};
  assign tmp_norm_gather_word_write_base_1 = {4'd0, norm_gather_cache_ptr};
  assign tmp_search_cache_addr_bias_2 = (tmp_search_cache_addr_bias_2_1 + 6'h20);
  assign tmp_search_cache_addr_bias_2_1 = {2'd0, search_cache_ptr};
  assign tmp_when_7 = {1'd0, mean_cahe_word_num};
  assign tmp_when_8 = ({1'b0,search_cache_ptr} + {1'b0,cache_ptr});
  assign tmp_search_cache_addr_bias_2_2 = (tmp_search_cache_addr_bias_2_3 - 6'h01);
  assign tmp_search_cache_addr_bias_2_3 = (tmp_search_cache_addr_bias_2_4 - tmp_search_cache_addr_bias_2_8);
  assign tmp_search_cache_addr_bias_2_4 = (tmp_search_cache_addr_bias_2_5 + tmp_search_cache_addr_bias_2_7);
  assign tmp_search_cache_addr_bias_2_5 = (6'h20 + tmp_search_cache_addr_bias_2_6);
  assign tmp_search_cache_addr_bias_2_6 = {2'd0, search_cache_ptr};
  assign tmp_search_cache_addr_bias_2_7 = {2'd0, cache_ptr};
  assign tmp_search_cache_addr_bias_2_8 = {2'd0, mean_cahe_word_num};
  assign tmp_search_cache_addr_bias_2_9 = (tmp_search_cache_addr_bias_2_10 + tmp_search_cache_addr_bias_2_12);
  assign tmp_search_cache_addr_bias_2_10 = (tmp_search_cache_addr_bias_2_11 + 6'h20);
  assign tmp_search_cache_addr_bias_2_11 = {2'd0, search_cache_ptr};
  assign tmp_search_cache_addr_bias_2_12 = {2'd0, cache_ptr};
  assign tmp_norm_gather_word_write_base_2 = {4'd0, norm_gather_cache_ptr};
  assign tmp_cache_addr = {3'd0, cache_ptr};
  assign tmp_cache_addr_1 = (rg_norm_mean_base_addr + 7'h10);
  assign tmp_cache_addr_2 = {3'd0, cache_ptr};
  assign tmp_cache_addr_3 = (rg_norm_mean_base_addr + 7'h20);
  assign tmp_cache_addr_4 = {3'd0, cache_ptr};
  lzc lzc_unit (
    .mode    (1'b1                  ), //i
    .lead    (1'b1                  ), //i
    .trail   (1'b0                  ), //i
    .data_in (lzc_unit_data_in[15:0]), //i
    .cnt_out (lzc_unit_cnt_out[4:0] )  //o
  );
  always @(*) begin
    case(search_area_num)
      2'b00 : begin
        tmp_search_pad_data = amp_mean_0;
        tmp_data_in = cal_norm_ptp_0;
        tmp_tmp_pre_cali_ptp = rg_norm_cali_touch_0;
        tmp_pre_cali_ptp_1 = rg_norm_cali_base_0;
        tmp_tmp_pre_cali_diff = search_min_buf_0;
        tmp_tmp_mean_cache_read_slice_1 = mean_gather_buffer_0_0;
        tmp_tmp_mean_cache_read_slice_2 = mean_gather_buffer_0_1;
        tmp_tmp_mean_cache_read_slice_3 = mean_gather_buffer_0_2;
        tmp_tmp_mean_cache_read_slice_4 = mean_gather_buffer_0_3;
        tmp_when = search_max_buf_0;
        tmp_tmp_norm_gather_buffer_0 = cal_norm_Value_0;
      end
      2'b01 : begin
        tmp_search_pad_data = amp_mean_1;
        tmp_data_in = cal_norm_ptp_1;
        tmp_tmp_pre_cali_ptp = rg_norm_cali_touch_1;
        tmp_pre_cali_ptp_1 = rg_norm_cali_base_1;
        tmp_tmp_pre_cali_diff = search_min_buf_1;
        tmp_tmp_mean_cache_read_slice_1 = mean_gather_buffer_1_0;
        tmp_tmp_mean_cache_read_slice_2 = mean_gather_buffer_1_1;
        tmp_tmp_mean_cache_read_slice_3 = mean_gather_buffer_1_2;
        tmp_tmp_mean_cache_read_slice_4 = mean_gather_buffer_1_3;
        tmp_when = search_max_buf_1;
        tmp_tmp_norm_gather_buffer_0 = cal_norm_Value_1;
      end
      default : begin
        tmp_search_pad_data = amp_mean_2;
        tmp_data_in = cal_norm_ptp_2;
        tmp_tmp_pre_cali_ptp = rg_norm_cali_touch_2;
        tmp_pre_cali_ptp_1 = rg_norm_cali_base_2;
        tmp_tmp_pre_cali_diff = search_min_buf_2;
        tmp_tmp_mean_cache_read_slice_1 = mean_gather_buffer_2_0;
        tmp_tmp_mean_cache_read_slice_2 = mean_gather_buffer_2_1;
        tmp_tmp_mean_cache_read_slice_3 = mean_gather_buffer_2_2;
        tmp_tmp_mean_cache_read_slice_4 = mean_gather_buffer_2_3;
        tmp_when = search_max_buf_2;
        tmp_tmp_norm_gather_buffer_0 = cal_norm_Value_2;
      end
    endcase
  end

  always @(*) begin
    case(search_cache_slice_ptr)
      2'b00 : begin
        tmp_norm_read_mean_mem = norm_read_mean_mem_buffer_slice_0;
        tmp_tmp_mean_cache_read_slice = tmp_tmp_mean_cache_read_slice_1;
        tmp_mean_cache_read_slice_1 = search_cache_slice_0;
      end
      2'b01 : begin
        tmp_norm_read_mean_mem = norm_read_mean_mem_buffer_slice_1;
        tmp_tmp_mean_cache_read_slice = tmp_tmp_mean_cache_read_slice_2;
        tmp_mean_cache_read_slice_1 = search_cache_slice_1;
      end
      2'b10 : begin
        tmp_norm_read_mean_mem = norm_read_mean_mem_buffer_slice_2;
        tmp_tmp_mean_cache_read_slice = tmp_tmp_mean_cache_read_slice_3;
        tmp_mean_cache_read_slice_1 = search_cache_slice_2;
      end
      default : begin
        tmp_norm_read_mean_mem = norm_read_mean_mem_buffer_slice_3;
        tmp_tmp_mean_cache_read_slice = tmp_tmp_mean_cache_read_slice_4;
        tmp_mean_cache_read_slice_1 = search_cache_slice_3;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(curr_state)
      NORMSTATE_IDLE : curr_state_string = "IDLE      ";
      NORMSTATE_STORE_MEAN : curr_state_string = "STORE_MEAN";
      NORMSTATE_SEARCH_PTP : curr_state_string = "SEARCH_PTP";
      NORMSTATE_CAL_NORM : curr_state_string = "CAL_NORM  ";
      default : curr_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(next_state)
      NORMSTATE_IDLE : next_state_string = "IDLE      ";
      NORMSTATE_STORE_MEAN : next_state_string = "STORE_MEAN";
      NORMSTATE_SEARCH_PTP : next_state_string = "SEARCH_PTP";
      NORMSTATE_CAL_NORM : next_state_string = "CAL_NORM  ";
      default : next_state_string = "??????????";
    endcase
  end
  `endif

  assign norm_is_first_seq = (! norm_is_not_first_seq);
  assign state_is_storemean = (curr_state == NORMSTATE_STORE_MEAN);
  assign state_in_searchptp = ((curr_state != NORMSTATE_SEARCH_PTP) && (next_state == NORMSTATE_SEARCH_PTP));
  assign state_is_searchptp = (curr_state == NORMSTATE_SEARCH_PTP);
  assign state_in_calnorm = ((curr_state != NORMSTATE_CAL_NORM) && (next_state == NORMSTATE_CAL_NORM));
  assign state_is_calnorm = (curr_state == NORMSTATE_CAL_NORM);
  assign mean_num = (tmp_mean_num - 6'h01);
  assign mean_cahe_word_num = (mean_num >>> 2'd2);
  assign norm_cahe_word_num = (mean_num >>> 2'd3);
  assign pad_aready_smp_num = (tmp_pad_aready_smp_num - 6'h01);
  assign pad_start_cahe_word_num = (pad_aready_smp_num >>> 2'd2);
  assign mean_gather_buffer_ptr_ov = (mean_gather_buffer_ptr == 2'b11);
  assign cache_ptr_ov = (cache_ptr == mean_cahe_word_num);
  assign frist_64_smp_done = (cache_ptr_ov && mean_cache_write_2);
  assign pad_smp_en = (((rg_norm_mean_pad_smp_num_log2 != 3'b000) && (! frist_64_smp_done_latch)) && (pad_start_cahe_word_num <= cache_ptr));
  assign pad_mean_store_done = (pad_smp_en && mean_cache_write_2);
  assign pad_is_frist_seq = (! pad_is_not_frist_seq);
  assign pad_seq_start = (pad_is_frist_seq ? pad_mean_store_done : amp_mean_vld_2_dly);
  assign mean_store_done = (norm_is_first_seq ? (frist_64_smp_done || pad_seq_start) : amp_mean_vld_2_dly);
  assign search_ptp_inc = (state_is_searchptp_delay_2 && state_is_searchptp);
  assign search_cache_slice_ptr_ov = (search_cache_slice_ptr == 2'b11);
  assign search_cache_slice_0 = cache_rdata[15 : 0];
  assign search_cache_slice_1 = cache_rdata[31 : 16];
  assign search_cache_slice_2 = cache_rdata[47 : 32];
  assign search_cache_slice_3 = cache_rdata[63 : 48];
  assign search_cache_ptr_ov = (search_cache_ptr == mean_cahe_word_num);
  assign pad_word_ref_ptr_ov = (pad_word_ref_ptr == mean_cahe_word_num);
  assign search_area_num_ov = (search_area_num == 2'b10);
  assign need_search_from_buffer = (norm_is_not_first_seq && (mean_gather_buffer_ptr != 2'b00));
  always @(*) begin
    if(pad_smp_en) begin
      if((cache_ptr <= pad_word_ref_ptr)) begin
        if((pad_word_ref_ptr == cache_ptr)) begin
          pad_search_from_buffer = (search_cache_slice_ptr < mean_gather_buffer_ptr);
        end else begin
          pad_search_from_buffer = 1'b0;
        end
      end else begin
        pad_search_from_buffer = 1'b0;
      end
    end else begin
      pad_search_from_buffer = 1'b0;
    end
  end

  always @(*) begin
    if(pad_smp_en) begin
      if((cache_ptr <= pad_word_ref_ptr)) begin
        if((pad_word_ref_ptr == cache_ptr)) begin
          search_pad_data_vld = (mean_gather_buffer_ptr <= search_cache_slice_ptr);
        end else begin
          search_pad_data_vld = 1'b1;
        end
      end else begin
        search_pad_data_vld = 1'b0;
      end
    end else begin
      search_pad_data_vld = 1'b0;
    end
  end

  assign search_pad_data = tmp_search_pad_data;
  assign cal_norm_inc = (state_is_calnorm_delay_2 && (curr_state == NORMSTATE_CAL_NORM));
  assign search_inc_dly = (tmp_search_inc_dly && (state_is_searchptp || state_is_calnorm));
  assign lzc_unit_data_in = tmp_data_in;
  assign most_signifi_num = ((lzc_unit_cnt_out == 5'h10) ? tmp_most_signifi_num : lzc_unit_cnt_out[3 : 0]);
  assign norm_read_mean_real = ((cache_ena && (! cache_wena)) && cal_norm_inc);
  assign norm_write_mean_real = ((cache_ena && cache_wena) && cal_norm_inc);
  assign norm_read_mean_mem_buffer_slice_0 = norm_read_mean_mem_buffer[15 : 0];
  assign norm_read_mean_mem_buffer_slice_1 = norm_read_mean_mem_buffer[31 : 16];
  assign norm_read_mean_mem_buffer_slice_2 = norm_read_mean_mem_buffer[47 : 32];
  assign norm_read_mean_mem_buffer_slice_3 = norm_read_mean_mem_buffer[63 : 48];
  assign norm_read_mean_mem = tmp_norm_read_mean_mem;
  assign norm_gather_buffer_ptr_ov = (norm_gather_buffer_ptr == 3'b111);
  assign norm_gather_done = (cal_norm_inc && norm_gather_buffer_ptr_ov_delay_1);
  assign norm_gather_word = {{{{{{{norm_gather_buffer_7,norm_gather_buffer_6},norm_gather_buffer_5},norm_gather_buffer_4},norm_gather_buffer_3},norm_gather_buffer_2},norm_gather_buffer_1},norm_gather_buffer_0};
  assign norm_gather_cache_ptr_ov = (norm_gather_cache_ptr == norm_cahe_word_num);
  assign norm_gather_write_read_conflict = ((|{norm_gather_word_write_2,{norm_gather_word_write_1,norm_gather_word_write_0}}) && (|{cal_norm_cache_read_2,{cal_norm_cache_read_1,cal_norm_cache_read_0}}));
  assign tmp_pre_cali_ptp = tmp_tmp_pre_cali_ptp;
  assign pre_cali_ptp = (tmp_pre_cali_ptp_1 - tmp_pre_cali_ptp);
  assign pre_cali_ptp_en = (pre_cali_ptp != 11'h0);
  assign tmp_pre_cali_diff = tmp_tmp_pre_cali_diff;
  assign tmp_1 = ({3'd0,1'b1} <<< search_area_num);
  assign pre_cali_diff = (pre_cali_ptp_en ? tmp_pre_cali_diff_1 : tmp_pre_cali_diff_5);
  assign cal_norm_done = ((cal_norm_inc && norm_gather_word_write_2) && (norm_gather_cache_ptr == norm_cahe_word_num));
  assign cal_norm_done_his_0 = cal_norm_done;
  assign norm_done = cal_norm_done_his_3;
  assign norm_done_20M = (|{cal_norm_done_his_3,{cal_norm_done_his_2,{cal_norm_done_his_1,cal_norm_done_his_0}}});
  assign tmp_samp_done = ((state_is_storemean && (! mean_store_done)) && amp_mean_vld_2_dly);
  assign samp_done = (|{tmp_samp_done_3,{tmp_samp_done_2,{tmp_samp_done_1,tmp_samp_done}}});
  always @(*) begin
    if(need_search_from_buffer) begin
      if(((search_cache_slice_ptr_ov && state_is_calnorm) && (! cal_norm_inc))) begin
        cal_norm_cache_oth_read = cal_norm_cache_1st_read_delay_1;
      end else begin
        cal_norm_cache_oth_read = (cal_norm_inc && (search_cache_slice_ptr == 2'b10));
      end
    end else begin
      cal_norm_cache_oth_read = (cal_norm_inc && (search_cache_slice_ptr == 2'b10));
    end
  end

  always @(*) begin
    if(need_search_from_buffer) begin
      if(((search_cache_slice_ptr_ov && state_is_searchptp) && (! search_ptp_inc))) begin
        search_cache_oth_read = search_cache_1st_read_delay_1;
      end else begin
        search_cache_oth_read = (search_ptp_inc && (search_cache_slice_ptr == 2'b10));
      end
    end else begin
      search_cache_oth_read = (search_ptp_inc && (search_cache_slice_ptr == 2'b10));
    end
  end

  always @(*) begin
    if(need_search_from_buffer) begin
      search_area_inc = ((search_cache_slice_ptr == tmp_search_area_inc) && (search_cache_ptr == 4'b0001));
    end else begin
      search_area_inc = (search_cache_slice_ptr_ov && (search_cache_ptr == 4'b0001));
    end
  end

  always @(*) begin
    if((((search_cache_ptr == 4'b0000) && (search_cache_oth_read || cal_norm_cache_oth_read)) || search_area_inc)) begin
      if((search_area_num < 2'b10)) begin
        search_area_num_pre = (search_area_num + 2'b01);
      end else begin
        search_area_num_pre = search_area_num;
      end
    end else begin
      search_area_num_pre = search_area_num;
    end
  end

  assign tmp_mean_cache_read_slice = tmp_tmp_mean_cache_read_slice;
  always @(*) begin
    if(pad_search_from_buffer) begin
      mean_cache_read_slice = tmp_mean_cache_read_slice;
    end else begin
      if(search_pad_data_vld) begin
        mean_cache_read_slice = {5'd0, search_pad_data};
      end else begin
        if(mean_cache_read_slice_from_buffer) begin
          mean_cache_read_slice = tmp_mean_cache_read_slice;
        end else begin
          if(norm_read_mean_from_buffer) begin
            mean_cache_read_slice = norm_read_mean_mem;
          end else begin
            mean_cache_read_slice = tmp_mean_cache_read_slice_1;
          end
        end
      end
    end
  end

  always @(*) begin
    if(need_search_from_buffer) begin
      search_ptp_done = ((((mean_cache_read_slice_from_buffer && search_ptp_inc) && search_area_inc) && search_area_num_ov) && (! cache_ena));
    end else begin
      search_ptp_done = (((search_ptp_inc && search_cache_slice_ptr_ov) && search_area_num_ov) && (search_cache_ptr == 4'b0001));
    end
  end

  assign mean_gather_word_0 = {{{mean_gather_buffer_0_3,mean_gather_buffer_0_2},mean_gather_buffer_0_1},mean_gather_buffer_0_0};
  assign mean_cache_write_0 = (state_is_storemean && mean_gather_done_0);
  assign tmp_2 = ({3'd0,1'b1} <<< mean_gather_buffer_ptr);
  assign tmp_mean_gather_buffer_0_0 = amp_mean_0;
  assign search_cache_read_0 = ((search_area_num_pre == 2'b00) ? (search_cache_1st_read || search_cache_oth_read) : 1'b0);
  assign cal_norm_cache_read_0 = ((search_area_num_pre == 2'b00) ? (cal_norm_cache_1st_read || cal_norm_cache_oth_read) : 1'b0);
  assign cal_norm_ptp_0 = (pre_cali_ptp_en ? tmp_cal_norm_ptp_0 : tmp_cal_norm_ptp_0_1);
  assign norm_gather_word_write_0 = ((search_area_num_dly == 2'b00) ? norm_gather_done : 1'b0);
  assign mean_gather_word_1 = {{{mean_gather_buffer_1_3,mean_gather_buffer_1_2},mean_gather_buffer_1_1},mean_gather_buffer_1_0};
  assign mean_cache_write_1 = (state_is_storemean && mean_gather_done_1);
  assign tmp_3 = ({3'd0,1'b1} <<< mean_gather_buffer_ptr);
  assign tmp_mean_gather_buffer_1_0 = amp_mean_1;
  assign search_cache_read_1 = ((search_area_num_pre == 2'b01) ? (search_cache_1st_read || search_cache_oth_read) : 1'b0);
  assign cal_norm_cache_read_1 = ((search_area_num_pre == 2'b01) ? (cal_norm_cache_1st_read || cal_norm_cache_oth_read) : 1'b0);
  assign cal_norm_ptp_1 = (pre_cali_ptp_en ? tmp_cal_norm_ptp_1 : tmp_cal_norm_ptp_1_1);
  assign norm_gather_word_write_1 = ((search_area_num_dly == 2'b01) ? norm_gather_done : 1'b0);
  assign mean_gather_word_2 = {{{mean_gather_buffer_2_3,mean_gather_buffer_2_2},mean_gather_buffer_2_1},mean_gather_buffer_2_0};
  assign mean_cache_write_2 = (state_is_storemean && mean_gather_done_2);
  assign tmp_4 = ({3'd0,1'b1} <<< mean_gather_buffer_ptr);
  assign tmp_mean_gather_buffer_2_0 = amp_mean_2;
  assign search_cache_read_2 = ((search_area_num_pre == 2'b10) ? (search_cache_1st_read || search_cache_oth_read) : 1'b0);
  assign cal_norm_cache_read_2 = ((search_area_num_pre == 2'b10) ? (cal_norm_cache_1st_read || cal_norm_cache_oth_read) : 1'b0);
  assign cal_norm_ptp_2 = (pre_cali_ptp_en ? tmp_cal_norm_ptp_2 : tmp_cal_norm_ptp_2_1);
  assign norm_gather_word_write_2 = ((search_area_num_dly == 2'b10) ? norm_gather_done : 1'b0);
  assign tmp_5 = ({3'd0,1'b1} <<< search_area_num);
  always @(*) begin
    cal_norm_Value_0 = 8'h0;
    if(cal_norm_inc) begin
      if(tmp_6[0]) begin
        cal_norm_Value_0 = tmp_cal_norm_Value_0_2;
      end
    end
  end

  always @(*) begin
    cal_norm_Value_1 = 8'h0;
    if(cal_norm_inc) begin
      if(tmp_6[1]) begin
        cal_norm_Value_1 = tmp_cal_norm_Value_0_2;
      end
    end
  end

  always @(*) begin
    cal_norm_Value_2 = 8'h0;
    if(cal_norm_inc) begin
      if(tmp_6[2]) begin
        cal_norm_Value_2 = tmp_cal_norm_Value_0_2;
      end
    end
  end

  assign tmp_6 = ({3'd0,1'b1} <<< search_area_num);
  assign tmp_cal_norm_Value_0 = ($signed(tmp_tmp_cal_norm_Value_0) >>> most_signifi_num);
  always @(*) begin
    if(tmp_cal_norm_Value_0[22]) begin
      if((! (&tmp_when_1))) begin
        tmp_cal_norm_Value_0_1 = 8'h80;
      end else begin
        tmp_cal_norm_Value_0_1 = tmp_cal_norm_Value_0[7 : 0];
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_cal_norm_Value_0_1 = 8'h7f;
      end else begin
        tmp_cal_norm_Value_0_1 = tmp_cal_norm_Value_0[7 : 0];
      end
    end
  end

  assign tmp_cal_norm_Value_0_2 = tmp_cal_norm_Value_0_1;
  assign tmp_7 = ({7'd0,1'b1} <<< norm_gather_buffer_ptr);
  assign tmp_norm_gather_buffer_0 = tmp_tmp_norm_gather_buffer_0;
  always @(*) begin
    next_state = curr_state;
    case(curr_state)
      NORMSTATE_IDLE : begin
        if(amp_mean_vld_0) begin
          next_state = NORMSTATE_STORE_MEAN;
        end
      end
      NORMSTATE_STORE_MEAN : begin
        if(mean_store_done) begin
          next_state = NORMSTATE_SEARCH_PTP;
        end
      end
      NORMSTATE_SEARCH_PTP : begin
        if(search_ptp_done) begin
          next_state = NORMSTATE_CAL_NORM;
        end
      end
      default : begin
        if(cal_norm_done) begin
          next_state = NORMSTATE_STORE_MEAN;
        end
      end
    endcase
  end

  always @(*) begin
    if(pad_smp_en) begin
      search_cache_addr_bias_0 = {3'd0, tmp_search_cache_addr_bias_0};
    end else begin
      if((tmp_when_3 < tmp_when_4)) begin
        search_cache_addr_bias_0 = {3'd0, tmp_search_cache_addr_bias_0_1};
      end else begin
        search_cache_addr_bias_0 = {3'd0, tmp_search_cache_addr_bias_0_5};
      end
    end
  end

  assign norm_gather_word_write_base_0 = (rg_norm_base_addr_0 + tmp_norm_gather_word_write_base_0);
  always @(*) begin
    if(pad_smp_en) begin
      search_cache_addr_bias_1 = {2'd0, tmp_search_cache_addr_bias_1};
    end else begin
      if((tmp_when_5 < tmp_when_6)) begin
        search_cache_addr_bias_1 = {2'd0, tmp_search_cache_addr_bias_1_2};
      end else begin
        search_cache_addr_bias_1 = {2'd0, tmp_search_cache_addr_bias_1_9};
      end
    end
  end

  assign norm_gather_word_write_base_1 = (rg_norm_base_addr_1 + tmp_norm_gather_word_write_base_1);
  always @(*) begin
    if(pad_smp_en) begin
      search_cache_addr_bias_2 = {1'd0, tmp_search_cache_addr_bias_2};
    end else begin
      if((tmp_when_7 < tmp_when_8)) begin
        search_cache_addr_bias_2 = {1'd0, tmp_search_cache_addr_bias_2_2};
      end else begin
        search_cache_addr_bias_2 = {1'd0, tmp_search_cache_addr_bias_2_9};
      end
    end
  end

  assign norm_gather_word_write_base_2 = (rg_norm_base_addr_2 + tmp_norm_gather_word_write_base_2);
  always @(posedge clkout or negedge rstn_80m) begin
    if(!rstn_80m) begin
      curr_state <= NORMSTATE_IDLE;
      norm_is_not_first_seq <= 1'b0;
      mean_gather_buffer_0_0 <= 16'h0;
      mean_gather_buffer_0_1 <= 16'h0;
      mean_gather_buffer_0_2 <= 16'h0;
      mean_gather_buffer_0_3 <= 16'h0;
      mean_gather_buffer_1_0 <= 16'h0;
      mean_gather_buffer_1_1 <= 16'h0;
      mean_gather_buffer_1_2 <= 16'h0;
      mean_gather_buffer_1_3 <= 16'h0;
      mean_gather_buffer_2_0 <= 16'h0;
      mean_gather_buffer_2_1 <= 16'h0;
      mean_gather_buffer_2_2 <= 16'h0;
      mean_gather_buffer_2_3 <= 16'h0;
      mean_gather_buffer_ptr <= 2'b00;
      mean_gather_done_0 <= 1'b0;
      mean_gather_done_1 <= 1'b0;
      mean_gather_done_2 <= 1'b0;
      amp_mean_vld_2_dly <= 1'b0;
      cache_ptr <= 4'b0000;
      frist_64_smp_done_latch <= 1'b0;
      pad_is_not_frist_seq <= 1'b0;
      state_is_searchptp_delay_1 <= 1'b0;
      state_is_searchptp_delay_2 <= 1'b0;
      search_cache_slice_ptr <= 2'b00;
      search_cache_1st_read <= 1'b0;
      search_cache_ptr <= 4'b0000;
      pad_word_ref_ptr <= 4'b0000;
      search_area_num <= 2'b00;
      search_area_num_dly <= 2'b00;
      search_min_buf_0 <= 16'h0;
      search_min_buf_1 <= 16'h0;
      search_min_buf_2 <= 16'h0;
      search_max_buf_0 <= 16'h0;
      search_max_buf_1 <= 16'h0;
      search_max_buf_2 <= 16'h0;
      state_is_calnorm_delay_1 <= 1'b0;
      state_is_calnorm_delay_2 <= 1'b0;
      tmp_search_inc_dly <= 1'b0;
      cal_norm_cache_1st_read <= 1'b0;
      mean_cache_read_slice_from_buffer <= 1'b0;
      norm_read_mean_from_buffer <= 1'b0;
      norm_read_mean_mem_buffer_refresh <= 1'b0;
      norm_read_mean_mem_buffer <= 64'h0;
      norm_gather_buffer_0 <= 8'h0;
      norm_gather_buffer_1 <= 8'h0;
      norm_gather_buffer_2 <= 8'h0;
      norm_gather_buffer_3 <= 8'h0;
      norm_gather_buffer_4 <= 8'h0;
      norm_gather_buffer_5 <= 8'h0;
      norm_gather_buffer_6 <= 8'h0;
      norm_gather_buffer_7 <= 8'h0;
      norm_gather_buffer_ptr <= 3'b000;
      norm_gather_buffer_ptr_ov_delay_1 <= 1'b0;
      norm_gather_cache_ptr <= 3'b000;
      norm_gather_write_conflict_vld_buf <= 1'b0;
      norm_gather_write_conflict_addr_buf <= 7'h0;
      norm_gather_write_conflict_data_buf <= 64'h0;
      cal_norm_done_his_1 <= 1'b0;
      cal_norm_done_his_2 <= 1'b0;
      cal_norm_done_his_3 <= 1'b0;
      tmp_samp_done_1 <= 1'b0;
      tmp_samp_done_2 <= 1'b0;
      tmp_samp_done_3 <= 1'b0;
      cache_addr <= 7'h0;
      cache_wena <= 1'b0;
      cache_ena <= 1'b0;
      cache_wdata <= 64'h0;
    end else begin
      amp_mean_vld_2_dly <= amp_mean_vld_2;
      if(frist_64_smp_done) begin
        frist_64_smp_done_latch <= 1'b1;
      end
      if(pad_mean_store_done) begin
        pad_is_not_frist_seq <= 1'b1;
      end
      state_is_searchptp_delay_1 <= state_is_searchptp;
      state_is_searchptp_delay_2 <= state_is_searchptp_delay_1;
      search_cache_1st_read <= state_in_searchptp;
      search_area_num_dly <= search_area_num;
      state_is_calnorm_delay_1 <= state_is_calnorm;
      state_is_calnorm_delay_2 <= state_is_calnorm_delay_1;
      tmp_search_inc_dly <= (search_ptp_inc || cal_norm_inc);
      cal_norm_cache_1st_read <= state_in_calnorm;
      norm_read_mean_mem_buffer_refresh <= norm_read_mean_real;
      if(norm_read_mean_mem_buffer_refresh) begin
        norm_read_mean_mem_buffer <= cache_rdata;
      end
      if(norm_read_mean_real) begin
        norm_read_mean_from_buffer <= 1'b0;
      end else begin
        if(norm_write_mean_real) begin
          norm_read_mean_from_buffer <= 1'b1;
        end
      end
      norm_gather_buffer_ptr_ov_delay_1 <= norm_gather_buffer_ptr_ov;
      norm_gather_write_conflict_vld_buf <= norm_gather_write_read_conflict;
      if(norm_gather_write_read_conflict) begin
        norm_gather_write_conflict_data_buf <= norm_gather_word;
      end
      cal_norm_done_his_1 <= cal_norm_done_his_0;
      cal_norm_done_his_2 <= cal_norm_done_his_1;
      cal_norm_done_his_3 <= cal_norm_done_his_2;
      tmp_samp_done_1 <= tmp_samp_done;
      tmp_samp_done_2 <= tmp_samp_done_1;
      tmp_samp_done_3 <= tmp_samp_done_2;
      if(amp_mean_vld_2) begin
        if(mean_gather_buffer_ptr_ov) begin
          mean_gather_buffer_ptr <= 2'b00;
        end else begin
          mean_gather_buffer_ptr <= (mean_gather_buffer_ptr + 2'b01);
        end
      end
      if((state_in_searchptp || state_in_calnorm)) begin
        if(pad_smp_en) begin
          search_cache_slice_ptr <= 2'b00;
        end else begin
          search_cache_slice_ptr <= mean_gather_buffer_ptr;
        end
      end else begin
        if((search_ptp_inc || cal_norm_inc)) begin
          if(search_cache_slice_ptr_ov) begin
            search_cache_slice_ptr <= 2'b00;
          end else begin
            search_cache_slice_ptr <= (search_cache_slice_ptr + 2'b01);
          end
        end
      end
      if((state_in_searchptp || state_in_calnorm)) begin
        pad_word_ref_ptr <= 4'b0000;
      end else begin
        if((search_cache_slice_ptr_ov && pad_smp_en)) begin
          if(pad_word_ref_ptr_ov) begin
            pad_word_ref_ptr <= 4'b0000;
          end else begin
            pad_word_ref_ptr <= (pad_word_ref_ptr + 4'b0001);
          end
        end
      end
      if(mean_gather_done_2) begin
        if(cache_ptr_ov) begin
          cache_ptr <= 4'b0000;
        end else begin
          cache_ptr <= (cache_ptr + 4'b0001);
        end
      end
      if((search_ptp_done || cal_norm_done)) begin
        search_cache_ptr <= 4'b0000;
      end else begin
        if(((|{search_cache_read_2,{search_cache_read_1,search_cache_read_0}}) || (|{cal_norm_cache_read_2,{cal_norm_cache_read_1,cal_norm_cache_read_0}}))) begin
          if(search_cache_ptr_ov) begin
            search_cache_ptr <= 4'b0000;
          end else begin
            search_cache_ptr <= (search_cache_ptr + 4'b0001);
          end
        end
      end
      if((search_ptp_done || cal_norm_done)) begin
        search_area_num <= 2'b00;
      end else begin
        if(search_area_inc) begin
          if(search_area_num_ov) begin
            search_area_num <= 2'b00;
          end else begin
            search_area_num <= (search_area_num + 2'b01);
          end
        end
      end
      if((((need_search_from_buffer && search_cache_slice_ptr_ov) && (search_cache_ptr == 4'b0001)) && search_inc_dly)) begin
        mean_cache_read_slice_from_buffer <= 1'b1;
      end else begin
        if(search_area_inc) begin
          mean_cache_read_slice_from_buffer <= 1'b0;
        end
      end
      mean_gather_done_0 <= (amp_mean_vld_0 && mean_gather_buffer_ptr_ov);
      if(amp_mean_vld_0) begin
        if(tmp_2[0]) begin
          mean_gather_buffer_0_0 <= {5'd0, tmp_mean_gather_buffer_0_0};
        end
        if(tmp_2[1]) begin
          mean_gather_buffer_0_1 <= {5'd0, tmp_mean_gather_buffer_0_0};
        end
        if(tmp_2[2]) begin
          mean_gather_buffer_0_2 <= {5'd0, tmp_mean_gather_buffer_0_0};
        end
        if(tmp_2[3]) begin
          mean_gather_buffer_0_3 <= {5'd0, tmp_mean_gather_buffer_0_0};
        end
      end
      mean_gather_done_1 <= (amp_mean_vld_1 && mean_gather_buffer_ptr_ov);
      if(amp_mean_vld_1) begin
        if(tmp_3[0]) begin
          mean_gather_buffer_1_0 <= {5'd0, tmp_mean_gather_buffer_1_0};
        end
        if(tmp_3[1]) begin
          mean_gather_buffer_1_1 <= {5'd0, tmp_mean_gather_buffer_1_0};
        end
        if(tmp_3[2]) begin
          mean_gather_buffer_1_2 <= {5'd0, tmp_mean_gather_buffer_1_0};
        end
        if(tmp_3[3]) begin
          mean_gather_buffer_1_3 <= {5'd0, tmp_mean_gather_buffer_1_0};
        end
      end
      mean_gather_done_2 <= (amp_mean_vld_2 && mean_gather_buffer_ptr_ov);
      if(amp_mean_vld_2) begin
        if(tmp_4[0]) begin
          mean_gather_buffer_2_0 <= {5'd0, tmp_mean_gather_buffer_2_0};
        end
        if(tmp_4[1]) begin
          mean_gather_buffer_2_1 <= {5'd0, tmp_mean_gather_buffer_2_0};
        end
        if(tmp_4[2]) begin
          mean_gather_buffer_2_2 <= {5'd0, tmp_mean_gather_buffer_2_0};
        end
        if(tmp_4[3]) begin
          mean_gather_buffer_2_3 <= {5'd0, tmp_mean_gather_buffer_2_0};
        end
      end
      if(state_in_searchptp) begin
        search_min_buf_0 <= 16'hffff;
        search_max_buf_0 <= 16'h0;
        search_min_buf_1 <= 16'hffff;
        search_max_buf_1 <= 16'h0;
        search_min_buf_2 <= 16'hffff;
        search_max_buf_2 <= 16'h0;
      end else begin
        if(search_ptp_inc) begin
          if((mean_cache_read_slice < tmp_pre_cali_diff)) begin
            if(tmp_1[0]) begin
              search_min_buf_0 <= mean_cache_read_slice;
            end
            if(tmp_1[1]) begin
              search_min_buf_1 <= mean_cache_read_slice;
            end
            if(tmp_1[2]) begin
              search_min_buf_2 <= mean_cache_read_slice;
            end
          end
          if((tmp_when < mean_cache_read_slice)) begin
            if(tmp_5[0]) begin
              search_max_buf_0 <= mean_cache_read_slice;
            end
            if(tmp_5[1]) begin
              search_max_buf_1 <= mean_cache_read_slice;
            end
            if(tmp_5[2]) begin
              search_max_buf_2 <= mean_cache_read_slice;
            end
          end
        end
      end
      if(cal_norm_inc) begin
        if((norm_gather_buffer_ptr_ov || cal_norm_done)) begin
          norm_gather_buffer_ptr <= 3'b000;
        end else begin
          norm_gather_buffer_ptr <= (norm_gather_buffer_ptr + 3'b001);
        end
        if(tmp_7[0]) begin
          norm_gather_buffer_0 <= tmp_norm_gather_buffer_0;
        end
        if(tmp_7[1]) begin
          norm_gather_buffer_1 <= tmp_norm_gather_buffer_0;
        end
        if(tmp_7[2]) begin
          norm_gather_buffer_2 <= tmp_norm_gather_buffer_0;
        end
        if(tmp_7[3]) begin
          norm_gather_buffer_3 <= tmp_norm_gather_buffer_0;
        end
        if(tmp_7[4]) begin
          norm_gather_buffer_4 <= tmp_norm_gather_buffer_0;
        end
        if(tmp_7[5]) begin
          norm_gather_buffer_5 <= tmp_norm_gather_buffer_0;
        end
        if(tmp_7[6]) begin
          norm_gather_buffer_6 <= tmp_norm_gather_buffer_0;
        end
        if(tmp_7[7]) begin
          norm_gather_buffer_7 <= tmp_norm_gather_buffer_0;
        end
      end
      if(norm_gather_done) begin
        if(norm_gather_cache_ptr_ov) begin
          norm_gather_cache_ptr <= 3'b000;
        end else begin
          norm_gather_cache_ptr <= (norm_gather_cache_ptr + 3'b001);
        end
      end
      curr_state <= next_state;
      if((cal_norm_done && (! pad_smp_en))) begin
        norm_is_not_first_seq <= 1'b1;
      end
      if(norm_gather_write_read_conflict) begin
        if(norm_gather_word_write_0) begin
          norm_gather_write_conflict_addr_buf <= norm_gather_word_write_base_0;
        end else begin
          if(norm_gather_word_write_1) begin
            norm_gather_write_conflict_addr_buf <= norm_gather_word_write_base_1;
          end else begin
            if(norm_gather_word_write_2) begin
              norm_gather_write_conflict_addr_buf <= norm_gather_word_write_base_2;
            end
          end
        end
      end
      if(mean_cache_write_0) begin
        cache_ena <= 1'b1;
        cache_wena <= 1'b1;
        cache_addr <= (rg_norm_mean_base_addr + tmp_cache_addr);
        cache_wdata <= mean_gather_word_0;
      end else begin
        if(mean_cache_write_1) begin
          cache_ena <= 1'b1;
          cache_wena <= 1'b1;
          cache_addr <= (tmp_cache_addr_1 + tmp_cache_addr_2);
          cache_wdata <= mean_gather_word_1;
        end else begin
          if(mean_cache_write_2) begin
            cache_ena <= 1'b1;
            cache_wena <= 1'b1;
            cache_addr <= (tmp_cache_addr_3 + tmp_cache_addr_4);
            cache_wdata <= mean_gather_word_2;
          end else begin
            if(search_cache_read_0) begin
              cache_ena <= 1'b1;
              cache_wena <= 1'b0;
              cache_addr <= (rg_norm_mean_base_addr + search_cache_addr_bias_0);
            end else begin
              if(search_cache_read_1) begin
                cache_ena <= 1'b1;
                cache_wena <= 1'b0;
                cache_addr <= (rg_norm_mean_base_addr + search_cache_addr_bias_1);
              end else begin
                if(search_cache_read_2) begin
                  cache_ena <= 1'b1;
                  cache_wena <= 1'b0;
                  cache_addr <= (rg_norm_mean_base_addr + search_cache_addr_bias_2);
                end else begin
                  if(cal_norm_cache_read_0) begin
                    cache_ena <= 1'b1;
                    cache_wena <= 1'b0;
                    cache_addr <= (rg_norm_mean_base_addr + search_cache_addr_bias_0);
                  end else begin
                    if(cal_norm_cache_read_1) begin
                      cache_ena <= 1'b1;
                      cache_wena <= 1'b0;
                      cache_addr <= (rg_norm_mean_base_addr + search_cache_addr_bias_1);
                    end else begin
                      if(cal_norm_cache_read_2) begin
                        cache_ena <= 1'b1;
                        cache_wena <= 1'b0;
                        cache_addr <= (rg_norm_mean_base_addr + search_cache_addr_bias_2);
                      end else begin
                        if(norm_gather_word_write_0) begin
                          cache_ena <= 1'b1;
                          cache_wena <= 1'b1;
                          cache_addr <= norm_gather_word_write_base_0;
                          cache_wdata <= norm_gather_word;
                        end else begin
                          if(norm_gather_word_write_1) begin
                            cache_ena <= 1'b1;
                            cache_wena <= 1'b1;
                            cache_addr <= norm_gather_word_write_base_1;
                            cache_wdata <= norm_gather_word;
                          end else begin
                            if(norm_gather_word_write_2) begin
                              cache_ena <= 1'b1;
                              cache_wena <= 1'b1;
                              cache_addr <= norm_gather_word_write_base_2;
                              cache_wdata <= norm_gather_word;
                            end else begin
                              if(norm_gather_write_conflict_vld_buf) begin
                                cache_ena <= 1'b1;
                                cache_wena <= 1'b1;
                                cache_addr <= norm_gather_write_conflict_addr_buf;
                                cache_wdata <= norm_gather_write_conflict_data_buf;
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

  always @(posedge clkout or negedge rstn_80m) begin
    if(!rstn_80m) begin
      cal_norm_cache_1st_read_delay_1 <= 1'b0;
    end else begin
      cal_norm_cache_1st_read_delay_1 <= cal_norm_cache_1st_read;
    end
  end

  always @(posedge clkout or negedge rstn_80m) begin
    if(!rstn_80m) begin
      search_cache_1st_read_delay_1 <= 1'b0;
    end else begin
      search_cache_1st_read_delay_1 <= search_cache_1st_read;
    end
  end


endmodule

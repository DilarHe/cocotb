// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : fbank_top
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps

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
  wire                u_clkgate_filter_gclk_o;
  wire                u_clkgate_win_gclk_o;
  wire                u_clkgate_vad_gclk_o;
  wire                u_clkgate_fft_gclk_o;
  wire                u_clkgate_pow_gclk_o;
  wire                u_clkgate_mel_gclk_o;
  wire                u_clkgate_log_gclk_o;
  wire                u_clkgate_quant_gclk_o;
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
  wire       [21:0]   pow_mag_out;
  wire                mel_finish;
  wire                mel_memif_rd;
  wire                mel_memif_wr;
  wire       [31:0]   mel_memif_wdata;
  wire       [7:0]    mel_memif_addr;
  wire                mel_mulif_din_vld;
  wire       [31:0]   mel_mulif_dinA;
  wire       [15:0]   mel_mulif_dinB;
  wire       [21:0]   mel_mel_out;
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
  wire                clk_filter;
  wire                filter_active;
  wire                clk_win;
  wire                win_active;
  wire                clk_vad;
  wire                clk_fft;
  wire                fft_active;
  wire                clk_pow;
  wire                pow_active;
  wire                clk_mel;
  wire                mel_active;
  wire                clk_log;
  wire                log_active;
  wire                clk_quant;
  wire                quant_active;
  reg                 filter_en_reg;
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
  reg                 toplevel_fft_finish_regNext;
  reg                 toplevel_pow_finish_regNext;
  reg                 toplevel_mel_finish_regNext;
  wire                quant_start_time;
  reg                 quant_wait_flag;
  reg                 quant_wait_flag_regNext;

  assign tmp_mulif_dout = 25'h0;
  assign tmp_mulif_dout_1 = 25'h0;
  cld_clk_gate u_clkgate_filter (
    .clk_i                 (clk                    ), //i
    .dft_mode_test_mode_i  (1'b0                   ), //i
    .dft_mode_scan_mode_i  (1'b0                   ), //i
    .dft_mode_scan_shift_i (1'b0                   ), //i
    .dft_mode_mbist_mode_i (1'b0                   ), //i
    .en_i                  (rg_kws_fb_lp_filter_en ), //i
    .gclk_o                (u_clkgate_filter_gclk_o)  //o
  );
  cld_clk_gate u_clkgate_win (
    .clk_i                 (clk                 ), //i
    .dft_mode_test_mode_i  (1'b0                ), //i
    .dft_mode_scan_mode_i  (1'b0                ), //i
    .dft_mode_scan_shift_i (1'b0                ), //i
    .dft_mode_mbist_mode_i (1'b0                ), //i
    .en_i                  (win_active          ), //i
    .gclk_o                (u_clkgate_win_gclk_o)  //o
  );
  cld_clk_gate u_clkgate_vad (
    .clk_i                 (clk                 ), //i
    .dft_mode_test_mode_i  (1'b0                ), //i
    .dft_mode_scan_mode_i  (1'b0                ), //i
    .dft_mode_scan_shift_i (1'b0                ), //i
    .dft_mode_mbist_mode_i (1'b0                ), //i
    .en_i                  (rg_kws_fb_vad_en    ), //i
    .gclk_o                (u_clkgate_vad_gclk_o)  //o
  );
  cld_clk_gate u_clkgate_fft (
    .clk_i                 (clk                 ), //i
    .dft_mode_test_mode_i  (1'b0                ), //i
    .dft_mode_scan_mode_i  (1'b0                ), //i
    .dft_mode_scan_shift_i (1'b0                ), //i
    .dft_mode_mbist_mode_i (1'b0                ), //i
    .en_i                  (fft_active          ), //i
    .gclk_o                (u_clkgate_fft_gclk_o)  //o
  );
  cld_clk_gate u_clkgate_pow (
    .clk_i                 (clk                 ), //i
    .dft_mode_test_mode_i  (1'b0                ), //i
    .dft_mode_scan_mode_i  (1'b0                ), //i
    .dft_mode_scan_shift_i (1'b0                ), //i
    .dft_mode_mbist_mode_i (1'b0                ), //i
    .en_i                  (pow_active          ), //i
    .gclk_o                (u_clkgate_pow_gclk_o)  //o
  );
  cld_clk_gate u_clkgate_mel (
    .clk_i                 (clk                 ), //i
    .dft_mode_test_mode_i  (1'b0                ), //i
    .dft_mode_scan_mode_i  (1'b0                ), //i
    .dft_mode_scan_shift_i (1'b0                ), //i
    .dft_mode_mbist_mode_i (1'b0                ), //i
    .en_i                  (mel_active          ), //i
    .gclk_o                (u_clkgate_mel_gclk_o)  //o
  );
  cld_clk_gate u_clkgate_log (
    .clk_i                 (clk                 ), //i
    .dft_mode_test_mode_i  (1'b0                ), //i
    .dft_mode_scan_mode_i  (1'b0                ), //i
    .dft_mode_scan_shift_i (1'b0                ), //i
    .dft_mode_mbist_mode_i (1'b0                ), //i
    .en_i                  (log_active          ), //i
    .gclk_o                (u_clkgate_log_gclk_o)  //o
  );
  cld_clk_gate u_clkgate_quant (
    .clk_i                 (clk                   ), //i
    .dft_mode_test_mode_i  (1'b0                  ), //i
    .dft_mode_scan_mode_i  (1'b0                  ), //i
    .dft_mode_scan_shift_i (1'b0                  ), //i
    .dft_mode_mbist_mode_i (1'b0                  ), //i
    .en_i                  (quant_active          ), //i
    .gclk_o                (u_clkgate_quant_gclk_o)  //o
  );
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
    .clk_filter       (clk_filter                 ), //i
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
    .clk_win          (clk_win                    ), //i
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
    .clk_vad              (clk_vad                             ), //i
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
    .clk_fft          (clk_fft              ), //i
    .resetn           (resetn               )  //i
  );
  power pow (
    .start            (toplevel_fft_finish_regNext), //i
    .finish           (pow_finish                 ), //o
    .memif_rd         (pow_memif_rd               ), //o
    .memif_wr         (pow_memif_wr               ), //o
    .memif_addr       (pow_memif_addr[7:0]        ), //o
    .memif_wdata      (pow_memif_wdata[31:0]      ), //o
    .memif_rdata      (pow_memif_rdata[31:0]      ), //i
    .mulif_din_vld    (pow_mulif_din_vld          ), //o
    .mulif_dinA       (pow_mulif_dinA[15:0]       ), //o
    .mulif_dinB       (pow_mulif_dinB[15:0]       ), //o
    .mulif_dout_vld   (pow_mulif_dout_vld         ), //i
    .mulif_cal_finish (pow_mulif_cal_finish       ), //i
    .mulif_dout       (pow_mulif_dout[31:0]       ), //i
    .mag_out          (pow_mag_out[21:0]          ), //o
    .clk_pow          (clk_pow                    ), //i
    .resetn           (resetn                     )  //i
  );
  mel_dot mel (
    .start            (toplevel_pow_finish_regNext), //i
    .finish           (mel_finish                 ), //o
    .memif_rd         (mel_memif_rd               ), //o
    .memif_wr         (mel_memif_wr               ), //o
    .memif_addr       (mel_memif_addr[7:0]        ), //o
    .memif_wdata      (mel_memif_wdata[31:0]      ), //o
    .memif_rdata      (mel_memif_rdata[31:0]      ), //i
    .mulif_din_vld    (mel_mulif_din_vld          ), //o
    .mulif_dinA       (mel_mulif_dinA[31:0]       ), //o
    .mulif_dinB       (mel_mulif_dinB[15:0]       ), //o
    .mulif_dout_vld   (mel_mulif_dout_vld         ), //i
    .mulif_cal_finish (mel_mulif_cal_finish       ), //i
    .mulif_dout       (mel_mulif_dout[47:0]       ), //i
    .mel_out          (mel_mel_out[21:0]          ), //o
    .clk_mel          (clk_mel                    ), //i
    .resetn           (resetn                     )  //i
  );
  cordic_ln log (
    .start         (toplevel_mel_finish_regNext), //i
    .finish        (log_finish                 ), //o
    .memif_rd      (log_memif_rd               ), //o
    .memif_wr      (log_memif_wr               ), //o
    .memif_addr    (log_memif_addr[7:0]        ), //o
    .memif_wdata   (log_memif_wdata[31:0]      ), //o
    .memif_rdata   (log_memif_rdata[31:0]      ), //i
    .cordic_ln_out (log_cordic_ln_out[15:0]    ), //o
    .clk_log       (clk_log                    ), //i
    .resetn        (resetn                     )  //i
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
    .clk_quant               (clk_quant                    ), //i
    .resetn                  (resetn                       )  //i
  );
  ck_enable_gen_4 fft_cken (
    .start      (fft_start          ), //i
    .finish     (fft_finish         ), //i
    .enable_out (fft_cken_enable_out), //o
    .clk        (clk                ), //i
    .resetn     (resetn             )  //i
  );
  ck_enable_gen_4 pow_cken (
    .start      (toplevel_fft_finish_regNext), //i
    .finish     (pow_finish                 ), //i
    .enable_out (pow_cken_enable_out        ), //o
    .clk        (clk                        ), //i
    .resetn     (resetn                     )  //i
  );
  ck_enable_gen_4 mel_cken (
    .start      (toplevel_pow_finish_regNext), //i
    .finish     (mel_finish                 ), //i
    .enable_out (mel_cken_enable_out        ), //o
    .clk        (clk                        ), //i
    .resetn     (resetn                     )  //i
  );
  ck_enable_gen_4 log_cken (
    .start      (toplevel_mel_finish_regNext), //i
    .finish     (log_finish                 ), //i
    .enable_out (log_cken_enable_out        ), //o
    .clk        (clk                        ), //i
    .resetn     (resetn                     )  //i
  );
  ck_enable_gen_4 quant_cken (
    .start      (quant_start          ), //i
    .finish     (quant_finish         ), //i
    .enable_out (quant_cken_enable_out), //o
    .clk        (clk                  ), //i
    .resetn     (resetn               )  //i
  );
  assign clk_filter = u_clkgate_filter_gclk_o; // @[fbank_top.scala 112:14]
  assign clk_win = u_clkgate_win_gclk_o; // @[fbank_top.scala 113:11]
  assign clk_vad = u_clkgate_vad_gclk_o; // @[fbank_top.scala 114:11]
  assign clk_fft = u_clkgate_fft_gclk_o; // @[fbank_top.scala 115:11]
  assign clk_pow = u_clkgate_pow_gclk_o; // @[fbank_top.scala 116:11]
  assign clk_mel = u_clkgate_mel_gclk_o; // @[fbank_top.scala 117:11]
  assign clk_log = u_clkgate_log_gclk_o; // @[fbank_top.scala 118:11]
  assign clk_quant = u_clkgate_quant_gclk_o; // @[fbank_top.scala 119:13]
  assign filter_active = (filter_filter_start || filter_en_reg); // @[fbank_top.scala 166:17]
  assign mul1_io_din_vld = (filter_mulif_din_vld || win_mulif_din_vld); // @[fbank_top.scala 168:19]
  assign mul1_io_dinA = (filter_active ? filter_mulif_dinA : win_mulif_dinA); // @[fbank_top.scala 169:16]
  assign mul1_io_dinB = (filter_active ? filter_mulif_dinB : win_mulif_dinB); // @[fbank_top.scala 170:16]
  assign kws_start_pos = (kws_enable && (! kws_enable_regNext)); // @[BaseType.scala 305:24]
  assign filter_mulif_dout = (filter_active ? mul1_io_dout : tmp_mulif_dout); // @[fbank_top.scala 173:24]
  assign filter_mulif_dout_vld = (filter_active ? mul1_io_dout_vld : 1'b0); // @[fbank_top.scala 174:28]
  assign win_mulif_dout = ((! filter_active) ? mul1_io_dout : tmp_mulif_dout_1); // @[fbank_top.scala 182:21]
  assign win_mulif_dout_vld = ((! filter_active) ? mul1_io_dout_vld : 1'b0); // @[fbank_top.scala 183:25]
  assign pingpong_flag = win_pingpong_flag; // @[fbank_top.scala 188:20]
  assign win_active = rg_kws_fb_window_en; // @[fbank_top.scala 191:14]
  assign win_memif_rd = win_memif_rd_1; // @[fbank_top.scala 194:13]
  assign win_memif_wr = win_memif_wr_1; // @[fbank_top.scala 194:13]
  assign win_memif_addr = win_memif_addr_1; // @[fbank_top.scala 194:13]
  assign win_memif_wdata = win_memif_wdata_1; // @[fbank_top.scala 194:13]
  assign energy_vad_frame_end = (pingpong_flag ^ pingpong_flag_regNext); // @[fbank_top.scala 201:27]
  assign fft_start = ((((vad_finish && energy_vad_vad_flag) && rg_kws_fb_fbank_en) && (! rg_kws_fb_debug_rx_en)) && (! debug_nn)); // @[fbank_top.scala 222:16]
  assign fft_active = fft_cken_enable_out; // @[fbank_top.scala 227:14]
  assign pow_active = pow_cken_enable_out; // @[fbank_top.scala 234:14]
  assign mel_active = mel_cken_enable_out; // @[fbank_top.scala 241:14]
  assign log_active = log_cken_enable_out; // @[fbank_top.scala 248:14]
  assign quant_start_time = (win_win_addr == 8'hc0); // @[BaseType.scala 305:24]
  assign quant_start = ((! quant_wait_flag) && quant_wait_flag_regNext); // @[fbank_top.scala 258:18]
  assign quant_active = quant_cken_enable_out; // @[fbank_top.scala 263:16]
  assign fbank_finish = quant_finish; // @[fbank_top.scala 265:19]
  assign pcm_mb2_addr = combine_memif_addr; // @[fbank_top.scala 272:19]
  assign pcm_mb2_wr = combine_memif_wr; // @[fbank_top.scala 273:17]
  assign pcm_mb2_rd = combine_memif_rd; // @[fbank_top.scala 274:17]
  assign pcm_mb2_wdata = combine_memif_wdata[15 : 0]; // @[fbank_top.scala 275:20]
  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb1_rd = win_memif_rd; // @[fbank_top.scala 277:16]
    end else begin
      pcm_mb1_rd = combine_memif_rd; // @[fbank_top.scala 287:19]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb1_wr = win_memif_wr; // @[fbank_top.scala 277:16]
    end else begin
      pcm_mb1_wr = combine_memif_wr; // @[fbank_top.scala 286:19]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb1_addr = win_memif_addr; // @[fbank_top.scala 277:16]
    end else begin
      pcm_mb1_addr = combine_memif_addr; // @[fbank_top.scala 285:21]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb1_wdata = win_memif_wdata; // @[fbank_top.scala 277:16]
    end else begin
      pcm_mb1_wdata = combine_memif_wdata[31 : 16]; // @[fbank_top.scala 288:22]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      win_memif_rdata = pcm_mb1_rdata; // @[fbank_top.scala 277:16]
    end else begin
      win_memif_rdata = pcm_mb0_rdata; // @[fbank_top.scala 284:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb0_addr = combine_memif_addr; // @[fbank_top.scala 278:21]
    end else begin
      pcm_mb0_addr = win_memif_addr; // @[fbank_top.scala 284:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb0_wr = combine_memif_wr; // @[fbank_top.scala 279:19]
    end else begin
      pcm_mb0_wr = win_memif_wr; // @[fbank_top.scala 284:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb0_rd = combine_memif_rd; // @[fbank_top.scala 280:19]
    end else begin
      pcm_mb0_rd = win_memif_rd; // @[fbank_top.scala 284:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_mb0_wdata = combine_memif_wdata[31 : 16]; // @[fbank_top.scala 281:22]
    end else begin
      pcm_mb0_wdata = win_memif_wdata; // @[fbank_top.scala 284:16]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      combine_memif_rdata = {pcm_mb0_rdata,pcm_mb2_rdata}; // @[fbank_top.scala 282:25]
    end else begin
      combine_memif_rdata = {pcm_mb1_rdata,pcm_mb2_rdata}; // @[fbank_top.scala 289:25]
    end
  end

  always @(*) begin
    combine_memif_rd = 1'b0; // @[fbank_top.scala 292:20]
    if(fft_active) begin
      combine_memif_rd = fft_memif_rd; // @[fbank_top.scala 319:19]
    end else begin
      if(pow_active) begin
        combine_memif_rd = pow_memif_rd; // @[fbank_top.scala 326:19]
      end else begin
        if(mel_active) begin
          combine_memif_rd = mel_memif_rd; // @[fbank_top.scala 333:19]
        end else begin
          if(log_active) begin
            combine_memif_rd = log_memif_rd; // @[fbank_top.scala 340:19]
          end else begin
            if(quant_active) begin
              combine_memif_rd = quant_pcm_memif_rd; // @[fbank_top.scala 343:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    combine_memif_wr = 1'b0; // @[fbank_top.scala 293:20]
    if(fft_active) begin
      combine_memif_wr = fft_memif_wr; // @[fbank_top.scala 319:19]
    end else begin
      if(pow_active) begin
        combine_memif_wr = pow_memif_wr; // @[fbank_top.scala 326:19]
      end else begin
        if(mel_active) begin
          combine_memif_wr = mel_memif_wr; // @[fbank_top.scala 333:19]
        end else begin
          if(log_active) begin
            combine_memif_wr = log_memif_wr; // @[fbank_top.scala 340:19]
          end else begin
            if(quant_active) begin
              combine_memif_wr = quant_pcm_memif_wr; // @[fbank_top.scala 343:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    combine_memif_wdata = 32'h0; // @[fbank_top.scala 294:23]
    if(fft_active) begin
      combine_memif_wdata = fft_memif_wdata; // @[fbank_top.scala 319:19]
    end else begin
      if(pow_active) begin
        combine_memif_wdata = pow_memif_wdata; // @[fbank_top.scala 326:19]
      end else begin
        if(mel_active) begin
          combine_memif_wdata = mel_memif_wdata; // @[fbank_top.scala 333:19]
        end else begin
          if(log_active) begin
            combine_memif_wdata = log_memif_wdata; // @[fbank_top.scala 340:19]
          end else begin
            if(quant_active) begin
              combine_memif_wdata = quant_pcm_memif_wdata; // @[fbank_top.scala 343:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    combine_memif_addr = 8'h0; // @[fbank_top.scala 295:22]
    if(fft_active) begin
      combine_memif_addr = fft_memif_addr; // @[fbank_top.scala 319:19]
    end else begin
      if(pow_active) begin
        combine_memif_addr = pow_memif_addr; // @[fbank_top.scala 326:19]
      end else begin
        if(mel_active) begin
          combine_memif_addr = mel_memif_addr; // @[fbank_top.scala 333:19]
        end else begin
          if(log_active) begin
            combine_memif_addr = log_memif_addr; // @[fbank_top.scala 340:19]
          end else begin
            if(quant_active) begin
              combine_memif_addr = quant_pcm_memif_addr; // @[fbank_top.scala 343:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mul2_io_din_vld = 1'b0; // @[fbank_top.scala 297:19]
    if(fft_active) begin
      mul2_io_din_vld = fft_mulif_din_vld; // @[fbank_top.scala 320:21]
    end else begin
      if(pow_active) begin
        mul2_io_din_vld = pow_mulif_din_vld; // @[fbank_top.scala 327:21]
      end else begin
        if(mel_active) begin
          mul2_io_din_vld = mel_mulif_din_vld; // @[fbank_top.scala 334:21]
        end else begin
          if(!log_active) begin
            if(quant_active) begin
              mul2_io_din_vld = quant_mulif_din_vld; // @[fbank_top.scala 344:21]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mul2_io_dinA = 32'h0; // @[fbank_top.scala 298:16]
    if(fft_active) begin
      mul2_io_dinA = {{16{fft_mulif_dinA[15]}}, fft_mulif_dinA}; // @[fbank_top.scala 321:18]
    end else begin
      if(pow_active) begin
        mul2_io_dinA = {{16{pow_mulif_dinA[15]}}, pow_mulif_dinA}; // @[fbank_top.scala 328:18]
      end else begin
        if(mel_active) begin
          mul2_io_dinA = mel_mulif_dinA; // @[fbank_top.scala 335:18]
        end else begin
          if(!log_active) begin
            if(quant_active) begin
              mul2_io_dinA = quant_mulif_dinA; // @[fbank_top.scala 345:18]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mul2_io_dinB = 16'h0; // @[fbank_top.scala 299:16]
    if(fft_active) begin
      mul2_io_dinB = fft_mulif_dinB; // @[fbank_top.scala 322:18]
    end else begin
      if(pow_active) begin
        mul2_io_dinB = pow_mulif_dinB; // @[fbank_top.scala 329:18]
      end else begin
        if(mel_active) begin
          mul2_io_dinB = mel_mulif_dinB; // @[fbank_top.scala 336:18]
        end else begin
          if(!log_active) begin
            if(quant_active) begin
              mul2_io_dinB = quant_mulif_dinB; // @[fbank_top.scala 346:18]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    fft_memif_rdata = 32'h0; // @[fbank_top.scala 301:22]
    if(fft_active) begin
      fft_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 319:19]
    end
  end

  always @(*) begin
    fft_mulif_dout = 32'h0; // @[fbank_top.scala 302:21]
    if(fft_active) begin
      fft_mulif_dout = mul2_io_dout[31:0]; // @[fbank_top.scala 323:23]
    end
  end

  always @(*) begin
    fft_mulif_dout_vld = 1'b0; // @[fbank_top.scala 303:25]
    if(fft_active) begin
      fft_mulif_dout_vld = mul2_io_dout_vld; // @[fbank_top.scala 324:27]
    end
  end

  always @(*) begin
    pow_memif_rdata = 32'h0; // @[fbank_top.scala 305:22]
    if(!fft_active) begin
      if(pow_active) begin
        pow_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 326:19]
      end
    end
  end

  always @(*) begin
    pow_mulif_dout = 32'h0; // @[fbank_top.scala 306:21]
    if(!fft_active) begin
      if(pow_active) begin
        pow_mulif_dout = mul2_io_dout[31:0]; // @[fbank_top.scala 330:23]
      end
    end
  end

  always @(*) begin
    pow_mulif_dout_vld = 1'b0; // @[fbank_top.scala 307:25]
    if(!fft_active) begin
      if(pow_active) begin
        pow_mulif_dout_vld = mul2_io_dout_vld; // @[fbank_top.scala 331:27]
      end
    end
  end

  always @(*) begin
    mel_memif_rdata = 32'h0; // @[fbank_top.scala 309:22]
    if(!fft_active) begin
      if(!pow_active) begin
        if(mel_active) begin
          mel_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 333:19]
        end
      end
    end
  end

  always @(*) begin
    mel_mulif_dout = 48'h0; // @[fbank_top.scala 310:21]
    if(!fft_active) begin
      if(!pow_active) begin
        if(mel_active) begin
          mel_mulif_dout = mul2_io_dout; // @[fbank_top.scala 337:23]
        end
      end
    end
  end

  always @(*) begin
    mel_mulif_dout_vld = 1'b0; // @[fbank_top.scala 311:25]
    if(!fft_active) begin
      if(!pow_active) begin
        if(mel_active) begin
          mel_mulif_dout_vld = mul2_io_dout_vld; // @[fbank_top.scala 338:27]
        end
      end
    end
  end

  always @(*) begin
    log_memif_rdata = 32'h0; // @[fbank_top.scala 313:22]
    if(!fft_active) begin
      if(!pow_active) begin
        if(!mel_active) begin
          if(log_active) begin
            log_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 340:19]
          end
        end
      end
    end
  end

  always @(*) begin
    quant_pcm_memif_rdata = 32'h0; // @[fbank_top.scala 315:28]
    if(!fft_active) begin
      if(!pow_active) begin
        if(!mel_active) begin
          if(!log_active) begin
            if(quant_active) begin
              quant_pcm_memif_rdata = combine_memif_rdata; // @[fbank_top.scala 343:19]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    quant_mulif_dout = 48'h0; // @[fbank_top.scala 316:23]
    if(!fft_active) begin
      if(!pow_active) begin
        if(!mel_active) begin
          if(!log_active) begin
            if(quant_active) begin
              quant_mulif_dout = mul2_io_dout; // @[fbank_top.scala 347:25]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    quant_mulif_dout_vld = 1'b0; // @[fbank_top.scala 317:27]
    if(!fft_active) begin
      if(!pow_active) begin
        if(!mel_active) begin
          if(!log_active) begin
            if(quant_active) begin
              quant_mulif_dout_vld = mul2_io_dout_vld; // @[fbank_top.scala 348:29]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    lmfb_mem_rd = 1'b0; // @[fbank_top.scala 351:18]
    if(quant_active) begin
      lmfb_mem_rd = quant_lmfb_memif_rd; // @[fbank_top.scala 358:17]
    end
  end

  always @(*) begin
    lmfb_mem_wr = 1'b0; // @[fbank_top.scala 352:18]
    if(quant_active) begin
      lmfb_mem_wr = quant_lmfb_memif_wr; // @[fbank_top.scala 358:17]
    end
  end

  always @(*) begin
    lmfb_mem_wdata = 128'h0; // @[fbank_top.scala 353:21]
    if(quant_active) begin
      lmfb_mem_wdata = quant_lmfb_memif_wdata; // @[fbank_top.scala 358:17]
    end
  end

  always @(*) begin
    lmfb_mem_addr = 7'h0; // @[fbank_top.scala 354:20]
    if(quant_active) begin
      lmfb_mem_addr = quant_lmfb_memif_addr; // @[fbank_top.scala 358:17]
    end
  end

  always @(*) begin
    quant_lmfb_memif_rdata = 128'h0; // @[fbank_top.scala 356:29]
    if(quant_active) begin
      quant_lmfb_memif_rdata = lmfb_mem_rdata; // @[fbank_top.scala 358:17]
    end
  end

  assign lmfb_write_addr = quant_lmfb_write_addr; // @[fbank_top.scala 362:22]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      filter_en_reg <= 1'b0; // @[Data.scala 400:33]
      vad_finish <= 1'b0; // @[Data.scala 400:33]
      toplevel_fft_finish_regNext <= 1'b0; // @[Data.scala 400:33]
      toplevel_pow_finish_regNext <= 1'b0; // @[Data.scala 400:33]
      toplevel_mel_finish_regNext <= 1'b0; // @[Data.scala 400:33]
      quant_wait_flag <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(filter_filter_start) begin
        filter_en_reg <= 1'b1; // @[fbank_top.scala 162:19]
      end else begin
        if(filter_filter_finish) begin
          filter_en_reg <= 1'b0; // @[fbank_top.scala 164:19]
        end
      end
      vad_finish <= (pingpong_flag ^ pingpong_flag_regNext_1); // @[Reg.scala 39:30]
      toplevel_fft_finish_regNext <= fft_finish; // @[Reg.scala 39:30]
      toplevel_pow_finish_regNext <= pow_finish; // @[Reg.scala 39:30]
      toplevel_mel_finish_regNext <= mel_finish; // @[Reg.scala 39:30]
      if(log_finish) begin
        quant_wait_flag <= 1'b1; // @[fbank_top.scala 254:21]
      end else begin
        if(quant_start_time) begin
          quant_wait_flag <= 1'b0; // @[fbank_top.scala 256:21]
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

//ck_enable_gen_4 replaced by ck_enable_gen_4

//ck_enable_gen_4 replaced by ck_enable_gen_4

//ck_enable_gen_4 replaced by ck_enable_gen_4

//ck_enable_gen_4 replaced by ck_enable_gen_4

module ck_enable_gen_4 (
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
  input               clk_quant,
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
  `ifndef SYNTHESIS
  reg [71:0] next_state_string;
  reg [71:0] curr_state_string;
  `endif


  assign tmp_lmfb_uint8_out = (shifted_fbank + tmp_lmfb_uint8_out_1);
  assign tmp_lmfb_uint8_out_1 = {16'd0, rg_fbank_quant_zerpoint};
  assign tmp_mulif_dinA_1 = rg_fbank_quant_scale;
  assign tmp_mulif_dinA = {16'd0, tmp_mulif_dinA_1};
  assign tmp_mulif_dinB = pcm_memif_rdata;
  Round2Even rdeven (
    .din  (unclamped_fbank[32:0]), //i
    .dout (rdeven_dout[23:0]    )  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE     ";
      LOADDATA : next_state_string = "LOADDATA ";
      QUANTMUL : next_state_string = "QUANTMUL ";
      STOREDATA : next_state_string = "STOREDATA";
      default : next_state_string = "?????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE     ";
      LOADDATA : curr_state_string = "LOADDATA ";
      QUANTMUL : curr_state_string = "QUANTMUL ";
      STOREDATA : curr_state_string = "STOREDATA";
      default : curr_state_string = "?????????";
    endcase
  end
  `endif

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

  always @(posedge clk_quant or negedge resetn) begin
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
  input               clk_log,
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
  wire       [26:0]   tmp_xi_2;
  wire       [26:0]   tmp_xi_3;
  wire       [3:0]    tmp_tmp_yi;
  wire       [26:0]   tmp_yi_1;
  wire       [26:0]   tmp_yi_2;
  wire       [26:0]   tmp_xi_4;
  wire       [26:0]   tmp_yi_3;
  reg        [15:0]   tmp_ei;
  wire       [19:0]   tmp_tmp_z_reg;
  wire       [19:0]   tmp_tmp_z_reg_1;
  wire       [19:0]   tmp_tmp_z_reg_2;
  wire       [20:0]   tmp_tmp_z_reg_1_1;
  wire       [20:0]   tmp_tmp_z_reg_1_2;
  wire       [1:0]    tmp_when_3;
  wire       [0:0]    tmp_when_4;
  wire       [26:0]   tmp_tmp_x_reg;
  wire       [26:0]   tmp_tmp_x_reg_1;
  wire       [26:0]   tmp_tmp_x_reg_2;
  wire       [27:0]   tmp_tmp_x_reg_1_1;
  wire       [26:0]   tmp_tmp_x_reg_1_2;
  wire       [27:0]   tmp_tmp_x_reg_1_3;
  wire       [2:0]    tmp_when_5;
  wire       [1:0]    tmp_when_6;
  wire       [26:0]   tmp_tmp_y_reg;
  wire       [26:0]   tmp_tmp_y_reg_1;
  wire       [26:0]   tmp_tmp_y_reg_2;
  wire       [27:0]   tmp_tmp_y_reg_1_1;
  wire       [26:0]   tmp_tmp_y_reg_1_2;
  wire       [27:0]   tmp_tmp_y_reg_1_3;
  wire       [2:0]    tmp_when_7;
  wire       [1:0]    tmp_when_8;
  wire       [25:0]   tmp_x_reg_3;
  wire       [25:0]   tmp_x_reg_4;
  wire       [25:0]   tmp_x_reg_5;
  wire       [25:0]   tmp_x_reg_6;
  wire       [25:0]   tmp_y_reg_3;
  wire       [25:0]   tmp_y_reg_4;
  wire       [25:0]   tmp_y_reg_5;
  wire       [25:0]   tmp_y_reg_6;
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
  reg        [25:0]   x_reg;
  reg        [25:0]   y_reg;
  reg        [19:0]   z_reg;
  reg        [26:0]   xi;
  reg        [26:0]   yi;
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
  wire       [25:0]   tmp_xi_1;
  wire       [25:0]   tmp_yi;
  wire       [19:0]   ei;
  wire       [19:0]   tmp_z_reg;
  wire       [20:0]   tmp_z_reg_1;
  reg        [19:0]   tmp_z_reg_2;
  wire       [26:0]   tmp_x_reg;
  wire       [27:0]   tmp_x_reg_1;
  reg        [25:0]   tmp_x_reg_2;
  wire       [26:0]   tmp_y_reg;
  wire       [27:0]   tmp_y_reg_1;
  reg        [25:0]   tmp_y_reg_2;
  wire       [7:0]    tmp_memif_addr;
  reg        [7:0]    tmp_memif_addr_1;
  wire       [7:0]    tmp_memif_addr_2;
  reg        [7:0]    tmp_memif_addr_3;
  `ifndef SYNTHESIS
  reg [71:0] next_state_string;
  reg [71:0] curr_state_string;
  `endif


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
  assign tmp_xi_2 = {x_reg[25],x_reg};
  assign tmp_xi_3 = {tmp_xi_1[25],tmp_xi_1};
  assign tmp_tmp_yi = (tmp_xi + 4'b0010);
  assign tmp_yi_1 = {y_reg[25],y_reg};
  assign tmp_yi_2 = {tmp_yi[25],tmp_yi};
  assign tmp_xi_4 = {{1{x_reg[25]}}, x_reg};
  assign tmp_yi_3 = {{1{y_reg[25]}}, y_reg};
  assign tmp_tmp_z_reg = ($signed(tmp_tmp_z_reg_1) + $signed(tmp_tmp_z_reg_2));
  assign tmp_tmp_z_reg_1 = (~ ei);
  assign tmp_tmp_z_reg_2 = 20'h00001;
  assign tmp_tmp_z_reg_1_1 = {z_reg[19],z_reg};
  assign tmp_tmp_z_reg_1_2 = {tmp_z_reg[19],tmp_z_reg};
  assign tmp_when_3 = tmp_z_reg_1[20 : 19];
  assign tmp_when_4 = tmp_z_reg_1[19 : 19];
  assign tmp_tmp_x_reg = ($signed(tmp_tmp_x_reg_1) + $signed(tmp_tmp_x_reg_2));
  assign tmp_tmp_x_reg_1 = (~ yi);
  assign tmp_tmp_x_reg_2 = 27'h0000001;
  assign tmp_tmp_x_reg_1_2 = {x_reg[25],x_reg};
  assign tmp_tmp_x_reg_1_1 = {{1{tmp_tmp_x_reg_1_2[26]}}, tmp_tmp_x_reg_1_2};
  assign tmp_tmp_x_reg_1_3 = {tmp_x_reg[26],tmp_x_reg};
  assign tmp_when_5 = tmp_x_reg_1[27 : 25];
  assign tmp_when_6 = tmp_x_reg_1[26 : 25];
  assign tmp_tmp_y_reg = ($signed(tmp_tmp_y_reg_1) + $signed(tmp_tmp_y_reg_2));
  assign tmp_tmp_y_reg_1 = (~ xi);
  assign tmp_tmp_y_reg_2 = 27'h0000001;
  assign tmp_tmp_y_reg_1_2 = {y_reg[25],y_reg};
  assign tmp_tmp_y_reg_1_1 = {{1{tmp_tmp_y_reg_1_2[26]}}, tmp_tmp_y_reg_1_2};
  assign tmp_tmp_y_reg_1_3 = {tmp_y_reg[26],tmp_y_reg};
  assign tmp_when_7 = tmp_y_reg_1[27 : 25];
  assign tmp_when_8 = tmp_y_reg_1[26 : 25];
  assign tmp_x_reg_3 = ($signed(tmp_x_reg_4) + $signed(tmp_x_reg_5));
  assign tmp_x_reg_4 = memif_rdata[25 : 0];
  assign tmp_x_reg_5 = 26'h0004000;
  assign tmp_x_reg_6 = 26'h0000010;
  assign tmp_y_reg_3 = ($signed(tmp_y_reg_4) - $signed(tmp_y_reg_5));
  assign tmp_y_reg_4 = memif_rdata[25 : 0];
  assign tmp_y_reg_5 = 26'h0004000;
  assign tmp_y_reg_6 = 26'h0000010;
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

  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE     ";
      LOADDATA : next_state_string = "LOADDATA ";
      CORDIC : next_state_string = "CORDIC   ";
      STOREDATA : next_state_string = "STOREDATA";
      default : next_state_string = "?????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE     ";
      LOADDATA : curr_state_string = "LOADDATA ";
      CORDIC : curr_state_string = "CORDIC   ";
      STOREDATA : curr_state_string = "STOREDATA";
      default : curr_state_string = "?????????";
    endcase
  end
  `endif

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
  assign di = (y_reg[25] ? 1'b1 : 1'b0); // @[Expression.scala 1420:25]
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
    xi = 27'h0; // @[cordic_ln.scala 101:6]
    if((curr_state == CORDIC)) begin
      if((cnt < 4'b0101)) begin
        xi = ($signed(tmp_xi_2) - $signed(tmp_xi_3)); // @[cordic_ln.scala 105:10]
      end else begin
        xi = ($signed(tmp_xi_4) >>> tmp_xi); // @[cordic_ln.scala 108:10]
      end
    end
  end

  always @(*) begin
    yi = 27'h0; // @[cordic_ln.scala 102:6]
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
    if(tmp_x_reg_1[27]) begin
      if((! (&tmp_when_5))) begin
        tmp_x_reg_2 = 26'h2000000; // @[SInt.scala 133:13]
      end else begin
        tmp_x_reg_2 = tmp_x_reg_1[25 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_6)) begin
        tmp_x_reg_2 = 26'h1ffffff; // @[SInt.scala 139:13]
      end else begin
        tmp_x_reg_2 = tmp_x_reg_1[25 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign tmp_y_reg = (di ? xi : tmp_tmp_y_reg); // @[Expression.scala 1420:25]
  assign tmp_y_reg_1 = ($signed(tmp_tmp_y_reg_1_1) + $signed(tmp_tmp_y_reg_1_3)); // @[BaseType.scala 299:24]
  always @(*) begin
    if(tmp_y_reg_1[27]) begin
      if((! (&tmp_when_7))) begin
        tmp_y_reg_2 = 26'h2000000; // @[SInt.scala 133:13]
      end else begin
        tmp_y_reg_2 = tmp_y_reg_1[25 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_8)) begin
        tmp_y_reg_2 = 26'h1ffffff; // @[SInt.scala 139:13]
      end else begin
        tmp_y_reg_2 = tmp_y_reg_1[25 : 0]; // @[SInt.scala 141:13]
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

  always @(posedge clk_log or negedge resetn) begin
    if(!resetn) begin
      x_reg <= 26'h0; // @[Data.scala 400:33]
      y_reg <= 26'h0; // @[Data.scala 400:33]
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
  output     [21:0]   mel_out,
  input               clk_mel,
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
  wire       [21:0]   rdsat_dout;
  wire       [3:0]    tmp_mel_len_cnt_ov;
  wire       [31:0]   tmp_din;
  wire       [31:0]   tmp_memif_wdata;
  wire       [15:0]   tmp_mulif_dinB;
  wire       [33:0]   tmp_sum_buffer;
  reg        [7:0]    mel_filter_addr;
  wire       [7:0]    mel_filter;
  reg        [4:0]    mel_index_addr;
  wire       [7:0]    mel_index;
  wire       [3:0]    mel_len;
  reg        [2:0]    next_state;
  reg        [2:0]    curr_state;
  reg        [33:0]   sum_buffer;
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
  `ifndef SYNTHESIS
  reg [87:0] next_state_string;
  reg [87:0] curr_state_string;
  `endif


  assign tmp_mel_len_cnt_ov = (mel_len - 4'b0001);
  assign tmp_din = sum_buffer[31:0];
  assign tmp_memif_wdata = {10'd0, mel_out};
  assign tmp_mulif_dinB = {8'd0, mel_filter};
  assign tmp_sum_buffer = mulif_dout[33 : 0];
  mel_rom melrom (
    .mel_filter_addr (mel_filter_addr[7:0]  ), //i
    .mel_filter      (melrom_mel_filter[7:0]), //o
    .mel_index_addr  (mel_index_addr[4:0]   ), //i
    .mel_index       (melrom_mel_index[7:0] ), //o
    .mel_len         (melrom_mel_len[3:0]   )  //o
  );
  RoundandSat_1 rdsat (
    .din  (rdsat_din[31:0] ), //i
    .dout (rdsat_dout[21:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE       ";
      FETCH_INDEX : next_state_string = "FETCH_INDEX";
      LOADMG : next_state_string = "LOADMG     ";
      MULSUM : next_state_string = "MULSUM     ";
      STOREMEL : next_state_string = "STOREMEL   ";
      default : next_state_string = "???????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE       ";
      FETCH_INDEX : curr_state_string = "FETCH_INDEX";
      LOADMG : curr_state_string = "LOADMG     ";
      MULSUM : curr_state_string = "MULSUM     ";
      STOREMEL : curr_state_string = "STOREMEL   ";
      default : curr_state_string = "???????????";
    endcase
  end
  `endif

  assign mel_filter = melrom_mel_filter; // @[mel_dot.scala 44:14]
  assign mel_index = melrom_mel_index; // @[mel_dot.scala 45:13]
  assign mel_len = melrom_mel_len; // @[mel_dot.scala 46:11]
  assign mel_filter_addr_ov = (mel_filter_addr == 8'hca); // @[BaseType.scala 305:24]
  assign mel_index_addr_ov = (mel_index_addr == 5'h1d); // @[BaseType.scala 305:24]
  assign mel_len_cnt_ov = (mel_len_cnt == tmp_mel_len_cnt_ov); // @[BaseType.scala 305:24]
  assign rdsat_din = tmp_din; // @[mel_dot.scala 72:16]
  assign mel_out = rdsat_dout[21 : 0]; // @[mel_dot.scala 73:14]
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

  always @(posedge clk_mel or negedge resetn) begin
    if(!resetn) begin
      mel_filter_addr <= 8'h0; // @[Data.scala 400:33]
      mel_index_addr <= 5'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      sum_buffer <= 34'h0; // @[Data.scala 400:33]
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
          sum_buffer <= 34'h0; // @[mel_dot.scala 118:16]
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
  output     [21:0]   mag_out,
  input               clk_pow,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam MUL1 = 2'd1;
  localparam MUL2 = 2'd2;
  localparam STORE = 2'd3;

  wire       [32:0]   rdsat_din;
  wire       [21:0]   rdsat_dout;
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
  `ifndef SYNTHESIS
  reg [39:0] next_state_string;
  reg [39:0] curr_state_string;
  `endif


  assign tmp_memif_wdata = {10'd0, mag_out};
  assign tmp_buffer_data = memif_rdata;
  assign tmp_buffer_data_1 = mulif_dout;
  assign tmp_buffer_data_3 = mulif_dout;
  assign tmp_buffer_data_2 = {1'd0, tmp_buffer_data_3};
  RoundandSat_2 rdsat (
    .din  (rdsat_din[32:0] ), //i
    .dout (rdsat_dout[21:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE ";
      MUL1 : next_state_string = "MUL1 ";
      MUL2 : next_state_string = "MUL2 ";
      STORE : next_state_string = "STORE";
      default : next_state_string = "?????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE ";
      MUL1 : curr_state_string = "MUL1 ";
      MUL2 : curr_state_string = "MUL2 ";
      STORE : curr_state_string = "STORE";
      default : curr_state_string = "?????";
    endcase
  end
  `endif

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

  always @(posedge clk_pow or negedge resetn) begin
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
  input               clk_fft,
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
  `ifndef SYNTHESIS
  reg [95:0] next_state_string;
  reg [95:0] curr_state_string;
  `endif


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
    .clk_fft          (clk_fft                     ), //i
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

  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE        ";
      LOADXQ : next_state_string = "LOADXQ      ";
      LOADXP : next_state_string = "LOADXP      ";
      WAIT_STOREYQ : next_state_string = "WAIT_STOREYQ";
      STOREYP : next_state_string = "STOREYP     ";
      default : next_state_string = "????????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE        ";
      LOADXQ : curr_state_string = "LOADXQ      ";
      LOADXP : curr_state_string = "LOADXP      ";
      WAIT_STOREYQ : curr_state_string = "WAIT_STOREYQ";
      STOREYP : curr_state_string = "STOREYP     ";
      default : curr_state_string = "????????????";
    endcase
  end
  `endif

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
  always @(posedge clk_fft or negedge resetn) begin
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
  input               clk_vad,
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
  always @(posedge clk_vad or negedge resetn) begin
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
  input               clk_win,
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
  always @(posedge clk_win or negedge resetn) begin
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
  input               clk_filter,
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
  always @(posedge clk_filter or negedge resetn) begin
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
  output     [21:0]   dout
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
  wire       [6:0]    tmp_when_3;
  wire       [5:0]    tmp_when_4;
  (* keep *) wire       [21:0]   dataOut;
  wire       [31:0]   tmp_dataOut;
  reg        [28:0]   tmp_dataOut_1;
  wire       [31:0]   tmp_dataOut_2;
  wire       [31:0]   tmp_dataOut_3;
  wire       [31:0]   tmp_dataOut_4;
  wire       [32:0]   tmp_dataOut_5;
  wire       [31:0]   tmp_dataOut_6;
  reg        [28:0]   tmp_dataOut_7;
  reg        [27:0]   tmp_dataOut_8;
  reg        [21:0]   tmp_dataOut_9;

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
  assign tmp_when_3 = tmp_dataOut_8[27 : 21];
  assign tmp_when_4 = tmp_dataOut_8[26 : 21];
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
        tmp_dataOut_9 = 22'h200000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[21 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_dataOut_9 = 22'h1fffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[21 : 0]; // @[SInt.scala 141:13]
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
  output     [21:0]   dout
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
  wire       [1:0]    tmp_when_3;
  wire       [0:0]    tmp_when_4;
  (* keep *) wire       [21:0]   dataOut;
  wire       [32:0]   tmp_dataOut;
  reg        [23:0]   tmp_dataOut_1;
  wire       [32:0]   tmp_dataOut_2;
  wire       [32:0]   tmp_dataOut_3;
  wire       [32:0]   tmp_dataOut_4;
  wire       [33:0]   tmp_dataOut_5;
  wire       [32:0]   tmp_dataOut_6;
  reg        [23:0]   tmp_dataOut_7;
  reg        [22:0]   tmp_dataOut_8;
  reg        [21:0]   tmp_dataOut_9;

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
  assign tmp_when_3 = tmp_dataOut_8[22 : 21];
  assign tmp_when_4 = tmp_dataOut_8[21 : 21];
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
        tmp_dataOut_9 = 22'h200000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[21 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_dataOut_9 = 22'h1fffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[21 : 0]; // @[SInt.scala 141:13]
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
  input               clk_fft,
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
  wire       [30:0]   tmp_adder_pinB;
  wire       [30:0]   tmp_minus_pinA;
  wire       [30:0]   tmp_adder_pinB_1;
  wire       [30:0]   tmp_minus_pinA_1;
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
  `ifndef SYNTHESIS
  reg [95:0] next_state_string;
  reg [95:0] curr_state_string;
  `endif


  assign tmp_sumbuff1 = {{2{mulif_dout[31]}}, mulif_dout};
  assign tmp_sumbuff1_1 = {{2{mulif_dout[31]}}, mulif_dout};
  assign tmp_adder_pinB = {xp_real,15'h0};
  assign tmp_minus_pinA = {xp_real,15'h0};
  assign tmp_adder_pinB_1 = {xp_imag,15'h0};
  assign tmp_minus_pinA_1 = {xp_imag,15'h0};
  RoundandSat_6 rdsat0 (
    .din  (rdsat0_din[33:0] ), //i
    .dout (rdsat0_dout[15:0])  //o
  );
  RoundandSat_6 rdsat1 (
    .din  (rdsat1_din[33:0] ), //i
    .dout (rdsat1_dout[15:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE        ";
      XQ_WN_MUL_AC : next_state_string = "XQ_WN_MUL_AC";
      XQ_WN_MUL_BD : next_state_string = "XQ_WN_MUL_BD";
      XQ_WN_MUL_AD : next_state_string = "XQ_WN_MUL_AD";
      XQ_WN_MUL_BC : next_state_string = "XQ_WN_MUL_BC";
      default : next_state_string = "????????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE        ";
      XQ_WN_MUL_AC : curr_state_string = "XQ_WN_MUL_AC";
      XQ_WN_MUL_BD : curr_state_string = "XQ_WN_MUL_BD";
      XQ_WN_MUL_AD : curr_state_string = "XQ_WN_MUL_AD";
      XQ_WN_MUL_BC : curr_state_string = "XQ_WN_MUL_BC";
      default : curr_state_string = "????????????";
    endcase
  end
  `endif

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
      adder_pinB = {{3{tmp_adder_pinB[30]}}, tmp_adder_pinB}; // @[butterfly_unit.scala 156:16]
    end
    if(MUL_END) begin
      adder_pinB = {{3{tmp_adder_pinB_1[30]}}, tmp_adder_pinB_1}; // @[butterfly_unit.scala 162:16]
    end
  end

  always @(*) begin
    minus_pinA = 34'h0; // @[butterfly_unit.scala 154:14]
    if(MUL_AD_IN) begin
      minus_pinA = {{3{tmp_minus_pinA[30]}}, tmp_minus_pinA}; // @[butterfly_unit.scala 158:16]
    end
    if(MUL_END) begin
      minus_pinA = {{3{tmp_minus_pinA_1[30]}}, tmp_minus_pinA_1}; // @[butterfly_unit.scala 164:16]
    end
  end

  assign yp_real = yp_real_reg; // @[butterfly_unit.scala 169:14]
  assign yp_imag = yp_imag_reg; // @[butterfly_unit.scala 170:14]
  assign yq_real = yq_real_reg; // @[butterfly_unit.scala 171:14]
  assign yq_imag = yq_imag_reg; // @[butterfly_unit.scala 172:14]
  always @(posedge clk_fft or negedge resetn) begin
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

//RoundandSat_6 replaced by RoundandSat_6

module RoundandSat_6 (
  input      [33:0]   din,
  output     [15:0]   dout
);

  wire       [34:0]   tmp_tmp_dataOut_5;
  wire       [34:0]   tmp_tmp_dataOut_5_1;
  wire       [14:0]   tmp_when;
  wire       [19:0]   tmp_tmp_dataOut_7;
  wire       [19:0]   tmp_tmp_dataOut_7_1;
  wire       [34:0]   tmp_tmp_dataOut_1;
  wire       [34:0]   tmp_tmp_dataOut_1_1;
  wire       [34:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  wire       [3:0]    tmp_when_3;
  wire       [2:0]    tmp_when_4;
  (* keep *) wire       [15:0]   dataOut;
  wire       [33:0]   tmp_dataOut;
  reg        [19:0]   tmp_dataOut_1;
  wire       [33:0]   tmp_dataOut_2;
  wire       [33:0]   tmp_dataOut_3;
  wire       [33:0]   tmp_dataOut_4;
  wire       [34:0]   tmp_dataOut_5;
  wire       [33:0]   tmp_dataOut_6;
  reg        [19:0]   tmp_dataOut_7;
  reg        [18:0]   tmp_dataOut_8;
  reg        [15:0]   tmp_dataOut_9;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[33],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[33],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[14 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[34 : 15];
  assign tmp_tmp_dataOut_7_1 = 20'h00001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[33],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[33],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[19 : 18];
  assign tmp_when_2 = tmp_dataOut_1[18 : 18];
  assign tmp_when_3 = tmp_dataOut_8[18 : 15];
  assign tmp_when_4 = tmp_dataOut_8[17 : 15];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{19'h0,1'b1},14'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {20'hfffff,14'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[33 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[33 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[34 : 15]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[34]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 15); // @[SInt.scala 341:11]
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

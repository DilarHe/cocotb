// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : window
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
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

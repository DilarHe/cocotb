// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : Sqrt_unsigned

`timescale 1ns/1ps 
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
      root <= 16'h0;
      rem_1 <= 16'h0;
      cnt <= 4'b0000;
      work <= 1'b0;
      datain <= 32'h0;
      work_regNext <= 1'b0;
      work_neg_regNext <= 1'b0;
      dout <= 16'h0;
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
          root <= 16'h0;
          rem_1 <= 16'h0;
        end
      end
      work_neg_regNext <= work_neg;
      if(work_neg) begin
        dout <= root;
      end
    end
  end


endmodule

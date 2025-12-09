// Generator : SpinalHDL v1.10.0    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : Tcore_top
// Git hash  : 44994dc7d529fb75451eac35831df6a792dfc304

`timescale 1ns/1ps 
module Tcore_top (
  input  wire          core_start,
  output wire          core_end,
  output wire          iram_mem_rd,
  output wire          iram_mem_wr,
  output wire [10:0]   iram_mem_addr,
  output wire [15:0]   iram_mem_wdata,
  input  wire [15:0]   iram_mem_rdata,
  output wire          dram_mem_rd,
  output wire          dram_mem_wr,
  output wire [10:0]   dram_mem_addr,
  output wire [15:0]   dram_mem_wdata,
  input  wire [15:0]   dram_mem_rdata,
  output wire [31:0]   debug_info_0,
  output wire [31:0]   debug_info_1,
  output wire [31:0]   debug_info_2,
  output wire [31:0]   debug_info_3,
  output wire [31:0]   debug_info_4,
  input  wire          clk,
  input  wire          resetn
);


  assign core_end = 1'b0;
  assign iram_mem_rd = 1'b0;
  assign iram_mem_wr = 1'b0;
  assign iram_mem_addr = 11'h000;
  assign iram_mem_wdata = 16'h0000;
  assign dram_mem_rd = 1'b0;
  assign dram_mem_wr = 1'b0;
  assign dram_mem_addr = 11'h000;
  assign dram_mem_wdata = 16'h0000;
  assign debug_info_0 = 32'h00000000;
  assign debug_info_1 = 32'h00000000;
  assign debug_info_2 = 32'h00000000;
  assign debug_info_3 = 32'h00000000;
  assign debug_info_4 = 32'h00000000;

endmodule

// Generator : SpinalHDL v1.10.0    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : clkGate_func_1
// Git hash  : 24ab56e1eab7e20ad71d6443ac1856c377d281d1

`timescale 1ns/1ps 
module ckgated4_cell (
  input  wire          scan_en,
  input  wire          enable,
  output wire          clkout,
  input  wire          clkin
);

  /* verilator lint_off LATCH */  reg                 ck_latch;

  always @(*) begin
    if((! clkin)) begin
      ck_latch = (scan_en || enable);
    end
  end

  assign clkout = (ck_latch && clkin);

endmodule

// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : clkGate_func

`timescale 1ns/1ps 
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

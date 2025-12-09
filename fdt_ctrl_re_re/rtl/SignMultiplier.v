// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : SignMultiplier

`timescale 1ns/1ps 
module SignMultiplier (
  input  wire [11:0]   dinA,
  input  wire [11:0]   dinB,
  input  wire          din_vld,
  output wire [23:0]   dout,
  output wire          dout_vld,
  input  wire          clkout,
  input  wire          rstn_80m
);

  reg        [23:0]   Result;
  wire                din_vld_1;
  reg                 dout_vld_reg;
  reg        [11:0]   dinA_reg;
  reg        [11:0]   dinB_reg;
  reg                 din_vld_regNext;

  assign din_vld_1 = din_vld_regNext;
  always @(*) begin
    Result = 24'h0;
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
      dinA_reg <= 12'h0;
      dinB_reg <= 12'h0;
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

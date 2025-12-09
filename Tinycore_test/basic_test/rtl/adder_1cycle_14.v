// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : adder_1cycle_14
// Git hash  : 31ce619fdcbb774cfe2df26d308fe4584454b941

`timescale 1ns/1ps 
module adder_1cycle_14 (
  input      [15:0]   dinA,
  input      [15:0]   dinB,
  output     [16:0]   dout
);

  wire       [16:0]   tmp_dout;
  wire       [16:0]   tmp_dout_1;

  assign tmp_dout = {dinA[15],dinA};
  assign tmp_dout_1 = {dinB[15],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1)); // @[adder_1cycle.scala 17:11]

endmodule

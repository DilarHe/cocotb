// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : adder_1cycle_6
// Git hash  : 31ce619fdcbb774cfe2df26d308fe4584454b941

`timescale 1ns/1ps 
module adder_1cycle_6 (
  input      [16:0]   dinA,
  input      [16:0]   dinB,
  output     [17:0]   dout
);

  wire       [17:0]   tmp_dout;
  wire       [17:0]   tmp_dout_1;

  assign tmp_dout = {dinA[16],dinA};
  assign tmp_dout_1 = {dinB[16],dinB};
  assign dout = ($signed(tmp_dout) + $signed(tmp_dout_1)); // @[adder_1cycle.scala 17:11]

endmodule

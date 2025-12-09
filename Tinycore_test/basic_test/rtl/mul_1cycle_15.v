// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : mul_1cycle_15
// Git hash  : 31ce619fdcbb774cfe2df26d308fe4584454b941

`timescale 1ns/1ps 
module mul_1cycle_15 (
  input      [7:0]    dinA,
  input      [7:0]    dinB,
  output     [15:0]   dout
);


  assign dout = ($signed(dinA) * $signed(dinB)); // @[mul_1cycle.scala 17:11]

endmodule

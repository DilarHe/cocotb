// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : AdderWithSub_1cycle
// Git hash  : 31ce619fdcbb774cfe2df26d308fe4584454b941

`timescale 1ns/1ps 
module AdderWithSub_1cycle (
  input               sub_en,
  input      [31:0]   dinA,
  input      [31:0]   dinB,
  output     [31:0]   dout
);

  wire       [31:0]   tmp_dinB_tmp;
  wire       [31:0]   tmp_dinB_tmp_1;
  wire       [31:0]   tmp_dinB_tmp_2;
  wire       [31:0]   dinB_tmp;

  assign tmp_dinB_tmp = ($signed(tmp_dinB_tmp_1) + $signed(tmp_dinB_tmp_2));
  assign tmp_dinB_tmp_1 = (~ dinB);
  assign tmp_dinB_tmp_2 = 32'h00000001;
  assign dinB_tmp = (sub_en ? tmp_dinB_tmp : dinB); // @[Expression.scala 1420:25]
  assign dout = ($signed(dinA) + $signed(dinB_tmp)); // @[AdderWithSub_1cycle.scala 18:11]

endmodule

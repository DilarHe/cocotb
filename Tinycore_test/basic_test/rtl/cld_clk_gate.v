// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : cld_clk_gate
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps

module cld_clk_gate (
  input               dft_mode_test_mode_i,
  input               dft_mode_scan_mode_i,
  input               dft_mode_scan_shift_i,
  input               dft_mode_mbist_mode_i,
  input               en_i,
  output              gclk_o,
  input               clk
);

  wire                u_clk_gate_leaf_gclk_o;

  cld_clk_gate_leaf u_clk_gate_leaf (
    .clk_i     (clk                   ), //i
    .test_en_i (dft_mode_scan_shift_i ), //i
    .en_i      (en_i                  ), //i
    .gclk_o    (u_clk_gate_leaf_gclk_o)  //o
  );
  assign gclk_o = u_clk_gate_leaf_gclk_o; // @[clk_gate.scala 30:13]

endmodule

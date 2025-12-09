// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : ck_enable_gen
// Git hash  : 63570bb5dcd0c418ed6221eed4fbe320fab6b9d8

`timescale 1ns/1ps

module ck_enable_gen (
  input               start,
  input               finish,
  output              enable_out,
  input               clk,
  input               resetn
);

  reg                 en_reg;

  assign enable_out = (start || en_reg); // @[ck_enable_gen.scala 24:17]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      en_reg <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(start) begin
        en_reg <= 1'b1; // @[ck_enable_gen.scala 20:12]
      end else begin
        if(finish) begin
          en_reg <= 1'b0; // @[ck_enable_gen.scala 22:12]
        end
      end
    end
  end


endmodule

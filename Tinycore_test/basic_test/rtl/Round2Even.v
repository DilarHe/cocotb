// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : Round2Even
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module Round2Even (
  input      [32:0]   din,
  output     [23:0]   dout
);

  wire       [33:0]   tmp_tmp_dout_4;
  wire       [33:0]   tmp_tmp_dout_4_1;
  wire       [9:0]    tmp_when;
  wire       [23:0]   tmp_tmp_dout_5;
  wire       [23:0]   tmp_tmp_dout_5_1;
  wire       [31:0]   tmp_tmp_dout_6;
  wire       [32:0]   tmp_tmp_dout_6_1;
  wire       [22:0]   tmp_tmp_dout_7;
  wire       [1:0]    tmp_tmp_dout_7_1;
  wire       [21:0]   tmp_tmp_dout_7_2;
  wire       [24:0]   tmp_tmp_dout;
  wire       [24:0]   tmp_tmp_dout_1;
  wire       [24:0]   tmp_tmp_dout_2;
  reg        [23:0]   tmp_dout;
  reg        [23:0]   tmp_dout_1;
  wire       [32:0]   tmp_dout_2;
  wire       [32:0]   tmp_dout_3;
  wire       [33:0]   tmp_dout_4;
  reg        [23:0]   tmp_dout_5;
  wire       [31:0]   tmp_dout_6;
  reg        [22:0]   tmp_dout_7;
  wire       [23:0]   tmp_dout_8;
  wire       [23:0]   tmp_dout_9;

  assign tmp_tmp_dout_4 = {tmp_dout_3[32],tmp_dout_3};
  assign tmp_tmp_dout_4_1 = {tmp_dout_2[32],tmp_dout_2};
  assign tmp_when = tmp_dout_4[9 : 0];
  assign tmp_tmp_dout_5 = tmp_dout_4[33 : 10];
  assign tmp_tmp_dout_5_1 = 24'h000001;
  assign tmp_tmp_dout_6_1 = tmp_dout_4[32 : 0];
  assign tmp_tmp_dout_6 = tmp_tmp_dout_6_1[31 : 0];
  assign tmp_tmp_dout_7_1 = {1'b0,1'b1};
  assign tmp_tmp_dout_7 = {21'd0, tmp_tmp_dout_7_1};
  assign tmp_tmp_dout_7_2 = tmp_dout_6[31 : 10];
  assign tmp_tmp_dout = ($signed(tmp_tmp_dout_1) + $signed(tmp_tmp_dout_2));
  assign tmp_tmp_dout_1 = {tmp_dout_9[23],tmp_dout_9};
  assign tmp_tmp_dout_2 = {tmp_dout_8[23],tmp_dout_8};
  assign tmp_dout_2 = {24'hffffff,9'h0}; // @[BaseType.scala 318:22]
  assign tmp_dout_3 = din[32 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dout_4 = ($signed(tmp_tmp_dout_4) + $signed(tmp_tmp_dout_4_1)); // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dout_5 = ($signed(tmp_tmp_dout_5) + $signed(tmp_tmp_dout_5_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dout_5 = tmp_dout_4[33 : 10]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dout_4[33]) begin
      tmp_dout_1 = tmp_dout_5; // @[SInt.scala 286:11]
    end else begin
      tmp_dout_1 = {1'b0,tmp_dout_7}; // @[SInt.scala 288:11]
    end
  end

  assign tmp_dout_6 = tmp_tmp_dout_6; // @[BaseType.scala 318:22]
  always @(*) begin
    if((|tmp_dout_6[9 : 0])) begin
      tmp_dout_7 = ({1'b0,tmp_dout_6[31 : 10]} + tmp_tmp_dout_7); // @[UInt.scala 171:11]
    end else begin
      tmp_dout_7 = {1'd0, tmp_tmp_dout_7_2}; // @[UInt.scala 173:11]
    end
  end

  always @(*) begin
    if((! din[10])) begin
      tmp_dout = tmp_dout_1; // @[SInt.scala 358:11]
    end else begin
      tmp_dout = (tmp_tmp_dout >>> 1); // @[SInt.scala 360:11]
    end
  end

  assign tmp_dout_8 = {23'h0,1'b1}; // @[BaseType.scala 318:22]
  assign tmp_dout_9 = din[32 : 9]; // @[BaseType.scala 299:24]
  assign dout = tmp_dout; // @[Round2Even.scala 13:11]

endmodule

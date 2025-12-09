// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : RoundandSat_1
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module RoundandSat_1 (
  input      [31:0]   din,
  output     [21:0]   dout
);

  wire       [32:0]   tmp_tmp_dataOut_5;
  wire       [32:0]   tmp_tmp_dataOut_5_1;
  wire       [3:0]    tmp_when;
  wire       [28:0]   tmp_tmp_dataOut_7;
  wire       [28:0]   tmp_tmp_dataOut_7_1;
  wire       [32:0]   tmp_tmp_dataOut_1;
  wire       [32:0]   tmp_tmp_dataOut_1_1;
  wire       [32:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  wire       [6:0]    tmp_when_3;
  wire       [5:0]    tmp_when_4;
  (* keep *) wire       [21:0]   dataOut;
  wire       [31:0]   tmp_dataOut;
  reg        [28:0]   tmp_dataOut_1;
  wire       [31:0]   tmp_dataOut_2;
  wire       [31:0]   tmp_dataOut_3;
  wire       [31:0]   tmp_dataOut_4;
  wire       [32:0]   tmp_dataOut_5;
  wire       [31:0]   tmp_dataOut_6;
  reg        [28:0]   tmp_dataOut_7;
  reg        [27:0]   tmp_dataOut_8;
  reg        [21:0]   tmp_dataOut_9;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[31],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[31],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[3 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[32 : 4];
  assign tmp_tmp_dataOut_7_1 = 29'h00000001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[31],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[31],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[28 : 27];
  assign tmp_when_2 = tmp_dataOut_1[27 : 27];
  assign tmp_when_3 = tmp_dataOut_8[27 : 21];
  assign tmp_when_4 = tmp_dataOut_8[26 : 21];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{28'h0,1'b1},3'b000}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {29'h1fffffff,3'b000}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[31 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[31 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[32 : 4]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[32]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 4); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_1[28]) begin
      if((! (&tmp_when_1))) begin
        tmp_dataOut_8 = 28'h8000000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[27 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_dataOut_8 = 28'h7ffffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[27 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    if(tmp_dataOut_8[27]) begin
      if((! (&tmp_when_3))) begin
        tmp_dataOut_9 = 22'h200000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[21 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_dataOut_9 = 22'h1fffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[21 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign dataOut = tmp_dataOut_9; // @[RoundandSat.scala 22:13]
  assign dout = dataOut; // @[RoundandSat.scala 26:11]

endmodule

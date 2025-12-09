// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : RoundandSat_2
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module RoundandSat_2 (
  input      [32:0]   din,
  output     [21:0]   dout
);

  wire       [33:0]   tmp_tmp_dataOut_5;
  wire       [33:0]   tmp_tmp_dataOut_5_1;
  wire       [9:0]    tmp_when;
  wire       [23:0]   tmp_tmp_dataOut_7;
  wire       [23:0]   tmp_tmp_dataOut_7_1;
  wire       [33:0]   tmp_tmp_dataOut_1;
  wire       [33:0]   tmp_tmp_dataOut_1_1;
  wire       [33:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  wire       [1:0]    tmp_when_3;
  wire       [0:0]    tmp_when_4;
  (* keep *) wire       [21:0]   dataOut;
  wire       [32:0]   tmp_dataOut;
  reg        [23:0]   tmp_dataOut_1;
  wire       [32:0]   tmp_dataOut_2;
  wire       [32:0]   tmp_dataOut_3;
  wire       [32:0]   tmp_dataOut_4;
  wire       [33:0]   tmp_dataOut_5;
  wire       [32:0]   tmp_dataOut_6;
  reg        [23:0]   tmp_dataOut_7;
  reg        [22:0]   tmp_dataOut_8;
  reg        [21:0]   tmp_dataOut_9;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[32],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[32],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[9 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[33 : 10];
  assign tmp_tmp_dataOut_7_1 = 24'h000001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[32],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[32],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[23 : 22];
  assign tmp_when_2 = tmp_dataOut_1[22 : 22];
  assign tmp_when_3 = tmp_dataOut_8[22 : 21];
  assign tmp_when_4 = tmp_dataOut_8[21 : 21];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{23'h0,1'b1},9'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {24'hffffff,9'h0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[32 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[32 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[33 : 10]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[33]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 10); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_1[23]) begin
      if((! (&tmp_when_1))) begin
        tmp_dataOut_8 = 23'h400000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[22 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_dataOut_8 = 23'h3fffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[22 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    if(tmp_dataOut_8[22]) begin
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

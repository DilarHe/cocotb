// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : RoundandSat
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module RoundandSat (
  input      [20:0]   din,
  output     [15:0]   dout
);

  wire       [21:0]   tmp_tmp_dataOut_5;
  wire       [21:0]   tmp_tmp_dataOut_5_1;
  wire       [1:0]    tmp_when;
  wire       [19:0]   tmp_tmp_dataOut_7;
  wire       [19:0]   tmp_tmp_dataOut_7_1;
  wire       [21:0]   tmp_tmp_dataOut_1;
  wire       [21:0]   tmp_tmp_dataOut_1_1;
  wire       [21:0]   tmp_tmp_dataOut_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  wire       [3:0]    tmp_when_3;
  wire       [2:0]    tmp_when_4;
  (* keep *) wire       [15:0]   dataOut;
  wire       [20:0]   tmp_dataOut;
  reg        [19:0]   tmp_dataOut_1;
  wire       [20:0]   tmp_dataOut_2;
  wire       [20:0]   tmp_dataOut_3;
  wire       [20:0]   tmp_dataOut_4;
  wire       [21:0]   tmp_dataOut_5;
  wire       [20:0]   tmp_dataOut_6;
  reg        [19:0]   tmp_dataOut_7;
  reg        [18:0]   tmp_dataOut_8;
  reg        [15:0]   tmp_dataOut_9;

  assign tmp_tmp_dataOut_5 = {tmp_dataOut_4[20],tmp_dataOut_4};
  assign tmp_tmp_dataOut_5_1 = {tmp_dataOut_3[20],tmp_dataOut_3};
  assign tmp_when = tmp_dataOut_5[1 : 0];
  assign tmp_tmp_dataOut_7 = tmp_dataOut_5[21 : 2];
  assign tmp_tmp_dataOut_7_1 = 20'h00001;
  assign tmp_tmp_dataOut_1 = ($signed(tmp_tmp_dataOut_1_1) + $signed(tmp_tmp_dataOut_1_2));
  assign tmp_tmp_dataOut_1_1 = {tmp_dataOut_6[20],tmp_dataOut_6};
  assign tmp_tmp_dataOut_1_2 = {tmp_dataOut_2[20],tmp_dataOut_2};
  assign tmp_when_1 = tmp_dataOut_1[19 : 18];
  assign tmp_when_2 = tmp_dataOut_1[18 : 18];
  assign tmp_when_3 = tmp_dataOut_8[18 : 15];
  assign tmp_when_4 = tmp_dataOut_8[17 : 15];
  assign tmp_dataOut = din; // @[BaseType.scala 318:22]
  assign tmp_dataOut_2 = {{19'h0,1'b1},1'b0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_3 = {20'hfffff,1'b0}; // @[BaseType.scala 318:22]
  assign tmp_dataOut_4 = tmp_dataOut[20 : 0]; // @[BaseType.scala 299:24]
  assign tmp_dataOut_5 = ($signed(tmp_tmp_dataOut_5) + $signed(tmp_tmp_dataOut_5_1)); // @[BaseType.scala 299:24]
  assign tmp_dataOut_6 = tmp_dataOut[20 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_dataOut_7 = ($signed(tmp_tmp_dataOut_7) + $signed(tmp_tmp_dataOut_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_dataOut_7 = tmp_dataOut_5[21 : 2]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_5[21]) begin
      tmp_dataOut_1 = tmp_dataOut_7; // @[SInt.scala 339:11]
    end else begin
      tmp_dataOut_1 = (tmp_tmp_dataOut_1 >>> 2); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_dataOut_1[19]) begin
      if((! (&tmp_when_1))) begin
        tmp_dataOut_8 = 19'h40000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[18 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        tmp_dataOut_8 = 19'h3ffff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_8 = tmp_dataOut_1[18 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    if(tmp_dataOut_8[18]) begin
      if((! (&tmp_when_3))) begin
        tmp_dataOut_9 = 16'h8000; // @[SInt.scala 133:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[15 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_dataOut_9 = 16'h7fff; // @[SInt.scala 139:13]
      end else begin
        tmp_dataOut_9 = tmp_dataOut_8[15 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign dataOut = tmp_dataOut_9; // @[RoundandSat.scala 22:13]
  assign dout = dataOut; // @[RoundandSat.scala 26:11]

endmodule

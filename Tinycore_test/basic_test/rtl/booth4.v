// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : booth4
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module booth4 (
  input               io_din_vld,
  input      [31:0]   io_dinA,
  input      [15:0]   io_dinB,
  output              io_dout_vld,
  output              io_cal_finish,
  output     [47:0]   io_dout,
  input               clk,
  input               resetn
);

  wire       [50:0]   tmp_aftershift;
  wire       [50:0]   tmp_aftershift_1;
  reg        [15:0]   Breg;
  reg        [50:0]   shiftReg;
  wire       [2:0]    flag_bits;
  wire       [17:0]   NegativeB;
  wire       [17:0]   Negative2B;
  wire       [17:0]   PositiveB;
  wire       [17:0]   Positive2B;
  wire       [17:0]   AddB;
  wire       [17:0]   Add2B;
  wire       [17:0]   MinusB;
  wire       [17:0]   Minus2B;
  reg        [3:0]    cal_cnt;
  reg                 cal_en;
  wire       [32:0]   shiftReg_low;
  wire       [17:0]   shiftReg_high;
  wire                cal_cnt_ov_flag;
  reg        [17:0]   beforeshift;
  wire       [50:0]   aftershift;
  reg                 cal_en_regNext;

  assign tmp_aftershift = ($signed(tmp_aftershift_1) >>> 2);
  assign tmp_aftershift_1 = {beforeshift,shiftReg_low};
  assign flag_bits = shiftReg[2 : 0]; // @[booth4.scala 38:13]
  assign NegativeB = (- PositiveB); // @[booth4.scala 39:13]
  assign PositiveB = {{2{Breg[15]}}, Breg}; // @[booth4.scala 40:13]
  assign Negative2B = (NegativeB <<< 1); // @[booth4.scala 41:14]
  assign Positive2B = (PositiveB <<< 1); // @[booth4.scala 42:14]
  assign shiftReg_low = shiftReg[32 : 0]; // @[booth4.scala 46:16]
  assign shiftReg_high = shiftReg[50 : 33]; // @[booth4.scala 47:17]
  assign AddB = ($signed(shiftReg_high) + $signed(PositiveB)); // @[booth4.scala 49:8]
  assign Add2B = ($signed(shiftReg_high) + $signed(Positive2B)); // @[booth4.scala 50:9]
  assign MinusB = ($signed(shiftReg_high) + $signed(NegativeB)); // @[booth4.scala 51:10]
  assign Minus2B = ($signed(shiftReg_high) + $signed(Negative2B)); // @[booth4.scala 52:11]
  assign cal_cnt_ov_flag = (cal_cnt == 4'b1111); // @[BaseType.scala 305:24]
  assign io_cal_finish = (cal_cnt_ov_flag && cal_en); // @[booth4.scala 55:17]
  always @(*) begin
    case(flag_bits)
      3'b000, 3'b111 : begin
        beforeshift = shiftReg_high; // @[booth4.scala 71:19]
      end
      3'b001, 3'b010 : begin
        beforeshift = AddB; // @[booth4.scala 74:20]
      end
      3'b101, 3'b110 : begin
        beforeshift = MinusB; // @[booth4.scala 77:20]
      end
      3'b011 : begin
        beforeshift = Add2B; // @[booth4.scala 80:20]
      end
      default : begin
        beforeshift = Minus2B; // @[booth4.scala 83:20]
      end
    endcase
  end

  assign aftershift = tmp_aftershift; // @[booth4.scala 86:14]
  assign io_dout_vld = ((! cal_en) && cal_en_regNext); // @[booth4.scala 99:15]
  assign io_dout = shiftReg[48 : 1]; // @[booth4.scala 100:11]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      Breg <= 16'h0; // @[Data.scala 400:33]
      shiftReg <= 51'h0; // @[Data.scala 400:33]
      cal_cnt <= 4'b0000; // @[Data.scala 400:33]
      cal_en <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(io_din_vld) begin
        cal_en <= 1'b1; // @[booth4.scala 58:12]
      end else begin
        if(cal_cnt_ov_flag) begin
          cal_en <= 1'b0; // @[booth4.scala 60:12]
        end
      end
      if(cal_en) begin
        cal_cnt <= (cal_cnt + 4'b0001); // @[booth4.scala 63:13]
      end else begin
        if(io_din_vld) begin
          cal_cnt <= 4'b0000; // @[booth4.scala 65:13]
        end
      end
      if(io_din_vld) begin
        shiftReg <= {{18'h0,io_dinA},1'b0}; // @[booth4.scala 93:14]
        Breg <= io_dinB; // @[booth4.scala 94:14]
      end else begin
        if(cal_en) begin
          shiftReg <= aftershift; // @[booth4.scala 96:14]
        end
      end
    end
  end

  always @(posedge clk) begin
    cal_en_regNext <= cal_en; // @[Reg.scala 39:30]
  end


endmodule

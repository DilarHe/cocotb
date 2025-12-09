// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : restoring_div_radix4
// Git hash  : 31ce619fdcbb774cfe2df26d308fe4584454b941

`timescale 1ns/1ps 
module restoring_div_radix4 (
  input               din_vld,
  input      [15:0]   dinA,
  input      [7:0]    dinB,
  output              dout_vld,
  output     [16:0]   quot,
  output     [7:0]    remainder,
  input               clk,
  input               resetn
);

  wire       [15:0]   tmp_dinA_abs;
  wire       [15:0]   tmp_dinA_abs_1;
  wire       [15:0]   tmp_dinA_abs_2;
  wire       [0:0]    tmp_dinA_abs_3;
  wire       [7:0]    tmp_dinB_abs;
  wire       [7:0]    tmp_dinB_abs_1;
  wire       [7:0]    tmp_dinB_abs_2;
  wire       [0:0]    tmp_dinB_abs_3;
  wire       [7:0]    tmp_divisior;
  wire       [9:0]    tmp_p_r_minus_d;
  wire       [9:0]    tmp_p_r_minus_d_1;
  wire       [9:0]    tmp_p_r_minus_d_2;
  wire       [9:0]    tmp_p_r_minus_2d;
  wire       [9:0]    tmp_p_r_minus_2d_1;
  wire       [9:0]    tmp_p_r_minus_2d_2;
  wire       [9:0]    tmp_p_r_minus_2d_3;
  wire       [9:0]    tmp_p_r_minus_3d;
  wire       [9:0]    tmp_p_r_minus_3d_1;
  wire       [9:0]    tmp_p_r_minus_3d_2;
  wire       [9:0]    tmp_p_r_minus_3d_3;
  wire       [7:0]    tmp_remainder;
  wire       [7:0]    tmp_remainder_1;
  wire       [7:0]    tmp_remainder_2;
  wire       [16:0]   tmp_quot;
  wire       [15:0]   tmp_quot_1;
  wire       [16:0]   tmp_quot_2;
  wire                sign_out;
  wire       [15:0]   dinA_abs;
  wire       [7:0]    dinB_abs;
  reg        [15:0]   quotient;
  reg        [9:0]    divisior;
  reg        [25:0]   p_remainder;
  wire       [25:0]   p_r_shift;
  wire       [9:0]    p_r_calpart;
  wire       [9:0]    p_r_minus_d;
  wire       [9:0]    p_r_minus_2d;
  wire       [9:0]    p_r_minus_3d;
  reg        [9:0]    p_r_part_next;
  wire       [2:0]    deside_bits;
  reg        [1:0]    quot_updata_bits;
  reg        [2:0]    control_cnt;
  reg                 doing;
  wire                finish_pulse;
  wire       [7:0]    remainder_abs;
  reg                 finish_pulse_regNext;

  assign tmp_dinA_abs = (dinA[15] ? tmp_dinA_abs_1 : dinA);
  assign tmp_dinA_abs_1 = (~ dinA);
  assign tmp_dinA_abs_3 = dinA[15];
  assign tmp_dinA_abs_2 = {15'd0, tmp_dinA_abs_3};
  assign tmp_dinB_abs = (dinB[7] ? tmp_dinB_abs_1 : dinB);
  assign tmp_dinB_abs_1 = (~ dinB);
  assign tmp_dinB_abs_3 = dinB[7];
  assign tmp_dinB_abs_2 = {7'd0, tmp_dinB_abs_3};
  assign tmp_divisior = dinB_abs;
  assign tmp_p_r_minus_d = ($signed(tmp_p_r_minus_d_1) - $signed(tmp_p_r_minus_d_2));
  assign tmp_p_r_minus_d_1 = p_r_calpart;
  assign tmp_p_r_minus_d_2 = divisior;
  assign tmp_p_r_minus_2d = ($signed(tmp_p_r_minus_2d_1) - $signed(tmp_p_r_minus_2d_2));
  assign tmp_p_r_minus_2d_1 = p_r_calpart;
  assign tmp_p_r_minus_2d_2 = (tmp_p_r_minus_2d_3 <<< 1);
  assign tmp_p_r_minus_2d_3 = divisior;
  assign tmp_p_r_minus_3d = ($signed(tmp_p_r_minus_3d_1) - $signed(tmp_p_r_minus_3d_2));
  assign tmp_p_r_minus_3d_1 = p_r_minus_d;
  assign tmp_p_r_minus_3d_2 = (tmp_p_r_minus_3d_3 <<< 1);
  assign tmp_p_r_minus_3d_3 = divisior;
  assign tmp_remainder = tmp_remainder_1;
  assign tmp_remainder_1 = ((~ remainder_abs) + 8'h01);
  assign tmp_remainder_2 = remainder_abs;
  assign tmp_quot = {1'b1,tmp_quot_1};
  assign tmp_quot_1 = ((~ quotient) + 16'h0001);
  assign tmp_quot_2 = {1'b0,quotient};
  assign sign_out = (dinA[15] ^ dinB[7]); // @[restoring_div_radix4.scala 21:11]
  assign dinA_abs = (tmp_dinA_abs + tmp_dinA_abs_2); // @[restoring_div_radix4.scala 24:11]
  assign dinB_abs = (tmp_dinB_abs + tmp_dinB_abs_2); // @[restoring_div_radix4.scala 25:11]
  assign p_r_shift = (p_remainder <<< 2); // @[BaseType.scala 299:24]
  assign p_r_calpart = p_r_shift[25 : 16]; // @[restoring_div_radix4.scala 47:13]
  assign p_r_minus_d = tmp_p_r_minus_d; // @[restoring_div_radix4.scala 48:13]
  assign p_r_minus_2d = tmp_p_r_minus_2d; // @[restoring_div_radix4.scala 49:14]
  assign p_r_minus_3d = tmp_p_r_minus_3d; // @[restoring_div_radix4.scala 50:14]
  assign deside_bits = {{p_r_minus_d[9],p_r_minus_2d[9]},p_r_minus_3d[9]}; // @[BaseType.scala 299:24]
  always @(*) begin
    case(deside_bits)
      3'b000 : begin
        p_r_part_next = p_r_minus_3d; // @[restoring_div_radix4.scala 56:23]
      end
      3'b001 : begin
        p_r_part_next = p_r_minus_2d; // @[restoring_div_radix4.scala 60:23]
      end
      3'b010, 3'b011 : begin
        p_r_part_next = p_r_minus_d; // @[restoring_div_radix4.scala 64:23]
      end
      default : begin
        p_r_part_next = p_r_calpart; // @[restoring_div_radix4.scala 69:23]
      end
    endcase
  end

  always @(*) begin
    case(deside_bits)
      3'b000 : begin
        quot_updata_bits = 2'b11; // @[restoring_div_radix4.scala 57:26]
      end
      3'b001 : begin
        quot_updata_bits = 2'b10; // @[restoring_div_radix4.scala 61:26]
      end
      3'b010, 3'b011 : begin
        quot_updata_bits = 2'b01; // @[restoring_div_radix4.scala 65:26]
      end
      default : begin
        quot_updata_bits = 2'b00; // @[restoring_div_radix4.scala 70:26]
      end
    endcase
  end

  assign finish_pulse = (control_cnt == 3'b111); // @[BaseType.scala 305:24]
  assign remainder_abs = p_remainder[23 : 16]; // @[BaseType.scala 299:24]
  assign remainder = (dinB[7] ? tmp_remainder : tmp_remainder_2); // @[restoring_div_radix4.scala 110:14]
  assign quot = (sign_out ? tmp_quot : tmp_quot_2); // @[restoring_div_radix4.scala 111:9]
  assign dout_vld = finish_pulse_regNext; // @[restoring_div_radix4.scala 112:13]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      quotient <= 16'h0; // @[Data.scala 400:33]
      divisior <= 10'h0; // @[Data.scala 400:33]
      p_remainder <= 26'h0; // @[Data.scala 400:33]
      control_cnt <= 3'b000; // @[Data.scala 400:33]
      doing <= 1'b0; // @[Data.scala 400:33]
      finish_pulse_regNext <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(din_vld) begin
        divisior <= {2'd0, tmp_divisior}; // @[restoring_div_radix4.scala 34:14]
      end
      if(din_vld) begin
        doing <= 1'b1; // @[Bool.scala 88:26]
      end else begin
        if(finish_pulse) begin
          doing <= 1'b0; // @[Bool.scala 90:28]
        end
      end
      if(din_vld) begin
        control_cnt <= 3'b000; // @[restoring_div_radix4.scala 84:17]
      end else begin
        if(doing) begin
          control_cnt <= (control_cnt + 3'b001); // @[restoring_div_radix4.scala 86:17]
        end else begin
          if(finish_pulse) begin
            control_cnt <= 3'b000; // @[restoring_div_radix4.scala 88:17]
          end
        end
      end
      if(din_vld) begin
        p_remainder <= {10'h0,dinA_abs}; // @[restoring_div_radix4.scala 92:17]
      end else begin
        if(doing) begin
          p_remainder <= {p_r_part_next,p_r_shift[15 : 0]}; // @[restoring_div_radix4.scala 94:17]
        end
      end
      if(din_vld) begin
        quotient[15 : 14] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b000)) begin
            quotient[15 : 14] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[13 : 12] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b001)) begin
            quotient[13 : 12] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[11 : 10] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b010)) begin
            quotient[11 : 10] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[9 : 8] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b011)) begin
            quotient[9 : 8] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[7 : 6] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b100)) begin
            quotient[7 : 6] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[5 : 4] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b101)) begin
            quotient[5 : 4] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[3 : 2] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b110)) begin
            quotient[3 : 2] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      if(din_vld) begin
        quotient[1 : 0] <= 2'b00; // @[restoring_div_radix4.scala 99:56]
      end else begin
        if(doing) begin
          if((control_cnt == 3'b111)) begin
            quotient[1 : 0] <= quot_updata_bits; // @[restoring_div_radix4.scala 102:58]
          end
        end
      end
      finish_pulse_regNext <= finish_pulse; // @[Reg.scala 39:30]
    end
  end


endmodule

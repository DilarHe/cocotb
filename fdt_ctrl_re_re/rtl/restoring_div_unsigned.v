// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : restoring_div_unsigned

`timescale 1ns/1ps 
module restoring_div_unsigned (
  input  wire          din_vld,
  input  wire [15:0]   dinA,
  input  wire [3:0]    dinB,
  output wire          dout_vld,
  output wire [15:0]   quot,
  output wire [3:0]    remainder,
  input  wire          clkout,
  input  wire          rstn_80m
);

  wire       [3:0]    tmp_divisior;
  wire       [4:0]    tmp_p_r_minus_d;
  wire       [4:0]    tmp_p_r_minus_d_1;
  wire       [4:0]    tmp_p_r_minus_d_2;
  wire                tmp_quot_reversed;
  wire       [0:0]    tmp_quot_reversed_1;
  wire       [6:0]    tmp_quot_reversed_2;
  wire       [15:0]   dinA_abs;
  wire       [3:0]    dinB_abs;
  reg        [15:0]   quotient;
  reg        [4:0]    divisior;
  reg        [20:0]   p_remainder;
  wire       [20:0]   p_r_shift;
  wire       [4:0]    p_r_calpart;
  wire       [4:0]    p_r_minus_d;
  wire       [4:0]    p_r_part_next;
  reg        [3:0]    control_cnt;
  reg                 doing;
  wire                finish_pulse;
  wire       [15:0]   quot_reversed;
  reg                 finish_pulse_regNext;

  assign tmp_divisior = dinB_abs;
  assign tmp_p_r_minus_d = ($signed(tmp_p_r_minus_d_1) - $signed(tmp_p_r_minus_d_2));
  assign tmp_p_r_minus_d_1 = p_r_calpart;
  assign tmp_p_r_minus_d_2 = divisior;
  assign tmp_quot_reversed = quotient[7];
  assign tmp_quot_reversed_1 = quotient[8];
  assign tmp_quot_reversed_2 = {quotient[9],{quotient[10],{quotient[11],{quotient[12],{quotient[13],{quotient[14],quotient[15]}}}}}};
  assign dinA_abs = dinA;
  assign dinB_abs = dinB;
  assign p_r_shift = (p_remainder <<< 1);
  assign p_r_calpart = p_r_shift[20 : 16];
  assign p_r_minus_d = tmp_p_r_minus_d;
  assign p_r_part_next = (p_r_minus_d[4] ? p_r_calpart : p_r_minus_d);
  assign finish_pulse = (control_cnt == 4'b1111);
  assign quot_reversed = {quotient[0],{quotient[1],{quotient[2],{quotient[3],{quotient[4],{quotient[5],{quotient[6],{tmp_quot_reversed,{tmp_quot_reversed_1,tmp_quot_reversed_2}}}}}}}}};
  assign remainder = p_remainder[19 : 16];
  assign quot = quot_reversed;
  assign dout_vld = finish_pulse_regNext;
  always @(posedge clkout or negedge rstn_80m) begin
    if(!rstn_80m) begin
      quotient <= 16'h0;
      divisior <= 5'h0;
      p_remainder <= 21'h0;
      control_cnt <= 4'b0000;
      doing <= 1'b0;
      finish_pulse_regNext <= 1'b0;
    end else begin
      if(din_vld) begin
        divisior <= {1'd0, tmp_divisior};
      end
      if(din_vld) begin
        doing <= 1'b1;
      end else begin
        if(finish_pulse) begin
          doing <= 1'b0;
        end
      end
      if(din_vld) begin
        control_cnt <= 4'b0000;
      end else begin
        if(doing) begin
          control_cnt <= (control_cnt + 4'b0001);
        end else begin
          if(finish_pulse) begin
            control_cnt <= 4'b0000;
          end
        end
      end
      if(din_vld) begin
        p_remainder <= {5'h0,dinA_abs};
      end else begin
        if(doing) begin
          p_remainder <= {p_r_part_next,p_r_shift[15 : 0]};
        end
      end
      if(din_vld) begin
        quotient[0] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b0000)) begin
            quotient[0] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[1] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b0001)) begin
            quotient[1] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[2] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b0010)) begin
            quotient[2] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[3] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b0011)) begin
            quotient[3] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[4] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b0100)) begin
            quotient[4] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[5] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b0101)) begin
            quotient[5] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[6] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b0110)) begin
            quotient[6] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[7] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b0111)) begin
            quotient[7] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[8] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b1000)) begin
            quotient[8] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[9] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b1001)) begin
            quotient[9] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[10] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b1010)) begin
            quotient[10] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[11] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b1011)) begin
            quotient[11] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[12] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b1100)) begin
            quotient[12] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[13] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b1101)) begin
            quotient[13] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[14] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b1110)) begin
            quotient[14] <= (! p_r_minus_d[4]);
          end
        end
      end
      if(din_vld) begin
        quotient[15] <= 1'b0;
      end else begin
        if(doing) begin
          if((control_cnt == 4'b1111)) begin
            quotient[15] <= (! p_r_minus_d[4]);
          end
        end
      end
      finish_pulse_regNext <= finish_pulse;
    end
  end


endmodule

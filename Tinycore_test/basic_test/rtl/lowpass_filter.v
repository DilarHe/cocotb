// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : lowpass_filter
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module lowpass_filter (
  input               rg_lpfilter_en,
  input               kws_start_pos,
  output              filter_start,
  output              filter_finish,
  input      [15:0]   pcm16k_in,
  input               pcm16k_vld,
  output reg [15:0]   pcm_filter_out,
  output reg          pcm_filter_vld,
  output reg          mulif_din_vld,
  output reg [15:0]   mulif_dinA,
  output reg [8:0]    mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [24:0]   mulif_dout,
  input               clk,
  input               resetn
);

  wire       [28:0]   rdsat_din;
  wire       [15:0]   rdsat_dout;
  wire       [15:0]   tmp_pcm_filter_out_stable;
  wire       [15:0]   tmp_pcm_filter_out_stable_1;
  wire       [15:0]   tmp_pcm_filter_out;
  wire       [28:0]   tmp_filter_out;
  wire       [28:0]   tmp_filter_out_1;
  wire       [28:0]   tmp_filter_out_2;
  wire       [28:0]   tmp_filter_out_3;
  reg        [15:0]   bufferi0;
  reg        [15:0]   bufferi1;
  reg        [15:0]   bufferi2;
  reg        [28:0]   filter_out;
  reg        [1:0]    cnt;
  reg        [2:0]    mul_state;
  reg                 downsample_flag;
  wire                filter_cal_active;
  reg                 pcm16k_vld_delay;
  wire                filter_cal_start;
  reg                 pcm_filter_vld_stable;
  wire       [15:0]   pcm_filter_out_stable;

  assign tmp_pcm_filter_out_stable = rdsat_dout;
  assign tmp_pcm_filter_out_stable_1 = 16'h0;
  assign tmp_pcm_filter_out = 16'h0;
  assign tmp_filter_out = {{4{mulif_dout[24]}}, mulif_dout};
  assign tmp_filter_out_1 = {{4{mulif_dout[24]}}, mulif_dout};
  assign tmp_filter_out_2 = {{4{mulif_dout[24]}}, mulif_dout};
  assign tmp_filter_out_3 = {{4{mulif_dout[24]}}, mulif_dout};
  RoundandSat_4 rdsat (
    .din  (rdsat_din[28:0] ), //i
    .dout (rdsat_dout[15:0])  //o
  );
  assign rdsat_din = filter_out; // @[lowpass_filter.scala 45:16]
  assign filter_cal_active = (cnt == 2'b11); // @[BaseType.scala 305:24]
  assign filter_cal_start = ((rg_lpfilter_en && filter_cal_active) && pcm16k_vld_delay); // @[BaseType.scala 305:24]
  assign pcm_filter_out_stable = (pcm_filter_vld ? tmp_pcm_filter_out_stable : tmp_pcm_filter_out_stable_1); // @[Expression.scala 1420:25]
  always @(*) begin
    pcm_filter_vld = 1'b0; // @[lowpass_filter.scala 84:21]
    if(rg_lpfilter_en) begin
      if((cnt < 2'b10)) begin
        pcm_filter_vld = (pcm16k_vld && downsample_flag); // @[lowpass_filter.scala 88:25]
      end else begin
        if((2'b10 <= cnt)) begin
          pcm_filter_vld = (pcm_filter_vld_stable && downsample_flag); // @[lowpass_filter.scala 91:25]
        end
      end
    end else begin
      pcm_filter_vld = pcm16k_vld; // @[lowpass_filter.scala 95:23]
    end
  end

  always @(*) begin
    pcm_filter_out = 16'h0; // @[lowpass_filter.scala 85:21]
    if(rg_lpfilter_en) begin
      if((cnt < 2'b10)) begin
        pcm_filter_out = 16'h0; // @[lowpass_filter.scala 89:25]
      end else begin
        if((2'b10 <= cnt)) begin
          pcm_filter_out = (pcm_filter_vld ? pcm_filter_out_stable : tmp_pcm_filter_out); // @[lowpass_filter.scala 92:25]
        end
      end
    end else begin
      pcm_filter_out = pcm16k_in; // @[lowpass_filter.scala 96:23]
    end
  end

  always @(*) begin
    mulif_dinA = 16'h0; // @[lowpass_filter.scala 100:17]
    if((mul_state == 3'b000)) begin
      if(filter_cal_start) begin
        mulif_dinA = bufferi0; // @[lowpass_filter.scala 106:21]
      end else begin
        if(mulif_dout_vld) begin
          mulif_dinA = bufferi1; // @[lowpass_filter.scala 110:21]
        end
      end
    end else begin
      if((mul_state == 3'b001)) begin
        if(mulif_dout_vld) begin
          mulif_dinA = bufferi2; // @[lowpass_filter.scala 119:21]
        end
      end else begin
        if((mul_state == 3'b010)) begin
          if(mulif_dout_vld) begin
            mulif_dinA = bufferi1; // @[lowpass_filter.scala 127:21]
          end
        end else begin
          if((mul_state == 3'b011)) begin
            if(mulif_dout_vld) begin
              mulif_dinA = bufferi2; // @[lowpass_filter.scala 135:21]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mulif_dinB = 9'h0; // @[lowpass_filter.scala 101:17]
    if((mul_state == 3'b000)) begin
      if(filter_cal_start) begin
        mulif_dinB = 9'h0a6; // @[lowpass_filter.scala 107:21]
      end else begin
        if(mulif_dout_vld) begin
          mulif_dinB = 9'h089; // @[lowpass_filter.scala 111:21]
        end
      end
    end else begin
      if((mul_state == 3'b001)) begin
        if(mulif_dout_vld) begin
          mulif_dinB = 9'h040; // @[lowpass_filter.scala 120:21]
        end
      end else begin
        if((mul_state == 3'b010)) begin
          if(mulif_dout_vld) begin
            mulif_dinB = 9'h026; // @[lowpass_filter.scala 128:21]
          end
        end else begin
          if((mul_state == 3'b011)) begin
            if(mulif_dout_vld) begin
              mulif_dinB = 9'h04a; // @[lowpass_filter.scala 136:21]
            end
          end
        end
      end
    end
  end

  always @(*) begin
    mulif_din_vld = 1'b0; // @[lowpass_filter.scala 102:20]
    if((mul_state == 3'b000)) begin
      if(filter_cal_start) begin
        mulif_din_vld = 1'b1; // @[lowpass_filter.scala 105:24]
      end else begin
        if(mulif_dout_vld) begin
          mulif_din_vld = 1'b1; // @[lowpass_filter.scala 109:24]
        end
      end
    end else begin
      if((mul_state == 3'b001)) begin
        if(mulif_dout_vld) begin
          mulif_din_vld = 1'b1; // @[lowpass_filter.scala 118:24]
        end
      end else begin
        if((mul_state == 3'b010)) begin
          if(mulif_dout_vld) begin
            mulif_din_vld = 1'b1; // @[lowpass_filter.scala 126:24]
          end
        end else begin
          if((mul_state == 3'b011)) begin
            if(mulif_dout_vld) begin
              mulif_din_vld = 1'b1; // @[lowpass_filter.scala 134:24]
            end
          end
        end
      end
    end
  end

  assign filter_finish = (rg_lpfilter_en ? ((cnt < 2'b11) ? pcm16k_vld_delay : ((mul_state == 3'b100) && mulif_dout_vld)) : pcm16k_vld_delay); // @[lowpass_filter.scala 169:20]
  assign filter_start = pcm16k_vld; // @[lowpass_filter.scala 170:19]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      bufferi0 <= 16'h0; // @[Data.scala 400:33]
      bufferi1 <= 16'h0; // @[Data.scala 400:33]
      bufferi2 <= 16'h0; // @[Data.scala 400:33]
      filter_out <= 29'h0; // @[Data.scala 400:33]
      cnt <= 2'b00; // @[Data.scala 400:33]
      mul_state <= 3'b000; // @[Data.scala 400:33]
      downsample_flag <= 1'b0; // @[Data.scala 400:33]
      pcm16k_vld_delay <= 1'b0; // @[Data.scala 400:33]
      pcm_filter_vld_stable <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(rg_lpfilter_en) begin
        if(pcm16k_vld) begin
          bufferi0 <= pcm16k_in; // @[lowpass_filter.scala 50:16]
          bufferi1 <= bufferi0; // @[lowpass_filter.scala 51:16]
          bufferi2 <= bufferi1; // @[lowpass_filter.scala 52:16]
        end
      end
      if(rg_lpfilter_en) begin
        if(kws_start_pos) begin
          cnt <= 2'b00; // @[lowpass_filter.scala 58:11]
        end else begin
          if((cnt < 2'b11)) begin
            if(pcm16k_vld) begin
              cnt <= (cnt + 2'b01); // @[lowpass_filter.scala 61:13]
            end
          end
        end
      end
      pcm16k_vld_delay <= pcm16k_vld; // @[Reg.scala 39:30]
      pcm_filter_vld_stable <= ((mul_state == 3'b100) && mulif_dout_vld); // @[Reg.scala 39:30]
      if(kws_start_pos) begin
        downsample_flag <= 1'b1; // @[lowpass_filter.scala 73:21]
      end else begin
        if((cnt < 2'b10)) begin
          if(pcm16k_vld) begin
            downsample_flag <= (! downsample_flag); // @[lowpass_filter.scala 76:23]
          end
        end else begin
          if((2'b10 <= cnt)) begin
            if(pcm_filter_vld_stable) begin
              downsample_flag <= (! downsample_flag); // @[lowpass_filter.scala 80:23]
            end
          end
        end
      end
      if((mul_state == 3'b000)) begin
        if(!filter_cal_start) begin
          if(mulif_dout_vld) begin
            filter_out <= {{4{mulif_dout[24]}}, mulif_dout}; // @[lowpass_filter.scala 114:18]
          end
        end
      end else begin
        if((mul_state == 3'b001)) begin
          if(mulif_dout_vld) begin
            filter_out <= ($signed(filter_out) + $signed(tmp_filter_out)); // @[lowpass_filter.scala 122:18]
          end
        end else begin
          if((mul_state == 3'b010)) begin
            if(mulif_dout_vld) begin
              filter_out <= ($signed(filter_out) + $signed(tmp_filter_out_1)); // @[lowpass_filter.scala 130:18]
            end
          end else begin
            if((mul_state == 3'b011)) begin
              if(mulif_dout_vld) begin
                filter_out <= ($signed(filter_out) - $signed(tmp_filter_out_2)); // @[lowpass_filter.scala 138:18]
              end
            end else begin
              if((mul_state == 3'b100)) begin
                if(mulif_dout_vld) begin
                  filter_out <= ($signed(filter_out) - $signed(tmp_filter_out_3)); // @[lowpass_filter.scala 143:18]
                end
              end
            end
          end
        end
      end
      if((mul_state == 3'b000)) begin
        if(mulif_dout_vld) begin
          mul_state <= 3'b001; // @[lowpass_filter.scala 149:17]
        end
      end else begin
        if((mul_state == 3'b001)) begin
          if(mulif_dout_vld) begin
            mul_state <= 3'b010; // @[lowpass_filter.scala 153:17]
          end
        end else begin
          if((mul_state == 3'b010)) begin
            if(mulif_dout_vld) begin
              mul_state <= 3'b011; // @[lowpass_filter.scala 157:17]
            end
          end else begin
            if((mul_state == 3'b011)) begin
              if(mulif_dout_vld) begin
                mul_state <= 3'b100; // @[lowpass_filter.scala 161:17]
              end
            end else begin
              if((mul_state == 3'b100)) begin
                if(mulif_dout_vld) begin
                  mul_state <= 3'b000; // @[lowpass_filter.scala 165:17]
                end
              end
            end
          end
        end
      end
    end
  end


endmodule

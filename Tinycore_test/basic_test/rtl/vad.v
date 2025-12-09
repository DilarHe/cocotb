// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : vad
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module vad (
  input               vad_en,
  input               frame_end,
  input      [15:0]   pcm_in,
  input               pcm_vld,
  input      [15:0]   vad_energy_threshold,
  input      [7:0]    vad_hangover,
  output              vad_flag,
  input               vad_clk,
  input               resetn
);

  wire       [15:0]   tmp_pcm_in_abs;
  wire       [15:0]   tmp_pcm_in_abs_1;
  wire       [15:0]   tmp_pcm_in_abs_2;
  wire       [0:0]    tmp_pcm_in_abs_3;
  wire       [23:0]   tmp_energy;
  reg        [7:0]    count_tail;
  reg                 vad_flag_reg;
  reg        [23:0]   energy;
  wire       [15:0]   pcm_in_abs;
  wire       [23:0]   threshold;

  assign tmp_pcm_in_abs = (pcm_in[15] ? tmp_pcm_in_abs_1 : pcm_in);
  assign tmp_pcm_in_abs_1 = (~ pcm_in);
  assign tmp_pcm_in_abs_3 = pcm_in[15];
  assign tmp_pcm_in_abs_2 = {15'd0, tmp_pcm_in_abs_3};
  assign tmp_energy = {8'd0, pcm_in_abs};
  assign pcm_in_abs = (tmp_pcm_in_abs + tmp_pcm_in_abs_2); // @[BaseType.scala 299:24]
  assign threshold = {vad_energy_threshold,8'h0}; // @[BaseType.scala 299:24]
  assign vad_flag = vad_flag_reg; // @[vad.scala 59:15]
  always @(posedge vad_clk or negedge resetn) begin
    if(!resetn) begin
      count_tail <= 8'h0; // @[Data.scala 400:33]
      vad_flag_reg <= 1'b0; // @[Data.scala 400:33]
      energy <= 24'h0; // @[Data.scala 400:33]
    end else begin
      if(vad_en) begin
        if(pcm_vld) begin
          energy <= (energy + tmp_energy); // @[vad.scala 32:14]
        end else begin
          if(frame_end) begin
            energy <= 24'h0; // @[vad.scala 34:14]
          end
        end
      end else begin
        energy <= 24'h0; // @[vad.scala 37:12]
      end
      if(vad_en) begin
        if(frame_end) begin
          if((threshold <= energy)) begin
            vad_flag_reg <= 1'b1; // @[vad.scala 43:20]
            count_tail <= vad_hangover; // @[vad.scala 44:18]
          end else begin
            if((8'h0 < count_tail)) begin
              count_tail <= (count_tail - 8'h01); // @[vad.scala 47:20]
              vad_flag_reg <= 1'b1; // @[vad.scala 48:22]
            end else begin
              vad_flag_reg <= 1'b0; // @[vad.scala 50:22]
            end
          end
        end
      end else begin
        vad_flag_reg <= 1'b1; // @[vad.scala 55:16]
      end
    end
  end


endmodule

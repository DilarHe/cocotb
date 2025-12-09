// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : pre_mpx

`timescale 1ns/1ps 
module pre_mpx (
  input  wire [2:0]    rg_pre_mpx_sel,
  input  wire          fdt_sampling,
  input  wire          fdt_adc_in_vld,
  input  wire          fdt_done,
  input  wire          amp_mean_vld_0,
  input  wire          amp_mean_vld_1,
  input  wire          amp_mean_vld_2,
  input  wire          norm_samp_done,
  input  wire          norm_norm_done_20M,
  input  wire          NN_start_once,
  input  wire          NN_matmul_done_once,
  input  wire          NN_UpDown_label_result_vld,
  input  wire          NN_Heavy_label_result_vld,
  input  wire          NN_done,
  input  wire          label_UpDown,
  input  wire          label_Heavy,
  input  wire          fdt_start_pulse,
  input  wire [1:0]    fdt_area_cnt,
  input  wire          fdt_area_skip_flag,
  input  wire          fdt_all_area_NN_done,
  output reg           pre_mpx_pin_0,
  output reg           pre_mpx_pin_1,
  output reg           pre_mpx_pin_2
);


  always @(*) begin
    case(rg_pre_mpx_sel)
      3'b000 : begin
        pre_mpx_pin_0 = amp_mean_vld_2;
      end
      3'b001 : begin
        pre_mpx_pin_0 = norm_norm_done_20M;
      end
      3'b010 : begin
        pre_mpx_pin_0 = NN_start_once;
      end
      3'b011 : begin
        pre_mpx_pin_0 = NN_matmul_done_once;
      end
      3'b100 : begin
        pre_mpx_pin_0 = NN_matmul_done_once;
      end
      3'b101 : begin
        pre_mpx_pin_0 = fdt_sampling;
      end
      3'b110 : begin
        pre_mpx_pin_0 = fdt_start_pulse;
      end
      default : begin
        pre_mpx_pin_0 = fdt_area_skip_flag;
      end
    endcase
  end

  always @(*) begin
    case(rg_pre_mpx_sel)
      3'b000 : begin
        pre_mpx_pin_1 = norm_samp_done;
      end
      3'b001 : begin
        pre_mpx_pin_1 = NN_start_once;
      end
      3'b010 : begin
        pre_mpx_pin_1 = NN_matmul_done_once;
      end
      3'b011 : begin
        pre_mpx_pin_1 = NN_UpDown_label_result_vld;
      end
      3'b100 : begin
        pre_mpx_pin_1 = label_UpDown;
      end
      3'b101 : begin
        pre_mpx_pin_1 = fdt_adc_in_vld;
      end
      3'b110 : begin
        pre_mpx_pin_1 = fdt_area_cnt[0];
      end
      default : begin
        pre_mpx_pin_1 = fdt_area_cnt[0];
      end
    endcase
  end

  always @(*) begin
    case(rg_pre_mpx_sel)
      3'b000 : begin
        pre_mpx_pin_2 = norm_norm_done_20M;
      end
      3'b001 : begin
        pre_mpx_pin_2 = NN_done;
      end
      3'b010 : begin
        pre_mpx_pin_2 = NN_done;
      end
      3'b011 : begin
        pre_mpx_pin_2 = NN_Heavy_label_result_vld;
      end
      3'b100 : begin
        pre_mpx_pin_2 = label_Heavy;
      end
      3'b101 : begin
        pre_mpx_pin_2 = fdt_done;
      end
      3'b110 : begin
        pre_mpx_pin_2 = fdt_all_area_NN_done;
      end
      default : begin
        pre_mpx_pin_2 = fdt_area_cnt[1];
      end
    endcase
  end


endmodule

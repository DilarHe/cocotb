// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : lsu
// Git hash  : 94ae75793d6c2495c959630fe227dcbbacde6a31

`timescale 1ns/1ps 
module lsu (
  input               is_wstore,
  input               is_wload,
  input               is_vload,
  input               is_vstore,
  input               access_mem_vld,
  input      [31:0]   access_mem_addr,
  input      [31:0]   access_mem_wr_sdata,
  input      [127:0]  access_mem_wr_vdata,
  input      [4:0]    rd_load_index_in,
  output     [31:0]   lsu_write_rd_data,
  output     [4:0]    lsu_write_rd_index,
  output              lsu_write_rd_vld,
  output              lsu_write_rd_is_vector,
  output     [127:0]  lsu_write_rd_vector_data,
  output reg          highBandWidth_fb_mem_rd,
  output reg          highBandWidth_fb_mem_wr,
  output reg [6:0]    highBandWidth_fb_mem_addr,
  output reg [127:0]  highBandWidth_fb_mem_wdata,
  input      [127:0]  highBandWidth_fb_mem_rdata,
  output reg          highBandWidth_a_mem_rd,
  output reg          highBandWidth_a_mem_wr,
  output reg [6:0]    highBandWidth_a_mem_addr,
  output reg [127:0]  highBandWidth_a_mem_wdata,
  input      [127:0]  highBandWidth_a_mem_rdata,
  output reg          highBandWidth_w_mem_rd,
  output reg          highBandWidth_w_mem_wr,
  output reg [9:0]    highBandWidth_w_mem_addr,
  output reg [127:0]  highBandWidth_w_mem_wdata,
  input      [127:0]  highBandWidth_w_mem_rdata,
  output reg          lowBandWidth_mem_rd,
  output reg          lowBandWidth_mem_wr,
  output reg [7:0]    lowBandWidth_mem_addr,
  output reg [31:0]   lowBandWidth_mem_wdata,
  input      [31:0]   lowBandWidth_mem_rdata,
  input               clk,
  input               resetn
);

  wire       [31:0]   tmp_highBandWidth_fb_mem_addr;
  wire       [31:0]   tmp_highBandWidth_a_mem_addr;
  wire       [31:0]   tmp_highBandWidth_w_mem_addr;
  reg        [31:0]   access_mem_rd_sdata;
  reg        [127:0]  access_mem_rd_vdata;
  wire                is_load;
  reg                 is_load_regNext;
  reg                 is_vload_regNext;
  reg        [4:0]    load_index;
  wire                lowBandWidth_sel;
  wire                highBandWidth_fb_sel;
  wire                highBandWidth_a_sel;
  wire                highBandWidth_w_sel;
  wire       [3:0]    mem_sel;
  reg        [3:0]    mem_sel_regNext;

  assign tmp_highBandWidth_fb_mem_addr = (access_mem_addr - 32'h00000100);
  assign tmp_highBandWidth_a_mem_addr = (access_mem_addr - 32'h00000178);
  assign tmp_highBandWidth_w_mem_addr = (access_mem_addr - 32'h0000017f);
  assign is_load = (access_mem_vld && (is_vload || is_wload)); // @[BaseType.scala 305:24]
  assign lsu_write_rd_vld = is_load_regNext; // @[lsu.scala 93:23]
  assign lsu_write_rd_is_vector = is_vload_regNext; // @[lsu.scala 94:29]
  assign lsu_write_rd_data = access_mem_rd_sdata; // @[lsu.scala 95:24]
  assign lsu_write_rd_vector_data = access_mem_rd_vdata; // @[lsu.scala 96:31]
  assign lsu_write_rd_index = load_index; // @[lsu.scala 98:25]
  assign lowBandWidth_sel = (access_mem_addr < 32'h00000100); // @[BaseType.scala 305:24]
  assign highBandWidth_fb_sel = ((! lowBandWidth_sel) && (access_mem_addr < 32'h00000178)); // @[BaseType.scala 305:24]
  assign highBandWidth_a_sel = (((! lowBandWidth_sel) && (! highBandWidth_fb_sel)) && (access_mem_addr < 32'h0000017f)); // @[BaseType.scala 305:24]
  assign highBandWidth_w_sel = (((! lowBandWidth_sel) && (! highBandWidth_fb_sel)) && (! highBandWidth_a_sel)); // @[BaseType.scala 305:24]
  assign mem_sel = {{{lowBandWidth_sel,highBandWidth_fb_sel},highBandWidth_a_sel},highBandWidth_w_sel}; // @[BaseType.scala 299:24]
  always @(*) begin
    highBandWidth_fb_mem_rd = 1'b0; // @[lsu.scala 109:30]
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_rd = (is_vload && access_mem_vld); // @[lsu.scala 136:34]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_fb_mem_wr = 1'b0; // @[lsu.scala 110:30]
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_wr = (is_vstore && access_mem_vld); // @[lsu.scala 137:34]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_fb_mem_addr = 7'h0; // @[lsu.scala 111:32]
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_addr = tmp_highBandWidth_fb_mem_addr[6 : 0]; // @[lsu.scala 138:36]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_fb_mem_wdata = 128'h0; // @[lsu.scala 112:33]
    case(mem_sel)
      4'b0100 : begin
        highBandWidth_fb_mem_wdata = access_mem_wr_vdata; // @[lsu.scala 139:37]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_rd = 1'b0; // @[lsu.scala 114:29]
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_rd = (is_vload && access_mem_vld); // @[lsu.scala 142:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_wr = 1'b0; // @[lsu.scala 115:29]
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_wr = (is_vstore && access_mem_vld); // @[lsu.scala 143:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_addr = 7'h0; // @[lsu.scala 116:31]
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_addr = tmp_highBandWidth_a_mem_addr[6 : 0]; // @[lsu.scala 144:35]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_a_mem_wdata = 128'h0; // @[lsu.scala 117:32]
    case(mem_sel)
      4'b0010 : begin
        highBandWidth_a_mem_wdata = access_mem_wr_vdata; // @[lsu.scala 145:36]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_rd = 1'b0; // @[lsu.scala 119:29]
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_rd = (is_vload && access_mem_vld); // @[lsu.scala 148:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_wr = 1'b0; // @[lsu.scala 120:29]
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_wr = (is_vstore && access_mem_vld); // @[lsu.scala 149:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_addr = 10'h0; // @[lsu.scala 121:31]
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_addr = tmp_highBandWidth_w_mem_addr[9 : 0]; // @[lsu.scala 150:35]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    highBandWidth_w_mem_wdata = 128'h0; // @[lsu.scala 122:32]
    case(mem_sel)
      4'b0001 : begin
        highBandWidth_w_mem_wdata = access_mem_wr_vdata; // @[lsu.scala 151:36]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_rd = 1'b0; // @[lsu.scala 124:26]
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_rd = (is_wload && access_mem_vld); // @[lsu.scala 130:30]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_wr = 1'b0; // @[lsu.scala 125:26]
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_wr = (is_wstore && access_mem_vld); // @[lsu.scala 131:30]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_addr = 8'h0; // @[lsu.scala 126:28]
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_addr = access_mem_addr[7 : 0]; // @[lsu.scala 132:32]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    lowBandWidth_mem_wdata = 32'h0; // @[lsu.scala 127:29]
    case(mem_sel)
      4'b1000 : begin
        lowBandWidth_mem_wdata = access_mem_wr_sdata; // @[lsu.scala 133:33]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    access_mem_rd_vdata = 128'h0; // @[lsu.scala 156:25]
    case(mem_sel_regNext)
      4'b0100 : begin
        access_mem_rd_vdata = highBandWidth_fb_mem_rdata; // @[lsu.scala 163:29]
      end
      4'b0010 : begin
        access_mem_rd_vdata = highBandWidth_a_mem_rdata; // @[lsu.scala 166:29]
      end
      4'b0001 : begin
        access_mem_rd_vdata = highBandWidth_w_mem_rdata; // @[lsu.scala 169:29]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    access_mem_rd_sdata = 32'h0; // @[lsu.scala 157:25]
    case(mem_sel_regNext)
      4'b1000 : begin
        access_mem_rd_sdata = lowBandWidth_mem_rdata; // @[lsu.scala 160:29]
      end
      default : begin
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      is_load_regNext <= 1'b0; // @[Data.scala 400:33]
      is_vload_regNext <= 1'b0; // @[Data.scala 400:33]
      load_index <= 5'h0; // @[Data.scala 400:33]
      mem_sel_regNext <= 4'b0000; // @[Data.scala 400:33]
    end else begin
      is_load_regNext <= is_load; // @[Reg.scala 39:30]
      is_vload_regNext <= is_vload; // @[Reg.scala 39:30]
      if(is_load) begin
        load_index <= rd_load_index_in; // @[lsu.scala 100:16]
      end
      mem_sel_regNext <= mem_sel; // @[Reg.scala 39:30]
    end
  end


endmodule

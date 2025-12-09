// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : quant8
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module quant8 (
  input               start,
  output              finish,
  input      [15:0]   rg_fbank_quant_scale,
  input      [7:0]    rg_fbank_quant_zerpoint,
  input      [4:0]    rg_fbank_quant_shift,
  output              mulif_din_vld,
  output reg [31:0]   mulif_dinA,
  output reg [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [47:0]   mulif_dout,
  output reg          pcm_memif_rd,
  output              pcm_memif_wr,
  output reg [7:0]    pcm_memif_addr,
  output     [31:0]   pcm_memif_wdata,
  input      [31:0]   pcm_memif_rdata,
  output              lmfb_memif_rd,
  output reg          lmfb_memif_wr,
  output reg [6:0]    lmfb_memif_addr,
  output reg [127:0]  lmfb_memif_wdata,
  input      [127:0]  lmfb_memif_rdata,
  output     [7:0]    lmfb_uint8_out,
  output     [6:0]    lmfb_write_addr,
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam LOADDATA = 2'd1;
  localparam QUANTMUL = 2'd2;
  localparam STOREDATA = 2'd3;

  wire       [23:0]   rdeven_dout;
  wire       [23:0]   tmp_lmfb_uint8_out;
  wire       [23:0]   tmp_lmfb_uint8_out_1;
  wire       [31:0]   tmp_mulif_dinA;
  wire       [15:0]   tmp_mulif_dinA_1;
  wire       [31:0]   tmp_mulif_dinB;
  reg        [7:0]    lmfb_buffer_0;
  reg        [7:0]    lmfb_buffer_1;
  reg        [7:0]    lmfb_buffer_2;
  reg        [7:0]    lmfb_buffer_3;
  reg        [7:0]    lmfb_buffer_4;
  reg        [7:0]    lmfb_buffer_5;
  reg        [7:0]    lmfb_buffer_6;
  reg        [7:0]    lmfb_buffer_7;
  reg        [7:0]    lmfb_buffer_8;
  reg        [7:0]    lmfb_buffer_9;
  reg        [7:0]    lmfb_buffer_10;
  reg        [7:0]    lmfb_buffer_11;
  reg        [7:0]    lmfb_buffer_12;
  reg        [7:0]    lmfb_buffer_13;
  reg        [7:0]    lmfb_buffer_14;
  reg        [7:0]    lmfb_buffer_15;
  wire       [127:0]  lmfb_mem_wr_line;
  reg        [4:0]    lmfb_cnt;
  reg        [3:0]    lmfb_line_cnt;
  reg        [1:0]    store_cnt;
  reg        [6:0]    lmfb_mem_addr;
  reg        [32:0]   unclamped_fbank;
  wire       [23:0]   shifted_fbank;
  wire                lmfb_cnt_ov;
  wire                lmfb_line_cnt_ov;
  wire                store_cnt_ov;
  wire                lmfb_mem_addr_ov;
  reg        [1:0]    next_state;
  reg        [1:0]    curr_state;
  reg                 start_mul;
  wire       [7:0]    tmp_pcm_memif_addr;
  reg        [7:0]    tmp_pcm_memif_addr_1;
  wire       [15:0]   tmp_1;
  wire       [7:0]    tmp_lmfb_buffer_0;
  `ifndef SYNTHESIS
  reg [71:0] next_state_string;
  reg [71:0] curr_state_string;
  `endif


  assign tmp_lmfb_uint8_out = (shifted_fbank + tmp_lmfb_uint8_out_1);
  assign tmp_lmfb_uint8_out_1 = {16'd0, rg_fbank_quant_zerpoint};
  assign tmp_mulif_dinA_1 = rg_fbank_quant_scale;
  assign tmp_mulif_dinA = {16'd0, tmp_mulif_dinA_1};
  assign tmp_mulif_dinB = pcm_memif_rdata;
  Round2Even rdeven (
    .din  (unclamped_fbank[32:0]), //i
    .dout (rdeven_dout[23:0]    )  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE     ";
      LOADDATA : next_state_string = "LOADDATA ";
      QUANTMUL : next_state_string = "QUANTMUL ";
      STOREDATA : next_state_string = "STOREDATA";
      default : next_state_string = "?????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE     ";
      LOADDATA : curr_state_string = "LOADDATA ";
      QUANTMUL : curr_state_string = "QUANTMUL ";
      STOREDATA : curr_state_string = "STOREDATA";
      default : curr_state_string = "?????????";
    endcase
  end
  `endif

  assign lmfb_mem_wr_line = {{{{{{{{{{{{{{{lmfb_buffer_15,lmfb_buffer_14},lmfb_buffer_13},lmfb_buffer_12},lmfb_buffer_11},lmfb_buffer_10},lmfb_buffer_9},lmfb_buffer_8},lmfb_buffer_7},lmfb_buffer_6},lmfb_buffer_5},lmfb_buffer_4},lmfb_buffer_3},lmfb_buffer_2},lmfb_buffer_1},lmfb_buffer_0}; // @[quant8.scala 54:20]
  assign shifted_fbank = ($signed(rdeven_dout) >>> rg_fbank_quant_shift); // @[quant8.scala 64:16]
  assign lmfb_uint8_out = tmp_lmfb_uint8_out[7 : 0]; // @[quant8.scala 65:21]
  assign lmfb_write_addr = lmfb_mem_addr; // @[quant8.scala 67:22]
  assign lmfb_cnt_ov = (lmfb_cnt == 5'h1d); // @[BaseType.scala 305:24]
  assign lmfb_line_cnt_ov = ((lmfb_line_cnt == 4'b1111) || lmfb_cnt_ov); // @[BaseType.scala 305:24]
  assign store_cnt_ov = (store_cnt == 2'b01); // @[BaseType.scala 305:24]
  assign lmfb_mem_addr_ov = (lmfb_mem_addr == 7'h77); // @[BaseType.scala 305:24]
  assign lmfb_memif_rd = 1'b0; // @[quant8.scala 78:20]
  always @(*) begin
    lmfb_memif_wr = 1'b0; // @[quant8.scala 79:20]
    if(!(curr_state == LOADDATA)) begin
      if((curr_state == STOREDATA)) begin
        lmfb_memif_wr = 1'b1; // @[quant8.scala 43:22]
      end
    end
  end

  always @(*) begin
    lmfb_memif_addr = 7'h0; // @[quant8.scala 80:22]
    if(!(curr_state == LOADDATA)) begin
      if((curr_state == STOREDATA)) begin
        lmfb_memif_addr = lmfb_mem_addr; // @[quant8.scala 44:24]
      end
    end
  end

  always @(*) begin
    lmfb_memif_wdata = 128'h0; // @[quant8.scala 81:23]
    if(!(curr_state == LOADDATA)) begin
      if((curr_state == STOREDATA)) begin
        lmfb_memif_wdata = lmfb_mem_wr_line; // @[quant8.scala 45:25]
      end
    end
  end

  always @(*) begin
    pcm_memif_rd = 1'b0; // @[quant8.scala 83:19]
    if((curr_state == LOADDATA)) begin
      pcm_memif_rd = 1'b1; // @[quant8.scala 48:21]
    end
  end

  assign pcm_memif_wr = 1'b0; // @[quant8.scala 84:19]
  always @(*) begin
    pcm_memif_addr = 8'h0; // @[quant8.scala 85:21]
    if((curr_state == LOADDATA)) begin
      pcm_memif_addr = tmp_pcm_memif_addr_1; // @[quant8.scala 49:23]
    end
  end

  assign pcm_memif_wdata = 32'h0; // @[quant8.scala 86:22]
  assign tmp_pcm_memif_addr = {3'd0, lmfb_cnt}; // @[BaseType.scala 299:24]
  always @(*) begin
    tmp_pcm_memif_addr_1[0] = tmp_pcm_memif_addr[7]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[1] = tmp_pcm_memif_addr[6]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[2] = tmp_pcm_memif_addr[5]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[3] = tmp_pcm_memif_addr[4]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[4] = tmp_pcm_memif_addr[3]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[5] = tmp_pcm_memif_addr[2]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[6] = tmp_pcm_memif_addr[1]; // @[Utils.scala 432:14]
    tmp_pcm_memif_addr_1[7] = tmp_pcm_memif_addr[0]; // @[Utils.scala 432:14]
  end

  assign mulif_din_vld = start_mul; // @[quant8.scala 93:20]
  always @(*) begin
    mulif_dinA = 32'h0; // @[quant8.scala 94:17]
    if(start_mul) begin
      mulif_dinA = tmp_mulif_dinA; // @[quant8.scala 97:19]
    end
  end

  always @(*) begin
    mulif_dinB = 16'h0; // @[quant8.scala 95:17]
    if(start_mul) begin
      mulif_dinB = tmp_mulif_dinB[15:0]; // @[quant8.scala 98:19]
    end
  end

  always @(*) begin
    unclamped_fbank = 33'h0; // @[quant8.scala 114:19]
    if(((curr_state == QUANTMUL) && mulif_dout_vld)) begin
      unclamped_fbank = mulif_dout[32 : 0]; // @[quant8.scala 116:21]
    end
  end

  assign tmp_1 = ({15'd0,1'b1} <<< lmfb_line_cnt); // @[BaseType.scala 299:24]
  assign tmp_lmfb_buffer_0 = lmfb_uint8_out; // @[BaseType.scala 318:22]
  assign finish = ((curr_state == STOREDATA) && (next_state == IDLE)); // @[quant8.scala 136:13]
  always @(*) begin
    next_state = curr_state; // @[quant8.scala 138:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = LOADDATA; // @[Enum.scala 148:67]
        end
      end
      LOADDATA : begin
        next_state = QUANTMUL; // @[Enum.scala 148:67]
      end
      QUANTMUL : begin
        if((mulif_dout_vld && (! lmfb_line_cnt_ov))) begin
          next_state = LOADDATA; // @[Enum.scala 148:67]
        end else begin
          if((mulif_dout_vld && lmfb_line_cnt_ov)) begin
            next_state = STOREDATA; // @[Enum.scala 148:67]
          end
        end
      end
      default : begin
        if(store_cnt_ov) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          next_state = LOADDATA; // @[Enum.scala 148:67]
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      lmfb_buffer_0 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_1 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_2 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_3 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_4 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_5 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_6 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_7 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_8 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_9 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_10 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_11 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_12 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_13 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_14 <= 8'h0; // @[Data.scala 400:33]
      lmfb_buffer_15 <= 8'h0; // @[Data.scala 400:33]
      lmfb_cnt <= 5'h0; // @[Data.scala 400:33]
      lmfb_line_cnt <= 4'b0000; // @[Data.scala 400:33]
      store_cnt <= 2'b00; // @[Data.scala 400:33]
      lmfb_mem_addr <= 7'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      start_mul <= 1'b0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      start_mul <= ((curr_state == LOADDATA) && (next_state == QUANTMUL)); // @[Reg.scala 39:30]
      if((curr_state == STOREDATA)) begin
        if(store_cnt_ov) begin
          store_cnt <= 2'b00; // @[quant8.scala 103:17]
        end else begin
          store_cnt <= (store_cnt + 2'b01); // @[quant8.scala 105:17]
        end
        if(lmfb_mem_addr_ov) begin
          lmfb_mem_addr <= 7'h0; // @[quant8.scala 108:21]
        end else begin
          lmfb_mem_addr <= (lmfb_mem_addr + 7'h01); // @[quant8.scala 110:21]
        end
      end
      if(((curr_state == QUANTMUL) && mulif_dout_vld)) begin
        if(lmfb_line_cnt_ov) begin
          lmfb_line_cnt <= 4'b0000; // @[quant8.scala 118:21]
        end else begin
          lmfb_line_cnt <= (lmfb_line_cnt + 4'b0001); // @[quant8.scala 120:21]
        end
        if(lmfb_cnt_ov) begin
          lmfb_cnt <= 5'h0; // @[quant8.scala 123:16]
        end else begin
          lmfb_cnt <= (lmfb_cnt + 5'h01); // @[quant8.scala 125:16]
        end
      end
      if(((curr_state == QUANTMUL) && mulif_dout_vld)) begin
        if(tmp_1[0]) begin
          lmfb_buffer_0 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[1]) begin
          lmfb_buffer_1 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[2]) begin
          lmfb_buffer_2 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[3]) begin
          lmfb_buffer_3 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[4]) begin
          lmfb_buffer_4 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[5]) begin
          lmfb_buffer_5 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[6]) begin
          lmfb_buffer_6 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[7]) begin
          lmfb_buffer_7 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[8]) begin
          lmfb_buffer_8 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[9]) begin
          lmfb_buffer_9 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[10]) begin
          lmfb_buffer_10 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[11]) begin
          lmfb_buffer_11 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[12]) begin
          lmfb_buffer_12 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[13]) begin
          lmfb_buffer_13 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[14]) begin
          lmfb_buffer_14 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
        if(tmp_1[15]) begin
          lmfb_buffer_15 <= tmp_lmfb_buffer_0; // @[quant8.scala 129:32]
        end
      end else begin
        if((curr_state == STOREDATA)) begin
          lmfb_buffer_14 <= 8'h0; // @[quant8.scala 131:21]
          lmfb_buffer_15 <= 8'h0; // @[quant8.scala 132:21]
        end
      end
    end
  end


endmodule

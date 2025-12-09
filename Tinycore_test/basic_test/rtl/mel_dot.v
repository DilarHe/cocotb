// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : mel_dot
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module mel_dot (
  input               start,
  output              finish,
  output reg          memif_rd,
  output reg          memif_wr,
  output reg [7:0]    memif_addr,
  output reg [31:0]   memif_wdata,
  input      [31:0]   memif_rdata,
  output              mulif_din_vld,
  output     [31:0]   mulif_dinA,
  output     [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [47:0]   mulif_dout,
  output     [21:0]   mel_out,
  input               clk,
  input               resetn
);
  localparam IDLE = 3'd0;
  localparam FETCH_INDEX = 3'd1;
  localparam LOADMG = 3'd2;
  localparam MULSUM = 3'd3;
  localparam STOREMEL = 3'd4;

  wire       [31:0]   rdsat_din;
  wire       [7:0]    melrom_mel_filter;
  wire       [7:0]    melrom_mel_index;
  wire       [3:0]    melrom_mel_len;
  wire       [21:0]   rdsat_dout;
  wire       [3:0]    tmp_mel_len_cnt_ov;
  wire       [31:0]   tmp_din;
  wire       [31:0]   tmp_memif_wdata;
  wire       [15:0]   tmp_mulif_dinB;
  wire       [33:0]   tmp_sum_buffer;
  reg        [7:0]    mel_filter_addr;
  wire       [7:0]    mel_filter;
  reg        [4:0]    mel_index_addr;
  wire       [7:0]    mel_index;
  wire       [3:0]    mel_len;
  reg        [2:0]    next_state;
  reg        [2:0]    curr_state;
  reg        [33:0]   sum_buffer;
  reg        [7:0]    mel_dot_cnt;
  reg        [3:0]    mel_len_cnt;
  wire                mel_filter_addr_ov;
  wire                mel_index_addr_ov;
  wire                mel_len_cnt_ov;
  wire       [7:0]    tmp_memif_addr;
  reg        [7:0]    tmp_memif_addr_1;
  wire       [7:0]    tmp_memif_addr_2;
  reg        [7:0]    tmp_memif_addr_3;
  reg                 tmp_mulif_din_vld;
  `ifndef SYNTHESIS
  reg [87:0] next_state_string;
  reg [87:0] curr_state_string;
  `endif


  assign tmp_mel_len_cnt_ov = (mel_len - 4'b0001);
  assign tmp_din = sum_buffer[31:0];
  assign tmp_memif_wdata = {10'd0, mel_out};
  assign tmp_mulif_dinB = {8'd0, mel_filter};
  assign tmp_sum_buffer = mulif_dout[33 : 0];
  mel_rom melrom (
    .mel_filter_addr (mel_filter_addr[7:0]  ), //i
    .mel_filter      (melrom_mel_filter[7:0]), //o
    .mel_index_addr  (mel_index_addr[4:0]   ), //i
    .mel_index       (melrom_mel_index[7:0] ), //o
    .mel_len         (melrom_mel_len[3:0]   )  //o
  );
  RoundandSat_1 rdsat (
    .din  (rdsat_din[31:0] ), //i
    .dout (rdsat_dout[21:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE       ";
      FETCH_INDEX : next_state_string = "FETCH_INDEX";
      LOADMG : next_state_string = "LOADMG     ";
      MULSUM : next_state_string = "MULSUM     ";
      STOREMEL : next_state_string = "STOREMEL   ";
      default : next_state_string = "???????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE       ";
      FETCH_INDEX : curr_state_string = "FETCH_INDEX";
      LOADMG : curr_state_string = "LOADMG     ";
      MULSUM : curr_state_string = "MULSUM     ";
      STOREMEL : curr_state_string = "STOREMEL   ";
      default : curr_state_string = "???????????";
    endcase
  end
  `endif

  assign mel_filter = melrom_mel_filter; // @[mel_dot.scala 44:14]
  assign mel_index = melrom_mel_index; // @[mel_dot.scala 45:13]
  assign mel_len = melrom_mel_len; // @[mel_dot.scala 46:11]
  assign mel_filter_addr_ov = (mel_filter_addr == 8'hca); // @[BaseType.scala 305:24]
  assign mel_index_addr_ov = (mel_index_addr == 5'h1d); // @[BaseType.scala 305:24]
  assign mel_len_cnt_ov = (mel_len_cnt == tmp_mel_len_cnt_ov); // @[BaseType.scala 305:24]
  assign rdsat_din = tmp_din; // @[mel_dot.scala 72:16]
  assign mel_out = rdsat_dout[21 : 0]; // @[mel_dot.scala 73:14]
  assign finish = (mel_index_addr_ov && (curr_state == STOREMEL)); // @[mel_dot.scala 75:13]
  always @(*) begin
    memif_rd = 1'b0; // @[mel_dot.scala 77:15]
    if((curr_state == LOADMG)) begin
      memif_rd = 1'b1; // @[mel_dot.scala 55:17]
    end
  end

  always @(*) begin
    memif_wr = 1'b0; // @[mel_dot.scala 78:15]
    if(!(curr_state == LOADMG)) begin
      if((curr_state == STOREMEL)) begin
        memif_wr = 1'b1; // @[mel_dot.scala 49:17]
      end
    end
  end

  always @(*) begin
    memif_addr = 8'h0; // @[mel_dot.scala 79:17]
    if((curr_state == LOADMG)) begin
      memif_addr = tmp_memif_addr_1; // @[mel_dot.scala 56:19]
    end else begin
      if((curr_state == STOREMEL)) begin
        memif_addr = tmp_memif_addr_3; // @[mel_dot.scala 50:19]
      end
    end
  end

  always @(*) begin
    memif_wdata = 32'h0; // @[mel_dot.scala 80:18]
    if(!(curr_state == LOADMG)) begin
      if((curr_state == STOREMEL)) begin
        memif_wdata = tmp_memif_wdata; // @[mel_dot.scala 51:20]
      end
    end
  end

  assign tmp_memif_addr = mel_dot_cnt; // @[BaseType.scala 299:24]
  always @(*) begin
    tmp_memif_addr_1[0] = tmp_memif_addr[7]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[1] = tmp_memif_addr[6]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[2] = tmp_memif_addr[5]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[3] = tmp_memif_addr[4]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[4] = tmp_memif_addr[3]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[5] = tmp_memif_addr[2]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[6] = tmp_memif_addr[1]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[7] = tmp_memif_addr[0]; // @[Utils.scala 432:14]
  end

  assign tmp_memif_addr_2 = {3'd0, mel_index_addr}; // @[BaseType.scala 299:24]
  always @(*) begin
    tmp_memif_addr_3[0] = tmp_memif_addr_2[7]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[1] = tmp_memif_addr_2[6]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[2] = tmp_memif_addr_2[5]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[3] = tmp_memif_addr_2[4]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[4] = tmp_memif_addr_2[3]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[5] = tmp_memif_addr_2[2]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[6] = tmp_memif_addr_2[1]; // @[Utils.scala 432:14]
    tmp_memif_addr_3[7] = tmp_memif_addr_2[0]; // @[Utils.scala 432:14]
  end

  assign mulif_din_vld = tmp_mulif_din_vld; // @[mel_dot.scala 112:20]
  assign mulif_dinA = memif_rdata; // @[mel_dot.scala 113:17]
  assign mulif_dinB = tmp_mulif_dinB; // @[mel_dot.scala 114:17]
  always @(*) begin
    next_state = curr_state; // @[mel_dot.scala 121:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = FETCH_INDEX; // @[Enum.scala 148:67]
        end
      end
      FETCH_INDEX : begin
        next_state = LOADMG; // @[Enum.scala 148:67]
      end
      LOADMG : begin
        next_state = MULSUM; // @[Enum.scala 148:67]
      end
      MULSUM : begin
        if(mulif_dout_vld) begin
          if(mel_len_cnt_ov) begin
            next_state = STOREMEL; // @[Enum.scala 148:67]
          end else begin
            next_state = LOADMG; // @[Enum.scala 148:67]
          end
        end
      end
      default : begin
        if(mel_index_addr_ov) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          next_state = FETCH_INDEX; // @[Enum.scala 148:67]
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      mel_filter_addr <= 8'h0; // @[Data.scala 400:33]
      mel_index_addr <= 5'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      sum_buffer <= 34'h0; // @[Data.scala 400:33]
      mel_dot_cnt <= 8'h0; // @[Data.scala 400:33]
      mel_len_cnt <= 4'b0000; // @[Data.scala 400:33]
      tmp_mulif_din_vld <= 1'b0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      if(((curr_state == MULSUM) && mulif_dout_vld)) begin
        if(mel_filter_addr_ov) begin
          mel_filter_addr <= 8'h0; // @[mel_dot.scala 89:23]
        end else begin
          mel_filter_addr <= (mel_filter_addr + 8'h01); // @[mel_dot.scala 91:23]
        end
      end
      if((curr_state == STOREMEL)) begin
        if(mel_index_addr_ov) begin
          mel_index_addr <= 5'h0; // @[mel_dot.scala 96:22]
        end else begin
          mel_index_addr <= (mel_index_addr + 5'h01); // @[mel_dot.scala 98:22]
        end
      end
      if((curr_state == FETCH_INDEX)) begin
        mel_dot_cnt <= mel_index; // @[mel_dot.scala 103:17]
        mel_len_cnt <= 4'b0000; // @[mel_dot.scala 104:17]
      end else begin
        if(((curr_state == MULSUM) && mulif_dout_vld)) begin
          if((! mel_len_cnt_ov)) begin
            mel_dot_cnt <= (mel_dot_cnt + 8'h01); // @[mel_dot.scala 107:19]
            mel_len_cnt <= (mel_len_cnt + 4'b0001); // @[mel_dot.scala 108:19]
          end
        end
      end
      tmp_mulif_din_vld <= (curr_state == LOADMG); // @[Reg.scala 39:30]
      if(((curr_state == MULSUM) && mulif_dout_vld)) begin
        sum_buffer <= (sum_buffer + tmp_sum_buffer); // @[mel_dot.scala 116:16]
      end else begin
        if((curr_state == FETCH_INDEX)) begin
          sum_buffer <= 34'h0; // @[mel_dot.scala 118:16]
        end
      end
    end
  end


endmodule

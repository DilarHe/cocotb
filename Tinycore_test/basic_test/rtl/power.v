// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : power
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module power (
  input               start,
  output              finish,
  output reg          memif_rd,
  output reg          memif_wr,
  output reg [7:0]    memif_addr,
  output reg [31:0]   memif_wdata,
  input      [31:0]   memif_rdata,
  output              mulif_din_vld,
  output reg [15:0]   mulif_dinA,
  output reg [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [31:0]   mulif_dout,
  output     [21:0]   mag_out,
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam MUL1 = 2'd1;
  localparam MUL2 = 2'd2;
  localparam STORE = 2'd3;

  wire       [32:0]   rdsat_din;
  wire       [21:0]   rdsat_dout;
  wire       [31:0]   tmp_memif_wdata;
  wire       [31:0]   tmp_buffer_data;
  wire       [31:0]   tmp_buffer_data_1;
  wire       [32:0]   tmp_buffer_data_2;
  wire       [31:0]   tmp_buffer_data_3;
  reg        [7:0]    index;
  reg        [32:0]   buffer_data;
  wire       [15:0]   y_real;
  wire       [15:0]   y_imag;
  reg        [1:0]    next_state;
  reg        [1:0]    curr_state;
  wire                mul1_stin;
  reg                 mul1_stin_dly1;
  reg                 mul1_stin_dly2;
  wire                mul2_start;
  wire                store_stin;
  wire                one_power_finish;
  reg                 write_mag2mem_flg;
  reg                 read_mem2mag_flg;
  wire                all_power_wr_finish;
  reg                 all_power_wr_finish_regNext;
  reg        [7:0]    tmp_memif_addr;
  reg        [7:0]    tmp_memif_addr_1;
  `ifndef SYNTHESIS
  reg [39:0] next_state_string;
  reg [39:0] curr_state_string;
  `endif


  assign tmp_memif_wdata = {10'd0, mag_out};
  assign tmp_buffer_data = memif_rdata;
  assign tmp_buffer_data_1 = mulif_dout;
  assign tmp_buffer_data_3 = mulif_dout;
  assign tmp_buffer_data_2 = {1'd0, tmp_buffer_data_3};
  RoundandSat_2 rdsat (
    .din  (rdsat_din[32:0] ), //i
    .dout (rdsat_dout[21:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE ";
      MUL1 : next_state_string = "MUL1 ";
      MUL2 : next_state_string = "MUL2 ";
      STORE : next_state_string = "STORE";
      default : next_state_string = "?????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE ";
      MUL1 : curr_state_string = "MUL1 ";
      MUL2 : curr_state_string = "MUL2 ";
      STORE : curr_state_string = "STORE";
      default : curr_state_string = "?????";
    endcase
  end
  `endif

  assign y_real = buffer_data[31 : 16]; // @[power.scala 43:10]
  assign y_imag = buffer_data[15 : 0]; // @[power.scala 44:10]
  assign rdsat_din = buffer_data; // @[power.scala 46:16]
  assign mag_out = rdsat_dout; // @[power.scala 47:14]
  assign mul1_stin = ((! (curr_state == MUL1)) && (next_state == MUL1)); // @[BaseType.scala 305:24]
  assign mul2_start = ((curr_state == MUL1) && mulif_dout_vld); // @[BaseType.scala 305:24]
  assign store_stin = ((curr_state == MUL2) && (next_state == STORE)); // @[BaseType.scala 305:24]
  assign one_power_finish = ((curr_state == MUL2) && mulif_dout_vld); // @[BaseType.scala 305:24]
  assign all_power_wr_finish = ((index == 8'h80) && write_mag2mem_flg); // @[BaseType.scala 305:24]
  assign finish = all_power_wr_finish_regNext; // @[power.scala 63:13]
  always @(*) begin
    memif_rd = 1'b0; // @[power.scala 65:15]
    if(mul1_stin) begin
      memif_rd = 1'b1; // @[power.scala 34:17]
    end
  end

  always @(*) begin
    memif_wr = 1'b0; // @[power.scala 66:15]
    if(!mul1_stin) begin
      if(write_mag2mem_flg) begin
        memif_wr = 1'b1; // @[power.scala 29:17]
      end
    end
  end

  always @(*) begin
    memif_addr = 8'h0; // @[power.scala 67:17]
    if(mul1_stin) begin
      memif_addr = tmp_memif_addr; // @[power.scala 35:19]
    end else begin
      if(write_mag2mem_flg) begin
        memif_addr = tmp_memif_addr_1; // @[power.scala 30:19]
      end
    end
  end

  always @(*) begin
    memif_wdata = 32'h0; // @[power.scala 68:18]
    if(!mul1_stin) begin
      if(write_mag2mem_flg) begin
        memif_wdata = tmp_memif_wdata; // @[power.scala 31:20]
      end
    end
  end

  always @(*) begin
    tmp_memif_addr[0] = index[7]; // @[Utils.scala 432:14]
    tmp_memif_addr[1] = index[6]; // @[Utils.scala 432:14]
    tmp_memif_addr[2] = index[5]; // @[Utils.scala 432:14]
    tmp_memif_addr[3] = index[4]; // @[Utils.scala 432:14]
    tmp_memif_addr[4] = index[3]; // @[Utils.scala 432:14]
    tmp_memif_addr[5] = index[2]; // @[Utils.scala 432:14]
    tmp_memif_addr[6] = index[1]; // @[Utils.scala 432:14]
    tmp_memif_addr[7] = index[0]; // @[Utils.scala 432:14]
  end

  always @(*) begin
    tmp_memif_addr_1[0] = index[7]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[1] = index[6]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[2] = index[5]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[3] = index[4]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[4] = index[3]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[5] = index[2]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[6] = index[1]; // @[Utils.scala 432:14]
    tmp_memif_addr_1[7] = index[0]; // @[Utils.scala 432:14]
  end

  assign mulif_din_vld = (mul1_stin_dly2 || mul2_start); // @[power.scala 82:20]
  always @(*) begin
    mulif_dinA = 16'h0; // @[power.scala 83:17]
    if(mul1_stin_dly2) begin
      mulif_dinA = y_real; // @[power.scala 86:19]
    end else begin
      if(mul2_start) begin
        mulif_dinA = y_imag; // @[power.scala 89:19]
      end
    end
  end

  always @(*) begin
    mulif_dinB = 16'h0; // @[power.scala 84:17]
    if(mul1_stin_dly2) begin
      mulif_dinB = y_real; // @[power.scala 87:19]
    end else begin
      if(mul2_start) begin
        mulif_dinB = y_imag; // @[power.scala 90:19]
      end
    end
  end

  always @(*) begin
    next_state = curr_state; // @[power.scala 101:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = MUL1; // @[Enum.scala 148:67]
        end
      end
      MUL1 : begin
        if(mulif_dout_vld) begin
          next_state = MUL2; // @[Enum.scala 148:67]
        end
      end
      MUL2 : begin
        if(mulif_dout_vld) begin
          next_state = STORE; // @[Enum.scala 148:67]
        end
      end
      default : begin
        if(all_power_wr_finish) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          if(read_mem2mag_flg) begin
            next_state = MUL1; // @[Enum.scala 148:67]
          end
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      index <= 8'h0; // @[Data.scala 400:33]
      buffer_data <= 33'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      mul1_stin_dly1 <= 1'b0; // @[Data.scala 400:33]
      mul1_stin_dly2 <= 1'b0; // @[Data.scala 400:33]
      write_mag2mem_flg <= 1'b0; // @[Data.scala 400:33]
      read_mem2mag_flg <= 1'b0; // @[Data.scala 400:33]
      all_power_wr_finish_regNext <= 1'b0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      mul1_stin_dly1 <= mul1_stin; // @[Reg.scala 39:30]
      mul1_stin_dly2 <= mul1_stin_dly1; // @[Reg.scala 39:30]
      write_mag2mem_flg <= store_stin; // @[Reg.scala 39:30]
      read_mem2mag_flg <= write_mag2mem_flg; // @[Reg.scala 39:30]
      all_power_wr_finish_regNext <= all_power_wr_finish; // @[Reg.scala 39:30]
      if(mul1_stin_dly1) begin
        buffer_data <= {1'd0, tmp_buffer_data}; // @[power.scala 75:17]
      end else begin
        if(mul2_start) begin
          buffer_data <= {1'd0, tmp_buffer_data_1}; // @[power.scala 77:17]
        end else begin
          if(one_power_finish) begin
            buffer_data <= (buffer_data + tmp_buffer_data_2); // @[power.scala 79:17]
          end
        end
      end
      if(write_mag2mem_flg) begin
        if(all_power_wr_finish) begin
          index <= 8'h0; // @[power.scala 95:13]
        end else begin
          index <= (index + 8'h01); // @[power.scala 97:13]
        end
      end
    end
  end


endmodule

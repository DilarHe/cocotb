// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : qfft
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module qfft (
  input               start,
  output              finish,
  output reg          memif_rd,
  output reg          memif_wr,
  output reg [7:0]    memif_addr,
  output reg [31:0]   memif_wdata,
  input      [31:0]   memif_rdata,
  output              mulif_din_vld,
  output     [15:0]   mulif_dinA,
  output     [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [31:0]   mulif_dout,
  input               clk,
  input               resetn
);
  localparam IDLE = 3'd0;
  localparam LOADXQ = 3'd1;
  localparam LOADXP = 3'd2;
  localparam WAIT_STOREYQ = 3'd3;
  localparam STOREYP = 3'd4;

  wire                butterfly_1_finish;
  wire       [15:0]   butterfly_1_yp_real;
  wire       [15:0]   butterfly_1_yp_imag;
  wire       [15:0]   butterfly_1_yq_real;
  wire       [15:0]   butterfly_1_yq_imag;
  wire                butterfly_1_mulif_din_vld;
  wire       [15:0]   butterfly_1_mulif_dinA;
  wire       [15:0]   butterfly_1_mulif_dinB;
  wire       [15:0]   Wnrom_io_wn_real;
  wire       [15:0]   Wnrom_io_wn_imag;
  wire       [0:0]    tmp_inverse_g_cnt_0;
  wire       [0:0]    tmp_inverse_g_cnt_1;
  wire       [3:0]    tmp_stage_inverse;
  wire       [7:0]    tmp_xaddr_base;
  wire       [7:0]    tmp_xp_rd_addr;
  wire       [6:0]    tmp_wn_rd_addr;
  reg        [6:0]    tmp_wn_rd_addr_1;
  wire       [6:0]    tmp_wn_rd_addr_2;
  wire       [6:0]    tmp_wn_rd_addr_3;
  wire       [6:0]    tmp_wn_rd_addr_4;
  wire       [6:0]    tmp_wn_rd_addr_5;
  wire       [6:0]    tmp_wn_rd_addr_6;
  wire       [6:0]    tmp_wn_rd_addr_7;
  wire       [6:0]    tmp_wn_rd_addr_8;
  wire       [3:0]    tmp_wn_rd_addr_9;
  wire       [7:0]    tmp_flg_cnt_btfly_done;
  wire       [7:0]    tmp_flg_cnt_btfly_done_1;
  wire       [7:0]    tmp_flg_cnt_group_done;
  wire       [7:0]    tmp_flg_cnt_group_done_1;
  wire       [15:0]   tmp_xq_imag_reg;
  wire       [15:0]   tmp_xq_imag_reg_1;
  wire       [15:0]   tmp_xp_imag_reg;
  wire       [15:0]   tmp_xp_imag_reg_1;
  reg        [2:0]    cnt_stage;
  reg        [6:0]    cnt_group;
  reg        [6:0]    cnt_butterfly;
  wire       [7:0]    max_group_num;
  wire       [7:0]    max_butfly_num;
  wire       [0:0]    inverse_g_cnt_0;
  wire       [0:0]    inverse_g_cnt_1;
  wire       [1:0]    tmp_inverse_g_cnt_2;
  reg        [1:0]    inverse_g_cnt_2;
  wire       [2:0]    tmp_inverse_g_cnt_3;
  reg        [2:0]    inverse_g_cnt_3;
  wire       [3:0]    tmp_inverse_g_cnt_4;
  reg        [3:0]    inverse_g_cnt_4;
  wire       [4:0]    tmp_inverse_g_cnt_5;
  reg        [4:0]    inverse_g_cnt_5;
  wire       [5:0]    tmp_inverse_g_cnt_6;
  reg        [5:0]    inverse_g_cnt_6;
  wire       [6:0]    tmp_inverse_g_cnt_7;
  reg        [6:0]    inverse_g_cnt_7;
  wire       [7:0]    xaddr_base;
  wire       [7:0]    xp_rd_addr;
  wire       [7:0]    xq_rd_addr;
  wire       [6:0]    wn_rd_addr;
  wire       [3:0]    stage_inverse;
  wire                butterfly_start;
  wire                butterfly_finish;
  wire       [15:0]   xp_real;
  wire       [15:0]   xp_imag;
  wire       [15:0]   xq_real;
  wire       [15:0]   xq_imag;
  wire       [15:0]   wn_real;
  wire       [15:0]   wn_imag;
  wire       [15:0]   yp_real;
  wire       [15:0]   yp_imag;
  wire       [15:0]   yq_real;
  wire       [15:0]   yq_imag;
  reg                 butfly_cnt_incr;
  reg                 butfly_done;
  wire                flg_fft_finish;
  wire                flg_cnt_btfly_done;
  wire                flg_cnt_group_done;
  wire                flg_cnt_stage_done;
  reg        [2:0]    next_state;
  reg        [2:0]    curr_state;
  reg        [6:0]    rom_wn_addr;
  reg        [15:0]   xp_real_reg;
  reg        [15:0]   xp_imag_reg;
  reg        [15:0]   xq_real_reg;
  reg        [15:0]   xq_imag_reg;
  reg                 load_xq_vld;
  reg                 load_xp_vld;
  wire                first_satge_imag_zero;
  `ifndef SYNTHESIS
  reg [95:0] next_state_string;
  reg [95:0] curr_state_string;
  `endif


  assign tmp_inverse_g_cnt_0 = cnt_group[0 : 0];
  assign tmp_inverse_g_cnt_1 = cnt_group[0 : 0];
  assign tmp_stage_inverse = {1'd0, cnt_stage};
  assign tmp_xaddr_base = {1'd0, cnt_group};
  assign tmp_xp_rd_addr = {1'd0, cnt_butterfly};
  assign tmp_wn_rd_addr = (tmp_wn_rd_addr_1 <<< tmp_wn_rd_addr_9);
  assign tmp_wn_rd_addr_2 = {6'd0, inverse_g_cnt_0};
  assign tmp_wn_rd_addr_3 = {6'd0, inverse_g_cnt_1};
  assign tmp_wn_rd_addr_4 = {5'd0, inverse_g_cnt_2};
  assign tmp_wn_rd_addr_5 = {4'd0, inverse_g_cnt_3};
  assign tmp_wn_rd_addr_6 = {3'd0, inverse_g_cnt_4};
  assign tmp_wn_rd_addr_7 = {2'd0, inverse_g_cnt_5};
  assign tmp_wn_rd_addr_8 = {1'd0, inverse_g_cnt_6};
  assign tmp_wn_rd_addr_9 = (stage_inverse - 4'b0001);
  assign tmp_flg_cnt_btfly_done = {1'd0, cnt_butterfly};
  assign tmp_flg_cnt_btfly_done_1 = (max_butfly_num - 8'h01);
  assign tmp_flg_cnt_group_done = {1'd0, cnt_group};
  assign tmp_flg_cnt_group_done_1 = (max_group_num - 8'h01);
  assign tmp_xq_imag_reg = 16'h0;
  assign tmp_xq_imag_reg_1 = memif_rdata[15 : 0];
  assign tmp_xp_imag_reg = 16'h0;
  assign tmp_xp_imag_reg_1 = memif_rdata[15 : 0];
  butterfly_unit butterfly_1 (
    .start            (butterfly_start             ), //i
    .finish           (butterfly_1_finish          ), //o
    .xp_real          (xp_real[15:0]               ), //i
    .xp_imag          (xp_imag[15:0]               ), //i
    .xq_real          (xq_real[15:0]               ), //i
    .xq_imag          (xq_imag[15:0]               ), //i
    .wn_real          (wn_real[15:0]               ), //i
    .wn_imag          (wn_imag[15:0]               ), //i
    .yp_real          (butterfly_1_yp_real[15:0]   ), //o
    .yp_imag          (butterfly_1_yp_imag[15:0]   ), //o
    .yq_real          (butterfly_1_yq_real[15:0]   ), //o
    .yq_imag          (butterfly_1_yq_imag[15:0]   ), //o
    .mulif_din_vld    (butterfly_1_mulif_din_vld   ), //o
    .mulif_dinA       (butterfly_1_mulif_dinA[15:0]), //o
    .mulif_dinB       (butterfly_1_mulif_dinB[15:0]), //o
    .mulif_dout_vld   (mulif_dout_vld              ), //i
    .mulif_cal_finish (mulif_cal_finish            ), //i
    .mulif_dout       (mulif_dout[31:0]            ), //i
    .clk              (clk                         ), //i
    .resetn           (resetn                      )  //i
  );
  wn_rom Wnrom (
    .io_wn_addr (rom_wn_addr[6:0]      ), //i
    .io_wn_real (Wnrom_io_wn_real[15:0]), //o
    .io_wn_imag (Wnrom_io_wn_imag[15:0])  //o
  );
  always @(*) begin
    case(cnt_stage)
      3'b000 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_2;
      3'b001 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_3;
      3'b010 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_4;
      3'b011 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_5;
      3'b100 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_6;
      3'b101 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_7;
      3'b110 : tmp_wn_rd_addr_1 = tmp_wn_rd_addr_8;
      default : tmp_wn_rd_addr_1 = inverse_g_cnt_7;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE        ";
      LOADXQ : next_state_string = "LOADXQ      ";
      LOADXP : next_state_string = "LOADXP      ";
      WAIT_STOREYQ : next_state_string = "WAIT_STOREYQ";
      STOREYP : next_state_string = "STOREYP     ";
      default : next_state_string = "????????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE        ";
      LOADXQ : curr_state_string = "LOADXQ      ";
      LOADXP : curr_state_string = "LOADXP      ";
      WAIT_STOREYQ : curr_state_string = "WAIT_STOREYQ";
      STOREYP : curr_state_string = "STOREYP     ";
      default : curr_state_string = "????????????";
    endcase
  end
  `endif

  assign inverse_g_cnt_0[0] = tmp_inverse_g_cnt_0[0]; // @[Utils.scala 432:14]
  assign inverse_g_cnt_1[0] = tmp_inverse_g_cnt_1[0]; // @[Utils.scala 432:14]
  assign tmp_inverse_g_cnt_2 = cnt_group[1 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_2[0] = tmp_inverse_g_cnt_2[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_2[1] = tmp_inverse_g_cnt_2[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_3 = cnt_group[2 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_3[0] = tmp_inverse_g_cnt_3[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_3[1] = tmp_inverse_g_cnt_3[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_3[2] = tmp_inverse_g_cnt_3[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_4 = cnt_group[3 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_4[0] = tmp_inverse_g_cnt_4[3]; // @[Utils.scala 432:14]
    inverse_g_cnt_4[1] = tmp_inverse_g_cnt_4[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_4[2] = tmp_inverse_g_cnt_4[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_4[3] = tmp_inverse_g_cnt_4[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_5 = cnt_group[4 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_5[0] = tmp_inverse_g_cnt_5[4]; // @[Utils.scala 432:14]
    inverse_g_cnt_5[1] = tmp_inverse_g_cnt_5[3]; // @[Utils.scala 432:14]
    inverse_g_cnt_5[2] = tmp_inverse_g_cnt_5[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_5[3] = tmp_inverse_g_cnt_5[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_5[4] = tmp_inverse_g_cnt_5[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_6 = cnt_group[5 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_6[0] = tmp_inverse_g_cnt_6[5]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[1] = tmp_inverse_g_cnt_6[4]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[2] = tmp_inverse_g_cnt_6[3]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[3] = tmp_inverse_g_cnt_6[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[4] = tmp_inverse_g_cnt_6[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_6[5] = tmp_inverse_g_cnt_6[0]; // @[Utils.scala 432:14]
  end

  assign tmp_inverse_g_cnt_7 = cnt_group[6 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    inverse_g_cnt_7[0] = tmp_inverse_g_cnt_7[6]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[1] = tmp_inverse_g_cnt_7[5]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[2] = tmp_inverse_g_cnt_7[4]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[3] = tmp_inverse_g_cnt_7[3]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[4] = tmp_inverse_g_cnt_7[2]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[5] = tmp_inverse_g_cnt_7[1]; // @[Utils.scala 432:14]
    inverse_g_cnt_7[6] = tmp_inverse_g_cnt_7[0]; // @[Utils.scala 432:14]
  end

  assign max_group_num = (8'h01 <<< cnt_stage); // @[qfft.scala 51:17]
  assign max_butfly_num = (8'h80 >>> cnt_stage); // @[qfft.scala 52:18]
  assign stage_inverse = (4'b1000 - tmp_stage_inverse); // @[qfft.scala 59:17]
  assign xaddr_base = (tmp_xaddr_base <<< stage_inverse); // @[qfft.scala 60:14]
  assign xp_rd_addr = (xaddr_base + tmp_xp_rd_addr); // @[qfft.scala 61:14]
  assign xq_rd_addr = (xp_rd_addr + max_butfly_num); // @[qfft.scala 62:14]
  assign wn_rd_addr = tmp_wn_rd_addr; // @[qfft.scala 63:14]
  assign butterfly_finish = butterfly_1_finish; // @[qfft.scala 75:23]
  assign yp_real = butterfly_1_yp_real; // @[qfft.scala 79:6]
  assign yp_imag = butterfly_1_yp_imag; // @[qfft.scala 79:6]
  assign yq_real = butterfly_1_yq_real; // @[qfft.scala 80:6]
  assign yq_imag = butterfly_1_yq_imag; // @[qfft.scala 80:6]
  assign mulif_din_vld = butterfly_1_mulif_din_vld; // @[qfft.scala 82:12]
  assign mulif_dinA = butterfly_1_mulif_dinA; // @[qfft.scala 82:12]
  assign mulif_dinB = butterfly_1_mulif_dinB; // @[qfft.scala 82:12]
  assign flg_cnt_btfly_done = (tmp_flg_cnt_btfly_done == tmp_flg_cnt_btfly_done_1); // @[qfft.scala 93:22]
  assign flg_cnt_group_done = (tmp_flg_cnt_group_done == tmp_flg_cnt_group_done_1); // @[qfft.scala 94:22]
  assign flg_cnt_stage_done = (cnt_stage == 3'b111); // @[qfft.scala 95:22]
  assign flg_fft_finish = ((butfly_cnt_incr && flg_cnt_btfly_done) && (flg_cnt_group_done && flg_cnt_stage_done)); // @[qfft.scala 96:18]
  assign finish = flg_fft_finish; // @[qfft.scala 98:13]
  always @(*) begin
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = LOADXQ; // @[Enum.scala 148:67]
        end else begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end
      end
      LOADXQ : begin
        next_state = LOADXP; // @[Enum.scala 148:67]
      end
      LOADXP : begin
        next_state = WAIT_STOREYQ; // @[Enum.scala 148:67]
      end
      WAIT_STOREYQ : begin
        if(butterfly_finish) begin
          next_state = STOREYP; // @[Enum.scala 148:67]
        end else begin
          next_state = WAIT_STOREYQ; // @[Enum.scala 148:67]
        end
      end
      default : begin
        if(finish) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          next_state = LOADXQ; // @[Enum.scala 148:67]
        end
      end
    endcase
  end

  always @(*) begin
    memif_rd = 1'b0; // @[qfft.scala 167:15]
    case(curr_state)
      IDLE : begin
      end
      LOADXQ : begin
        memif_rd = 1'b1; // @[qfft.scala 132:17]
      end
      LOADXP : begin
        memif_rd = 1'b1; // @[qfft.scala 132:17]
      end
      WAIT_STOREYQ : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    memif_wr = 1'b0; // @[qfft.scala 168:15]
    case(curr_state)
      IDLE : begin
      end
      LOADXQ : begin
        memif_wr = 1'b0; // @[qfft.scala 133:17]
      end
      LOADXP : begin
        memif_wr = 1'b0; // @[qfft.scala 133:17]
      end
      WAIT_STOREYQ : begin
        if(butterfly_finish) begin
          memif_wr = 1'b1; // @[qfft.scala 127:17]
        end
      end
      default : begin
        memif_wr = 1'b1; // @[qfft.scala 127:17]
      end
    endcase
  end

  always @(*) begin
    memif_wdata = 32'h0; // @[qfft.scala 169:18]
    case(curr_state)
      IDLE : begin
      end
      LOADXQ : begin
      end
      LOADXP : begin
      end
      WAIT_STOREYQ : begin
        if(butterfly_finish) begin
          memif_wdata = {yq_real,yq_imag}; // @[qfft.scala 129:20]
        end
      end
      default : begin
        memif_wdata = {yp_real,yp_imag}; // @[qfft.scala 129:20]
      end
    endcase
  end

  always @(*) begin
    memif_addr = 8'h0; // @[qfft.scala 170:17]
    case(curr_state)
      IDLE : begin
      end
      LOADXQ : begin
        memif_addr = xq_rd_addr; // @[qfft.scala 134:19]
      end
      LOADXP : begin
        memif_addr = xp_rd_addr; // @[qfft.scala 134:19]
      end
      WAIT_STOREYQ : begin
        if(butterfly_finish) begin
          memif_addr = xq_rd_addr; // @[qfft.scala 128:19]
        end
      end
      default : begin
        memif_addr = xp_rd_addr; // @[qfft.scala 128:19]
      end
    endcase
  end

  assign first_satge_imag_zero = (cnt_stage == 3'b000); // @[qfft.scala 199:25]
  assign butterfly_start = load_xp_vld; // @[qfft.scala 209:19]
  assign xp_real = xp_real_reg; // @[qfft.scala 210:11]
  assign xp_imag = xp_imag_reg; // @[qfft.scala 211:11]
  assign xq_real = xq_real_reg; // @[qfft.scala 212:11]
  assign xq_imag = xq_imag_reg; // @[qfft.scala 213:11]
  assign wn_real = Wnrom_io_wn_real; // @[qfft.scala 217:6]
  assign wn_imag = Wnrom_io_wn_imag; // @[qfft.scala 217:6]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      cnt_stage <= 3'b000; // @[Data.scala 400:33]
      cnt_group <= 7'h0; // @[Data.scala 400:33]
      cnt_butterfly <= 7'h0; // @[Data.scala 400:33]
      butfly_cnt_incr <= 1'b0; // @[Data.scala 400:33]
      butfly_done <= 1'b0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      rom_wn_addr <= 7'h0; // @[Data.scala 400:33]
      xp_real_reg <= 16'h0; // @[Data.scala 400:33]
      xp_imag_reg <= 16'h0; // @[Data.scala 400:33]
      xq_real_reg <= 16'h0; // @[Data.scala 400:33]
      xq_imag_reg <= 16'h0; // @[Data.scala 400:33]
      load_xq_vld <= 1'b0; // @[Data.scala 400:33]
      load_xp_vld <= 1'b0; // @[Data.scala 400:33]
    end else begin
      butfly_cnt_incr <= butterfly_finish; // @[Reg.scala 39:30]
      butfly_done <= butfly_cnt_incr; // @[Reg.scala 39:30]
      if(butfly_cnt_incr) begin
        if(flg_cnt_btfly_done) begin
          cnt_butterfly <= 7'h0; // @[qfft.scala 102:21]
          if(flg_cnt_group_done) begin
            cnt_group <= 7'h0; // @[qfft.scala 104:19]
            if(flg_cnt_stage_done) begin
              cnt_stage <= 3'b000; // @[qfft.scala 106:21]
            end else begin
              cnt_stage <= (cnt_stage + 3'b001); // @[qfft.scala 108:21]
            end
          end else begin
            cnt_group <= (cnt_group + 7'h01); // @[qfft.scala 111:19]
          end
        end else begin
          cnt_butterfly <= (cnt_butterfly + 7'h01); // @[qfft.scala 114:21]
        end
      end
      curr_state <= next_state; // @[Reg.scala 39:30]
      case(curr_state)
        IDLE : begin
        end
        LOADXQ : begin
          rom_wn_addr <= wn_rd_addr; // @[qfft.scala 176:19]
        end
        LOADXP : begin
        end
        WAIT_STOREYQ : begin
        end
        default : begin
        end
      endcase
      load_xq_vld <= (curr_state == LOADXQ); // @[Reg.scala 39:30]
      load_xp_vld <= load_xq_vld; // @[Reg.scala 39:30]
      if(load_xq_vld) begin
        xq_real_reg <= memif_rdata[31 : 16]; // @[qfft.scala 202:17]
        xq_imag_reg <= (first_satge_imag_zero ? tmp_xq_imag_reg : tmp_xq_imag_reg_1); // @[qfft.scala 203:17]
      end
      if(load_xp_vld) begin
        xp_real_reg <= memif_rdata[31 : 16]; // @[qfft.scala 206:17]
        xp_imag_reg <= (first_satge_imag_zero ? tmp_xp_imag_reg : tmp_xp_imag_reg_1); // @[qfft.scala 207:17]
      end
    end
  end


endmodule

// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : cordic_ln
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module cordic_ln (
  input               start,
  output              finish,
  output reg          memif_rd,
  output reg          memif_wr,
  output reg [7:0]    memif_addr,
  output reg [31:0]   memif_wdata,
  input      [31:0]   memif_rdata,
  output     [15:0]   cordic_ln_out,
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam LOADDATA = 2'd1;
  localparam CORDIC = 2'd2;
  localparam STOREDATA = 2'd3;

  wire       [15:0]   rdsat_dout;
  wire       [18:0]   tmp_tmp_ln_x_to_lg;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_5;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_5_1;
  wire       [3:0]    tmp_when;
  wire       [15:0]   tmp_tmp_ln_x_to_lg_7;
  wire       [15:0]   tmp_tmp_ln_x_to_lg_7_1;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_1;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_1_1;
  wire       [19:0]   tmp_tmp_ln_x_to_lg_1_2;
  wire       [1:0]    tmp_when_1;
  wire       [0:0]    tmp_when_2;
  reg        [3:0]    tmp_tmp_xi;
  wire       [3:0]    tmp_tmp_xi_1;
  wire       [26:0]   tmp_xi_2;
  wire       [26:0]   tmp_xi_3;
  wire       [3:0]    tmp_tmp_yi;
  wire       [26:0]   tmp_yi_1;
  wire       [26:0]   tmp_yi_2;
  wire       [26:0]   tmp_xi_4;
  wire       [26:0]   tmp_yi_3;
  reg        [15:0]   tmp_ei;
  wire       [19:0]   tmp_tmp_z_reg;
  wire       [19:0]   tmp_tmp_z_reg_1;
  wire       [19:0]   tmp_tmp_z_reg_2;
  wire       [20:0]   tmp_tmp_z_reg_1_1;
  wire       [20:0]   tmp_tmp_z_reg_1_2;
  wire       [1:0]    tmp_when_3;
  wire       [0:0]    tmp_when_4;
  wire       [26:0]   tmp_tmp_x_reg;
  wire       [26:0]   tmp_tmp_x_reg_1;
  wire       [26:0]   tmp_tmp_x_reg_2;
  wire       [27:0]   tmp_tmp_x_reg_1_1;
  wire       [26:0]   tmp_tmp_x_reg_1_2;
  wire       [27:0]   tmp_tmp_x_reg_1_3;
  wire       [2:0]    tmp_when_5;
  wire       [1:0]    tmp_when_6;
  wire       [26:0]   tmp_tmp_y_reg;
  wire       [26:0]   tmp_tmp_y_reg_1;
  wire       [26:0]   tmp_tmp_y_reg_2;
  wire       [27:0]   tmp_tmp_y_reg_1_1;
  wire       [26:0]   tmp_tmp_y_reg_1_2;
  wire       [27:0]   tmp_tmp_y_reg_1_3;
  wire       [2:0]    tmp_when_7;
  wire       [1:0]    tmp_when_8;
  wire       [25:0]   tmp_x_reg_3;
  wire       [25:0]   tmp_x_reg_4;
  wire       [25:0]   tmp_x_reg_5;
  wire       [25:0]   tmp_x_reg_6;
  wire       [25:0]   tmp_y_reg_3;
  wire       [25:0]   tmp_y_reg_4;
  wire       [25:0]   tmp_y_reg_5;
  wire       [25:0]   tmp_y_reg_6;
  wire       [31:0]   tmp_memif_wdata;
  wire       [3:0]    iters_0;
  wire       [3:0]    iters_1;
  wire       [3:0]    iters_2;
  wire       [3:0]    iters_3;
  wire       [3:0]    iters_4;
  wire       [3:0]    iters_5;
  wire       [3:0]    iters_6;
  wire       [3:0]    iters_7;
  wire       [3:0]    iters_8;
  wire       [3:0]    iters_9;
  wire       [3:0]    iters_10;
  wire       [3:0]    iters_11;
  wire       [15:0]   e_data_0;
  wire       [15:0]   e_data_1;
  wire       [15:0]   e_data_2;
  wire       [15:0]   e_data_3;
  wire       [15:0]   e_data_4;
  wire       [15:0]   e_data_5;
  wire       [15:0]   e_data_6;
  wire       [15:0]   e_data_7;
  wire       [15:0]   e_data_8;
  wire       [15:0]   e_data_9;
  wire       [15:0]   e_data_10;
  wire       [15:0]   e_data_11;
  reg        [25:0]   x_reg;
  reg        [25:0]   y_reg;
  reg        [19:0]   z_reg;
  reg        [26:0]   xi;
  reg        [26:0]   yi;
  wire                di;
  reg        [3:0]    cnt;
  reg        [4:0]    mel_addr;
  wire       [15:0]   ln_out;
  wire       [20:0]   zreg_mul2;
  wire       [18:0]   ln_x_shift1;
  wire       [18:0]   tmp_ln_x_to_lg;
  reg        [15:0]   tmp_ln_x_to_lg_1;
  wire       [18:0]   tmp_ln_x_to_lg_2;
  wire       [18:0]   tmp_ln_x_to_lg_3;
  wire       [18:0]   tmp_ln_x_to_lg_4;
  wire       [19:0]   tmp_ln_x_to_lg_5;
  wire       [18:0]   tmp_ln_x_to_lg_6;
  reg        [15:0]   tmp_ln_x_to_lg_7;
  reg        [14:0]   ln_x_to_lg;
  wire                mel_addr_ov;
  wire                cordic_end;
  reg        [1:0]    next_state;
  reg        [1:0]    curr_state;
  wire                load_stin;
  reg                 store_en;
  reg                 store_en_delay;
  wire       [3:0]    tmp_xi;
  wire       [25:0]   tmp_xi_1;
  wire       [25:0]   tmp_yi;
  wire       [19:0]   ei;
  wire       [19:0]   tmp_z_reg;
  wire       [20:0]   tmp_z_reg_1;
  reg        [19:0]   tmp_z_reg_2;
  wire       [26:0]   tmp_x_reg;
  wire       [27:0]   tmp_x_reg_1;
  reg        [25:0]   tmp_x_reg_2;
  wire       [26:0]   tmp_y_reg;
  wire       [27:0]   tmp_y_reg_1;
  reg        [25:0]   tmp_y_reg_2;
  wire       [7:0]    tmp_memif_addr;
  reg        [7:0]    tmp_memif_addr_1;
  wire       [7:0]    tmp_memif_addr_2;
  reg        [7:0]    tmp_memif_addr_3;
  `ifndef SYNTHESIS
  reg [71:0] next_state_string;
  reg [71:0] curr_state_string;
  `endif


  assign tmp_tmp_ln_x_to_lg = {{3{ln_out[15]}}, ln_out};
  assign tmp_tmp_ln_x_to_lg_5 = {tmp_ln_x_to_lg_4[18],tmp_ln_x_to_lg_4};
  assign tmp_tmp_ln_x_to_lg_5_1 = {tmp_ln_x_to_lg_3[18],tmp_ln_x_to_lg_3};
  assign tmp_when = tmp_ln_x_to_lg_5[3 : 0];
  assign tmp_tmp_ln_x_to_lg_7 = tmp_ln_x_to_lg_5[19 : 4];
  assign tmp_tmp_ln_x_to_lg_7_1 = 16'h0001;
  assign tmp_tmp_ln_x_to_lg_1 = ($signed(tmp_tmp_ln_x_to_lg_1_1) + $signed(tmp_tmp_ln_x_to_lg_1_2));
  assign tmp_tmp_ln_x_to_lg_1_1 = {tmp_ln_x_to_lg_6[18],tmp_ln_x_to_lg_6};
  assign tmp_tmp_ln_x_to_lg_1_2 = {tmp_ln_x_to_lg_2[18],tmp_ln_x_to_lg_2};
  assign tmp_when_1 = tmp_ln_x_to_lg_1[15 : 14];
  assign tmp_when_2 = tmp_ln_x_to_lg_1[14 : 14];
  assign tmp_tmp_xi_1 = (tmp_xi + 4'b0010);
  assign tmp_xi_2 = {x_reg[25],x_reg};
  assign tmp_xi_3 = {tmp_xi_1[25],tmp_xi_1};
  assign tmp_tmp_yi = (tmp_xi + 4'b0010);
  assign tmp_yi_1 = {y_reg[25],y_reg};
  assign tmp_yi_2 = {tmp_yi[25],tmp_yi};
  assign tmp_xi_4 = {{1{x_reg[25]}}, x_reg};
  assign tmp_yi_3 = {{1{y_reg[25]}}, y_reg};
  assign tmp_tmp_z_reg = ($signed(tmp_tmp_z_reg_1) + $signed(tmp_tmp_z_reg_2));
  assign tmp_tmp_z_reg_1 = (~ ei);
  assign tmp_tmp_z_reg_2 = 20'h00001;
  assign tmp_tmp_z_reg_1_1 = {z_reg[19],z_reg};
  assign tmp_tmp_z_reg_1_2 = {tmp_z_reg[19],tmp_z_reg};
  assign tmp_when_3 = tmp_z_reg_1[20 : 19];
  assign tmp_when_4 = tmp_z_reg_1[19 : 19];
  assign tmp_tmp_x_reg = ($signed(tmp_tmp_x_reg_1) + $signed(tmp_tmp_x_reg_2));
  assign tmp_tmp_x_reg_1 = (~ yi);
  assign tmp_tmp_x_reg_2 = 27'h0000001;
  assign tmp_tmp_x_reg_1_2 = {x_reg[25],x_reg};
  assign tmp_tmp_x_reg_1_1 = {{1{tmp_tmp_x_reg_1_2[26]}}, tmp_tmp_x_reg_1_2};
  assign tmp_tmp_x_reg_1_3 = {tmp_x_reg[26],tmp_x_reg};
  assign tmp_when_5 = tmp_x_reg_1[27 : 25];
  assign tmp_when_6 = tmp_x_reg_1[26 : 25];
  assign tmp_tmp_y_reg = ($signed(tmp_tmp_y_reg_1) + $signed(tmp_tmp_y_reg_2));
  assign tmp_tmp_y_reg_1 = (~ xi);
  assign tmp_tmp_y_reg_2 = 27'h0000001;
  assign tmp_tmp_y_reg_1_2 = {y_reg[25],y_reg};
  assign tmp_tmp_y_reg_1_1 = {{1{tmp_tmp_y_reg_1_2[26]}}, tmp_tmp_y_reg_1_2};
  assign tmp_tmp_y_reg_1_3 = {tmp_y_reg[26],tmp_y_reg};
  assign tmp_when_7 = tmp_y_reg_1[27 : 25];
  assign tmp_when_8 = tmp_y_reg_1[26 : 25];
  assign tmp_x_reg_3 = ($signed(tmp_x_reg_4) + $signed(tmp_x_reg_5));
  assign tmp_x_reg_4 = memif_rdata[25 : 0];
  assign tmp_x_reg_5 = 26'h0004000;
  assign tmp_x_reg_6 = 26'h0000010;
  assign tmp_y_reg_3 = ($signed(tmp_y_reg_4) - $signed(tmp_y_reg_5));
  assign tmp_y_reg_4 = memif_rdata[25 : 0];
  assign tmp_y_reg_5 = 26'h0004000;
  assign tmp_y_reg_6 = 26'h0000010;
  assign tmp_memif_wdata = {{16{cordic_ln_out[15]}}, cordic_ln_out};
  RoundandSat rdsat (
    .din  (zreg_mul2[20:0] ), //i
    .dout (rdsat_dout[15:0])  //o
  );
  always @(*) begin
    case(cnt)
      4'b0000 : begin
        tmp_tmp_xi = iters_0;
        tmp_ei = e_data_0;
      end
      4'b0001 : begin
        tmp_tmp_xi = iters_1;
        tmp_ei = e_data_1;
      end
      4'b0010 : begin
        tmp_tmp_xi = iters_2;
        tmp_ei = e_data_2;
      end
      4'b0011 : begin
        tmp_tmp_xi = iters_3;
        tmp_ei = e_data_3;
      end
      4'b0100 : begin
        tmp_tmp_xi = iters_4;
        tmp_ei = e_data_4;
      end
      4'b0101 : begin
        tmp_tmp_xi = iters_5;
        tmp_ei = e_data_5;
      end
      4'b0110 : begin
        tmp_tmp_xi = iters_6;
        tmp_ei = e_data_6;
      end
      4'b0111 : begin
        tmp_tmp_xi = iters_7;
        tmp_ei = e_data_7;
      end
      4'b1000 : begin
        tmp_tmp_xi = iters_8;
        tmp_ei = e_data_8;
      end
      4'b1001 : begin
        tmp_tmp_xi = iters_9;
        tmp_ei = e_data_9;
      end
      4'b1010 : begin
        tmp_tmp_xi = iters_10;
        tmp_ei = e_data_10;
      end
      default : begin
        tmp_tmp_xi = iters_11;
        tmp_ei = e_data_11;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE     ";
      LOADDATA : next_state_string = "LOADDATA ";
      CORDIC : next_state_string = "CORDIC   ";
      STOREDATA : next_state_string = "STOREDATA";
      default : next_state_string = "?????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE     ";
      LOADDATA : curr_state_string = "LOADDATA ";
      CORDIC : curr_state_string = "CORDIC   ";
      STOREDATA : curr_state_string = "STOREDATA";
      default : curr_state_string = "?????????";
    endcase
  end
  `endif

  assign iters_0 = 4'b0100; // @[cordic_ln.scala 44:16]
  assign iters_1 = 4'b0011; // @[cordic_ln.scala 44:16]
  assign iters_2 = 4'b0010; // @[cordic_ln.scala 44:16]
  assign iters_3 = 4'b0001; // @[cordic_ln.scala 44:16]
  assign iters_4 = 4'b0000; // @[cordic_ln.scala 47:16]
  assign iters_5 = 4'b0001; // @[cordic_ln.scala 47:16]
  assign iters_6 = 4'b0010; // @[cordic_ln.scala 47:16]
  assign iters_7 = 4'b0011; // @[cordic_ln.scala 47:16]
  assign iters_8 = 4'b0100; // @[cordic_ln.scala 47:16]
  assign iters_9 = 4'b0101; // @[cordic_ln.scala 47:16]
  assign iters_10 = 4'b0110; // @[cordic_ln.scala 47:16]
  assign iters_11 = 4'b0111; // @[cordic_ln.scala 47:16]
  assign e_data_0 = 16'h26c1; // @[Expression.scala 2380:18]
  assign e_data_1 = 16'h2125; // @[Expression.scala 2380:18]
  assign e_data_2 = 16'h1b79; // @[Expression.scala 2380:18]
  assign e_data_3 = 16'h15aa; // @[Expression.scala 2380:18]
  assign e_data_4 = 16'h0f91; // @[Expression.scala 2380:18]
  assign e_data_5 = 16'h08ca; // @[Expression.scala 2380:18]
  assign e_data_6 = 16'h0416; // @[Expression.scala 2380:18]
  assign e_data_7 = 16'h0203; // @[Expression.scala 2380:18]
  assign e_data_8 = 16'h0100; // @[Expression.scala 2380:18]
  assign e_data_9 = 16'h0080; // @[Expression.scala 2380:18]
  assign e_data_10 = 16'h0040; // @[Expression.scala 2380:18]
  assign e_data_11 = 16'h0020; // @[Expression.scala 2380:18]
  assign di = (y_reg[25] ? 1'b1 : 1'b0); // @[Expression.scala 1420:25]
  assign zreg_mul2 = {z_reg,1'b0}; // @[BaseType.scala 299:24]
  assign ln_out = rdsat_dout; // @[cordic_ln.scala 74:10]
  assign ln_x_shift1 = {ln_out,3'b000}; // @[cordic_ln.scala 78:15]
  assign tmp_ln_x_to_lg = ($signed(ln_x_shift1) - $signed(tmp_tmp_ln_x_to_lg)); // @[BaseType.scala 299:24]
  assign tmp_ln_x_to_lg_2 = {{15'h0,1'b1},3'b000}; // @[BaseType.scala 318:22]
  assign tmp_ln_x_to_lg_3 = {16'hffff,3'b000}; // @[BaseType.scala 318:22]
  assign tmp_ln_x_to_lg_4 = tmp_ln_x_to_lg[18 : 0]; // @[BaseType.scala 299:24]
  assign tmp_ln_x_to_lg_5 = ($signed(tmp_tmp_ln_x_to_lg_5) + $signed(tmp_tmp_ln_x_to_lg_5_1)); // @[BaseType.scala 299:24]
  assign tmp_ln_x_to_lg_6 = tmp_ln_x_to_lg[18 : 0]; // @[BaseType.scala 299:24]
  always @(*) begin
    if((|tmp_when)) begin
      tmp_ln_x_to_lg_7 = ($signed(tmp_tmp_ln_x_to_lg_7) + $signed(tmp_tmp_ln_x_to_lg_7_1)); // @[SInt.scala 193:11]
    end else begin
      tmp_ln_x_to_lg_7 = tmp_ln_x_to_lg_5[19 : 4]; // @[SInt.scala 195:11]
    end
  end

  always @(*) begin
    if(tmp_ln_x_to_lg_5[19]) begin
      tmp_ln_x_to_lg_1 = tmp_ln_x_to_lg_7; // @[SInt.scala 339:11]
    end else begin
      tmp_ln_x_to_lg_1 = (tmp_tmp_ln_x_to_lg_1 >>> 4); // @[SInt.scala 341:11]
    end
  end

  always @(*) begin
    if(tmp_ln_x_to_lg_1[15]) begin
      if((! (&tmp_when_1))) begin
        ln_x_to_lg = 15'h4000; // @[SInt.scala 133:13]
      end else begin
        ln_x_to_lg = tmp_ln_x_to_lg_1[14 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_2)) begin
        ln_x_to_lg = 15'h3fff; // @[SInt.scala 139:13]
      end else begin
        ln_x_to_lg = tmp_ln_x_to_lg_1[14 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign cordic_ln_out = {{1{ln_x_to_lg[14]}}, ln_x_to_lg}; // @[cordic_ln.scala 80:20]
  assign mel_addr_ov = (mel_addr == 5'h1e); // @[BaseType.scala 305:24]
  assign cordic_end = (cnt == 4'b1011); // @[BaseType.scala 305:24]
  assign load_stin = ((! (curr_state == LOADDATA)) && (next_state == LOADDATA)); // @[BaseType.scala 305:24]
  assign finish = (mel_addr_ov && (curr_state == STOREDATA)); // @[cordic_ln.scala 91:13]
  always @(*) begin
    xi = 27'h0; // @[cordic_ln.scala 101:6]
    if((curr_state == CORDIC)) begin
      if((cnt < 4'b0101)) begin
        xi = ($signed(tmp_xi_2) - $signed(tmp_xi_3)); // @[cordic_ln.scala 105:10]
      end else begin
        xi = ($signed(tmp_xi_4) >>> tmp_xi); // @[cordic_ln.scala 108:10]
      end
    end
  end

  always @(*) begin
    yi = 27'h0; // @[cordic_ln.scala 102:6]
    if((curr_state == CORDIC)) begin
      if((cnt < 4'b0101)) begin
        yi = ($signed(tmp_yi_1) - $signed(tmp_yi_2)); // @[cordic_ln.scala 106:10]
      end else begin
        yi = ($signed(tmp_yi_3) >>> tmp_xi); // @[cordic_ln.scala 109:10]
      end
    end
  end

  assign tmp_xi = tmp_tmp_xi; // @[Vec.scala 202:25]
  assign tmp_xi_1 = ($signed(x_reg) >>> tmp_tmp_xi_1); // @[BaseType.scala 299:24]
  assign tmp_yi = ($signed(y_reg) >>> tmp_tmp_yi); // @[BaseType.scala 299:24]
  assign ei = {{4{tmp_ei[15]}}, tmp_ei}; // @[BaseType.scala 299:24]
  assign tmp_z_reg = (di ? tmp_tmp_z_reg : ei); // @[Expression.scala 1420:25]
  assign tmp_z_reg_1 = ($signed(tmp_tmp_z_reg_1_1) + $signed(tmp_tmp_z_reg_1_2)); // @[BaseType.scala 299:24]
  always @(*) begin
    if(tmp_z_reg_1[20]) begin
      if((! (&tmp_when_3))) begin
        tmp_z_reg_2 = 20'h80000; // @[SInt.scala 133:13]
      end else begin
        tmp_z_reg_2 = tmp_z_reg_1[19 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_4)) begin
        tmp_z_reg_2 = 20'h7ffff; // @[SInt.scala 139:13]
      end else begin
        tmp_z_reg_2 = tmp_z_reg_1[19 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign tmp_x_reg = (di ? yi : tmp_tmp_x_reg); // @[Expression.scala 1420:25]
  assign tmp_x_reg_1 = ($signed(tmp_tmp_x_reg_1_1) + $signed(tmp_tmp_x_reg_1_3)); // @[BaseType.scala 299:24]
  always @(*) begin
    if(tmp_x_reg_1[27]) begin
      if((! (&tmp_when_5))) begin
        tmp_x_reg_2 = 26'h2000000; // @[SInt.scala 133:13]
      end else begin
        tmp_x_reg_2 = tmp_x_reg_1[25 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_6)) begin
        tmp_x_reg_2 = 26'h1ffffff; // @[SInt.scala 139:13]
      end else begin
        tmp_x_reg_2 = tmp_x_reg_1[25 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  assign tmp_y_reg = (di ? xi : tmp_tmp_y_reg); // @[Expression.scala 1420:25]
  assign tmp_y_reg_1 = ($signed(tmp_tmp_y_reg_1_1) + $signed(tmp_tmp_y_reg_1_3)); // @[BaseType.scala 299:24]
  always @(*) begin
    if(tmp_y_reg_1[27]) begin
      if((! (&tmp_when_7))) begin
        tmp_y_reg_2 = 26'h2000000; // @[SInt.scala 133:13]
      end else begin
        tmp_y_reg_2 = tmp_y_reg_1[25 : 0]; // @[SInt.scala 135:13]
      end
    end else begin
      if((|tmp_when_8)) begin
        tmp_y_reg_2 = 26'h1ffffff; // @[SInt.scala 139:13]
      end else begin
        tmp_y_reg_2 = tmp_y_reg_1[25 : 0]; // @[SInt.scala 141:13]
      end
    end
  end

  always @(*) begin
    memif_rd = 1'b0; // @[cordic_ln.scala 132:15]
    if(load_stin) begin
      memif_rd = 1'b1; // @[cordic_ln.scala 129:17]
    end
  end

  always @(*) begin
    memif_wr = 1'b0; // @[cordic_ln.scala 133:15]
    if(!load_stin) begin
      if(store_en) begin
        memif_wr = 1'b1; // @[cordic_ln.scala 124:17]
      end
    end
  end

  always @(*) begin
    memif_addr = 8'h0; // @[cordic_ln.scala 134:17]
    if(load_stin) begin
      memif_addr = tmp_memif_addr_1; // @[cordic_ln.scala 130:19]
    end else begin
      if(store_en) begin
        memif_addr = tmp_memif_addr_3; // @[cordic_ln.scala 125:19]
      end
    end
  end

  always @(*) begin
    memif_wdata = 32'h0; // @[cordic_ln.scala 135:18]
    if(!load_stin) begin
      if(store_en) begin
        memif_wdata = tmp_memif_wdata; // @[cordic_ln.scala 126:20]
      end
    end
  end

  assign tmp_memif_addr = {3'd0, mel_addr}; // @[BaseType.scala 299:24]
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

  assign tmp_memif_addr_2 = {3'd0, mel_addr}; // @[BaseType.scala 299:24]
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

  always @(*) begin
    next_state = curr_state; // @[cordic_ln.scala 148:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = LOADDATA; // @[Enum.scala 148:67]
        end
      end
      LOADDATA : begin
        next_state = CORDIC; // @[Enum.scala 148:67]
      end
      CORDIC : begin
        if(cordic_end) begin
          next_state = STOREDATA; // @[Enum.scala 148:67]
        end
      end
      default : begin
        if(mel_addr_ov) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end else begin
          if(store_en_delay) begin
            next_state = LOADDATA; // @[Enum.scala 148:67]
          end
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      x_reg <= 26'h0; // @[Data.scala 400:33]
      y_reg <= 26'h0; // @[Data.scala 400:33]
      z_reg <= 20'h0; // @[Data.scala 400:33]
      cnt <= 4'b0000; // @[Data.scala 400:33]
      mel_addr <= 5'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
      store_en <= 1'b0; // @[Data.scala 400:33]
      store_en_delay <= 1'b0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      store_en <= ((! (curr_state == STOREDATA)) && (next_state == STOREDATA)); // @[Reg.scala 39:30]
      store_en_delay <= store_en; // @[Reg.scala 39:30]
      if((curr_state == CORDIC)) begin
        if(cordic_end) begin
          cnt <= 4'b0000; // @[cordic_ln.scala 95:11]
        end else begin
          cnt <= (cnt + 4'b0001); // @[cordic_ln.scala 97:11]
        end
      end
      if((curr_state == CORDIC)) begin
        z_reg <= tmp_z_reg_2; // @[cordic_ln.scala 114:11]
        x_reg <= tmp_x_reg_2; // @[cordic_ln.scala 115:11]
        y_reg <= tmp_y_reg_2; // @[cordic_ln.scala 116:11]
      end else begin
        if((curr_state == LOADDATA)) begin
          z_reg <= 20'h0; // @[cordic_ln.scala 118:11]
          x_reg <= ($signed(tmp_x_reg_3) + $signed(tmp_x_reg_6)); // @[cordic_ln.scala 119:11]
          y_reg <= ($signed(tmp_y_reg_3) + $signed(tmp_y_reg_6)); // @[cordic_ln.scala 120:11]
        end
      end
      if(store_en) begin
        mel_addr <= (mel_addr + 5'h01); // @[cordic_ln.scala 143:14]
      end else begin
        if(finish) begin
          mel_addr <= 5'h0; // @[cordic_ln.scala 145:14]
        end
      end
    end
  end


endmodule

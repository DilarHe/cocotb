// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : butterfly_unit
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module butterfly_unit (
  input               start,
  output              finish,
  input      [15:0]   xp_real,
  input      [15:0]   xp_imag,
  input      [15:0]   xq_real,
  input      [15:0]   xq_imag,
  input      [15:0]   wn_real,
  input      [15:0]   wn_imag,
  output     [15:0]   yp_real,
  output     [15:0]   yp_imag,
  output     [15:0]   yq_real,
  output     [15:0]   yq_imag,
  output              mulif_din_vld,
  output reg [15:0]   mulif_dinA,
  output reg [15:0]   mulif_dinB,
  input               mulif_dout_vld,
  input               mulif_cal_finish,
  input      [31:0]   mulif_dout,
  input               clk,
  input               resetn
);
  localparam IDLE = 3'd0;
  localparam XQ_WN_MUL_AC = 3'd1;
  localparam XQ_WN_MUL_BD = 3'd2;
  localparam XQ_WN_MUL_AD = 3'd3;
  localparam XQ_WN_MUL_BC = 3'd4;

  wire       [33:0]   rdsat0_din;
  wire       [33:0]   rdsat1_din;
  wire       [15:0]   rdsat0_dout;
  wire       [15:0]   rdsat1_dout;
  wire       [33:0]   tmp_sumbuff1;
  wire       [33:0]   tmp_sumbuff1_1;
  wire       [30:0]   tmp_adder_pinB;
  wire       [30:0]   tmp_minus_pinA;
  wire       [30:0]   tmp_adder_pinB_1;
  wire       [30:0]   tmp_minus_pinA_1;
  reg        [2:0]    next_state;
  reg        [2:0]    curr_state;
  reg                 MUL_AC_IN;
  reg                 MUL_BD_IN;
  reg                 MUL_AD_IN;
  reg                 MUL_BC_IN;
  reg                 MUL_END;
  reg                 MUL_END_regNext;
  reg        [33:0]   sumbuff1;
  reg        [15:0]   yp_real_reg;
  reg        [15:0]   yp_imag_reg;
  reg        [15:0]   yq_real_reg;
  reg        [15:0]   yq_imag_reg;
  wire       [33:0]   adder_pinA;
  reg        [33:0]   adder_pinB;
  wire       [33:0]   adder_out;
  reg        [33:0]   minus_pinA;
  wire       [33:0]   minus_pinB;
  wire       [33:0]   minus_out;
  wire       [15:0]   adder_clip_out;
  wire       [15:0]   minus_clip_out;
  `ifndef SYNTHESIS
  reg [95:0] next_state_string;
  reg [95:0] curr_state_string;
  `endif


  assign tmp_sumbuff1 = {{2{mulif_dout[31]}}, mulif_dout};
  assign tmp_sumbuff1_1 = {{2{mulif_dout[31]}}, mulif_dout};
  assign tmp_adder_pinB = {xp_real,15'h0};
  assign tmp_minus_pinA = {xp_real,15'h0};
  assign tmp_adder_pinB_1 = {xp_imag,15'h0};
  assign tmp_minus_pinA_1 = {xp_imag,15'h0};
  RoundandSat_6 rdsat0 (
    .din  (rdsat0_din[33:0] ), //i
    .dout (rdsat0_dout[15:0])  //o
  );
  RoundandSat_6 rdsat1 (
    .din  (rdsat1_din[33:0] ), //i
    .dout (rdsat1_dout[15:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE        ";
      XQ_WN_MUL_AC : next_state_string = "XQ_WN_MUL_AC";
      XQ_WN_MUL_BD : next_state_string = "XQ_WN_MUL_BD";
      XQ_WN_MUL_AD : next_state_string = "XQ_WN_MUL_AD";
      XQ_WN_MUL_BC : next_state_string = "XQ_WN_MUL_BC";
      default : next_state_string = "????????????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE        ";
      XQ_WN_MUL_AC : curr_state_string = "XQ_WN_MUL_AC";
      XQ_WN_MUL_BD : curr_state_string = "XQ_WN_MUL_BD";
      XQ_WN_MUL_AD : curr_state_string = "XQ_WN_MUL_AD";
      XQ_WN_MUL_BC : curr_state_string = "XQ_WN_MUL_BC";
      default : curr_state_string = "????????????";
    endcase
  end
  `endif

  assign finish = MUL_END_regNext; // @[butterfly_unit.scala 81:13]
  assign mulif_din_vld = (((MUL_AC_IN || MUL_BD_IN) || MUL_AD_IN) || MUL_BC_IN); // @[butterfly_unit.scala 82:20]
  always @(*) begin
    next_state = curr_state; // @[butterfly_unit.scala 87:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = XQ_WN_MUL_AC; // @[Enum.scala 148:67]
        end
      end
      XQ_WN_MUL_AC : begin
        if(mulif_dout_vld) begin
          next_state = XQ_WN_MUL_BD; // @[Enum.scala 148:67]
        end
      end
      XQ_WN_MUL_BD : begin
        if(mulif_dout_vld) begin
          next_state = XQ_WN_MUL_AD; // @[Enum.scala 148:67]
        end
      end
      XQ_WN_MUL_AD : begin
        if(mulif_dout_vld) begin
          next_state = XQ_WN_MUL_BC; // @[Enum.scala 148:67]
        end
      end
      default : begin
        if(mulif_dout_vld) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end
      end
    endcase
  end

  always @(*) begin
    mulif_dinA = 16'h0; // @[butterfly_unit.scala 88:17]
    case(curr_state)
      IDLE : begin
      end
      XQ_WN_MUL_AC : begin
        mulif_dinA = xq_real; // @[butterfly_unit.scala 97:21]
      end
      XQ_WN_MUL_BD : begin
        mulif_dinA = xq_imag; // @[butterfly_unit.scala 105:21]
      end
      XQ_WN_MUL_AD : begin
        mulif_dinA = xq_real; // @[butterfly_unit.scala 113:21]
      end
      default : begin
        mulif_dinA = xq_imag; // @[butterfly_unit.scala 121:21]
      end
    endcase
  end

  always @(*) begin
    mulif_dinB = 16'h0; // @[butterfly_unit.scala 89:17]
    case(curr_state)
      IDLE : begin
      end
      XQ_WN_MUL_AC : begin
        mulif_dinB = wn_real; // @[butterfly_unit.scala 98:21]
      end
      XQ_WN_MUL_BD : begin
        mulif_dinB = wn_imag; // @[butterfly_unit.scala 106:21]
      end
      XQ_WN_MUL_AD : begin
        mulif_dinB = wn_imag; // @[butterfly_unit.scala 114:21]
      end
      default : begin
        mulif_dinB = wn_real; // @[butterfly_unit.scala 122:21]
      end
    endcase
  end

  assign adder_out = ($signed(adder_pinA) + $signed(adder_pinB)); // @[BaseType.scala 299:24]
  assign minus_out = ($signed(minus_pinA) - $signed(minus_pinB)); // @[BaseType.scala 299:24]
  assign rdsat0_din = adder_out; // @[butterfly_unit.scala 145:17]
  assign adder_clip_out = rdsat0_dout; // @[BaseType.scala 318:22]
  assign rdsat1_din = minus_out; // @[butterfly_unit.scala 147:17]
  assign minus_clip_out = rdsat1_dout; // @[BaseType.scala 318:22]
  assign adder_pinA = sumbuff1; // @[butterfly_unit.scala 151:14]
  assign minus_pinB = sumbuff1; // @[butterfly_unit.scala 152:14]
  always @(*) begin
    adder_pinB = 34'h0; // @[butterfly_unit.scala 153:14]
    if(MUL_AD_IN) begin
      adder_pinB = {{3{tmp_adder_pinB[30]}}, tmp_adder_pinB}; // @[butterfly_unit.scala 156:16]
    end
    if(MUL_END) begin
      adder_pinB = {{3{tmp_adder_pinB_1[30]}}, tmp_adder_pinB_1}; // @[butterfly_unit.scala 162:16]
    end
  end

  always @(*) begin
    minus_pinA = 34'h0; // @[butterfly_unit.scala 154:14]
    if(MUL_AD_IN) begin
      minus_pinA = {{3{tmp_minus_pinA[30]}}, tmp_minus_pinA}; // @[butterfly_unit.scala 158:16]
    end
    if(MUL_END) begin
      minus_pinA = {{3{tmp_minus_pinA_1[30]}}, tmp_minus_pinA_1}; // @[butterfly_unit.scala 164:16]
    end
  end

  assign yp_real = yp_real_reg; // @[butterfly_unit.scala 169:14]
  assign yp_imag = yp_imag_reg; // @[butterfly_unit.scala 170:14]
  assign yq_real = yq_real_reg; // @[butterfly_unit.scala 171:14]
  assign yq_imag = yq_imag_reg; // @[butterfly_unit.scala 172:14]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      curr_state <= IDLE; // @[Data.scala 400:33]
      MUL_AC_IN <= 1'b0; // @[Data.scala 400:33]
      MUL_BD_IN <= 1'b0; // @[Data.scala 400:33]
      MUL_AD_IN <= 1'b0; // @[Data.scala 400:33]
      MUL_BC_IN <= 1'b0; // @[Data.scala 400:33]
      MUL_END <= 1'b0; // @[Data.scala 400:33]
      MUL_END_regNext <= 1'b0; // @[Data.scala 400:33]
      sumbuff1 <= 34'h0; // @[Data.scala 400:33]
      yp_real_reg <= 16'h0; // @[Data.scala 400:33]
      yp_imag_reg <= 16'h0; // @[Data.scala 400:33]
      yq_real_reg <= 16'h0; // @[Data.scala 400:33]
      yq_imag_reg <= 16'h0; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      MUL_AC_IN <= ((curr_state == IDLE) && (next_state == XQ_WN_MUL_AC)); // @[Reg.scala 39:30]
      MUL_BD_IN <= ((curr_state == XQ_WN_MUL_AC) && (next_state == XQ_WN_MUL_BD)); // @[Reg.scala 39:30]
      MUL_AD_IN <= ((curr_state == XQ_WN_MUL_BD) && (next_state == XQ_WN_MUL_AD)); // @[Reg.scala 39:30]
      MUL_BC_IN <= ((curr_state == XQ_WN_MUL_AD) && (next_state == XQ_WN_MUL_BC)); // @[Reg.scala 39:30]
      MUL_END <= ((curr_state == XQ_WN_MUL_BC) && (next_state == IDLE)); // @[Reg.scala 39:30]
      MUL_END_regNext <= MUL_END; // @[Reg.scala 39:30]
      case(curr_state)
        IDLE : begin
        end
        XQ_WN_MUL_AC : begin
          if(mulif_dout_vld) begin
            sumbuff1 <= {{2{mulif_dout[31]}}, mulif_dout}; // @[butterfly_unit.scala 101:18]
          end
        end
        XQ_WN_MUL_BD : begin
          if(mulif_dout_vld) begin
            sumbuff1 <= ($signed(sumbuff1) - $signed(tmp_sumbuff1)); // @[butterfly_unit.scala 109:18]
          end
        end
        XQ_WN_MUL_AD : begin
          if(mulif_dout_vld) begin
            sumbuff1 <= {{2{mulif_dout[31]}}, mulif_dout}; // @[butterfly_unit.scala 117:18]
          end
        end
        default : begin
          if(mulif_dout_vld) begin
            sumbuff1 <= ($signed(sumbuff1) + $signed(tmp_sumbuff1_1)); // @[butterfly_unit.scala 125:18]
          end
        end
      endcase
      if(MUL_AD_IN) begin
        yp_real_reg <= adder_clip_out; // @[butterfly_unit.scala 157:17]
        yq_real_reg <= minus_clip_out; // @[butterfly_unit.scala 159:17]
      end
      if(MUL_END) begin
        yp_imag_reg <= adder_clip_out; // @[butterfly_unit.scala 163:17]
        yq_imag_reg <= minus_clip_out; // @[butterfly_unit.scala 165:17]
      end
    end
  end


endmodule

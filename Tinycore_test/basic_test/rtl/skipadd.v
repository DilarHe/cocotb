// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : skipadd
// Git hash  : a260736bdb50f866f639e57533d6185c804e7407

`timescale 1ns/1ps 
module skipadd (
  input               start,
  output              end_1,
  input      [31:0]   rs1,
  input      [31:0]   rs2,
  input      [31:0]   rs3,
  input      [3:0]    rd_index,
  input      [127:0]  vs1,
  input      [127:0]  vs2,
  output              mul_start_out,
  output reg [31:0]   mul_pinA_out,
  output reg [31:0]   mul_pinB_out,
  input      [63:0]   mul_dout_in,
  input               mul_end_in,
  output     [7:0]    shift_out,
  output     [63:0]   skipadd_out,
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam MUL1 = 2'd1;
  localparam MUL2 = 2'd2;
  localparam ADD = 2'd3;

  reg        [7:0]    tmp_input_data1_val;
  reg        [7:0]    tmp_input_data2_val;
  wire       [63:0]   tmp_skipadd_out;
  wire       [7:0]    tmp_mul_pinA_out;
  wire       [7:0]    tmp_mul_pinA_out_1;
  wire       [7:0]    tmp_mul_pinA_out_2;
  wire       [15:0]   tmp_mul_pinA_out_3;
  wire       [15:0]   tmp_mul_pinA_out_4;
  wire       [7:0]    tmp_mul_pinA_out_5;
  wire       [15:0]   tmp_mul_pinA_out_6;
  wire       [7:0]    input_data1_vec_0;
  wire       [7:0]    input_data1_vec_1;
  wire       [7:0]    input_data1_vec_2;
  wire       [7:0]    input_data1_vec_3;
  wire       [7:0]    input_data1_vec_4;
  wire       [7:0]    input_data1_vec_5;
  wire       [7:0]    input_data1_vec_6;
  wire       [7:0]    input_data1_vec_7;
  wire       [7:0]    input_data1_vec_8;
  wire       [7:0]    input_data1_vec_9;
  wire       [7:0]    input_data1_vec_10;
  wire       [7:0]    input_data1_vec_11;
  wire       [7:0]    input_data1_vec_12;
  wire       [7:0]    input_data1_vec_13;
  wire       [7:0]    input_data1_vec_14;
  wire       [7:0]    input_data1_vec_15;
  wire       [7:0]    input_data2_vec_0;
  wire       [7:0]    input_data2_vec_1;
  wire       [7:0]    input_data2_vec_2;
  wire       [7:0]    input_data2_vec_3;
  wire       [7:0]    input_data2_vec_4;
  wire       [7:0]    input_data2_vec_5;
  wire       [7:0]    input_data2_vec_6;
  wire       [7:0]    input_data2_vec_7;
  wire       [7:0]    input_data2_vec_8;
  wire       [7:0]    input_data2_vec_9;
  wire       [7:0]    input_data2_vec_10;
  wire       [7:0]    input_data2_vec_11;
  wire       [7:0]    input_data2_vec_12;
  wire       [7:0]    input_data2_vec_13;
  wire       [7:0]    input_data2_vec_14;
  wire       [7:0]    input_data2_vec_15;
  wire       [7:0]    input_data1_val;
  wire       [7:0]    input_data2_val;
  wire       [7:0]    offset1;
  wire       [15:0]   offset2;
  reg        [63:0]   sum_reg;
  reg        [1:0]    next_state;
  reg        [1:0]    curr_state;
  wire                tmp_mul1_state_in;
  reg                 tmp_mul1_state_in_regNext;
  wire                mul1_state_in;
  wire                tmp_mul2_state_in;
  reg                 tmp_mul2_state_in_regNext;
  wire                mul2_state_in;
  wire                mul1_mul_end;
  wire                mul2_mul_end;
  `ifndef SYNTHESIS
  reg [31:0] next_state_string;
  reg [31:0] curr_state_string;
  `endif


  assign tmp_skipadd_out = 64'h0;
  assign tmp_mul_pinA_out = ($signed(tmp_mul_pinA_out_1) - $signed(tmp_mul_pinA_out_2));
  assign tmp_mul_pinA_out_1 = input_data1_val;
  assign tmp_mul_pinA_out_2 = offset1;
  assign tmp_mul_pinA_out_3 = ($signed(tmp_mul_pinA_out_4) - $signed(tmp_mul_pinA_out_6));
  assign tmp_mul_pinA_out_5 = input_data2_val;
  assign tmp_mul_pinA_out_4 = {{8{tmp_mul_pinA_out_5[7]}}, tmp_mul_pinA_out_5};
  assign tmp_mul_pinA_out_6 = offset2;
  always @(*) begin
    case(rd_index)
      4'b0000 : begin
        tmp_input_data1_val = input_data1_vec_0;
        tmp_input_data2_val = input_data2_vec_0;
      end
      4'b0001 : begin
        tmp_input_data1_val = input_data1_vec_1;
        tmp_input_data2_val = input_data2_vec_1;
      end
      4'b0010 : begin
        tmp_input_data1_val = input_data1_vec_2;
        tmp_input_data2_val = input_data2_vec_2;
      end
      4'b0011 : begin
        tmp_input_data1_val = input_data1_vec_3;
        tmp_input_data2_val = input_data2_vec_3;
      end
      4'b0100 : begin
        tmp_input_data1_val = input_data1_vec_4;
        tmp_input_data2_val = input_data2_vec_4;
      end
      4'b0101 : begin
        tmp_input_data1_val = input_data1_vec_5;
        tmp_input_data2_val = input_data2_vec_5;
      end
      4'b0110 : begin
        tmp_input_data1_val = input_data1_vec_6;
        tmp_input_data2_val = input_data2_vec_6;
      end
      4'b0111 : begin
        tmp_input_data1_val = input_data1_vec_7;
        tmp_input_data2_val = input_data2_vec_7;
      end
      4'b1000 : begin
        tmp_input_data1_val = input_data1_vec_8;
        tmp_input_data2_val = input_data2_vec_8;
      end
      4'b1001 : begin
        tmp_input_data1_val = input_data1_vec_9;
        tmp_input_data2_val = input_data2_vec_9;
      end
      4'b1010 : begin
        tmp_input_data1_val = input_data1_vec_10;
        tmp_input_data2_val = input_data2_vec_10;
      end
      4'b1011 : begin
        tmp_input_data1_val = input_data1_vec_11;
        tmp_input_data2_val = input_data2_vec_11;
      end
      4'b1100 : begin
        tmp_input_data1_val = input_data1_vec_12;
        tmp_input_data2_val = input_data2_vec_12;
      end
      4'b1101 : begin
        tmp_input_data1_val = input_data1_vec_13;
        tmp_input_data2_val = input_data2_vec_13;
      end
      4'b1110 : begin
        tmp_input_data1_val = input_data1_vec_14;
        tmp_input_data2_val = input_data2_vec_14;
      end
      default : begin
        tmp_input_data1_val = input_data1_vec_15;
        tmp_input_data2_val = input_data2_vec_15;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(next_state)
      IDLE : next_state_string = "IDLE";
      MUL1 : next_state_string = "MUL1";
      MUL2 : next_state_string = "MUL2";
      ADD : next_state_string = "ADD ";
      default : next_state_string = "????";
    endcase
  end
  always @(*) begin
    case(curr_state)
      IDLE : curr_state_string = "IDLE";
      MUL1 : curr_state_string = "MUL1";
      MUL2 : curr_state_string = "MUL2";
      ADD : curr_state_string = "ADD ";
      default : curr_state_string = "????";
    endcase
  end
  `endif

  assign input_data1_vec_0 = vs1[7 : 0]; // @[BaseType.scala 299:24]
  assign input_data1_vec_1 = vs1[15 : 8]; // @[BaseType.scala 299:24]
  assign input_data1_vec_2 = vs1[23 : 16]; // @[BaseType.scala 299:24]
  assign input_data1_vec_3 = vs1[31 : 24]; // @[BaseType.scala 299:24]
  assign input_data1_vec_4 = vs1[39 : 32]; // @[BaseType.scala 299:24]
  assign input_data1_vec_5 = vs1[47 : 40]; // @[BaseType.scala 299:24]
  assign input_data1_vec_6 = vs1[55 : 48]; // @[BaseType.scala 299:24]
  assign input_data1_vec_7 = vs1[63 : 56]; // @[BaseType.scala 299:24]
  assign input_data1_vec_8 = vs1[71 : 64]; // @[BaseType.scala 299:24]
  assign input_data1_vec_9 = vs1[79 : 72]; // @[BaseType.scala 299:24]
  assign input_data1_vec_10 = vs1[87 : 80]; // @[BaseType.scala 299:24]
  assign input_data1_vec_11 = vs1[95 : 88]; // @[BaseType.scala 299:24]
  assign input_data1_vec_12 = vs1[103 : 96]; // @[BaseType.scala 299:24]
  assign input_data1_vec_13 = vs1[111 : 104]; // @[BaseType.scala 299:24]
  assign input_data1_vec_14 = vs1[119 : 112]; // @[BaseType.scala 299:24]
  assign input_data1_vec_15 = vs1[127 : 120]; // @[BaseType.scala 299:24]
  assign input_data2_vec_0 = vs2[7 : 0]; // @[BaseType.scala 299:24]
  assign input_data2_vec_1 = vs2[15 : 8]; // @[BaseType.scala 299:24]
  assign input_data2_vec_2 = vs2[23 : 16]; // @[BaseType.scala 299:24]
  assign input_data2_vec_3 = vs2[31 : 24]; // @[BaseType.scala 299:24]
  assign input_data2_vec_4 = vs2[39 : 32]; // @[BaseType.scala 299:24]
  assign input_data2_vec_5 = vs2[47 : 40]; // @[BaseType.scala 299:24]
  assign input_data2_vec_6 = vs2[55 : 48]; // @[BaseType.scala 299:24]
  assign input_data2_vec_7 = vs2[63 : 56]; // @[BaseType.scala 299:24]
  assign input_data2_vec_8 = vs2[71 : 64]; // @[BaseType.scala 299:24]
  assign input_data2_vec_9 = vs2[79 : 72]; // @[BaseType.scala 299:24]
  assign input_data2_vec_10 = vs2[87 : 80]; // @[BaseType.scala 299:24]
  assign input_data2_vec_11 = vs2[95 : 88]; // @[BaseType.scala 299:24]
  assign input_data2_vec_12 = vs2[103 : 96]; // @[BaseType.scala 299:24]
  assign input_data2_vec_13 = vs2[111 : 104]; // @[BaseType.scala 299:24]
  assign input_data2_vec_14 = vs2[119 : 112]; // @[BaseType.scala 299:24]
  assign input_data2_vec_15 = vs2[127 : 120]; // @[BaseType.scala 299:24]
  assign input_data1_val = tmp_input_data1_val; // @[Vec.scala 202:25]
  assign input_data2_val = tmp_input_data2_val; // @[Vec.scala 202:25]
  assign offset1 = rs3[15 : 8]; // @[BaseType.scala 299:24]
  assign offset2 = rs3[31 : 16]; // @[BaseType.scala 299:24]
  assign shift_out = rs3[7 : 0]; // @[skipadd.scala 41:16]
  assign tmp_mul1_state_in = (curr_state == MUL1); // @[BaseType.scala 305:24]
  assign mul1_state_in = (tmp_mul1_state_in && (! tmp_mul1_state_in_regNext)); // @[BaseType.scala 305:24]
  assign tmp_mul2_state_in = (curr_state == MUL2); // @[BaseType.scala 305:24]
  assign mul2_state_in = (tmp_mul2_state_in && (! tmp_mul2_state_in_regNext)); // @[BaseType.scala 305:24]
  assign mul1_mul_end = ((curr_state == MUL1) && mul_end_in); // @[BaseType.scala 305:24]
  assign mul2_mul_end = ((curr_state == MUL2) && mul_end_in); // @[BaseType.scala 305:24]
  assign mul_start_out = (mul1_state_in || mul2_state_in); // @[skipadd.scala 53:20]
  assign end_1 = (curr_state == ADD); // @[skipadd.scala 54:10]
  assign skipadd_out = (end_1 ? sum_reg : tmp_skipadd_out); // @[skipadd.scala 55:18]
  always @(*) begin
    next_state = curr_state; // @[skipadd.scala 63:14]
    case(curr_state)
      IDLE : begin
        if(start) begin
          next_state = MUL1; // @[Enum.scala 148:67]
        end
      end
      MUL1 : begin
        if(mul_end_in) begin
          next_state = MUL2; // @[Enum.scala 148:67]
        end
      end
      MUL2 : begin
        if(mul_end_in) begin
          next_state = IDLE; // @[Enum.scala 148:67]
        end
      end
      default : begin
        next_state = IDLE; // @[Enum.scala 148:67]
      end
    endcase
  end

  always @(*) begin
    mul_pinA_out = 32'h0; // @[skipadd.scala 85:19]
    case(curr_state)
      MUL1 : begin
        mul_pinA_out = {{24{tmp_mul_pinA_out[7]}}, tmp_mul_pinA_out}; // @[skipadd.scala 89:23]
      end
      MUL2 : begin
        mul_pinA_out = {{16{tmp_mul_pinA_out_3[15]}}, tmp_mul_pinA_out_3}; // @[skipadd.scala 93:23]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mul_pinB_out = 32'h0; // @[skipadd.scala 86:19]
    case(curr_state)
      MUL1 : begin
        mul_pinB_out = rs1; // @[skipadd.scala 90:23]
      end
      MUL2 : begin
        mul_pinB_out = rs2; // @[skipadd.scala 94:23]
      end
      default : begin
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      sum_reg <= 64'h0; // @[Data.scala 400:33]
      curr_state <= IDLE; // @[Data.scala 400:33]
    end else begin
      curr_state <= next_state; // @[Reg.scala 39:30]
      if(mul1_mul_end) begin
        sum_reg <= mul_dout_in; // @[skipadd.scala 58:13]
      end else begin
        if(mul2_mul_end) begin
          sum_reg <= ($signed(mul_dout_in) + $signed(sum_reg)); // @[skipadd.scala 60:13]
        end
      end
    end
  end

  always @(posedge clk) begin
    tmp_mul1_state_in_regNext <= tmp_mul1_state_in; // @[Reg.scala 39:30]
    tmp_mul2_state_in_regNext <= tmp_mul2_state_in; // @[Reg.scala 39:30]
  end


endmodule

// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : decoder
// Git hash  : 31ce619fdcbb774cfe2df26d308fe4584454b941

`timescale 1ns/1ps 
module decoder (
  input               instr_valid,
  input      [15:0]   instr_payload,
  output reg [4:0]    dec_rs1_index,
  output reg [4:0]    dec_rs2_index,
  output reg [4:0]    dec_rd_index,
  output reg [31:0]   dec_imm,
  output reg          dec_imm_is_rs2,
  output reg          dec_is_jump,
  output reg          dec_is_branch,
  output reg          dec_is_wload,
  output reg          dec_is_wstore,
  output reg          dec_is_vector_instr,
  output reg          dec_is_vload,
  output reg          dec_is_vstore1,
  output reg          dec_is_vstore2,
  output reg          dec_info_vld,
  output reg [4:0]    op_type
);
  localparam NOP = 5'd0;
  localparam LW = 5'd1;
  localparam LV = 5'd2;
  localparam SW = 5'd3;
  localparam SV1 = 5'd4;
  localparam SV2 = 5'd5;
  localparam J = 5'd6;
  localparam JAL = 5'd7;
  localparam JR = 5'd8;
  localparam BEQZ = 5'd9;
  localparam BNEZ = 5'd10;
  localparam MV = 5'd11;
  localparam EBREAK = 5'd12;
  localparam VMUL_SUM = 5'd13;
  localparam V_MUL = 5'd14;
  localparam MUL = 5'd15;
  localparam DIV = 5'd16;
  localparam ADDI4SPN = 5'd17;
  localparam ADDI = 5'd18;
  localparam ADD = 5'd19;
  localparam SUB = 5'd20;
  localparam SRLI = 5'd21;
  localparam SRAI = 5'd22;
  localparam SRL_1 = 5'd23;
  localparam SLLI = 5'd24;
  localparam SLL_1 = 5'd25;

  wire       [4:0]    tmp_rs1_index_short;
  wire       [2:0]    tmp_rs1_index_short_1;
  wire       [4:0]    tmp_rs2_index_short;
  wire       [2:0]    tmp_rs2_index_short_1;
  wire       [4:0]    tmp_imm_op00;
  wire       [31:0]   tmp_imm_op11;
  wire       [1:0]    tmp_imm_op11_1;
  wire       [31:0]   tmp_dec_imm;
  wire       [7:0]    tmp_dec_imm_1;
  wire       [31:0]   tmp_dec_imm_2;
  wire       [5:0]    tmp_dec_imm_3;
  wire       [31:0]   tmp_dec_imm_4;
  wire       [10:0]   tmp_dec_imm_5;
  wire       [31:0]   tmp_dec_imm_6;
  wire       [5:0]    tmp_dec_imm_7;
  wire       [31:0]   tmp_dec_imm_8;
  wire       [5:0]    tmp_dec_imm_9;
  wire       [31:0]   tmp_dec_imm_10;
  wire       [10:0]   tmp_dec_imm_11;
  wire       [31:0]   tmp_dec_imm_12;
  wire       [7:0]    tmp_dec_imm_13;
  wire       [31:0]   tmp_dec_imm_14;
  wire       [7:0]    tmp_dec_imm_15;
  wire       [31:0]   tmp_dec_imm_16;
  wire       [5:0]    tmp_dec_imm_17;
  wire       [4:0]    tmp_dec_rd_index;
  wire       [3:0]    tmp_dec_rd_index_1;
  wire       [2:0]    tmp_dec_rs1_index;
  wire       [31:0]   tmp_dec_imm_18;
  wire       [4:0]    tmp_dec_imm_19;
  wire       [2:0]    tmp_dec_rs2_index;
  wire       [4:0]    tmp_dec_rd_index_2;
  wire       [2:0]    tmp_dec_rd_index_3;
  wire       [2:0]    tmp_dec_rs1_index_1;
  wire       [2:0]    tmp_dec_rs1_index_2;
  wire       [31:0]   tmp_dec_imm_20;
  wire       [4:0]    tmp_dec_imm_21;
  wire       [4:0]    tmp_dec_rs2_index_1;
  wire       [1:0]    op;
  wire       [2:0]    funct3;
  wire       [4:0]    rs1_index_short;
  wire       [4:0]    rs1_index;
  wire       [4:0]    rs2_index_short;
  wire       [4:0]    rs2_index;
  wire       [31:0]   imm_op00;
  wire       [34:0]   imm_op11;
  `ifndef SYNTHESIS
  reg [63:0] op_type_string;
  `endif


  assign tmp_rs1_index_short_1 = instr_payload[9 : 7];
  assign tmp_rs1_index_short = {2'd0, tmp_rs1_index_short_1};
  assign tmp_rs2_index_short_1 = instr_payload[4 : 2];
  assign tmp_rs2_index_short = {2'd0, tmp_rs2_index_short_1};
  assign tmp_imm_op00 = {instr_payload[12 : 10],instr_payload[6 : 5]};
  assign tmp_imm_op11_1 = instr_payload[8 : 7];
  assign tmp_imm_op11 = {{30{tmp_imm_op11_1[1]}}, tmp_imm_op11_1};
  assign tmp_dec_imm_1 = instr_payload[12 : 5];
  assign tmp_dec_imm = {24'd0, tmp_dec_imm_1};
  assign tmp_dec_imm_3 = {instr_payload[12],rs2_index};
  assign tmp_dec_imm_2 = {{26{tmp_dec_imm_3[5]}}, tmp_dec_imm_3};
  assign tmp_dec_imm_5 = instr_payload[12 : 2];
  assign tmp_dec_imm_4 = {{21{tmp_dec_imm_5[10]}}, tmp_dec_imm_5};
  assign tmp_dec_imm_7 = {instr_payload[12],rs2_index};
  assign tmp_dec_imm_6 = {26'd0, tmp_dec_imm_7};
  assign tmp_dec_imm_9 = {instr_payload[12],rs2_index};
  assign tmp_dec_imm_8 = {26'd0, tmp_dec_imm_9};
  assign tmp_dec_imm_11 = instr_payload[12 : 2];
  assign tmp_dec_imm_10 = {{21{tmp_dec_imm_11[10]}}, tmp_dec_imm_11};
  assign tmp_dec_imm_13 = {instr_payload[12 : 10],instr_payload[6 : 2]};
  assign tmp_dec_imm_12 = {{24{tmp_dec_imm_13[7]}}, tmp_dec_imm_13};
  assign tmp_dec_imm_15 = {instr_payload[12 : 10],instr_payload[6 : 2]};
  assign tmp_dec_imm_14 = {{24{tmp_dec_imm_15[7]}}, tmp_dec_imm_15};
  assign tmp_dec_imm_17 = {instr_payload[12],rs2_index};
  assign tmp_dec_imm_16 = {26'd0, tmp_dec_imm_17};
  assign tmp_dec_rd_index_1 = instr_payload[5 : 2];
  assign tmp_dec_rd_index = {1'd0, tmp_dec_rd_index_1};
  assign tmp_dec_rs1_index = instr_payload[10 : 8];
  assign tmp_dec_imm_19 = {instr_payload[13 : 11],instr_payload[7 : 6]};
  assign tmp_dec_imm_18 = {{27{tmp_dec_imm_19[4]}}, tmp_dec_imm_19};
  assign tmp_dec_rs2_index = instr_payload[12 : 10];
  assign tmp_dec_rd_index_3 = instr_payload[9 : 7];
  assign tmp_dec_rd_index_2 = {2'd0, tmp_dec_rd_index_3};
  assign tmp_dec_rs1_index_1 = instr_payload[4 : 2];
  assign tmp_dec_rs1_index_2 = instr_payload[11 : 9];
  assign tmp_dec_imm_21 = {instr_payload[14 : 12],instr_payload[8 : 7]};
  assign tmp_dec_imm_20 = {{27{tmp_dec_imm_21[4]}}, tmp_dec_imm_21};
  assign tmp_dec_rs2_index_1 = instr_payload[6 : 2];
  `ifndef SYNTHESIS
  always @(*) begin
    case(op_type)
      NOP : op_type_string = "NOP     ";
      LW : op_type_string = "LW      ";
      LV : op_type_string = "LV      ";
      SW : op_type_string = "SW      ";
      SV1 : op_type_string = "SV1     ";
      SV2 : op_type_string = "SV2     ";
      J : op_type_string = "J       ";
      JAL : op_type_string = "JAL     ";
      JR : op_type_string = "JR      ";
      BEQZ : op_type_string = "BEQZ    ";
      BNEZ : op_type_string = "BNEZ    ";
      MV : op_type_string = "MV      ";
      EBREAK : op_type_string = "EBREAK  ";
      VMUL_SUM : op_type_string = "VMUL_SUM";
      V_MUL : op_type_string = "V_MUL   ";
      MUL : op_type_string = "MUL     ";
      DIV : op_type_string = "DIV     ";
      ADDI4SPN : op_type_string = "ADDI4SPN";
      ADDI : op_type_string = "ADDI    ";
      ADD : op_type_string = "ADD     ";
      SUB : op_type_string = "SUB     ";
      SRLI : op_type_string = "SRLI    ";
      SRAI : op_type_string = "SRAI    ";
      SRL_1 : op_type_string = "SRL_1   ";
      SLLI : op_type_string = "SLLI    ";
      SLL_1 : op_type_string = "SLL_1   ";
      default : op_type_string = "????????";
    endcase
  end
  `endif

  assign op = instr_payload[1 : 0]; // @[BaseType.scala 299:24]
  assign funct3 = instr_payload[15 : 13]; // @[BaseType.scala 299:24]
  assign rs1_index_short = tmp_rs1_index_short; // @[BaseType.scala 318:22]
  assign rs1_index = instr_payload[11 : 7]; // @[BaseType.scala 318:22]
  assign rs2_index_short = tmp_rs2_index_short; // @[BaseType.scala 318:22]
  assign rs2_index = instr_payload[6 : 2]; // @[BaseType.scala 318:22]
  assign imm_op00 = {{27{tmp_imm_op00[4]}}, tmp_imm_op00}; // @[BaseType.scala 299:24]
  assign imm_op11 = {instr_payload[14 : 12],tmp_imm_op11}; // @[BaseType.scala 299:24]
  always @(*) begin
    dec_rs1_index = 5'h0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 56:28]
          end
          3'b110 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 64:28]
          end
          3'b000 : begin
            dec_rs1_index = 5'h02; // @[decoder.scala 72:28]
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            dec_rs1_index = rs1_index; // @[decoder.scala 83:28]
          end
          3'b001 : begin
            dec_rs1_index = 5'h0; // @[decoder.scala 95:28]
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                dec_rs1_index = rs1_index_short; // @[decoder.scala 104:32]
              end
              2'b01 : begin
                dec_rs1_index = rs1_index_short; // @[decoder.scala 110:32]
              end
              2'b11 : begin
                case(instr_payload[6 : 5])
                  2'b00 : begin
                    dec_rs1_index = rs1_index_short; // @[decoder.scala 117:36]
                  end
                  default : begin
                  end
                endcase
              end
              default : begin
              end
            endcase
          end
          3'b101 : begin
            dec_rs1_index = 5'h0; // @[decoder.scala 129:28]
          end
          3'b110 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 136:28]
          end
          3'b111 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 143:28]
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            dec_rs1_index = rs1_index_short; // @[decoder.scala 154:30]
          end
          3'b100 : begin
            dec_rs1_index = rs1_index; // @[decoder.scala 160:30]
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_rs1_index = {2'd0, tmp_dec_rs1_index}; // @[decoder.scala 188:30]
            end else begin
              case(funct3)
                3'b000 : begin
                  dec_rs1_index = {2'd0, tmp_dec_rs1_index_1}; // @[decoder.scala 199:34]
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rs1_index = instr_payload[11 : 7]; // @[decoder.scala 206:38]
                    end
                    default : begin
                      dec_rs1_index = instr_payload[11 : 7]; // @[decoder.scala 211:38]
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            dec_rs1_index = {2'd0, tmp_dec_rs1_index_2}; // @[decoder.scala 223:28]
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_rs2_index = 5'h0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b110 : begin
            dec_rs2_index = rs2_index_short; // @[decoder.scala 66:28]
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b11 : begin
                case(instr_payload[6 : 5])
                  2'b00 : begin
                    dec_rs2_index = rs2_index_short; // @[decoder.scala 118:36]
                  end
                  default : begin
                  end
                endcase
              end
              default : begin
              end
            endcase
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b100 : begin
            dec_rs2_index = rs2_index; // @[decoder.scala 161:30]
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if(!(instr_payload[15 : 14] == 2'b01)) begin
              case(funct3)
                3'b000 : begin
                  dec_rs2_index = {2'd0, tmp_dec_rs2_index}; // @[decoder.scala 197:34]
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      dec_rs2_index = instr_payload[6 : 2]; // @[decoder.scala 207:38]
                    end
                    default : begin
                      dec_rs2_index = instr_payload[6 : 2]; // @[decoder.scala 212:38]
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            dec_rs2_index = tmp_dec_rs2_index_1; // @[decoder.scala 225:28]
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_rd_index = 5'h0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_rd_index = rs2_index_short; // @[decoder.scala 58:27]
          end
          3'b000 : begin
            dec_rd_index = rs1_index_short; // @[decoder.scala 73:27]
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
      end
      2'b10 : begin
        case(funct3)
          3'b100 : begin
            dec_rd_index = rs1_index; // @[decoder.scala 159:29]
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_rd_index = (tmp_dec_rd_index + 5'h08); // @[decoder.scala 187:29]
            end else begin
              case(funct3)
                3'b000 : begin
                  dec_rd_index = (tmp_dec_rd_index_2 + 5'h10); // @[decoder.scala 198:33]
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_imm = 32'h0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_imm = imm_op00; // @[decoder.scala 57:22]
          end
          3'b110 : begin
            dec_imm = imm_op00; // @[decoder.scala 65:22]
          end
          3'b000 : begin
            dec_imm = tmp_dec_imm; // @[decoder.scala 74:22]
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            dec_imm = tmp_dec_imm_2; // @[decoder.scala 84:22]
          end
          3'b001 : begin
            dec_imm = tmp_dec_imm_4; // @[decoder.scala 93:22]
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                dec_imm = tmp_dec_imm_6; // @[decoder.scala 103:26]
              end
              2'b01 : begin
                dec_imm = tmp_dec_imm_8; // @[decoder.scala 109:26]
              end
              default : begin
              end
            endcase
          end
          3'b101 : begin
            dec_imm = tmp_dec_imm_10; // @[decoder.scala 127:22]
          end
          3'b110 : begin
            dec_imm = tmp_dec_imm_12; // @[decoder.scala 137:22]
          end
          3'b111 : begin
            dec_imm = tmp_dec_imm_14; // @[decoder.scala 144:22]
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            dec_imm = tmp_dec_imm_16; // @[decoder.scala 153:24]
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_imm = tmp_dec_imm_18; // @[decoder.scala 189:24]
            end
          end
          default : begin
            dec_imm = tmp_dec_imm_20; // @[decoder.scala 224:22]
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_imm_is_rs2 = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 61:29]
          end
          3'b110 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 69:29]
          end
          3'b000 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 76:29]
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            if(!((rs1_index == 5'h0) && (dec_imm == 32'h0))) begin
              dec_imm_is_rs2 = 1'b1; // @[decoder.scala 89:31]
            end
          end
          3'b001 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 96:29]
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                dec_imm_is_rs2 = 1'b1; // @[decoder.scala 105:33]
              end
              2'b01 : begin
                dec_imm_is_rs2 = 1'b1; // @[decoder.scala 111:33]
              end
              default : begin
              end
            endcase
          end
          3'b101 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 130:29]
          end
          3'b110 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 138:29]
          end
          3'b111 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 145:29]
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 155:31]
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_imm_is_rs2 = 1'b1; // @[decoder.scala 193:31]
            end
          end
          default : begin
            dec_imm_is_rs2 = 1'b1; // @[decoder.scala 227:29]
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_jump = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
        case(funct3)
          3'b001 : begin
            dec_is_jump = 1'b1; // @[decoder.scala 98:26]
          end
          3'b101 : begin
            dec_is_jump = 1'b1; // @[decoder.scala 132:26]
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    dec_is_branch = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
        case(funct3)
          3'b110 : begin
            dec_is_branch = 1'b1; // @[decoder.scala 139:28]
          end
          3'b111 : begin
            dec_is_branch = 1'b1; // @[decoder.scala 146:28]
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    dec_is_wload = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            dec_is_wload = 1'b1; // @[decoder.scala 59:27]
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    dec_is_wstore = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b110 : begin
            dec_is_wstore = 1'b1; // @[decoder.scala 67:28]
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    dec_is_vector_instr = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_is_vector_instr = 1'b1; // @[decoder.scala 190:36]
            end else begin
              case(funct3)
                3'b000 : begin
                  dec_is_vector_instr = 1'b1; // @[decoder.scala 201:40]
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            dec_is_vector_instr = 1'b1; // @[decoder.scala 226:34]
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_vload = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              dec_is_vload = 1'b1; // @[decoder.scala 192:29]
            end
          end
          default : begin
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_vstore1 = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
          end
          default : begin
            if((dec_rs2_index == 5'h0)) begin
              dec_is_vstore1 = 1'b1; // @[decoder.scala 230:31]
            end
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_is_vstore2 = 1'b0; // @[utils.scala 82:9]
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
      end
      2'b10 : begin
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
          end
          default : begin
            if(!(dec_rs2_index == 5'h0)) begin
              dec_is_vstore2 = 1'b1; // @[decoder.scala 233:31]
            end
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    op_type = NOP; // @[Enum.scala 148:67]
    case(op)
      2'b00 : begin
        case(funct3)
          3'b010 : begin
            op_type = LW; // @[Enum.scala 148:67]
          end
          3'b110 : begin
            op_type = SW; // @[Enum.scala 148:67]
          end
          3'b000 : begin
            op_type = ADDI4SPN; // @[Enum.scala 148:67]
          end
          default : begin
          end
        endcase
      end
      2'b01 : begin
        case(funct3)
          3'b000 : begin
            if(((rs1_index == 5'h0) && (dec_imm == 32'h0))) begin
              op_type = NOP; // @[Enum.scala 148:67]
            end else begin
              op_type = ADDI; // @[Enum.scala 148:67]
            end
          end
          3'b001 : begin
            op_type = JAL; // @[Enum.scala 148:67]
          end
          3'b100 : begin
            case(instr_payload[11 : 10])
              2'b00 : begin
                op_type = SRLI; // @[Enum.scala 148:67]
              end
              2'b01 : begin
                op_type = SRAI; // @[Enum.scala 148:67]
              end
              2'b11 : begin
                case(instr_payload[6 : 5])
                  2'b00 : begin
                    op_type = SUB; // @[Enum.scala 148:67]
                  end
                  default : begin
                  end
                endcase
              end
              default : begin
              end
            endcase
          end
          3'b101 : begin
            op_type = J; // @[Enum.scala 148:67]
          end
          3'b110 : begin
            op_type = BEQZ; // @[Enum.scala 148:67]
          end
          3'b111 : begin
            op_type = BNEZ; // @[Enum.scala 148:67]
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
        case(funct3)
          3'b000 : begin
            op_type = SLLI; // @[Enum.scala 148:67]
          end
          3'b100 : begin
            case(instr_payload[12])
              1'b0 : begin
                op_type = MV; // @[Enum.scala 148:67]
              end
              default : begin
                if(((rs1_index == 5'h0) && (rs2_index == 5'h0))) begin
                  op_type = EBREAK; // @[Enum.scala 148:67]
                end else begin
                  if(((! (rs1_index == 5'h0)) && (! (rs2_index == 5'h0)))) begin
                    op_type = ADD; // @[Enum.scala 148:67]
                  end else begin
                    if(((! (rs1_index == 5'h0)) && (rs2_index == 5'h0))) begin
                      op_type = JR; // @[Enum.scala 148:67]
                    end
                  end
                end
              end
            endcase
          end
          default : begin
          end
        endcase
      end
      default : begin
        case(instr_payload[15])
          1'b0 : begin
            if((instr_payload[15 : 14] == 2'b01)) begin
              op_type = LV; // @[Enum.scala 148:67]
            end else begin
              case(funct3)
                3'b000 : begin
                  op_type = VMUL_SUM; // @[Enum.scala 148:67]
                end
                3'b001 : begin
                  case(instr_payload[12])
                    1'b0 : begin
                      op_type = MUL; // @[Enum.scala 148:67]
                    end
                    default : begin
                      op_type = DIV; // @[Enum.scala 148:67]
                    end
                  endcase
                end
                default : begin
                end
              endcase
            end
          end
          default : begin
            if((dec_rs2_index == 5'h0)) begin
              op_type = SV1; // @[Enum.scala 148:67]
            end else begin
              op_type = SV2; // @[Enum.scala 148:67]
            end
          end
        endcase
      end
    endcase
  end

  always @(*) begin
    dec_info_vld = instr_valid; // @[decoder.scala 50:19]
    case(op)
      2'b00 : begin
      end
      2'b01 : begin
        case(funct3)
          3'b001 : begin
            dec_info_vld = 1'b0; // @[decoder.scala 97:27]
          end
          3'b101 : begin
            dec_info_vld = 1'b0; // @[decoder.scala 128:27]
          end
          default : begin
          end
        endcase
      end
      2'b10 : begin
      end
      default : begin
      end
    endcase
  end


endmodule

// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : fetch
// Git hash  : 31ce619fdcbb774cfe2df26d308fe4584454b941

`timescale 1ns/1ps 
module fetch (
  output              imem_rd,
  output     [9:0]    imem_addr,
  input      [15:0]   imem_rdata,
  input               fetch_start,
  input               fetch_break,
  input               fetch_restore,
  input      [9:0]    branch_addr,
  input               branch_vld,
  output              instr_valid,
  output     [15:0]   instr_payload,
  output     [9:0]    pc_curr,
  input               clk,
  input               resetn
);

  reg                 fetch_going;
  reg        [9:0]    pc_reg;
  reg        [9:0]    pc_next;
  reg                 imem_rd_regNext;

  assign imem_rd = ((fetch_start || fetch_restore) || (fetch_going && (! fetch_break))); // @[fetch.scala 42:14]
  assign pc_curr = pc_reg; // @[fetch.scala 45:14]
  always @(*) begin
    if(fetch_start) begin
      pc_next = 10'h0; // @[fetch.scala 48:13]
    end else begin
      if(branch_vld) begin
        pc_next = branch_addr[9 : 0]; // @[fetch.scala 50:13]
      end else begin
        pc_next = (pc_reg + 10'h002); // @[fetch.scala 52:13]
      end
    end
  end

  assign imem_addr = pc_next; // @[fetch.scala 59:16]
  assign instr_payload = imem_rdata; // @[fetch.scala 61:20]
  assign instr_valid = imem_rd_regNext; // @[fetch.scala 62:18]
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      fetch_going <= 1'b0; // @[Data.scala 400:33]
      pc_reg <= 10'h0; // @[Data.scala 400:33]
      imem_rd_regNext <= 1'b0; // @[Data.scala 400:33]
    end else begin
      if(fetch_start) begin
        fetch_going <= 1'b1; // @[fetch.scala 36:17]
      end else begin
        if(fetch_break) begin
          fetch_going <= 1'b0; // @[fetch.scala 38:17]
        end else begin
          if(fetch_restore) begin
            fetch_going <= 1'b1; // @[fetch.scala 40:17]
          end
        end
      end
      if(imem_rd) begin
        pc_reg <= pc_next; // @[fetch.scala 56:12]
      end
      imem_rd_regNext <= imem_rd; // @[Reg.scala 39:30]
    end
  end


endmodule

// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : apb2mem_trans
// Git hash  : 64a8a01180c8b78a22afff4458f6a364a04ce1c3

`timescale 1ns/1ps

module apb2mem_trans (
  input      [11:0]   apb_slv_PADDR,
  input      [0:0]    apb_slv_PSEL,
  input               apb_slv_PENABLE,
  output reg          apb_slv_PREADY,
  input               apb_slv_PWRITE,
  input      [31:0]   apb_slv_PWDATA,
  output reg [31:0]   apb_slv_PRDATA,
  output              apb_slv_PSLVERROR,
  output reg          mem_ena,
  output reg          mem_wena,
  output reg [3:0]    mem_wsel,
  output reg [6:0]    mem_addr,
  output reg [127:0]  mem_wdata,
  input      [127:0]  mem_rdata
);

  wire       [3:0]    tmp_wsel;
  wire       [1:0]    shiftnum;
  wire       [3:0]    wsel;
  wire       [6:0]    bitoffset;

  assign tmp_wsel = (4'b0001 <<< shiftnum);
  assign shiftnum = apb_slv_PADDR[3 : 2]; // @[BaseType.scala 299:24]
  assign wsel = tmp_wsel; // @[BaseType.scala 318:22]
  assign bitoffset = ({5'd0,shiftnum} <<< 5); // @[BaseType.scala 299:24]
  assign apb_slv_PSLVERROR = 1'b0; // @[apb2mem_trans.scala 46:24]
  always @(*) begin
    apb_slv_PREADY = 1'b0; // @[apb2mem_trans.scala 47:21]
    if(apb_slv_PSEL[0]) begin
      if(apb_slv_PWRITE) begin
        if(apb_slv_PENABLE) begin
          apb_slv_PREADY = 1'b1; // @[apb2mem_trans.scala 63:27]
        end else begin
          apb_slv_PREADY = 1'b0; // @[apb2mem_trans.scala 67:27]
        end
      end else begin
        if(apb_slv_PENABLE) begin
          apb_slv_PREADY = 1'b1; // @[apb2mem_trans.scala 73:27]
        end else begin
          apb_slv_PREADY = 1'b0; // @[apb2mem_trans.scala 79:27]
        end
      end
    end
  end

  always @(*) begin
    apb_slv_PRDATA = 32'h0; // @[apb2mem_trans.scala 48:21]
    if(apb_slv_PSEL[0]) begin
      if(!apb_slv_PWRITE) begin
        if(apb_slv_PENABLE) begin
          apb_slv_PRDATA = mem_rdata[bitoffset +: 32]; // @[apb2mem_trans.scala 74:27]
        end
      end
    end
  end

  always @(*) begin
    mem_ena = 1'b0; // @[apb2mem_trans.scala 50:14]
    if(apb_slv_PSEL[0]) begin
      if(apb_slv_PWRITE) begin
        if(apb_slv_PENABLE) begin
          mem_ena = 1'b1; // @[apb2mem_trans.scala 58:20]
        end else begin
          mem_ena = 1'b0; // @[apb2mem_trans.scala 65:20]
        end
      end else begin
        if(apb_slv_PENABLE) begin
          mem_ena = 1'b0; // @[apb2mem_trans.scala 71:20]
        end else begin
          mem_ena = 1'b1; // @[apb2mem_trans.scala 76:20]
        end
      end
    end
  end

  always @(*) begin
    mem_wena = 1'b0; // @[apb2mem_trans.scala 51:15]
    if(apb_slv_PSEL[0]) begin
      if(apb_slv_PWRITE) begin
        if(apb_slv_PENABLE) begin
          mem_wena = 1'b1; // @[apb2mem_trans.scala 59:21]
        end else begin
          mem_wena = 1'b0; // @[apb2mem_trans.scala 66:21]
        end
      end else begin
        if(apb_slv_PENABLE) begin
          mem_wena = 1'b0; // @[apb2mem_trans.scala 72:21]
        end else begin
          mem_wena = 1'b0; // @[apb2mem_trans.scala 77:21]
        end
      end
    end
  end

  always @(*) begin
    mem_wsel = 4'b0000; // @[apb2mem_trans.scala 52:15]
    if(apb_slv_PSEL[0]) begin
      if(apb_slv_PWRITE) begin
        if(apb_slv_PENABLE) begin
          mem_wsel = wsel; // @[apb2mem_trans.scala 61:21]
        end
      end
    end
  end

  always @(*) begin
    mem_wdata = 128'h0; // @[apb2mem_trans.scala 53:16]
    if(apb_slv_PSEL[0]) begin
      if(apb_slv_PWRITE) begin
        if(apb_slv_PENABLE) begin
          mem_wdata[bitoffset +: 32] = apb_slv_PWDATA; // @[apb2mem_trans.scala 62:52]
        end
      end
    end
  end

  always @(*) begin
    mem_addr = 7'h0; // @[apb2mem_trans.scala 54:15]
    if(apb_slv_PSEL[0]) begin
      if(apb_slv_PWRITE) begin
        if(apb_slv_PENABLE) begin
          mem_addr = apb_slv_PADDR[10 : 4]; // @[apb2mem_trans.scala 60:21]
        end
      end else begin
        if(!apb_slv_PENABLE) begin
          mem_addr = apb_slv_PADDR[10 : 4]; // @[apb2mem_trans.scala 78:21]
        end
      end
    end
  end


endmodule

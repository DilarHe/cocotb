// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : TCMToRAMBridge
// Git hash  : fdd14e11ef0d6b0cf73fe737ea2270459ff49459

`timescale 1ns/1ps 
module TCMToRAMBridge (
  input  wire [31:0]   tcm_TCMADDR,
  input  wire          tcm_TCMCS,
  input  wire          tcm_TCMPRIV,
  input  wire          tcm_TCMWR,
  input  wire [4:0]    tcm_TCMBYTEWR,
  input  wire [38:0]   tcm_TCMWDATA,
  input  wire [3:0]    tcm_TCMMASTER,
  output wire [38:0]   tcm_TCMRDATA,
  output wire          tcm_TCMWAIT,
  output wire          tcm_TCMERR,
  output reg           ram_req,
  output reg           ram_we,
  output reg  [31:0]   ram_addr,
  output reg  [3:0]    ram_be,
  output reg  [31:0]   ram_wdata,
  input  wire [31:0]   ram_rdata,
  input  wire          ram_grant,
  input  wire          clk,
  input  wire          resetn
);

  reg                 reqBufVld;
  reg                 we;
  reg        [3:0]    be;
  reg        [31:0]   addr;
  reg        [31:0]   wdata;

  always @(*) begin
    if(reqBufVld) begin
      ram_req = 1'b1;
    end else begin
      ram_req = tcm_TCMCS;
    end
  end

  always @(*) begin
    if(reqBufVld) begin
      ram_we = we;
    end else begin
      ram_we = (tcm_TCMCS && tcm_TCMWR);
    end
  end

  always @(*) begin
    if(reqBufVld) begin
      ram_be = be;
    end else begin
      ram_be = tcm_TCMBYTEWR[3:0];
    end
  end

  always @(*) begin
    if(reqBufVld) begin
      ram_addr = addr;
    end else begin
      ram_addr = tcm_TCMADDR;
    end
  end

  always @(*) begin
    if(reqBufVld) begin
      ram_wdata = wdata;
    end else begin
      ram_wdata = tcm_TCMWDATA[31 : 0];
    end
  end

  assign tcm_TCMRDATA = {7'd0, ram_rdata};
  assign tcm_TCMWAIT = reqBufVld;
  assign tcm_TCMERR = 1'b0;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      reqBufVld <= 1'b0;
      we <= 1'b0;
      be <= 4'b0000;
      addr <= 32'h0;
      wdata <= 32'h0;
    end else begin
      if(((tcm_TCMCS && (! ram_grant)) && (! reqBufVld))) begin
        reqBufVld <= 1'b1;
        we <= tcm_TCMWR;
        be <= tcm_TCMBYTEWR[3:0];
        addr <= tcm_TCMADDR;
        wdata <= tcm_TCMWDATA[31 : 0];
      end else begin
        if((reqBufVld && ram_grant)) begin
          reqBufVld <= 1'b0;
        end
      end
    end
  end


endmodule

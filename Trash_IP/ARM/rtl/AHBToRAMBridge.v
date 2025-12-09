// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : AHBToRAMBridge

`timescale 1ns/1ps 
module AHBToRAMBridge (
  input  wire [31:0]   ahbs_HADDR,
  input  wire          ahbs_HSEL,
  input  wire          ahbs_HREADY,
  input  wire          ahbs_HWRITE,
  input  wire [2:0]    ahbs_HSIZE,
  input  wire [2:0]    ahbs_HBURST,
  input  wire [3:0]    ahbs_HPROT,
  input  wire [1:0]    ahbs_HTRANS,
  input  wire          ahbs_HMASTLOCK,
  input  wire [31:0]   ahbs_HWDATA,
  output wire [31:0]   ahbs_HRDATA,
  output wire          ahbs_HREADYOUT,
  output wire          ahbs_HRESP,
  output wire          ram_req,
  input  wire          ram_grant,
  output wire          ram_we,
  output wire [31:0]   ram_addr,
  output wire [3:0]    ram_be,
  output wire [31:0]   ram_wdata,
  input  wire [31:0]   ram_rdata,
  input  wire          clk,
  input  wire          resetn
);

  wire                ahb_wr_req;
  wire                ahb_rd_req;
  reg                 wr_buf_vld;
  reg                 rd_buf_vld;
  reg        [31:0]   addr;
  reg                 write;
  wire       [31:0]   wdata;
  reg        [2:0]    size;
  wire                ram_write_handshake_done;
  reg                 ram_read_handshake_done;
  reg        [3:0]    ram_be_i;

  assign ahb_wr_req = (((ahbs_HSEL && ahbs_HREADY) && ahbs_HTRANS[1]) && ahbs_HWRITE);
  assign ahb_rd_req = (((ahbs_HSEL && ahbs_HREADY) && ahbs_HTRANS[1]) && (! ahbs_HWRITE));
  assign ram_write_handshake_done = (wr_buf_vld && ram_grant);
  assign wdata = ahbs_HWDATA;
  always @(*) begin
    case(size)
      3'b000 : begin
        case(ahbs_HADDR[1 : 0])
          2'b00 : begin
            ram_be_i = 4'b0001;
          end
          2'b01 : begin
            ram_be_i = 4'b0010;
          end
          2'b10 : begin
            ram_be_i = 4'b0100;
          end
          default : begin
            ram_be_i = 4'b1000;
          end
        endcase
      end
      3'b001 : begin
        ram_be_i = (ahbs_HADDR[1] ? 4'b1100 : 4'b0011);
      end
      default : begin
        ram_be_i = 4'b1111;
      end
    endcase
  end

  assign ahbs_HREADYOUT = ((ram_write_handshake_done || ram_read_handshake_done) || ((! wr_buf_vld) && (! rd_buf_vld)));
  assign ahbs_HRESP = 1'b0;
  assign ahbs_HRDATA = ram_rdata;
  assign ram_req = ((rd_buf_vld || wr_buf_vld) || ahb_rd_req);
  assign ram_we = wr_buf_vld;
  assign ram_addr = ((wr_buf_vld || rd_buf_vld) ? addr : ahbs_HADDR);
  assign ram_be = ram_be_i;
  assign ram_wdata = wdata;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      wr_buf_vld <= 1'b0;
      rd_buf_vld <= 1'b0;
      addr <= 32'h0;
      write <= 1'b0;
      size <= 3'b000;
      ram_read_handshake_done <= 1'b1;
    end else begin
      ram_read_handshake_done <= ((((ahb_rd_req && ram_grant) && (! rd_buf_vld)) && (! wr_buf_vld)) || (rd_buf_vld && ram_grant));
      wr_buf_vld <= ((ahb_wr_req && ahbs_HREADYOUT) || (wr_buf_vld && (! ram_grant)));
      rd_buf_vld <= (((((ahb_rd_req && (! ram_grant)) && (! rd_buf_vld)) && (! wr_buf_vld)) || (ram_write_handshake_done && ahb_rd_req)) || (rd_buf_vld && (! ram_grant)));
      if((ahb_wr_req && ahbs_HREADYOUT)) begin
        addr <= ahbs_HADDR;
        write <= 1'b1;
        size <= ahbs_HSIZE;
      end else begin
        if(((ram_write_handshake_done && ahb_rd_req) || (((ahb_rd_req && (! ram_grant)) && (! rd_buf_vld)) && (! wr_buf_vld)))) begin
          addr <= ahbs_HADDR;
          write <= 1'b0;
          size <= ahbs_HSIZE;
        end
      end
    end
  end


endmodule

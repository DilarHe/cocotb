module moc_membank #(
    parameter AHB_BASE     = 32'h0000_0000, // AHB基地址    
    parameter TCM_BASE     = 32'h0000_0000, // TCM基地址
    parameter RAM_BASE     = 32'h0000_0000, // RAM基地址
    
    parameter NUM_RAMS     = 4,             // RAM单元数量
    parameter AHB_ADDR_W   = 32,            // AHB地址总线宽度
    parameter RAM_ADDR_W   = 10,            // 每个RAM地址宽度
    parameter RAM_DATA_W   = 32,            // 每个RAM数据宽度
    parameter BYTE_W       = RAM_DATA_W/8,  // 字节宽度    
    parameter BANK_SPAN    = 64*(2**10)     // 每个Bank地址跨度
)(
    // AHB-Lite 接口
    input                       HCLK,
    input                       HRESETn,
    input  [AHB_ADDR_W-1:0]     HADDR,
    input                       HWRITE,
    input  [1:0]                HTRANS,
    input  [2:0]                HSIZE,
    input  [RAM_DATA_W-1:0]     HWDATA,
    output [RAM_DATA_W-1:0]     HRDATA,
    output                      HREADYOUT,
    output                      HRESP,

    // TCM专用接口
    input                       tcm_cs,
    input                       tcm_wr,
    input  [BYTE_W-1:0]         tcm_bytewr,
    input  [RAM_ADDR_W-1:0]     tcm_addr,
    input  [RAM_DATA_W-1:0]     tcm_wdata,
    output [RAM_DATA_W-1:0]     tcm_rdata,
    input                       tcm_priv,
    input  [3:0]                tcm_master,
    output                      tcm_wait,
    output                      tcm_err,
    
    // RAM常规接口（生成数组）
    input [NUM_RAMS-1:0]                 ram_rd,
    input [NUM_RAMS-1:0]                 ram_wr,
    input [NUM_RAMS-1:0][BYTE_W-1:0]     ram_wmask,
    input [NUM_RAMS-1:0][RAM_ADDR_W-1:0] ram_addr,
    input [NUM_RAMS-1:0][RAM_DATA_W-1:0] ram_wdata,
    output  [NUM_RAMS-1:0][RAM_DATA_W-1:0] ram_rdata
);

//
wire [NUM_RAMS-1:0] ram_req;

wire [NUM_RAMS-1:0] ram_cen;
wire [NUM_RAMS-1:0] ram_wen;
wire [NUM_RAMS-1:0] ram_wmask_inter;
wire [NUM_RAMS-1:0] [RAM_ADDR_W-1:0] ram_addr_inter;
wire [NUM_RAMS-1:0] [RAM_DATA_W-1:0] ram_wdata_inter;
wire [NUM_RAMS-1:0] [RAM_DATA_W-1:0] ram_rdata_inter;
// AHB REQ
logic [NUM_RAMS-1:0] ahb_req;
logic [NUM_RAMS-1:0] ahb_req_shakehands;
logic [NUM_RAMS-1:0] ahb_req_grant;
logic [RAM_DATA_W-1:0] ahb_sel_rdata;

logic [NUM_RAMS-1:0] ahb_req_rd;
logic [NUM_RAMS-1:0] ahb_req_wr;
// save write
logic [NUM_RAMS-1:0] ahb_req_wr_buf;
logic [RAM_ADDR_W-1:0] ahb_req_wr_addr_buf;
// 生成RAM选择信号
logic [NUM_RAMS-1:0] ahb_ram_select;
logic [NUM_RAMS-1:0] ahb_ram_select_shadow;
generate
for(genvar i=0; i<NUM_RAMS; i=i+1) begin
    localparam RAM_START = RAM_BASE + i*BANK_SPAN;
    localparam RAM_END   = RAM_START + BANK_SPAN -1;
    /* verilator lint_off UNSIGNED */
    assign ahb_ram_select[i] = (HADDR >= RAM_START) && (HADDR <= RAM_END);
    /* verilator lint_on UNSIGNED */
end
endgenerate

always @(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        ahb_ram_select_shadow <= 0;
        ahb_req_wr_buf <= 0;
        ahb_req_wr_addr_buf <= 0;
    end else begin
        ahb_ram_select_shadow <= ahb_ram_select;
        ahb_req_wr_buf <= ahb_req_wr;
        ahb_req_wr_addr_buf <= HADDR;
    end
end

assign ahb_req = ahb_ram_select & {4{HTRANS[1]}};
assign ahb_req_rd = {4{~HWRITE}} & ahb_req ;
assign ahb_req_wr = {4{HWRITE}}  & ahb_req ;
assign ahb_req_grant =  ahb_ram_select & (~ram_req) ;
assign ahb_req_shakehands =  ahb_req & ahb_req_grant    ;

always_comb begin
    ahb_sel_rdata = '0;  // 默认值
    for (int i = 0; i < NUM_RAMS; i++) begin
        if (ahb_ram_select_shadow[i]) begin
            ahb_sel_rdata = ram_rdata_inter[i];
        end
    end
end

assign HREADYOUT = |ahb_req_grant;
assign HRDATA = ahb_sel_rdata;

assign ram_req = ram_rd  | ram_wr;
assign ram_cen = ram_req | ahb_req_rd | ahb_req_wr_buf;
assign ram_wen = ram_wr  | ahb_req_wr_buf;

generate
for(genvar i=0; i<NUM_RAMS; i=i+1) begin
    assign ram_addr_inter[i] = ahb_req[i]? HADDR : ram_addr[i];
    assign ram_wdata_inter[i] = ahb_req_wr_buf[i]? HWDATA : ram_wdata[i];
    assign ram_wmask_inter[i] = ahb_req[i]? {BYTE_W{1'b0}} : ram_wmask[i];
    assign ram_rdata[i] = ram_rdata_inter[i];
end
endgenerate

//for test
wire ram_wen0;
wire ram_wen1;
wire ram_wen2;
wire ram_wen3;

wire ram_cen0;
wire ram_cen1;
wire ram_cen2;
wire ram_cen3;

wire [RAM_ADDR_W-1:0] ram_addr_inter0;
wire [RAM_ADDR_W-1:0] ram_addr_inter1;
wire [RAM_ADDR_W-1:0] ram_addr_inter2;
wire [RAM_ADDR_W-1:0] ram_addr_inter3;

wire [RAM_DATA_W-1:0] ram_wdata_inter0;
wire [RAM_DATA_W-1:0] ram_wdata_inter1;
wire [RAM_DATA_W-1:0] ram_wdata_inter2;
wire [RAM_DATA_W-1:0] ram_wdata_inter3;

wire [RAM_DATA_W-1:0] ram_rdata_inter0;
wire [RAM_DATA_W-1:0] ram_rdata_inter1;
wire [RAM_DATA_W-1:0] ram_rdata_inter2;
wire [RAM_DATA_W-1:0] ram_rdata_inter3;


assign ram_wen0 = ram_wen[0];
assign ram_wen1 = ram_wen[1];
assign ram_wen2 = ram_wen[2];
assign ram_wen3 = ram_wen[3];

assign ram_cen0 = ram_cen[0];
assign ram_cen1 = ram_cen[1];
assign ram_cen2 = ram_cen[2];
assign ram_cen3 = ram_cen[3];

assign ram_addr_inter0 = ram_addr_inter[0];
assign ram_addr_inter1 = ram_addr_inter[1];
assign ram_addr_inter2 = ram_addr_inter[2];
assign ram_addr_inter3 = ram_addr_inter[3];

assign ram_wdata_inter0 = ram_wdata_inter[0];
assign ram_wdata_inter1 = ram_wdata_inter[1];
assign ram_wdata_inter2 = ram_wdata_inter[2];
assign ram_wdata_inter3 = ram_wdata_inter[3];

assign ram_rdata_inter[0] = ram_rdata_inter0;
assign ram_rdata_inter[1] = ram_rdata_inter1;
assign ram_rdata_inter[2] = ram_rdata_inter2;
assign ram_rdata_inter[3] = ram_rdata_inter3;

endmodule
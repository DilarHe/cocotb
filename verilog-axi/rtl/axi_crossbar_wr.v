/*

Copyright (c) 2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`resetall
`timescale 1ns / 1ps
`default_nettype none

/*
 * AXI4 crossbar (write)
 */
module axi_crossbar_wr #
(
    // Number of AXI inputs (slave interfaces)
    parameter S_COUNT = 4,
    // Number of AXI outputs (master interfaces)
    parameter M_COUNT = 4,
    // Width of data bus in bits
    parameter DATA_WIDTH = 32,
    // Width of address bus in bits
    parameter ADDR_WIDTH = 32,
    // Width of wstrb (width of data bus in words)
    parameter STRB_WIDTH = (DATA_WIDTH/8),
    // Input ID field width (from AXI masters)
    parameter S_ID_WIDTH = 8,
    // Output ID field width (towards AXI slaves)
    // Additional bits required for response routing
    parameter M_ID_WIDTH = S_ID_WIDTH+$clog2(S_COUNT),
    // Propagate awuser signal
    parameter AWUSER_ENABLE = 0,
    // Width of awuser signal
    parameter AWUSER_WIDTH = 1,
    // Propagate wuser signal
    parameter WUSER_ENABLE = 0,
    // Width of wuser signal
    parameter WUSER_WIDTH = 1,
    // Propagate buser signal
    parameter BUSER_ENABLE = 0,
    // Width of buser signal
    parameter BUSER_WIDTH = 1,
    // Number of concurrent unique IDs for each slave interface
    // S_COUNT concatenated fields of 32 bits
    parameter S_THREADS = {S_COUNT{32'd2}},
    // Number of concurrent operations for each slave interface
    // S_COUNT concatenated fields of 32 bits
    parameter S_ACCEPT = {S_COUNT{32'd16}},
    // Number of regions per master interface
    parameter M_REGIONS = 1,
    // Master interface base addresses
    // M_COUNT concatenated fields of M_REGIONS concatenated fields of ADDR_WIDTH bits
    // set to zero for default addressing based on M_ADDR_WIDTH
    parameter M_BASE_ADDR = 0,
    // Master interface address widths
    // M_COUNT concatenated fields of M_REGIONS concatenated fields of 32 bits
    parameter M_ADDR_WIDTH = {M_COUNT{{M_REGIONS{32'd24}}}},
    // Write connections between interfaces
    // M_COUNT concatenated fields of S_COUNT bits
    parameter M_CONNECT = {M_COUNT{{S_COUNT{1'b1}}}},
    // Number of concurrent operations for each master interface
    // M_COUNT concatenated fields of 32 bits
    parameter M_ISSUE = {M_COUNT{32'd4}},
    // Secure master (fail operations based on awprot/arprot)
    // M_COUNT bits
    parameter M_SECURE = {M_COUNT{1'b0}},
    // Slave interface AW channel register type (input)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter S_AW_REG_TYPE = {S_COUNT{2'd0}},
    // Slave interface W channel register type (input)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter S_W_REG_TYPE = {S_COUNT{2'd0}},
    // Slave interface B channel register type (output)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter S_B_REG_TYPE = {S_COUNT{2'd1}},
    // Master interface AW channel register type (output)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter M_AW_REG_TYPE = {M_COUNT{2'd1}},
    // Master interface W channel register type (output)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter M_W_REG_TYPE = {M_COUNT{2'd2}},
    // Master interface B channel register type (input)
    // 0 to bypass, 1 for simple buffer, 2 for skid buffer
    parameter M_B_REG_TYPE = {M_COUNT{2'd0}}
)
(
    input  wire                             clk,
    input  wire                             rst,

    /*
     * AXI slave interfaces
     */
    input  wire [S_COUNT*S_ID_WIDTH-1:0]    s_axi_awid,
    input  wire [S_COUNT*ADDR_WIDTH-1:0]    s_axi_awaddr,
    input  wire [S_COUNT*8-1:0]             s_axi_awlen,
    input  wire [S_COUNT*3-1:0]             s_axi_awsize,
    input  wire [S_COUNT*2-1:0]             s_axi_awburst,
    input  wire [S_COUNT-1:0]               s_axi_awlock,
    input  wire [S_COUNT*4-1:0]             s_axi_awcache,
    input  wire [S_COUNT*3-1:0]             s_axi_awprot,
    input  wire [S_COUNT*4-1:0]             s_axi_awqos,
    input  wire [S_COUNT*AWUSER_WIDTH-1:0]  s_axi_awuser,
    input  wire [S_COUNT-1:0]               s_axi_awvalid,
    output wire [S_COUNT-1:0]               s_axi_awready,
    input  wire [S_COUNT*DATA_WIDTH-1:0]    s_axi_wdata,
    input  wire [S_COUNT*STRB_WIDTH-1:0]    s_axi_wstrb,
    input  wire [S_COUNT-1:0]               s_axi_wlast,
    input  wire [S_COUNT*WUSER_WIDTH-1:0]   s_axi_wuser,
    input  wire [S_COUNT-1:0]               s_axi_wvalid,
    output wire [S_COUNT-1:0]               s_axi_wready,
    output wire [S_COUNT*S_ID_WIDTH-1:0]    s_axi_bid,
    output wire [S_COUNT*2-1:0]             s_axi_bresp,
    output wire [S_COUNT*BUSER_WIDTH-1:0]   s_axi_buser,
    output wire [S_COUNT-1:0]               s_axi_bvalid,
    input  wire [S_COUNT-1:0]               s_axi_bready,

    /*
     * AXI master interfaces
     */
    output wire [M_COUNT*M_ID_WIDTH-1:0]    m_axi_awid,
    output wire [M_COUNT*ADDR_WIDTH-1:0]    m_axi_awaddr,
    output wire [M_COUNT*8-1:0]             m_axi_awlen,
    output wire [M_COUNT*3-1:0]             m_axi_awsize,
    output wire [M_COUNT*2-1:0]             m_axi_awburst,
    output wire [M_COUNT-1:0]               m_axi_awlock,
    output wire [M_COUNT*4-1:0]             m_axi_awcache,
    output wire [M_COUNT*3-1:0]             m_axi_awprot,
    output wire [M_COUNT*4-1:0]             m_axi_awqos,
    output wire [M_COUNT*4-1:0]             m_axi_awregion,
    output wire [M_COUNT*AWUSER_WIDTH-1:0]  m_axi_awuser,
    output wire [M_COUNT-1:0]               m_axi_awvalid,
    input  wire [M_COUNT-1:0]               m_axi_awready,
    output wire [M_COUNT*DATA_WIDTH-1:0]    m_axi_wdata,
    output wire [M_COUNT*STRB_WIDTH-1:0]    m_axi_wstrb,
    output wire [M_COUNT-1:0]               m_axi_wlast,
    output wire [M_COUNT*WUSER_WIDTH-1:0]   m_axi_wuser,
    output wire [M_COUNT-1:0]               m_axi_wvalid,
    input  wire [M_COUNT-1:0]               m_axi_wready,
    input  wire [M_COUNT*M_ID_WIDTH-1:0]    m_axi_bid,
    input  wire [M_COUNT*2-1:0]             m_axi_bresp,
    input  wire [M_COUNT*BUSER_WIDTH-1:0]   m_axi_buser,
    input  wire [M_COUNT-1:0]               m_axi_bvalid,
    output wire [M_COUNT-1:0]               m_axi_bready
);

parameter CL_S_COUNT = $clog2(S_COUNT);
parameter CL_M_COUNT = $clog2(M_COUNT);
parameter M_COUNT_P1 = M_COUNT+1;
parameter CL_M_COUNT_P1 = $clog2(M_COUNT_P1);

integer i;

// check configuration
initial begin
    if (M_ID_WIDTH < S_ID_WIDTH+$clog2(S_COUNT)) begin
        $error("Error: M_ID_WIDTH must be at least $clog2(S_COUNT) larger than S_ID_WIDTH (instance %m)");
        $finish;
    end

    for (i = 0; i < M_COUNT*M_REGIONS; i = i + 1) begin
        if (M_ADDR_WIDTH[i*32 +: 32] && (M_ADDR_WIDTH[i*32 +: 32] < 12 || M_ADDR_WIDTH[i*32 +: 32] > ADDR_WIDTH)) begin
            $error("Error: value out of range (instance %m)");
            $finish;
        end
    end
end

wire [S_COUNT*S_ID_WIDTH-1:0]    int_s_axi_awid;
wire [S_COUNT*ADDR_WIDTH-1:0]    int_s_axi_awaddr;
wire [S_COUNT*8-1:0]             int_s_axi_awlen;
wire [S_COUNT*3-1:0]             int_s_axi_awsize;
wire [S_COUNT*2-1:0]             int_s_axi_awburst;
wire [S_COUNT-1:0]               int_s_axi_awlock;
wire [S_COUNT*4-1:0]             int_s_axi_awcache;
wire [S_COUNT*3-1:0]             int_s_axi_awprot;
wire [S_COUNT*4-1:0]             int_s_axi_awqos;
wire [S_COUNT*4-1:0]             int_s_axi_awregion;
wire [S_COUNT*AWUSER_WIDTH-1:0]  int_s_axi_awuser;
wire [S_COUNT-1:0]               int_s_axi_awvalid;
wire [S_COUNT-1:0]               int_s_axi_awready;

wire [S_COUNT*M_COUNT-1:0]       int_axi_awvalid;
wire [M_COUNT*S_COUNT-1:0]       int_axi_awready;

wire [S_COUNT*DATA_WIDTH-1:0]    int_s_axi_wdata;
wire [S_COUNT*STRB_WIDTH-1:0]    int_s_axi_wstrb;
wire [S_COUNT-1:0]               int_s_axi_wlast;
wire [S_COUNT*WUSER_WIDTH-1:0]   int_s_axi_wuser;
wire [S_COUNT-1:0]               int_s_axi_wvalid;
wire [S_COUNT-1:0]               int_s_axi_wready;

wire [S_COUNT*M_COUNT-1:0]       int_axi_wvalid;
wire [M_COUNT*S_COUNT-1:0]       int_axi_wready;

wire [M_COUNT*M_ID_WIDTH-1:0]    int_m_axi_bid;
wire [M_COUNT*2-1:0]             int_m_axi_bresp;
wire [M_COUNT*BUSER_WIDTH-1:0]   int_m_axi_buser;
wire [M_COUNT-1:0]               int_m_axi_bvalid;
wire [M_COUNT-1:0]               int_m_axi_bready;

wire [M_COUNT*S_COUNT-1:0]       int_axi_bvalid;
wire [S_COUNT*M_COUNT-1:0]       int_axi_bready;

generate

    genvar m, n;

    for (m = 0; m < S_COUNT; m = m + 1) begin : s_ifaces
        // address decode and admission control
        wire [CL_M_COUNT-1:0] a_select;

        wire m_axi_avalid;
        wire m_axi_aready;

        wire [CL_M_COUNT-1:0] m_wc_select;
        wire m_wc_decerr;
        wire m_wc_valid;
        wire m_wc_ready;

        wire m_rc_decerr;
        wire m_rc_valid;
        wire m_rc_ready;

        wire [S_ID_WIDTH-1:0] s_cpl_id;
        wire s_cpl_valid;

        axi_crossbar_addr #(
            .S(m),
            .S_COUNT(S_COUNT),
            .M_COUNT(M_COUNT),
            .ADDR_WIDTH(ADDR_WIDTH),
            .ID_WIDTH(S_ID_WIDTH),
            .S_THREADS(S_THREADS[m*32 +: 32]),
            .S_ACCEPT(S_ACCEPT[m*32 +: 32]),
            .M_REGIONS(M_REGIONS),
            .M_BASE_ADDR(M_BASE_ADDR),
            .M_ADDR_WIDTH(M_ADDR_WIDTH),
            .M_CONNECT(M_CONNECT),
            .M_SECURE(M_SECURE),
            .WC_OUTPUT(1)
        )
        addr_inst (
            .clk(clk),
            .rst(rst),

            /*
             * Address input
             */
            .s_axi_aid(int_s_axi_awid[m*S_ID_WIDTH +: S_ID_WIDTH]),
            .s_axi_aaddr(int_s_axi_awaddr[m*ADDR_WIDTH +: ADDR_WIDTH]),
            .s_axi_aprot(int_s_axi_awprot[m*3 +: 3]),
            .s_axi_aqos(int_s_axi_awqos[m*4 +: 4]),
            .s_axi_avalid(int_s_axi_awvalid[m]),
            .s_axi_aready(int_s_axi_awready[m]),

            /*
             * Address output
             */
            .m_axi_aregion(int_s_axi_awregion[m*4 +: 4]),
            .m_select(a_select),
            .m_axi_avalid(m_axi_avalid),
            .m_axi_aready(m_axi_aready),

            /*
             * Write command output
             */
            .m_wc_select(m_wc_select),
            .m_wc_decerr(m_wc_decerr),
            .m_wc_valid(m_wc_valid),
            .m_wc_ready(m_wc_ready),

            /*
             * Response command output
             */
            .m_rc_decerr(m_rc_decerr),
            .m_rc_valid(m_rc_valid),
            .m_rc_ready(m_rc_ready),

            /*
             * Completion input
             */
            .s_cpl_id(s_cpl_id),
            .s_cpl_valid(s_cpl_valid)
        );

        assign int_axi_awvalid[m*M_COUNT +: M_COUNT] = m_axi_avalid << a_select; // 根据当前master对于事物请求译码的得到的slave选择信号，将当前master事物avalid信号路由给对应的Slave（master接口）
        assign m_axi_aready = int_axi_awready[a_select*S_COUNT+m]; // 根据当前master对于事物请求译码的得到的slave选择信号，将当前Slave（master接口）的awready信号反路由到master

        // write command handling
        reg [CL_M_COUNT-1:0] w_select_reg = 0, w_select_next; // 记录当前addr译码出的master选择信号，用于w通道请求正向路由
        reg w_drop_reg = 1'b0, w_drop_next; // 记录当前addr请求产生的m_wc_decerr，来决定W通道是否丢弃对应的数据
        reg w_select_valid_reg = 1'b0, w_select_valid_next; // 记录当前addr译码出的master选择信号是否有效，用于w通道请求正向路由

        assign m_wc_ready = !w_select_valid_reg;

        always @* begin
            w_select_next = w_select_reg;
            // 如果当前master的w通道数据有效，且当前master的w通道ready，且当前master的w通道是最后一个数据，那么w_drop_next为0，否则保持上一个事物的drop信息
            w_drop_next = w_drop_reg && !(int_s_axi_wvalid[m] && int_s_axi_wready[m] && int_s_axi_wlast[m]);
            // 如果当前master的w通道数据有效，且当前master的w通道ready，且当前master的w通道是最后一个数据，那么w_select_valid_next为0，否则保持上一个事物的select信息
            w_select_valid_next = w_select_valid_reg && !(int_s_axi_wvalid[m] && int_s_axi_wready[m] && int_s_axi_wlast[m]);

            if (m_wc_valid && !w_select_valid_reg) begin
                w_select_next = m_wc_select;
                w_drop_next = m_wc_decerr;
                w_select_valid_next = m_wc_valid;
            end
        end

        always @(posedge clk) begin
            if (rst) begin
                w_select_valid_reg <= 1'b0;
            end else begin
                w_select_valid_reg <= w_select_valid_next;
            end

            w_select_reg <= w_select_next;
            w_drop_reg <= w_drop_next;
        end

        // write data forwarding
        // 根据当前master对于事物请求译码的得到的slave选择信号，将当前master事物wvalid信号路由给对应的Slave（master接口）
        assign int_axi_wvalid[m*M_COUNT +: M_COUNT] = (int_s_axi_wvalid[m] && w_select_valid_reg && !w_drop_reg) << w_select_reg;
        assign int_s_axi_wready[m] = int_axi_wready[w_select_reg*S_COUNT+m] || w_drop_reg;

        // decode error handling
        // 当地址解码失败（DECERR） 时（即请求的地址无法匹配任何 Master 接口），
        // AXI 协议要求 Crossbar 必须向发起请求的 Slave 返回错误响应（bresp = DECERR）。
        // 此段代码的作用是 捕获地址解码错误，生成并管理对应的错误响应，确保错误能按协议规范反馈给原始请求的 Slave。
        reg [S_ID_WIDTH-1:0]  decerr_m_axi_bid_reg = {S_ID_WIDTH{1'b0}}, decerr_m_axi_bid_next; //存储错误响应的 Transaction ID（即原始请求的 awid），确保响应与请求的 ID 匹配。
        reg                   decerr_m_axi_bvalid_reg = 1'b0, decerr_m_axi_bvalid_next;
        wire                  decerr_m_axi_bready; // 指示下游是否准备好接收错误响应（来自仲裁逻辑）。

        assign m_rc_ready = !decerr_m_axi_bvalid_reg;

        always @* begin
            decerr_m_axi_bid_next = decerr_m_axi_bid_reg;
            decerr_m_axi_bvalid_next = decerr_m_axi_bvalid_reg;

            if (decerr_m_axi_bvalid_reg) begin
                if (decerr_m_axi_bready) begin
                    decerr_m_axi_bvalid_next = 1'b0;
                end
            // 当地址解码失败（DECERR） 时（即请求的地址无法匹配任何 Master 接口），AXI 协议要求 Crossbar 必须向发起请求的 Slave 返回错误响应（bresp = DECERR）。
            end else if (m_rc_valid && m_rc_ready) begin 
                decerr_m_axi_bid_next = int_s_axi_awid[m*S_ID_WIDTH +: S_ID_WIDTH];  
                decerr_m_axi_bvalid_next = 1'b1;
            end
        end

        always @(posedge clk) begin
            if (rst) begin
                decerr_m_axi_bvalid_reg <= 1'b0;
            end else begin
                decerr_m_axi_bvalid_reg <= decerr_m_axi_bvalid_next;
            end

            decerr_m_axi_bid_reg <= decerr_m_axi_bid_next;
        end

        // write response arbitration
        wire [M_COUNT_P1-1:0] b_request;
        wire [M_COUNT_P1-1:0] b_acknowledge;
        wire [M_COUNT_P1-1:0] b_grant;
        wire b_grant_valid;
        wire [CL_M_COUNT_P1-1:0] b_grant_encoded;

        /*
        仲裁类型：
        轮询仲裁（Round-Robin）：公平分配总线权限，避免某个 Master 长期占用。
        阻塞模式（Blocking）：确保当前授权的响应事务（从 bvalid 到 bready 握手）完成前，仲裁器不切换授权。
        */ 
        arbiter #(
            .PORTS(M_COUNT_P1),          // 端口数 = Master数量 + 1（错误响应）
            .ARB_TYPE_ROUND_ROBIN(1),    // 轮询仲裁
            .ARB_BLOCK(1),               // 阻塞式仲裁（当前事务完成前不切换）
            .ARB_BLOCK_ACK(1),           // 响应接收后释放阻塞
            .ARB_LSB_HIGH_PRIORITY(1)    // 低索引端口优先级高
        )
        b_arb_inst (
            .clk(clk),
            .rst(rst),
            .request(b_request),         // 输入：各端口请求信号
            .acknowledge(b_acknowledge), // 输出：仲裁完成确认
            .grant(b_grant),             // 输出：授权信号（独热码）
            .grant_valid(b_grant_valid), // 输出：授权有效
            .grant_encoded(b_grant_encoded) // 输出：授权端口的索引编码
        );

        /* write response mux
        将 正常 Master 响应 和 解码错误响应 合并为一个宽向量：
        bid：错误响应的 bid 是 decerr_m_axi_bid_reg，正常响应的 bid 来自 int_m_axi_bid。
        bresp：错误响应固定为 2'b11（DECERR），正常响应来自 int_m_axi_bresp。
        根据仲裁结果 b_grant_encoded（授权端口的索引），通过位移操作选择对应的响应字段。
        */
        wire [S_ID_WIDTH-1:0]  m_axi_bid_mux    = {decerr_m_axi_bid_reg, int_m_axi_bid} >> b_grant_encoded*M_ID_WIDTH;
        wire [1:0]             m_axi_bresp_mux  = {2'b11, int_m_axi_bresp} >> b_grant_encoded*2;
        wire [BUSER_WIDTH-1:0] m_axi_buser_mux  = {{BUSER_WIDTH{1'b0}}, int_m_axi_buser} >> b_grant_encoded*BUSER_WIDTH;
        wire                   m_axi_bvalid_mux = ({decerr_m_axi_bvalid_reg, int_m_axi_bvalid} >> b_grant_encoded) & b_grant_valid;
        wire                   m_axi_bready_mux;
        //根据仲裁结果，向对应 Master端口（slave） 的 B 通道发送 bready 信号，表示 Crossbar 已准备好接收响应。
        assign int_axi_bready[m*M_COUNT +: M_COUNT] = (b_grant_valid && m_axi_bready_mux) << b_grant_encoded;
        // 若仲裁选择的是错误响应端口，则触发错误响应的 bready。
        assign decerr_m_axi_bready = (b_grant_valid && m_axi_bready_mux) && (b_grant_encoded == M_COUNT_P1-1);
        
        for (n = 0; n < M_COUNT; n = n + 1) begin
            // 每个 Master 的响应有效（int_axi_bvalid）且未被授权（!b_grant）时，发出请求
            assign b_request[n] = int_axi_bvalid[n*S_COUNT+m] && !b_grant[n];
            // 当授权有效（b_grant）且响应握手完成（bvalid && bready）时，确认仲裁完成
            assign b_acknowledge[n] = b_grant[n] && int_axi_bvalid[n*S_COUNT+m] && m_axi_bready_mux;
        end
        // 考虑到axi crossbar同样作为slave在访问出错时需要返回err信息，因此需要额外一个b通道的返回请求专门用来返回错误
        assign b_request[M_COUNT_P1-1] = decerr_m_axi_bvalid_reg && !b_grant[M_COUNT_P1-1];
        assign b_acknowledge[M_COUNT_P1-1] = b_grant[M_COUNT_P1-1] && decerr_m_axi_bvalid_reg && m_axi_bready_mux;
        // s_cpl_id 和 s_cpl_valid 通知地址解码模块（axi_crossbar_addr）当前事务已完成，释放相关资源（如 Transaction ID 跟踪）
        assign s_cpl_id = m_axi_bid_mux;
        assign s_cpl_valid = m_axi_bvalid_mux && m_axi_bready_mux;

        // S side register
        axi_register_wr #(
            .DATA_WIDTH(DATA_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .STRB_WIDTH(STRB_WIDTH),
            .ID_WIDTH(S_ID_WIDTH),
            .AWUSER_ENABLE(AWUSER_ENABLE),
            .AWUSER_WIDTH(AWUSER_WIDTH),
            .WUSER_ENABLE(WUSER_ENABLE),
            .WUSER_WIDTH(WUSER_WIDTH),
            .BUSER_ENABLE(BUSER_ENABLE),
            .BUSER_WIDTH(BUSER_WIDTH),
            .AW_REG_TYPE(S_AW_REG_TYPE[m*2 +: 2]),
            .W_REG_TYPE(S_W_REG_TYPE[m*2 +: 2]),
            .B_REG_TYPE(S_B_REG_TYPE[m*2 +: 2])
        )
        reg_inst (
            .clk(clk),
            .rst(rst),
            .s_axi_awid(s_axi_awid[m*S_ID_WIDTH +: S_ID_WIDTH]),
            .s_axi_awaddr(s_axi_awaddr[m*ADDR_WIDTH +: ADDR_WIDTH]),
            .s_axi_awlen(s_axi_awlen[m*8 +: 8]),
            .s_axi_awsize(s_axi_awsize[m*3 +: 3]),
            .s_axi_awburst(s_axi_awburst[m*2 +: 2]),
            .s_axi_awlock(s_axi_awlock[m]),
            .s_axi_awcache(s_axi_awcache[m*4 +: 4]),
            .s_axi_awprot(s_axi_awprot[m*3 +: 3]),
            .s_axi_awqos(s_axi_awqos[m*4 +: 4]),
            .s_axi_awregion(4'd0),
            .s_axi_awuser(s_axi_awuser[m*AWUSER_WIDTH +: AWUSER_WIDTH]),
            .s_axi_awvalid(s_axi_awvalid[m]),
            .s_axi_awready(s_axi_awready[m]),
            .s_axi_wdata(s_axi_wdata[m*DATA_WIDTH +: DATA_WIDTH]),
            .s_axi_wstrb(s_axi_wstrb[m*STRB_WIDTH +: STRB_WIDTH]),
            .s_axi_wlast(s_axi_wlast[m]),
            .s_axi_wuser(s_axi_wuser[m*WUSER_WIDTH +: WUSER_WIDTH]),
            .s_axi_wvalid(s_axi_wvalid[m]),
            .s_axi_wready(s_axi_wready[m]),
            .s_axi_bid(s_axi_bid[m*S_ID_WIDTH +: S_ID_WIDTH]),
            .s_axi_bresp(s_axi_bresp[m*2 +: 2]),
            .s_axi_buser(s_axi_buser[m*BUSER_WIDTH +: BUSER_WIDTH]),
            .s_axi_bvalid(s_axi_bvalid[m]),
            .s_axi_bready(s_axi_bready[m]),
            .m_axi_awid(int_s_axi_awid[m*S_ID_WIDTH +: S_ID_WIDTH]),
            .m_axi_awaddr(int_s_axi_awaddr[m*ADDR_WIDTH +: ADDR_WIDTH]),
            .m_axi_awlen(int_s_axi_awlen[m*8 +: 8]),
            .m_axi_awsize(int_s_axi_awsize[m*3 +: 3]),
            .m_axi_awburst(int_s_axi_awburst[m*2 +: 2]),
            .m_axi_awlock(int_s_axi_awlock[m]),
            .m_axi_awcache(int_s_axi_awcache[m*4 +: 4]),
            .m_axi_awprot(int_s_axi_awprot[m*3 +: 3]),
            .m_axi_awqos(int_s_axi_awqos[m*4 +: 4]),
            .m_axi_awregion(),
            .m_axi_awuser(int_s_axi_awuser[m*AWUSER_WIDTH +: AWUSER_WIDTH]),
            .m_axi_awvalid(int_s_axi_awvalid[m]),
            .m_axi_awready(int_s_axi_awready[m]),
            .m_axi_wdata(int_s_axi_wdata[m*DATA_WIDTH +: DATA_WIDTH]),
            .m_axi_wstrb(int_s_axi_wstrb[m*STRB_WIDTH +: STRB_WIDTH]),
            .m_axi_wlast(int_s_axi_wlast[m]),
            .m_axi_wuser(int_s_axi_wuser[m*WUSER_WIDTH +: WUSER_WIDTH]),
            .m_axi_wvalid(int_s_axi_wvalid[m]),
            .m_axi_wready(int_s_axi_wready[m]),
            .m_axi_bid(m_axi_bid_mux),
            .m_axi_bresp(m_axi_bresp_mux),
            .m_axi_buser(m_axi_buser_mux),
            .m_axi_bvalid(m_axi_bvalid_mux),
            .m_axi_bready(m_axi_bready_mux)
        );
    end // s_ifaces
    // 为每个 Master 接口生成逻辑（共 M_COUNT 个）
    for (n = 0; n < M_COUNT; n = n + 1) begin : m_ifaces
        // --- 1. 在途事务计数器（In-flight Transaction Count） ---
        // 跟踪当前 Master 接口未完成的写事务数量
        wire trans_start; // 事务开始信号（地址通道握手成功）
        wire trans_complete; // 事务完成信号（响应通道握手成功）
        reg [$clog2(M_ISSUE[n*32 +: 32]+1)-1:0] trans_count_reg = 0;
        // 判断是否达到事务并发上限
        wire trans_limit = trans_count_reg >= M_ISSUE[n*32 +: 32] && !trans_complete;

        always @(posedge clk) begin
            if (rst) begin
                trans_count_reg <= 0;
            end else begin
                if (trans_start && !trans_complete) begin
                    trans_count_reg <= trans_count_reg + 1;
                end else if (!trans_start && trans_complete) begin
                    trans_count_reg <= trans_count_reg - 1;
                end
            end
        end

        // --- 2. 地址仲裁逻辑（Address Arbitration） ---
        reg [CL_S_COUNT-1:0] w_select_reg = 0, w_select_next; // 当前选中的 Slave 索引
        reg w_select_valid_reg = 1'b0, w_select_valid_next;   // 选择信号是否有效
        reg w_select_new_reg = 1'b0, w_select_new_next;       // 控制数据通道是否需要更新到新的 Slave 选择信号
        // 仲裁器输入：来自所有 Slave 的地址请求
        wire [S_COUNT-1:0] a_request;     // 请求信号（每个 Slave 是否请求当前 Master）
        wire [S_COUNT-1:0] a_acknowledge; // 确认信号（仲裁完成）
        wire [S_COUNT-1:0] a_grant;       // 授权信号（独热码）
        wire a_grant_valid;               // 授权有效标志
        wire [CL_S_COUNT-1:0] a_grant_encoded; // 授权的 Slave 索引（二进制编码）

        arbiter #(
            .PORTS(S_COUNT), // 端口数 = Slave数量 
            .ARB_TYPE_ROUND_ROBIN(1),
            .ARB_BLOCK(1),
            .ARB_BLOCK_ACK(1),
            .ARB_LSB_HIGH_PRIORITY(1)
        )
        a_arb_inst (
            .clk(clk),
            .rst(rst),
            .request(a_request),
            .acknowledge(a_acknowledge),
            .grant(a_grant),
            .grant_valid(a_grant_valid),
            .grant_encoded(a_grant_encoded)
        );

        // --- 3. 地址通道多路复用（Address Mux） ---
        // 将选中的 Slave 地址信号路由到当前 Master 的输出
        wire [M_ID_WIDTH-1:0]   s_axi_awid_mux     = int_s_axi_awid[a_grant_encoded*S_ID_WIDTH +: S_ID_WIDTH] | (a_grant_encoded << S_ID_WIDTH);
        // 拼接 ID：原始 Slave ID + Slave 索引（避免 ID 冲突）
        wire [ADDR_WIDTH-1:0]   s_axi_awaddr_mux   = int_s_axi_awaddr[a_grant_encoded*ADDR_WIDTH +: ADDR_WIDTH]; // 地址
        wire [7:0]              s_axi_awlen_mux    = int_s_axi_awlen[a_grant_encoded*8 +: 8];     // 突发长度
        wire [2:0]              s_axi_awsize_mux   = int_s_axi_awsize[a_grant_encoded*3 +: 3];    // 数据宽度
        wire [1:0]              s_axi_awburst_mux  = int_s_axi_awburst[a_grant_encoded*2 +: 2];   // 突发类型
        wire                    s_axi_awlock_mux   = int_s_axi_awlock[a_grant_encoded];           // 锁定类型
        wire [3:0]              s_axi_awcache_mux  = int_s_axi_awcache[a_grant_encoded*4 +: 4];  // 缓存类型
        wire [2:0]              s_axi_awprot_mux   = int_s_axi_awprot[a_grant_encoded*3 +: 3];   // 保护类型
        wire [3:0]              s_axi_awqos_mux    = int_s_axi_awqos[a_grant_encoded*4 +: 4];    // QoS
        wire [3:0]              s_axi_awregion_mux = int_s_axi_awregion[a_grant_encoded*4 +: 4]; // 区域
        wire [AWUSER_WIDTH-1:0] s_axi_awuser_mux   = int_s_axi_awuser[a_grant_encoded*AWUSER_WIDTH +: AWUSER_WIDTH]; // 用户信号
        wire                    s_axi_awvalid_mux  = int_axi_awvalid[a_grant_encoded*M_COUNT+n] && a_grant_valid; // 有效信号
        wire                    s_axi_awready_mux; // Master 的 awready 输入

        // 将仲裁结果转换为 awready 信号反馈给对应 Slave
        assign int_axi_awready[n*S_COUNT +: S_COUNT] = (a_grant_valid && s_axi_awready_mux) << a_grant_encoded;

        for (m = 0; m < S_COUNT; m = m + 1) begin
            // 生成每个 Slave 的请求信号：需满足三个条件
            // 1. 该 Slave 有地址请求到当前 Master
            // 2. 未达到事务并发上限（!trans_limit）
            // 3. 数据通道未占用（!w_select_valid_next）
            assign a_request[m] = int_axi_awvalid[m*M_COUNT+n] && !a_grant[m] && !trans_limit && !w_select_valid_next;
            // 当授权有效（a_grant）且地址握手完成（awvalid && awready）时，确认仲裁完成
            assign a_acknowledge[m] = a_grant[m] && int_axi_awvalid[m*M_COUNT+n] && s_axi_awready_mux;
        end
        // 事务开始：地址通道握手成功且仲裁有效
        assign trans_start = s_axi_awvalid_mux && s_axi_awready_mux && a_grant_valid;

        // --- 4. 数据通道多路复用（Write Data Mux） ---
        // 根据 w_select_reg 选择对应 Slave 的数据信号
        wire [DATA_WIDTH-1:0]  s_axi_wdata_mux   = int_s_axi_wdata[w_select_reg*DATA_WIDTH +: DATA_WIDTH];
        wire [STRB_WIDTH-1:0]  s_axi_wstrb_mux   = int_s_axi_wstrb[w_select_reg*STRB_WIDTH +: STRB_WIDTH];
        wire                   s_axi_wlast_mux   = int_s_axi_wlast[w_select_reg];
        wire [WUSER_WIDTH-1:0] s_axi_wuser_mux   = int_s_axi_wuser[w_select_reg*WUSER_WIDTH +: WUSER_WIDTH];
        wire                   s_axi_wvalid_mux  = int_axi_wvalid[w_select_reg*M_COUNT+n] && w_select_valid_reg;
        wire                   s_axi_wready_mux;
        // 将数据通道的 ready 信号路由回对应 Slave
        assign int_axi_wready[n*S_COUNT +: S_COUNT] = (w_select_valid_reg && s_axi_wready_mux) << w_select_reg;

        // --- 5. 数据通道路由逻辑（Write Data Routing） ---
        // 更新数据通道的选择信号（w_select_reg）
        always @* begin
            w_select_next = w_select_reg;
            // 如果当前Slave的W数据通道有效，且当前W数据通道握手成功，且当前 Slave 的数据通道是最后一个数据，表示当前W数据通道完成传输可以关闭
            w_select_valid_next = w_select_valid_reg && !(s_axi_wvalid_mux && s_axi_wready_mux && s_axi_wlast_mux);
            // 后续的每次仲裁都是新的选择
            w_select_new_next = w_select_new_reg || !a_grant_valid || a_acknowledge;

            // 当有新地址被仲裁且数据通道空闲时，更新选择信号
            if (a_grant_valid && !w_select_valid_reg && w_select_new_reg) begin
                w_select_next = a_grant_encoded;    // 选择仲裁的 Slave
                w_select_valid_next = a_grant_valid; // 标记有效
                w_select_new_next = 1'b0;          // 清除新选择标志
            end
        end

        always @(posedge clk) begin
            if (rst) begin
                w_select_valid_reg <= 1'b0;
                w_select_new_reg <= 1'b1; //初始化为 1，允许首次仲裁后立即应用新选择。
            end else begin
                w_select_valid_reg <= w_select_valid_next;
                w_select_new_reg <= w_select_new_next;
            end

            w_select_reg <= w_select_next; // 更新选择的 Slave 索引
        end

        // --- 6. 写响应转发（Write Response Forwarding） ---
        // 从 Master 的 bid 中提取原始 Slave 索引（高 S_ID_WIDTH 位）
        wire [CL_S_COUNT-1:0] b_select = m_axi_bid[n*M_ID_WIDTH +: M_ID_WIDTH] >> S_ID_WIDTH;
        // 将响应路由回对应的 Slave
        assign int_axi_bvalid[n*S_COUNT +: S_COUNT] = int_m_axi_bvalid[n] << b_select;
        assign int_m_axi_bready[n] = int_axi_bready[b_select*M_COUNT+n];
        // 事务完成：响应通道握手成功
        assign trans_complete = int_m_axi_bvalid[n] && int_m_axi_bready[n];

        // M side register
        axi_register_wr #(
            .DATA_WIDTH(DATA_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .STRB_WIDTH(STRB_WIDTH),
            .ID_WIDTH(M_ID_WIDTH),
            .AWUSER_ENABLE(AWUSER_ENABLE),
            .AWUSER_WIDTH(AWUSER_WIDTH),
            .WUSER_ENABLE(WUSER_ENABLE),
            .WUSER_WIDTH(WUSER_WIDTH),
            .BUSER_ENABLE(BUSER_ENABLE),
            .BUSER_WIDTH(BUSER_WIDTH),
            .AW_REG_TYPE(M_AW_REG_TYPE[n*2 +: 2]),
            .W_REG_TYPE(M_W_REG_TYPE[n*2 +: 2]),
            .B_REG_TYPE(M_B_REG_TYPE[n*2 +: 2])
        )
        reg_inst (
            .clk(clk),
            .rst(rst),
            .s_axi_awid(s_axi_awid_mux),
            .s_axi_awaddr(s_axi_awaddr_mux),
            .s_axi_awlen(s_axi_awlen_mux),
            .s_axi_awsize(s_axi_awsize_mux),
            .s_axi_awburst(s_axi_awburst_mux),
            .s_axi_awlock(s_axi_awlock_mux),
            .s_axi_awcache(s_axi_awcache_mux),
            .s_axi_awprot(s_axi_awprot_mux),
            .s_axi_awqos(s_axi_awqos_mux),
            .s_axi_awregion(s_axi_awregion_mux),
            .s_axi_awuser(s_axi_awuser_mux),
            .s_axi_awvalid(s_axi_awvalid_mux),
            .s_axi_awready(s_axi_awready_mux),
            .s_axi_wdata(s_axi_wdata_mux),
            .s_axi_wstrb(s_axi_wstrb_mux),
            .s_axi_wlast(s_axi_wlast_mux),
            .s_axi_wuser(s_axi_wuser_mux),
            .s_axi_wvalid(s_axi_wvalid_mux),
            .s_axi_wready(s_axi_wready_mux),
            .s_axi_bid(int_m_axi_bid[n*M_ID_WIDTH +: M_ID_WIDTH]),
            .s_axi_bresp(int_m_axi_bresp[n*2 +: 2]),
            .s_axi_buser(int_m_axi_buser[n*BUSER_WIDTH +: BUSER_WIDTH]),
            .s_axi_bvalid(int_m_axi_bvalid[n]),
            .s_axi_bready(int_m_axi_bready[n]),
            .m_axi_awid(m_axi_awid[n*M_ID_WIDTH +: M_ID_WIDTH]),
            .m_axi_awaddr(m_axi_awaddr[n*ADDR_WIDTH +: ADDR_WIDTH]),
            .m_axi_awlen(m_axi_awlen[n*8 +: 8]),
            .m_axi_awsize(m_axi_awsize[n*3 +: 3]),
            .m_axi_awburst(m_axi_awburst[n*2 +: 2]),
            .m_axi_awlock(m_axi_awlock[n]),
            .m_axi_awcache(m_axi_awcache[n*4 +: 4]),
            .m_axi_awprot(m_axi_awprot[n*3 +: 3]),
            .m_axi_awqos(m_axi_awqos[n*4 +: 4]),
            .m_axi_awregion(m_axi_awregion[n*4 +: 4]),
            .m_axi_awuser(m_axi_awuser[n*AWUSER_WIDTH +: AWUSER_WIDTH]),
            .m_axi_awvalid(m_axi_awvalid[n]),
            .m_axi_awready(m_axi_awready[n]),
            .m_axi_wdata(m_axi_wdata[n*DATA_WIDTH +: DATA_WIDTH]),
            .m_axi_wstrb(m_axi_wstrb[n*STRB_WIDTH +: STRB_WIDTH]),
            .m_axi_wlast(m_axi_wlast[n]),
            .m_axi_wuser(m_axi_wuser[n*WUSER_WIDTH +: WUSER_WIDTH]),
            .m_axi_wvalid(m_axi_wvalid[n]),
            .m_axi_wready(m_axi_wready[n]),
            .m_axi_bid(m_axi_bid[n*M_ID_WIDTH +: M_ID_WIDTH]),
            .m_axi_bresp(m_axi_bresp[n*2 +: 2]),
            .m_axi_buser(m_axi_buser[n*BUSER_WIDTH +: BUSER_WIDTH]),
            .m_axi_bvalid(m_axi_bvalid[n]),
            .m_axi_bready(m_axi_bready[n])
        );
    end // m_ifaces

endgenerate

endmodule

`resetall

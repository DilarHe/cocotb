module skid_buf #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32 
)(
input logic  clk ,
input logic  rst_n,

input   logic  s_valid_i,
output  logic  s_ready_o,
input   logic [DATA_WIDTH-1:0] s_addr_i,
input   logic [DATA_WIDTH-1:0] s_data_i,

output  logic m_valid_o,
input   logic m_ready_i,
output  logic [DATA_WIDTH-1:0] m_addr_o,
output  logic [DATA_WIDTH-1:0] m_data_o
);

logic skid_buf_valid;
logic [ADDR_WIDTH-1:0] skid_buf_addr;
logic [DATA_WIDTH-1:0] skid_buf_data;

logic s_handshake_suc;
logic m_handshake_suc;
logic pipedown_valid;

assign s_handshake_suc = s_valid_i && s_ready_o;
assign m_handshake_suc = m_valid_o && m_ready_i;
assign pipedown_valid = m_handshake_suc || 
                        !m_valid_o;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        skid_buf_addr <= '0;
        skid_buf_data <= '0;
    end
    else if(s_handshake_suc & !pipedown_valid)begin
        skid_buf_addr <= s_addr_i;
        skid_buf_data <= s_data_i;
    end
end
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        skid_buf_valid <= '0;
    end
    else if(!pipedown_valid & s_handshake_suc)begin
        skid_buf_valid <= 1'b1 ;
    end
    else if(pipedown_valid) begin
        skid_buf_valid <= '0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        s_ready_o <= '1;
    end
    else begin
        s_ready_o <= pipedown_valid;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        m_valid_o <= 1'b0;
        m_addr_o <= '0;
        m_data_o <= '0;
    end
    else begin
        if(pipedown_valid) begin
            m_valid_o <= skid_buf_valid | s_valid_i;
            m_addr_o <= skid_buf_valid? skid_buf_addr : s_addr_i;
            m_data_o <= skid_buf_valid? skid_buf_data : s_data_i;
        end
    end
end

endmodule
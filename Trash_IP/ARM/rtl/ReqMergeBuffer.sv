//--------------------------------------------------------------
//  Module Name   : ReqMergeBuffer
//  Author        : zhangyiyao
//  Version       : v1.0
//  Date          : 2025-07-02
//  Description   :  
//--------------------------------------------------------------
module ReqMergeBuffer #(
    parameter ENTRY_NUM = 32,
    parameter PORT_NUM  = 4
)(
    input  logic              clk,
    input  logic              rst_n,

    // 上游接口
    input  logic [PORT_NUM-1:0]          req_in_valid,
    input  logic [PORT_NUM-1:0][31:0]    req_in_addr,
    output logic [PORT_NUM-1:0]          req_out_ack,
    output logic [PORT_NUM-1:0][4:0]     req_out_entry, // 5 bits for 32 entries

    // 下游接口
    output logic                        request_out_valid,
    output logic [31:0]                 request_out_addr,
    input  logic                        response_in_valid,
    input  logic [4:0]                  release_entry, // 下游返回释放的entry号
    input  logic                        release_valid
);
    localparam int REF_CNT_MAX = (1 << 6); 
    // Buffer条目定义
    typedef struct packed {
        logic         valid;
        logic [31:0]  addr;
        logic [5:0]   ref_cnt; // 最多支持64路同一地址请求
    } buffer_entry_t;

    buffer_entry_t   buffer [ENTRY_NUM];

    logic [ENTRY_NUM-1:0] entry_free_vec ;  

    // logic entry_full; 
    // logic entry_empty;

    // assign entry_empty = &entry_free_vec; 
    // assign entry_full = ~(|entry_free_vec);
    always_comb begin
        for (int i = 0; i < ENTRY_NUM; i++) begin
            entry_free_vec[i] = !buffer[i].valid;
        end
    end

    // alloc
    logic [PORT_NUM-1:0]       req_in_valid_merge;         // merge后的新valid
    logic [PORT_NUM-1:0][31:0] req_in_addr_merge;    // merge后的新addr
    logic [PORT_NUM-1:0][3:0]  req_in_merge_cnt;      // 本组有多少端口被合并
    logic [PORT_NUM-1:0]       is_merged;
    logic [PORT_NUM-1:0][3:0]  merge_to;   // merge_to[p]=q, port p被merge到q

    logic [ENTRY_NUM-1:0]      free_mask; // 当前可用空entry的mask
    logic [ENTRY_NUM-1:0]      entry_alloc_oh_vec [PORT_NUM-1:0];  
    logic [ENTRY_NUM-1:0]      entry_alloc_oh ;  
    logic [31:0]               entry_alloc_addr [ENTRY_NUM-1:0];  
    logic [5:0]                entry_alloc_refcnt [ENTRY_NUM-1:0];  
    logic [PORT_NUM-1:0]       entry_alloc_ack; 
    logic [PORT_NUM-1:0][4:0]  entry_alloc_idx; 

    // merge
    // 查找命中
    logic [ENTRY_NUM-1:0] hit_vec   [PORT_NUM-1:0]; 
    logic [ENTRY_NUM-1:0] entry_merge_oh_vec [PORT_NUM-1:0];  
    logic [ENTRY_NUM-1:0] entry_merge_oh ;  
    logic [PORT_NUM-1:0]  entry_merge_ack ;  
    logic [ENTRY_NUM-1:0][PORT_NUM-1:0] merge_plan;   // [entry][port]，是否merge
    logic [ENTRY_NUM-1:0][PORT_NUM:0]   merge_cumu;   // 记录到每个port前累计merge数
    logic [ENTRY_NUM-1:0][6:0] merge_cnt_per_entry; // 每个entry的merge计数
    logic [PORT_NUM-1:0][4:0]  entry_merge_idx; 

    // release
    logic [ENTRY_NUM-1:0] release_oh;
    // req ack 
    always_comb begin
        for (int p = 0; p < PORT_NUM; p++) begin
            req_out_ack[p]   = entry_alloc_ack[merge_to[p]] | entry_merge_ack[p];
            if (entry_merge_ack[p]) begin
                req_out_entry[p] = entry_merge_idx[p];
            end else if (entry_alloc_ack[merge_to[p]]) begin
                req_out_entry[p] = entry_alloc_idx[merge_to[p]];
            end else begin
                req_out_entry[p] = 5'd0;  
            end
        end
    end
    // alloc
    always_comb begin : alloc_merge_gen
        req_in_valid_merge = req_in_valid;
        req_in_addr_merge  = req_in_addr;
        for (int p = 0; p < PORT_NUM; p++) begin
            req_in_merge_cnt[p] = req_in_valid[p] ? 1 : 0;  
            is_merged[p] = 1'b0;
            merge_to[p] = p; // 默认自己归自己
            if (req_in_valid[p]) begin
                // 扫描p之前的端口，有相同地址则本端口被merge
                for (int q = 0; q < p; q++) begin
                    if (req_in_addr[q] == req_in_addr[p]) begin
                        req_in_valid_merge[p] = 1'b0; // 本端口被merge
                        is_merged[p] = 1'b1;
                        merge_to[p] = q;
                        break;   // <<<<<< 只记录第一个命中者
                    end
                end
                // 统计p之后有多少个被merge到本端口
                if (!is_merged[p]) begin
                    for (int q = p+1; q < PORT_NUM; q++) begin
                        if (req_in_addr[q] == req_in_addr[p]) begin
                            req_in_merge_cnt[p] += 1;
                        end
                    end
                end
            end
        end
    end
    always_comb begin : alloc_gen
        free_mask = entry_free_vec;
        for (int e = 0; e < ENTRY_NUM; e++)begin
            entry_alloc_addr[e] = 32'd0; // 默认 
            entry_alloc_refcnt[e] = 6'd0; // 默认 
        end
        for (int p = 0; p < PORT_NUM; p++) begin
            entry_alloc_ack[p] = 1'b0;
            entry_alloc_oh_vec[p] = '0;
            entry_alloc_idx[p] = '0;
            if (req_in_valid_merge[p]&!entry_merge_ack[p]) begin // findfirst
                for (int e = 0; e < ENTRY_NUM; e++) begin
                    if (free_mask[e]) begin
                        entry_alloc_oh_vec[p][e] = 1'b1;
                        free_mask[e] = 1'b0; // 标记该entry已分配，后面port不能再用
                        entry_alloc_ack[p] = 1'b1; // 分配成功
                        entry_alloc_addr[e] = req_in_addr_merge[p];// 记录该entry的分配地址
                        entry_alloc_refcnt[e] = req_in_merge_cnt[p]; // 初始port merge 的refcnt
                        entry_alloc_idx[p] = e[4:0]; // 记录index
                        break;
                    end
                end
                // 若没找到空entry，则entry_alloc_oh_vec[p]='0，ack=0
            end
            // 若req_in_valid[p]==0，则entry_alloc_oh_vec[p]='0, ack=0
        end
        // 最后统一归约
        entry_alloc_oh = '0;
        for (int p = 0; p < PORT_NUM; p++) begin
            entry_alloc_oh = entry_alloc_oh | entry_alloc_oh_vec[p];
        end
    end
    // merge  
    always_comb begin : hit_box_gen
        for (int p = 0; p < PORT_NUM; p++) begin
            for (int e = 0; e < ENTRY_NUM; e++) begin
                hit_vec[p][e] = buffer[e].valid && (buffer[e].addr == req_in_addr[p]);
            end
        end
    end
    always_comb begin
        for (int e = 0; e < ENTRY_NUM; e++) begin
            merge_cumu[e][0] = 0;
            merge_cnt_per_entry[e] = '0;
            for (int p = 0; p < PORT_NUM; p++) begin
                merge_plan[e][p] = 1'b0;
                merge_cnt_per_entry[e] += merge_plan[e][p];
                if (hit_vec[p][e] && (buffer[e].ref_cnt + merge_cumu[e][p] < REF_CNT_MAX)) begin
                    merge_plan[e][p] = 1'b1;
                    merge_cumu[e][p+1] = merge_cumu[e][p] + 1;
                end else begin
                    merge_plan[e][p] = 1'b0;
                    merge_cumu[e][p+1] = merge_cumu[e][p];
                end
            end
        end
    end
    always_comb begin
        for (int p = 0; p < PORT_NUM; p++) begin
            entry_merge_ack[p] = 1'b0;
            entry_merge_oh_vec[p] = '0;
            entry_merge_idx[p] = '0; // 或 {5{1'b0}}
            for (int e = 0; e < ENTRY_NUM; e++) begin
                if (merge_plan[e][p]) begin
                    entry_merge_ack[p] = 1'b1;
                    entry_merge_oh_vec[p][e] = 1'b1;
                    entry_merge_idx[p] = e[4:0];
                end
            end
        end
        // 最后统一归约
        entry_merge_oh = '0;
        for (int p = 0; p < PORT_NUM; p++) begin
            entry_merge_oh = entry_merge_oh | entry_merge_oh_vec[p];
        end
    end
    // release
    always_comb begin : release_gen
        release_oh = '0;
        for (int e = 0; e < ENTRY_NUM; e++) begin
            if (buffer[e].valid && (release_entry == e) && release_valid) begin
                release_oh[e] = 1'b1;
            end
        end
    end
    // buffer entry update
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < ENTRY_NUM; i++) begin
                buffer[i].valid   <= 1'b0;
                buffer[i].addr    <= 32'd0;
                buffer[i].ref_cnt <= 6'd0;
            end
        end else begin
            for (int i = 0; i < ENTRY_NUM; i++) begin
                // 1. merge
                if (entry_merge_oh[i]) begin
                    buffer[i].ref_cnt <= buffer[i].ref_cnt + merge_cnt_per_entry[i] - release_oh[i];
                end
                // 2. alloc
                else if (entry_alloc_oh[i]) begin
                    buffer[i].valid   <= 1'b1;
                    buffer[i].addr    <= entry_alloc_addr[i] ; // port的地址
                    buffer[i].ref_cnt <= 1;              // 新分配，引用计数=1
                end
                // 3. release
                else if (release_oh[i]) begin
                    buffer[i].valid   <= (buffer[i].ref_cnt-1) != 0; // 释放该entry
                    buffer[i].ref_cnt <= buffer[i].ref_cnt - 1 ;  
                end
            end
        end
    end
endmodule

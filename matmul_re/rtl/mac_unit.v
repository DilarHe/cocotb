// Generator : SpinalHDL v1.10.0    git head : 270018552577f3bb8e5339ee2583c9c22d324215
// Component : mac_unit
// Git hash  : 804e9ff7f14f39e9c4c181de48958a35325991e0

`timescale 1ns/1ps 
module mac_unit (
  input  wire          clka,
  input  wire          rstn_a,
  input  wire          valid,
  input  wire [7:0]    A_0,
  input  wire [7:0]    A_1,
  input  wire [7:0]    A_2,
  input  wire [7:0]    A_3,
  input  wire [7:0]    A_4,
  input  wire [7:0]    A_5,
  input  wire [7:0]    A_6,
  input  wire [7:0]    A_7,
  input  wire [7:0]    B_0,
  input  wire [7:0]    B_1,
  input  wire [7:0]    B_2,
  input  wire [7:0]    B_3,
  input  wire [7:0]    B_4,
  input  wire [7:0]    B_5,
  input  wire [7:0]    B_6,
  input  wire [7:0]    B_7,
  input  wire [19:0]   psum_in,
  output wire [19:0]   psum_out,
  output wire          psum_acc_valid,
  input  wire          clk,
  input  wire          resetn
);

  wire       [7:0]    tmp_product_0;
  wire       [7:0]    tmp_product_0_1;
  wire       [7:0]    tmp_product_1;
  wire       [7:0]    tmp_product_1_1;
  wire       [7:0]    tmp_product_2;
  wire       [7:0]    tmp_product_2_1;
  wire       [7:0]    tmp_product_3;
  wire       [7:0]    tmp_product_3_1;
  wire       [7:0]    tmp_product_4;
  wire       [7:0]    tmp_product_4_1;
  wire       [7:0]    tmp_product_5;
  wire       [7:0]    tmp_product_5_1;
  wire       [7:0]    tmp_product_6;
  wire       [7:0]    tmp_product_6_1;
  wire       [7:0]    tmp_product_7;
  wire       [7:0]    tmp_product_7_1;
  wire       [16:0]   tmp_tmp_sum;
  wire       [16:0]   tmp_tmp_sum_1;
  wire       [16:0]   tmp_tmp_sum_1_1;
  wire       [16:0]   tmp_tmp_sum_1_2;
  wire       [16:0]   tmp_tmp_sum_2;
  wire       [16:0]   tmp_tmp_sum_2_1;
  wire       [16:0]   tmp_tmp_sum_3;
  wire       [16:0]   tmp_tmp_sum_3_1;
  wire       [17:0]   tmp_tmp_sum_4;
  wire       [17:0]   tmp_tmp_sum_4_1;
  wire       [17:0]   tmp_tmp_sum_5;
  wire       [17:0]   tmp_tmp_sum_5_1;
  wire       [18:0]   tmp_sum_6;
  wire       [18:0]   tmp_sum_7;
  wire       [18:0]   tmp_sum_8;
  wire       [19:0]   tmp_psum_out;
  wire       [19:0]   tmp_psum_out_1;
  reg        [15:0]   product_0;
  reg        [15:0]   product_1;
  reg        [15:0]   product_2;
  reg        [15:0]   product_3;
  reg        [15:0]   product_4;
  reg        [15:0]   product_5;
  reg        [15:0]   product_6;
  reg        [15:0]   product_7;
  reg        [19:0]   sum;
  wire       [16:0]   tmp_sum;
  wire       [16:0]   tmp_sum_1;
  wire       [16:0]   tmp_sum_2;
  wire       [16:0]   tmp_sum_3;
  wire       [17:0]   tmp_sum_4;
  wire       [17:0]   tmp_sum_5;
  reg                 stage1_valid;

  assign tmp_product_0 = A_0;
  assign tmp_product_0_1 = B_0;
  assign tmp_product_1 = A_1;
  assign tmp_product_1_1 = B_1;
  assign tmp_product_2 = A_2;
  assign tmp_product_2_1 = B_2;
  assign tmp_product_3 = A_3;
  assign tmp_product_3_1 = B_3;
  assign tmp_product_4 = A_4;
  assign tmp_product_4_1 = B_4;
  assign tmp_product_5 = A_5;
  assign tmp_product_5_1 = B_5;
  assign tmp_product_6 = A_6;
  assign tmp_product_6_1 = B_6;
  assign tmp_product_7 = A_7;
  assign tmp_product_7_1 = B_7;
  assign tmp_tmp_sum = {product_0[15],product_0};
  assign tmp_tmp_sum_1 = {product_1[15],product_1};
  assign tmp_tmp_sum_1_1 = {product_2[15],product_2};
  assign tmp_tmp_sum_1_2 = {product_3[15],product_3};
  assign tmp_tmp_sum_2 = {product_4[15],product_4};
  assign tmp_tmp_sum_2_1 = {product_5[15],product_5};
  assign tmp_tmp_sum_3 = {product_6[15],product_6};
  assign tmp_tmp_sum_3_1 = {product_7[15],product_7};
  assign tmp_tmp_sum_4 = {tmp_sum[16],tmp_sum};
  assign tmp_tmp_sum_4_1 = {tmp_sum_1[16],tmp_sum_1};
  assign tmp_tmp_sum_5 = {tmp_sum_2[16],tmp_sum_2};
  assign tmp_tmp_sum_5_1 = {tmp_sum_3[16],tmp_sum_3};
  assign tmp_sum_6 = ($signed(tmp_sum_7) + $signed(tmp_sum_8));
  assign tmp_sum_7 = {tmp_sum_4[17],tmp_sum_4};
  assign tmp_sum_8 = {tmp_sum_5[17],tmp_sum_5};
  assign tmp_psum_out = ($signed(sum) + $signed(tmp_psum_out_1));
  assign tmp_psum_out_1 = psum_in;
  always @(*) begin
    product_0 = 16'h0000;
    if(valid) begin
      product_0 = ($signed(tmp_product_0) * $signed(tmp_product_0_1));
    end
  end

  always @(*) begin
    product_1 = 16'h0000;
    if(valid) begin
      product_1 = ($signed(tmp_product_1) * $signed(tmp_product_1_1));
    end
  end

  always @(*) begin
    product_2 = 16'h0000;
    if(valid) begin
      product_2 = ($signed(tmp_product_2) * $signed(tmp_product_2_1));
    end
  end

  always @(*) begin
    product_3 = 16'h0000;
    if(valid) begin
      product_3 = ($signed(tmp_product_3) * $signed(tmp_product_3_1));
    end
  end

  always @(*) begin
    product_4 = 16'h0000;
    if(valid) begin
      product_4 = ($signed(tmp_product_4) * $signed(tmp_product_4_1));
    end
  end

  always @(*) begin
    product_5 = 16'h0000;
    if(valid) begin
      product_5 = ($signed(tmp_product_5) * $signed(tmp_product_5_1));
    end
  end

  always @(*) begin
    product_6 = 16'h0000;
    if(valid) begin
      product_6 = ($signed(tmp_product_6) * $signed(tmp_product_6_1));
    end
  end

  always @(*) begin
    product_7 = 16'h0000;
    if(valid) begin
      product_7 = ($signed(tmp_product_7) * $signed(tmp_product_7_1));
    end
  end

  assign tmp_sum = ($signed(tmp_tmp_sum) + $signed(tmp_tmp_sum_1));
  assign tmp_sum_1 = ($signed(tmp_tmp_sum_1_1) + $signed(tmp_tmp_sum_1_2));
  assign tmp_sum_2 = ($signed(tmp_tmp_sum_2) + $signed(tmp_tmp_sum_2_1));
  assign tmp_sum_3 = ($signed(tmp_tmp_sum_3) + $signed(tmp_tmp_sum_3_1));
  assign tmp_sum_4 = ($signed(tmp_tmp_sum_4) + $signed(tmp_tmp_sum_4_1));
  assign tmp_sum_5 = ($signed(tmp_tmp_sum_5) + $signed(tmp_tmp_sum_5_1));
  assign psum_out = tmp_psum_out;
  assign psum_acc_valid = stage1_valid;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      sum <= 20'h00000;
      stage1_valid <= 1'b0;
    end else begin
      if(valid) begin
        sum <= {{1{tmp_sum_6[18]}}, tmp_sum_6};
      end
      stage1_valid <= valid;
    end
  end


endmodule

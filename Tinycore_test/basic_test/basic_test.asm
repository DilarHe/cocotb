// **********************************************************
//  partial conv function
// **********************************************************
.CONV1
    lw x4, __CONV1._filter_p(x2)                         // load weight pointer

.C1LOADBIAS
    lw x6, __CONV1._bias_p(x2)  // *** load bias
    lv v8, 0(x6)
    addi x6,x6,1
    lv v12, 0(x6)
    addi x6,x6,1
    lv v16, 0(x6)
    addi x6,x6,1
    lv v20, 0(x6)
    addi x6,x6,1
    sw x6, __CONV1._bias_p(x2)

    lw x3, __CONV1._ifmap_p(x2)                          // load ifmap pointer
    lw x5, __CONV1._inner_cnt(x2)                        // load innerloop cnt
.INNERLOOP
    addi4spn x6,16  // ***layer-1 conv 1*n       // out channel loop num
    addi4spn x7,16                               // psum index (from x16 to x31)
    lv v0, 0(x3)                                 // load act line
    addi x3,x3,1
.MULSUM16
    lv v4, 0(x4)
    addi x4,x4,1                                 // load weight step = 1, because each mem line contains 16 elements
    vmulsum x7,x7,v0
    addi x7,x7,1
    addi x6,x6,-1
    bnez x6, .MULSUM16
    nop
    addi x5,x5,-1
    bnez x5, .INNERLOOP
    nop
.CQUANT16
    lw x6, __CONV1._quant_p(x2)   // *** quantize
    lv v0, 0(x6)                                 // x8 = zero_point; x9 = scale(int32); x10 = shift
    addi4spn x6,16                               // out activate and quant loop
    addi4spn x5,16                               // out activate and quant loop
.C1RELU
    mv x7, x10
    fmsr  x6,x6,x9
    addi4spn x7,`KWS_MAX_VAL
    addx  x6,x6,x8
    min   x6,x6,x7
    addi4spn x7,`KWS_MIN_VAL
    max   x6,x6,x7
    addi  x6,x6,1
    addi  x5,x5,-1
    bnez  x5,.C1RELU
.C1STORE16
    lw x5, __CONV1._ofmap_p(x2)  // *** store                   // ofmap_wr_pointer
    sv1 x0, 0(x5)
    addi x5,x5,1
    sw x5, __CONV1._ofmap_p(x2)                                 // ofmap_wr_pointer update
.C1CHECKOUTLOOP    
    lw x5, __CONV1._outer_cnt(x2) // *** check out loop cnt      // outchannel / 16
    addi x5,x5,-1
    bnez x5, 2
    jr x1
    sw x5, __CONV1._outer_cnt(x2)
    j .C1LOADBIAS

// **********************************************************
//  Depthwise partial conv function
// **********************************************************
.DEPTHWISE_CONV_FUN
    lw x3, __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)                          // load ifmap pointer
    lw x4, __DEPTHWISE_CONV_FUN._filter_start_p(x2)                         // load weight pointer
.DW_LOADBIAS
    lw x6, __DEPTHWISE_CONV_FUN._bias_p(x2)  // *** load bias
    lv v8, 0(x6)
    addi x6,x6,1
    lv v12, 0(x6)
    addi x6,x6,1
    lv v16, 0(x6)
    addi x6,x6,1
    lv v20, 0(x6)
    addi x6,x6,1
    sw x6, __DEPTHWISE_CONV_FUN._bias_p(x2)

    lw x5, __DEPTHWISE_CONV_FUN._conv_width(x2)                             // load innerloop cnt
.DWINNERLOOP
    lv   v0, 0(x3)                                 // load act line
    mv   x7,x3
    lw   x6, __DEPTHWISE_CONV_FUN._fmap_fifo_end_p(x2)                          // load ifmap end bound
    sub  x7,x7,x6
    beqz x7, .DWIFMAP_RETURN_START
    addi x3,x3,3                                 // ochannel=48, 所以每次act地址递增3
    j .DW_LOAD_WEIGHT
.DWIFMAP_RETURN_START
    lw x3, __DEPTHWISE_CONV_FUN._fmap_fifo_start_p(x2)                          // load ifmap fifo start pointer
.DW_LOAD_WEIGHT
    lv v4, 0(x4)                                 // load filter line
    addi x4,x4,3                                 // load weight step = 3, because each mem line contains 16 elements, ochannel=48, 所以每次filter地址递增3
    addi4spn x7,16                               // psum index (from x16 to x31) //注意，vmac8的操作数不支持前递，所以x7的值需要提前vmac一拍
    addi4spn x6,16                               // out channel loop num
.DWMACC8
    vmac8 x7,x7,x7
    addi x7,x7,1
    addi x6,x6,-1
    bnez x6, .DWMACC8
    nop
    addi x5,x5,-1
    bnez x5, .DWINNERLOOP
    nop
.DW_QUANT16
    lw x6, __DEPTHWISE_CONV_FUN._quant_p(x2)   // *** quantize
    lv v0, 0(x6)                                 // x8 = zero_point; x9 = scale(int32); x10 = shift
    addi4spn x6,16                               // out activate and quant loop
    addi4spn x5,16                               // out activate and quant loop
.DW_RELU
    mv x7, x10                                   // prepare quant shift to x7
    fmsr  x6,x6,x9
    addi4spn x7,`KWS_MAX_VAL
    addx  x6,x6,x8
    min   x6,x6,x7
    addi4spn x7,`KWS_MIN_VAL
    max   x6,x6,x7
    addi  x6,x6,1
    addi  x5,x5,-1
    bnez  x5,.DW_RELU
.DW_STORE16
    lw x5, __DEPTHWISE_CONV_FUN._ofmap_p(x2)  // *** store                   // ofmap_wr_pointer
    sv1 x0, 0(x5)
    addi x5,x5,1
    sw x5, __DEPTHWISE_CONV_FUN._ofmap_p(x2)                                 // ofmap_wr_pointer update
.DW_CHECKOUTLOOP    
    lw x5, __DEPTHWISE_CONV_FUN._outer_cnt(x2) // *** check out loop cnt      // outchannel / 16
    addi x5,x5,-1
    bnez x5, 2
    jr x1
    sw x5, __DEPTHWISE_CONV_FUN._outer_cnt(x2)
    lw x5, __DEPTHWISE_CONV_FUN._fmap_fifo_end_p(x2)                          // load ifmap end bound
    addi x5,x5,1
    sw x5, __DEPTHWISE_CONV_FUN._fmap_fifo_end_p(x2)                      // update ifmap end bound
    lw x5, __DEPTHWISE_CONV_FUN._fmap_fifo_start_p(x2)                          // load ifmap end bound
    addi x5,x5,1
    sw x5, __DEPTHWISE_CONV_FUN._fmap_fifo_start_p(x2)                      // update ifmap end bound
    lw x3, __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)                          // load ifmap pointer
    addi x3,x3,1
    sw x3, __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)                      // update ifmap pointer
    lw x4, __DEPTHWISE_CONV_FUN._filter_start_p(x2)                         // load weight pointer
    addi x4,x4,1
    sw x4, __DEPTHWISE_CONV_FUN._filter_start_p(x2)                         // load weight pointer

    j .DW_LOADBIAS
// **********************************************************
//   Skip add
// **********************************************************
.SKIP_ADD_FUNCTION
    lw  x3, __SKIP_ADD._sk_params_p(x2)                                        // load skip add parameters
    lv  v0, 0(x3)
    nop            // 这两个nop不可以少， 因为lv没有v寄存器到普通寄存器的forwarding
    nop
    mv  x4, x11    // bias
    mv  x5, x9     // scale1
    mv  x6, x10    // scale2
    mv  x7, x8     // {0, offset2, offset1, shift}
    lw  x3, __SKIP_ADD._sk_ifmap1_p(x2)
    lv  v0, 0(x3)
    lw  x3, __SKIP_ADD._sk_ifmap2_p(x2)
    lv  v4, 0(x3)
    addi4spn x3, 16
.SKIP_ADD_LOOP_16
    addi x3, x3, -1
    nop                // 这个nop不可少， skipadd是双重寄存器索引， 所以不支持前递
    skipadd x3, x3, x5
    bnez x3, .SKIP_ADD_LOOP_16
    addi4spn x3, 16
    addi4spn x5, 16
.SKIP_ADD_RELU_16
    addi4spn x7,`KWS_MAX_VAL
    addx  x3,x3,x4
    min   x3,x3,x7
    addi4spn x7,`KWS_MIN_VAL
    max   x3,x3,x7
    addi  x3,x3,1
    addi  x5,x5,-1
    bnez  x5,.SKIP_ADD_RELU_16
    //store 
    lw  x3, __SKIP_ADD._sk_ifmap2_p(x2)
    sv1 x0, 0(x3)
    addi x3,x3,1
    sw  x3, __SKIP_ADD._sk_ifmap2_p(x2)
    jr x1

// **********************************************************
//   MAIN
// **********************************************************

.MAIN
// 先要check block count 是否为0
    addi4spn x2, `TOPCTRL_StackBase                 // is block count == 0
    lw x3, __TOPCTRL._block_count(x2)
    addi x3, x3, -1
    addi4spn x4, 3
    addi4spn x5, 0
    max x4,x4, x5
    nop
    sw x3, __TOPCTRL._block_count(x2)
    beqz x3, 2                                      // blocknum == 0, 做NN
    j .NN_END
//-----------   conv 0    -------------------------------------
    addi4spn x1,0 //*** main function
    addi4spn x2, `C1_StackBase

    mvimmx4 x4, `C1_IfmapBase                      // init ifmap  pointer
    sw    x4, __CONV1._ifmap_p(x2)
    mvimmx4 x4, `C1_OfmapBase                      // init ofmap  pointer
    sw    x4, __CONV1._ofmap_p(x2)

    mvimmx4 x4, `C1_BiasBase                       // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `C1_QuantBase                      // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, `C1_InnerLoopFirst                 // init innerloop cnt
    sw    x4, __CONV1._inner_cnt(x2)

    mvimmx4 x4,`C1_IfmapWidth
    sw    x4,__CONV1._out_x(x2)                  // init out x cnt (from 60 to 1)

    mvimmx4 x4, `C1_WeightBaseFirst                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
.CONV1DO
    mvimmx4 x4, `C1_OuterLoop                 // init outerloop cnt
    sw    x4, __CONV1._outer_cnt(x2)
    
    jal   x1, .CONV1

    lw    x4, __CONV1._out_x(x2)   // check out x
    beqz  x4, .IBB1
    addi  x4, x4, -1
    sw    x4,__CONV1._out_x(x2)                  // 
.CHECKOUTX
    beqz     x4, .LASTLINECONV
    addi4spn x5, 58
    sub      x4, x4,x5
    beqz     x4,.SECONDLINECONV
    // 中间的正常卷积
    mvimmx4  x4, `C1_BiasBaseADD16              // bias还是需要重新定位
    sw       x4, __CONV1._bias_p(x2)   
    lw    x4, __CONV1._ifmap_p(x2)              // in_x 递增一行
    addi  x4, x4, 2
    sw    x4, __CONV1._ifmap_p(x2)
    j .CONV1DO                                  // conv line 2-59
.LASTLINECONV
    mvimmx4 x4, `C1_BiasBaseADD32                 // conv line 60
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `C1_InnerLoopFirst                // 最后一次卷积 innerloop cnt = frist inner loop （4）
    sw    x4, __CONV1._inner_cnt(x2)
    lw    x4, __CONV1._ifmap_p(x2)              // in_x 递增一行
    addi  x4, x4, 2
    sw    x4, __CONV1._ifmap_p(x2)
    j .CONV1DO
.SECONDLINECONV                                 // conv line 2
    mvimmx4 x4, `C1_BiasBaseADD16
    sw    x4, __CONV1._bias_p(x2)   

    mvimmx4 x4, `C1_WeightBase                    // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)

    mvimmx4 x4, `C1_IfmapBase                     // ifmap  pointer stay unchange
    sw    x4, __CONV1._ifmap_p(x2)

    mvimmx4 x4, `C1_InnerLoop                     // init innerloop cnt (6)
    sw    x4, __CONV1._inner_cnt(x2)
    j .CONV1DO

// **********************************************************
//   IBB1
// **********************************************************

.IBB1
    // ------------- 标识位， conv0 finish  = 1 ----------------------
    addi4spn x1, 1                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
    //初始化skip add参数
    addi4spn x2, `Skipadd_StackBase                // 切换到skipadd函数栈区
    mvimmx4 x4, `IBB1_skipadd_paramBase            // init weight  pointer
    sw    x4, __SKIP_ADD._sk_params_p(x2)
    mvimmx4 x4, `IBB1_C2_ofmapBase
    sw    x4, __SKIP_ADD._sk_ifmap1_p(x2)
    mvimmx4 x4, `IBB1_C1_ifmapBase
    sw    x4, __SKIP_ADD._sk_ifmap2_p(x2)

    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
  // 初始化循环参数
    mvimmx4 x4, 0
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    mvimmx4 x4, `IBB1_C1_ifmapBase
    addi  x4, x4, -1                               // 让循环从0开始
    sw    x4, __IBB1._c1_ifmap_p(x3)
 //   sw    x4, __CONV1._ifmap_p(x2)
    mvimmx4 x4, `IBB1_C1_ofmapBase                 // init ofmap  pointer
    addi  x4, x4, -3                               // 让循环从0开始
    sw    x4, __IBB1._c1_ofmap_p(x3)
 //   sw    x4, __CONV1._ofmap_p(x2)
    mvimmx4 x4, 0
    sw    x4,__IBB1._c1_out_x(x3)                  // init out x cnt (0)

    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4 , __IBB1._dw_ifmap_p(x3)                // 写入dw ifmap pointer

.IBB1_C1ANDSKIP_CONV
// IBB3 conv1
    // C1卷积
    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
    mvimmx4 x4, `IBB1_C1_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB1_C1_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, 1                                  // init innerloop cnt
    sw    x4, __CONV1._inner_cnt(x2)
    mvimmx4 x4, `IBB1_C1_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C1_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)

    lw    x4, __IBB1._c1_ifmap_p(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._c1_ifmap_p(x3)
    sw    x4, __CONV1._ifmap_p(x2)
    // 检查ofmap指针是否超出fifo
    lw    x5, __IBB1._c1_ofmap_p(x3)
    addi  x5, x5, 3
    mv    x6, x5
    mvimmx4 x4, `IBB1_C1_ofmapBound                            
    sub   x5, x5, x4
    bnez  x5, 3                                    // 如果输出超过9*48的边界，就需要回到起始位置
    mvimmx4 x4, `IBB1_C1_ofmapBase
    mv    x6, x4
    sw    x6, __CONV1._ofmap_p(x2)
    sw    x6, __IBB1._c1_ofmap_p(x3)               // 保存当前的ofmap pointer， 给dw卷积作为输入的ifmap pointer

    jal   x1, .CONV1
    // ------------- 标识位， ibb1_conv1 = 2 -----------------------------
    addi4spn x1, 2                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // ------------------------------------------------------------------
    // skip conv卷积
    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
    mvimmx4 x4, `IBB1_Cskip_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB1_Cskip_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, `IBB1_Cskip_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_Skip_OuterLoop                   // init outerloop cnt (1)
    sw    x4, __CONV1._outer_cnt(x2)

    lw    x4, __IBB1._c1_ifmap_p(x3)                  // skip conv 原位计算                                            
    sw    x4, __CONV1._ifmap_p(x2)
    mv    x5, x4
    mvimmx4 x4, `IBB1_C1_ifmapBase
    sub   x5, x5, x4
    srli  x5, x5, 1                                 // skip conv的输出是ibb conv1的输入的1/2, 需要先求出conv1的输入相对index（减去base)
    add   x4, x4, x5
    sw    x4, __CONV1._ofmap_p(x2)
    jal   x1, .CONV1
    // ------------- 标识位， ibb1_conv skip = 3 -------------------------
    addi4spn x1, 3                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // ------------------------------------------------------------------
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    j .IBB1_LOOP_CTRL

.IBB1_C1_CONV_ALONE
  // C1卷积
    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
    mvimmx4 x4, `IBB1_C1_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB1_C1_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, 1                                  // init innerloop cnt
    sw    x4, __CONV1._inner_cnt(x2)
    mvimmx4 x4, `IBB1_C1_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C1_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)

    lw    x4, __IBB1._c1_ifmap_p(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._c1_ifmap_p(x3)
    sw    x4, __CONV1._ifmap_p(x2)
    // 检查ofmap指针是否超出fifo
    lw    x5, __IBB1._c1_ofmap_p(x3)
    addi  x5, x5, 3
    mv    x6, x5
    mvimmx4 x4, `IBB1_C1_ofmapBound                            
    sub   x5, x5, x4
    bnez  x5, 3                                    // 如果输出超过9*48的边界，就需要回到起始位置
    mvimmx4 x4, `IBB1_C1_ofmapBase
    mv    x6, x4
    sw    x6, __CONV1._ofmap_p(x2)
    sw    x6, __IBB1._c1_ofmap_p(x3)               // 保存当前的ofmap pointer， 给dw卷积作为输入的ifmap pointer

    jal   x1, .CONV1
    // ------------- 标识位， ibb1_conv1 = 2 -----------------------------
    addi4spn x1, 2                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // ------------------------------------------------------------------
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    mv    x5, x4
    addi  x5, x5, -30
    bnez  x5 , .IBB1_C1ANDSKIP_CONV                // conv cnt = 15时只需要做依次c1 alone就行了
    addi  x4, x4, 1
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    
.IBB1_LOOP_CTRL
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    addi x4, x4, -3
    bltz  x4, .IBB1_C1_CONV_ALONE
    addi x4, x4, -3        
    bltz  x4, .IBB1_DW_WIDTH_LTE9                    // 此时 conv cnt = 3,4,5; 对应的dw width = 5，7，9
    addi  x4, x4, -25
    bltz  x4, .IBB1_DW_NORMAL_25                        // 当前9行dw输入全满，总共25次正常的dw卷积
    addi  x4, x4, -2
    bltz  x4, .IBB1_DW_WIDTH_GT27                            // 9行数据不满，依次是8,6行有效数据 
    j     .IBB2

.IBB1_DW_WIDTH_LTE9   
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4, __IBB1._ibb_conv_cnt(x3)                         // 可以省略
    slli x4, x4, 1
    addi x4, x4, -1                                         // width = conv_cnt*2 -1
    sw  x4 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 5,7,9
    mv  x6, x4                                        
    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4 , __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)       // ifmap fifo rd pointer = 0
    // 求当前的weight base = （9-width）*3
    addi4spn x7, 9
    sub  x7, x7, x6 
    mv   x5, x7
    slli x7, x7 ,1    // (q-width)*2
    add  x7, x7, x5   // (q-width)*2 + (q-width)
    mvimmx4 x4, `IBB1_DW_WeightBase
    add x4, x4, x7                                        // 从第(9-width)*3行开始
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB1_DWCONV_MAIN

.IBB1_DW_NORMAL_25
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x4, 9
    sw  x4 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 9
    mvimmx4 x4, `IBB1_DW_WeightBase
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB1_CHECK_DW_IFMAP_POINT

.IBB1_DW_WIDTH_GT27
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4, __IBB1._ibb_conv_cnt(x3)                         // 可以省略
    addi4spn  x5, 70
    slli x4, x4, 1
    sub x5, x5, x4                                         // conv width = 70-2*convcnt
    sw  x5 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 8,6
    mvimmx4 x4, `IBB1_DW_WeightBase
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB1_CHECK_DW_IFMAP_POINT

.IBB1_CHECK_DW_IFMAP_POINT
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4 , __IBB1._dw_ifmap_p(x3)       // 导入dw ifmap pointer
    mv    x5, x4
    addi  x5, x5, 6
    mv    x6, x5
    mvimmx4  x4, `IBB1_C1_ofmapBound
    sub   x5,x5,x4                                 // 如果 dw ifmap + 6 - bound > =0, 表示跃界 , < 0 未跃界                          
    bltz  x5, .IBB1_UPDATA_DW_IFMAP_POINT     
    //跃界      
    // addi  x5, x5, 6                                // 跃界时只需要对差值+ 6即可获得原点偏移量
    mvimmx4 x4, `IBB1_DW_ifmapBase
    add  x4, x4, x5
    mv   x6, x4
  .IBB1_UPDATA_DW_IFMAP_POINT
    sw  x6 , __IBB1._dw_ifmap_p(x3)       // 写入dw ifmap pointer
    sw  x6 , __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)       // ifmap fifo rd pointer = base + 3

   // dw 卷积
.IBB1_DWCONV_MAIN
    mvimmx4 x4, `IBB1_DW_BiasBase                          // 这一段可以放在最开始，只需要跑一次
    sw  x4, __DEPTHWISE_CONV_FUN._bias_p(x2)
    mvimmx4 x4, `IBB1_DW_QuantBase
    sw  x4, __DEPTHWISE_CONV_FUN._quant_p(x2)
    mvimmx4 x4, `IBB1_DW_ofmapBase
    sw  x4, __DEPTHWISE_CONV_FUN._ofmap_p(x2)
    mvimmx4 x4, `IBB_DW_OuterLoop
    sw  x4, __DEPTHWISE_CONV_FUN._outer_cnt(x2)            // 3
    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4, __DEPTHWISE_CONV_FUN._fmap_fifo_start_p(x2)
    mvimmx4 x4, `IBB1_DW_ifmap_fifo_end
    sw  x4, __DEPTHWISE_CONV_FUN._fmap_fifo_end_p(x2)      // 第9行的开始，相当于ofmap的位置-3

    jal x1, .DEPTHWISE_CONV_FUN
    // ------------- 标识位， ibb1_dw = 4 ----------------------------
    addi4spn x1, 4                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
.IBB1_CONV2_MAIN
    addi4spn x2, `C1_StackBase
    mvimmx4 x4, `IBB1_C2_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB1_C2_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, 3                                  // init innerloop cnt 
    sw    x4, __CONV1._inner_cnt(x2)
    mvimmx4 x4, `IBB1_C2_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C2_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)

    mvimmx4 x4, `IBB1_C2_ifmapBase                 // init ifmap  pointer
    sw    x4, __CONV1._ifmap_p(x2)
    mvimmx4 x4, `IBB1_C2_ofmapBase                 // init ofmap  pointer
    sw    x4, __CONV1._ofmap_p(x2)
    jal   x1, .CONV1
    // ------------- 标识位， ibb1_conv2 = 5 -------------------------
    addi4spn x1, 5                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
.IBB1_SKIP_ADD
    addi4spn x2, `Skipadd_StackBase
    jal   x1, .SKIP_ADD_FUNCTION
    // ------------- 标识位， ibb1_skip add = 6 -------------------------
    addi4spn x1, 6                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------

.IBB1_TAIL_CONTROL
  // 判断是否需要跳过c1
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    mv    x5, x4
    addi  x5, x5, -31                                 
    bltz  x5, .TO_IBB1_C1_ALONE                       // 需要做c1, 这里跳转间隔太长了，不能直接通过bltz跳过去（超出了-128—）
    // 不需要做c1
    addi  x4, x4, 1                                 
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    j     .IBB1_LOOP_CTRL
    
  .TO_IBB1_C1_ALONE
    j    .IBB1_C1_CONV_ALONE

// **********************************************************
//   IBB2
// **********************************************************

.IBB2
    // ------------- 标识位， ibb1 finish  = 7 ----------------------------
    addi4spn x1, 7                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
   //初始化skip add参数
    addi4spn x2, `Skipadd_StackBase                // 切换到skipadd函数栈区
    mvimmx4 x4, `IBB2_skipadd_paramBase            // init weight  pointer
    sw    x4, __SKIP_ADD._sk_params_p(x2)
    mvimmx4 x4, `IBB1_C2_ofmapBase
    sw    x4, __SKIP_ADD._sk_ifmap1_p(x2)
    mvimmx4 x4, `IBB1_C1_ifmapBase
    sw    x4, __SKIP_ADD._sk_ifmap2_p(x2)

    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
  // 初始化循环参数
    mvimmx4 x4, 0
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    mvimmx4 x4, `IBB1_C1_ifmapBase
    addi  x4, x4, -1                               // 让循环从0开始
    sw    x4, __IBB1._c1_ifmap_p(x3)
 //   sw    x4, __CONV1._ifmap_p(x2)
    mvimmx4 x4, `IBB1_C1_ofmapBase                 // init ofmap  pointer
    addi  x4, x4, -3                               // 让循环从0开始
    sw    x4, __IBB1._c1_ofmap_p(x3)
 //   sw    x4, __CONV1._ofmap_p(x2)
    mvimmx4 x4, 0
    sw    x4,__IBB1._c1_out_x(x3)                  // init out x cnt (0)

    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4 , __IBB1._dw_ifmap_p(x3)                // 写入dw ifmap pointer


.IBB2_LOOPMAIN
  // 判断是否要进行dw卷积
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    mv    x5, x4
    addi  x5, x5, -5                                 
    bltz  x5, .IBB2_C1                            // 当前9行dw输入中只有3行数据
    addi  x5, x5, -5                                 
    bltz  x5, .IBB2_DW_WIDTH_LTE9                       // 当前9行dw输入中有5-9行数据
    addi  x5, x5, -21
    bltz  x5, .IBB2_DW_NORMAL_21                        // 当前9行dw输入全满，总共21次正常的dw卷积
    addi  x5, x5, -4
    bltz  x5, .IBB2_DW_WIDTH_GT21                            // 9行数据不满，依次是8,7,6,5行有效数据 
    j     .IBB3

// conv 1
.IBB2_C1
    addi4spn x2, `C1_StackBase
    mvimmx4 x4, `IBB2_C1_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB2_C1_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, `IBB2_C1_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C1_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)
    mvimmx4 x4, 1                                  // 由于后面c2的输入channel=48,会修改inner loop,所以这里要改回来
    sw    x4, __CONV1._inner_cnt(x2)

    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._c1_ifmap_p(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._c1_ifmap_p(x3)
    sw    x4, __CONV1._ifmap_p(x2)
    // 检查ofmap指针是否超出fifo
    lw    x5, __IBB1._c1_ofmap_p(x3)
    addi  x5, x5, 3
    mv    x6, x5
    mvimmx4 x4, `IBB1_C1_ofmapBound                            
    sub   x5, x5, x4
    bnez  x5, 3                                    // 如果输出超过9*48的边界，就需要回到起始位置
    mvimmx4 x4, `IBB1_C1_ofmapBase
    mv    x6, x4
    sw    x6, __CONV1._ofmap_p(x2)
    sw    x6, __IBB1._c1_ofmap_p(x3)               // 保存当前的ofmap pointer， 给dw卷积作为输入的ifmap pointer

    jal   x1, .CONV1
    //保存当前 c1卷积次数
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    // ------------- 标识位， ibb2_conv1 = 8 -------------------------
    addi4spn x1, 8                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
    j .IBB2_LOOPMAIN

.IBB2_DW_WIDTH_LTE9   
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4, __IBB1._ibb_conv_cnt(x3)                         // 可以省略
    sw  x4 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 5,6,7,8,9
    mv  x6, x4                                        
    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4 , __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)       // ifmap fifo rd pointer = 0
    // 求当前的weight base = （9-width）*3
    addi4spn x7, 9
    sub  x7, x7, x6 
    mv   x5, x7
    slli x7, x7 ,1    // (q-width)*2
    add  x7, x7, x5   // (q-width)*2 + (q-width)
    mvimmx4 x4, `IBB2_DW_WeightBase
    add x4, x4, x7                                        // 从第(9-width)*3行开始
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB2_DWCONV_MAIN

.IBB2_DW_NORMAL_21   
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x4, 9
    sw  x4 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 9
    mvimmx4 x4, `IBB2_DW_WeightBase
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB2_CHECK_DW_IFMAP_POINT

.IBB2_DW_WIDTH_GT21
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4, __IBB1._ibb_conv_cnt(x3)                         // 可以省略
    addi4spn  x5, 39
    sub x5, x5, x4                                         // conv width = 39-convcnt
    sw  x5 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 5,6,7,8
    mvimmx4 x4, `IBB2_DW_WeightBase
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB2_CHECK_DW_IFMAP_POINT

.IBB2_CHECK_DW_IFMAP_POINT
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4 , __IBB1._dw_ifmap_p(x3)       // 导入dw ifmap pointer
    mv    x5, x4
    mvimmx4  x4, `IBB1_C1_ofmapBound2
    sub   x5,x5,x4                                    
    bnez  x5, 3                                    // 如果输出超过9*48的边界，就需要回到起始位置, 此时处于第8行，下一次卷积开始位置是第1行
   // ifmap到边界-3
    mvimmx4 x4, `IBB1_DW_ifmapBase
    j .IBB2_UPDATA_DW_IFMAP_POINT
    // ifmap没到边界
    lw  x4 , __IBB1._dw_ifmap_p(x3)       // 导入dw ifmap pointer
    addi  x4, x4, 3
  .IBB2_UPDATA_DW_IFMAP_POINT
    sw  x4 , __IBB1._dw_ifmap_p(x3)       // 写入dw ifmap pointer
    sw  x4 , __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)       // ifmap fifo rd pointer = base + 3
   // dw 卷积
.IBB2_DWCONV_MAIN
    mvimmx4 x4, `IBB2_DW_BiasBase                          // 这一段可以放在最开始，只需要跑一次
    sw  x4, __DEPTHWISE_CONV_FUN._bias_p(x2)
    mvimmx4 x4, `IBB2_DW_QuantBase
    sw  x4, __DEPTHWISE_CONV_FUN._quant_p(x2)
    mvimmx4 x4, `IBB1_DW_ofmapBase
    sw  x4, __DEPTHWISE_CONV_FUN._ofmap_p(x2)
    mvimmx4 x4, `IBB_DW_OuterLoop
    sw  x4, __DEPTHWISE_CONV_FUN._outer_cnt(x2)            // 3
    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4, __DEPTHWISE_CONV_FUN._fmap_fifo_start_p(x2)
    mvimmx4 x4, `IBB1_DW_ifmap_fifo_end
    sw  x4, __DEPTHWISE_CONV_FUN._fmap_fifo_end_p(x2)      // 第9行的开始，相当于ofmap的位置-3

    jal x1, .DEPTHWISE_CONV_FUN
    // ------------- 标识位， ibb1_dw = 9 ----------------------------
    addi4spn x1, 9                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
.IBB2_CONV2_MAIN
    addi4spn x2, `C1_StackBase
    mvimmx4 x4, `IBB2_C2_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB2_C2_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, 3                                  // init innerloop cnt 
    sw    x4, __CONV1._inner_cnt(x2)
    mvimmx4 x4, `IBB2_C2_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C2_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)

    mvimmx4 x4, `IBB1_C2_ifmapBase                 // init ifmap  pointer
    sw    x4, __CONV1._ifmap_p(x2)
    mvimmx4 x4, `IBB1_C2_ofmapBase                 // init ofmap  pointer
    sw    x4, __CONV1._ofmap_p(x2)
    jal   x1, .CONV1
    // ------------- 标识位， ibb2_conv2 = 10 -------------------------
    addi4spn x1, 10                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
.IBB2_SKIP_ADD
    addi4spn x2, `Skipadd_StackBase
    jal   x1, .SKIP_ADD_FUNCTION
    // ------------- 标识位， ibb2_skip add = 11 -------------------------
    addi4spn x1, 11                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
.IBB2_TAIL_CONTROL
  // 判断是否需要跳过c1
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    mv    x5, x4
    addi  x5, x5, -30                                 
    bltz  x5, .IBB2_C1                            // 需要做c1
    // 不需要做c1
    addi  x4, x4, 1                                 
    sw    x4, __IBB1._ibb_conv_cnt(x3)

    j     .IBB2_LOOPMAIN

// **********************************************************
//   IBB3
// **********************************************************

.IBB3
    // ------------- 标识位， ibb2 finish  = 12 ----------------------
    addi4spn x1, 12                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
    //初始化skip add参数
    addi4spn x2, `Skipadd_StackBase                // 切换到skipadd函数栈区
    mvimmx4 x4, `IBB3_skipadd_paramBase            // init weight  pointer
    sw    x4, __SKIP_ADD._sk_params_p(x2)
    mvimmx4 x4, `IBB1_C2_ofmapBase
    sw    x4, __SKIP_ADD._sk_ifmap1_p(x2)
    mvimmx4 x4, `IBB1_C1_ifmapBase
    sw    x4, __SKIP_ADD._sk_ifmap2_p(x2)

    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
  // 初始化循环参数
    mvimmx4 x4, 0
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    mvimmx4 x4, `IBB1_C1_ifmapBase
    addi  x4, x4, -1                               // 让循环从0开始
    sw    x4, __IBB1._c1_ifmap_p(x3)
 //   sw    x4, __CONV1._ifmap_p(x2)
    mvimmx4 x4, `IBB1_C1_ofmapBase                 // init ofmap  pointer
    addi  x4, x4, -3                               // 让循环从0开始
    sw    x4, __IBB1._c1_ofmap_p(x3)
 //   sw    x4, __CONV1._ofmap_p(x2)
    mvimmx4 x4, 0
    sw    x4,__IBB1._c1_out_x(x3)                  // init out x cnt (0)

    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4 , __IBB1._dw_ifmap_p(x3)                // 写入dw ifmap pointer

.IBB3_C1ANDSKIP_CONV
// IBB3 conv1
    // C1卷积
    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
    mvimmx4 x4, `IBB3_C1_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB3_C1_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, 1                                  // init innerloop cnt
    sw    x4, __CONV1._inner_cnt(x2)
    mvimmx4 x4, `IBB3_C1_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C1_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)

    lw    x4, __IBB1._c1_ifmap_p(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._c1_ifmap_p(x3)
    sw    x4, __CONV1._ifmap_p(x2)
    // 检查ofmap指针是否超出fifo
    lw    x5, __IBB1._c1_ofmap_p(x3)
    addi  x5, x5, 3
    mv    x6, x5
    mvimmx4 x4, `IBB1_C1_ofmapBound                            
    sub   x5, x5, x4
    bnez  x5, 3                                    // 如果输出超过9*48的边界，就需要回到起始位置
    mvimmx4 x4, `IBB1_C1_ofmapBase
    mv    x6, x4
    sw    x6, __CONV1._ofmap_p(x2)
    sw    x6, __IBB1._c1_ofmap_p(x3)               // 保存当前的ofmap pointer， 给dw卷积作为输入的ifmap pointer

    jal   x1, .CONV1
    // ------------- 标识位， ibb3_conv1 = 13 -----------------------------
    addi4spn x1, 13                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // ------------------------------------------------------------------
    // skip conv卷积
    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
    mvimmx4 x4, `IBB3_Cskip_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB3_Cskip_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, `IBB3_Cskip_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_Skip_OuterLoop                   // init outerloop cnt (1)
    sw    x4, __CONV1._outer_cnt(x2)

    lw    x4, __IBB1._c1_ifmap_p(x3)                  // skip conv 原位计算                                            
    sw    x4, __CONV1._ifmap_p(x2)
    mv    x5, x4
    mvimmx4 x4, `IBB1_C1_ifmapBase
    sub   x5, x5, x4
    srli  x5, x5, 1                                 // skip conv的输出是ibb conv1的输入的1/2, 需要先求出conv1的输入相对index（减去base)
    add   x4, x4, x5
    sw    x4, __CONV1._ofmap_p(x2)
    jal   x1, .CONV1
    // ------------- 标识位， ibb1_conv skip = 14 -------------------------
    addi4spn x1, 14                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // ------------------------------------------------------------------
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    j .IBB3_LOOP_CTRL

.IBB3_C1_CONV_ALONE
  // C1卷积
    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
    mvimmx4 x4, `IBB3_C1_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB3_C1_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, 1                                  // init innerloop cnt
    sw    x4, __CONV1._inner_cnt(x2)
    mvimmx4 x4, `IBB3_C1_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C1_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)

    lw    x4, __IBB1._c1_ifmap_p(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._c1_ifmap_p(x3)
    sw    x4, __CONV1._ifmap_p(x2)
    // 检查ofmap指针是否超出fifo
    lw    x5, __IBB1._c1_ofmap_p(x3)
    addi  x5, x5, 3
    mv    x6, x5
    mvimmx4 x4, `IBB1_C1_ofmapBound                            
    sub   x5, x5, x4
    bnez  x5, 3                                    // 如果输出超过9*48的边界，就需要回到起始位置
    mvimmx4 x4, `IBB1_C1_ofmapBase
    mv    x6, x4
    sw    x6, __CONV1._ofmap_p(x2)
    sw    x6, __IBB1._c1_ofmap_p(x3)               // 保存当前的ofmap pointer， 给dw卷积作为输入的ifmap pointer

    jal   x1, .CONV1
    // ------------- 标识位， ibb3_conv1 = 13 -----------------------------
    addi4spn x1, 13                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // ------------------------------------------------------------------
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    mv    x5, x4
    addi  x5, x5, -15
    bnez  x5 , .IBB3_C1ANDSKIP_CONV                // conv cnt = 15时只需要做依次c1 alone就行了
    addi  x4, x4, 1
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    
.IBB3_LOOP_CTRL
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    addi x4, x4, -3
    bltz  x4, .IBB3_C1_CONV_ALONE
    addi x4, x4, -3        
    bltz  x4, .IBB3_DW_WIDTH_LTE9                    // 此时 conv cnt = 3,4,5; 对应的dw width = 5，7，9
    addi  x4, x4, -10
    bltz  x4, .IBB3_DW_NORMAL_10                        // 当前9行dw输入全满，总共10次正常的dw卷积
    addi  x4, x4, -2
    bltz  x4, .IBB3_DW_WIDTH_GT10                            // 9行数据不满，依次是8,6行有效数据 
    j     .IBB4

.IBB3_DW_WIDTH_LTE9   
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4, __IBB1._ibb_conv_cnt(x3)                         // 可以省略
    slli x4, x4, 1
    addi x4, x4, -1                                         // width = conv_cnt*2 -1
    sw  x4 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 5,7,9
    mv  x6, x4                                        
    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4 , __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)       // ifmap fifo rd pointer = 0
    // 求当前的weight base = （9-width）*3
    addi4spn x7, 9
    sub  x7, x7, x6 
    mv   x5, x7
    slli x7, x7 ,1    // (q-width)*2
    add  x7, x7, x5   // (q-width)*2 + (q-width)
    mvimmx4 x4, `IBB3_DW_WeightBase
    add x4, x4, x7                                        // 从第(9-width)*3行开始
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB3_DWCONV_MAIN

.IBB3_DW_NORMAL_10
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x4, 9
    sw  x4 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 9
    mvimmx4 x4, `IBB3_DW_WeightBase
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB3_CHECK_DW_IFMAP_POINT

.IBB3_DW_WIDTH_GT10
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4, __IBB1._ibb_conv_cnt(x3)                         // 可以省略
    addi4spn  x5, 40
    slli x4, x4, 1
    sub x5, x5, x4                                         // conv width = 40-2*convcnt
    sw  x5 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 8,6
    mvimmx4 x4, `IBB3_DW_WeightBase
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB3_CHECK_DW_IFMAP_POINT

.IBB3_CHECK_DW_IFMAP_POINT
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4 , __IBB1._dw_ifmap_p(x3)       // 导入dw ifmap pointer
    mv    x5, x4
    addi  x5, x5, 6
    mv    x6, x5
    mvimmx4  x4, `IBB1_C1_ofmapBound
    sub   x5,x5,x4                                 // 如果 dw ifmap + 6 - bound > =0, 表示跃界 , < 0 未跃界                          
    bltz  x5, .IBB3_UPDATA_DW_IFMAP_POINT     
    //跃界      
    // addi  x5, x5, 6                                // 跃界时只需要对差值+ 6即可获得原点偏移量
    mvimmx4 x4, `IBB1_DW_ifmapBase
    add  x4, x4, x5
    mv   x6, x4
  .IBB3_UPDATA_DW_IFMAP_POINT
    sw  x6 , __IBB1._dw_ifmap_p(x3)       // 写入dw ifmap pointer
    sw  x6 , __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)       // ifmap fifo rd pointer = base + 3

   // dw 卷积
.IBB3_DWCONV_MAIN
    mvimmx4 x4, `IBB3_DW_BiasBase                          // 这一段可以放在最开始，只需要跑一次
    sw  x4, __DEPTHWISE_CONV_FUN._bias_p(x2)
    mvimmx4 x4, `IBB3_DW_QuantBase
    sw  x4, __DEPTHWISE_CONV_FUN._quant_p(x2)
    mvimmx4 x4, `IBB1_DW_ofmapBase
    sw  x4, __DEPTHWISE_CONV_FUN._ofmap_p(x2)
    mvimmx4 x4, `IBB_DW_OuterLoop
    sw  x4, __DEPTHWISE_CONV_FUN._outer_cnt(x2)            // 3
    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4, __DEPTHWISE_CONV_FUN._fmap_fifo_start_p(x2)
    mvimmx4 x4, `IBB1_DW_ifmap_fifo_end
    sw  x4, __DEPTHWISE_CONV_FUN._fmap_fifo_end_p(x2)      // 第9行的开始，相当于ofmap的位置-3

    jal x1, .DEPTHWISE_CONV_FUN
    // ------------- 标识位， ibb3_dw = 15 ----------------------------
    addi4spn x1, 15                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
.IBB3_CONV2_MAIN
    addi4spn x2, `C1_StackBase
    mvimmx4 x4, `IBB3_C2_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB3_C2_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, 3                                  // init innerloop cnt 
    sw    x4, __CONV1._inner_cnt(x2)
    mvimmx4 x4, `IBB3_C2_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C2_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)

    mvimmx4 x4, `IBB1_C2_ifmapBase                 // init ifmap  pointer
    sw    x4, __CONV1._ifmap_p(x2)
    mvimmx4 x4, `IBB1_C2_ofmapBase                 // init ofmap  pointer
    sw    x4, __CONV1._ofmap_p(x2)
    jal   x1, .CONV1
    // ------------- 标识位， ibb3_conv2 = 16 -------------------------
    addi4spn x1, 16                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
.IBB3_SKIP_ADD
    addi4spn x2, `Skipadd_StackBase
    jal   x1, .SKIP_ADD_FUNCTION
    // ------------- 标识位， ibb3_skip add = 17 -------------------------
    addi4spn x1, 17                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------

.IBB3_TAIL_CONTROL
  // 判断是否需要跳过c1
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    mv    x5, x4
    addi  x5, x5, -16                                 
    bltz  x5, .TO_IBB3_C1_ALONE                       // 需要做c1, 这里跳转间隔太长了，不能直接通过bltz跳过去（超出了-128—）
    // 不需要做c1
    addi  x4, x4, 1                                 
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    j     .IBB3_LOOP_CTRL
    
  .TO_IBB3_C1_ALONE
    j    .IBB3_C1_CONV_ALONE
// **********************************************************
//   IBB4
// **********************************************************

.IBB4
    // ------------- 标识位， ibb3 finish  = 18 ----------------------
    addi4spn x1, 18                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------

   //初始化skip add参数
    addi4spn x2, `Skipadd_StackBase                // 切换到skipadd函数栈区
    mvimmx4 x4, `IBB4_skipadd_paramBase            // init weight  pointer
    sw    x4, __SKIP_ADD._sk_params_p(x2)
    mvimmx4 x4, `IBB1_C2_ofmapBase
    sw    x4, __SKIP_ADD._sk_ifmap1_p(x2)
    mvimmx4 x4, `IBB1_C1_ifmapBase
    sw    x4, __SKIP_ADD._sk_ifmap2_p(x2)

    addi4spn x2, `C1_StackBase
    addi4spn x3, `IBB1C1_StackBase
  // 初始化循环参数
    mvimmx4 x4, 0
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    mvimmx4 x4, `IBB1_C1_ifmapBase
    addi  x4, x4, -1                               // 让循环从0开始
    sw    x4, __IBB1._c1_ifmap_p(x3)
 //   sw    x4, __CONV1._ifmap_p(x2)
    mvimmx4 x4, `IBB1_C1_ofmapBase                 // init ofmap  pointer
    addi  x4, x4, -3                               // 让循环从0开始
    sw    x4, __IBB1._c1_ofmap_p(x3)
 //   sw    x4, __CONV1._ofmap_p(x2)
    mvimmx4 x4, 0
    sw    x4,__IBB1._c1_out_x(x3)                  // init out x cnt (0)

    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4 , __IBB1._dw_ifmap_p(x3)                // 写入dw ifmap pointer

.IBB4_LOOPMAIN
  // 判断是否要进行dw卷积
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    mv    x5, x4
    addi  x5, x5, -5                                 
    bltz  x5, .IBB4_C1                            // 当前9行dw输入中只有3行数据
    addi  x5, x5, -5                                 
    bltz  x5, .IBB4_DW_WIDTH_LTE9                       // 当前9行dw输入中有5-9行数据
    addi  x5, x5, -6
    bltz  x5, .IBB4_DW_NORMAL_6                        // 当前9行dw输入全满，总共6次正常的dw卷积
    addi  x5, x5, -4
    bltz  x5, .IBB4_DW_WIDTH_GT6                            // 9行数据不满，依次是8,7,6,5行有效数据 
    j     .AVGPOOL

// conv 1
.IBB4_C1
    addi4spn x2, `C1_StackBase
    mvimmx4 x4, `IBB4_C1_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB4_C1_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, `IBB4_C1_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C1_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)
    mvimmx4 x4, 1                                  // 由于后面c2的输入channel=48,会修改inner loop,所以这里要改回来
    sw    x4, __CONV1._inner_cnt(x2)

    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._c1_ifmap_p(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._c1_ifmap_p(x3)
    sw    x4, __CONV1._ifmap_p(x2)
    // 检查ofmap指针是否超出fifo
    lw    x5, __IBB1._c1_ofmap_p(x3)
    addi  x5, x5, 3
    mv    x6, x5
    mvimmx4 x4, `IBB1_C1_ofmapBound                            
    sub   x5, x5, x4
    bnez  x5, 3                                    // 如果输出超过9*48的边界，就需要回到起始位置
    mvimmx4 x4, `IBB1_C1_ofmapBase
    mv    x6, x4
    sw    x6, __CONV1._ofmap_p(x2)
    sw    x6, __IBB1._c1_ofmap_p(x3)               // 保存当前的ofmap pointer， 给dw卷积作为输入的ifmap pointer

    jal   x1, .CONV1
    //保存当前 c1卷积次数
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    addi  x4, x4, 1
    sw    x4, __IBB1._ibb_conv_cnt(x3)
    // ------------- 标识位， ibb4 conv1 = 19 -------------------------
    addi4spn x1, 19                                 // layer finish
    addi4spn x1, 0                                  // layer finish
    // --------------------------------------------------------------
    j .IBB4_LOOPMAIN

.IBB4_DW_WIDTH_LTE9   
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4, __IBB1._ibb_conv_cnt(x3)                         // 可以省略
    sw  x4 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 5,6,7,8,9
    mv  x6, x4                                        
    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4 , __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)       // ifmap fifo rd pointer = 0
    // 求当前的weight base = （9-width）*3
    addi4spn x7, 9
    sub  x7, x7, x6 
    mv   x5, x7
    slli x7, x7 ,1    // (q-width)*2
    add  x7, x7, x5   // (q-width)*2 + (q-width)
    mvimmx4 x4, `IBB4_DW_WeightBase
    add x4, x4, x7                                        // 从第(9-width)*3行开始
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB4_DWCONV_MAIN

.IBB4_DW_NORMAL_6   
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x4, 9
    sw  x4 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 9
    mvimmx4 x4, `IBB4_DW_WeightBase
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB4_CHECK_DW_IFMAP_POINT

.IBB4_DW_WIDTH_GT6
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4, __IBB1._ibb_conv_cnt(x3)                         // 可以省略
    addi4spn  x5, 24
    sub x5, x5, x4                                         // conv width = 24-convcnt
    sw  x5 , __DEPTHWISE_CONV_FUN._conv_width(x2)          // conv width = 5,6,7,8
    mvimmx4 x4, `IBB4_DW_WeightBase
    sw  x4 , __DEPTHWISE_CONV_FUN._filter_start_p(x2)      // weight rd pointer = 0
    j .IBB4_CHECK_DW_IFMAP_POINT

.IBB4_CHECK_DW_IFMAP_POINT
    addi4spn x2, `DW_StackBase                         // 切换到dw函数栈区
    addi4spn x3, `IBB1C1_StackBase
    lw  x4 , __IBB1._dw_ifmap_p(x3)       // 导入dw ifmap pointer
    mv    x5, x4
    mvimmx4  x4, `IBB1_C1_ofmapBound2
    sub   x5,x5,x4                                    
    bnez  x5, 3                                    // 如果输出超过9*48的边界，就需要回到起始位置, 此时处于第8行，下一次卷积开始位置是第1行
   // ifmap到边界-3
    mvimmx4 x4, `IBB1_DW_ifmapBase
    j .IBB4_UPDATA_DW_IFMAP_POINT
    // ifmap没到边界
    lw  x4 , __IBB1._dw_ifmap_p(x3)       // 导入dw ifmap pointer
    addi  x4, x4, 3
  .IBB4_UPDATA_DW_IFMAP_POINT
    sw  x4 , __IBB1._dw_ifmap_p(x3)       // 写入dw ifmap pointer
    sw  x4 , __DEPTHWISE_CONV_FUN._ifmap_start_p(x2)       // ifmap fifo rd pointer = base + 3
   // dw 卷积
.IBB4_DWCONV_MAIN
    mvimmx4 x4, `IBB4_DW_BiasBase                          // 这一段可以放在最开始，只需要跑一次
    sw  x4, __DEPTHWISE_CONV_FUN._bias_p(x2)
    mvimmx4 x4, `IBB4_DW_QuantBase
    sw  x4, __DEPTHWISE_CONV_FUN._quant_p(x2)
    mvimmx4 x4, `IBB1_DW_ofmapBase
    sw  x4, __DEPTHWISE_CONV_FUN._ofmap_p(x2)
    mvimmx4 x4, `IBB_DW_OuterLoop
    sw  x4, __DEPTHWISE_CONV_FUN._outer_cnt(x2)            // 3
    mvimmx4 x4, `IBB1_DW_ifmapBase
    sw  x4, __DEPTHWISE_CONV_FUN._fmap_fifo_start_p(x2)
    mvimmx4 x4, `IBB1_DW_ifmap_fifo_end
    sw  x4, __DEPTHWISE_CONV_FUN._fmap_fifo_end_p(x2)      // 第9行的开始，相当于ofmap的位置-3

    jal x1, .DEPTHWISE_CONV_FUN
    // ------------- 标识位， ibb4_dw = 20 ----------------------------
    addi4spn x1, 20                                 // layer finish
    addi4spn x1, 0                                  // layer finish
    // --------------------------------------------------------------
.IBB4_CONV2_MAIN
    addi4spn x2, `C1_StackBase
    mvimmx4 x4, `IBB4_C2_BiasBase                  // init bias  pointer
    sw    x4, __CONV1._bias_p(x2)
    mvimmx4 x4, `IBB4_C2_QuantBase                 // init quant  pointer
    sw    x4, __CONV1._quant_p(x2)
    mvimmx4 x4, 3                                  // init innerloop cnt 
    sw    x4, __CONV1._inner_cnt(x2)
    mvimmx4 x4, `IBB4_C2_WeightBase                // init weight  pointer
    sw    x4, __CONV1._filter_p(x2)
    mvimmx4 x4, `IBB_C2_OuterLoop                  // init outerloop cnt (3)
    sw    x4, __CONV1._outer_cnt(x2)

    mvimmx4 x4, `IBB1_C2_ifmapBase                 // init ifmap  pointer
    sw    x4, __CONV1._ifmap_p(x2)
    mvimmx4 x4, `IBB1_C2_ofmapBase                 // init ofmap  pointer
    sw    x4, __CONV1._ofmap_p(x2)
    jal   x1, .CONV1
    // ------------- 标识位， ibb2_conv2 = 10 -------------------------
    addi4spn x1, 21                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
.IBB4_SKIP_ADD
    addi4spn x2, `Skipadd_StackBase
    jal   x1, .SKIP_ADD_FUNCTION
    // ------------- 标识位， ibb2_skip add = 11 -------------------------
    addi4spn x1, 22                                 // layer finish
    addi4spn x1, 0                                  // layer finish
    // --------------------------------------------------------------
.IBB4_TAIL_CONTROL
  // 判断是否需要跳过c1
    addi4spn x3, `IBB1C1_StackBase
    lw    x4, __IBB1._ibb_conv_cnt(x3)
    mv    x5, x4
    addi  x5, x5, -15                                 
    bltz  x5, .IBB4_C1                            // 需要做c1
    // 不需要做c1
    addi  x4, x4, 1                                 
    sw    x4, __IBB1._ibb_conv_cnt(x3)

    j     .IBB4_LOOPMAIN

.AVGPOOL
    // ------------- 标识位， ibb4 finished = 23 ---------------------
    addi4spn x1, 23                                 // layer finish
    addi4spn x1, 0                                 // layer finish
    // --------------------------------------------------------------
     // clear sum buffer
    luil8 x4,  0
    mv x16, x4
    mv x17, x4
    mv x18, x4
    mv x19, x4
    mv x20, x4
    mv x21, x4
    mv x22, x4
    mv x23, x4
    mv x24, x4
    mv x25, x4
    mv x26, x4
    mv x27, x4
    mv x28, x4
    mv x29, x4
    mv x30, x4
    mv x31, x4
    // mul b is all 1
    mvimmx4 x4,  257            // 0000 0000 0000 0000 0000 0001 0000 0001
    slli x4, x4, 8              // 0000 0000 0000 0001 0000 0001 0000 0000 
    addi x4, x4, 1              // 0000 0000 0000 0001 0000 0001 0000 0001 
    slli x4, x4, 8              // 0000 0001 0000 0001 0000 0001 0000 0000
    addi x4, x4, 1              // 0000 0001 0000 0001 0000 0001 0000 0001

    mv   x12, x4
    mv   x13, x4
    mv   x14, x4
    mv   x15, x4

    mvimmx4 x4, `AVGPOOL_ifmapBase                        // load ifmap pointer
    addi4spn x5, 15
.AVGPOOL_LOAD_IFMAP
    lv v0, 0(x4)                                 // load ifmap line
    addi x4,x4,1                                 
    addi4spn x7,16                               // psum index (from x16 to x31) //注意，vmac8的操作数不支持前递，所以x7的值需要提前vmac一拍
    addi4spn x6,16                               // out channel loop num
.AVGMACC8
    vmac8 x7,x7,x7
    addi x7,x7,1
    addi x6,x6,-1
    bnez x6, .AVGMACC8
    addi x5,x5,-1
    bnez x5, .AVGPOOL_LOAD_IFMAP
.AVG_QUANT16
    mvimmx4 x4, `AvgPool_QuantBase
    lv v0, 0(x4)                                 // x8 = zero_point; x9 = scale(int32); x10 = shift
    addi4spn x6,16                               // out activate and quant loop
    addi4spn x5,16                               // out activate and quant loop
    mv x7, x10                                   // prepare quant shift to x7
.AVG_RTE
    fmsr  x6,x6,x9
    addx  x6,x6,x8
    addi  x6,x6,1
    addi  x5,x5,-1
    bnez  x5,.AVG_RTE

    mvimmx4 x4, `AVGPOOL_ofmapBase
    sv1  x0, 0(x4)

.LINEAR
    // ------------- 标识位， avgpool finished = 24 -------------------
    addi4spn x1, 24                                 // layer finish
    addi4spn x1, 0                                  // layer finish
    // --------------------------------------------------------------
    mvimmx4 x4, `LINEAR_BiasBase
    lv v8, 0(x4)
    addi x4,x4,1
    lv v12, 0(x4)
    addi x4,x4,1
    lv v16, 0(x4)
    addi x4,x4,1
    lv v20, 0(x4)
    addi x4,x4,1

    addi4spn x6,9   // ***layer-1 conv 1*n       // out channel loop num
    addi4spn x7,16                               // psum index (from x16 to x31)
    mvimmx4 x4, `LINEAR_ifmapBase                    // load ifmap pointer
    lv v0, 0(x4)                                 // load act line
    mvimmx4 x4, `LINEAR_WeightBase                    // load weight pointer
.LINEAR_MULSUM16
    lv v4, 0(x4)
    addi x4,x4,1                                 // load weight step = 1, because each mem line contains 16 elements
    vmulsum x7,x7,v0
    addi x7,x7,1
    addi x6,x6,-1
    bnez x6, .LINEAR_MULSUM16
.LINEAR_CQUANT16
    mvimmx4 x4, `LINEAR_QuantBase                    // load quant pointer
    lv v0, 0(x4)                                 // x8 = zero_point; x9 = scale(int32); x10 = shift
    addi4spn x6,16                               // out activate and quant loop
    addi4spn x5,9                               // out activate and quant loop
.LINEAR_C1RELU
    mv x7, x10
    fmsr  x6,x6,x9
    addi4spn x7,`KWS_MAX_VAL
    addx  x6,x6,x8
    min   x6,x6,x7
    addi4spn x7,`KWS_MIN_VAL
    max   x6,x6,x7
    addi  x6,x6,1
    addi  x5,x5,-1
    bnez  x5,.LINEAR_C1RELU

    mvimmx4 x4, `LINEAR_ofmapBase                    // load ofmap pointer
    sv1 x0, 0(x4)

.SOFTMAX
    // ------------- 标识位， linear finished = 25 -------------------
    addi4spn x1, 25                                 // layer finish
    addi4spn x1, 0                                  // layer finish
    // --------------------------------------------------------------
    mvimmx4 x4, `SOFTMAX_PARAM
    lv v0, 0(x4)
    addi x4, x4, 1
    lv v4, 0(x4)
    mv x4, x8
    srai x4, x4, 9
    addi4spn x5, 9                               // out activate and loop
    addi4spn x6, 16
    addi4spn x7, 0                              // x7 = shift num
.SM_DEQUANT_LOOP
    subx   x6,x6,x9
    nop
    fxmul  x6,x6,x4
    addi  x5,x5,-1
    addi  x6,x6, 1
    bnez  x5,.SM_DEQUANT_LOOP

    addi4spn x3, 7                               // max value in x7
    mv x7, x16
    addi4spn x6, 17
    addi4spn x5, 8
.FIND_MAX_ONE
    mvx   x4, x6
    nop
    max   x3,x3,x4
    addi  x5,x5,-1
    addi  x6,x6, 1
    bnez  x5,.FIND_MAX_ONE
  // max one in x7
    addi4spn x6, 16
    addi4spn x5, 9                               // out activate and loop
.MINUSMAX_LOOP
    subx   x6,x6,x7
    nop
    addx   x6,x6,x11
    nop
    max    x6,x6,x0
    addi  x5,x5,-1
    addi  x6,x6, 1
    bnez  x5,.MINUSMAX_LOOP

    addi4spn x2, `SOFTMAX_StackBase
    addi4spn x5, 9                               // out activate and loop
    addi4spn x6, 16
.SOFTINIT   
    addi4spn x3, 0
.FINDQ_LOOP
    subx x6,x6,x10                               // x10 = ln2
    nop
    mvx x4, x6
    bltz x4, .DIV_END
    addi x3,x3,1
    j .FINDQ_LOOP
.DIV_END
    addi4spn x7, `SOFTMAX_StackBase
    sw x3, __SMOUT._ln2_p(x7)
    add  x4,x4, x10                             // 多减了一次，需要加回来。 x3,x5,x6，x7,x10, x12,x13,x14,x15 都被占用
    bnez x4, 4                   
    mv   x4, x12                                // r = 0
    sw   x4, __SMOUT._numerator_0(x2)
    j .EXPCAL_LOOPCTL                            
    slli x4, x4, 7                               // r << 7
    mv   x3, x4                                  // x3 = r
    mv   x8, x12
    add  x4, x4, x8                              // r + MG1
    sw   x4, __SMOUT._numerator_0(x2)

.EXPCAL
    addi4spn x7, 30                              // x7 = shift num
    mv x9,x3
    addi4spn x4, 9
    nop
    fxmul x4,x4,x9                               // r*r>>30, x9 = tmp1
    nop                                         
    mv x4, x9                                   // x4 = tmp2
    srli x4,x4,1          
    mv x8, x4
    lw   x4, __SMOUT._numerator_0(x2)
    add  x4, x4, x8                             // 1+ x + 1/2 x^2
    sw   x4, __SMOUT._numerator_0(x2)

    addi4spn x4, 9                           
    nop
    fxmul x4,x4,x3                               // tmp1*r>>30, x9 = tmp1
    addi4spn x4, 11
    mv x11, x9                                   // x11 = tmp2
    fxmul x4,x4,x14                               // tmp2*MG6>>30, x11 = tmp2
    lw   x4, __SMOUT._numerator_0(x2)
    add  x4, x4, x11                             // 1+ x + 1/2 x^2 + 1/6 * x^3
    sw   x4, __SMOUT._numerator_0(x2)

    addi4spn x4, 9                           
    nop
    fxmul x4,x4,x3                               // tmp1*r>>30, x9 = tmp1
    addi4spn x4, 11
    mv x11, x9                                   // x11 = tmp2
    fxmul x4,x4,x15                              // tmp2*MG24>>30, x11 = tmp2
    lw   x4, __SMOUT._numerator_0(x2)
    add  x4, x4, x11                             // 1+ x + 1/2 x^2 + 1/6 * x^3 + 1/24 * x^4
    sw   x4, __SMOUT._numerator_0(x2)

    addi4spn x3, `SOFTMAX_StackBase
    lw x4, __SMOUT._ln2_p(x3)
    addi4spn x7, 32
    sub x7, x7, x4
    lw x4, __SMOUT._numerator_0(x2)
    srl x4, x4, x7
    sw x4, __SMOUT._numerator_0(x2)


.EXPCAL_LOOPCTL
    addi  x2, x2, 1
    addi  x5,x5,-1
    addi  x6,x6, 1
    beqz  x5, .DENOMINATOR
    j .SOFTINIT

.DENOMINATOR
    addi4spn x2, `SOFTMAX_StackBase
    addi4spn x5, 9                               // out activate and loop
    addi4spn x3, 0
.DENOMINATOR_LOOP
    lw x4, __SMOUT._numerator_0(x2)
    add x3,x3,x4

    addi  x2, x2, 1
    addi  x5,x5,-1
    beqz  x5, .POSTPROCESS
    j .DENOMINATOR_LOOP

.POSTPROCESS
    sw x3, __SMOUT._denominator(x2)

    // ------------- 标识位， softmax finished = 26 -------------------
    addi4spn x1, 26                                 // layer finish
    addi4spn x1, 0                                  // layer finish
    // --------------------------------------------------------------
    //addi4spn x2, `TOPCTRL_StackBase                 // initial
    //addi4spn x5, 7                  
    //sw x5, __TOPCTRL._max_index_last(x2)
    //sw x5, __TOPCTRL._max_index_now(x2)

.POST_PROCESS_START
    addi4spn x2, `TOPCTRL_StackBase
    addi4spn x5, 0
    addi x5, x5, -1
    sw x5, __TOPCTRL._kws_output(x2)     // init kws output = -1

    addi4spn x2, `SOFTMAX_StackBase
    addi4spn x5, 0                       // max_index now
    lw x6, __SMOUT._numerator_0(x2)      // max_value now
    addi4spn x3, 6
    addi4spn x8, 1

  .FIND_MAX_OUTPUTVALUE
    addi x2, x2, 1             
    lw x7, __SMOUT._numerator_0(x2)      
    mv x4, x7
    sub x7, x7, x6 
    bltz x7, 3
    mv x6, x4                            // numerator[i] > max value 这个地方C代码需要改动一下变成>=
    mv x5, x8

    addi x2,x2,1
    addi x8,x8,1
    addi x3,x3,-1
    bnez x3, .FIND_MAX_OUTPUTVALUE

    addi4spn x2, `TOPCTRL_StackBase
    sw x5, __TOPCTRL._max_index_now(x2)
    sw x6, __TOPCTRL._max_value_now(x2)

    mv x3, x5
    addi x3, x3, -7
    bltz x3, 2
    j .UPDATE_WAKE_CNT
    addi4spn x2, `KWSCONFIG_StackBase
    add x2, x2, x5                          // max index 
    lw x4, __KWS_CONFIG._kwscfg_threshold_0(x2)      // max index corrsbanding thre
    addi x4, x4, 1
    addi4spn x2, `SOFTMAX_StackBase
    lw x3, __SMOUT._denominator(x2)  
    addi4spn x7, 8
    addi x2, x2, 4
    nop
    fxmul x2, x2, x3
    nop
    sub x6, x6, x4
    bltz x6, 2
    j .UPDATE_WAKE_CNT
    addi4spn x5, 7            // out lt thre, is unknown word
    addi4spn x2, `TOPCTRL_StackBase
    sw x5, __TOPCTRL._max_index_now(x2)
.UPDATE_WAKE_CNT
    mv x3, x5
    addi x3, x3, -7
    bltz x3, 2
    j .CLEAR_WAKE_CNT
    addi4spn x2, `TOPCTRL_StackBase
    lw x4, __TOPCTRL._wake_count(x2)
    lw x7, __TOPCTRL._max_index_last(x2)                // max index last
    sub x7, x7, x5
    bnez x7, 2
    addi x4, x4, 1
    addi4spn x4, 1
  .CLEAR_WAKE_CNT
    addi4spn x4, 0
    sw x4, __TOPCTRL._wake_count(x2)

    addi4spn x2, `KWSCONFIG_StackBase
    addi4spn x3, `TOPCTRL_StackBase
    bnez x5 , .ELSE_EVANUM1                                         // if max index now ==0
    lw x7, __KWS_CONFIG._kwscfg_eva_num_group_0(x2)     // load evanum0
    sub x4, x4, x7
    bnez x4,  .UPDATE_MAX_VALUE_LAST                                // if wake count == evanum0
    sw x5, __TOPCTRL._kws_output(x3)
    lw x7, __KWS_CONFIG._kwscfg_block_num_group_0(x2)
    sw x7, __TOPCTRL._block_count(x3)
    addi4spn x7, 0
    sw x7, __TOPCTRL._wake_count(x3)
  .ELSE_EVANUM1
    lw x7, __KWS_CONFIG._kwscfg_eva_num_group_1(x2)     // load evanum1
    sub x4, x4, x7
    bnez x4,  .UPDATE_MAX_VALUE_LAST                                // if wake count == evanum1
    sw x5, __TOPCTRL._kws_output(x3)
    lw x7, __KWS_CONFIG._kwscfg_block_num_group_1(x2)
    sw x7, __TOPCTRL._block_count(x3)
    addi4spn x7, 0
    sw x7, __TOPCTRL._wake_count(x3)

.UPDATE_MAX_VALUE_LAST
    sw x5, __TOPCTRL._max_index_last(x3)                // max index last = max index now
    // ------------- 标识位， post process finished = 27 -------------------
    addi4spn x1, 27                                 // layer finish
    addi4spn x1, 0                                  // layer finish
    // --------------------------------------------------------------
.NN_END
    nop
    ebreak



.CONV1
lw x4 2(x2) 
.C1LOADBIAS
lw x6 3(x2) 
lv v8 0(x6)
addi x6 x6 1
lv v12 0(x6)
addi x6 x6 1
lv v16 0(x6)
addi x6 x6 1
lv v20 0(x6)
addi x6 x6 1
sw x6 3(x2)
lw x3 0(x2) 
lw x5 5(x2) 
.INNERLOOP
addi4spn x6 16 
addi4spn x7 16 
lv v0 0(x3) 
addi x3 x3 1
.MULSUM16
lv v4 0(x4)
addi x4 x4 1 
vmulsum x7 x7 v0
addi x7 x7 1
addi x6 x6 -1
bnez x6 .MULSUM16
nop
addi x5 x5 -1
bnez x5 .INNERLOOP
nop
.CQUANT16
lw x6 4(x2) 
lv v0 0(x6) 
addi4spn x6 16 
addi4spn x5 16 
.C1RELU
mv x7 x10
fmsr x6 x6 x9
addi4spn x7 255
addx x6 x6 x8
min x6 x6 x7
addi4spn x7 0
max x6 x6 x7
addi x6 x6 1
addi x5 x5 -1
bnez x5 .C1RELU
.C1STORE16
lw x5 1(x2) 
sv1 x0 0(x5)
addi x5 x5 1
sw x5 1(x2) 
.C1CHECKOUTLOOP 
lw x5 6(x2) 
addi x5 x5 -1
bnez x5 2
jr x1
sw x5 6(x2)
j .C1LOADBIAS
.DEPTHWISE_CONV_FUN
lw x3 0(x2) 
lw x4 1(x2) 
.DW_LOADBIAS
lw x6 3(x2) 
lv v8 0(x6)
addi x6 x6 1
lv v12 0(x6)
addi x6 x6 1
lv v16 0(x6)
addi x6 x6 1
lv v20 0(x6)
addi x6 x6 1
sw x6 3(x2)
lw x5 2(x2) 
.DWINNERLOOP
lv v0 0(x3) 
mv x7 x3
lw x6 7(x2) 
sub x7 x7 x6
beqz x7 .DWIFMAP_RETURN_START
addi x3 x3 3 
j .DW_LOAD_WEIGHT
.DWIFMAP_RETURN_START
lw x3 6(x2) 
.DW_LOAD_WEIGHT
lv v4 0(x4) 
addi x4 x4 3 
addi4spn x7 16 
addi4spn x6 16 
.DWMACC8
vmac8 x7 x7 x7
addi x7 x7 1
addi x6 x6 -1
bnez x6 .DWMACC8
nop
addi x5 x5 -1
bnez x5 .DWINNERLOOP
nop
.DW_QUANT16
lw x6 4(x2) 
lv v0 0(x6) 
addi4spn x6 16 
addi4spn x5 16 
.DW_RELU
mv x7 x10 
fmsr x6 x6 x9
addi4spn x7 255
addx x6 x6 x8
min x6 x6 x7
addi4spn x7 0
max x6 x6 x7
addi x6 x6 1
addi x5 x5 -1
bnez x5 .DW_RELU
.DW_STORE16
lw x5 5(x2) 
sv1 x0 0(x5)
addi x5 x5 1
sw x5 5(x2) 
.DW_CHECKOUTLOOP 
lw x5 8(x2) 
addi x5 x5 -1
bnez x5 2
jr x1
sw x5 8(x2)
lw x5 7(x2) 
addi x5 x5 1
sw x5 7(x2) 
lw x5 6(x2) 
addi x5 x5 1
sw x5 6(x2) 
lw x3 0(x2) 
addi x3 x3 1
sw x3 0(x2) 
lw x4 1(x2) 
addi x4 x4 1
sw x4 1(x2) 
j .DW_LOADBIAS
.SKIP_ADD_FUNCTION
lw x3 2(x2) 
lv v0 0(x3)
nop 
nop
mv x4 x11 
mv x5 x9 
mv x6 x10 
mv x7 x8 
lw x3 0(x2)
lv v0 0(x3)
lw x3 1(x2)
lv v4 0(x3)
addi4spn x3 16
.SKIP_ADD_LOOP_16
addi x3 x3 -1
nop 
skipadd x3 x3 x5
bnez x3 .SKIP_ADD_LOOP_16
addi4spn x3 16
addi4spn x5 16
.SKIP_ADD_RELU_16
addi4spn x7 255
addx x3 x3 x4
min x3 x3 x7
addi4spn x7 0
max x3 x3 x7
addi x3 x3 1
addi x5 x5 -1
bnez x5 .SKIP_ADD_RELU_16
lw x3 1(x2)
sv1 x0 0(x3)
addi x3 x3 1
sw x3 1(x2)
jr x1
.MAIN
addi4spn x2 37 
lw x3 4(x2)
addi x3 x3 -1
addi4spn x4 3
addi4spn x5 0
max x4 x4 x5
nop
sw x3 4(x2)
beqz x3 2 
j .NN_END
addi4spn x1 0 
addi4spn x2 0
mvimmx4 x4 128 
sw x4 0(x2)
mvimmx4 x4 248 
sw x4 1(x2)
mvimmx4 x4 444 
sw x4 3(x2)
mvimmx4 x4 456 
sw x4 4(x2)
mvimmx4 x4 4 
sw x4 5(x2)
mvimmx4 x4 59
sw x4 7(x2) 
mvimmx4 x4 380 
sw x4 2(x2)
.CONV1DO
mvimmx4 x4 1 
sw x4 6(x2)
jal x1 .CONV1
lw x4 7(x2) 
beqz x4 .IBB1
addi x4 x4 -1
sw x4 7(x2) 
.CHECKOUTX
beqz x4 .LASTLINECONV
addi4spn x5 58
sub x4 x4 x5
beqz x4 .SECONDLINECONV
mvimmx4 x4 448 
sw x4 3(x2) 
lw x4 0(x2) 
addi x4 x4 2
sw x4 0(x2)
j .CONV1DO 
.LASTLINECONV
mvimmx4 x4 452 
sw x4 3(x2)
mvimmx4 x4 4 
sw x4 5(x2)
lw x4 0(x2) 
addi x4 x4 2
sw x4 0(x2)
j .CONV1DO
.SECONDLINECONV 
mvimmx4 x4 448
sw x4 3(x2) 
mvimmx4 x4 348 
sw x4 2(x2)
mvimmx4 x4 128 
sw x4 0(x2)
mvimmx4 x4 6 
sw x4 5(x2)
j .CONV1DO
.IBB1
addi4spn x1 1 
addi4spn x1 0 
addi4spn x2 17 
mvimmx4 x4 632 
sw x4 2(x2)
mvimmx4 x4 335
sw x4 0(x2)
mvimmx4 x4 248
sw x4 1(x2)
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 0
sw x4 4(x3)
mvimmx4 x4 248
addi x4 x4 -1 
sw x4 0(x3)
mvimmx4 x4 308 
addi x4 x4 -3 
sw x4 1(x3)
mvimmx4 x4 0
sw x4 2(x3) 
mvimmx4 x4 308
sw x4 3(x3) 
.IBB1_C1ANDSKIP_CONV
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 505 
sw x4 3(x2)
mvimmx4 x4 517 
sw x4 4(x2)
mvimmx4 x4 1 
sw x4 5(x2)
mvimmx4 x4 457 
sw x4 2(x2)
mvimmx4 x4 3 
sw x4 6(x2)
lw x4 0(x3)
addi x4 x4 1
sw x4 0(x3)
sw x4 0(x2)
lw x5 1(x3)
addi x5 x5 3
mv x6 x5
mvimmx4 x4 335 
sub x5 x5 x4
bnez x5 3 
mvimmx4 x4 308
mv x6 x4
sw x6 1(x2)
sw x6 1(x3) 
jal x1 .CONV1
addi4spn x1 2 
addi4spn x1 0 
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 627 
sw x4 3(x2)
mvimmx4 x4 631 
sw x4 4(x2)
mvimmx4 x4 611 
sw x4 2(x2)
mvimmx4 x4 1 
sw x4 6(x2)
lw x4 0(x3) 
sw x4 0(x2)
mv x5 x4
mvimmx4 x4 248
sub x5 x5 x4
srli x5 x5 1 
add x4 x4 x5
sw x4 1(x2)
jal x1 .CONV1
addi4spn x1 3 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 1
sw x4 4(x3)
j .IBB1_LOOP_CTRL
.IBB1_C1_CONV_ALONE
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 505 
sw x4 3(x2)
mvimmx4 x4 517 
sw x4 4(x2)
mvimmx4 x4 1 
sw x4 5(x2)
mvimmx4 x4 457 
sw x4 2(x2)
mvimmx4 x4 3 
sw x4 6(x2)
lw x4 0(x3)
addi x4 x4 1
sw x4 0(x3)
sw x4 0(x2)
lw x5 1(x3)
addi x5 x5 3
mv x6 x5
mvimmx4 x4 335 
sub x5 x5 x4
bnez x5 3 
mvimmx4 x4 308
mv x6 x4
sw x6 1(x2)
sw x6 1(x3) 
jal x1 .CONV1
addi4spn x1 2 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -30
bnez x5 .IBB1_C1ANDSKIP_CONV 
addi x4 x4 1
sw x4 4(x3)
.IBB1_LOOP_CTRL
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 -3
bltz x4 .IBB1_C1_CONV_ALONE
addi x4 x4 -3 
bltz x4 .IBB1_DW_WIDTH_LTE9 
addi x4 x4 -25
bltz x4 .IBB1_DW_NORMAL_25 
addi x4 x4 -2
bltz x4 .IBB1_DW_WIDTH_GT27 
j .IBB2
.IBB1_DW_WIDTH_LTE9 
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
slli x4 x4 1
addi x4 x4 -1 
sw x4 2(x2) 
mv x6 x4 
mvimmx4 x4 308
sw x4 0(x2) 
addi4spn x7 9
sub x7 x7 x6 
mv x5 x7
slli x7 x7 1 
add x7 x7 x5 
mvimmx4 x4 518
add x4 x4 x7 
sw x4 1(x2) 
j .IBB1_DWCONV_MAIN
.IBB1_DW_NORMAL_25
addi4spn x2 8 
addi4spn x4 9
sw x4 2(x2) 
mvimmx4 x4 518
sw x4 1(x2) 
j .IBB1_CHECK_DW_IFMAP_POINT
.IBB1_DW_WIDTH_GT27
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
addi4spn x5 70
slli x4 x4 1
sub x5 x5 x4 
sw x5 2(x2) 
mvimmx4 x4 518
sw x4 1(x2) 
j .IBB1_CHECK_DW_IFMAP_POINT
.IBB1_CHECK_DW_IFMAP_POINT
addi4spn x2 8 
addi4spn x3 21
lw x4 3(x3) 
mv x5 x4
addi x5 x5 6
mv x6 x5
mvimmx4 x4 335
sub x5 x5 x4 
bltz x5 .IBB1_UPDATA_DW_IFMAP_POINT 
mvimmx4 x4 308
add x4 x4 x5
mv x6 x4
.IBB1_UPDATA_DW_IFMAP_POINT
sw x6 3(x3) 
sw x6 0(x2) 
.IBB1_DWCONV_MAIN
mvimmx4 x4 545 
sw x4 3(x2)
mvimmx4 x4 557
sw x4 4(x2)
mvimmx4 x4 335
sw x4 5(x2)
mvimmx4 x4 3
sw x4 8(x2) 
mvimmx4 x4 308
sw x4 6(x2)
mvimmx4 x4 332
sw x4 7(x2) 
jal x1 .DEPTHWISE_CONV_FUN
addi4spn x1 4 
addi4spn x1 0 
.IBB1_CONV2_MAIN
addi4spn x2 0
mvimmx4 x4 606 
sw x4 3(x2)
mvimmx4 x4 610 
sw x4 4(x2)
mvimmx4 x4 3 
sw x4 5(x2)
mvimmx4 x4 558 
sw x4 2(x2)
mvimmx4 x4 1 
sw x4 6(x2)
mvimmx4 x4 335 
sw x4 0(x2)
mvimmx4 x4 335 
sw x4 1(x2)
jal x1 .CONV1
addi4spn x1 5 
addi4spn x1 0 
.IBB1_SKIP_ADD
addi4spn x2 17
jal x1 .SKIP_ADD_FUNCTION
addi4spn x1 6 
addi4spn x1 0 
.IBB1_TAIL_CONTROL
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -31 
bltz x5 .TO_IBB1_C1_ALONE 
addi x4 x4 1 
sw x4 4(x3)
j .IBB1_LOOP_CTRL
.TO_IBB1_C1_ALONE
j .IBB1_C1_CONV_ALONE
.IBB2
addi4spn x1 7 
addi4spn x1 0 
addi4spn x2 17 
mvimmx4 x4 787 
sw x4 2(x2)
mvimmx4 x4 335
sw x4 0(x2)
mvimmx4 x4 248
sw x4 1(x2)
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 0
sw x4 4(x3)
mvimmx4 x4 248
addi x4 x4 -1 
sw x4 0(x3)
mvimmx4 x4 308 
addi x4 x4 -3 
sw x4 1(x3)
mvimmx4 x4 0
sw x4 2(x3) 
mvimmx4 x4 308
sw x4 3(x3) 
.IBB2_LOOPMAIN
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -5 
bltz x5 .IBB2_C1 
addi x5 x5 -5 
bltz x5 .IBB2_DW_WIDTH_LTE9 
addi x5 x5 -21
bltz x5 .IBB2_DW_NORMAL_21 
addi x5 x5 -4
bltz x5 .IBB2_DW_WIDTH_GT21 
j .IBB3
.IBB2_C1
addi4spn x2 0
mvimmx4 x4 681 
sw x4 3(x2)
mvimmx4 x4 693 
sw x4 4(x2)
mvimmx4 x4 633 
sw x4 2(x2)
mvimmx4 x4 3 
sw x4 6(x2)
mvimmx4 x4 1 
sw x4 5(x2)
addi4spn x3 21
lw x4 0(x3)
addi x4 x4 1
sw x4 0(x3)
sw x4 0(x2)
lw x5 1(x3)
addi x5 x5 3
mv x6 x5
mvimmx4 x4 335 
sub x5 x5 x4
bnez x5 3 
mvimmx4 x4 308
mv x6 x4
sw x6 1(x2)
sw x6 1(x3) 
jal x1 .CONV1
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 1
sw x4 4(x3)
addi4spn x1 8 
addi4spn x1 0 
j .IBB2_LOOPMAIN
.IBB2_DW_WIDTH_LTE9 
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
sw x4 2(x2) 
mv x6 x4 
mvimmx4 x4 308
sw x4 0(x2) 
addi4spn x7 9
sub x7 x7 x6 
mv x5 x7
slli x7 x7 1 
add x7 x7 x5 
mvimmx4 x4 694
add x4 x4 x7 
sw x4 1(x2) 
j .IBB2_DWCONV_MAIN
.IBB2_DW_NORMAL_21 
addi4spn x2 8 
addi4spn x4 9
sw x4 2(x2) 
mvimmx4 x4 694
sw x4 1(x2) 
j .IBB2_CHECK_DW_IFMAP_POINT
.IBB2_DW_WIDTH_GT21
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
addi4spn x5 39
sub x5 x5 x4 
sw x5 2(x2) 
mvimmx4 x4 694
sw x4 1(x2) 
j .IBB2_CHECK_DW_IFMAP_POINT
.IBB2_CHECK_DW_IFMAP_POINT
addi4spn x2 8 
addi4spn x3 21
lw x4 3(x3) 
mv x5 x4
mvimmx4 x4 332
sub x5 x5 x4 
bnez x5 3 
mvimmx4 x4 308
j .IBB2_UPDATA_DW_IFMAP_POINT
lw x4 3(x3) 
addi x4 x4 3
.IBB2_UPDATA_DW_IFMAP_POINT
sw x4 3(x3) 
sw x4 0(x2) 
.IBB2_DWCONV_MAIN
mvimmx4 x4 721 
sw x4 3(x2)
mvimmx4 x4 733
sw x4 4(x2)
mvimmx4 x4 335
sw x4 5(x2)
mvimmx4 x4 3
sw x4 8(x2) 
mvimmx4 x4 308
sw x4 6(x2)
mvimmx4 x4 332
sw x4 7(x2) 
jal x1 .DEPTHWISE_CONV_FUN
addi4spn x1 9 
addi4spn x1 0 
.IBB2_CONV2_MAIN
addi4spn x2 0
mvimmx4 x4 782 
sw x4 3(x2)
mvimmx4 x4 786 
sw x4 4(x2)
mvimmx4 x4 3 
sw x4 5(x2)
mvimmx4 x4 734 
sw x4 2(x2)
mvimmx4 x4 1 
sw x4 6(x2)
mvimmx4 x4 335 
sw x4 0(x2)
mvimmx4 x4 335 
sw x4 1(x2)
jal x1 .CONV1
addi4spn x1 10 
addi4spn x1 0 
.IBB2_SKIP_ADD
addi4spn x2 17
jal x1 .SKIP_ADD_FUNCTION
addi4spn x1 11 
addi4spn x1 0 
.IBB2_TAIL_CONTROL
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -30 
bltz x5 .IBB2_C1 
addi x4 x4 1 
sw x4 4(x3)
j .IBB2_LOOPMAIN
.IBB3
addi4spn x1 12 
addi4spn x1 0 
addi4spn x2 17 
mvimmx4 x4 963 
sw x4 2(x2)
mvimmx4 x4 335
sw x4 0(x2)
mvimmx4 x4 248
sw x4 1(x2)
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 0
sw x4 4(x3)
mvimmx4 x4 248
addi x4 x4 -1 
sw x4 0(x3)
mvimmx4 x4 308 
addi x4 x4 -3 
sw x4 1(x3)
mvimmx4 x4 0
sw x4 2(x3) 
mvimmx4 x4 308
sw x4 3(x3) 
.IBB3_C1ANDSKIP_CONV
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 836 
sw x4 3(x2)
mvimmx4 x4 848 
sw x4 4(x2)
mvimmx4 x4 1 
sw x4 5(x2)
mvimmx4 x4 788 
sw x4 2(x2)
mvimmx4 x4 3 
sw x4 6(x2)
lw x4 0(x3)
addi x4 x4 1
sw x4 0(x3)
sw x4 0(x2)
lw x5 1(x3)
addi x5 x5 3
mv x6 x5
mvimmx4 x4 335 
sub x5 x5 x4
bnez x5 3 
mvimmx4 x4 308
mv x6 x4
sw x6 1(x2)
sw x6 1(x3) 
jal x1 .CONV1
addi4spn x1 13 
addi4spn x1 0 
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 958 
sw x4 3(x2)
mvimmx4 x4 962 
sw x4 4(x2)
mvimmx4 x4 942 
sw x4 2(x2)
mvimmx4 x4 1 
sw x4 6(x2)
lw x4 0(x3) 
sw x4 0(x2)
mv x5 x4
mvimmx4 x4 248
sub x5 x5 x4
srli x5 x5 1 
add x4 x4 x5
sw x4 1(x2)
jal x1 .CONV1
addi4spn x1 14 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 1
sw x4 4(x3)
j .IBB3_LOOP_CTRL
.IBB3_C1_CONV_ALONE
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 836 
sw x4 3(x2)
mvimmx4 x4 848 
sw x4 4(x2)
mvimmx4 x4 1 
sw x4 5(x2)
mvimmx4 x4 788 
sw x4 2(x2)
mvimmx4 x4 3 
sw x4 6(x2)
lw x4 0(x3)
addi x4 x4 1
sw x4 0(x3)
sw x4 0(x2)
lw x5 1(x3)
addi x5 x5 3
mv x6 x5
mvimmx4 x4 335 
sub x5 x5 x4
bnez x5 3 
mvimmx4 x4 308
mv x6 x4
sw x6 1(x2)
sw x6 1(x3) 
jal x1 .CONV1
addi4spn x1 13 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -15
bnez x5 .IBB3_C1ANDSKIP_CONV 
addi x4 x4 1
sw x4 4(x3)
.IBB3_LOOP_CTRL
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 -3
bltz x4 .IBB3_C1_CONV_ALONE
addi x4 x4 -3 
bltz x4 .IBB3_DW_WIDTH_LTE9 
addi x4 x4 -10
bltz x4 .IBB3_DW_NORMAL_10 
addi x4 x4 -2
bltz x4 .IBB3_DW_WIDTH_GT10 
j .IBB4
.IBB3_DW_WIDTH_LTE9 
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
slli x4 x4 1
addi x4 x4 -1 
sw x4 2(x2) 
mv x6 x4 
mvimmx4 x4 308
sw x4 0(x2) 
addi4spn x7 9
sub x7 x7 x6 
mv x5 x7
slli x7 x7 1 
add x7 x7 x5 
mvimmx4 x4 849
add x4 x4 x7 
sw x4 1(x2) 
j .IBB3_DWCONV_MAIN
.IBB3_DW_NORMAL_10
addi4spn x2 8 
addi4spn x4 9
sw x4 2(x2) 
mvimmx4 x4 849
sw x4 1(x2) 
j .IBB3_CHECK_DW_IFMAP_POINT
.IBB3_DW_WIDTH_GT10
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
addi4spn x5 40
slli x4 x4 1
sub x5 x5 x4 
sw x5 2(x2) 
mvimmx4 x4 849
sw x4 1(x2) 
j .IBB3_CHECK_DW_IFMAP_POINT
.IBB3_CHECK_DW_IFMAP_POINT
addi4spn x2 8 
addi4spn x3 21
lw x4 3(x3) 
mv x5 x4
addi x5 x5 6
mv x6 x5
mvimmx4 x4 335
sub x5 x5 x4 
bltz x5 .IBB3_UPDATA_DW_IFMAP_POINT 
mvimmx4 x4 308
add x4 x4 x5
mv x6 x4
.IBB3_UPDATA_DW_IFMAP_POINT
sw x6 3(x3) 
sw x6 0(x2) 
.IBB3_DWCONV_MAIN
mvimmx4 x4 876 
sw x4 3(x2)
mvimmx4 x4 888
sw x4 4(x2)
mvimmx4 x4 335
sw x4 5(x2)
mvimmx4 x4 3
sw x4 8(x2) 
mvimmx4 x4 308
sw x4 6(x2)
mvimmx4 x4 332
sw x4 7(x2) 
jal x1 .DEPTHWISE_CONV_FUN
addi4spn x1 15 
addi4spn x1 0 
.IBB3_CONV2_MAIN
addi4spn x2 0
mvimmx4 x4 937 
sw x4 3(x2)
mvimmx4 x4 941 
sw x4 4(x2)
mvimmx4 x4 3 
sw x4 5(x2)
mvimmx4 x4 889 
sw x4 2(x2)
mvimmx4 x4 1 
sw x4 6(x2)
mvimmx4 x4 335 
sw x4 0(x2)
mvimmx4 x4 335 
sw x4 1(x2)
jal x1 .CONV1
addi4spn x1 16 
addi4spn x1 0 
.IBB3_SKIP_ADD
addi4spn x2 17
jal x1 .SKIP_ADD_FUNCTION
addi4spn x1 17 
addi4spn x1 0 
.IBB3_TAIL_CONTROL
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -16 
bltz x5 .TO_IBB3_C1_ALONE 
addi x4 x4 1 
sw x4 4(x3)
j .IBB3_LOOP_CTRL
.TO_IBB3_C1_ALONE
j .IBB3_C1_CONV_ALONE
.IBB4
addi4spn x1 18 
addi4spn x1 0 
addi4spn x2 17 
mvimmx4 x4 1118 
sw x4 2(x2)
mvimmx4 x4 335
sw x4 0(x2)
mvimmx4 x4 248
sw x4 1(x2)
addi4spn x2 0
addi4spn x3 21
mvimmx4 x4 0
sw x4 4(x3)
mvimmx4 x4 248
addi x4 x4 -1 
sw x4 0(x3)
mvimmx4 x4 308 
addi x4 x4 -3 
sw x4 1(x3)
mvimmx4 x4 0
sw x4 2(x3) 
mvimmx4 x4 308
sw x4 3(x3) 
.IBB4_LOOPMAIN
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -5 
bltz x5 .IBB4_C1 
addi x5 x5 -5 
bltz x5 .IBB4_DW_WIDTH_LTE9 
addi x5 x5 -6
bltz x5 .IBB4_DW_NORMAL_6 
addi x5 x5 -4
bltz x5 .IBB4_DW_WIDTH_GT6 
j .AVGPOOL
.IBB4_C1
addi4spn x2 0
mvimmx4 x4 1012 
sw x4 3(x2)
mvimmx4 x4 1024 
sw x4 4(x2)
mvimmx4 x4 964 
sw x4 2(x2)
mvimmx4 x4 3 
sw x4 6(x2)
mvimmx4 x4 1 
sw x4 5(x2)
addi4spn x3 21
lw x4 0(x3)
addi x4 x4 1
sw x4 0(x3)
sw x4 0(x2)
lw x5 1(x3)
addi x5 x5 3
mv x6 x5
mvimmx4 x4 335 
sub x5 x5 x4
bnez x5 3 
mvimmx4 x4 308
mv x6 x4
sw x6 1(x2)
sw x6 1(x3) 
jal x1 .CONV1
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 1
sw x4 4(x3)
addi4spn x1 19 
addi4spn x1 0 
j .IBB4_LOOPMAIN
.IBB4_DW_WIDTH_LTE9 
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
sw x4 2(x2) 
mv x6 x4 
mvimmx4 x4 308
sw x4 0(x2) 
addi4spn x7 9
sub x7 x7 x6 
mv x5 x7
slli x7 x7 1 
add x7 x7 x5 
mvimmx4 x4 1025
add x4 x4 x7 
sw x4 1(x2) 
j .IBB4_DWCONV_MAIN
.IBB4_DW_NORMAL_6 
addi4spn x2 8 
addi4spn x4 9
sw x4 2(x2) 
mvimmx4 x4 1025
sw x4 1(x2) 
j .IBB4_CHECK_DW_IFMAP_POINT
.IBB4_DW_WIDTH_GT6
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
addi4spn x5 24
sub x5 x5 x4 
sw x5 2(x2) 
mvimmx4 x4 1025
sw x4 1(x2) 
j .IBB4_CHECK_DW_IFMAP_POINT
.IBB4_CHECK_DW_IFMAP_POINT
addi4spn x2 8 
addi4spn x3 21
lw x4 3(x3) 
mv x5 x4
mvimmx4 x4 332
sub x5 x5 x4 
bnez x5 3 
mvimmx4 x4 308
j .IBB4_UPDATA_DW_IFMAP_POINT
lw x4 3(x3) 
addi x4 x4 3
.IBB4_UPDATA_DW_IFMAP_POINT
sw x4 3(x3) 
sw x4 0(x2) 
.IBB4_DWCONV_MAIN
mvimmx4 x4 1052 
sw x4 3(x2)
mvimmx4 x4 1064
sw x4 4(x2)
mvimmx4 x4 335
sw x4 5(x2)
mvimmx4 x4 3
sw x4 8(x2) 
mvimmx4 x4 308
sw x4 6(x2)
mvimmx4 x4 332
sw x4 7(x2) 
jal x1 .DEPTHWISE_CONV_FUN
addi4spn x1 20 
addi4spn x1 0 
.IBB4_CONV2_MAIN
addi4spn x2 0
mvimmx4 x4 1113 
sw x4 3(x2)
mvimmx4 x4 1117 
sw x4 4(x2)
mvimmx4 x4 3 
sw x4 5(x2)
mvimmx4 x4 1065 
sw x4 2(x2)
mvimmx4 x4 1 
sw x4 6(x2)
mvimmx4 x4 335 
sw x4 0(x2)
mvimmx4 x4 335 
sw x4 1(x2)
jal x1 .CONV1
addi4spn x1 21 
addi4spn x1 0 
.IBB4_SKIP_ADD
addi4spn x2 17
jal x1 .SKIP_ADD_FUNCTION
addi4spn x1 22 
addi4spn x1 0 
.IBB4_TAIL_CONTROL
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -15 
bltz x5 .IBB4_C1 
addi x4 x4 1 
sw x4 4(x3)
j .IBB4_LOOPMAIN
.AVGPOOL
addi4spn x1 23 
addi4spn x1 0 
luil8 x4 0
mv x16 x4
mv x17 x4
mv x18 x4
mv x19 x4
mv x20 x4
mv x21 x4
mv x22 x4
mv x23 x4
mv x24 x4
mv x25 x4
mv x26 x4
mv x27 x4
mv x28 x4
mv x29 x4
mv x30 x4
mv x31 x4
mvimmx4 x4 257 
slli x4 x4 8 
addi x4 x4 1 
slli x4 x4 8 
addi x4 x4 1 
mv x12 x4
mv x13 x4
mv x14 x4
mv x15 x4
mvimmx4 x4 248 
addi4spn x5 15
.AVGPOOL_LOAD_IFMAP
lv v0 0(x4) 
addi x4 x4 1 
addi4spn x7 16 
addi4spn x6 16 
.AVGMACC8
vmac8 x7 x7 x7
addi x7 x7 1
addi x6 x6 -1
bnez x6 .AVGMACC8
addi x5 x5 -1
bnez x5 .AVGPOOL_LOAD_IFMAP
.AVG_QUANT16
mvimmx4 x4 1119
lv v0 0(x4) 
addi4spn x6 16 
addi4spn x5 16 
mv x7 x10 
.AVG_RTE
fmsr x6 x6 x9
addx x6 x6 x8
addi x6 x6 1
addi x5 x5 -1
bnez x5 .AVG_RTE
mvimmx4 x4 248
sv1 x0 0(x4)
.LINEAR
addi4spn x1 24 
addi4spn x1 0 
mvimmx4 x4 1129
lv v8 0(x4)
addi x4 x4 1
lv v12 0(x4)
addi x4 x4 1
lv v16 0(x4)
addi x4 x4 1
lv v20 0(x4)
addi x4 x4 1
addi4spn x6 9 
addi4spn x7 16 
mvimmx4 x4 248 
lv v0 0(x4) 
mvimmx4 x4 1120 
.LINEAR_MULSUM16
lv v4 0(x4)
addi x4 x4 1 
vmulsum x7 x7 v0
addi x7 x7 1
addi x6 x6 -1
bnez x6 .LINEAR_MULSUM16
.LINEAR_CQUANT16
mvimmx4 x4 1132 
lv v0 0(x4) 
addi4spn x6 16 
addi4spn x5 9 
.LINEAR_C1RELU
mv x7 x10
fmsr x6 x6 x9
addi4spn x7 255
addx x6 x6 x8
min x6 x6 x7
addi4spn x7 0
max x6 x6 x7
addi x6 x6 1
addi x5 x5 -1
bnez x5 .LINEAR_C1RELU
mvimmx4 x4 248 
sv1 x0 0(x4)
.SOFTMAX
addi4spn x1 25 
addi4spn x1 0 
mvimmx4 x4 1133
lv v0 0(x4)
addi x4 x4 1
lv v4 0(x4)
mv x4 x8
srai x4 x4 9
addi4spn x5 9 
addi4spn x6 16
addi4spn x7 0 
.SM_DEQUANT_LOOP
subx x6 x6 x9
nop
fxmul x6 x6 x4
addi x5 x5 -1
addi x6 x6 1
bnez x5 .SM_DEQUANT_LOOP
addi4spn x3 7 
mv x7 x16
addi4spn x6 17
addi4spn x5 8
.FIND_MAX_ONE
mvx x4 x6
nop
max x3 x3 x4
addi x5 x5 -1
addi x6 x6 1
bnez x5 .FIND_MAX_ONE
addi4spn x6 16
addi4spn x5 9 
.MINUSMAX_LOOP
subx x6 x6 x7
nop
addx x6 x6 x11
nop
max x6 x6 x0
addi x5 x5 -1
addi x6 x6 1
bnez x5 .MINUSMAX_LOOP
addi4spn x2 26
addi4spn x5 9 
addi4spn x6 16
.SOFTINIT 
addi4spn x3 0
.FINDQ_LOOP
subx x6 x6 x10 
nop
mvx x4 x6
bltz x4 .DIV_END
addi x3 x3 1
j .FINDQ_LOOP
.DIV_END
addi4spn x7 26
sw x3 0(x7)
add x4 x4 x10 
bnez x4 4 
mv x4 x12 
sw x4 1(x2)
j .EXPCAL_LOOPCTL 
slli x4 x4 7 
mv x3 x4 
mv x8 x12
add x4 x4 x8 
sw x4 1(x2)
.EXPCAL
addi4spn x7 30 
mv x9 x3
addi4spn x4 9
nop
fxmul x4 x4 x9 
nop 
mv x4 x9 
srli x4 x4 1 
mv x8 x4
lw x4 1(x2)
add x4 x4 x8 
sw x4 1(x2)
addi4spn x4 9 
nop
fxmul x4 x4 x3 
addi4spn x4 11
mv x11 x9 
fxmul x4 x4 x14 
lw x4 1(x2)
add x4 x4 x11 
sw x4 1(x2)
addi4spn x4 9 
nop
fxmul x4 x4 x3 
addi4spn x4 11
mv x11 x9 
fxmul x4 x4 x15 
lw x4 1(x2)
add x4 x4 x11 
sw x4 1(x2)
addi4spn x3 26
lw x4 0(x3)
addi4spn x7 32
sub x7 x7 x4
lw x4 1(x2)
srl x4 x4 x7
sw x4 1(x2)
.EXPCAL_LOOPCTL
addi x2 x2 1
addi x5 x5 -1
addi x6 x6 1
beqz x5 .DENOMINATOR
j .SOFTINIT
.DENOMINATOR
addi4spn x2 26
addi4spn x5 9 
addi4spn x3 0
.DENOMINATOR_LOOP
lw x4 1(x2)
add x3 x3 x4
addi x2 x2 1
addi x5 x5 -1
beqz x5 .POSTPROCESS
j .DENOMINATOR_LOOP
.POSTPROCESS
sw x3 10(x2)
addi4spn x1 26 
addi4spn x1 0 
.POST_PROCESS_START
addi4spn x2 37
addi4spn x5 0
addi x5 x5 -1
sw x5 5(x2) 
addi4spn x2 26
addi4spn x5 0 
lw x6 1(x2) 
addi4spn x3 6
addi4spn x8 1
.FIND_MAX_OUTPUTVALUE
addi x2 x2 1 
lw x7 1(x2) 
mv x4 x7
sub x7 x7 x6 
bltz x7 3
mv x6 x4 
mv x5 x8
addi x2 x2 1
addi x8 x8 1
addi x3 x3 -1
bnez x3 .FIND_MAX_OUTPUTVALUE
addi4spn x2 37
sw x5 0(x2)
sw x6 1(x2)
mv x3 x5
addi x3 x3 -7
bltz x3 2
j .UPDATE_WAKE_CNT
addi4spn x2 43
add x2 x2 x5 
lw x4 0(x2) 
addi x4 x4 1
addi4spn x2 26
lw x3 10(x2) 
addi4spn x7 8
addi x2 x2 4
nop
fxmul x2 x2 x3
nop
sub x6 x6 x4
bltz x6 2
j .UPDATE_WAKE_CNT
addi4spn x5 7 
addi4spn x2 37
sw x5 0(x2)
.UPDATE_WAKE_CNT
mv x3 x5
addi x3 x3 -7
bltz x3 2
j .CLEAR_WAKE_CNT
addi4spn x2 37
lw x4 3(x2)
lw x7 2(x2) 
sub x7 x7 x5
bnez x7 2
addi x4 x4 1
addi4spn x4 1
.CLEAR_WAKE_CNT
addi4spn x4 0
sw x4 3(x2)
addi4spn x2 43
addi4spn x3 37
bnez x5 .ELSE_EVANUM1 
lw x7 9(x2) 
sub x4 x4 x7
bnez x4 .UPDATE_MAX_VALUE_LAST 
sw x5 5(x3)
lw x7 7(x2)
sw x7 4(x3)
addi4spn x7 0
sw x7 3(x3)
.ELSE_EVANUM1
lw x7 10(x2) 
sub x4 x4 x7
bnez x4 .UPDATE_MAX_VALUE_LAST 
sw x5 5(x3)
lw x7 8(x2)
sw x7 4(x3)
addi4spn x7 0
sw x7 3(x3)
.UPDATE_MAX_VALUE_LAST
sw x5 2(x3) 
addi4spn x1 27 
addi4spn x1 0 
.NN_END
nop
ebreak
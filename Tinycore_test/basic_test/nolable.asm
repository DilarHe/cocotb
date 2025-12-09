lw x4 2(x2) 
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
addi4spn x6 16 
addi4spn x7 16 
lv v0 0(x3) 
addi x3 x3 1
lv v4 0(x4)
addi x4 x4 1 
vmulsum x7 x7 v0
addi x7 x7 1
addi x6 x6 -1
bnez x6 -5
nop
addi x5 x5 -1
bnez x5 -12
nop
lw x6 4(x2) 
lv v0 0(x6) 
addi4spn x6 16 
addi4spn x5 16 
mv x7 x10
fmsr x6 x6 x9
addi4spn x7 255
addx x6 x6 x8
min x6 x6 x7
addi4spn x7 0
max x6 x6 x7
addi x6 x6 1
addi x5 x5 -1
bnez x5 -9
lw x5 1(x2) 
sv1 x0 0(x5)
addi x5 x5 1
sw x5 1(x2) 
lw x5 6(x2) 
addi x5 x5 -1
bnez x5 2
jr x1
sw x5 6(x2)
j -49
lw x3 0(x2) 
lw x4 1(x2) 
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
lv v0 0(x3) 
mv x7 x3
lw x6 7(x2) 
sub x7 x7 x6
beqz x7 3
addi x3 x3 3 
j 2
lw x3 6(x2) 
lv v4 0(x4) 
addi x4 x4 3 
addi4spn x7 16 
addi4spn x6 16 
vmac8 x7 x7 x7
addi x7 x7 1
addi x6 x6 -1
bnez x6 -3
nop
addi x5 x5 -1
bnez x5 -18
nop
lw x6 4(x2) 
lv v0 0(x6) 
addi4spn x6 16 
addi4spn x5 16 
mv x7 x10 
fmsr x6 x6 x9
addi4spn x7 255
addx x6 x6 x8
min x6 x6 x7
addi4spn x7 0
max x6 x6 x7
addi x6 x6 1
addi x5 x5 -1
bnez x5 -9
lw x5 5(x2) 
sv1 x0 0(x5)
addi x5 x5 1
sw x5 5(x2) 
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
j -66
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
addi x3 x3 -1
nop 
skipadd x3 x3 x5
bnez x3 -3
addi4spn x3 16
addi4spn x5 16
addi4spn x7 255
addx x3 x3 x4
min x3 x3 x7
addi4spn x7 0
max x3 x3 x7
addi x3 x3 1
addi x5 x5 -1
bnez x5 -7
lw x3 1(x2)
sv1 x0 0(x3)
addi x3 x3 1
sw x3 1(x2)
jr x1
addi4spn x2 37 
lw x3 4(x2)
addi x3 x3 -1
addi4spn x4 3
addi4spn x5 0
max x4 x4 x5
nop
sw x3 4(x2)
beqz x3 2 
j 1087
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
mvimmx4 x4 1 
sw x4 6(x2)
jal x1 -180
lw x4 7(x2) 
beqz x4 30
addi x4 x4 -1
sw x4 7(x2) 
beqz x4 10
addi4spn x5 58
sub x4 x4 x5
beqz x4 15
mvimmx4 x4 448 
sw x4 3(x2) 
lw x4 0(x2) 
addi x4 x4 2
sw x4 0(x2)
j -16 
mvimmx4 x4 452 
sw x4 3(x2)
mvimmx4 x4 4 
sw x4 5(x2)
lw x4 0(x2) 
addi x4 x4 2
sw x4 0(x2)
j -24
mvimmx4 x4 448
sw x4 3(x2) 
mvimmx4 x4 348 
sw x4 2(x2)
mvimmx4 x4 128 
sw x4 0(x2)
mvimmx4 x4 6 
sw x4 5(x2)
j -33
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
jal x1 -261
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
jal x1 -282
addi4spn x1 3 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 1
sw x4 4(x3)
j 37
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
jal x1 -316
addi4spn x1 2 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -30
bnez x5 -88 
addi x4 x4 1
sw x4 4(x3)
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 -3
bltz x4 -39
addi x4 x4 -3 
bltz x4 6 
addi x4 x4 -25
bltz x4 22 
addi x4 x4 -2
bltz x4 26 
j 95
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
j 31
addi4spn x2 8 
addi4spn x4 9
sw x4 2(x2) 
mvimmx4 x4 518
sw x4 1(x2) 
j 11
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
addi4spn x5 70
slli x4 x4 1
sub x5 x5 x4 
sw x5 2(x2) 
mvimmx4 x4 518
sw x4 1(x2) 
j 1
addi4spn x2 8 
addi4spn x3 21
lw x4 3(x3) 
mv x5 x4
addi x5 x5 6
mv x6 x5
mvimmx4 x4 335
sub x5 x5 x4 
bltz x5 4 
mvimmx4 x4 308
add x4 x4 x5
mv x6 x4
sw x6 3(x3) 
sw x6 0(x2) 
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
jal x1 -346
addi4spn x1 4 
addi4spn x1 0 
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
jal x1 -415
addi4spn x1 5 
addi4spn x1 0 
addi4spn x2 17
jal x1 -299
addi4spn x1 6 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -31 
bltz x5 4 
addi x4 x4 1 
sw x4 4(x3)
j -103
j -140
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
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -5 
bltz x5 8 
addi x5 x5 -5 
bltz x5 40 
addi x5 x5 -21
bltz x5 54 
addi x5 x5 -4
bltz x5 58 
j 124
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
jal x1 -492
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 1
sw x4 4(x3)
addi4spn x1 8 
addi4spn x1 0 
j -45
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
j 29
addi4spn x2 8 
addi4spn x4 9
sw x4 2(x2) 
mvimmx4 x4 694
sw x4 1(x2) 
j 10
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
addi4spn x5 39
sub x5 x5 x4 
sw x5 2(x2) 
mvimmx4 x4 694
sw x4 1(x2) 
j 1
addi4spn x2 8 
addi4spn x3 21
lw x4 3(x3) 
mv x5 x4
mvimmx4 x4 332
sub x5 x5 x4 
bnez x5 3 
mvimmx4 x4 308
j 3
lw x4 3(x3) 
addi x4 x4 3
sw x4 3(x3) 
sw x4 0(x2) 
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
jal x1 -505
addi4spn x1 9 
addi4spn x1 0 
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
jal x1 -574
addi4spn x1 10 
addi4spn x1 0 
addi4spn x2 17
jal x1 -458
addi4spn x1 11 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -30 
bltz x5 -119 
addi x4 x4 1 
sw x4 4(x3)
j -134
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
jal x1 -638
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
jal x1 -659
addi4spn x1 14 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 1
sw x4 4(x3)
j 37
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
jal x1 -693
addi4spn x1 13 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -15
bnez x5 -88 
addi x4 x4 1
sw x4 4(x3)
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 -3
bltz x4 -39
addi x4 x4 -3 
bltz x4 6 
addi x4 x4 -10
bltz x4 22 
addi x4 x4 -2
bltz x4 26 
j 95
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
j 31
addi4spn x2 8 
addi4spn x4 9
sw x4 2(x2) 
mvimmx4 x4 849
sw x4 1(x2) 
j 11
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
addi4spn x5 40
slli x4 x4 1
sub x5 x5 x4 
sw x5 2(x2) 
mvimmx4 x4 849
sw x4 1(x2) 
j 1
addi4spn x2 8 
addi4spn x3 21
lw x4 3(x3) 
mv x5 x4
addi x5 x5 6
mv x6 x5
mvimmx4 x4 335
sub x5 x5 x4 
bltz x5 4 
mvimmx4 x4 308
add x4 x4 x5
mv x6 x4
sw x6 3(x3) 
sw x6 0(x2) 
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
jal x1 -723
addi4spn x1 15 
addi4spn x1 0 
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
jal x1 -792
addi4spn x1 16 
addi4spn x1 0 
addi4spn x2 17
jal x1 -676
addi4spn x1 17 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -16 
bltz x5 4 
addi x4 x4 1 
sw x4 4(x3)
j -103
j -140
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
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -5 
bltz x5 8 
addi x5 x5 -5 
bltz x5 40 
addi x5 x5 -6
bltz x5 54 
addi x5 x5 -4
bltz x5 58 
j 124
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
jal x1 -869
addi4spn x3 21
lw x4 4(x3)
addi x4 x4 1
sw x4 4(x3)
addi4spn x1 19 
addi4spn x1 0 
j -45
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
j 29
addi4spn x2 8 
addi4spn x4 9
sw x4 2(x2) 
mvimmx4 x4 1025
sw x4 1(x2) 
j 10
addi4spn x2 8 
addi4spn x3 21
lw x4 4(x3) 
addi4spn x5 24
sub x5 x5 x4 
sw x5 2(x2) 
mvimmx4 x4 1025
sw x4 1(x2) 
j 1
addi4spn x2 8 
addi4spn x3 21
lw x4 3(x3) 
mv x5 x4
mvimmx4 x4 332
sub x5 x5 x4 
bnez x5 3 
mvimmx4 x4 308
j 3
lw x4 3(x3) 
addi x4 x4 3
sw x4 3(x3) 
sw x4 0(x2) 
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
jal x1 -882
addi4spn x1 20 
addi4spn x1 0 
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
jal x1 -951
addi4spn x1 21 
addi4spn x1 0 
addi4spn x2 17
jal x1 -835
addi4spn x1 22 
addi4spn x1 0 
addi4spn x3 21
lw x4 4(x3)
mv x5 x4
addi x5 x5 -15 
bltz x5 -119 
addi x4 x4 1 
sw x4 4(x3)
j -134
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
lv v0 0(x4) 
addi x4 x4 1 
addi4spn x7 16 
addi4spn x6 16 
vmac8 x7 x7 x7
addi x7 x7 1
addi x6 x6 -1
bnez x6 -3
addi x5 x5 -1
bnez x5 -9
mvimmx4 x4 1119
lv v0 0(x4) 
addi4spn x6 16 
addi4spn x5 16 
mv x7 x10 
fmsr x6 x6 x9
addx x6 x6 x8
addi x6 x6 1
addi x5 x5 -1
bnez x5 -4
mvimmx4 x4 248
sv1 x0 0(x4)
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
lv v4 0(x4)
addi x4 x4 1 
vmulsum x7 x7 v0
addi x7 x7 1
addi x6 x6 -1
bnez x6 -5
mvimmx4 x4 1132 
lv v0 0(x4) 
addi4spn x6 16 
addi4spn x5 9 
mv x7 x10
fmsr x6 x6 x9
addi4spn x7 255
addx x6 x6 x8
min x6 x6 x7
addi4spn x7 0
max x6 x6 x7
addi x6 x6 1
addi x5 x5 -1
bnez x5 -9
mvimmx4 x4 248 
sv1 x0 0(x4)
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
subx x6 x6 x9
nop
fxmul x6 x6 x4
addi x5 x5 -1
addi x6 x6 1
bnez x5 -5
addi4spn x3 7 
mv x7 x16
addi4spn x6 17
addi4spn x5 8
mvx x4 x6
nop
max x3 x3 x4
addi x5 x5 -1
addi x6 x6 1
bnez x5 -5
addi4spn x6 16
addi4spn x5 9 
subx x6 x6 x7
nop
addx x6 x6 x11
nop
max x6 x6 x0
addi x5 x5 -1
addi x6 x6 1
bnez x5 -7
addi4spn x2 26
addi4spn x5 9 
addi4spn x6 16
addi4spn x3 0
subx x6 x6 x10 
nop
mvx x4 x6
bltz x4 3
addi x3 x3 1
j -5
addi4spn x7 26
sw x3 0(x7)
add x4 x4 x10 
bnez x4 4 
mv x4 x12 
sw x4 1(x2)
j 43 
slli x4 x4 7 
mv x3 x4 
mv x8 x12
add x4 x4 x8 
sw x4 1(x2)
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
addi x2 x2 1
addi x5 x5 -1
addi x6 x6 1
beqz x5 2
j -60
addi4spn x2 26
addi4spn x5 9 
addi4spn x3 0
lw x4 1(x2)
add x3 x3 x4
addi x2 x2 1
addi x5 x5 -1
beqz x5 2
j -5
sw x3 10(x2)
addi4spn x1 26 
addi4spn x1 0 
addi4spn x2 37
addi4spn x5 0
addi x5 x5 -1
sw x5 5(x2) 
addi4spn x2 26
addi4spn x5 0 
lw x6 1(x2) 
addi4spn x3 6
addi4spn x8 1
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
bnez x3 -10
addi4spn x2 37
sw x5 0(x2)
sw x6 1(x2)
mv x3 x5
addi x3 x3 -7
bltz x3 2
j 18
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
j 4
addi4spn x5 7 
addi4spn x2 37
sw x5 0(x2)
mv x3 x5
addi x3 x3 -7
bltz x3 2
j 8
addi4spn x2 37
lw x4 3(x2)
lw x7 2(x2) 
sub x7 x7 x5
bnez x7 2
addi x4 x4 1
addi4spn x4 1
addi4spn x4 0
sw x4 3(x2)
addi4spn x2 43
addi4spn x3 37
bnez x5 9 
lw x7 9(x2) 
sub x4 x4 x7
bnez x4 14 
sw x5 5(x3)
lw x7 7(x2)
sw x7 4(x3)
addi4spn x7 0
sw x7 3(x3)
lw x7 10(x2) 
sub x4 x4 x7
bnez x4 6 
sw x5 5(x3)
lw x7 8(x2)
sw x7 4(x3)
addi4spn x7 0
sw x7 3(x3)
sw x5 2(x3) 
addi4spn x1 27 
addi4spn x1 0 
nop
ebreak
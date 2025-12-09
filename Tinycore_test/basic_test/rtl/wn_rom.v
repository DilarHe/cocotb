// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : wn_rom
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module wn_rom (
  input      [6:0]    io_wn_addr,
  output     [15:0]   io_wn_real,
  output     [15:0]   io_wn_imag
);

  reg        [15:0]   tmp_io_wn_real;
  reg        [15:0]   tmp_io_wn_imag;
  wire       [15:0]   wnreal_0;
  wire       [15:0]   wnreal_1;
  wire       [15:0]   wnreal_2;
  wire       [15:0]   wnreal_3;
  wire       [15:0]   wnreal_4;
  wire       [15:0]   wnreal_5;
  wire       [15:0]   wnreal_6;
  wire       [15:0]   wnreal_7;
  wire       [15:0]   wnreal_8;
  wire       [15:0]   wnreal_9;
  wire       [15:0]   wnreal_10;
  wire       [15:0]   wnreal_11;
  wire       [15:0]   wnreal_12;
  wire       [15:0]   wnreal_13;
  wire       [15:0]   wnreal_14;
  wire       [15:0]   wnreal_15;
  wire       [15:0]   wnreal_16;
  wire       [15:0]   wnreal_17;
  wire       [15:0]   wnreal_18;
  wire       [15:0]   wnreal_19;
  wire       [15:0]   wnreal_20;
  wire       [15:0]   wnreal_21;
  wire       [15:0]   wnreal_22;
  wire       [15:0]   wnreal_23;
  wire       [15:0]   wnreal_24;
  wire       [15:0]   wnreal_25;
  wire       [15:0]   wnreal_26;
  wire       [15:0]   wnreal_27;
  wire       [15:0]   wnreal_28;
  wire       [15:0]   wnreal_29;
  wire       [15:0]   wnreal_30;
  wire       [15:0]   wnreal_31;
  wire       [15:0]   wnreal_32;
  wire       [15:0]   wnreal_33;
  wire       [15:0]   wnreal_34;
  wire       [15:0]   wnreal_35;
  wire       [15:0]   wnreal_36;
  wire       [15:0]   wnreal_37;
  wire       [15:0]   wnreal_38;
  wire       [15:0]   wnreal_39;
  wire       [15:0]   wnreal_40;
  wire       [15:0]   wnreal_41;
  wire       [15:0]   wnreal_42;
  wire       [15:0]   wnreal_43;
  wire       [15:0]   wnreal_44;
  wire       [15:0]   wnreal_45;
  wire       [15:0]   wnreal_46;
  wire       [15:0]   wnreal_47;
  wire       [15:0]   wnreal_48;
  wire       [15:0]   wnreal_49;
  wire       [15:0]   wnreal_50;
  wire       [15:0]   wnreal_51;
  wire       [15:0]   wnreal_52;
  wire       [15:0]   wnreal_53;
  wire       [15:0]   wnreal_54;
  wire       [15:0]   wnreal_55;
  wire       [15:0]   wnreal_56;
  wire       [15:0]   wnreal_57;
  wire       [15:0]   wnreal_58;
  wire       [15:0]   wnreal_59;
  wire       [15:0]   wnreal_60;
  wire       [15:0]   wnreal_61;
  wire       [15:0]   wnreal_62;
  wire       [15:0]   wnreal_63;
  wire       [15:0]   wnreal_64;
  wire       [15:0]   wnreal_65;
  wire       [15:0]   wnreal_66;
  wire       [15:0]   wnreal_67;
  wire       [15:0]   wnreal_68;
  wire       [15:0]   wnreal_69;
  wire       [15:0]   wnreal_70;
  wire       [15:0]   wnreal_71;
  wire       [15:0]   wnreal_72;
  wire       [15:0]   wnreal_73;
  wire       [15:0]   wnreal_74;
  wire       [15:0]   wnreal_75;
  wire       [15:0]   wnreal_76;
  wire       [15:0]   wnreal_77;
  wire       [15:0]   wnreal_78;
  wire       [15:0]   wnreal_79;
  wire       [15:0]   wnreal_80;
  wire       [15:0]   wnreal_81;
  wire       [15:0]   wnreal_82;
  wire       [15:0]   wnreal_83;
  wire       [15:0]   wnreal_84;
  wire       [15:0]   wnreal_85;
  wire       [15:0]   wnreal_86;
  wire       [15:0]   wnreal_87;
  wire       [15:0]   wnreal_88;
  wire       [15:0]   wnreal_89;
  wire       [15:0]   wnreal_90;
  wire       [15:0]   wnreal_91;
  wire       [15:0]   wnreal_92;
  wire       [15:0]   wnreal_93;
  wire       [15:0]   wnreal_94;
  wire       [15:0]   wnreal_95;
  wire       [15:0]   wnreal_96;
  wire       [15:0]   wnreal_97;
  wire       [15:0]   wnreal_98;
  wire       [15:0]   wnreal_99;
  wire       [15:0]   wnreal_100;
  wire       [15:0]   wnreal_101;
  wire       [15:0]   wnreal_102;
  wire       [15:0]   wnreal_103;
  wire       [15:0]   wnreal_104;
  wire       [15:0]   wnreal_105;
  wire       [15:0]   wnreal_106;
  wire       [15:0]   wnreal_107;
  wire       [15:0]   wnreal_108;
  wire       [15:0]   wnreal_109;
  wire       [15:0]   wnreal_110;
  wire       [15:0]   wnreal_111;
  wire       [15:0]   wnreal_112;
  wire       [15:0]   wnreal_113;
  wire       [15:0]   wnreal_114;
  wire       [15:0]   wnreal_115;
  wire       [15:0]   wnreal_116;
  wire       [15:0]   wnreal_117;
  wire       [15:0]   wnreal_118;
  wire       [15:0]   wnreal_119;
  wire       [15:0]   wnreal_120;
  wire       [15:0]   wnreal_121;
  wire       [15:0]   wnreal_122;
  wire       [15:0]   wnreal_123;
  wire       [15:0]   wnreal_124;
  wire       [15:0]   wnreal_125;
  wire       [15:0]   wnreal_126;
  wire       [15:0]   wnreal_127;
  wire       [15:0]   wnimag_0;
  wire       [15:0]   wnimag_1;
  wire       [15:0]   wnimag_2;
  wire       [15:0]   wnimag_3;
  wire       [15:0]   wnimag_4;
  wire       [15:0]   wnimag_5;
  wire       [15:0]   wnimag_6;
  wire       [15:0]   wnimag_7;
  wire       [15:0]   wnimag_8;
  wire       [15:0]   wnimag_9;
  wire       [15:0]   wnimag_10;
  wire       [15:0]   wnimag_11;
  wire       [15:0]   wnimag_12;
  wire       [15:0]   wnimag_13;
  wire       [15:0]   wnimag_14;
  wire       [15:0]   wnimag_15;
  wire       [15:0]   wnimag_16;
  wire       [15:0]   wnimag_17;
  wire       [15:0]   wnimag_18;
  wire       [15:0]   wnimag_19;
  wire       [15:0]   wnimag_20;
  wire       [15:0]   wnimag_21;
  wire       [15:0]   wnimag_22;
  wire       [15:0]   wnimag_23;
  wire       [15:0]   wnimag_24;
  wire       [15:0]   wnimag_25;
  wire       [15:0]   wnimag_26;
  wire       [15:0]   wnimag_27;
  wire       [15:0]   wnimag_28;
  wire       [15:0]   wnimag_29;
  wire       [15:0]   wnimag_30;
  wire       [15:0]   wnimag_31;
  wire       [15:0]   wnimag_32;
  wire       [15:0]   wnimag_33;
  wire       [15:0]   wnimag_34;
  wire       [15:0]   wnimag_35;
  wire       [15:0]   wnimag_36;
  wire       [15:0]   wnimag_37;
  wire       [15:0]   wnimag_38;
  wire       [15:0]   wnimag_39;
  wire       [15:0]   wnimag_40;
  wire       [15:0]   wnimag_41;
  wire       [15:0]   wnimag_42;
  wire       [15:0]   wnimag_43;
  wire       [15:0]   wnimag_44;
  wire       [15:0]   wnimag_45;
  wire       [15:0]   wnimag_46;
  wire       [15:0]   wnimag_47;
  wire       [15:0]   wnimag_48;
  wire       [15:0]   wnimag_49;
  wire       [15:0]   wnimag_50;
  wire       [15:0]   wnimag_51;
  wire       [15:0]   wnimag_52;
  wire       [15:0]   wnimag_53;
  wire       [15:0]   wnimag_54;
  wire       [15:0]   wnimag_55;
  wire       [15:0]   wnimag_56;
  wire       [15:0]   wnimag_57;
  wire       [15:0]   wnimag_58;
  wire       [15:0]   wnimag_59;
  wire       [15:0]   wnimag_60;
  wire       [15:0]   wnimag_61;
  wire       [15:0]   wnimag_62;
  wire       [15:0]   wnimag_63;
  wire       [15:0]   wnimag_64;
  wire       [15:0]   wnimag_65;
  wire       [15:0]   wnimag_66;
  wire       [15:0]   wnimag_67;
  wire       [15:0]   wnimag_68;
  wire       [15:0]   wnimag_69;
  wire       [15:0]   wnimag_70;
  wire       [15:0]   wnimag_71;
  wire       [15:0]   wnimag_72;
  wire       [15:0]   wnimag_73;
  wire       [15:0]   wnimag_74;
  wire       [15:0]   wnimag_75;
  wire       [15:0]   wnimag_76;
  wire       [15:0]   wnimag_77;
  wire       [15:0]   wnimag_78;
  wire       [15:0]   wnimag_79;
  wire       [15:0]   wnimag_80;
  wire       [15:0]   wnimag_81;
  wire       [15:0]   wnimag_82;
  wire       [15:0]   wnimag_83;
  wire       [15:0]   wnimag_84;
  wire       [15:0]   wnimag_85;
  wire       [15:0]   wnimag_86;
  wire       [15:0]   wnimag_87;
  wire       [15:0]   wnimag_88;
  wire       [15:0]   wnimag_89;
  wire       [15:0]   wnimag_90;
  wire       [15:0]   wnimag_91;
  wire       [15:0]   wnimag_92;
  wire       [15:0]   wnimag_93;
  wire       [15:0]   wnimag_94;
  wire       [15:0]   wnimag_95;
  wire       [15:0]   wnimag_96;
  wire       [15:0]   wnimag_97;
  wire       [15:0]   wnimag_98;
  wire       [15:0]   wnimag_99;
  wire       [15:0]   wnimag_100;
  wire       [15:0]   wnimag_101;
  wire       [15:0]   wnimag_102;
  wire       [15:0]   wnimag_103;
  wire       [15:0]   wnimag_104;
  wire       [15:0]   wnimag_105;
  wire       [15:0]   wnimag_106;
  wire       [15:0]   wnimag_107;
  wire       [15:0]   wnimag_108;
  wire       [15:0]   wnimag_109;
  wire       [15:0]   wnimag_110;
  wire       [15:0]   wnimag_111;
  wire       [15:0]   wnimag_112;
  wire       [15:0]   wnimag_113;
  wire       [15:0]   wnimag_114;
  wire       [15:0]   wnimag_115;
  wire       [15:0]   wnimag_116;
  wire       [15:0]   wnimag_117;
  wire       [15:0]   wnimag_118;
  wire       [15:0]   wnimag_119;
  wire       [15:0]   wnimag_120;
  wire       [15:0]   wnimag_121;
  wire       [15:0]   wnimag_122;
  wire       [15:0]   wnimag_123;
  wire       [15:0]   wnimag_124;
  wire       [15:0]   wnimag_125;
  wire       [15:0]   wnimag_126;
  wire       [15:0]   wnimag_127;

  always @(*) begin
    case(io_wn_addr)
      7'b0000000 : begin
        tmp_io_wn_real = wnreal_0;
        tmp_io_wn_imag = wnimag_0;
      end
      7'b0000001 : begin
        tmp_io_wn_real = wnreal_1;
        tmp_io_wn_imag = wnimag_1;
      end
      7'b0000010 : begin
        tmp_io_wn_real = wnreal_2;
        tmp_io_wn_imag = wnimag_2;
      end
      7'b0000011 : begin
        tmp_io_wn_real = wnreal_3;
        tmp_io_wn_imag = wnimag_3;
      end
      7'b0000100 : begin
        tmp_io_wn_real = wnreal_4;
        tmp_io_wn_imag = wnimag_4;
      end
      7'b0000101 : begin
        tmp_io_wn_real = wnreal_5;
        tmp_io_wn_imag = wnimag_5;
      end
      7'b0000110 : begin
        tmp_io_wn_real = wnreal_6;
        tmp_io_wn_imag = wnimag_6;
      end
      7'b0000111 : begin
        tmp_io_wn_real = wnreal_7;
        tmp_io_wn_imag = wnimag_7;
      end
      7'b0001000 : begin
        tmp_io_wn_real = wnreal_8;
        tmp_io_wn_imag = wnimag_8;
      end
      7'b0001001 : begin
        tmp_io_wn_real = wnreal_9;
        tmp_io_wn_imag = wnimag_9;
      end
      7'b0001010 : begin
        tmp_io_wn_real = wnreal_10;
        tmp_io_wn_imag = wnimag_10;
      end
      7'b0001011 : begin
        tmp_io_wn_real = wnreal_11;
        tmp_io_wn_imag = wnimag_11;
      end
      7'b0001100 : begin
        tmp_io_wn_real = wnreal_12;
        tmp_io_wn_imag = wnimag_12;
      end
      7'b0001101 : begin
        tmp_io_wn_real = wnreal_13;
        tmp_io_wn_imag = wnimag_13;
      end
      7'b0001110 : begin
        tmp_io_wn_real = wnreal_14;
        tmp_io_wn_imag = wnimag_14;
      end
      7'b0001111 : begin
        tmp_io_wn_real = wnreal_15;
        tmp_io_wn_imag = wnimag_15;
      end
      7'b0010000 : begin
        tmp_io_wn_real = wnreal_16;
        tmp_io_wn_imag = wnimag_16;
      end
      7'b0010001 : begin
        tmp_io_wn_real = wnreal_17;
        tmp_io_wn_imag = wnimag_17;
      end
      7'b0010010 : begin
        tmp_io_wn_real = wnreal_18;
        tmp_io_wn_imag = wnimag_18;
      end
      7'b0010011 : begin
        tmp_io_wn_real = wnreal_19;
        tmp_io_wn_imag = wnimag_19;
      end
      7'b0010100 : begin
        tmp_io_wn_real = wnreal_20;
        tmp_io_wn_imag = wnimag_20;
      end
      7'b0010101 : begin
        tmp_io_wn_real = wnreal_21;
        tmp_io_wn_imag = wnimag_21;
      end
      7'b0010110 : begin
        tmp_io_wn_real = wnreal_22;
        tmp_io_wn_imag = wnimag_22;
      end
      7'b0010111 : begin
        tmp_io_wn_real = wnreal_23;
        tmp_io_wn_imag = wnimag_23;
      end
      7'b0011000 : begin
        tmp_io_wn_real = wnreal_24;
        tmp_io_wn_imag = wnimag_24;
      end
      7'b0011001 : begin
        tmp_io_wn_real = wnreal_25;
        tmp_io_wn_imag = wnimag_25;
      end
      7'b0011010 : begin
        tmp_io_wn_real = wnreal_26;
        tmp_io_wn_imag = wnimag_26;
      end
      7'b0011011 : begin
        tmp_io_wn_real = wnreal_27;
        tmp_io_wn_imag = wnimag_27;
      end
      7'b0011100 : begin
        tmp_io_wn_real = wnreal_28;
        tmp_io_wn_imag = wnimag_28;
      end
      7'b0011101 : begin
        tmp_io_wn_real = wnreal_29;
        tmp_io_wn_imag = wnimag_29;
      end
      7'b0011110 : begin
        tmp_io_wn_real = wnreal_30;
        tmp_io_wn_imag = wnimag_30;
      end
      7'b0011111 : begin
        tmp_io_wn_real = wnreal_31;
        tmp_io_wn_imag = wnimag_31;
      end
      7'b0100000 : begin
        tmp_io_wn_real = wnreal_32;
        tmp_io_wn_imag = wnimag_32;
      end
      7'b0100001 : begin
        tmp_io_wn_real = wnreal_33;
        tmp_io_wn_imag = wnimag_33;
      end
      7'b0100010 : begin
        tmp_io_wn_real = wnreal_34;
        tmp_io_wn_imag = wnimag_34;
      end
      7'b0100011 : begin
        tmp_io_wn_real = wnreal_35;
        tmp_io_wn_imag = wnimag_35;
      end
      7'b0100100 : begin
        tmp_io_wn_real = wnreal_36;
        tmp_io_wn_imag = wnimag_36;
      end
      7'b0100101 : begin
        tmp_io_wn_real = wnreal_37;
        tmp_io_wn_imag = wnimag_37;
      end
      7'b0100110 : begin
        tmp_io_wn_real = wnreal_38;
        tmp_io_wn_imag = wnimag_38;
      end
      7'b0100111 : begin
        tmp_io_wn_real = wnreal_39;
        tmp_io_wn_imag = wnimag_39;
      end
      7'b0101000 : begin
        tmp_io_wn_real = wnreal_40;
        tmp_io_wn_imag = wnimag_40;
      end
      7'b0101001 : begin
        tmp_io_wn_real = wnreal_41;
        tmp_io_wn_imag = wnimag_41;
      end
      7'b0101010 : begin
        tmp_io_wn_real = wnreal_42;
        tmp_io_wn_imag = wnimag_42;
      end
      7'b0101011 : begin
        tmp_io_wn_real = wnreal_43;
        tmp_io_wn_imag = wnimag_43;
      end
      7'b0101100 : begin
        tmp_io_wn_real = wnreal_44;
        tmp_io_wn_imag = wnimag_44;
      end
      7'b0101101 : begin
        tmp_io_wn_real = wnreal_45;
        tmp_io_wn_imag = wnimag_45;
      end
      7'b0101110 : begin
        tmp_io_wn_real = wnreal_46;
        tmp_io_wn_imag = wnimag_46;
      end
      7'b0101111 : begin
        tmp_io_wn_real = wnreal_47;
        tmp_io_wn_imag = wnimag_47;
      end
      7'b0110000 : begin
        tmp_io_wn_real = wnreal_48;
        tmp_io_wn_imag = wnimag_48;
      end
      7'b0110001 : begin
        tmp_io_wn_real = wnreal_49;
        tmp_io_wn_imag = wnimag_49;
      end
      7'b0110010 : begin
        tmp_io_wn_real = wnreal_50;
        tmp_io_wn_imag = wnimag_50;
      end
      7'b0110011 : begin
        tmp_io_wn_real = wnreal_51;
        tmp_io_wn_imag = wnimag_51;
      end
      7'b0110100 : begin
        tmp_io_wn_real = wnreal_52;
        tmp_io_wn_imag = wnimag_52;
      end
      7'b0110101 : begin
        tmp_io_wn_real = wnreal_53;
        tmp_io_wn_imag = wnimag_53;
      end
      7'b0110110 : begin
        tmp_io_wn_real = wnreal_54;
        tmp_io_wn_imag = wnimag_54;
      end
      7'b0110111 : begin
        tmp_io_wn_real = wnreal_55;
        tmp_io_wn_imag = wnimag_55;
      end
      7'b0111000 : begin
        tmp_io_wn_real = wnreal_56;
        tmp_io_wn_imag = wnimag_56;
      end
      7'b0111001 : begin
        tmp_io_wn_real = wnreal_57;
        tmp_io_wn_imag = wnimag_57;
      end
      7'b0111010 : begin
        tmp_io_wn_real = wnreal_58;
        tmp_io_wn_imag = wnimag_58;
      end
      7'b0111011 : begin
        tmp_io_wn_real = wnreal_59;
        tmp_io_wn_imag = wnimag_59;
      end
      7'b0111100 : begin
        tmp_io_wn_real = wnreal_60;
        tmp_io_wn_imag = wnimag_60;
      end
      7'b0111101 : begin
        tmp_io_wn_real = wnreal_61;
        tmp_io_wn_imag = wnimag_61;
      end
      7'b0111110 : begin
        tmp_io_wn_real = wnreal_62;
        tmp_io_wn_imag = wnimag_62;
      end
      7'b0111111 : begin
        tmp_io_wn_real = wnreal_63;
        tmp_io_wn_imag = wnimag_63;
      end
      7'b1000000 : begin
        tmp_io_wn_real = wnreal_64;
        tmp_io_wn_imag = wnimag_64;
      end
      7'b1000001 : begin
        tmp_io_wn_real = wnreal_65;
        tmp_io_wn_imag = wnimag_65;
      end
      7'b1000010 : begin
        tmp_io_wn_real = wnreal_66;
        tmp_io_wn_imag = wnimag_66;
      end
      7'b1000011 : begin
        tmp_io_wn_real = wnreal_67;
        tmp_io_wn_imag = wnimag_67;
      end
      7'b1000100 : begin
        tmp_io_wn_real = wnreal_68;
        tmp_io_wn_imag = wnimag_68;
      end
      7'b1000101 : begin
        tmp_io_wn_real = wnreal_69;
        tmp_io_wn_imag = wnimag_69;
      end
      7'b1000110 : begin
        tmp_io_wn_real = wnreal_70;
        tmp_io_wn_imag = wnimag_70;
      end
      7'b1000111 : begin
        tmp_io_wn_real = wnreal_71;
        tmp_io_wn_imag = wnimag_71;
      end
      7'b1001000 : begin
        tmp_io_wn_real = wnreal_72;
        tmp_io_wn_imag = wnimag_72;
      end
      7'b1001001 : begin
        tmp_io_wn_real = wnreal_73;
        tmp_io_wn_imag = wnimag_73;
      end
      7'b1001010 : begin
        tmp_io_wn_real = wnreal_74;
        tmp_io_wn_imag = wnimag_74;
      end
      7'b1001011 : begin
        tmp_io_wn_real = wnreal_75;
        tmp_io_wn_imag = wnimag_75;
      end
      7'b1001100 : begin
        tmp_io_wn_real = wnreal_76;
        tmp_io_wn_imag = wnimag_76;
      end
      7'b1001101 : begin
        tmp_io_wn_real = wnreal_77;
        tmp_io_wn_imag = wnimag_77;
      end
      7'b1001110 : begin
        tmp_io_wn_real = wnreal_78;
        tmp_io_wn_imag = wnimag_78;
      end
      7'b1001111 : begin
        tmp_io_wn_real = wnreal_79;
        tmp_io_wn_imag = wnimag_79;
      end
      7'b1010000 : begin
        tmp_io_wn_real = wnreal_80;
        tmp_io_wn_imag = wnimag_80;
      end
      7'b1010001 : begin
        tmp_io_wn_real = wnreal_81;
        tmp_io_wn_imag = wnimag_81;
      end
      7'b1010010 : begin
        tmp_io_wn_real = wnreal_82;
        tmp_io_wn_imag = wnimag_82;
      end
      7'b1010011 : begin
        tmp_io_wn_real = wnreal_83;
        tmp_io_wn_imag = wnimag_83;
      end
      7'b1010100 : begin
        tmp_io_wn_real = wnreal_84;
        tmp_io_wn_imag = wnimag_84;
      end
      7'b1010101 : begin
        tmp_io_wn_real = wnreal_85;
        tmp_io_wn_imag = wnimag_85;
      end
      7'b1010110 : begin
        tmp_io_wn_real = wnreal_86;
        tmp_io_wn_imag = wnimag_86;
      end
      7'b1010111 : begin
        tmp_io_wn_real = wnreal_87;
        tmp_io_wn_imag = wnimag_87;
      end
      7'b1011000 : begin
        tmp_io_wn_real = wnreal_88;
        tmp_io_wn_imag = wnimag_88;
      end
      7'b1011001 : begin
        tmp_io_wn_real = wnreal_89;
        tmp_io_wn_imag = wnimag_89;
      end
      7'b1011010 : begin
        tmp_io_wn_real = wnreal_90;
        tmp_io_wn_imag = wnimag_90;
      end
      7'b1011011 : begin
        tmp_io_wn_real = wnreal_91;
        tmp_io_wn_imag = wnimag_91;
      end
      7'b1011100 : begin
        tmp_io_wn_real = wnreal_92;
        tmp_io_wn_imag = wnimag_92;
      end
      7'b1011101 : begin
        tmp_io_wn_real = wnreal_93;
        tmp_io_wn_imag = wnimag_93;
      end
      7'b1011110 : begin
        tmp_io_wn_real = wnreal_94;
        tmp_io_wn_imag = wnimag_94;
      end
      7'b1011111 : begin
        tmp_io_wn_real = wnreal_95;
        tmp_io_wn_imag = wnimag_95;
      end
      7'b1100000 : begin
        tmp_io_wn_real = wnreal_96;
        tmp_io_wn_imag = wnimag_96;
      end
      7'b1100001 : begin
        tmp_io_wn_real = wnreal_97;
        tmp_io_wn_imag = wnimag_97;
      end
      7'b1100010 : begin
        tmp_io_wn_real = wnreal_98;
        tmp_io_wn_imag = wnimag_98;
      end
      7'b1100011 : begin
        tmp_io_wn_real = wnreal_99;
        tmp_io_wn_imag = wnimag_99;
      end
      7'b1100100 : begin
        tmp_io_wn_real = wnreal_100;
        tmp_io_wn_imag = wnimag_100;
      end
      7'b1100101 : begin
        tmp_io_wn_real = wnreal_101;
        tmp_io_wn_imag = wnimag_101;
      end
      7'b1100110 : begin
        tmp_io_wn_real = wnreal_102;
        tmp_io_wn_imag = wnimag_102;
      end
      7'b1100111 : begin
        tmp_io_wn_real = wnreal_103;
        tmp_io_wn_imag = wnimag_103;
      end
      7'b1101000 : begin
        tmp_io_wn_real = wnreal_104;
        tmp_io_wn_imag = wnimag_104;
      end
      7'b1101001 : begin
        tmp_io_wn_real = wnreal_105;
        tmp_io_wn_imag = wnimag_105;
      end
      7'b1101010 : begin
        tmp_io_wn_real = wnreal_106;
        tmp_io_wn_imag = wnimag_106;
      end
      7'b1101011 : begin
        tmp_io_wn_real = wnreal_107;
        tmp_io_wn_imag = wnimag_107;
      end
      7'b1101100 : begin
        tmp_io_wn_real = wnreal_108;
        tmp_io_wn_imag = wnimag_108;
      end
      7'b1101101 : begin
        tmp_io_wn_real = wnreal_109;
        tmp_io_wn_imag = wnimag_109;
      end
      7'b1101110 : begin
        tmp_io_wn_real = wnreal_110;
        tmp_io_wn_imag = wnimag_110;
      end
      7'b1101111 : begin
        tmp_io_wn_real = wnreal_111;
        tmp_io_wn_imag = wnimag_111;
      end
      7'b1110000 : begin
        tmp_io_wn_real = wnreal_112;
        tmp_io_wn_imag = wnimag_112;
      end
      7'b1110001 : begin
        tmp_io_wn_real = wnreal_113;
        tmp_io_wn_imag = wnimag_113;
      end
      7'b1110010 : begin
        tmp_io_wn_real = wnreal_114;
        tmp_io_wn_imag = wnimag_114;
      end
      7'b1110011 : begin
        tmp_io_wn_real = wnreal_115;
        tmp_io_wn_imag = wnimag_115;
      end
      7'b1110100 : begin
        tmp_io_wn_real = wnreal_116;
        tmp_io_wn_imag = wnimag_116;
      end
      7'b1110101 : begin
        tmp_io_wn_real = wnreal_117;
        tmp_io_wn_imag = wnimag_117;
      end
      7'b1110110 : begin
        tmp_io_wn_real = wnreal_118;
        tmp_io_wn_imag = wnimag_118;
      end
      7'b1110111 : begin
        tmp_io_wn_real = wnreal_119;
        tmp_io_wn_imag = wnimag_119;
      end
      7'b1111000 : begin
        tmp_io_wn_real = wnreal_120;
        tmp_io_wn_imag = wnimag_120;
      end
      7'b1111001 : begin
        tmp_io_wn_real = wnreal_121;
        tmp_io_wn_imag = wnimag_121;
      end
      7'b1111010 : begin
        tmp_io_wn_real = wnreal_122;
        tmp_io_wn_imag = wnimag_122;
      end
      7'b1111011 : begin
        tmp_io_wn_real = wnreal_123;
        tmp_io_wn_imag = wnimag_123;
      end
      7'b1111100 : begin
        tmp_io_wn_real = wnreal_124;
        tmp_io_wn_imag = wnimag_124;
      end
      7'b1111101 : begin
        tmp_io_wn_real = wnreal_125;
        tmp_io_wn_imag = wnimag_125;
      end
      7'b1111110 : begin
        tmp_io_wn_real = wnreal_126;
        tmp_io_wn_imag = wnimag_126;
      end
      default : begin
        tmp_io_wn_real = wnreal_127;
        tmp_io_wn_imag = wnimag_127;
      end
    endcase
  end

  assign wnreal_0 = 16'h7fff; // @[Expression.scala 2380:18]
  assign wnreal_1 = 16'h7ff6; // @[Expression.scala 2380:18]
  assign wnreal_2 = 16'h7fd9; // @[Expression.scala 2380:18]
  assign wnreal_3 = 16'h7fa7; // @[Expression.scala 2380:18]
  assign wnreal_4 = 16'h7f62; // @[Expression.scala 2380:18]
  assign wnreal_5 = 16'h7f0a; // @[Expression.scala 2380:18]
  assign wnreal_6 = 16'h7e9d; // @[Expression.scala 2380:18]
  assign wnreal_7 = 16'h7e1e; // @[Expression.scala 2380:18]
  assign wnreal_8 = 16'h7d8a; // @[Expression.scala 2380:18]
  assign wnreal_9 = 16'h7ce4; // @[Expression.scala 2380:18]
  assign wnreal_10 = 16'h7c2a; // @[Expression.scala 2380:18]
  assign wnreal_11 = 16'h7b5d; // @[Expression.scala 2380:18]
  assign wnreal_12 = 16'h7a7d; // @[Expression.scala 2380:18]
  assign wnreal_13 = 16'h798a; // @[Expression.scala 2380:18]
  assign wnreal_14 = 16'h7885; // @[Expression.scala 2380:18]
  assign wnreal_15 = 16'h776c; // @[Expression.scala 2380:18]
  assign wnreal_16 = 16'h7642; // @[Expression.scala 2380:18]
  assign wnreal_17 = 16'h7505; // @[Expression.scala 2380:18]
  assign wnreal_18 = 16'h73b6; // @[Expression.scala 2380:18]
  assign wnreal_19 = 16'h7255; // @[Expression.scala 2380:18]
  assign wnreal_20 = 16'h70e3; // @[Expression.scala 2380:18]
  assign wnreal_21 = 16'h6f5f; // @[Expression.scala 2380:18]
  assign wnreal_22 = 16'h6dca; // @[Expression.scala 2380:18]
  assign wnreal_23 = 16'h6c24; // @[Expression.scala 2380:18]
  assign wnreal_24 = 16'h6a6e; // @[Expression.scala 2380:18]
  assign wnreal_25 = 16'h68a7; // @[Expression.scala 2380:18]
  assign wnreal_26 = 16'h66d0; // @[Expression.scala 2380:18]
  assign wnreal_27 = 16'h64e9; // @[Expression.scala 2380:18]
  assign wnreal_28 = 16'h62f2; // @[Expression.scala 2380:18]
  assign wnreal_29 = 16'h60ec; // @[Expression.scala 2380:18]
  assign wnreal_30 = 16'h5ed7; // @[Expression.scala 2380:18]
  assign wnreal_31 = 16'h5cb4; // @[Expression.scala 2380:18]
  assign wnreal_32 = 16'h5a82; // @[Expression.scala 2380:18]
  assign wnreal_33 = 16'h5843; // @[Expression.scala 2380:18]
  assign wnreal_34 = 16'h55f6; // @[Expression.scala 2380:18]
  assign wnreal_35 = 16'h539b; // @[Expression.scala 2380:18]
  assign wnreal_36 = 16'h5134; // @[Expression.scala 2380:18]
  assign wnreal_37 = 16'h4ec0; // @[Expression.scala 2380:18]
  assign wnreal_38 = 16'h4c40; // @[Expression.scala 2380:18]
  assign wnreal_39 = 16'h49b4; // @[Expression.scala 2380:18]
  assign wnreal_40 = 16'h471d; // @[Expression.scala 2380:18]
  assign wnreal_41 = 16'h447b; // @[Expression.scala 2380:18]
  assign wnreal_42 = 16'h41ce; // @[Expression.scala 2380:18]
  assign wnreal_43 = 16'h3f17; // @[Expression.scala 2380:18]
  assign wnreal_44 = 16'h3c57; // @[Expression.scala 2380:18]
  assign wnreal_45 = 16'h398d; // @[Expression.scala 2380:18]
  assign wnreal_46 = 16'h36ba; // @[Expression.scala 2380:18]
  assign wnreal_47 = 16'h33df; // @[Expression.scala 2380:18]
  assign wnreal_48 = 16'h30fc; // @[Expression.scala 2380:18]
  assign wnreal_49 = 16'h2e11; // @[Expression.scala 2380:18]
  assign wnreal_50 = 16'h2b1f; // @[Expression.scala 2380:18]
  assign wnreal_51 = 16'h2827; // @[Expression.scala 2380:18]
  assign wnreal_52 = 16'h2528; // @[Expression.scala 2380:18]
  assign wnreal_53 = 16'h2224; // @[Expression.scala 2380:18]
  assign wnreal_54 = 16'h1f1a; // @[Expression.scala 2380:18]
  assign wnreal_55 = 16'h1c0c; // @[Expression.scala 2380:18]
  assign wnreal_56 = 16'h18f9; // @[Expression.scala 2380:18]
  assign wnreal_57 = 16'h15e2; // @[Expression.scala 2380:18]
  assign wnreal_58 = 16'h12c8; // @[Expression.scala 2380:18]
  assign wnreal_59 = 16'h0fab; // @[Expression.scala 2380:18]
  assign wnreal_60 = 16'h0c8c; // @[Expression.scala 2380:18]
  assign wnreal_61 = 16'h096b; // @[Expression.scala 2380:18]
  assign wnreal_62 = 16'h0648; // @[Expression.scala 2380:18]
  assign wnreal_63 = 16'h0324; // @[Expression.scala 2380:18]
  assign wnreal_64 = 16'h0; // @[Expression.scala 2380:18]
  assign wnreal_65 = 16'hfcdc; // @[Expression.scala 2380:18]
  assign wnreal_66 = 16'hf9b8; // @[Expression.scala 2380:18]
  assign wnreal_67 = 16'hf695; // @[Expression.scala 2380:18]
  assign wnreal_68 = 16'hf374; // @[Expression.scala 2380:18]
  assign wnreal_69 = 16'hf055; // @[Expression.scala 2380:18]
  assign wnreal_70 = 16'hed38; // @[Expression.scala 2380:18]
  assign wnreal_71 = 16'hea1e; // @[Expression.scala 2380:18]
  assign wnreal_72 = 16'he707; // @[Expression.scala 2380:18]
  assign wnreal_73 = 16'he3f4; // @[Expression.scala 2380:18]
  assign wnreal_74 = 16'he0e6; // @[Expression.scala 2380:18]
  assign wnreal_75 = 16'hdddc; // @[Expression.scala 2380:18]
  assign wnreal_76 = 16'hdad8; // @[Expression.scala 2380:18]
  assign wnreal_77 = 16'hd7d9; // @[Expression.scala 2380:18]
  assign wnreal_78 = 16'hd4e1; // @[Expression.scala 2380:18]
  assign wnreal_79 = 16'hd1ef; // @[Expression.scala 2380:18]
  assign wnreal_80 = 16'hcf04; // @[Expression.scala 2380:18]
  assign wnreal_81 = 16'hcc21; // @[Expression.scala 2380:18]
  assign wnreal_82 = 16'hc946; // @[Expression.scala 2380:18]
  assign wnreal_83 = 16'hc673; // @[Expression.scala 2380:18]
  assign wnreal_84 = 16'hc3a9; // @[Expression.scala 2380:18]
  assign wnreal_85 = 16'hc0e9; // @[Expression.scala 2380:18]
  assign wnreal_86 = 16'hbe32; // @[Expression.scala 2380:18]
  assign wnreal_87 = 16'hbb85; // @[Expression.scala 2380:18]
  assign wnreal_88 = 16'hb8e3; // @[Expression.scala 2380:18]
  assign wnreal_89 = 16'hb64c; // @[Expression.scala 2380:18]
  assign wnreal_90 = 16'hb3c0; // @[Expression.scala 2380:18]
  assign wnreal_91 = 16'hb140; // @[Expression.scala 2380:18]
  assign wnreal_92 = 16'haecc; // @[Expression.scala 2380:18]
  assign wnreal_93 = 16'hac65; // @[Expression.scala 2380:18]
  assign wnreal_94 = 16'haa0a; // @[Expression.scala 2380:18]
  assign wnreal_95 = 16'ha7bd; // @[Expression.scala 2380:18]
  assign wnreal_96 = 16'ha57e; // @[Expression.scala 2380:18]
  assign wnreal_97 = 16'ha34c; // @[Expression.scala 2380:18]
  assign wnreal_98 = 16'ha129; // @[Expression.scala 2380:18]
  assign wnreal_99 = 16'h9f14; // @[Expression.scala 2380:18]
  assign wnreal_100 = 16'h9d0e; // @[Expression.scala 2380:18]
  assign wnreal_101 = 16'h9b17; // @[Expression.scala 2380:18]
  assign wnreal_102 = 16'h9930; // @[Expression.scala 2380:18]
  assign wnreal_103 = 16'h9759; // @[Expression.scala 2380:18]
  assign wnreal_104 = 16'h9592; // @[Expression.scala 2380:18]
  assign wnreal_105 = 16'h93dc; // @[Expression.scala 2380:18]
  assign wnreal_106 = 16'h9236; // @[Expression.scala 2380:18]
  assign wnreal_107 = 16'h90a1; // @[Expression.scala 2380:18]
  assign wnreal_108 = 16'h8f1d; // @[Expression.scala 2380:18]
  assign wnreal_109 = 16'h8dab; // @[Expression.scala 2380:18]
  assign wnreal_110 = 16'h8c4a; // @[Expression.scala 2380:18]
  assign wnreal_111 = 16'h8afb; // @[Expression.scala 2380:18]
  assign wnreal_112 = 16'h89be; // @[Expression.scala 2380:18]
  assign wnreal_113 = 16'h8894; // @[Expression.scala 2380:18]
  assign wnreal_114 = 16'h877b; // @[Expression.scala 2380:18]
  assign wnreal_115 = 16'h8676; // @[Expression.scala 2380:18]
  assign wnreal_116 = 16'h8583; // @[Expression.scala 2380:18]
  assign wnreal_117 = 16'h84a3; // @[Expression.scala 2380:18]
  assign wnreal_118 = 16'h83d6; // @[Expression.scala 2380:18]
  assign wnreal_119 = 16'h831c; // @[Expression.scala 2380:18]
  assign wnreal_120 = 16'h8276; // @[Expression.scala 2380:18]
  assign wnreal_121 = 16'h81e2; // @[Expression.scala 2380:18]
  assign wnreal_122 = 16'h8163; // @[Expression.scala 2380:18]
  assign wnreal_123 = 16'h80f6; // @[Expression.scala 2380:18]
  assign wnreal_124 = 16'h809e; // @[Expression.scala 2380:18]
  assign wnreal_125 = 16'h8059; // @[Expression.scala 2380:18]
  assign wnreal_126 = 16'h8027; // @[Expression.scala 2380:18]
  assign wnreal_127 = 16'h800a; // @[Expression.scala 2380:18]
  assign wnimag_0 = 16'h0; // @[Expression.scala 2380:18]
  assign wnimag_1 = 16'hfcdc; // @[Expression.scala 2380:18]
  assign wnimag_2 = 16'hf9b8; // @[Expression.scala 2380:18]
  assign wnimag_3 = 16'hf695; // @[Expression.scala 2380:18]
  assign wnimag_4 = 16'hf374; // @[Expression.scala 2380:18]
  assign wnimag_5 = 16'hf055; // @[Expression.scala 2380:18]
  assign wnimag_6 = 16'hed38; // @[Expression.scala 2380:18]
  assign wnimag_7 = 16'hea1e; // @[Expression.scala 2380:18]
  assign wnimag_8 = 16'he707; // @[Expression.scala 2380:18]
  assign wnimag_9 = 16'he3f4; // @[Expression.scala 2380:18]
  assign wnimag_10 = 16'he0e6; // @[Expression.scala 2380:18]
  assign wnimag_11 = 16'hdddc; // @[Expression.scala 2380:18]
  assign wnimag_12 = 16'hdad8; // @[Expression.scala 2380:18]
  assign wnimag_13 = 16'hd7d9; // @[Expression.scala 2380:18]
  assign wnimag_14 = 16'hd4e1; // @[Expression.scala 2380:18]
  assign wnimag_15 = 16'hd1ef; // @[Expression.scala 2380:18]
  assign wnimag_16 = 16'hcf04; // @[Expression.scala 2380:18]
  assign wnimag_17 = 16'hcc21; // @[Expression.scala 2380:18]
  assign wnimag_18 = 16'hc946; // @[Expression.scala 2380:18]
  assign wnimag_19 = 16'hc673; // @[Expression.scala 2380:18]
  assign wnimag_20 = 16'hc3a9; // @[Expression.scala 2380:18]
  assign wnimag_21 = 16'hc0e9; // @[Expression.scala 2380:18]
  assign wnimag_22 = 16'hbe32; // @[Expression.scala 2380:18]
  assign wnimag_23 = 16'hbb85; // @[Expression.scala 2380:18]
  assign wnimag_24 = 16'hb8e3; // @[Expression.scala 2380:18]
  assign wnimag_25 = 16'hb64c; // @[Expression.scala 2380:18]
  assign wnimag_26 = 16'hb3c0; // @[Expression.scala 2380:18]
  assign wnimag_27 = 16'hb140; // @[Expression.scala 2380:18]
  assign wnimag_28 = 16'haecc; // @[Expression.scala 2380:18]
  assign wnimag_29 = 16'hac65; // @[Expression.scala 2380:18]
  assign wnimag_30 = 16'haa0a; // @[Expression.scala 2380:18]
  assign wnimag_31 = 16'ha7bd; // @[Expression.scala 2380:18]
  assign wnimag_32 = 16'ha57e; // @[Expression.scala 2380:18]
  assign wnimag_33 = 16'ha34c; // @[Expression.scala 2380:18]
  assign wnimag_34 = 16'ha129; // @[Expression.scala 2380:18]
  assign wnimag_35 = 16'h9f14; // @[Expression.scala 2380:18]
  assign wnimag_36 = 16'h9d0e; // @[Expression.scala 2380:18]
  assign wnimag_37 = 16'h9b17; // @[Expression.scala 2380:18]
  assign wnimag_38 = 16'h9930; // @[Expression.scala 2380:18]
  assign wnimag_39 = 16'h9759; // @[Expression.scala 2380:18]
  assign wnimag_40 = 16'h9592; // @[Expression.scala 2380:18]
  assign wnimag_41 = 16'h93dc; // @[Expression.scala 2380:18]
  assign wnimag_42 = 16'h9236; // @[Expression.scala 2380:18]
  assign wnimag_43 = 16'h90a1; // @[Expression.scala 2380:18]
  assign wnimag_44 = 16'h8f1d; // @[Expression.scala 2380:18]
  assign wnimag_45 = 16'h8dab; // @[Expression.scala 2380:18]
  assign wnimag_46 = 16'h8c4a; // @[Expression.scala 2380:18]
  assign wnimag_47 = 16'h8afb; // @[Expression.scala 2380:18]
  assign wnimag_48 = 16'h89be; // @[Expression.scala 2380:18]
  assign wnimag_49 = 16'h8894; // @[Expression.scala 2380:18]
  assign wnimag_50 = 16'h877b; // @[Expression.scala 2380:18]
  assign wnimag_51 = 16'h8676; // @[Expression.scala 2380:18]
  assign wnimag_52 = 16'h8583; // @[Expression.scala 2380:18]
  assign wnimag_53 = 16'h84a3; // @[Expression.scala 2380:18]
  assign wnimag_54 = 16'h83d6; // @[Expression.scala 2380:18]
  assign wnimag_55 = 16'h831c; // @[Expression.scala 2380:18]
  assign wnimag_56 = 16'h8276; // @[Expression.scala 2380:18]
  assign wnimag_57 = 16'h81e2; // @[Expression.scala 2380:18]
  assign wnimag_58 = 16'h8163; // @[Expression.scala 2380:18]
  assign wnimag_59 = 16'h80f6; // @[Expression.scala 2380:18]
  assign wnimag_60 = 16'h809e; // @[Expression.scala 2380:18]
  assign wnimag_61 = 16'h8059; // @[Expression.scala 2380:18]
  assign wnimag_62 = 16'h8027; // @[Expression.scala 2380:18]
  assign wnimag_63 = 16'h800a; // @[Expression.scala 2380:18]
  assign wnimag_64 = 16'h8000; // @[Expression.scala 2380:18]
  assign wnimag_65 = 16'h800a; // @[Expression.scala 2380:18]
  assign wnimag_66 = 16'h8027; // @[Expression.scala 2380:18]
  assign wnimag_67 = 16'h8059; // @[Expression.scala 2380:18]
  assign wnimag_68 = 16'h809e; // @[Expression.scala 2380:18]
  assign wnimag_69 = 16'h80f6; // @[Expression.scala 2380:18]
  assign wnimag_70 = 16'h8163; // @[Expression.scala 2380:18]
  assign wnimag_71 = 16'h81e2; // @[Expression.scala 2380:18]
  assign wnimag_72 = 16'h8276; // @[Expression.scala 2380:18]
  assign wnimag_73 = 16'h831c; // @[Expression.scala 2380:18]
  assign wnimag_74 = 16'h83d6; // @[Expression.scala 2380:18]
  assign wnimag_75 = 16'h84a3; // @[Expression.scala 2380:18]
  assign wnimag_76 = 16'h8583; // @[Expression.scala 2380:18]
  assign wnimag_77 = 16'h8676; // @[Expression.scala 2380:18]
  assign wnimag_78 = 16'h877b; // @[Expression.scala 2380:18]
  assign wnimag_79 = 16'h8894; // @[Expression.scala 2380:18]
  assign wnimag_80 = 16'h89be; // @[Expression.scala 2380:18]
  assign wnimag_81 = 16'h8afb; // @[Expression.scala 2380:18]
  assign wnimag_82 = 16'h8c4a; // @[Expression.scala 2380:18]
  assign wnimag_83 = 16'h8dab; // @[Expression.scala 2380:18]
  assign wnimag_84 = 16'h8f1d; // @[Expression.scala 2380:18]
  assign wnimag_85 = 16'h90a1; // @[Expression.scala 2380:18]
  assign wnimag_86 = 16'h9236; // @[Expression.scala 2380:18]
  assign wnimag_87 = 16'h93dc; // @[Expression.scala 2380:18]
  assign wnimag_88 = 16'h9592; // @[Expression.scala 2380:18]
  assign wnimag_89 = 16'h9759; // @[Expression.scala 2380:18]
  assign wnimag_90 = 16'h9930; // @[Expression.scala 2380:18]
  assign wnimag_91 = 16'h9b17; // @[Expression.scala 2380:18]
  assign wnimag_92 = 16'h9d0e; // @[Expression.scala 2380:18]
  assign wnimag_93 = 16'h9f14; // @[Expression.scala 2380:18]
  assign wnimag_94 = 16'ha129; // @[Expression.scala 2380:18]
  assign wnimag_95 = 16'ha34c; // @[Expression.scala 2380:18]
  assign wnimag_96 = 16'ha57e; // @[Expression.scala 2380:18]
  assign wnimag_97 = 16'ha7bd; // @[Expression.scala 2380:18]
  assign wnimag_98 = 16'haa0a; // @[Expression.scala 2380:18]
  assign wnimag_99 = 16'hac65; // @[Expression.scala 2380:18]
  assign wnimag_100 = 16'haecc; // @[Expression.scala 2380:18]
  assign wnimag_101 = 16'hb140; // @[Expression.scala 2380:18]
  assign wnimag_102 = 16'hb3c0; // @[Expression.scala 2380:18]
  assign wnimag_103 = 16'hb64c; // @[Expression.scala 2380:18]
  assign wnimag_104 = 16'hb8e3; // @[Expression.scala 2380:18]
  assign wnimag_105 = 16'hbb85; // @[Expression.scala 2380:18]
  assign wnimag_106 = 16'hbe32; // @[Expression.scala 2380:18]
  assign wnimag_107 = 16'hc0e9; // @[Expression.scala 2380:18]
  assign wnimag_108 = 16'hc3a9; // @[Expression.scala 2380:18]
  assign wnimag_109 = 16'hc673; // @[Expression.scala 2380:18]
  assign wnimag_110 = 16'hc946; // @[Expression.scala 2380:18]
  assign wnimag_111 = 16'hcc21; // @[Expression.scala 2380:18]
  assign wnimag_112 = 16'hcf04; // @[Expression.scala 2380:18]
  assign wnimag_113 = 16'hd1ef; // @[Expression.scala 2380:18]
  assign wnimag_114 = 16'hd4e1; // @[Expression.scala 2380:18]
  assign wnimag_115 = 16'hd7d9; // @[Expression.scala 2380:18]
  assign wnimag_116 = 16'hdad8; // @[Expression.scala 2380:18]
  assign wnimag_117 = 16'hdddc; // @[Expression.scala 2380:18]
  assign wnimag_118 = 16'he0e6; // @[Expression.scala 2380:18]
  assign wnimag_119 = 16'he3f4; // @[Expression.scala 2380:18]
  assign wnimag_120 = 16'he707; // @[Expression.scala 2380:18]
  assign wnimag_121 = 16'hea1e; // @[Expression.scala 2380:18]
  assign wnimag_122 = 16'hed38; // @[Expression.scala 2380:18]
  assign wnimag_123 = 16'hf055; // @[Expression.scala 2380:18]
  assign wnimag_124 = 16'hf374; // @[Expression.scala 2380:18]
  assign wnimag_125 = 16'hf695; // @[Expression.scala 2380:18]
  assign wnimag_126 = 16'hf9b8; // @[Expression.scala 2380:18]
  assign wnimag_127 = 16'hfcdc; // @[Expression.scala 2380:18]
  assign io_wn_real = tmp_io_wn_real; // @[wn_rom.scala 39:14]
  assign io_wn_imag = tmp_io_wn_imag; // @[wn_rom.scala 40:14]

endmodule

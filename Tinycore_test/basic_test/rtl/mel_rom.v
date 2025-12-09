// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : mel_rom
// Git hash  : 85ee573ec2fdedb6c3867ea06589ef2968a1a761

`timescale 1ns/1ps 
module mel_rom (
  input      [7:0]    mel_filter_addr,
  output     [7:0]    mel_filter,
  input      [4:0]    mel_index_addr,
  output     [7:0]    mel_index,
  output     [3:0]    mel_len
);

  reg        [7:0]    tmp_mel_filter;
  reg        [11:0]   tmp_mel_len;
  reg        [11:0]   tmp_mel_index;
  wire       [7:0]    mel_data_0;
  wire       [7:0]    mel_data_1;
  wire       [7:0]    mel_data_2;
  wire       [7:0]    mel_data_3;
  wire       [7:0]    mel_data_4;
  wire       [7:0]    mel_data_5;
  wire       [7:0]    mel_data_6;
  wire       [7:0]    mel_data_7;
  wire       [7:0]    mel_data_8;
  wire       [7:0]    mel_data_9;
  wire       [7:0]    mel_data_10;
  wire       [7:0]    mel_data_11;
  wire       [7:0]    mel_data_12;
  wire       [7:0]    mel_data_13;
  wire       [7:0]    mel_data_14;
  wire       [7:0]    mel_data_15;
  wire       [7:0]    mel_data_16;
  wire       [7:0]    mel_data_17;
  wire       [7:0]    mel_data_18;
  wire       [7:0]    mel_data_19;
  wire       [7:0]    mel_data_20;
  wire       [7:0]    mel_data_21;
  wire       [7:0]    mel_data_22;
  wire       [7:0]    mel_data_23;
  wire       [7:0]    mel_data_24;
  wire       [7:0]    mel_data_25;
  wire       [7:0]    mel_data_26;
  wire       [7:0]    mel_data_27;
  wire       [7:0]    mel_data_28;
  wire       [7:0]    mel_data_29;
  wire       [7:0]    mel_data_30;
  wire       [7:0]    mel_data_31;
  wire       [7:0]    mel_data_32;
  wire       [7:0]    mel_data_33;
  wire       [7:0]    mel_data_34;
  wire       [7:0]    mel_data_35;
  wire       [7:0]    mel_data_36;
  wire       [7:0]    mel_data_37;
  wire       [7:0]    mel_data_38;
  wire       [7:0]    mel_data_39;
  wire       [7:0]    mel_data_40;
  wire       [7:0]    mel_data_41;
  wire       [7:0]    mel_data_42;
  wire       [7:0]    mel_data_43;
  wire       [7:0]    mel_data_44;
  wire       [7:0]    mel_data_45;
  wire       [7:0]    mel_data_46;
  wire       [7:0]    mel_data_47;
  wire       [7:0]    mel_data_48;
  wire       [7:0]    mel_data_49;
  wire       [7:0]    mel_data_50;
  wire       [7:0]    mel_data_51;
  wire       [7:0]    mel_data_52;
  wire       [7:0]    mel_data_53;
  wire       [7:0]    mel_data_54;
  wire       [7:0]    mel_data_55;
  wire       [7:0]    mel_data_56;
  wire       [7:0]    mel_data_57;
  wire       [7:0]    mel_data_58;
  wire       [7:0]    mel_data_59;
  wire       [7:0]    mel_data_60;
  wire       [7:0]    mel_data_61;
  wire       [7:0]    mel_data_62;
  wire       [7:0]    mel_data_63;
  wire       [7:0]    mel_data_64;
  wire       [7:0]    mel_data_65;
  wire       [7:0]    mel_data_66;
  wire       [7:0]    mel_data_67;
  wire       [7:0]    mel_data_68;
  wire       [7:0]    mel_data_69;
  wire       [7:0]    mel_data_70;
  wire       [7:0]    mel_data_71;
  wire       [7:0]    mel_data_72;
  wire       [7:0]    mel_data_73;
  wire       [7:0]    mel_data_74;
  wire       [7:0]    mel_data_75;
  wire       [7:0]    mel_data_76;
  wire       [7:0]    mel_data_77;
  wire       [7:0]    mel_data_78;
  wire       [7:0]    mel_data_79;
  wire       [7:0]    mel_data_80;
  wire       [7:0]    mel_data_81;
  wire       [7:0]    mel_data_82;
  wire       [7:0]    mel_data_83;
  wire       [7:0]    mel_data_84;
  wire       [7:0]    mel_data_85;
  wire       [7:0]    mel_data_86;
  wire       [7:0]    mel_data_87;
  wire       [7:0]    mel_data_88;
  wire       [7:0]    mel_data_89;
  wire       [7:0]    mel_data_90;
  wire       [7:0]    mel_data_91;
  wire       [7:0]    mel_data_92;
  wire       [7:0]    mel_data_93;
  wire       [7:0]    mel_data_94;
  wire       [7:0]    mel_data_95;
  wire       [7:0]    mel_data_96;
  wire       [7:0]    mel_data_97;
  wire       [7:0]    mel_data_98;
  wire       [7:0]    mel_data_99;
  wire       [7:0]    mel_data_100;
  wire       [7:0]    mel_data_101;
  wire       [7:0]    mel_data_102;
  wire       [7:0]    mel_data_103;
  wire       [7:0]    mel_data_104;
  wire       [7:0]    mel_data_105;
  wire       [7:0]    mel_data_106;
  wire       [7:0]    mel_data_107;
  wire       [7:0]    mel_data_108;
  wire       [7:0]    mel_data_109;
  wire       [7:0]    mel_data_110;
  wire       [7:0]    mel_data_111;
  wire       [7:0]    mel_data_112;
  wire       [7:0]    mel_data_113;
  wire       [7:0]    mel_data_114;
  wire       [7:0]    mel_data_115;
  wire       [7:0]    mel_data_116;
  wire       [7:0]    mel_data_117;
  wire       [7:0]    mel_data_118;
  wire       [7:0]    mel_data_119;
  wire       [7:0]    mel_data_120;
  wire       [7:0]    mel_data_121;
  wire       [7:0]    mel_data_122;
  wire       [7:0]    mel_data_123;
  wire       [7:0]    mel_data_124;
  wire       [7:0]    mel_data_125;
  wire       [7:0]    mel_data_126;
  wire       [7:0]    mel_data_127;
  wire       [7:0]    mel_data_128;
  wire       [7:0]    mel_data_129;
  wire       [7:0]    mel_data_130;
  wire       [7:0]    mel_data_131;
  wire       [7:0]    mel_data_132;
  wire       [7:0]    mel_data_133;
  wire       [7:0]    mel_data_134;
  wire       [7:0]    mel_data_135;
  wire       [7:0]    mel_data_136;
  wire       [7:0]    mel_data_137;
  wire       [7:0]    mel_data_138;
  wire       [7:0]    mel_data_139;
  wire       [7:0]    mel_data_140;
  wire       [7:0]    mel_data_141;
  wire       [7:0]    mel_data_142;
  wire       [7:0]    mel_data_143;
  wire       [7:0]    mel_data_144;
  wire       [7:0]    mel_data_145;
  wire       [7:0]    mel_data_146;
  wire       [7:0]    mel_data_147;
  wire       [7:0]    mel_data_148;
  wire       [7:0]    mel_data_149;
  wire       [7:0]    mel_data_150;
  wire       [7:0]    mel_data_151;
  wire       [7:0]    mel_data_152;
  wire       [7:0]    mel_data_153;
  wire       [7:0]    mel_data_154;
  wire       [7:0]    mel_data_155;
  wire       [7:0]    mel_data_156;
  wire       [7:0]    mel_data_157;
  wire       [7:0]    mel_data_158;
  wire       [7:0]    mel_data_159;
  wire       [7:0]    mel_data_160;
  wire       [7:0]    mel_data_161;
  wire       [7:0]    mel_data_162;
  wire       [7:0]    mel_data_163;
  wire       [7:0]    mel_data_164;
  wire       [7:0]    mel_data_165;
  wire       [7:0]    mel_data_166;
  wire       [7:0]    mel_data_167;
  wire       [7:0]    mel_data_168;
  wire       [7:0]    mel_data_169;
  wire       [7:0]    mel_data_170;
  wire       [7:0]    mel_data_171;
  wire       [7:0]    mel_data_172;
  wire       [7:0]    mel_data_173;
  wire       [7:0]    mel_data_174;
  wire       [7:0]    mel_data_175;
  wire       [7:0]    mel_data_176;
  wire       [7:0]    mel_data_177;
  wire       [7:0]    mel_data_178;
  wire       [7:0]    mel_data_179;
  wire       [7:0]    mel_data_180;
  wire       [7:0]    mel_data_181;
  wire       [7:0]    mel_data_182;
  wire       [7:0]    mel_data_183;
  wire       [7:0]    mel_data_184;
  wire       [7:0]    mel_data_185;
  wire       [7:0]    mel_data_186;
  wire       [7:0]    mel_data_187;
  wire       [7:0]    mel_data_188;
  wire       [7:0]    mel_data_189;
  wire       [7:0]    mel_data_190;
  wire       [7:0]    mel_data_191;
  wire       [7:0]    mel_data_192;
  wire       [7:0]    mel_data_193;
  wire       [7:0]    mel_data_194;
  wire       [7:0]    mel_data_195;
  wire       [7:0]    mel_data_196;
  wire       [7:0]    mel_data_197;
  wire       [7:0]    mel_data_198;
  wire       [7:0]    mel_data_199;
  wire       [7:0]    mel_data_200;
  wire       [7:0]    mel_data_201;
  wire       [7:0]    mel_data_202;
  wire       [11:0]   mel_index_data_0;
  wire       [11:0]   mel_index_data_1;
  wire       [11:0]   mel_index_data_2;
  wire       [11:0]   mel_index_data_3;
  wire       [11:0]   mel_index_data_4;
  wire       [11:0]   mel_index_data_5;
  wire       [11:0]   mel_index_data_6;
  wire       [11:0]   mel_index_data_7;
  wire       [11:0]   mel_index_data_8;
  wire       [11:0]   mel_index_data_9;
  wire       [11:0]   mel_index_data_10;
  wire       [11:0]   mel_index_data_11;
  wire       [11:0]   mel_index_data_12;
  wire       [11:0]   mel_index_data_13;
  wire       [11:0]   mel_index_data_14;
  wire       [11:0]   mel_index_data_15;
  wire       [11:0]   mel_index_data_16;
  wire       [11:0]   mel_index_data_17;
  wire       [11:0]   mel_index_data_18;
  wire       [11:0]   mel_index_data_19;
  wire       [11:0]   mel_index_data_20;
  wire       [11:0]   mel_index_data_21;
  wire       [11:0]   mel_index_data_22;
  wire       [11:0]   mel_index_data_23;
  wire       [11:0]   mel_index_data_24;
  wire       [11:0]   mel_index_data_25;
  wire       [11:0]   mel_index_data_26;
  wire       [11:0]   mel_index_data_27;
  wire       [11:0]   mel_index_data_28;
  wire       [11:0]   mel_index_data_29;

  always @(*) begin
    case(mel_filter_addr)
      8'b00000000 : tmp_mel_filter = mel_data_0;
      8'b00000001 : tmp_mel_filter = mel_data_1;
      8'b00000010 : tmp_mel_filter = mel_data_2;
      8'b00000011 : tmp_mel_filter = mel_data_3;
      8'b00000100 : tmp_mel_filter = mel_data_4;
      8'b00000101 : tmp_mel_filter = mel_data_5;
      8'b00000110 : tmp_mel_filter = mel_data_6;
      8'b00000111 : tmp_mel_filter = mel_data_7;
      8'b00001000 : tmp_mel_filter = mel_data_8;
      8'b00001001 : tmp_mel_filter = mel_data_9;
      8'b00001010 : tmp_mel_filter = mel_data_10;
      8'b00001011 : tmp_mel_filter = mel_data_11;
      8'b00001100 : tmp_mel_filter = mel_data_12;
      8'b00001101 : tmp_mel_filter = mel_data_13;
      8'b00001110 : tmp_mel_filter = mel_data_14;
      8'b00001111 : tmp_mel_filter = mel_data_15;
      8'b00010000 : tmp_mel_filter = mel_data_16;
      8'b00010001 : tmp_mel_filter = mel_data_17;
      8'b00010010 : tmp_mel_filter = mel_data_18;
      8'b00010011 : tmp_mel_filter = mel_data_19;
      8'b00010100 : tmp_mel_filter = mel_data_20;
      8'b00010101 : tmp_mel_filter = mel_data_21;
      8'b00010110 : tmp_mel_filter = mel_data_22;
      8'b00010111 : tmp_mel_filter = mel_data_23;
      8'b00011000 : tmp_mel_filter = mel_data_24;
      8'b00011001 : tmp_mel_filter = mel_data_25;
      8'b00011010 : tmp_mel_filter = mel_data_26;
      8'b00011011 : tmp_mel_filter = mel_data_27;
      8'b00011100 : tmp_mel_filter = mel_data_28;
      8'b00011101 : tmp_mel_filter = mel_data_29;
      8'b00011110 : tmp_mel_filter = mel_data_30;
      8'b00011111 : tmp_mel_filter = mel_data_31;
      8'b00100000 : tmp_mel_filter = mel_data_32;
      8'b00100001 : tmp_mel_filter = mel_data_33;
      8'b00100010 : tmp_mel_filter = mel_data_34;
      8'b00100011 : tmp_mel_filter = mel_data_35;
      8'b00100100 : tmp_mel_filter = mel_data_36;
      8'b00100101 : tmp_mel_filter = mel_data_37;
      8'b00100110 : tmp_mel_filter = mel_data_38;
      8'b00100111 : tmp_mel_filter = mel_data_39;
      8'b00101000 : tmp_mel_filter = mel_data_40;
      8'b00101001 : tmp_mel_filter = mel_data_41;
      8'b00101010 : tmp_mel_filter = mel_data_42;
      8'b00101011 : tmp_mel_filter = mel_data_43;
      8'b00101100 : tmp_mel_filter = mel_data_44;
      8'b00101101 : tmp_mel_filter = mel_data_45;
      8'b00101110 : tmp_mel_filter = mel_data_46;
      8'b00101111 : tmp_mel_filter = mel_data_47;
      8'b00110000 : tmp_mel_filter = mel_data_48;
      8'b00110001 : tmp_mel_filter = mel_data_49;
      8'b00110010 : tmp_mel_filter = mel_data_50;
      8'b00110011 : tmp_mel_filter = mel_data_51;
      8'b00110100 : tmp_mel_filter = mel_data_52;
      8'b00110101 : tmp_mel_filter = mel_data_53;
      8'b00110110 : tmp_mel_filter = mel_data_54;
      8'b00110111 : tmp_mel_filter = mel_data_55;
      8'b00111000 : tmp_mel_filter = mel_data_56;
      8'b00111001 : tmp_mel_filter = mel_data_57;
      8'b00111010 : tmp_mel_filter = mel_data_58;
      8'b00111011 : tmp_mel_filter = mel_data_59;
      8'b00111100 : tmp_mel_filter = mel_data_60;
      8'b00111101 : tmp_mel_filter = mel_data_61;
      8'b00111110 : tmp_mel_filter = mel_data_62;
      8'b00111111 : tmp_mel_filter = mel_data_63;
      8'b01000000 : tmp_mel_filter = mel_data_64;
      8'b01000001 : tmp_mel_filter = mel_data_65;
      8'b01000010 : tmp_mel_filter = mel_data_66;
      8'b01000011 : tmp_mel_filter = mel_data_67;
      8'b01000100 : tmp_mel_filter = mel_data_68;
      8'b01000101 : tmp_mel_filter = mel_data_69;
      8'b01000110 : tmp_mel_filter = mel_data_70;
      8'b01000111 : tmp_mel_filter = mel_data_71;
      8'b01001000 : tmp_mel_filter = mel_data_72;
      8'b01001001 : tmp_mel_filter = mel_data_73;
      8'b01001010 : tmp_mel_filter = mel_data_74;
      8'b01001011 : tmp_mel_filter = mel_data_75;
      8'b01001100 : tmp_mel_filter = mel_data_76;
      8'b01001101 : tmp_mel_filter = mel_data_77;
      8'b01001110 : tmp_mel_filter = mel_data_78;
      8'b01001111 : tmp_mel_filter = mel_data_79;
      8'b01010000 : tmp_mel_filter = mel_data_80;
      8'b01010001 : tmp_mel_filter = mel_data_81;
      8'b01010010 : tmp_mel_filter = mel_data_82;
      8'b01010011 : tmp_mel_filter = mel_data_83;
      8'b01010100 : tmp_mel_filter = mel_data_84;
      8'b01010101 : tmp_mel_filter = mel_data_85;
      8'b01010110 : tmp_mel_filter = mel_data_86;
      8'b01010111 : tmp_mel_filter = mel_data_87;
      8'b01011000 : tmp_mel_filter = mel_data_88;
      8'b01011001 : tmp_mel_filter = mel_data_89;
      8'b01011010 : tmp_mel_filter = mel_data_90;
      8'b01011011 : tmp_mel_filter = mel_data_91;
      8'b01011100 : tmp_mel_filter = mel_data_92;
      8'b01011101 : tmp_mel_filter = mel_data_93;
      8'b01011110 : tmp_mel_filter = mel_data_94;
      8'b01011111 : tmp_mel_filter = mel_data_95;
      8'b01100000 : tmp_mel_filter = mel_data_96;
      8'b01100001 : tmp_mel_filter = mel_data_97;
      8'b01100010 : tmp_mel_filter = mel_data_98;
      8'b01100011 : tmp_mel_filter = mel_data_99;
      8'b01100100 : tmp_mel_filter = mel_data_100;
      8'b01100101 : tmp_mel_filter = mel_data_101;
      8'b01100110 : tmp_mel_filter = mel_data_102;
      8'b01100111 : tmp_mel_filter = mel_data_103;
      8'b01101000 : tmp_mel_filter = mel_data_104;
      8'b01101001 : tmp_mel_filter = mel_data_105;
      8'b01101010 : tmp_mel_filter = mel_data_106;
      8'b01101011 : tmp_mel_filter = mel_data_107;
      8'b01101100 : tmp_mel_filter = mel_data_108;
      8'b01101101 : tmp_mel_filter = mel_data_109;
      8'b01101110 : tmp_mel_filter = mel_data_110;
      8'b01101111 : tmp_mel_filter = mel_data_111;
      8'b01110000 : tmp_mel_filter = mel_data_112;
      8'b01110001 : tmp_mel_filter = mel_data_113;
      8'b01110010 : tmp_mel_filter = mel_data_114;
      8'b01110011 : tmp_mel_filter = mel_data_115;
      8'b01110100 : tmp_mel_filter = mel_data_116;
      8'b01110101 : tmp_mel_filter = mel_data_117;
      8'b01110110 : tmp_mel_filter = mel_data_118;
      8'b01110111 : tmp_mel_filter = mel_data_119;
      8'b01111000 : tmp_mel_filter = mel_data_120;
      8'b01111001 : tmp_mel_filter = mel_data_121;
      8'b01111010 : tmp_mel_filter = mel_data_122;
      8'b01111011 : tmp_mel_filter = mel_data_123;
      8'b01111100 : tmp_mel_filter = mel_data_124;
      8'b01111101 : tmp_mel_filter = mel_data_125;
      8'b01111110 : tmp_mel_filter = mel_data_126;
      8'b01111111 : tmp_mel_filter = mel_data_127;
      8'b10000000 : tmp_mel_filter = mel_data_128;
      8'b10000001 : tmp_mel_filter = mel_data_129;
      8'b10000010 : tmp_mel_filter = mel_data_130;
      8'b10000011 : tmp_mel_filter = mel_data_131;
      8'b10000100 : tmp_mel_filter = mel_data_132;
      8'b10000101 : tmp_mel_filter = mel_data_133;
      8'b10000110 : tmp_mel_filter = mel_data_134;
      8'b10000111 : tmp_mel_filter = mel_data_135;
      8'b10001000 : tmp_mel_filter = mel_data_136;
      8'b10001001 : tmp_mel_filter = mel_data_137;
      8'b10001010 : tmp_mel_filter = mel_data_138;
      8'b10001011 : tmp_mel_filter = mel_data_139;
      8'b10001100 : tmp_mel_filter = mel_data_140;
      8'b10001101 : tmp_mel_filter = mel_data_141;
      8'b10001110 : tmp_mel_filter = mel_data_142;
      8'b10001111 : tmp_mel_filter = mel_data_143;
      8'b10010000 : tmp_mel_filter = mel_data_144;
      8'b10010001 : tmp_mel_filter = mel_data_145;
      8'b10010010 : tmp_mel_filter = mel_data_146;
      8'b10010011 : tmp_mel_filter = mel_data_147;
      8'b10010100 : tmp_mel_filter = mel_data_148;
      8'b10010101 : tmp_mel_filter = mel_data_149;
      8'b10010110 : tmp_mel_filter = mel_data_150;
      8'b10010111 : tmp_mel_filter = mel_data_151;
      8'b10011000 : tmp_mel_filter = mel_data_152;
      8'b10011001 : tmp_mel_filter = mel_data_153;
      8'b10011010 : tmp_mel_filter = mel_data_154;
      8'b10011011 : tmp_mel_filter = mel_data_155;
      8'b10011100 : tmp_mel_filter = mel_data_156;
      8'b10011101 : tmp_mel_filter = mel_data_157;
      8'b10011110 : tmp_mel_filter = mel_data_158;
      8'b10011111 : tmp_mel_filter = mel_data_159;
      8'b10100000 : tmp_mel_filter = mel_data_160;
      8'b10100001 : tmp_mel_filter = mel_data_161;
      8'b10100010 : tmp_mel_filter = mel_data_162;
      8'b10100011 : tmp_mel_filter = mel_data_163;
      8'b10100100 : tmp_mel_filter = mel_data_164;
      8'b10100101 : tmp_mel_filter = mel_data_165;
      8'b10100110 : tmp_mel_filter = mel_data_166;
      8'b10100111 : tmp_mel_filter = mel_data_167;
      8'b10101000 : tmp_mel_filter = mel_data_168;
      8'b10101001 : tmp_mel_filter = mel_data_169;
      8'b10101010 : tmp_mel_filter = mel_data_170;
      8'b10101011 : tmp_mel_filter = mel_data_171;
      8'b10101100 : tmp_mel_filter = mel_data_172;
      8'b10101101 : tmp_mel_filter = mel_data_173;
      8'b10101110 : tmp_mel_filter = mel_data_174;
      8'b10101111 : tmp_mel_filter = mel_data_175;
      8'b10110000 : tmp_mel_filter = mel_data_176;
      8'b10110001 : tmp_mel_filter = mel_data_177;
      8'b10110010 : tmp_mel_filter = mel_data_178;
      8'b10110011 : tmp_mel_filter = mel_data_179;
      8'b10110100 : tmp_mel_filter = mel_data_180;
      8'b10110101 : tmp_mel_filter = mel_data_181;
      8'b10110110 : tmp_mel_filter = mel_data_182;
      8'b10110111 : tmp_mel_filter = mel_data_183;
      8'b10111000 : tmp_mel_filter = mel_data_184;
      8'b10111001 : tmp_mel_filter = mel_data_185;
      8'b10111010 : tmp_mel_filter = mel_data_186;
      8'b10111011 : tmp_mel_filter = mel_data_187;
      8'b10111100 : tmp_mel_filter = mel_data_188;
      8'b10111101 : tmp_mel_filter = mel_data_189;
      8'b10111110 : tmp_mel_filter = mel_data_190;
      8'b10111111 : tmp_mel_filter = mel_data_191;
      8'b11000000 : tmp_mel_filter = mel_data_192;
      8'b11000001 : tmp_mel_filter = mel_data_193;
      8'b11000010 : tmp_mel_filter = mel_data_194;
      8'b11000011 : tmp_mel_filter = mel_data_195;
      8'b11000100 : tmp_mel_filter = mel_data_196;
      8'b11000101 : tmp_mel_filter = mel_data_197;
      8'b11000110 : tmp_mel_filter = mel_data_198;
      8'b11000111 : tmp_mel_filter = mel_data_199;
      8'b11001000 : tmp_mel_filter = mel_data_200;
      8'b11001001 : tmp_mel_filter = mel_data_201;
      default : tmp_mel_filter = mel_data_202;
    endcase
  end

  always @(*) begin
    case(mel_index_addr)
      5'b00000 : begin
        tmp_mel_len = mel_index_data_0;
        tmp_mel_index = mel_index_data_0;
      end
      5'b00001 : begin
        tmp_mel_len = mel_index_data_1;
        tmp_mel_index = mel_index_data_1;
      end
      5'b00010 : begin
        tmp_mel_len = mel_index_data_2;
        tmp_mel_index = mel_index_data_2;
      end
      5'b00011 : begin
        tmp_mel_len = mel_index_data_3;
        tmp_mel_index = mel_index_data_3;
      end
      5'b00100 : begin
        tmp_mel_len = mel_index_data_4;
        tmp_mel_index = mel_index_data_4;
      end
      5'b00101 : begin
        tmp_mel_len = mel_index_data_5;
        tmp_mel_index = mel_index_data_5;
      end
      5'b00110 : begin
        tmp_mel_len = mel_index_data_6;
        tmp_mel_index = mel_index_data_6;
      end
      5'b00111 : begin
        tmp_mel_len = mel_index_data_7;
        tmp_mel_index = mel_index_data_7;
      end
      5'b01000 : begin
        tmp_mel_len = mel_index_data_8;
        tmp_mel_index = mel_index_data_8;
      end
      5'b01001 : begin
        tmp_mel_len = mel_index_data_9;
        tmp_mel_index = mel_index_data_9;
      end
      5'b01010 : begin
        tmp_mel_len = mel_index_data_10;
        tmp_mel_index = mel_index_data_10;
      end
      5'b01011 : begin
        tmp_mel_len = mel_index_data_11;
        tmp_mel_index = mel_index_data_11;
      end
      5'b01100 : begin
        tmp_mel_len = mel_index_data_12;
        tmp_mel_index = mel_index_data_12;
      end
      5'b01101 : begin
        tmp_mel_len = mel_index_data_13;
        tmp_mel_index = mel_index_data_13;
      end
      5'b01110 : begin
        tmp_mel_len = mel_index_data_14;
        tmp_mel_index = mel_index_data_14;
      end
      5'b01111 : begin
        tmp_mel_len = mel_index_data_15;
        tmp_mel_index = mel_index_data_15;
      end
      5'b10000 : begin
        tmp_mel_len = mel_index_data_16;
        tmp_mel_index = mel_index_data_16;
      end
      5'b10001 : begin
        tmp_mel_len = mel_index_data_17;
        tmp_mel_index = mel_index_data_17;
      end
      5'b10010 : begin
        tmp_mel_len = mel_index_data_18;
        tmp_mel_index = mel_index_data_18;
      end
      5'b10011 : begin
        tmp_mel_len = mel_index_data_19;
        tmp_mel_index = mel_index_data_19;
      end
      5'b10100 : begin
        tmp_mel_len = mel_index_data_20;
        tmp_mel_index = mel_index_data_20;
      end
      5'b10101 : begin
        tmp_mel_len = mel_index_data_21;
        tmp_mel_index = mel_index_data_21;
      end
      5'b10110 : begin
        tmp_mel_len = mel_index_data_22;
        tmp_mel_index = mel_index_data_22;
      end
      5'b10111 : begin
        tmp_mel_len = mel_index_data_23;
        tmp_mel_index = mel_index_data_23;
      end
      5'b11000 : begin
        tmp_mel_len = mel_index_data_24;
        tmp_mel_index = mel_index_data_24;
      end
      5'b11001 : begin
        tmp_mel_len = mel_index_data_25;
        tmp_mel_index = mel_index_data_25;
      end
      5'b11010 : begin
        tmp_mel_len = mel_index_data_26;
        tmp_mel_index = mel_index_data_26;
      end
      5'b11011 : begin
        tmp_mel_len = mel_index_data_27;
        tmp_mel_index = mel_index_data_27;
      end
      5'b11100 : begin
        tmp_mel_len = mel_index_data_28;
        tmp_mel_index = mel_index_data_28;
      end
      default : begin
        tmp_mel_len = mel_index_data_29;
        tmp_mel_index = mel_index_data_29;
      end
    endcase
  end

  assign mel_data_0 = 8'h52; // @[Expression.scala 2342:18]
  assign mel_data_1 = 8'hf3; // @[Expression.scala 2342:18]
  assign mel_data_2 = 8'h43; // @[Expression.scala 2342:18]
  assign mel_data_3 = 8'h0c; // @[Expression.scala 2342:18]
  assign mel_data_4 = 8'hbc; // @[Expression.scala 2342:18]
  assign mel_data_5 = 8'h98; // @[Expression.scala 2342:18]
  assign mel_data_6 = 8'h67; // @[Expression.scala 2342:18]
  assign mel_data_7 = 8'hf0; // @[Expression.scala 2342:18]
  assign mel_data_8 = 8'h52; // @[Expression.scala 2342:18]
  assign mel_data_9 = 8'h0f; // @[Expression.scala 2342:18]
  assign mel_data_10 = 8'had; // @[Expression.scala 2342:18]
  assign mel_data_11 = 8'hb7; // @[Expression.scala 2342:18]
  assign mel_data_12 = 8'h21; // @[Expression.scala 2342:18]
  assign mel_data_13 = 8'h48; // @[Expression.scala 2342:18]
  assign mel_data_14 = 8'hde; // @[Expression.scala 2342:18]
  assign mel_data_15 = 8'h90; // @[Expression.scala 2342:18]
  assign mel_data_16 = 8'h02; // @[Expression.scala 2342:18]
  assign mel_data_17 = 8'h6f; // @[Expression.scala 2342:18]
  assign mel_data_18 = 8'hfd; // @[Expression.scala 2342:18]
  assign mel_data_19 = 8'h7a; // @[Expression.scala 2342:18]
  assign mel_data_20 = 8'h85; // @[Expression.scala 2342:18]
  assign mel_data_21 = 8'hf3; // @[Expression.scala 2342:18]
  assign mel_data_22 = 8'h73; // @[Expression.scala 2342:18]
  assign mel_data_23 = 8'h0c; // @[Expression.scala 2342:18]
  assign mel_data_24 = 8'h8c; // @[Expression.scala 2342:18]
  assign mel_data_25 = 8'hf3; // @[Expression.scala 2342:18]
  assign mel_data_26 = 8'h7a; // @[Expression.scala 2342:18]
  assign mel_data_27 = 8'h01; // @[Expression.scala 2342:18]
  assign mel_data_28 = 8'h0c; // @[Expression.scala 2342:18]
  assign mel_data_29 = 8'h85; // @[Expression.scala 2342:18]
  assign mel_data_30 = 8'hfe; // @[Expression.scala 2342:18]
  assign mel_data_31 = 8'h8d; // @[Expression.scala 2342:18]
  assign mel_data_32 = 8'h1b; // @[Expression.scala 2342:18]
  assign mel_data_33 = 8'h72; // @[Expression.scala 2342:18]
  assign mel_data_34 = 8'he4; // @[Expression.scala 2342:18]
  assign mel_data_35 = 8'hab; // @[Expression.scala 2342:18]
  assign mel_data_36 = 8'h3f; // @[Expression.scala 2342:18]
  assign mel_data_37 = 8'h54; // @[Expression.scala 2342:18]
  assign mel_data_38 = 8'hc0; // @[Expression.scala 2342:18]
  assign mel_data_39 = 8'hd3; // @[Expression.scala 2342:18]
  assign mel_data_40 = 8'h6c; // @[Expression.scala 2342:18]
  assign mel_data_41 = 8'h05; // @[Expression.scala 2342:18]
  assign mel_data_42 = 8'h2c; // @[Expression.scala 2342:18]
  assign mel_data_43 = 8'h93; // @[Expression.scala 2342:18]
  assign mel_data_44 = 8'hfa; // @[Expression.scala 2342:18]
  assign mel_data_45 = 8'ha2; // @[Expression.scala 2342:18]
  assign mel_data_46 = 8'h40; // @[Expression.scala 2342:18]
  assign mel_data_47 = 8'h5d; // @[Expression.scala 2342:18]
  assign mel_data_48 = 8'hbf; // @[Expression.scala 2342:18]
  assign mel_data_49 = 8'hdf; // @[Expression.scala 2342:18]
  assign mel_data_50 = 8'h83; // @[Expression.scala 2342:18]
  assign mel_data_51 = 8'h26; // @[Expression.scala 2342:18]
  assign mel_data_52 = 8'h20; // @[Expression.scala 2342:18]
  assign mel_data_53 = 8'h7c; // @[Expression.scala 2342:18]
  assign mel_data_54 = 8'hd9; // @[Expression.scala 2342:18]
  assign mel_data_55 = 8'hcb; // @[Expression.scala 2342:18]
  assign mel_data_56 = 8'h73; // @[Expression.scala 2342:18]
  assign mel_data_57 = 8'h1c; // @[Expression.scala 2342:18]
  assign mel_data_58 = 8'h34; // @[Expression.scala 2342:18]
  assign mel_data_59 = 8'h8c; // @[Expression.scala 2342:18]
  assign mel_data_60 = 8'he3; // @[Expression.scala 2342:18]
  assign mel_data_61 = 8'hc6; // @[Expression.scala 2342:18]
  assign mel_data_62 = 8'h73; // @[Expression.scala 2342:18]
  assign mel_data_63 = 8'h1f; // @[Expression.scala 2342:18]
  assign mel_data_64 = 8'h39; // @[Expression.scala 2342:18]
  assign mel_data_65 = 8'h8c; // @[Expression.scala 2342:18]
  assign mel_data_66 = 8'he0; // @[Expression.scala 2342:18]
  assign mel_data_67 = 8'hce; // @[Expression.scala 2342:18]
  assign mel_data_68 = 8'h7f; // @[Expression.scala 2342:18]
  assign mel_data_69 = 8'h30; // @[Expression.scala 2342:18]
  assign mel_data_70 = 8'h31; // @[Expression.scala 2342:18]
  assign mel_data_71 = 8'h80; // @[Expression.scala 2342:18]
  assign mel_data_72 = 8'hcf; // @[Expression.scala 2342:18]
  assign mel_data_73 = 8'he2; // @[Expression.scala 2342:18]
  assign mel_data_74 = 8'h97; // @[Expression.scala 2342:18]
  assign mel_data_75 = 8'h4c; // @[Expression.scala 2342:18]
  assign mel_data_76 = 8'h01; // @[Expression.scala 2342:18]
  assign mel_data_77 = 8'h1d; // @[Expression.scala 2342:18]
  assign mel_data_78 = 8'h68; // @[Expression.scala 2342:18]
  assign mel_data_79 = 8'hb3; // @[Expression.scala 2342:18]
  assign mel_data_80 = 8'hfe; // @[Expression.scala 2342:18]
  assign mel_data_81 = 8'hba; // @[Expression.scala 2342:18]
  assign mel_data_82 = 8'h73; // @[Expression.scala 2342:18]
  assign mel_data_83 = 8'h2c; // @[Expression.scala 2342:18]
  assign mel_data_84 = 8'h45; // @[Expression.scala 2342:18]
  assign mel_data_85 = 8'h8c; // @[Expression.scala 2342:18]
  assign mel_data_86 = 8'hd3; // @[Expression.scala 2342:18]
  assign mel_data_87 = 8'he5; // @[Expression.scala 2342:18]
  assign mel_data_88 = 8'ha2; // @[Expression.scala 2342:18]
  assign mel_data_89 = 8'h5f; // @[Expression.scala 2342:18]
  assign mel_data_90 = 8'h1c; // @[Expression.scala 2342:18]
  assign mel_data_91 = 8'h1a; // @[Expression.scala 2342:18]
  assign mel_data_92 = 8'h5d; // @[Expression.scala 2342:18]
  assign mel_data_93 = 8'ha0; // @[Expression.scala 2342:18]
  assign mel_data_94 = 8'he3; // @[Expression.scala 2342:18]
  assign mel_data_95 = 8'hda; // @[Expression.scala 2342:18]
  assign mel_data_96 = 8'h9a; // @[Expression.scala 2342:18]
  assign mel_data_97 = 8'h5a; // @[Expression.scala 2342:18]
  assign mel_data_98 = 8'h1b; // @[Expression.scala 2342:18]
  assign mel_data_99 = 8'h25; // @[Expression.scala 2342:18]
  assign mel_data_100 = 8'h65; // @[Expression.scala 2342:18]
  assign mel_data_101 = 8'ha5; // @[Expression.scala 2342:18]
  assign mel_data_102 = 8'he4; // @[Expression.scala 2342:18]
  assign mel_data_103 = 8'hdc; // @[Expression.scala 2342:18]
  assign mel_data_104 = 8'h9f; // @[Expression.scala 2342:18]
  assign mel_data_105 = 8'h63; // @[Expression.scala 2342:18]
  assign mel_data_106 = 8'h27; // @[Expression.scala 2342:18]
  assign mel_data_107 = 8'h23; // @[Expression.scala 2342:18]
  assign mel_data_108 = 8'h60; // @[Expression.scala 2342:18]
  assign mel_data_109 = 8'h9c; // @[Expression.scala 2342:18]
  assign mel_data_110 = 8'hd8; // @[Expression.scala 2342:18]
  assign mel_data_111 = 8'hea; // @[Expression.scala 2342:18]
  assign mel_data_112 = 8'hb1; // @[Expression.scala 2342:18]
  assign mel_data_113 = 8'h78; // @[Expression.scala 2342:18]
  assign mel_data_114 = 8'h3f; // @[Expression.scala 2342:18]
  assign mel_data_115 = 8'h06; // @[Expression.scala 2342:18]
  assign mel_data_116 = 8'h15; // @[Expression.scala 2342:18]
  assign mel_data_117 = 8'h4e; // @[Expression.scala 2342:18]
  assign mel_data_118 = 8'h87; // @[Expression.scala 2342:18]
  assign mel_data_119 = 8'hc0; // @[Expression.scala 2342:18]
  assign mel_data_120 = 8'hf9; // @[Expression.scala 2342:18]
  assign mel_data_121 = 8'hce; // @[Expression.scala 2342:18]
  assign mel_data_122 = 8'h98; // @[Expression.scala 2342:18]
  assign mel_data_123 = 8'h62; // @[Expression.scala 2342:18]
  assign mel_data_124 = 8'h2b; // @[Expression.scala 2342:18]
  assign mel_data_125 = 8'h31; // @[Expression.scala 2342:18]
  assign mel_data_126 = 8'h67; // @[Expression.scala 2342:18]
  assign mel_data_127 = 8'h9d; // @[Expression.scala 2342:18]
  assign mel_data_128 = 8'hd4; // @[Expression.scala 2342:18]
  assign mel_data_129 = 8'hf5; // @[Expression.scala 2342:18]
  assign mel_data_130 = 8'hc1; // @[Expression.scala 2342:18]
  assign mel_data_131 = 8'h8e; // @[Expression.scala 2342:18]
  assign mel_data_132 = 8'h5a; // @[Expression.scala 2342:18]
  assign mel_data_133 = 8'h27; // @[Expression.scala 2342:18]
  assign mel_data_134 = 8'h0a; // @[Expression.scala 2342:18]
  assign mel_data_135 = 8'h3e; // @[Expression.scala 2342:18]
  assign mel_data_136 = 8'h71; // @[Expression.scala 2342:18]
  assign mel_data_137 = 8'ha5; // @[Expression.scala 2342:18]
  assign mel_data_138 = 8'hd8; // @[Expression.scala 2342:18]
  assign mel_data_139 = 8'hf3; // @[Expression.scala 2342:18]
  assign mel_data_140 = 8'hc2; // @[Expression.scala 2342:18]
  assign mel_data_141 = 8'h92; // @[Expression.scala 2342:18]
  assign mel_data_142 = 8'h61; // @[Expression.scala 2342:18]
  assign mel_data_143 = 8'h30; // @[Expression.scala 2342:18]
  assign mel_data_144 = 8'h0c; // @[Expression.scala 2342:18]
  assign mel_data_145 = 8'h3d; // @[Expression.scala 2342:18]
  assign mel_data_146 = 8'h6d; // @[Expression.scala 2342:18]
  assign mel_data_147 = 8'h9e; // @[Expression.scala 2342:18]
  assign mel_data_148 = 8'hcf; // @[Expression.scala 2342:18]
  assign mel_data_149 = 8'hff; // @[Expression.scala 2342:18]
  assign mel_data_150 = 8'hd0; // @[Expression.scala 2342:18]
  assign mel_data_151 = 8'ha2; // @[Expression.scala 2342:18]
  assign mel_data_152 = 8'h74; // @[Expression.scala 2342:18]
  assign mel_data_153 = 8'h46; // @[Expression.scala 2342:18]
  assign mel_data_154 = 8'h18; // @[Expression.scala 2342:18]
  assign mel_data_155 = 8'h2f; // @[Expression.scala 2342:18]
  assign mel_data_156 = 8'h5d; // @[Expression.scala 2342:18]
  assign mel_data_157 = 8'h8b; // @[Expression.scala 2342:18]
  assign mel_data_158 = 8'hb9; // @[Expression.scala 2342:18]
  assign mel_data_159 = 8'he7; // @[Expression.scala 2342:18]
  assign mel_data_160 = 8'hea; // @[Expression.scala 2342:18]
  assign mel_data_161 = 8'hbe; // @[Expression.scala 2342:18]
  assign mel_data_162 = 8'h92; // @[Expression.scala 2342:18]
  assign mel_data_163 = 8'h66; // @[Expression.scala 2342:18]
  assign mel_data_164 = 8'h3a; // @[Expression.scala 2342:18]
  assign mel_data_165 = 8'h0f; // @[Expression.scala 2342:18]
  assign mel_data_166 = 8'h15; // @[Expression.scala 2342:18]
  assign mel_data_167 = 8'h41; // @[Expression.scala 2342:18]
  assign mel_data_168 = 8'h6d; // @[Expression.scala 2342:18]
  assign mel_data_169 = 8'h99; // @[Expression.scala 2342:18]
  assign mel_data_170 = 8'hc5; // @[Expression.scala 2342:18]
  assign mel_data_171 = 8'hf0; // @[Expression.scala 2342:18]
  assign mel_data_172 = 8'he3; // @[Expression.scala 2342:18]
  assign mel_data_173 = 8'hba; // @[Expression.scala 2342:18]
  assign mel_data_174 = 8'h90; // @[Expression.scala 2342:18]
  assign mel_data_175 = 8'h67; // @[Expression.scala 2342:18]
  assign mel_data_176 = 8'h3d; // @[Expression.scala 2342:18]
  assign mel_data_177 = 8'h14; // @[Expression.scala 2342:18]
  assign mel_data_178 = 8'h1c; // @[Expression.scala 2342:18]
  assign mel_data_179 = 8'h45; // @[Expression.scala 2342:18]
  assign mel_data_180 = 8'h6f; // @[Expression.scala 2342:18]
  assign mel_data_181 = 8'h98; // @[Expression.scala 2342:18]
  assign mel_data_182 = 8'hc2; // @[Expression.scala 2342:18]
  assign mel_data_183 = 8'heb; // @[Expression.scala 2342:18]
  assign mel_data_184 = 8'heb; // @[Expression.scala 2342:18]
  assign mel_data_185 = 8'hc3; // @[Expression.scala 2342:18]
  assign mel_data_186 = 8'h9c; // @[Expression.scala 2342:18]
  assign mel_data_187 = 8'h75; // @[Expression.scala 2342:18]
  assign mel_data_188 = 8'h4d; // @[Expression.scala 2342:18]
  assign mel_data_189 = 8'h26; // @[Expression.scala 2342:18]
  assign mel_data_190 = 8'h14; // @[Expression.scala 2342:18]
  assign mel_data_191 = 8'h3c; // @[Expression.scala 2342:18]
  assign mel_data_192 = 8'h63; // @[Expression.scala 2342:18]
  assign mel_data_193 = 8'h8a; // @[Expression.scala 2342:18]
  assign mel_data_194 = 8'hb2; // @[Expression.scala 2342:18]
  assign mel_data_195 = 8'hd9; // @[Expression.scala 2342:18]
  assign mel_data_196 = 8'hfe; // @[Expression.scala 2342:18]
  assign mel_data_197 = 8'hd8; // @[Expression.scala 2342:18]
  assign mel_data_198 = 8'hb3; // @[Expression.scala 2342:18]
  assign mel_data_199 = 8'h8e; // @[Expression.scala 2342:18]
  assign mel_data_200 = 8'h68; // @[Expression.scala 2342:18]
  assign mel_data_201 = 8'h43; // @[Expression.scala 2342:18]
  assign mel_data_202 = 8'h1e; // @[Expression.scala 2342:18]
  assign mel_filter = tmp_mel_filter; // @[mel_rom.scala 36:17]
  assign mel_index_data_0 = 12'h033; // @[Expression.scala 2342:18]
  assign mel_index_data_1 = 12'h043; // @[Expression.scala 2342:18]
  assign mel_index_data_2 = 12'h063; // @[Expression.scala 2342:18]
  assign mel_index_data_3 = 12'h074; // @[Expression.scala 2342:18]
  assign mel_index_data_4 = 12'h094; // @[Expression.scala 2342:18]
  assign mel_index_data_5 = 12'h0b3; // @[Expression.scala 2342:18]
  assign mel_index_data_6 = 12'h0d3; // @[Expression.scala 2342:18]
  assign mel_index_data_7 = 12'h0e5; // @[Expression.scala 2342:18]
  assign mel_index_data_8 = 12'h105; // @[Expression.scala 2342:18]
  assign mel_index_data_9 = 12'h134; // @[Expression.scala 2342:18]
  assign mel_index_data_10 = 12'h155; // @[Expression.scala 2342:18]
  assign mel_index_data_11 = 12'h175; // @[Expression.scala 2342:18]
  assign mel_index_data_12 = 12'h1a5; // @[Expression.scala 2342:18]
  assign mel_index_data_13 = 12'h1c6; // @[Expression.scala 2342:18]
  assign mel_index_data_14 = 12'h1f6; // @[Expression.scala 2342:18]
  assign mel_index_data_15 = 12'h226; // @[Expression.scala 2342:18]
  assign mel_index_data_16 = 12'h257; // @[Expression.scala 2342:18]
  assign mel_index_data_17 = 12'h287; // @[Expression.scala 2342:18]
  assign mel_index_data_18 = 12'h2c7; // @[Expression.scala 2342:18]
  assign mel_index_data_19 = 12'h2f8; // @[Expression.scala 2342:18]
  assign mel_index_data_20 = 12'h338; // @[Expression.scala 2342:18]
  assign mel_index_data_21 = 12'h379; // @[Expression.scala 2342:18]
  assign mel_index_data_22 = 12'h3b9; // @[Expression.scala 2342:18]
  assign mel_index_data_23 = 12'h409; // @[Expression.scala 2342:18]
  assign mel_index_data_24 = 12'h44a; // @[Expression.scala 2342:18]
  assign mel_index_data_25 = 12'h49b; // @[Expression.scala 2342:18]
  assign mel_index_data_26 = 12'h4fb; // @[Expression.scala 2342:18]
  assign mel_index_data_27 = 12'h54c; // @[Expression.scala 2342:18]
  assign mel_index_data_28 = 12'h5ac; // @[Expression.scala 2342:18]
  assign mel_index_data_29 = 12'h60d; // @[Expression.scala 2342:18]
  assign mel_len = tmp_mel_len[3 : 0]; // @[mel_rom.scala 40:14]
  assign mel_index = tmp_mel_index[11 : 4]; // @[mel_rom.scala 41:16]

endmodule

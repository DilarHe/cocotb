KWS_MAX_VAL          255
KWS_MIN_VAL          0

C1_StackBase         0      // C1的stack栈帧指针
IBB1C1_StackBase     8      // IBB1C1的stack栈帧指针


C1_WeightBase        504    // 0  + 256+1920/16+2048/16   // weight memline num = 3*32*16/16 = 96个
C1_WeightBaseFirst   536    // 32     // first conv weight base 第一次卷积需要从第二列开始
C1_BiasBase          600    // 96 + 504    // bias memline num = 16/4 = 4
C1_BiasBaseADD16     604    // 100    // bias memline num = 3*16/4 = 4 + 4
C1_BiasBaseADD32     608    // 104     // bias memline num = 3*16/4 = 4 + 8
C1_QuantBase         612    // 108    // scale, zero point = 64bit， shift = 31

C1_IfmapBase         256    // 0  需要加上config数256    // 输入fbank memline个数 = 60*32/16 = 120
C1_OfmapBase         376    // 120    // 去除输入fbank的条目

C1_IfmapWidth        59
C1_IfmapDepth        32
C1_OfmapDepth        16
C1_FilterWidth       3
C1_Stride            1
C1_Padding           1
C1_InnerLoop         6
C1_InnerLoopFirst    4
C1_OuterLoop         1

IBB1_C1_WeightBase   109    // C1_QuantBase + 1

# fbank.py 使用说明

+ 目前IC服务器上py环境为3.9.6， 有numpy包和matplotlib包。因此fbank.py中将所有依赖的函数都copy了过来，不需要再导入新的包（IC服务器传文件非常麻烦）
+ 主函数为 fbank_main， 输入参数为pcm16k_int, json格式的config文件路径, 以及VAD相关参数
+ pcm16k_int是一个有符号整数形式的16bit数据列表或NpArray
+ json配置文件中包含了fbank各层的量化参数以及最终量化到uin8所需的scale, shift, zeropoint等。
+ 每一层的输出都加入到fbank main函数的返回值中，其中最后一个返回值 lmfb_uint8 是最终fbank的计算结果
+ 如果vad_en配置为1, 则会对每一帧计算vad, 输出vad flag结果。如果vad flag=1, 则会进行后续的fbank计算（FFT,POW,MEL...)，否则不进行后续计算。此时输出结果lmfb_uint8 中只会包含vad flag=1 对应的那一帧。

Example:
```python
    pcm = np.random.randint(low=-2**15, high=2**15-1, size=[16000]) # 替换成音频数据 （int16）

    filter8K, frams, vad_flag, stft_matrix, fft_stages, power_fft_q, spec_q, lmfb, lmfb_uint8 = \
            fbank_main(pcm16k_int= pcm, 
                          json_path = "../../../hw_config.json", 
                          vad_en=1, vad_thre=100, vad_hang=4)
```

> 注意：window 加窗操作及其之后的结果都是一个2维数组， 第一维为帧计算结果，第二维为帧数，例如：lmfb_uint8.shape = [30, 100], 其中30是fbank特征维度，100是帧数，因此该函数是向量模式的，调用一次会输出整段音频的所有帧的结果，这点与未量化的C代码不同（Cmodel是根据音频流串行获取每一帧的结果）。
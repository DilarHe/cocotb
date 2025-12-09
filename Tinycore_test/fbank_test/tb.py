import random
import math
import cocotb
import numpy as np
from numfi import numfi
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge, Timer, Edge
import matplotlib.pyplot as plt
import sys
sys.path.append("../basic_test/")
from utils import * 
# from basic_test.utils import *
import librosa
import fbank as fb
import FFT
# from simd_model import *
# from macro_gen import *

CLK_NS = 1

# def bias_in_mem2int(membank):
#     out_bias = np.zeros([membank.shape[0], int(membank.shape[1]/4)], dtype= np.int32)
#     line_num = int(membank.shape[1]/4)
#     for i in range(membank.shape[0]):
#         for j in range(line_num):
#             tmp = membank[i][j*4]
#             for k in range(4 - 1):
#                 tmp += membank[i][j*4+k+1] * 256
#             sign_tmp = (tmp >> 31) & 1
#             print(bin(tmp))
#             if sign_tmp == 1:
#                 print(tmp)
#                 tmp = tmp ^ ((1<<32)-1) + 1
#             out_bias[i][j] = tmp 

#     return out_bias

async def reset_dut(reset_n, duration_ns):
    reset_n.value = 0
    await Timer(duration_ns, units="ns")
    reset_n.value = 1
    reset_n._log.info("Reset complete.")


async def mem_driver(dut, mem_name, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata):
    while True:
        await RisingEdge(dut.clk)
        if io_wr.value.integer:  # write
            membank[io_addr.value.integer] = io_wdata.value.integer
            dut._log.info('Mem {} write in to address: {}, data: {}'.format(mem_name, io_addr.value.integer,
                                                                            Uint2Sint(io_wdata.value.integer,16)))
            # dut._log.info('Mem Contents : {}'.format(NpUint2Sint(membank,16)))
        elif io_rd.value.integer:
            rddata = int(membank[io_addr.value.integer])
            io_rdata.value = rddata
            dut._log.info('Mem {} read out from address: {}, data: {}'.format(
                mem_name, io_addr.value.integer, Uint2Sint(rddata,16)))


async def monitor_filter(dut, true_data, qout):
    iter_filter = 0
    while True:
        await RisingEdge(dut.filter.pcm_filter_vld)
        true_data_filter = true_data[iter_filter]
        true_data_filter = (true_data_filter * (2 ** qout[2])).astype(np.int32)
        my_value = NpUint2Sint(np.array(dut.filter.pcm_filter_out.value.integer), qout[1])
        distance = my_value  - true_data_filter
        if(np.sum(distance) != 0):
            dut._log.error('*** Filter data {} is wrong! \n distance = {}, \n my = {}, \n ture = {}.'.format(
                            iter_filter,distance, my_value, true_data_filter))
            raise('!')
        else:
            dut._log.info(f'*** Filter data {iter_filter} is right! my = {my_value}, ture = {true_data_filter}.')
        iter_filter += 1

async def monitor_window(dut, bank0, bank1, frame_ture, pingpong, qout):
    frame_iter = 0
    while True:
        await Edge(pingpong)
        this_frame = frame_ture[:,frame_iter]
        this_frame = (this_frame * (2 ** qout[2])).astype(np.int32)
        if(pingpong.value.integer):
            bank = NpUint2Sint(bank0, qout[1])
            distance = bank - this_frame
        else:
            bank = NpUint2Sint(bank1, qout[1])
            distance = bank - this_frame
        if(np.sum(distance) != 0):
            dut._log.error('*** Frame {} : window data wrong! \n distance = {}, \n my = {}, \n ture = {}.'.format(frame_iter,distance, bank, this_frame))
            dut._log.error('Where not equal index: {}'.format(np.where(distance != 0)))
            raise('!')
        else:
            dut._log.info('*** Frame {} : window data right! '.format(frame_iter))
        frame_iter += 1

async def monitor_fft_stage(dut, pcm_buff0, pcm_buff1, pcm_buff2 ,mem_stage_true, pingpong, qout):
    frame_iter = 0
    j = 0
    while True:
        await FallingEdge(dut.fft.flg_cnt_group_done)
        if pingpong.value.integer:
            mem_real = pcm_buff0
        else:
            mem_real = pcm_buff1
        mem_imag = pcm_buff2
        true_real_stage = mem_stage_true[j][0,:,frame_iter] * 2**qout[2]
        true_imag_stage = mem_stage_true[j][1,:,frame_iter] * 2**qout[2]
        
        my_real_stage = NpUint2Sint(mem_real, qout[1])
        my_imag_stage = NpUint2Sint(mem_imag, qout[1])

        isequal_real = np.array(true_real_stage) == np.array(my_real_stage) 
        isequal_imag = np.array(true_imag_stage) == np.array(my_imag_stage)
        if not ((np.sum(isequal_real) == isequal_real.shape[0]) or (np.sum(isequal_imag) == isequal_imag.shape[0])):
            print('FFT stage {}'.format(j))
            print('diff distance (A-B) real:')
            print(true_real_stage - my_real_stage)
            print('diff distance (A-B) imag:')
            print(true_imag_stage - my_imag_stage)
            print('true real:')
            print(true_real_stage)
            print('my real:')
            print(my_real_stage)
            print('true imag:')
            print(true_imag_stage)
            print('my imag:')
            print(my_imag_stage)
            raise('FFT stage {} cal wrong!'.format(j))
        else:
            dut._log.info('stage {}, test pass!'.format(j))
            j += 1
            if j == 7:
                frame_iter += 1
                j = 0

async def monitor_fft(dut, N, pcm_buff0, pcm_buff1, pcm_buff2, frame_ture, pingpong, qout):
    frame_iter = 0
    rfft_num = int(N/2) + 1
    final_reverse = np.array([FFT._reverse_pos(x, N) for x in range(N)])  # final reverse code
    #final_reverse = np.array([x for x in range(N)])  # final reverse code

    while True:
        await FallingEdge(dut.fft.finish)
        await RisingEdge(dut.clk)
        this_frame = frame_ture[:,frame_iter]
        this_frame_real = (this_frame.real * (2 ** qout[2])).astype(np.int32)
        this_frame_imag = (this_frame.imag * (2 ** qout[2])).astype(np.int32)
        if(pingpong.value.integer):
            bank_real = NpUint2Sint(pcm_buff0, qout[1])[final_reverse][:rfft_num]
            distance_real = bank_real - this_frame_real
        else:
            bank_real = NpUint2Sint(pcm_buff1, qout[1])[final_reverse][:rfft_num]
            distance_real = bank_real - this_frame_real
        bank_imag = NpUint2Sint(pcm_buff2, qout[1])[final_reverse][:rfft_num]
        distance_imag = bank_imag - this_frame_imag
        if(np.sum(distance_real) != 0):
            dut._log.error('frame {} : fft real data wrong! \n distance = {}, \n my = {}, \n ture = {}.'.format(frame_iter,distance_real, bank_real, this_frame_real))
            dut._log.error('Real data where not equal index: {}'.format(np.where(distance_real != 0)))
        if(np.sum(distance_imag) != 0):
            dut._log.error('frame {} : fft imag data wrong! \n distance = {}, \n my = {}, \n ture = {}.'.format(frame_iter,distance_imag, bank_imag, this_frame_imag))
            dut._log.error('Imag data where not equal index: {}'.format(np.where(distance_imag != 0)))

        if(np.sum(distance_imag) != 0 or np.sum(distance_real) != 0):
            raise("!")
        else:
            dut._log.info('frame {} : fft data right! '.format(frame_iter))
        frame_iter += 1

async def monitor_power(dut, N, pcm_buff0, pcm_buff1, pcm_buff2, frame_ture, pingpong, rfft_num, qout):
    frame_iter = 0
    final_reverse = np.array([FFT._reverse_pos(x, N) for x in range(N)])  # final reverse code
    while True:
        await RisingEdge(dut.pow.finish)
        this_frame = frame_ture[:,frame_iter]
        this_frame = (this_frame * (2 ** qout[2])).astype(np.int32)
        if(pingpong.value.integer):
            bank_real = pcm_buff0[final_reverse][:rfft_num]
            bank_imag = pcm_buff2[final_reverse][:rfft_num]
        else:
            bank_real = pcm_buff1[final_reverse][:rfft_num]
            bank_imag = pcm_buff2[final_reverse][:rfft_num]

        my_pow = bank_real * 2**16 + bank_imag

        true_pow = this_frame
        distance = true_pow - my_pow
        if(np.sum(distance) != 0):
            dut._log.error('frame {} : power data wrong! \n distance = {}, \n my = {}, \n ture = {}.'.format(
                frame_iter, distance, my_pow, true_pow))
            dut._log.error('Where not equal index: {}'.format(np.where(distance != 0)))
            raise('!')
        else:
            dut._log.info('frame {}: power data right! '.format(frame_iter))
        frame_iter += 1

async def monitor_mel(dut, N, nmel,  pcm_buff0, pcm_buff1, pcm_buff2, true_result,  pingpong, qout):
    frame_iter = 0
    final_reverse = np.array([FFT._reverse_pos(x, N) for x in range(N)])  # final reverse code

    while True:
        await FallingEdge(dut.mel.finish)
        true_mel = true_result[:,frame_iter] * (2**qout[2])
        if(pingpong.value.integer):
            bank_real = pcm_buff0[final_reverse][:nmel]
            bank_imag = pcm_buff2[final_reverse][:nmel]
        else:
            bank_real = pcm_buff1[final_reverse][:nmel]
            bank_imag = pcm_buff2[final_reverse][:nmel]
        my_mel = bank_real * 2**16 + bank_imag

        distance = true_mel - my_mel
        if (np.sum(distance) != 0):
            dut._log.info('frame {} : mel data wrong! \n distance = {}, \n my = {}, \n ture = {}'.format(
                frame_iter,distance,my_mel,true_mel))
            raise('!')
        else:
            dut._log.info('frame {} : mel data right! '.format(frame_iter))
        frame_iter += 1

async def monitor_log(dut, N, nmel,  pcm_buff0, pcm_buff1, pcm_buff2, true_result,  pingpong, qout):
    frame_iter = 0
    final_reverse = np.array([FFT._reverse_pos(x, N) for x in range(N)])  # final reverse code

    while True:
        await FallingEdge(dut.log.finish)
        true_log = true_result[:,frame_iter] * (2**qout[2])
        if(pingpong.value.integer):
            bank_real = pcm_buff0[final_reverse][:nmel]
            bank_imag = pcm_buff2[final_reverse][:nmel]
        else:
            bank_real = pcm_buff1[final_reverse][:nmel]
            bank_imag = pcm_buff2[final_reverse][:nmel]
        my_log = bank_real * 2**16 + bank_imag

        distance = true_log - my_log
        if (np.sum(distance) != 0):
            dut._log.info('frame {} : log data wrong! \n distance = {}, \n my = {}, \n ture = {}'.format(
                frame_iter,distance,my_log,true_log))
            raise('!')
        else:
            dut._log.info('frame {} : log data right! '.format(frame_iter))
        frame_iter += 1

async def monitor_quant(dut, nmel,  highbandwidth_fb, true_result):
    frame_iter = 0
    frame_iter_ref = 0

    while True:
        await FallingEdge(dut.quant.finish)
        true_quant = true_result[:,frame_iter_ref] 
        my_quant_part0 = highbandwidth_fb[frame_iter,:]
        if frame_iter + 1 >=  highbandwidth_fb.shape[0]:
            frame_iter_part1 = 0
        else :
            frame_iter_part1 = frame_iter + 1
        my_quant_part1 = highbandwidth_fb[frame_iter_part1,:]
        my_quant = np.append(my_quant_part0, my_quant_part1)
        my_quant = my_quant[:nmel]
        distance = true_quant - my_quant
        if (np.sum(distance) != 0):
            dut._log.info('frame {} : quant data wrong! \n distance = {}, \n my = {}, \n ture = {}'.format(
                frame_iter_ref,distance,my_quant,true_quant))
            raise('!')
        else:
            dut._log.info('frame {} : quant data right! '.format(frame_iter_ref))
        frame_iter_ref += 1
        if frame_iter ==  highbandwidth_fb.shape[0]-2:
            frame_iter = 0
        elif frame_iter ==  highbandwidth_fb.shape[0]-1:
            frame_iter = 1
        else:
            frame_iter += 2

async def highbendwidth_fbank_mem_driver(dut, mem_name, ele_width, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata):
    while True:
        await RisingEdge(dut.clk)
        if io_wr.value.integer:  # write
            for i in range(membank.shape[1]):
                membank[io_addr.value.integer][membank.shape[1] - 1 - i] = \
                    int('0b' +
                        io_wdata.value.binstr[ele_width * i:ele_width * (i + 1)], 2)
            dut._log.info('Mem {} write in to address: {}, data: {}'.format(mem_name, io_addr.value.integer,
                                                                            io_wdata.value.integer))
        elif io_rd.value.integer:
            rddata_str = ''
            for i in range(membank.shape[1]):
                rddata_str += dec2bin_ext_clip(
                    int(membank[io_addr.value.integer][membank.shape[1] - 1 - i]), ele_width)
            io_rdata.value = int('0b' + rddata_str, 2)
            dut._log.info('Mem {} read out from address: {}, data: {}, rawH:{}'.format(mem_name, io_addr.value.integer,
                                                                                       membank[io_addr.value.integer], int('0b' + rddata_str, 2)))
            


async def audio_driver(dut, datain, qin, SR, spar_ratio):
    pcm_iter = 0
    pcm_ns = int((1 / SR * (10 ** 9)) / spar_ratio)
    max_iter = datain.shape[0]
    await RisingEdge(dut.kws_enable)
    await Timer(1000, units="ns")
    while (pcm_iter != max_iter):
        await RisingEdge(dut.clk)
        pcm_data = datain[pcm_iter]
        dut.pcm16k_in.value = int(pcm_data * (2 ** qin[2]))
        dut._log.info('pcm {} datain: {}'.format(pcm_iter, int(pcm_data * (2 ** qin[2]))))
        dut.pcm16k_vld.value = 1
        pcm_iter += 1
        await RisingEdge(dut.clk)
        dut.pcm16k_vld.value = 0
        await Timer(pcm_ns - CLK_NS, units="ns")



@cocotb.test()
async def tb(dut):
    # "Clock" is a built in class for toggling a clock signal
    cocotb.start_soon(Clock(dut.clk, CLK_NS, units='ns').start())
    # run reset_dut immediately before continuing
    await cocotb.start(reset_dut(dut.resetn, CLK_NS * 10))

    np.random.seed(2023)

    # Parameters
    config = load_json_config("../../../hw_config.json")

    IRAM_LEN = 11
    PC_INIT = 115
    INSTR_LEN = 16
    VMEM_WIDTH = 128
    SMEM_WIDTH = 32
    VECTOR_LEN = 128
    SIMD_FACTOR = 16

    BIAS_WIDTH = 32
    LINE_BIAS_NUM = int(VMEM_WIDTH / BIAS_WIDTH)

    FBANK_MEM_KB = int(config["mem"]["fbank"])  #1920
    ACT_MEM_KB = int(config["mem"]["act"])  #2048
    WEIGHT_MEM_KB = int(config["mem"]["weight"]) #13000
    STACK_MEM_KB = int(config["mem"]["stack"]) #256

    FBANK_MEM_LEN = int(FBANK_MEM_KB / SIMD_FACTOR)
    ACT_MEM_LEN = int(ACT_MEM_KB / SIMD_FACTOR)
    WEIGHT_MEM_LEN = int(WEIGHT_MEM_KB / SIMD_FACTOR)

    NFFT = 256
    PCM_WIDTH = 16
    SAMPLERATE = 16000

    ENABLE_VAD = 1
    VAD_THRE = 100
    VAD_HANG = 4

    PCMInList         = config["fbank_qat"]["PCMInList"]
    FFTList           = config["fbank_qat"]["FFTList"]
    FFTWinList        = config["fbank_qat"]["FFTWinList"]
    PowList           = config["fbank_qat"]["PowList"]
    MelList           = config["fbank_qat"]["MelList"]
    CordicCoefList    = config["fbank_qat"]["CordicCoefList"]
    CordicList        = config["fbank_qat"]["CordicList"]
    FbankList         = config["fbank_qat"]["FbankList"]

    SCALE             = config["NN_input_qat"]["scale"]
    ZEROPOINT         = config["NN_input_qat"]["zeropoint"]
    SHIFT             = config["NN_input_qat"]["shift"]

    pcm_buff0 = np.zeros(shape=[NFFT], dtype=np.int32)
    pcm_buff1 = np.zeros(shape=[NFFT], dtype=np.int32)
    pcm_buff2 = np.zeros(shape=[NFFT], dtype=np.int32)

    highbandwidth_fb = np.zeros(shape=[FBANK_MEM_LEN, SIMD_FACTOR], dtype=np.int32)
    dut.rg_kws_fb_lp_filter_en.value = 1
    dut.rg_kws_fb_window_en.value = 1
    dut.rg_kws_fb_fbank_en.value = 1
    dut.rg_kws_fb_quant_scale.value =  SCALE
    dut.rg_kws_fb_quant_zerpoint.value =  ZEROPOINT
    dut.rg_kws_fb_quant_shift.value =  SHIFT
    # vad enable
    dut.rg_kws_fb_vad_en.value = ENABLE_VAD
    dut.rg_kws_fb_vad_energy_threshold.value =  VAD_THRE
    dut.rg_kws_fb_vad_hangover.value =  VAD_HANG


    audio_path = "0c40e715_nohash_0.wav"
    y, sr = librosa.load(audio_path, sr=SAMPLERATE)
    plt.figure()
    plt.plot(y)
    plt.show()

    audio_len = y.shape[0]
    y = np.array(numfi(y, PCMInList[0], PCMInList[1], PCMInList[2]))

    filter8K, frams, vad_flag, stft_matrix, fft_stages, power_fft_q, spec_q, lmfb, lmfb_uint8 = \
            fb.fbank_main(pcm16k_int=y*2**PCMInList[2], 
                          json_path = "../../../hw_config.json", 
                          vad_en=ENABLE_VAD, vad_thre=VAD_THRE, vad_hang=VAD_HANG)
    
    # _,filter8K = fb.lp_filter(y)
    # filter8K = np.array(numfi(filter8K, PCMInList[0], PCMInList[1], PCMInList[2]))


    # frams = fb.window(NFFT,NFFT,filter8K, quot=FFTList)
    # print(frams.shape)

    # energy, vad_flag = fb.vad(frams*2**FFTList[2], threshold=100, hangover=4)
    # print(energy)
    # print(vad_flag.shape)
    # vad_flag_index = np.array(np.where(vad_flag)).flatten()
    # print(vad_flag_index)
    # frams_after_vad = frams[:,vad_flag_index]
    # print(frams_after_vad.shape)

    # stft_matrix, fft_stages = fb.fftq(NFFT, frams_after_vad, quot_wn=FFTWinList, quot=FFTList)

    # print(stft_matrix.shape)
    
    # power_fft_q = fb.power(stft_matrix, quot=PowList)

    # spec_q = fb.mel(power_fft_q, quot=MelList)

    # print(spec_q.shape)  

    # lmfb = fb.log(spec_q, qinput=MelList, qcoeff=CordicCoefList,quot=CordicList)

    # mulscale, lmfb_uint8 = fb.quant(lmfb, SCALE, SHIFT, ZEROPOINT, quot=FbankList)
    # print(lmfb_uint8[:, 1])

    # DEBUG


    # Drivers
    cocotb.start_soon(audio_driver(dut, y, PCMInList, SAMPLERATE, int(4000000/SAMPLERATE)*CLK_NS))  # CLK 1cycle is 4MHz
    cocotb.start_soon(mem_driver(dut, "pcm_buff0", pcm_buff0,
                                dut.pcm_mb0_rd, dut.pcm_mb0_wr,
                                dut.pcm_mb0_addr, dut.pcm_mb0_wdata,
                                dut.pcm_mb0_rdata))
    cocotb.start_soon(mem_driver(dut, "pcm_buff1", pcm_buff1,
                                dut.pcm_mb1_rd, dut.pcm_mb1_wr,
                                dut.pcm_mb1_addr, dut.pcm_mb1_wdata,
                                dut.pcm_mb1_rdata))
    cocotb.start_soon(mem_driver(dut, "pcm_buff2", pcm_buff2,
                                dut.pcm_mb2_rd, dut.pcm_mb2_wr,
                                dut.pcm_mb2_addr, dut.pcm_mb2_wdata,
                                dut.pcm_mb2_rdata))
    cocotb.start_soon(
    highbendwidth_fbank_mem_driver(dut, "fbank_ram", int(VECTOR_LEN / SIMD_FACTOR), highbandwidth_fb,
                            dut.lmfb_mem_rd, dut.lmfb_mem_wr,
                            dut.lmfb_mem_addr, dut.lmfb_mem_wdata,
                            dut.lmfb_mem_rdata))

    # monitor
    cocotb.start_soon(monitor_filter(dut, filter8K, PCMInList))
    cocotb.start_soon(monitor_window(dut, pcm_buff0, pcm_buff1, frams, dut.pingpong_flag, [1,16,10]))
    
    cocotb.start_soon(monitor_fft_stage(dut, pcm_buff0, pcm_buff1, pcm_buff2 ,fft_stages, dut.pingpong_flag,FFTList))
    cocotb.start_soon(monitor_fft(dut, NFFT, pcm_buff0, pcm_buff1, pcm_buff2, stft_matrix, dut.pingpong_flag, FFTList))
    cocotb.start_soon(monitor_power(dut, NFFT, pcm_buff0, pcm_buff1, pcm_buff2, power_fft_q, dut.pingpong_flag, int(NFFT/2+1), PowList))
    cocotb.start_soon(monitor_mel(dut, NFFT, 30,  pcm_buff0, pcm_buff1, pcm_buff2, spec_q,  dut.pingpong_flag, MelList))
    cocotb.start_soon(monitor_log(dut, NFFT, 30,  pcm_buff0, pcm_buff1, pcm_buff2, lmfb,  dut.pingpong_flag, CordicList))
    cocotb.start_soon(monitor_quant(dut, 30,  highbandwidth_fb, lmfb_uint8))


    
    # cocotb.start_soon(monitor_layer1(dut, highbandwidth_a, fbank_0_raw, weight_all['conv00_w'], bias_all['conv00_b'], quant_all['conv00_q']))


    await RisingEdge(dut.resetn)
    await Timer(10, units="ns")
    await RisingEdge(dut.clk)
    dut.kws_enable.value = 0
    await RisingEdge(dut.clk)
    dut.kws_enable.value = 1


    await Timer(int((audio_len * int(4000000/SAMPLERATE)*CLK_NS)), units="ns")
    #await Timer(10000, units="ns")


if __name__ == '__main__':
    print('test')

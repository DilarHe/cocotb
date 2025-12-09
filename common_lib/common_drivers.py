from cocotb.triggers import FallingEdge, RisingEdge, Timer, Edge
from cocotb.binary import BinaryValue,BinaryRepresentation
import re
import numpy as np
import binascii
from Binary import Binary
"""
  single port but dual driving clk sram driver
  support both binary string and integer assignment
"""
async def Dualclk_spram_driver(dut, mem_name, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata, is_classic, use_str = False):
    while True:
        if(dut.cache_clk_sel.value):
            await RisingEdge(dut.clk)   
        else:
            await RisingEdge(dut.clk_80m)
        if is_classic:
            wr = io_wr.value.integer & io_rd.value.integer
            rd = ~io_wr.value.integer & io_rd.value.integer
        else:
            wr = io_wr.value.integer
            rd = io_rd.value.integer
        if wr:  # write
            membank[io_addr.value.integer] = BinaryValue(io_wdata.value.integer).binstr if use_str else io_wdata.value.integer
            dut._log.info('SPRAM {} write in to address: {}, data: {}'.format(mem_name, io_addr.value.integer,
                                                                            io_wdata.value.integer))
        elif rd:
            rddata = membank[io_addr.value.integer]
            io_rdata.value = BinaryValue(rddata, bigEndian=False) if type(rddata)==str else rddata
            dut._log.info('SPRAM {} read out from address: {}, data: {}'.format(
                mem_name, io_addr.value.integer, rddata))

"""
  single port sram driver
  support both binary string and integer assignment
"""
async def spram_driver(dut, mem_name, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata, is_classic, use_str = False):
    while True:
        await RisingEdge(dut.clk)
        if is_classic:
            wr = io_wr.value.integer & io_rd.value.integer
            rd = ~io_wr.value.integer & io_rd.value.integer
        else:
            wr = io_wr.value.integer
            rd = io_rd.value.integer
        if wr:  # write
            membank[io_addr.value.integer] = BinaryValue(io_wdata.value.integer).binstr if use_str else io_wdata.value.integer
            dut._log.info('SPRAM {} write in to address: {}, data: {}'.format(mem_name, io_addr.value.integer,
                                                                            io_wdata.value.integer))
        elif rd:
            rddata = membank[io_addr.value.integer]
            io_rdata.value = BinaryValue(rddata, bigEndian=False) if type(rddata)==str else rddata
            dut._log.info('SPRAM {} read out from address: {}, data: {}'.format(
                mem_name, io_addr.value.integer, rddata))


async def spram_driver_with_byte_select(dut, mem_name, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata, is_classic, byte_select=None, use_str=False, verbose=False):
    """
    Single Port SRAM Driver with Byte Select
    - This driver is designed to simulate a single-port SRAM interface for a System on Chip (SoC) design.
    - It supports writing and reading both binary strings and integer values to/from memory.
    - It operates in both "classic" and "non-classic" modes, which affect read/write control.
    - Byte Select functionality allows selective writing to individual bytes of the data word.

    Args:
        dut: The DUT (Device Under Test) object, representing the top-level module in the simulation.
        mem_name (str): A name identifier for the SRAM module, used for logging.
        membank (dict): A dictionary that acts as the SRAM memory bank, where data is stored.
        io_rd (Signal): Read control signal. High value enables reading.
        io_wr (Signal): Write control signal. High value enables writing.
        io_addr (Signal): Address bus for the SRAM, specifying the address for reading or writing.
        io_wdata (Signal): Data bus for write operations. Data to be written to SRAM is placed here.
        io_rdata (Signal): Data bus for read operations. Read data from SRAM is placed here.
        is_classic (bool): Mode flag for read/write behavior. If True, `io_rd` and `io_wr` combine to control access.
        byte_select (Signal, optional): Byte select mask to indicate which bytes of the word to write. A 4-bit mask.
        use_str (bool, optional): If True, data is stored in binary string format. Defaults to False (integer format).

    Returns:
        None. This is a coroutine function for use in an asynchronous test environment like cocotb.

    Example usage:
        To create a memory driver with byte select functionality for a simple SRAM block:
        ```python
        spram_memory = {}
        byte_select_mask = dut.byte_select
        cocotb.fork(spram_driver_with_byte_select(dut, "SRAM1", spram_memory, dut.io_rd, dut.io_wr, dut.io_addr, dut.io_wdata, dut.io_rdata, is_classic=True, byte_select=byte_select_mask))
        ```
    """
    while True:
        # Wait for the rising edge of the clock
        await RisingEdge(dut.clk)

        # Determine read/write control based on the mode
        if is_classic:
            wr = io_wr.value.integer & io_rd.value.integer  # Both wr and rd signals active for write
            rd = ~io_wr.value.integer & io_rd.value.integer  # Only rd active (and not wr) for read
        else:
            wr = io_wr.value.integer  # `io_wr` alone controls write
            rd = io_rd.value.integer  # `io_rd` alone controls read

        # Get the word address for numpy indexing
        membank_addr = io_addr.value.integer  # Word address for numpy array indexing

        if wr:  # Write operation
            # Check if the address is within valid bounds
            if membank_addr >= len(membank):
                dut._log.warning(f"Invalid address {membank_addr:#x} accessed for {mem_name}. Address out of bounds!")
                continue  # Skip the read/write operation if the address is out of bounds
            if byte_select is not None:
                byte_mask = byte_select.value  # The byte select mask (4 bits)
                # Process the data based on the byte select mask
                for byte_idx in range(4):
                    if byte_mask & (1 << byte_idx):  # If the byte is selected (mask bit is 1)
                        byte_shift = byte_idx * 8  # Shift for selecting the specific byte
                        byte_data = (io_wdata.value.integer >> byte_shift) & 0xFF  # Extract the byte
                        current_data = membank[membank_addr]  # Get current word value
                        # Update the selected byte in the word
                        new_data = (current_data & ~(0xFF << byte_shift)) | (byte_data << byte_shift)
                        membank[membank_addr] = new_data  # Store updated word
            else:
                # If no byte select, just write the full data word
                membank[membank_addr] = io_wdata.value.integer
                
            # Log the write operation
            dut._log.info('SPRAM {} write in to address: {}, data: 0x{:08x}'.format(
                mem_name, membank_addr, io_wdata.value.integer))
        
        elif rd:  # Read operation
            # Check if the address is within valid bounds
            if membank_addr >= len(membank):
                dut._log.warning(f"Invalid address {membank_addr:#x} accessed for {mem_name}. Address out of bounds!")
                continue  # Skip the read/write operation if the address is out of bounds
            rddata = int(membank[membank_addr])
            # Set `io_rdata` output signal
            io_rdata.value = rddata 
    
            # Log the read operation
            if verbose : dut._log.info('SPRAM {} read out from address: {}, data: 0x{:08x}'.format(
                mem_name, membank_addr, rddata))
            
async def sprom_driver(dut, mem_name, membank, io_rd, io_addr, io_rdata):
    while True:
        await RisingEdge(dut.clk)
        if io_rd.value.integer:
            rddata = membank[io_addr.value.integer]
            io_rdata.value = BinaryValue(rddata, bigEndian=False) if type(rddata)==str else rddata
            dut._log.info('ROM {} read out from address: {}, data: {}'.format(
                mem_name, io_addr.value.integer, rddata))

async def stream_spram_driver(dut, mem_name, membank, 
                              io_cmd_valid, io_cmd_wr, io_cmd_addr, io_cmd_ready, io_cmd_wdata,
                              io_rsp_valid, io_rsp_ready, io_rsp_rdata):
    while True:
        await RisingEdge(dut.clk)
        fire = io_cmd_valid.value.integer & io_cmd_ready.value.integer
        io_cmd_ready = 1
        io_rsp_valid = 0
        if  fire and io_cmd_wr.value.integer == 1:  # write
            membank[io_cmd_addr.value.integer] = io_cmd_wdata.binstr if type(membank[io_cmd_addr.value.integer])==str else io_cmd_wdata.value.integer
            dut._log.info('SPRAM {} write in to address: {}, data: {}'.format(mem_name, io_cmd_addr.value.integer,
                                                                            io_cmd_wdata.value.integer))
        elif fire and io_cmd_wr.value.integer == 0:
            io_rsp_valid = 1
            rddata = membank[io_cmd_addr.value.integer]
            io_rsp_rdata.value = BinaryValue(int('0b'+rddata,2)) if type(rddata)==str else rddata
            dut._log.info('SPRAM {} read out from address: {}, data: {}'.format(
                mem_name, io_cmd_addr.value.integer, rddata))
            
async def stream_sprom_driver(dut,mem_name, membank, 
                              io_cmd_valid, io_cmd_addr, io_cmd_ready,
                              io_rsp_valid, io_rsp_ready, io_rsp_rdata):
    while True:
        await RisingEdge(dut.clk)
        io_cmd_ready.value = 1
        io_rsp_valid.value = 0
        fire = io_cmd_valid.value.integer & io_cmd_ready.value.integer
        if fire and io_rsp_ready.value.integer:
            io_rsp_valid.value = 1
            rddata = membank[io_cmd_addr.value.integer]
            
            io_rsp_rdata.value = BinaryValue(int('0b'+rddata,2)) if type(rddata)==str else rddata
            dut._log.info('SPROM {} read out from address: {}, data: {}'.format(
                    mem_name, io_cmd_addr.value.integer, rddata))
            

def array2mem(array):
    flattened = np.array(array).flatten()
    return flattened.tolist()



def gather_array_element(array, gather_ratio, n_bits = 8, signed = True):
    binary_func = Binary(n_bits=n_bits)
    flattened = np.array(array).flatten()
    array_size = flattened.shape[0]
    assert(array_size % gather_ratio == 0, "gather_ratio is not suitable!")
    gathered_len = int(array_size / gather_ratio)
    gathered = np.zeros([gathered_len]).tolist()
    # binary_represent = BinaryRepresentation.TWOS_COMPLEMENT if signed else BinaryRepresentation.UNSIGNED
    for i in range(gathered_len):
        line = ''
        for j in range(gather_ratio):
            if signed:
                ele = binary_func._convert_to_twos_comp(int(flattened[i*gather_ratio+j]))
            else:
                ele = binary_func._convert_to_unsigned(int(flattened[i*gather_ratio+j]))

            # print("{},{},{},{}".format(i,j,ele.value,int(flattened[i*gather_ratio+j])))
            line =  ele + line
            # print(line)
        assert(len(line)==n_bits*gather_ratio, "Binary gather error! Width mismatch!")
        # gathered[i] = BinaryValue(int('0b'+line,2), n_bits=gather_ratio*n_bits, binaryRepresentation=binary_represent).value
        # gathered[i] = BinaryValue(line,n_bits=n_bits*gather_ratio, binaryRepresentation=binary_represent).value
        gathered[i] = int('0b'+line,2)
    return gathered

def invert(string):
    tmp = ''
    for i in string:
        if i == '0':
            tmp += '1'
        elif i == '1':
            tmp += '0'
        else:
            raise("Error invert")
    return tmp

def split_mem_element(mem, gather_ratio, n_bits = 8, signed = True):
    binary_func = Binary(n_bits=n_bits*gather_ratio)
    mem_len = len(mem)
    split_len = int(mem_len * gather_ratio)
    split = np.zeros([split_len], dtype=np.int32).tolist()
    # binary_represent = BinaryRepresentation.TWOS_COMPLEMENT if signed else BinaryRepresentation.UNSIGNED
    for i in range(mem_len):
        mem_ele = mem[i]
        for j in range(gather_ratio):
            array_ele = binary_func._adjust_unsigned(bin(mem_ele)[2:])
            array_ele = array_ele[(gather_ratio-j-1)*n_bits:((gather_ratio-j))*n_bits]
            if signed:
                if array_ele[0] == '1':
                    array_ele = int('0b'+invert(array_ele),2) + 1
                    array_ele = -array_ele
                    split[i*gather_ratio + j] = array_ele
                    continue
            split[i*gather_ratio + j] = int('0b'+array_ele,2)
            # print(line)
        # gathered[i] = BinaryValue(int('0b'+line,2), n_bits=gather_ratio*n_bits, binaryRepresentation=binary_represent).value
        

    return split



def load_hex_to_mem(hex_file_path, total_size, word_size=4, base_addr=0x0):
    """
    解析带@标签的Verilog HEX文件，加载到内存bank
    :param hex_file_path: hex文件路径
    :param total_size: 内存总大小（字节）
    :param word_size: 一个word多少字节（默认4）
    :param base_addr: 内存基地址（通常你的DRAM/IRAM起始物理地址）
    :return: numpy数组（每元素1 word）
    """
    num_words = total_size // word_size
    membank = np.zeros(num_words, dtype=np.uint32)
    curr_addr = base_addr

    with open(hex_file_path, "r") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            if line.startswith('@'):
                # 地址标签，16进制（字节地址）
                curr_addr = int(line[1:], 16)
                continue
            # 解析数据，支持一行多个word
            bytes_strs = line.split()
            for bidx, bstr in enumerate(bytes_strs):
                # 可能一行有4个字节
                if len(bstr) != 2:
                    raise ValueError(f"Bad byte string: {bstr}")
                # 计算word内偏移
                word_offset = (curr_addr - base_addr) % word_size
                word_idx = (curr_addr - base_addr) // word_size
                # 按小端拼接
                if 0 <= word_idx < num_words:
                    membank[word_idx] |= int(bstr, 16) << (8 * word_offset)
                curr_addr += 1
    return membank

def load_hex_to_mem_axi(hex_file_path, total_size, axi_ram=None, ram_base=0):
    """
    支持带@地址的verilog hex，加载到axi_ram.mem按小端存储
    """
    curr_addr = ram_base
    bytes_loaded = 0

    with open(hex_file_path, "r") as hex_file:
        for line in hex_file:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if line.startswith("@"):
                # @后面是物理地址（通常以16进制字符串给出）
                curr_addr = int(line[1:], 16)
                continue
            # 一行可能有多个字节，每个用空格或连续两个hex字符
            # 允许 "12 34 56 78" 或 "12345678"
            line_nospace = line.replace(" ", "")
            # 按2字符为一组分割
            byte_strs = [line_nospace[i:i+2] for i in range(0, len(line_nospace), 2)]
            for bstr in byte_strs:
                if bstr:  # 过滤空字符串
                    axi_ram.mem[curr_addr] = int(bstr, 16)
                    curr_addr += 1
                    bytes_loaded += 1

    print(f"Loaded {bytes_loaded} bytes into axi_ram.mem from hex file (with base=0x{ram_base:X}).")

def convert_32_to_wide_numpy(membank, wide_width=128):
    """
    将uint32的numpy数组转换为宽位组合的numpy对象数组
    原始数据存储示例：
    [w0_low, w0_mid_low, w0_mid_high, w0_high, w1_low, ...]
    """
    assert wide_width % 32 == 0, "Width必须是32的倍数"
    factor = wide_width // 32
    dtype = f"u{wide_width//8}"  # 实际使用时可能需要转为对象类型
    
    # 将输入数组重构为(entries, factor)的二维数组
    reshaped = membank.reshape(-1, factor)
    
    # 创建输出数组（用object类型存储大整数）
    wide_membank = np.empty(reshaped.shape[0], dtype=object)
    
    for i in range(reshaped.shape[0]):
        combined = 0
        for j in range(factor):
            # 将numpy uint32转换为Python无符号整数
            word = reshaped[i, j].item()  # 保证为无符号整型
            combined |= word << (j * 32)
        
        # 使用掩码保证位宽（特别针对移位超过64位的情况）
        mask = (1 << wide_width) - 1
        wide_membank[i] = combined & mask
    
    return wide_membank


async def spram_driver_bigwidth(dut, mem_name, membank, io_rd, io_wr, io_addr, io_wdata, io_rdata, is_classic, byte_select=None, use_str=False, verbose=False):
    """
    Single Port SRAM Driver with Byte Select（自动适配数据位宽版）
    
    这个驱动器可以模拟单端口 SRAM 接口，并且能自动根据 DUT 的数据接口位宽来确定数据字的大小，
    比如当 io_wdata 是128 bits时，会自动将数据拆分为16个字节进行 byte_select 操作。
    
    参数说明（与原版类似）：
      - dut: 待测模块（Device Under Test）
      - mem_name (str): SRAM 模块的名称，用于日志记录
      - membank (dict): 模拟 SRAM 存储的字典
      - io_rd (Signal): 读使能信号
      - io_wr (Signal): 写使能信号
      - io_addr (Signal): 地址总线（按数据字为单位）
      - io_wdata (Signal): 写数据总线
      - io_rdata (Signal): 读数据总线
      - is_classic (bool): 模式选择标志，决定读写逻辑
      - byte_select (Signal, optional): 字节使能信号，按位选择写入哪些字节
      - use_str (bool, optional): 是否以二进制字符串格式存储数据
      - verbose (bool, optional): 是否输出详细日志
    """
    while True:
        # 等待时钟上升沿
        await RisingEdge(dut.clk)

        # 根据模式确定读写控制信号
        if is_classic:
            wr = io_wr.value.integer & io_rd.value.integer  # 同时激活时为写操作
            rd = (~io_wr.value.integer) & io_rd.value.integer  # 只有 rd 激活时为读操作
        else:
            wr = io_wr.value.integer
            rd = io_rd.value.integer

        # 获取字地址（假设地址以整个数据字为单位）
        membank_addr = io_addr.value.integer

        if wr:  # 写操作
            if membank_addr >= len(membank):
                dut._log.warning(f"地址 {membank_addr:#x} 超出 {mem_name} 存储空间范围！")
                continue

            # 自动根据 io_wdata 的位宽确定数据字节数
            data_bits = len(io_wdata.value.binstr)  # 当前数据总线的位宽（比如128）
            num_bytes = data_bits // 8              # 字节数（比如128/8=16）

            if byte_select is not None:
                # 假设 byte_select 的位宽与字节数一致
                byte_mask = byte_select.value.integer
                for byte_idx in range(num_bytes):
                    if byte_mask & (1 << byte_idx):
                        byte_shift = byte_idx * 8
                        byte_data = (io_wdata.value.integer >> byte_shift) & 0xFF
                        current_data = membank[membank_addr]
                        new_data = (current_data & ~(0xFF << byte_shift)) | (byte_data << byte_shift)
                        membank[membank_addr] = new_data
            else:
                # 没有 byte_select，直接写入整个数据字
                membank[membank_addr] = io_wdata.value.integer

            # 动态计算输出格式宽度
            hex_width = data_bits // 4  # 每4位对应1个16进制数字
            dut._log.info(f'SPRAM {mem_name} 写入地址: {membank_addr:#x}, 数据: 0x{io_wdata.value.integer:0{hex_width}x}')
        
        elif rd:  # 读操作
            if membank_addr >= len(membank):
                dut._log.warning(f"地址 {membank_addr:#x} 超出 {mem_name} 存储空间范围！")
                continue

            rddata = int(membank[membank_addr])
            io_rdata.value = rddata

            if verbose:
                hex_width = data_bits // 4  # 用同样位宽格式显示数据
                dut._log.info(f'SPRAM {mem_name} 读取地址: {membank_addr:#x}, 数据: 0x{rddata:0{hex_width}x}')

import logging

class ZEMUFetcher:
    def __init__(self, iram):
        """
        初始化 ZEMUFetcher。
        Args:
            iram (numpy.ndarray): 模拟的 IRAM，索引为 word 地址（以 4 字节为单位），值为 32 位数据。
        """
        # 初始化日志器
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.INFO)  # 设置日志级别
        ch = logging.StreamHandler()  # 设置控制台输出
        ch.setLevel(logging.INFO)  # 设置日志级别
        formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')  # 日志格式
        ch.setFormatter(formatter)
        self.logger.addHandler(ch)
        
        self.iram = iram  # IRAM 存储
        # 程序计数器，初始地址为 0
        self.pc = 0  
        self.npc = 0  

    def fetch(self):
        """
        从 IRAM 中读取指令，并判断是否为压缩指令。
        Returns:
            tuple: (instr, is_compressed)，返回指令和是否为压缩指令的标志。
        """
        self.pc = self.npc
        word_address = self.pc // 4  # 计算 word 对齐地址
        word_data = self.iram[word_address] if word_address < len(self.iram) else 0xFFFFFFFF  # 读取 32 位 word，默认值为无效指令

        byte_offset = self.pc % 4  # 计算字节偏移
        if byte_offset == 0:  # 低半字节（低 16 位）
            first_half = word_data & 0xFFFF
        else:  # 高半字节（高 16 位）
            first_half = (word_data >> 16) & 0xFFFF

        # 判断是否为压缩指令
        if (first_half & 0x3) != 0x3:
            # 压缩指令
            instr = first_half
            is_compressed = True
            self.npc += 2  # 压缩指令，PC + 2
        else:
            # 非压缩指令（需要读取完整 32 位）
            if byte_offset == 0:  # Word 对齐读取
                instr = word_data
            else:  # 跨 word 读取高 16 位
                next_word_data = self.iram[word_address + 1] if (word_address + 1) < len(self.iram) else 0xFFFFFFFF
                instr = ((next_word_data << 16) | first_half) & 0xFFFFFFFF # 32bits 掩码来屏蔽超出的下一个word的高16bits
            is_compressed = False
            self.npc += 4  # 非压缩指令，PC + 4
        self.logger.info(f'Fetcher.PC : {self.pc:08x}, instr : {instr:08x}, is_compress : {is_compressed}')
        return instr, is_compressed

    def reset(self, start_pc=0):
        """
        重置 PC。
        Args:
            start_pc (int): 重置后的 PC 地址。
        """
        self.pc = start_pc

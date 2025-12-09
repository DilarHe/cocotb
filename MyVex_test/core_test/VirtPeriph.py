import logging

class VirtualUART:
    def __init__(self, uart_base, buffer_size=64):
        """
        模拟 UART 的行为。
        Args:
            uart_base (int): 串口映射的基地址。
            buffer_size (int): 缓冲区大小。
        """
        # 初始化日志器
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.INFO)  # 设置日志级别
        ch = logging.StreamHandler()  # 设置控制台输出
        ch.setLevel(logging.INFO)  # 设置日志级别
        formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')  # 日志格式
        ch.setFormatter(formatter)
        self.logger.addHandler(ch)
        
        self.uart_base = uart_base  # UART 的基地址
        self.buffer_size = buffer_size  # 缓冲区大小
        self.buffer = []  # 缓冲区

    def write_char(self, char):
        """
        写入一个字符到 UART 模拟器。
        Args:
            char (int): 写入的字符。
        """
        if len(self.buffer) < self.buffer_size and char != ord('\n'):
            self.buffer.append(chr(char))
        else:
            if char == ord('\n'):  # 遇到换行符，立即打印
                self.buffer.append(chr(char))
            # 打印缓冲区的内容
            self.print_buffer()

    def print_buffer(self):
        """
        打印缓冲区内容并清空缓冲区。
        """
        if self.buffer:
            message = ''.join(self.buffer)
            self.logger.info(f"UART OUTPUT: {message.strip()}")  # 使用 logger 输出日志
            self.buffer = []  # 清空缓冲区
            
class VirtualTerminal:
    def __init__(self, terminal_base, buffer_size=64):
        """
        模拟 Terminal 的行为。
        Args:
            terminal_base (int): 串口映射的基地址。
            buffer_size (int): 缓冲区大小。
            测试 Terminal 打印，注意testbench仿真时间需要根据输出内容增加，不然会导致看不到输出！
        """
        # 初始化日志器
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.INFO)  # 设置日志级别
        ch = logging.StreamHandler()  # 设置控制台输出
        ch.setLevel(logging.INFO)  # 设置日志级别
        formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')  # 日志格式
        ch.setFormatter(formatter)
        self.logger.addHandler(ch)
        
        self.terminal_base = terminal_base  # Terminal 的基地址
        self.buffer_size = buffer_size  # 缓冲区大小
        self.buffer = []  # 缓冲区

    def write_char(self, char):
        """
        写入一个字符到 terminal 模拟器。
        Args:
            char (int): 写入的字符。
        """
        if len(self.buffer) < self.buffer_size and char != ord('\n'):
            self.buffer.append(chr(char))
        else:
            if char == ord('\n'):  # 遇到换行符，立即打印
                self.buffer.append(chr(char))
            # 打印缓冲区的内容
            self.print_buffer()

    def print_buffer(self):
        """
        打印缓冲区内容并清空缓冲区。
        """
        if self.buffer:
            message = ''.join(self.buffer)
            self.logger.info(f"Terminal OUTPUT: {message.strip()}")  # 使用 logger 输出日志
            self.buffer = []  # 清空缓冲区
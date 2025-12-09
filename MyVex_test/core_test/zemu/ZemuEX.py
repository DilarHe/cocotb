import logging
from ZemuOPS import *
from ZemuISA import DEFAULT_CSR_VALUES

# ZYY RISC-V Emulator
class ZEMUExecutor:
    def __init__(self, dram_base, dram):
        # 初始化日志器
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.INFO)  # 设置日志级别
        ch = logging.StreamHandler()  # 设置控制台输出
        ch.setLevel(logging.INFO)  # 设置日志级别
        formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')  # 日志格式
        ch.setFormatter(formatter)
        self.logger.addHandler(ch)
        
        # 导入操作映射表
        self.instr_map = BASE_OPERATIONS_MAP
        # 初始化指令统计字典
        self.instr_stats = {name: 0 for name in self.instr_map}
        # 创建算子实例
        self.ops = ZEMUOperators()
        # 初始化NEW_PC
        self.branch_taken = False
        self.is_exception = False
        self.new_pc = None
        # 初始化寄存器，将reg设置为0 
        self.regs = ZEMUGPR()
        # 初始化CSR寄存器
        self.csrs = ZEMUCSR()
        # 初始化寄存器，将reg设置为0 
        self.fregs = ZEMUFPR()
        # 初始化外设地址检测
        self.op_peripheral = False  # 外设操作检测
        # 初始化执行STORE标志
        self.store_taken = False
        # 初始化DRAM镜像
        self.dram_base = dram_base  
        self.dram = dram 
        
    def execute(self, pc, npc, instr_info, verbose=False):
        # 复位计算标志信息，避免影响执行结果
        self.branch_taken = False
        self.is_exception = False
        self.new_pc = None
        self.store_taken = False
        self.op_peripheral = False
        
        """执行解码后的指令"""
        name = instr_info["name"]
        op_info = self.instr_map.get(name)
        
        if op_info:
            operation_name = op_info["operation"]
            
            uses_imm = op_info.get("uses_imm", False)  # 默认 False，如果没有该键
            is_branch = op_info.get("is_branch", False)  # 默认 False，如果没有该键
            is_ldst = op_info.get("is_ldst", False)  # 默认 False，如果没有该键
            # 如果是CSR指令，设置is_csr标志
            is_csr = op_info.get("is_csr", False)  # 默认 False，如果没有该键
            is_exception = op_info.get("is_exception", False)  # 默认 False，如果没有该键
            # 如果是浮点寄存器操作，设置is_freg标志
            is_freg = op_info.get("is_freg", False)  # 默认 False，如果没有该键

            operation = getattr(self.ops, operation_name)  # 动态调用操作函数
            
            # 更新指令执行计数
            self.instr_stats[name] += 1
            
            # 根据指令操作类型动态调用操作函数
            if is_branch: 
                self.branch_taken, self.new_pc, self.regs = operation(pc, npc, instr_info, self.regs)
                self.logger.info(f"Executed {name}: branch_taken={self.branch_taken}, new_pc={self.new_pc}")
            elif is_ldst and not is_freg:
                self.regs, self.dram, byte_addr, word_addr, self.store_taken , self.op_peripheral = operation(instr_info, self.regs, self.dram_base, self.dram)
                if self.op_peripheral:
                    self.logger.info(f"Executed {name} at peripheral: byte_addr={byte_addr:08x}, word_addr={word_addr:08x}")
                elif self.store_taken is not None:
                    self.logger.info(f"Executed {name}: byte_addr={byte_addr:08x}, word_addr={word_addr:08x}, word_value={self.dram[word_addr]:08x}")
            elif is_csr:
                if is_exception:
                    self.regs, self.csrs, self.new_pc = operation(pc, instr_info, self.regs, self.csrs)
                    self.is_exception = True
                    self.logger.info(f"Executed {name}: is_exception={self.is_exception} , new_pc={self.new_pc}")
                else:
                    self.regs, self.csrs, csr_addr = operation(pc, instr_info, self.regs, self.csrs)
                    self.logger.info(f"Executed {name}: CSR[{csr_addr:03x}] read as {self.csrs[csr_addr]:08x}")
            else:
                if is_freg:
                    print("Executing floating-point operation: %s", name)
                    if is_ldst:
                        self.fregs, self.dram, byte_addr, word_addr, self.store_taken = operation(pc, instr_info, uses_imm, self.regs, self.dram_base, self.dram, self.fregs)    
                        if self.store_taken is not None:
                            self.logger.info(f"Executed {name}: byte_addr={byte_addr:08x}, word_addr={word_addr:08x}, word_value={self.dram[word_addr]:08x}")
                    else :
                        self.fregs,self.regs = operation(pc, instr_info, uses_imm, self.regs, self.dram, self.fregs)
                else:
                    self.regs = operation(pc, instr_info, uses_imm, self.regs, self.dram)
                if verbose:
                    self.logger.info(f"Executed {name}: {' '.join([hex(reg) for reg in self.regs])}")
        else:
            self.logger.warning(f"Unsupported instruction: {name}")
        
    def log_instr_stats(self):
        """输出指令执行统计结果"""
        self.logger.info("Instruction Execution Stats:")
        for name, count in self.instr_stats.items():
            self.logger.info(f"{name}: {count} times")
            
class ZEMUGPR:
    def __init__(self):
        self._regs = [0] * 32  # 32个寄存器
    def __setitem__(self, index, value):
        if index == 0:
            # 永远不允许写入寄存器 x0
            return
        self._regs[index] = value
    
    def __getitem__(self, index):
        return self._regs[index]
    
    def __repr__(self):
        return repr(self._regs)

class ZEMUCSR:
    def __init__(self):
        # 只初始化常用或合法的CSR，或者用dict动态分配
        self._csrs = dict(DEFAULT_CSR_VALUES)

    def __setitem__(self, addr, value):
        self._csrs[addr] = value

    def __getitem__(self, addr):
        return self._csrs.get(addr, 0)  # 默认值为0

    def __repr__(self):
        # 按顺序显示，便于debug
        return repr(dict(sorted(self._csrs.items())))

class ZEMUFPR:
    def __init__(self):
        self._regs = [0] * 32  # 32个寄存器

    def __setitem__(self, index, value):
        self._regs[index] = value
    
    def __getitem__(self, index):
        return self._regs[index]

    def __repr__(self):
        return repr(self._regs)
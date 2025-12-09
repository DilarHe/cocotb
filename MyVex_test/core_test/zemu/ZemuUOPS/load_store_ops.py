

class LoadStoreOps():
    def is_peripheral_addr(self, addr):
        # 例：判断是否属于mtime、clint等外设
        # 你可以灵活配置范围
        return (
            (0x2000000 <= addr < 0x2001000) or  # mtime, mtimecmp, mtimectrl...
            (0x10000000 <= addr < 0x10001000)   # 其它外设举例
        )

    def peripheral_read(self, addr):
        # 按32位 word 对齐
        aligned_addr = addr & ~0x3
        if aligned_addr == 0x2000004:   # mtime
            return self.mtime_value & 0xFFFFFFFF
        elif aligned_addr == 0x2000008: # mtimecmp
            return self.mtimecmp_value & 0xFFFFFFFF
        # ... 其他外设判断
        else:
            self.logger.warning(f"Read unknown peripheral addr: {hex(addr)}")
            return 0


    def lb(self, instr_info, regs, mem_base, mem):
        # 从指令信息中提取寄存器和立即数
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        imm = instr_info["imm"]

        # 计算目标地址
        byte_addr = regs[rs1] + imm
        byte_offset = byte_addr % 4
        word_addr = (byte_addr - mem_base) // 4  # 将字节地址转换为字地址

        # 边界检查，确保访问的内存地址在有效范围内
        if word_addr < 0 or word_addr >= mem.shape[0]:
            # 超出内存范围，打印警告，而不是抛出异常
            self.logger.warning(f"Memory access out of bounds: address {word_addr} (byte address {byte_addr})")
            # 可以选择不继续执行存储操作，或者将 `store_taken` 设置为 False 等
            return regs, mem, byte_addr, word_addr, None , None
        
        # 访存地址正常开启保存标记
        store_taken = False
        mem_byte_data = (mem[word_addr] >> (byte_offset * 8)) & 0xFF
        
        # 对加载的字节数据执行符号扩展
        regs[rd] = self.sign_extend(mem_byte_data, 8) & 0xFFFFFFFF # 通过掩码保留低32位

        # 返回更新后的内存状态，byte_addr 和 word_addr
        return regs, mem, byte_addr, word_addr , store_taken, None
    
    def lh(self, instr_info, regs, mem_base, mem):
        # 从指令信息中提取寄存器和立即数
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        imm = instr_info["imm"]

        # 计算目标地址
        byte_addr = regs[rs1] + imm
        byte_offset = byte_addr % 4
        word_addr = (byte_addr - mem_base) // 4  # 将字节地址转换为字地址

        # 边界检查，确保访问的内存地址在有效范围内
        if word_addr < 0 or word_addr >= mem.shape[0]:
            # 超出内存范围，打印警告，而不是抛出异常
            self.logger.warning(f"Memory access out of bounds: address {word_addr} (byte address {byte_addr})")
            # 可以选择不继续执行加载操作，或者将 `load_taken` 设置为 False 等
            return regs, mem, byte_addr, word_addr, None, None

        # 访存地址正常开启保存标记
        load_taken = False

        # 加载目标字节，注意半字是16位
        mem_halfword_data = (mem[word_addr] >> (byte_offset * 8)) & 0xFFFF  # 读取 16 位的数据

        # 将加载的值存储到目标寄存器
        regs[rd] = self.sign_extend(mem_halfword_data, 16) & 0xFFFFFFFF # 通过掩码保留低32位

        # 返回更新后的内存状态，byte_addr 和 word_addr
        return regs, mem, byte_addr, word_addr, load_taken, None

    def lbu(self, instr_info, regs, mem_base, mem):
        # 从指令信息中提取寄存器和立即数
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        imm = instr_info["imm"]

        # 计算目标地址
        byte_addr = regs[rs1] + imm
        byte_offset = byte_addr % 4
        word_addr = (byte_addr - mem_base) // 4  # 将字节地址转换为字地址
        
        # 边界检查，确保访问的内存地址在有效范围内
        if word_addr < 0 or word_addr >= mem.shape[0]:
            # 超出内存范围，打印警告，而不是抛出异常
            self.logger.warning(f"Memory access out of bounds: address {word_addr} (byte address {byte_addr})")
            # 可以选择不继续执行存储操作，或者将 `store_taken` 设置为 False 等
            return regs, mem, byte_addr, word_addr, None, None

        # 访存地址正常开启保存标记
        store_taken = False
        mem_byte_data = (mem[word_addr] >> (byte_offset * 8)) & 0xFF
        
        # 对加载的字节数据执行符号扩展
        regs[rd] = mem_byte_data

        # 返回更新后的内存状态，byte_addr 和 word_addr
        return regs, mem, byte_addr, word_addr , store_taken, None

    def lhu(self, instr_info, regs, mem_base, mem):
        # 从指令信息中提取寄存器和立即数
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        imm = instr_info["imm"]

        # 计算目标地址
        byte_addr = regs[rs1] + imm
        byte_offset = byte_addr % 4
        word_addr = (byte_addr - mem_base) // 4  # 将字节地址转换为字地址

        # 边界检查，确保访问的内存地址在有效范围内
        if word_addr < 0 or word_addr >= mem.shape[0]:
            # 超出内存范围，打印警告，而不是抛出异常
            self.logger.warning(f"Memory access out of bounds: address {word_addr} (byte address {byte_addr})")
            # 可以选择不继续执行加载操作，或者将 `load_taken` 设置为 False 等
            return regs, mem, byte_addr, word_addr, None, None

        # 访存地址正常开启保存标记
        load_taken = False

        # 加载目标字节，注意半字是16位
        mem_halfword_data = (mem[word_addr] >> (byte_offset * 8)) & 0xFFFF  # 读取 16 位的数据

        # 将加载的值存储到目标寄存器
        regs[rd] = mem_halfword_data

        # 返回更新后的内存状态，byte_addr 和 word_addr
        return regs, mem, byte_addr, word_addr, load_taken, None

    def lw(self, instr_info, regs, mem_base, mem):
        # 从指令信息中提取寄存器和立即数
        rd = instr_info["rd"]
        rs1 = instr_info["rs1"]
        imm = instr_info["imm"]

        # 计算目标地址
        byte_addr = regs[rs1] + imm
        word_addr = (byte_addr - mem_base) // 4  # 将字节地址转换为字地址
        # 1. 外设地址检测
        if self.is_peripheral_addr(byte_addr):
            word_data = self.peripheral_read(byte_addr)
            regs[rd] = word_data
            return regs, mem, byte_addr, word_addr, None, True
        # 边界检查，确保访问的内存地址在有效范围内
        if word_addr < 0 or word_addr >= mem.shape[0]:
            # 超出内存范围，打印警告，而不是抛出异常
            self.logger.warning(f"Memory access out of bounds: address {word_addr} (byte address {byte_addr})")
            # 可以选择不继续执行存储操作，或者将 `store_taken` 设置为 False 等
            return regs, mem, byte_addr, word_addr, None, None

        # 访存地址正常开启保存标记
        store_taken = False
        # 将值存储到内存
        regs[rd] = mem[word_addr] # 从内存加载到目标寄存器

        # 返回更新后的内存状态，byte_addr 和 word_addr
        return regs, mem, byte_addr, word_addr , store_taken, None

    def sb(self, instr_info, regs, mem_base, mem):
        """Store byte: 将rs2的值存储到由rs1+imm计算得到的内存地址处"""

        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]

        # 计算目标地址
        byte_addr = regs[rs1] + imm
        byte_offset = byte_addr % 4
        word_addr = (byte_addr - mem_base) // 4  # 将字节地址转换为字地址
        
        # 边界检查，确保访问的内存地址在有效范围内
        if word_addr < 0 or word_addr >= mem.shape[0]:
            # 超出内存范围，打印警告，而不是抛出异常
            self.logger.warning(f"Memory access out of bounds: address {word_addr} (byte address {byte_addr})")
            # 可以选择不继续执行存储操作，或者将 `store_taken` 设置为 False 等
            return regs, mem, byte_addr, word_addr, None, None

        # 将rs2的低字节提取出来
        byte_to_store = regs[rs2] & 0xFF  # 仅取低字节
        
        # 使用位运算将字节存储到内存的相应位置
        mem_byte_data = mem[word_addr]
        mem_byte_data &= ~(0xFF << (byte_offset * 8))  # 清除对应字节
        mem_byte_data |= (byte_to_store << (byte_offset * 8))  # 存储字节     
           
        # 访存地址正常开启保存标记
        store_taken = True
        
        # 更新内存
        mem[word_addr] = mem_byte_data

        # 返回更新后的内存状态，byte_addr 和 word_addr
        return regs, mem, byte_addr, word_addr , store_taken, None

    def sh(self, instr_info, regs, mem_base, mem):
        """Store Halfword: 将 rs2 的值存储到由 rs1 + imm 计算得到的内存地址处"""

        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]

        # 计算目标地址
        halfword_addr = regs[rs1] + imm
        byte_offset = halfword_addr % 4  # 计算地址偏移量
        word_addr = (halfword_addr - mem_base) // 4  # 将字节地址转换为字地址

        # 边界检查，确保访问的内存地址在有效范围内
        if word_addr < 0 or word_addr >= mem.shape[0]:
            # 超出内存范围，打印警告，而不是抛出异常
            self.logger.warning(f"Memory access out of bounds: address {word_addr} (byte address {halfword_addr})")
            return regs, mem, halfword_addr, word_addr, None, None

        # 将 rs2 的低 16 位提取出来，确保数据在 16 位范围内
        halfword_to_store = regs[rs2] & 0xFFFF  # 仅取低 16 位

        # 使用位运算将半字存储到内存的相应位置
        mem_word_data = mem[word_addr]

        # 清除目标位置的半字（16 位）并将新的半字存入
        if byte_offset == 0:
            # 低位存储
            mem_word_data &= ~(0xFFFF)  # 清除低 16 位
            mem_word_data |= (halfword_to_store)  # 存储低 16 位
        elif byte_offset == 2:
            # 高位存储
            mem_word_data &= ~(0xFFFF << 16)  # 清除高 16 位
            mem_word_data |= (halfword_to_store << 16)  # 存储高 16 位
        else:
            # 非 2 字节对齐地址，应该抛出异常或警告
            self.logger.warning(f"Unaligned memory access: address {halfword_addr}")
            return regs, mem, halfword_addr, word_addr, None, None

        # 更新内存
        mem[word_addr] = mem_word_data

        # 返回更新后的内存状态
        return regs, mem, halfword_addr, word_addr, True, None

    
    def sw(self, instr_info, regs, mem_base, mem):
        """Store Word: 将rs2的值存储到由rs1+imm计算得到的内存地址处"""

        rs1 = instr_info["rs1"]
        rs2 = instr_info["rs2"]
        imm = instr_info["imm"]

        # 计算目标地址
        byte_addr = regs[rs1] + imm
        word_addr = (byte_addr - mem_base) // 4  # 将字节地址转换为字地址
        
        # 边界检查，确保访问的内存地址在有效范围内
        if word_addr < 0 or word_addr >= mem.shape[0]:
            # 超出内存范围，打印警告，而不是抛出异常
            self.logger.warning(f"Memory access out of bounds: address {word_addr} (byte address {byte_addr})")
            # 可以选择不继续执行存储操作，或者将 `store_taken` 设置为 False 等
            return regs, mem, byte_addr, word_addr, None, None

        # 访存地址正常开启保存标记
        store_taken = True
        # 将值存储到内存
        mem[word_addr] = regs[rs2]  # 直接存储到内存

        # 返回更新后的内存状态，byte_addr 和 word_addr
        return regs, mem, byte_addr, word_addr , store_taken, None
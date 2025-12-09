import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer, ClockCycles
from cocotbext.ahb import AHBBus, AHBLiteMaster
import random

async def reset_dut(reset_n, duration_ns=100):
    reset_n.value = 0
    await Timer(duration_ns, units='ns')
    reset_n.value = 1
    await RisingEdge(reset_n)
    reset_n._log.info("Reset complete.")

@cocotb.test()
async def ahb_slave_tb(dut):
    """Test AHB slave connected to RAM-like interface with ram_req/ram_grant."""
    clock = Clock(dut.clk, 10, units='ns')  # 100 MHz clock
    cocotb.start_soon(clock.start())

    # Reset
    await reset_dut(dut.resetn, duration_ns=100)

    # 构造一个 AHB 接口总线对象
    ahb_bus = AHBBus.from_prefix(
        dut, 
        prefix = "",
        signals = {
            "haddr" : "ahbs_HADDR",
            "hsize" : "ahbs_HSIZE",
            "htrans" : "ahbs_HTRANS",
            "hwdata" : "ahbs_HWDATA",
            "hrdata" : "ahbs_HRDATA",
            "hwrite" : "ahbs_HWRITE",
            "hready" : "ahbs_HREADYOUT",
            "hresp" : "ahbs_HRESP"
        },
        optional_signals = {
            "hsel" : "ahbs_HSEL",
            "hready_in" : "ahbs_HREADY",
        }
    )
    master = AHBLiteMaster(ahb_bus, dut.clk, dut.resetn, big_endian=False)

    # 创建简单的RAM模型
    class SimpleRAM:
        def __init__(self, size_kb=4):
            self.size = size_kb * 1024
            self.mem = [0] * (self.size // 4)
        
        async def access(self, dut):
            while True:
                await RisingEdge(dut.clk)
                if dut.ram_req.value == 1 and dut.ram_grant.value == 1:
                    addr = dut.ram_addr.value.integer >> 2
                    if addr < len(self.mem):
                        if dut.ram_we.value == 1:  # 写操作
                            # 根据字节使能更新RAM
                            be = dut.ram_be.value.integer
                            wdata = dut.ram_wdata.value.integer
                            current = self.mem[addr]
                            
                            # 更新字节使能对应的字节
                            if be & 0x1: current = (current & 0xFFFFFF00) | (wdata & 0xFF)
                            if be & 0x2: current = (current & 0xFFFF00FF) | (wdata & 0xFF00)
                            if be & 0x4: current = (current & 0xFF00FFFF) | (wdata & 0xFF0000)
                            if be & 0x8: current = (current & 0x00FFFFFF) | (wdata & 0xFF000000)
                            
                            self.mem[addr] = current
                            dut._log.info(f"RAM Write: addr=0x{addr*4:08X}, data=0x{current:08X}, be=0x{be:04b}")
                        else:  # 读操作
                            dut.ram_rdata.value = self.mem[addr]
                            dut._log.info(f"RAM Read: addr=0x{addr*4:08X}, data=0x{self.mem[addr]:08X}")
                    else:
                        dut._log.error(f"RAM access out of range: 0x{addr*4:08X}")

    # 初始化RAM模型
    ram_model = SimpleRAM()
    cocotb.start_soon(ram_model.access(dut))

    # 模拟RAM授权逻辑
    async def ram_grant_logic():
        while True:
            await RisingEdge(dut.clk)
            # 随机延迟授权，模拟真实环境
            if dut.ram_req.value == 1 and random.random() > 0.3:
                dut.ram_grant.value = 1
            else:
                dut.ram_grant.value = 0

    cocotb.start_soon(ram_grant_logic())

    await ClockCycles(dut.clk, 5)

    # 测试不同大小的传输
    sizes = {
        0: 1,  # 字节
        1: 2,  # 半字
        2: 4   # 字
    }

    for hsize_val, size_bytes in sizes.items():
        dut._log.info(f"Testing {size_bytes*8}-bit transfers")
        
        # 测试写入
        test_addr = 0x00000020 + (hsize_val << 4)
        test_data = 0xCAFEBABE & ((1 << (size_bytes * 8)) - 1)  # mask数据宽度
        
        dut._log.info(f"Writing 0x{test_data:X} to 0x{test_addr:X} with size {size_bytes*8} bits")
        await master.write(test_addr, test_data, size=size_bytes)
        
        await ClockCycles(dut.clk, 5)
        
        # 测试读取
        read_bytes = await master.read(test_addr, size=size_bytes)
        dut._log.info(f"Read data = 0x{read_bytes}")
        
        
        await ClockCycles(dut.clk, 5)

    # 测试背靠背传输
    dut._log.info("Testing back-to-back transfers")
    for i in range(4):
        addr = 0x100 + i * 4
        data = 0x12345678 + i
        await master.write(addr, data)
    
    await ClockCycles(dut.clk, 2)
    
    for i in range(4):
        addr = 0x100 + i * 4
        expected = 0x12345678 + i
        read_bytes = await master.read(addr)

    # pipeline形式的读写事务激励
    dut._log.info("Testing pipeline transfers")
    
    # 流水线测试数据
    address   = [0x10, 0x14, 0x18, 0x1C, 0x10, 0x14, 0x18, 0x1C]
    value     = [0xAAAA, 0xBBBB, 0xCCCC, 0xDDDD, 0x0000, 0x0000, 0x0000, 0x0000]
    size      = [2, 2, 2, 2, 2, 2, 2, 2]
    txn_type  = [1, 1, 1, 1, 0, 0, 0, 0]  # 前4次写入，后4次读取
    
    # 是否使用流水线模式，设为True开启Pipeline
    use_pipeline = True
    
    # 执行事务
    resp = await master.custom(address, value, txn_type, size, use_pipeline)
    
    # 打印响应结果
    for i, r in enumerate(resp):
        txn = "WRITE" if txn_type[i] else "READ"
        dut._log.info(f"{txn} Addr={hex(address[i])} Resp={r}, Data={hex(value[i])}")

    await ClockCycles(dut.clk, 10)
    dut._log.info("Test completed")
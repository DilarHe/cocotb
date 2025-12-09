# test_skid_buf.py
import random
import cocotb
from cocotb.clock      import Clock
from cocotb.triggers   import RisingEdge, Timer

CLK_PERIOD = 5  # ns


async def reset(dut, cycles=2):
    dut.rst_n.value = 0
    for _ in range(cycles):
        await RisingEdge(dut.clk)
    dut.rst_n.value = 1
    await RisingEdge(dut.clk)
    dut._log.info("Reset done")


def drive_slave_if(dut, valid, addr, data):
    """一次性驱动 Slave 侧信号"""
    dut.s_valid_i.value = valid
    dut.s_addr_i .value = addr
    dut.s_data_i .value = data


@cocotb.test()
async def test_skid_buf(dut):
    """完整功能验证"""
    # ───── 时钟 & 复位 ──────────────────────────────────────────
    cocotb.start_soon(Clock(dut.clk, CLK_PERIOD, units="ns").start())
    await reset(dut)

    # 方便随机但可复现
    random.seed(2025)

    # ───── 场景 1：下游始终 ready，skid 不应被使用 ───────────────
    N = 10
    for i in range(N):
        # 准备数据
        addr = random.getrandbits(dut.ADDR_WIDTH.value)
        data = random.getrandbits(dut.DATA_WIDTH.value)

        # 下游永远 ready
        dut.m_ready_i.value = 1

        # 发送 1 拍 valid
        drive_slave_if(dut, 1, addr, data)
        await RisingEdge(dut.clk)
        drive_slave_if(dut, 0, 0, 0)          # 拉低 valid，模拟“打拍”

        # 应立即透传
        await RisingEdge(dut.clk)
        assert dut.m_valid_o.value == 1,  "场景1：m_valid_o 应为 1"
        assert dut.m_addr_o.value  == addr, "场景1：地址应直通"
        assert dut.m_data_o.value  == data, "场景1：数据应直通"
        await RisingEdge(dut.clk)            # 结束该 beat

    dut._log.info("场景1 完成 —— 直通 OK")

    # ───── 场景 2：下游临时 not-ready，触发寄存一次 ──────────────
    addr2 = 0xA5A5A5A5
    data2 = 0x5A5A5A5A

    # 周期 0：发数据，m_ready_i=0 → DUT 必须缓存
    dut.m_ready_i.value = 0
    drive_slave_if(dut, 1, addr2, data2)
    await RisingEdge(dut.clk)

    # 周期 1：slave side 再送一拍 idle，m_ready 仍然 0
    drive_slave_if(dut, 0, 0, 0)
    await RisingEdge(dut.clk)

    # 周期 2：m_ready 变 1 → DUT 必须把缓存的 beat 推出去
    dut.m_ready_i.value = 1
    await RisingEdge(dut.clk)

    assert dut.m_valid_o.value == 1,          "场景2：back-pressure 后应拉高 m_valid_o"
    assert dut.m_addr_o.value  == addr2,      "场景2：地址应正确重放"
    assert dut.m_data_o.value  == data2,      "场景2：数据应正确重放"

    await RisingEdge(dut.clk)
    dut._log.info("场景2 完成 —— 单次 back-pressure OK")

    # ───── 场景 3：连续 back-pressure，并且上游继续发新包 ───────
    beats = [
        (0x11, 0xAA),
        (0x22, 0xBB),
        (0x33, 0xCC)
    ]
    dut.m_ready_i.value = 0   # 持续 back-pressure

    # 周期 0：首包到来 -> 缓存
    drive_slave_if(dut, 1, beats[0][0], beats[0][1])
    await RisingEdge(dut.clk)

    # 周期 1：第二包到来，同时 skid_buf 里已有一拍 -> skid_buf.valid 必须保持为 1
    drive_slave_if(dut, 1, beats[1][0], beats[1][1])
    await RisingEdge(dut.clk)

    # 周期 2：第三包到来
    drive_slave_if(dut, 1, beats[2][0], beats[2][1])
    await RisingEdge(dut.clk)

    # 周期 3：上游 idle，downstream 终于 ready
    dut.m_ready_i.value = 1

    # 依次应该把三拍全部推出去
    for exp_addr, exp_data in beats:
        await RisingEdge(dut.clk)
        print(f"周期 {dut.clk.value}: m_addr_o={int(dut.m_addr_o.value)}, m_data_o={int(dut.m_data_o.value)}")
        print(f"周期 {dut.clk.value}: exp_addr={exp_addr}, exp_data={exp_data}")
        assert dut.m_valid_o.value,                 "场景3：m_valid_o 应为 1"
        assert int(dut.m_addr_o.value) == exp_addr,      "场景3：地址顺序错误"
        assert int(dut.m_data_o.value) == exp_data,      "场景3：数据顺序错误"

    dut._log.info("场景3 完成 —— 连续 back-pressure OK")

    # ───── 结束仿真 ─────────────────────────────────────────────
    await Timer(100, units="ns")
    dut._log.info("All tests passed 🎉")



if __name__ == '__main__':
    print('test')
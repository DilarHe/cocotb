import cocotb
from cocotb.triggers import RisingEdge, Timer

def get_dut_gpr(dut):
    """提取DUT中所有的GPR寄存器值，并返回一个列表"""
    return [getattr(dut.core.rf, f"reg_r_{i}").value.integer for i in range(32)]

def get_dut_fpr(dut):
    """提取DUT中所有的FPR寄存器值，并返回一个列表"""
    return [getattr(dut.core.frf, f"freg_r_{i}").value.integer for i in range(32)]

async def decoder_illegal_instr_monitor(dut,illegal_flag):
    """
    持续监视 decoder 的非法指令信号，当信号有效时触发断言。
    
    Args:
        illegal_flag (cocotb.handle.ModifiableObject): DUT 中表示非法指令的信号。
    
    Raises:
        AssertionError: 当 `illegal_flag` 变为有效时触发。
    """
    while True:
        # 等待下一个时钟上升沿
        await RisingEdge(dut.clk)

        # 检查 illegal_flag 是否有效
        if illegal_flag.value.integer == 1:
            # 记录日志
            illegal_flag._log.error("Decoder detected an illegal instruction at cycle.")
            
            # 触发断言
            assert False, "Illegal instruction detected!"
            
async def pipeline_stall_monitor(dut,pipeline_stall, stall_fail_clk_cycle):
    """
    持续监控 pipeline_stall 信号，检测其发生和结束时刻。
    如果 stall 持续时间超过设定的时钟周期 (stall_fail_clk_cycle)，立即报错并停止仿真。
    
    Args:
        pipeline_stall (cocotb.handle.ModifiableObject): DUT 中表示流水线停顿的信号。
        stall_fail_clk_cycle (int): 允许的最大停顿时钟周期数。
    
    Raises:
        AssertionError: 当 stall 持续时间超过 `stall_fail_clk_cycle` 时触发。
    """
    stall_active = False  # 标志流水线停顿是否正在发生
    stall_start_cycle = 0  # 记录停顿开始的时钟周期
    current_cycle = 0  # 当前时钟周期计数器

    while True:
        await RisingEdge(dut.clk)  # 等待时钟上升沿
        current_cycle += 1  # 更新当前时钟周期计数器

        if pipeline_stall.value.integer == 1:  # 检测到流水线停顿
            if not stall_active:
                # 如果之前未记录停顿，则记录停顿开始
                stall_active = True
                stall_start_cycle = current_cycle
                pipeline_stall._log.info(f"Pipeline stall started at cycle {stall_start_cycle}.")
            else:
                # 持续检测是否超出允许的停顿周期
                stall_duration = current_cycle - stall_start_cycle
                if stall_duration > stall_fail_clk_cycle:
                    pipeline_stall._log.error(
                        f"Pipeline stall duration {stall_duration} exceeded limit of {stall_fail_clk_cycle} cycles."
                    )
                    assert False, f"Pipeline stall exceeded allowed duration: {stall_duration} cycles > {stall_fail_clk_cycle} cycles."
        else:
            if stall_active:
                # 停顿结束时记录日志
                stall_duration = current_cycle - stall_start_cycle
                pipeline_stall._log.info(f"Pipeline stall ended at cycle {current_cycle}. Duration: {stall_duration} cycles.")
                # 重置状态
                stall_active = False
            
async def core_halt_test_driver(dut):
    """
    """
    stall_active = False  # 标志流水线停顿是否正在发生
    stall_start_cycle = 0  # 记录停顿开始的时钟周期

    while True:
        await RisingEdge(dut.clk)  # 等待时钟上升沿

        if dut.core.hdu_unit_hdu2exu_halt_state.value.integer == 1:  # 检测到halt
            dut.resume_req.value = 1
            dut._log.info(f"Pipeline halt resume ")
         
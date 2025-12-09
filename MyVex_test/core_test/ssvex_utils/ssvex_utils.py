import random
import math
import cocotb
import numpy as np
from numfi import numfi
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, RisingEdge, Timer, Edge
from cocotb.handle import Force
from cocotb.utils import get_sim_time
import matplotlib.pyplot as plt
import sys
import logging

# === logger 设置（放在模块顶层） ===
class SimTimeFormatter(logging.Formatter):
    def format(self, record):
        # 加入自定义字段
        sim_time = get_sim_time(units='ns')
        record.sim_time = f"{sim_time} ns"   # 👈 手动添加单位字符串
        return super().format(record)

# 创建一个 logger，名字必须与 cocotb 的 logger 不重复
decode_logger = logging.getLogger("cocotb.decode_logger")
decode_logger.setLevel(logging.INFO)
decode_logger.propagate = False  # 防止冒泡到 cocotb.log
# 创建 file handler
decode_file_handler = logging.FileHandler("sslogs/decode_log.txt" , mode = 'w')
decode_file_handler.setLevel(logging.INFO)
# 设置输出格式
formatter = SimTimeFormatter("[%(sim_time)s] %(message)s")
decode_file_handler.setFormatter(formatter)
# 添加 handler（避免重复添加）
if not decode_logger.hasHandlers():
    decode_logger.addHandler(decode_file_handler)

# 创建一个 logger，名字必须与 cocotb 的 logger 不重复
retire_logger = logging.getLogger("cocotb.retire_logger")
retire_logger.setLevel(logging.INFO)
retire_logger.propagate = False  # 防止冒泡到 cocotb.log
# 创建 file handler
retire_file_handler = logging.FileHandler("sslogs/retire_log.txt", mode = 'w')
retire_file_handler.setLevel(logging.INFO)
# 设置输出格式
formatter = SimTimeFormatter("[%(sim_time)s] %(message)s")
retire_file_handler.setFormatter(formatter)
# 添加 handler（避免重复添加）
if not retire_logger.hasHandlers():
    retire_logger.addHandler(retire_file_handler)

@cocotb.coroutine
async def monitor_decode(dut,rob_table):
    while True:
        await RisingEdge(dut.clk)
        if int(dut.SScoreIFU.IDU.isst_pipe.is_rob_create_en_vec.value) != 0:
            # 任意一位为 1，表示有 rob create 有效
            cocotb.log.info("At least one instruction is being dispatched to ROB")
            for i in range(3):
                dispatch_valid = int(getattr(dut.SScoreIFU.IDU.isst_pipe, f"is_dis_inst_vld").value)
                if (dispatch_valid >> i) & 0x1:
                    iid = int(getattr(dut.SScoreIFU.IDU.isst_pipe, f"is_inst_iid_vec_{i}").value)
                    inst = int(getattr(dut.SScoreIFU.IDU.isst_pipe, f"is_inst_data_entry_{i}_inst_data_pkg_rd_inst_data").value)  # 原始指令编码
                    rob_table[iid] = {
                        "inst": inst,
                    }
                    decode_logger.info(f"Decode iid={iid}, Inst=0x{inst:08x}")
                # cocotb.log.info(f"[Decode] iid={iid}, PC=0x{pc:08x}, Inst=0x{inst:08x}, rd=x{rd}")

def ssvec_arch_regs(dut,arch_regs):
    for i in range(32):
        pst_idx = int(getattr(dut.SScoreIFU.RTU.pst, f"recover_preg_vec_{i}").value)
        value = int(getattr(dut.SScoreIFU.IDU.Prf, f"pregfile_{pst_idx}_preg_dout").value)
        arch_regs[i] = {
            "value":value,
            "pst_idx":pst_idx
        }
    return arch_regs

@cocotb.coroutine
async def monitor_retire(dut,rob_table,arch_regs):
    while True:
        await RisingEdge(dut.clk)
        if dut.SScoreIFU.RTU.rob.rob_retire_update.value :
            cocotb.log.info("At least one instruction is being reitre to ROB")
            for i in range(3):
                reitre_valid = bool(getattr(dut.SScoreIFU.RTU.rob, f"rob_retire_vec_{i}").value)
                if reitre_valid :
                    iid = int(getattr(dut.SScoreIFU.RTU.rob, f"rob_retire_iid_vec_{i}").value)
                    pc = int(getattr(dut.SScoreIFU.RTU.rob, f"rtu_retire_pc_vec_{i}").value)
                    info = rob_table.pop(iid, None)
                    retire_logger.info(f"RETIRE iid={iid}, PC=0x{pc:08x}, Inst=0x{info['inst']:08x}")
            # Dump PST
            arch_regs = ssvec_arch_regs(dut,arch_regs)
            log_line = ", ".join([
            f"x{i}(p{reg['pst_idx']})={hex(reg['value'])}"
            for i, reg in arch_regs.items()
            ])
            retire_logger.info(f"[{get_sim_time(units='ns')} ns] Arch Regs: {log_line}")


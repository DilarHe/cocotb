#UnicodeEncodeError: 'ascii' codec can't encode characters
# 这里全局生效
export PYTHONIOENCODING=utf-8

# SIM=vcs
SIM=verilator
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = /home/zhangyiyao/coco_work/cocoTest/Trash_IP/ARM/rtl/*

# TOPLEVEL = ReqMergeBuffer
# MODULE = ReqMergeBuf_tb

TOPLEVEL = AHBToRAMBridge
MODULE = ahb_slave_tb

# TOPLEVEL = skid_buf
# MODULE = skid_buf_tb

EXTRA_ARGS += --trace --trace-structs --Wno-WIDTH -Wno-CMPCONST --Wno-UNSIGNED
# EXTRA_ARGS += -full64 -LDFLAGS -Wl,--no-as-needed

include $(shell cocotb-config --makefiles)/Makefile.sim
# include $(shell cocotb-config --makefiles)/Makefile.inc
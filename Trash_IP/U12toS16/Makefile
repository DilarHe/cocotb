SIM=verilator
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = /home/zhangyiyao/coco_work/cocoTest/Trash_IP/U12toS16/rtl/*

TOPLEVEL = U12toS16
MODULE = testbench
EXTRA_ARGS += --trace --trace-structs --Wno-WIDTH -Wno-CMPCONST
# EXTRA_ARGS += -full64 -LDFLAGS -Wl,--no-as-needed

include $(shell cocotb-config --makefiles)/Makefile.sim
# include $(shell cocotb-config --makefiles)/Makefile.inc
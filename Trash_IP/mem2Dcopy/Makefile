SIM=verilator
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = /home/zyy/coco_work/cocoTest/Trash_IP/mem2Dcopy/rtl/*

TOPLEVEL = mem2Dcopy
MODULE = testbench
EXTRA_ARGS += --trace-fst --trace-structs --Wno-WIDTH -Wno-CMPCONST
# EXTRA_ARGS += -full64 -LDFLAGS -Wl,--no-as-needed

include $(shell cocotb-config --makefiles)/Makefile.sim
# include $(shell cocotb-config --makefiles)/Makefile.inc
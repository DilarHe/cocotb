helphelpSIM=verilator
TOPLEVEL_LANG = verilog
# VERILOG_SOURCES = /home/lyc/projects/Easonlib//cocoTest/fdt_ctrl/rtl/*
VERILOG_SOURCES = /home/zyy/coco_work/cocoTest/fdt_ctrl/rtl/*

TOPLEVEL = fdt_ctrl
MODULE = testbench
EXTRA_ARGS += --trace-fst --trace-structs --Wno-WIDTH -Wno-CMPCONST
# EXTRA_ARGS += -full64 -LDFLAGS -Wl,--no-as-needed

include $(shell cocotb-config --makefiles)/Makefile.sim
# include $(shell cocotb-config --makefiles)/Makefile.inc
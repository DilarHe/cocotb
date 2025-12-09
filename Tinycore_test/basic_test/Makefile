SIM=verilator
TOPLEVEL_LANG = verilog
# VERILOG_SOURCES = $(shell pwd)/../../rtltinyVcore_top.lst
# VERILOG_SOURCES = $(shell pwd)/../../../rtl/tinyVcore_top.v
VERILOG_SOURCES = /home/zyy/coco_work/cocoTest/Tinycore_test/basic_test/rtl/tinyVcore_top.v

TOPLEVEL = tinyVcore_top
MODULE = tb
EXTRA_ARGS += --trace-fst --trace-structs --Wno-WIDTH
# EXTRA_ARGS += -full64 -LDFLAGS -Wl,--no-as-needed

include $(shell cocotb-config --makefiles)/Makefile.sim
# include $(shell cocotb-config --makefiles)/Makefile.inc

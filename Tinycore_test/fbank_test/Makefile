SIM=verilator
TOPLEVEL_LANG = verilog
#VERILOG_SOURCES = $(shell pwd)/../../rtltinyVcore_top.lst
VERILOG_SOURCES = $(shell pwd)/../../../rtl/fbank_top.v
VERILOG_SOURCES += $(shell pwd)/../../../verilog_ips/common_ip/*.v

TOPLEVEL = fbank_top
MODULE = tb
EXTRA_ARGS += --trace-fst --trace-structs --Wno-WIDTH
# EXTRA_ARGS += -full64 -LDFLAGS -Wl,--no-as-needed

include $(shell cocotb-config --makefiles)/Makefile.sim
include $(shell cocotb-config --makefiles)/Makefile.inc

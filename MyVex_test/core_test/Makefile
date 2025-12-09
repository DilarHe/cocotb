# ==== 仿真基本变量配置 ====
SIM              = verilator
TOPLEVEL_LANG    = verilog
TOPLEVEL         = core_wrapper
MODULE           = tb
# ==== 你的 DesignWare .inc 文件路径 ====
DW_INCLUDE_DIR := /opt/eda/Synopsys/syn/O-2018.06-SP5-2/dw/dw02/src_ver
# lowpower core
VERILOG_SOURCES  = /home/zyy/coco_work/cocoTest/MyVex_test/core_test/rtl/VEX/*
# SuperScalar core
# VERILOG_SOURCES = /home/zyy/coco_work/cocoTest/MyVex_test/core_test/rtl/SSVEX/*

# 🧠 Verilator 加速参数：
EXTRA_ARGS      += --trace --trace-structs --Wno-WIDTH -Wno-CMPCONST --Wno-UNSIGNED -I$(DW_INCLUDE_DIR)
EXTRA_ARGS      += -I$(DW_INCLUDE_DIR)
# EXTRA_ARGS += -full64 -LDFLAGS -Wl,--no-as-needed
export VERILATOR_FLAGS += --output-split 8 --output-split-ctr
export MAKEFLAGS += -j$(shell nproc)

# 新增 DesignWare 目录变量
MERGED_RTL := /home/zyy/coco_work/cocoTest/MyVex_test/core_test/rtl/VEX/mergeRTL.v
# ==== lint patch 自动化处理 ====
.PHONY: patch_merge_rtl

patch_merge_rtl:
	@if [ -f $(MERGED_RTL) ]; then \
		if ! grep -q "verilator lint_off LATCH" $(MERGED_RTL); then \
			sed -i '1i /* verilator lint_off LATCH */\n/* verilator lint_off ASCRANGE */\n/* verilator lint_off WIDTHCONCAT */' $(MERGED_RTL); \
			echo '/* verilator lint_on LATCH */' >> $(MERGED_RTL); \
			echo '/* verilator lint_on ASCRANGE */' >> $(MERGED_RTL); \
			echo '/* verilator lint_on WIDTHCONCAT */' >> $(MERGED_RTL); \
			echo "Patched $(MERGED_RTL) for verilator lint_off/on."; \
		else \
			echo "$(MERGED_RTL) already patched, skip lint_off/on."; \
		fi \
	else \
		echo "$(MERGED_RTL) not found, skip patch."; \
	fi

# ==== 包含 cocotb 官方 Makefile ====
include $(shell cocotb-config --makefiles)/Makefile.sim

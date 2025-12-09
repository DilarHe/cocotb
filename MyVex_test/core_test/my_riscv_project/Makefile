# 项目相关的路径
PROJECT_ROOT := $(PWD)
BUILD_DIR := $(PROJECT_ROOT)/build
SOURCE_DIR := $(PROJECT_ROOT)/src
INCLUDE_DIR := $(PROJECT_ROOT)/include
TARGET := $(BUILD_DIR)/my_riscv_executable
IRAM_HEX_OUTPUT := $(BUILD_DIR)/my_riscv_executable.iram.hex
DRAM_HEX_OUTPUT := $(BUILD_DIR)/my_riscv_executable.dram.hex
PRJ_NAME := my_riscv_project

# CMake 配置选项
RISCV_MARCH ?= rv32imfczicsr

# CMake 命令
CMAKE := cmake
MAKE := make

#主要用来生成hex
OBJCOPY := riscv64-unknown-elf-objcopy
OBJDUMP := riscv64-unknown-elf-objdump

# 目标: 默认构建目标
all: $(TARGET)

# 配置 CMake
$(BUILD_DIR):
	@echo "Configuring project with CMake..."
	@mkdir -p $(BUILD_DIR)
	$(CMAKE) -S $(PROJECT_ROOT) -B $(BUILD_DIR) -DRISCV_MARCH=$(RISCV_MARCH)

# 构建
$(TARGET): $(BUILD_DIR)
	@echo "Building project..."
	@$(MAKE) -C $(BUILD_DIR) 

# 清理
clean:
	@echo "Cleaning up build directory..."
	@rm -rf $(BUILD_DIR)

# 得到反汇编
dasm:
	@$(OBJDUMP) -D -S -x $(TARGET) | gvim -
	
# 生成hex，并去除 @ 开始的地址label
genhex:
	@echo "generate hex file at build directory..."
	@$(OBJCOPY) -O verilog -j .text $(TARGET) /dev/stdout > $(IRAM_HEX_OUTPUT)
	@$(OBJCOPY) -O verilog -j .rodata -j .data -j .bss $(TARGET) /dev/stdout > $(DRAM_HEX_OUTPUT)

.PHONY: all clean

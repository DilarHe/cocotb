# 指定交叉编译工具链
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_C_COMPILER "riscv64-unknown-elf-gcc")
set(CMAKE_CXX_COMPILER "riscv64-unknown-elf-g++")
set(CMAKE_ASM_COMPILER "riscv64-unknown-elf-as")

# 添加一个选项来设置架构
option(RISCV_MARCH "Specify RISC-V architecture" "rv32imfczicsr")
# 验证输入的架构是否合法
# 验证输入的架构是否合法（含 f/c/zicsr 等扩展均可）
if(NOT RISCV_MARCH MATCHES "^(rv32im[fc]*zicsr?|rv32im[fc]*|rv32im[fc]*zicsr?)$")
    message(FATAL_ERROR "Invalid RISCV_MARCH value: ${RISCV_MARCH}. Must match e.g. 'rv32imc', 'rv32imfc', 'rv32imfzicsr', etc.")
endif()

# 判断ABI类型
if(RISCV_MARCH MATCHES "f")
    set(RISCV_ABI "ilp32f")
else()
    set(RISCV_ABI "ilp32")
endif()

# 配置编译器的 Flags
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -march=${RISCV_MARCH} -mabi=ilp32 -ffreestanding -nostdlib")
set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS}   -g -march=${RISCV_MARCH} -mabi=${RISCV_ABI}")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -march=${RISCV_MARCH} -mabi=ilp32 -ffreestanding -nostdlib")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -march=${RISCV_MARCH} -mabi=${RISCV_ABI}")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -g -march=${RISCV_MARCH} -mabi=${RISCV_ABI}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T../link.ld -nostartfiles -Wl,--gc-sections -lc")


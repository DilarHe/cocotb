# 设置最低 CMake 版本
cmake_minimum_required(VERSION 3.22.1)

# 项目信息
project(MyRiscvProject C CXX ASM)

# 指定 RISC-V 工具链路径
message(STATUS "Toolchain file path: ${CMAKE_CURRENT_SOURCE_DIR}/riscv_toolchain.cmake")
include(${CMAKE_CURRENT_SOURCE_DIR}/riscv_toolchain.cmake)

# 获取 clib 目录下所有的 .c 文件
file(GLOB CLIB_SOURCES "clib/*.c")

# 创建静态库，将 clib 目录下的所有 .c 文件作为源文件
add_library(clib STATIC ${CLIB_SOURCES})

# 添加源文件，包括 crt.S
set(SOURCES src/crt.S src/main.c)
# 创建可执行文件，并包含 crt.S
add_executable(my_riscv_executable ${SOURCES})

# 链接 clib 到可执行文件
target_link_libraries(my_riscv_executable PRIVATE clib)

# 包含头文件目录
target_include_directories(my_riscv_executable PRIVATE include clib)


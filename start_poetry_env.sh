#!/bin/zsh

# 设置额外的环境变量
export MY_CUSTOM_VAR1="value1"
export MY_CUSTOM_VAR2="value2"

# 启动 poetry shell 并进入 vscode
#poetry shell && code . && echo 'cocotest env enter success' 这个写法不行，shell进入了，vscode被block住
poetry run code . && echo 'cocotest env enter success'

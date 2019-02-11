#!/bin/sh

# echo [option] string
# -e 解析转义字符
# -n 不回车换行。默认情况echo回显的内容后面跟一个回车换行。

echo "hello\n\n"
# 输出hello\n\n
echo -e "hello\n\n"
# 输出hello
# 
# 
echo  "hello" # 自动换行
echo -n "hello"  # 不会换行
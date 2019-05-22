#!/bin/sh

# ./05_位置参数和特殊变量.sh a b c d e f g
echo "\$0 第一个参数为: $0"
echo "\$1 第二个参数为: $1"
echo "\$2 第三个参数为: $2"
echo "\$3 第四个参数为: $3"
echo "\$4 第五个参数为: $4"
echo "\$5 第六个参数为: $5"
echo "\$6 第七个参数为: $6"
echo "\$7 第八个参数为: $7"
echo "\$# 文件名后面的参数总数为: $#"

echo "\n"
echo "for循环遍历\$*(参数列表)"
for FILE in $*; do
	echo "$FILE is what?"
done

echo "\n"
echo "for循环遍历\$@(参数列表)"
for FILE in $@; do
	echo "$FILE is what? what?"
done

echo "\n"
echo "\$? 上一条命令执行的结果为(0:正确, 非0:失败):$?"
echo "\$\$ 当前进程号:$$"

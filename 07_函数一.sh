#!/bin/sh
# 示例一
func(){
	echo "func -- start ---"
	echo $0
	echo $1
	echo $2
	echo $3
	echo $4
	echo $5
	echo "func -- end ---"
}
echo "start"
func a b c d e
echo $0
echo $1
echo $2
echo $3
echo $4
echo $5

# 如果执行$ ./07_函数.sh 1 2 3 4 5
# 结果为:
# start
# func -- start ---
# ./07_函数.sh
# a
# b
# c
# d
# e
# func -- end ---
# ./07_函数.sh
# 1
# 2
# 3
# 4
# 5
# end

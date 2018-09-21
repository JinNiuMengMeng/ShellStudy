#!/bin/sh
# 示例二
is_directory(){ # 注意is_directory()返回0表示真返回1表示假。
	DIR_NAME=$1
	if test -d $DIR_NAME; then
		return 0
	else
		return 1
	fi
}

for DIR in $@; do
	if is_directory $DIR; then
		echo "$DIR is a directory!"
	else
		echo "$DIR is not a directory! creating"
		mkdir $DIR > /dev/null 2>&1
		if test $? -eq 0; then
			echo "create successd!"
		else
			echo "create faild!"
		fi
	fi
done
# 52行is_directory $DIR 是函数调用, 并传递参数$DIR(目录名)
# is_directory $DIR 该语句的$?为0(真)的话, if语句执行then语句, 否则执行else语句
# 53行 : 表示占位, 什么都不做
#!/bin/sh

# 判断.gitignore是否是一个文件
if [ -f ./.gitignore ]; then
	echo ".gitignore是一个文件!"
else
	echo ".gitignore不是一个文件!"
fi

# ':'是一个特殊的命令, 称为空命令, 该命令不做任何事, 但Exit Status总是真.
if :; then
	echo "always true"
else
	echo "条件不成立!"
fi

# 读取用户输入的数据判断早上还是晚上!
echo "Is it morning? Please answer yes or no."
read YES_OR_NO
if [ "$YES_OR_NO" = "yes" ]; then
  echo "Good morning!"
elif [ "$YES_OR_NO" = "no" ]; then
  echo "Good afternoon!"
else
  echo "Sorry, $YES_OR_NO not recognized. Enter yes or no."
fi
echo "end!"
# exit(0): 正常运行程序并退出程序;
# exit(1): 非正常运行导致退出程序;
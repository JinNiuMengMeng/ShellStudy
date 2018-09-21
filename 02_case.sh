#!/bin/sh

# 示例一:
echo "Is it morning? Please answer yes or no."
read YES_OR_NO
case "$YES_OR_NO" in
	[yY]*)
	    echo "Good morning!";;
	[nN]*)
	    echo "Good Afternoon!";;
	*)
	    echo "Sorry, $YES_OR_NO not recognized. Enter yes or no!";;
esac

# 示例二:
echo "1.上班    2.不上班    3.回家    4.玩耍"
read NUM
case "$NUM" in
	"1")
	    echo "去上班!";;
	"2")
	    echo "不上班啦!";;
	"3")
	    echo "回家吧!";;
	"4")
	    echo "去玩儿吧!";;
	*)
	    echo "没这个选择!";
	esac

# 示例三
case "$1" in
	"start")
        echo "正在开始 start 1!"
        echo "正在开始 start 2!";;
    "stop")
        echo "正在停止 stop 1!"
        echo "正在停止 stop 2!";;
    "restart")
        echo "正在重启 restart 1!"
        echo "正在重启 restart 2!";;
    *)
        echo "无此选项!";;
esac
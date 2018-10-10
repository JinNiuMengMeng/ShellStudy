#!/bin/sh
PATHS=/etc/NetworkManager/system-connections
FILES=$(ls $PATHS | sed 's/Wired\ connection\ 2//g')

if [ $# -ne 1 ]; then
	echo "\n请在脚本后面输入要连接的wifi名称, 以下是wifi列表, 示例:"
	echo "$0 wifi-name"
	echo "--------已知的wifi列表如下--------"
	for filename in $FILES; do 
		echo $filename "  \c"
	done 
	echo "\n"
	return;
else echo "\n--------正在切换网络----------"
fi

FILES=$(ls $PATHS | sed 's/Wired\ connection\ 2//g' | sed 's/'$1'//g')
for filename in $FILES; do
	grep -q "autoconnect=" $PATHS/$filename
	if [ $? -eq 0 ]; then
		grep -q "autoconnect=false" $PATHS/$filename
		if [ $? -eq 0 ]; then
			echo -n ''
		else
			sed -i 's/=true/=false/' $PATHS/$filename
			if [ $? -eq 0 ]; then 
				echo -n ''
			else 
				echo $filename: "关闭过程中出现异常"
			fi
		fi
	else
		sed -i '/\[connection\]/a\autoconnect=false' $PATHS/$filename
		if [ $? -eq 0 ];then 
			echo -n ''
		else 
			echo $filename: "关闭过程中出现异常"
		fi
	fi
done



grep -q "autoconnect=" $PATHS/$1
if [ $? -eq 0 ];then
	grep -q "autoconnect=true" $PATHS/$1
	if [ $? -eq 0 ]; then
		echo "--------"$1: "已打开----------"
	else
		sed -i 's/=false/=true/' $PATHS/$1
		if [ $? -eq 0 ];then 
			echo "--------"$1: "已经打开----------"
		else 
			echo "--------"$1: "打开过程中出现异常----------"
		fi
	fi
else
	sed -i '/\[connection\]/a\autoconnect=true' $PATHS/$1
	if [ $? -eq 0 ];then 
		echo "--------"$1: "已经打开----------"
	else 
		echo "--------"$1: "打开过程中出现异常----------"
	fi
fi

/etc/init.d/network-manager restart >> /dev/null 2>&1 && /etc/init.d/networking restart >> /dev/null 2>&1

echo -n "--------正在连接中"
for i in `seq 1 20`
do
	iwconfig wlp5s0 | grep ESSID >> /dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "\n--------wifi切换 success!---------\n"
		break
	else
		sleep 0.5
		if [ $i -eq 20 ];then 
			echo "\n--------wifi切换 Failed!--------\n"
		else 
			echo -n "-"
		fi
	fi
done

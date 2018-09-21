#!/bin/sh

# 示例一
echo "Enter password:"
read TRY
while [ "$TRY" != "secret" ]; do
	echo "Sorry, try again!"
	read TRY
done
echo "password is right!"

# 示例二
echo "\n请再次输入密码!"
COUNTER=1
while [ "$COUNTER" -le 5 ]; do
	read TRY
	if [ "$TRY" != "secret" ]; then
		echo "输入错误! 还有$((5-$COUNTER))次机会, 请再次输入:"
		COUNTER=$(($COUNTER+1))
		continue
	else
		echo "输入正确!"
		break
	fi
	#statements
done
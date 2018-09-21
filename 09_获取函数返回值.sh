
func(){  # 注意func()返回0表示真返回1表示假。
	if test -d $1; then
		return 0
	else
		return 1
	fi
}
func 44
result=$?
echo $result
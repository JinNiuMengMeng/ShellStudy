#!/usr/bin/bash
clear

function output(){
    echo -e "\t\t\t\t\t\t\033[36m $1 \033[0m" 
}

function get_server_info(){
    read Num
    case $Num in
    1)  output "Login Success..."
        Server="192.168.0.151:63737:root:usky666!#%"
    ;;
    2)  output "Login Success..."
        Server="192.168.0.154:63737:root:usky666!#%"
    ;;
    3)  output "Login Success..."
        Server="192.168.0.155:63737:root:usky666!#%"
    ;;
    4)  output "Login Success..."
        Server="192.168.0.215:2222:xiezh:xiezhaoheng"
    ;;
    5)  output "Login Success..."
        Server="183.250.89.162:2201:xiezh:xiezhaoheng"
    ;;
    6)  output "Exit Success..."
        exit 0
    ;;
    *)  output "You do not select a number between 1 to 6."
        exit 0
    ;;
    esac

    IP=$(echo $Server|awk -F ':' '{print $1}')
    PORT=$(echo $Server|awk -F ':' '{print $2}')
    USER=$(echo $Server|awk -F ':' '{print $3}')
    PASS=$(echo $Server|awk -F ':' '{print $4}')
    return 0
}

function login_handle(){
    if [ $Num -le 3 ]; then
        sshpass -p $PASS ssh -p $PORT $USER@$IP
    elif [ $Num -ge 4 ]; then
        expect -c "
        spawn ssh -p $PORT $USER@$IP
        expect {
                 \"*password:\" { send \"$PASS\r\"; exp_continue}
               }
        interact
       "
    else
        output "Unknow Error!"
    fi
}

function output_info(){
    output "==========================================="
    output "(1) Docker machine Server--> 192.168.0.151"
    output "(2) Docker machine Server--> 192.168.0.154"
    output "(3) Test  machine  Server--> 192.168.0.155"
    output "(4) Intranet fort machine--> 192.168.0.215"
    output "(5) Extranet fort machine--> 183.250.89.162"
    output "(6) Exit"
    output "==========================================="
    output "请输入需要登录的服务器前面的序号: \c"
}

# ---------------- start ---------------
output_info
if get_server_info; then
    login_handle
    exit 0
else
    output "Unknow Error!"
fi
# ---------------- end ---------------
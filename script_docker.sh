#!/bin/bash
# 自动部署docker shadowsocker
sentence1="update "
sentence2="安装curl "
sentence3="安装docker "
sentence4="添加docker用户组 "
sentence5="拉取docker_shadowsockr镜像 "
sentence6="运行容器 "

start(){
	echo "\n正在 "$1"..."
}
judge(){
	if [ $? -eq 0 ];then
	    echo $1" 成功..."
    else
	    echo $1" 失败..."
	    exit 1
    fi
    echo $1" 结束...\n"
}

start $sentence1
apt update >> /dev/null 2>&1
judge $sentence1

start $sentence2
apt install -y curl >> /dev/null 2>&1
judge $sentence2

start $sentence3
curl -sSL  https://get.docker.com/|sudo sh >> /dev/null 2>&1
judge $sentence3

start $sentence4
usermod -aG docker root >> /dev/null 2>&1
judge $sentence4

start $sentence5
docker pull wahaha00/ssr-with-net-speeder >> /dev/null 2>&1
judge $sentence5

start $sentence6
docker run -d --name ssr-with-net-speeder -p 7998:7998 wahaha00/ssr-with-net-speeder -s 0.0.0.0 -p 7998 -k 123wahaha321 -m aes-256-cfb -o plain -O auth_sha1_v4_compatible >> /dev/null 2>&1
judge $sentence6

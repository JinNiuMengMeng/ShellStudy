#!/bin/bash
# 自动部署docker shadowsocker
sentence1="update "
sentence2="安装curl "
sentence3="检测Docker是否安装 "
sentence4="安装docker "
sentence5="添加docker用户组 "
sentence6="docker login "
sentence7="拉取docker_shadowsockr镜像 "
sentence8="运行容器 "
sentence9="检测vim是否安装 "

start(){
	echo ""
	echo "正在 "$1"..."
}
judge(){
	if [ $? -eq 0 ];then
	    echo $1" 成功..."
    else
	    echo $1" 失败..."
	    exit 1
    fi
    echo $1" 结束..."
    echo ""
}

install_docker(){
	echo "Docker安装中..."
	start $sentence4
	curl -sSL  https://get.docker.com/|sudo sh >> /dev/null 2>&1
	judge $sentence4
    echo "Docker安装结束..."
    echo ""
	start $sentence5
	usermod -aG docker root >> /dev/null 2>&1
	judge $sentence5

	start $sentence6
	docker login -u wahaha00 -p Aa411317572 >> /dev/null 2>&1
	judge $sentence6

	start $sentence7
	docker pull wahaha00/ssr-with-net-speeder >> /dev/null 2>&1
	judge $sentence7

	start $sentence8
	docker run -d --name ssr-with-net-speeder -p 7998:7998 wahaha00/ssr-with-net-speeder -s 0.0.0.0 -p 7998 -k 123wahaha321 -m aes-256-cfb -o plain -O auth_sha1_v4_compatible >> /dev/null 2>&1
	judge $sentence8

}

judge_docker_install(){
	if [ $? -eq 0 ];then
	    echo $1" 已经安装..."
    else
	    echo $1" 没有安装..."
	    install_docker
    fi
    echo ""
}

install_vim(){
	echo "VIM正在安装..."
	apt install -y vim >> /dev/null 2>&1
	echo "VIM安装成功..."
}

judge_vim_install(){
	if [ $? -eq 0 ];then
	    echo $1" 已经安装..."
    else
	    echo $1" 没有安装..."
	    install_vim
    fi
    echo ""
}

start $sentence1
apt update >> /dev/null 2>&1
judge $sentence1

start $sentence2
apt install -y curl >> /dev/null 2>&1
judge $sentence2

start $sentence3
docker --version >> /dev/null 2>&1
judge_docker_install "Docker"

start $sentence9
vim --version >> /dev/null 2>&1
judge_vim_install "vim"

echo set tabstop=4 >> /root/.vimrc
echo set number >> /root/.vimrc
echo 'if has("win32")' >> /root/.vimrc
echo '    set guifont=Inconsolata:h12:cANSI' >> /root/.vimrc
echo endif >> /root/.vimrc
echo set encoding=utf-8 >> /root/.vimrc
echo set termencoding=utf-8 >> /root/.vimrc
echo set formatoptions+=mM >> /root/.vimrc
echo set fencs=utf-8,gbk >> /root/.vimrc

mkdir -p /root/.ssh
chmod 600 /root/.ssh
echo ssh-rsa ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRxXS6KPfsEKurncvKnEb1lGvHjoAbSqb7/aN7ED2whuiKzbufTc1rpJO10tWpsAUMv7VzJp0KLVGBluGZsacusE1Sist6t7hz0rE3eNLCc3r0XTDFXzkVL9B648lUFDQrJ346t/484Tzyzlrp8ZjgSeN0MFU3gPKeVv3Cdq034lWGcMwVwD//wIn78iW3rTfcrq7tvg/9760u0G1dA7cz4E853Jl881urxS8+JT7hiRTX/bdaMGVKBMCnvUuDRbN3qbC6lOlV+ZKLDX7HPvNh5E9ZcmIoyt4u5VfopJpyZlFinxpTvEOr0EsrDugbFtFqeivndK3t3JgRR9St/Uqp 411317572@qq.com > /root/.ssh/authorized_keys
chmod 700 /root/.ssh/authorized_keys

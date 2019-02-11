#!/bin/bash

cd /opt/
git  clone https://github.com/JinNiuMengMeng/shell_shadowsockr.git
cd /opt/shell_shadowsockr/
chmod 777 ssr.sh
git checkout develop
chmod 777 ssr.sh
./ssr.sh
git checkout master



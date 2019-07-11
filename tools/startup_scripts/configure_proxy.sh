#!/bin/bash

# config proxy
: ${ip_proxy:="192.168.5.12"}

echo "proxy configuring"
flag="proxy_configuring"
if [ `cat ~/.bashrc|grep flag{$flag}|wc -l` == 0 ]; then
echo "
#flag{$flag}
export http_proxy="http://"$ip_proxy":1080/"
export https_proxy="http://"$ip_proxy":1080/"
" >> ~/.bashrc
fi
source ~/.bashrc

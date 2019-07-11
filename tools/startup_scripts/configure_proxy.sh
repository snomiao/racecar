#!/bin/bash

# config proxy
: ${ip_proxy:="192.168.5.12"}
echo "proxy configuring"
echo "
export http_proxy="http://"$ip_proxy":1080/"
export https_proxy="http://"$ip_proxy":1080/"
">>~/.bashrc
source ~/.bashrc
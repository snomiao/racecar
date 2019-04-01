#!/bin/bash

# for open rviz and set ROS master ip
# Steven.Zhang
# 2018.03.09
#
# modified by snomiao(snomiao@gmail.com)
# [20190401]

# 这个函数无法正常工作
# function get_ip_address { ifconfig | fgrep -v 127.0.0.1 | fgrep 'Mask:255.255.255.0' | egrep -o 'addr:[^ ]*' | fgrep '.8.'| sed 's/^.*://'; }

# 改良后可用
function get_ip_address {
    ifconfig | fgrep -v 127.0.0.1 | fgrep 'Mask:255.255.255.0' | fgrep 'Bcast:192.168.5.255' | egrep -o 'addr:[^ ]*' | sed 's/^.*://';
}

export ROS_IP=$(get_ip_address) 
export ROS_MASTER_URI=http://192.168.5.101:11311

# 这个语句在多网卡的电脑下有BUG
# export ROS_IP=`hostname -I`
#
# 具体表现如下，于是rviz无法正确接收
#
# snomiao@ILOVEYOU:~$ roslaunch art_racecar rviz.launch
# ……
# ……
# ……
# ……
# ……
# started roslaunch server http://172.20.46.65 192.168.5.12 :14400/
# ……
# ……

## source ../devel/setup.bash
# rosrun rviz rviz 

#!/bin/bash

#for open rviz and set ROS master ip
#Steven.Zhang
#2018.03.09

function get_ip_address { ifconfig | fgrep -v 127.0.0.1 | fgrep 'Mask:255.255.255.0' | egrep -o 'addr:[^ ]*' | fgrep '.8.'| sed 's/^.*://'; }        

ros_ip=`hostname -I`
master_host=car
flag="set_rosip"
echo "$flag"
if [ `cat ~/.bashrc|grep flag{$flag}|wc -l` == 0 ]; then
echo "
#flag{$flag}
#export ROS_IP=$(get_ip_address) 
export ROS_IP=$ros_ip
export ROS_MASTER_URI=http://$master_host:11311
" >> ~/.bashrc
fi
source ~/.bashrc

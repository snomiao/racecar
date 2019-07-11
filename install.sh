#!/bin/bash

# run me by
# bash <(wget -qO - https://raw.githubusercontent.com/snomiao/racecar/master/install.sh)

# Varibles
ip_controller="192.168.5.12"
ip_master=`hostname -I`

# 配置阿里云源
bash <(wget -qO - https://raw.githubusercontent.com/snomiao/racecar/master/tools/startup_scripts/configure_aliyun_source.sh)

# 配置HOSTS环境
bash <(wget -qO - https://raw.githubusercontent.com/snomiao/racecar/master/tools/startup_scripts/configure_hosts.sh)

# 配置代理（如果需要的话）
# bash <(wget -qO - https://raw.githubusercontent.com/snomiao/racecar/master/tools/startup_scripts/configure_proxy.sh)

# 安装基础软件包
sudo apt-get install git -y
sudo apt-get install openssh-server -y
sudo apt-get install ssh -y
sudo apt-get install ntpdate -y
sudo apt-get install chrony -y

if [ `id -u` == 0 ]; then
echo "Don't running this use root(sudo)."
exit 0
fi

# get version of ros
ubuntu_release=`lsb_release -a|grep -P '(?<=^Release:)\s+.*' -o|tr -d '[:space:]'`
rosversion=`echo $ubuntu_release | sed s/14.04/indigo/ | sed s/16.04/kinetic/ | sed s/18.04/melodic/`

# Install ros
echo "Start to install the ros, http://wiki.ros.org/$rosversion/Installation/Ubuntu"
echo "Update the software list"
sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
# 旧的KEY
# sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update

echo "Install the ros from apt"
sudo apt-get install ros-$rosversion-desktop-full -y
sudo rosdep init
rosdep update

if [ `cat ~/.bashrc|grep flag{setup_ros_env}|wc -l` == 0 ]; then
    echo "Setup the ROS environment variables"
    echo "#flag{setup_ros_env}" >> ~/.bashrc
    echo -e "if [ -f /opt/ros/$rosversion/setup.bash ]; then\n\tsource /opt/ros/$rosversion/setup.bash\nfi" >> ~/.bashrc
    echo "source $install_path/racecar/devel/setup.bash" >> ~/.bashrc
fi
source ~/.bashrc

echo "Install ROS building tools"
sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential -y
sudo apt install ros-kinetic-catkin -y

echo "ROS installing Finished, please reboot the computer."

# //

# 下载安装 racecar 软件包
install_path=`echo ~`
cd $install_path
if [ -e $install_path/ ]
git clone https://github.com/snomiao/racecar



# Install the dependecies for the project
echo "Start to config for the project"

echo "configuring the serial udev of the car."
cd ~/racecar/src/art_racecar/udev/
sudo bash art_init.sh

cd ~/racecar/src/art_racecar/
source art_rviz.sh
#echo "Install the python dependecies"
#sudo apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose -y

#echo "Install the eigen3"
#sudo apt install libeigen3-dev -y

#echo "Install the nlopt"
#sudo apt install libnlopt* -y

echo "Install the ROS packages for art_racecar"
sudo apt-get install ros-$rosversion-joy -y
sudo apt-get install ros-$rosversion-move-base -y
sudo apt-get install ros-$rosversion-mrpt* -y
sudo apt-get install ros-$rosversion-geographic-msgs -y
sudo apt-get install ros-$rosversion-map-server -y
sudo apt-get install ros-$rosversion-gmapping -y   # missing in melodic
sudo apt-get install ros-$rosversion-amcl -y
sudo apt-get install ros-$rosversion-rviz-imu-plugin -y
sudo apt-get install ros-$rosversion-dwa-local-planner -y

echo "Compile the art_racecar"
catkin_make

chmod 777 -R ~/racecar/tools/*.sh
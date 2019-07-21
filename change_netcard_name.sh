#!/bin/bash
#CentOS7修改默认网卡配置文件名(eth0)
#作者：vidar
#版本：v0.1
#时间：2019年7月21日

#判断网卡配置文件是否存在
cd /etc/sysconfig/network-scripts
if [ -f "ifcfg-ens33" ];then
	echo "文件存在,备份原配置文件..."
else
	echo "文件不存在，退出脚本..."
	exit
fi

cp -a ifcfg-ens33 ifcfg-eth0
mv ifcfg-ens33 ifcfg-ens33.bak
#修改网卡配置文件内容
echo "修改网卡配置文件..."
sed -i 's/\(NAME=\).*/\1'eth0'/' ifcfg-eth0
sed -i 's/\(DEVICE=\).*/\1'eth0'/' ifcfg-eth0
#修改grub配置文件
echo "修改grub配置文件..."
sed -i 's/crashkernel=auto /&biosdevname=0 net.ifnames=0 /' /etc/default/grub

#更新配置文件，加载内核参数
grub2-mkconfig -o /boot/grub2/grub.cfg

read -p '是否重启系统[y/n]:' re
case $re in
    y)  echo '重启系统中...'
		reboot
    ;;
    Y)  echo '重启系统中...'
		reboot
    ;;
    n)  echo '退出脚本，请及时手动重启系统！'
		exit
    ;;
    N)  echo '退出脚本，请及时手动重启系统！'
		exit
    ;;
    *)  echo '输入错误，请手动输入reboot命令重启，退出脚本。'
    ;;
esac
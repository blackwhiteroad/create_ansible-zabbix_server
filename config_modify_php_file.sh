#!/bin/bash
yum -y install php-gd php-xml php-bcmath php-mbstring
#设置时区
sed -i '878s/^;date/date/1' /etc/php.ini 
sed -i '878s/date.*/& Asia\/Shanghai/' /etc/php.ini
#最大执行时间,单位:s
sed -i 's/^max_execution.*/&0/g' /etc/php.ini
#POST数据最大容量
sed -i '672s/8/32/1' /etc/php.ini
#服务器接收数据的时间限制
sed -i '394s/60/300/1' /etc/php.ini
#重启php-fpm服务
systemctl restart php-fpm

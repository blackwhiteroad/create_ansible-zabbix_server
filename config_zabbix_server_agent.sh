#!/bin/bash
#1.将zabbix-3.4.4/database/mysql/的数据导入到创建的zabbix库中
cd zabbix-3.4.4/database/mysql/
mysql -uzabbix -pcangqiong zabbix < schema.sql
mysql -uzabbix -pcangqiong zabbix < images.sql
mysql -uzabbix -pcangqiong zabbix < data.sql
#2.上线Zabbix的Web页面
cd /root/zabbix-3.4.4/frontends/php/
cp -r * /usr/local/nginx/html/
chmod -R 777 /usr/local/nginx/html/*
#3.修改Zabbix_server配置文件,设置数据库相关参数,启动Zabbix_server服务
#vim /usr/local/etc/zabbix_server.conf
sed -i '85s/^# DB/DB/1' /usr/local/etc/zabbix_server.conf
sed -i '119s/^# DBP/DBP/1' /usr/local/etc/zabbix_server.conf
sed -i '119s/DBP.*/&cangqiong/' /usr/local/etc/zabbix_server.conf
#4.创建用户启动,安全可靠
useradd -s /sbin/nologin zabbix
#5.启动服务
zabbix_server
#6.确认连接状态,端口10051
ss -antulp | grep zabbix.server
#7.设置被监控服务配置
#vim /usr/local/etc/zabbix_agentd.conf
#7.1允许哪些主机监控本机
sed -i '93s/127.0.0.1/192.168.5.4/1' /usr/local/etc/zabbix_agentd.conf
#7.2允许哪些主机通过主动模式监控本机
sed -i '134s/127.0.0.1/192.168.5.4/1' /usr/local/etc/zabbix_agentd.conf
#设置本机主机名
sed -i '30s/agentd/server/1' /usr/local/etc/zabbix_agentd.conf
#允许自定义key
sed -i '280s/^# Un/Un/1' /usr/local/etc/zabbix_agentd.conf
sed -i '280s/0/1/1' /usr/local/etc/zabbix_agentd.conf
#启动监控agent
zabbix_agentd
#查看端口信息为10050
ss -ntulp | grep zabbix.agentd
#浏览器访问Zabbix_server服务器的Web页面
curl http://192.168.5.4/index.php

#!/bin/bash
#被监控机器自定义key
#1.加载自定义key配置文件目录
sed -i '264s/^# In/In/1' /usr/local/etc/zabbix_agentd.conf
echo "UserParameter=count.line.passwd,wc -l /etc/passwd | awk '{print \$1}'" > /usr/local/etc/zabbix_agentd.conf.d/count.line.passwd
#2.测试自定义Key
#2.1杀死zabbix_agentd进程
killall zabbix_agentd
#2.2重启zabbix_agentd服务
zabbix_agentd
#2.3由于启动zabbix_agentd服务需要一段时间，所以让机器沉睡5s，以使zabbix_get命令能够顺利执行
sleep 5
zabbix_get -s 127.0.0.1 -k count.line.passwd

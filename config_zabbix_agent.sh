#1.安装依赖包
yum -y install gcc pcre-devel
#2.创建zabbix用户,管理zabbix监控软件
useradd -s /sbin/nologin zabbix
#3.获取zabbix软件包
lftp 192.168.5.254
#3.1解压缩
tar -xf zabbix-3.4.4.tar.gz
#3.2源码编译安装
cd /root/zabbix-3.4.4/
./configure --enable-agent
make && make install
#4.配置agent文件
#4.1允许哪些主机监控本机
sed -i '93s/127.0.0.1/192.168.5.4/1' /usr/local/etc/zabbix_agentd.conf
#4.2允许哪些主机通过主动模式监控本机
sed -i '134s/127.0.0.1/192.168.5.4/1' /usr/local/etc/zabbix_agentd.conf
#设置本机主机名
sed -i '30s/agentd/agent1/1' /usr/local/etc/zabbix_agentd.conf
#允许自定义key
sed -i '280s/^# Un/Un/1' /usr/local/etc/zabbix_agentd.conf
sed -i '280s/0/1/1' /usr/local/etc/zabbix_agentd.conf
#拷贝启动脚本(非必须操作),有启动脚本可以方便管理服务,启动与关闭服务,启动脚本位于源Zabbix源码目录下
cd /root/zabbix-3.4.4/misc/init.d/fedora/core
cp zabbix_agentd /etc/init.d/
/etc/init.d/zabbix_agentd start
/etc/init.d/zabbix_agentd status
/etc/init.d/zabbix_agentd restart
#查看端口信息为10050
ss -ntulp | grep zabbix.agentd

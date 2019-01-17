!/bin/bash
#1.关闭数据库mariadb关系型数据库,避免与安装的mysql关系型数据库冲突
systemctl stop mariadb
#2.卸载关系型数据库mariadb的相关软件:
rpm -e --nodeps mariadb-server mariadb
#3.删除其相关文件
rm -rf /etc/my.cnf
rm -rf /var/lib/mysql/*
#4.安装mysql软件
#4.1安装mysql依赖包
yum -y install perl-JSON libaio* perl*
#4.2升级安装mysql
cd mysql_plugin
tar -xf mysql-5.7.17-1.el7.x86_64.rpm-bundle.tar
rpm -Uvh mysql-community-*.rpm
rpm -qa | grep -i mysql
#5.启动mysql服务
systemctl start mysqld
#设置开机自启动mysql服务
systemctl enable mysqld
#查看mysql服务进程和端口号
ps -C mysqld


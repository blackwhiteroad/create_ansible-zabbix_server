#!/bin/bash
#1.启动nginx服务
#制作nginx软连接
ln -s /usr/local/nginx/sbin/nginx /sbin/nginx
nginx
#2.启动php-fpm服务
yum -y install php php-mysql php-gd php-xml php-ldap
systemctl start php-fpm
systemctl enbale php-fpm
start_php-fpm_nginx_service.sh
netstat -antupl | grep php-fpm
chmod +x start_php-fpm_nginx_service.sh
start_php-fpm_nginx_service.sh

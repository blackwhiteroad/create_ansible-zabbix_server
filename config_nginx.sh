#!/bin/bash
#脚本一键安装nginx
yum clean all
yum repolist
yum -y install gcc pcre-devel openssl-devel php-fpm
tar -zxf nginx-1.12.2.tar.gz
cd nginx-1.12.2/
./configure --with-http_ssl_module
make && make install

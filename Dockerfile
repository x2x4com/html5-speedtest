# PHP 容器配置

# 从官方基础版本构建
FROM php:7.4-apache
# 官方版本默认安装扩展: 
# Core, ctype, curl
# date, dom
# fileinfo, filter, ftp
# hash
# iconv
# json
# libxml
# mbstring, mysqlnd
# openssl
# pcre, PDO, pdo_sqlite, Phar, posix
# readline, Reflection, session, SimpleXML, sodium, SPL, sqlite3, standard
# tokenizer
# xml, xmlreader, xmlwriter
# zlib

#设置容器时区
ENV TZ Asia/Shanghai

#设置程序入口
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# 1.0.2 增加 bcmath, calendar, exif, gettext, sockets, dba, 
# mysqli, pcntl, pdo_mysql, shmop, sysvmsg, sysvsem, sysvshm 扩展
RUN docker-php-ext-install -j$(nproc) bcmath calendar exif gettext \
sockets dba mysqli pcntl pdo_mysql shmop sysvmsg sysvsem sysvshm

#复制代码到PHP容器
COPY . /var/www/html

# 开启URL重写 并且 添加目录权限
RUN a2enmod rewrite \
    && chmod -R 0755 /var/www/html \
    && chown -R www-data:www-data /var/www/html

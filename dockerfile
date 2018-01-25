FROM centos:7

MAINTAINER DavidCr crliujin@163.com

RUN yum install -y  gcc-c++ autoconf make cmake vim 

#安装nginx-php支持
RUN yum -y install bzip2-devel curl-devel freetype-devel gcc libjpeg-devel libpng-devel libxslt-devel libxml2-devel openssl-devel pcre-devel pcre-devel zlib-devel

RUN yum -y install wget 
#安装pcre-devel支持伪静态
RUN yum install pcre-devel


#添加用户组
RUN groupadd  www &&\
    useradd -g  www www -s /bin/false

#下载安装nginx
RUN mkdir /usr/local/server &&\
    cd  /usr/local/server/ &&\
    wget http://nginx.org/download/nginx-1.13.8.tar.gz &&\
    tar -zxvf nginx-1.13.8.tar.gz  -C /usr/local/server &&\
    cd nginx-1.13.8 &&\
    ./configure --prefix=/usr/local/server/nginx &&\
    make && make install

#下载安装php
RUN cd  /usr/local/server &&\
    wget http://hk1.php.net/get/php-7.2.1.tar.gz/from/this/mirror &&\
    tar -zxvf mirror -C /usr/local/server &&\
    cd php-7.2.1 &&\
    ./configure --prefix=/usr/local/server/php/ \
                --with-config-file-path=/usr/local/server/php/etc/ \
                --with-config-file-scan-dir=/usr/local/server/php/etc/php.d \
                --enable-fpm --with-fpm-user=www \
                --with-fpm-group=www \
                --with-zlib \
                --with-libxml-dir \
                --enable-sockets \
                --with-curl \
                --with-jpeg-dir \
                --with-png-dir \
                --with-iconv-dir=/usr/local/libiconv \
                --with-freetype-dir= \
                --enable-gd-native-ttf \
                --with-xmlrpc \
                --with-openssl \
                --with-mhash \
                --with-pear \
                --enable-mbstring \
                --enable-sysvshm \
                --enable-zip \
                --with-mysqli \
                --with-mysql-sock \
                --with-pdo-mysql \
                --disable-fileinfo &&\
    make && make install

RUN cp  /usr/local/server/php-7.2.1/php.ini-production /usr/local/server/php/etc/php.ini &&\
    cp /usr/local/server/php/etc/php-fpm.conf.default /usr/local/server/php/etc/php-fpm.conf &&\
    cp /usr/local/server/php/etc/php-fpm.d/www.conf.default /usr/local/server/php/etc/php-fpm.d/www.conf 	

RUN ln -s /usr/local/server/php/bin/php /usr/local/bin 
RUN ln -s /usr/local/server/nginx/bin/nginx /usr/local/bin

#安装composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#安装swoole
RUN /usr/local/server/php/bin/pecl install swoole
RUN /usr/local/server/php/bin/pecl install redis
RUN echo "extension=swoole" >> /usr/local/server/php/etc/php.ini 
RUN echo "extension=redis" >> /usr/local/server/php/etc/php.ini 

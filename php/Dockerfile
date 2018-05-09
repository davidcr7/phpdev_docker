FROM alpine:3.7

# 备份原始文件
RUN cp /etc/apk/repositories /etc/apk/repositories.bak

# 修改为国内镜像源
RUN echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories

RUN apk update
RUN apk add --no-cache g++ gcc autoconf make vim curl file linux-headers

#安装php扩展库
RUN apk add --no-cache bzip2-dev curl-dev freetype-dev libjpeg-turbo-dev libpng-dev libxslt-dev libxml2-dev openssl-dev zlib-dev libaio-dev

#添加用户组
RUN set -x &&\
    addgroup  www &&\ 
    adduser -G www www -S /bin/false

RUN mkdir /usr/local/server
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

#安装composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#安装yaf扩展
RUN /usr/local/server/php/bin/pecl install yaf 
RUN echo "extension=yaf.so" >> /usr/local/server/php/etc/php.ini
RUN echo "yaf.use_namespace=1" >> /usr/local/server/php/etc/php.ini
RUN echo "yaf.environ='develop'" >> /usr/local/server/php/etc/php.ini

#安装swoole扩展
RUN /usr/local/server/php/bin/pecl install swoole
RUN echo "extension=swoole" >> /usr/local/server/php/etc/php.ini 

#安装redis扩展
RUN /usr/local/server/php/bin/pecl install redis
RUN echo "extension=redis" >> /usr/local/server/php/etc/php.ini

CMD ["/usr/local/server/php/sbin/php-fpm", "-FR"]

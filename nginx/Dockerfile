FROM alpine:3.7

# 备份原始文件
RUN cp /etc/apk/repositories /etc/apk/repositories.bak

# 修改为国内镜像源
RUN echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories

RUN apk update
RUN apk add --no-cache  g++ gcc autoconf make cmake vim 

#安装nginx支持
RUN apk add --no-cache pcre-dev py-setuptools zlib-dev 

#下载安装nginx
RUN mkdir /usr/local/server &&\
    cd  /usr/local/server/ &&\ 
    wget http://nginx.org/download/nginx-1.13.8.tar.gz &&\ 
    tar -zxvf nginx-1.13.8.tar.gz  -C /usr/local/server &&\ 
    cd nginx-1.13.8 &&\ 
    ./configure --prefix=/usr/local/server/nginx &&\ 
    make && make install

RUN ln -s /usr/local/server/nginx/bin/nginx /usr/local/bin

# 安装supervisor
RUN easy_install-2.7 supervisor

CMD ["/usr/local/server/nginx/sbin/nginx", "-g", "daemon off;"]


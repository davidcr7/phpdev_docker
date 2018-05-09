FROM alpine:3.7

# 备份原始文件
RUN cp /etc/apk/repositories /etc/apk/repositories.bak

# 修改为国内镜像源
RUN echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories
RUN apk update

RUN apk add --no-cache g++ gcc autoconf make vim curl file linux-headers

RUN mkdir /usr/local/server
RUN cd /usr/local/server
RUN wget http://download.redis.io/releases/redis-4.0.9.tar.gz
RUN tar -zxvf redis-4.0.9.tar.gz -C /usr/local/server
RUN cd /usr/local/server/redis-4.0.9&& \ 
	make && make install


CMD ["/usr/local/server/redis-4.0.9/src/redis-server", "/usr/local/server/redis-4.0.9/redis.conf"]
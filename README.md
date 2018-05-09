# phpdev_docker
文件说明
nginx文件夹：nginx镜像（添加了supervisor进程管理工具）
php文件夹：php镜像（添加了swoole、yaf扩展等）
redis文件夹：redis镜像
conf:nginx、php、redis的配置文件

使用docker-compose管理以上三个容器

使用docker-compose来管理

启动说明
修改docker-compose.yml里 nginx和php容器下 挂载目录的地址（即你本地项目地址）
exp：  
  volumes:
    - ./www.conf:/usr/local/server/php/etc/php-fpm.d/www.conf
    - /www:/www
    
    改成  
  volumes:
    - ./www.conf:/usr/local/server/php/etc/php-fpm.d/www.conf
    - {本地项目路径}:/www

然后使用命令docker-compose up -d运行容器

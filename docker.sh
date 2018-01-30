#!/bin/bash

#------参数说明------
# $1 镜像名称
# $2本地项目目录
# $3nginx配置文件路径



#运行镜像名称
dockerImage=$1
#需要挂载的目录
sourceDir=$2
targetDir=/www

#nginx配置文件
nginxConf=$3

containerName=phpdev

#删除历史容器
docker stop $containerName
docker rm $(docker ps -aqf "name=$containerName" ) 2>&1|xargs ./docker_log.sh 

#运行docker镜像
docker run -itd -p 80:80 -v $sourceDir:$targetDir --name $containerName  $dockerImage /bin/bash 2>&1| xargs ./docker_log.sh


#复制nginx配置文件
docker cp $3 $containerName:/usr/local/server/nginx/conf/nginx.conf 2>&1| xargs ./docker_log.sh



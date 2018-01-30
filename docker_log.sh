#!/bin/bash

logString=""
#log时间
date=`date +%Y-%m-%d%h:%M:%S`

#拼接log信息
for((i=1;i<=$#;i++ ));
do
	logString=$logString" "${!i}
done
logString=$date":"$logString
logFile="/tmp/docker_error.log" 

#追加log到文件
echo $logString >> $logFile

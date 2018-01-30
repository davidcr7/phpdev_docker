#!/bin/bash
logString=""
date=`date +%Y-%m-%d%h:%M:%S`
for((i=1;i<=$#;i++ ));
do
	logString=$logString" "${!i}
done
logString=$date":"$logString
logFile="/tmp/docker_error.log" 
echo $logString >> $logFile

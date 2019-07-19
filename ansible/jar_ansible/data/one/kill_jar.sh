#!/bin/bash
JAR_NAME=$1
pid=`ps -aux | grep ${JAR_NAME} | grep -v "grep" | grep -v "sh" | awk '{print $2}'`
if [[ -z ${pid} ]]; then
    exit 0
else
    kill -9 ${pid}
fi

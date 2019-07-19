#!/bin/bash

export PATH=$PATH:/usr/local/jdk8/bin:/usr/local/jdk8/jre/bin

jar_name=$1
if [ -f "/data/log/$1" ];
then
    nohup java -jar /data/jar/$1/*.jar >> /data/log/$1 2>&1 &
else
    mkdir /data/log
    touch /data/log/$1
    nohup java -jar /data/jar/$1/*.jar >> /data/log/$1 2>&1 &
fi

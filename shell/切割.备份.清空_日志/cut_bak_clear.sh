#!/bin/bash
#定义变量
ip=`/usr/sbin/ifconfig ens192 | grep "inet" | awk '{print $2}' | grep -v ":"`
date=`date +%Y%m%d_%H:%M`
i=`ls /usr/local/bison_java/log`

#定义提示
if [ $# -eq "0" ];then
    echo "Usage: $0 ( 请输入 Help 寻求帮助~ )"
fi
function Help {
    echo "输入 脚本名+具体项目名或all 则可以切割对应日志最新的 1W 条记录。"
    echo "输入 脚本名+backup 则可以把所有日志备份到对应目录。"
    echo "输入 脚本名+clear 则可以清空所有日志内容。"
}

# 切割日志
function sc-advertising {
    mkdir -p /data/log
    tail -n 10000 /usr/local/bison_java/log/sc-advertising.log > /data/log/sc-advertising.log
    rm -rf /usr/local/bison_java/log/sc-advertising.log && \mv /data/log/sc-advertising.log /usr/local/bison_java/log/
}
function sc-bussiness {
    mkdir -p /data/log
    tail -n 10000 /usr/local/bison_java/log/sc-bussiness.log > /data/log/sc-bussiness.log
    rm -rf /usr/local/bison_java/log/sc-bussiness.log && \mv /data/log/sc-bussiness.log /usr/local/bison_java/log/
}
function sc-inventory {
    mkdir -p /data/log
    tail -n 10000 /usr/local/bison_java/log/sc-inventory.log > /data/log/sc-inventory.log
    rm -rf /usr/local/bison_java/log/sc-inventory.log && \mv /data/log/sc-inventory.log /usr/local/bison_java/log/
}
function sc-payment {
    mkdir -p /data/log
    tail -n 10000 /usr/local/bison_java/log/sc-payment.log > /data/log/sc-payment.log
    rm -rf /usr/local/bison_java/log/sc-payment.log && \mv /data/log/sc-payment.log /usr/local/bison_java/log/
}
function all {
    mkdir -p /data/log
    tail -n 10000 /usr/local/bison_java/log/sc-advertising.log > /data/log/sc-advertising.log
    tail -n 10000 /usr/local/bison_java/log/sc-bussiness.log > /data/log/sc-bussiness.log
    tail -n 10000 /usr/local/bison_java/log/sc-inventory.log > /data/log/sc-inventory.log
    tail -n 10000 /usr/local/bison_java/log/sc-payment.log > /data/log/sc-payment.log
    rm -rf /usr/local/bison_java/log/* && \mv /data/log/* /usr/local/bison_java/log/
}

#备份日志
function backup {
    mkdir -p /data/$ip\_$date/log
    cp -r /usr/local/bison_java/log/* /data/$ip\_$date/log/
}

#清空所有日志信息
function clear {
    for a in $i;
    do
        cd /usr/local/bison_java/log && echo ' ' > $a
    done
}
$1
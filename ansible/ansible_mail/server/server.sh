#!/bin/bash
n=`ps ef | grep $1 | grep -v "grep" | grep -v "server.sh" | wc -l`
ddate=`date +%Y%m%d`
fdate=`date +%H%M`
if [ $n -eq 0 ];then
    mkdir -p /data/$ddate/
    echo "$1 正在发送告警邮件" >> /data/$ddate/services_$fdate.log
    python /home/shell/mail.py 收件人地址 "主题"  "$1 服务有问题，请及时查看处理！"
else
	mkdir -p /data/$ddate/
    echo "$1 没问题！" >> /data/$ddate/services_$fdate.log
fi

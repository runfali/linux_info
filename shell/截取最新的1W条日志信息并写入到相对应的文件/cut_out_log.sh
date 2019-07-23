#!/bin/bash
date=`date +%Y%m%d_%H:%M`
if [ $# -eq "0" ];then
    echo "Usage: $0 ( sc-advertising | sc-bussiness | sc-inventory | sc-payment | all)"
fi

function sc-advertising {
    mkdir -p /data/$date/log
    tail -n 10000 /usr/local/bison_java/log/sc-advertising.log > /data/$date/log/sc-advertising.log
}
function sc-bussiness {
    mkdir -p /data/$date/log
    tail -n 10000 /usr/local/bison_java/log/sc-bussiness.log > /data/$date/log/sc-bussiness.log
}
function sc-inventory {
    mkdir -p /data/$date/log
    tail -n 10000 /usr/local/bison_java/log/sc-inventory.log > /data/$date/log/sc-inventory.log
}
function sc-payment {
    mkdir -p /data/$date/log
    tail -n 10000 /usr/local/bison_java/log/sc-payment.log > /data/$date/log/sc-payment.log
}
function all {
    mkdir -p /data/$date/log
    tail -n 10000 /usr/local/bison_java/log/sc-advertising.log > /data/$date/log/sc-advertising.log
    tail -n 10000 /usr/local/bison_java/log/sc-bussiness.log > /data/$date/log/sc-bussiness.log
    tail -n 10000 /usr/local/bison_java/log/sc-inventory.log > /data/$date/log/sc-inventory.log
    tail -n 10000 /usr/local/bison_java/log/sc-payment.log > /data/$date/log/sc-payment.log
}
$1
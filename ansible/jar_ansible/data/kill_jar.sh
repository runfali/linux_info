#!/bin/sh

if [ -f "/tmp/jar.pid" ];
then
    i=`cat /tmp/jar.pid`
    for pid in $i;
    do
        kill -9 $pid
    done
	rm -rf /tmp/jar.pid
else
    exit 0
fi



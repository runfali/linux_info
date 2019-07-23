#!/bin/bash
i=`ls /usr/local/bison_java/log`
for a in $i;
do
    cd /usr/local/bison_java/log && echo ' ' > $a
done
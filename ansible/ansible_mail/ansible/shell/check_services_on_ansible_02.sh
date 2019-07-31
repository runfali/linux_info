#!/bin/bash
services=`cat /home/shell/02.log`
for i in $services
do
    cd /etc/ansible/playbook/
    ansible-playbook check_services.yml --extra-vars "{'host':'02','name':'$i'}"
done

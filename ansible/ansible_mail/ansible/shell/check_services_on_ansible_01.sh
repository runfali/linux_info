#!/bin/bash
services=`cat /home/shell/01.log`
for i in $services
do
    cd /etc/ansible/playbook/
    ansible-playbook check_services.yml --extra-vars "{'host':'01','name':'$i'}"
done

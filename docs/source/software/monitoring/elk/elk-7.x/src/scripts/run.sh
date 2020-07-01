#!/bin/bash

if [ "$1" == "up" ]; then
    vagrant up elk cr0n05 4p0l0 --no-provision
elif [ "$1" == "provision-elk" ]; then
    vagrant provision elk
elif [ "$1" == "provision-filebeat" ]; then
    vagrant provision cr0n05 4p0l0
elif [ "$1" == "halt" ]; then
    vagrant halt elk cr0n05 4p0l0
else
    echo "Usage: ./run.sh up|provision-elk|provision-filebeat"
fi

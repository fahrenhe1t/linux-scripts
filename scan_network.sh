#!/bin/bash
# Quits if subnet is not included in command line
if [ $# -eq 0 ]; then
    echo "Requires subnet.  i.e. sudo $0 192.168.1.0/24"
    exit 1
fi

# folder to monitor
subnet="$1"

nmap -sP $subnet

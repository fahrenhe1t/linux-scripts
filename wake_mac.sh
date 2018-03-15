#!/bin/bash
# wake_mac.sh - Sends a magic packet to MAC address
if [ $# -eq 0 ]; then
    echo "Requires mac address.  i.e. $0 AA:BB:CC:DD:EE:FF"
    exit 1
fi

wakeonlan $1

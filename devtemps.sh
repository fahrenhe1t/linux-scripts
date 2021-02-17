#!/bin/bash

# devtemps.sh - lists device temps in Linux Mint
# requires lm-sensors and hddtemp to be installed
# hddtemp fix: sudo echo "Samsung SSD 850 EVO mSAT A21G0 B" 190 C "Samsung 850 EVO" >> /etc/hddtemp.db

(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
echo
echo CPU:
sensors k10temp-pci-00c3|grep temp1 && echo && echo "Hard Drive:" && hddtemp /dev/sda
echo

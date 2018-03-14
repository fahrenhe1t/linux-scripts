#!/bin/bash

# devtemps.sh - lists device temps in Linux Mint
(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
echo
echo CPU:
sensors k10temp-pci-00c3|grep temp1 && echo && echo "Hard Drive:" && hddtemp /dev/sda
echo

#!/bin/bash

# View a configuration file without comments or empty lines

(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1

# Quits if directory is not included in command line
if [ $# -eq 0 ]; then
    echo "Requires path to config file.  i.e. $0 /path/to/file.conf"
    exit 1
fi
echo 
echo $1
echo
egrep -v '#|^ *$' $1
echo

#!/bin/bash
# updatedebian.sh - runs commands to update debian OS
(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
apt-get update && apt-get upgrade && apt-get dist-upgrade

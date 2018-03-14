#!/bin/bash
(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
# shutdown -h -rF doesn't work to restart with FSCK - workaround is the following:
# requires that  /etc/default/rcS file is edited with option FSCKFIX=yes
touch /forcefsck
touch ~/usb0/forcefsck
shutdown -h -r now

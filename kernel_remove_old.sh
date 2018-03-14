#!/bin/bash
#removes old kernels from OS
(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
echo
echo "Removes old Kernels"
echo
v="$(uname -r | awk -F '-virtual' '{ print $1}')"
echo "Current Kernel: $v"
echo
i="linux-headers-virtual|linux-image-virtual|linux-headers-${v}|linux-image-$(uname -r)"
echo "Kernels to remove:"
dpkg --list | egrep -i  'linux-image|linux-headers' | awk '/ii/{ print $2}' | egrep -v "$i"
echo
echo "Removing old kernels..."
read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   apt-get --purge remove $(dpkg --list | egrep -i  'linux-image|linux-headers' | awk '/ii/{ print $2}' | egrep -v "$i")
fi

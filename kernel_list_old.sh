#!/bin/bash
#Lists old kernels installed on the machine
echo ""
echo "Lists old kernels"
echo ""
# Get kernel version #
v="$(uname -r | awk -F '-virtual' '{ print $1}')"
echo "Current Kernel: $v"
# Create ignore list to avoid deleting the running kernel #
i="linux-headers-virtual|linux-image-virtual|linux-headers-${v}|linux-image-$(uname -r)"
echo ""
echo "Ignore list: $i"
# Display the list #
echo ""
echo "Old Kernel Files:"
dpkg --list | egrep -i  'linux-image|linux-headers' | awk '/ii/{ print $2}' | egrep -v "$i"

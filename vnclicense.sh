#!/bin/bash
# vnclicense.sh - Applies RealVNC license key

echo ""
echo "Apply RealVNC License"
echo ""

(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1


vnclicense -add $1

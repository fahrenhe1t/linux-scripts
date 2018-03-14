#!/bin/bash
# Deletes security videos older than 15 days

echo ""
echo "Delete Security Videos"
echo ""

(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1

# Quits if directory is not included in command line
if [ $# -eq 0 ]; then
    echo "Requires video path to search.  i.e. sudo $0 /path/to/vids"
    exit 1
fi

# Set video path variable from command line
# for example: /mnt/path
# or /mnt/path
viddir="$1"

# Find directories in video path older than 15 days, delete them
# Only returns directories 1 level deep.  Excludes .template folder

find $viddir -maxdepth 1 -type d -mtime +15 -not -path "*template*" -exec rm -rf {} \; > /dev/null

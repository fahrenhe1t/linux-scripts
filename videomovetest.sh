#!/bin/bash
# Moves security videos from root of FTP folder to a folder named todays date
#
echo ""
echo "vidmovetest.sh - shows security .mkv videos created today"
echo ""
#(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
#if [ "$1" == "" ];
if [ -z "$1" ]; then
   echo "Script requires a path to videos.  Try $0 /mnt/usb0/ftp/ftp/security/FI9831P_00626E62878A/record"
   echo ""
   exit 1
else
  viddir="$1"
  today=`date +%F`
  tomorrow=`date '+%Y-%m-%d' -d '+1 day'`
  echo "Video Folder: $1"
  echo "Today's Date: $today"
  echo "Dollar0: $0"
  echo "Dollar1: $1"
  echo "Dollar2: $2"
  echo ""
  echo "Find videos modified today..."

  # Find videos in video path that were modified today and exclude files newer than today
  # find /mnt/usb0/ftp/ftp/security/FI9831P_00626E62878A/record -type f -name "*.mkv" -newermt 2016-01-29 ! -newermt 2016-01-30
  # find /mnt/usb0/ftp/ftp/security/C1_00626E60AAC1/record -type f -name "*.mkv" -newermt 2016-02-12 ! -newermt 2016-02-13
  find $viddir -maxdepth 1 -type f -name "*.mkv" -newermt $today ! -newermt $tomorrow | grep "."
fi

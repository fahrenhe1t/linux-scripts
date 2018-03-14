#!/bin/bash
# videomove.sh - v.1.5
# Moves security videos from root of FTP folder to a folder named yesterdays date
# Should be run after midnight to move yesterdays videos
#
echo ""
echo "videomove.sh - moves security .mkv videos"
echo ""
(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
# See if command line contains folder path
if [ -z "$1" ]; then
   echo "Script requires a path to videos.  Try $0 /mnt/path"
   echo ""
   exit 1
else
  # Set Variables - need vid folder, yesterday, today and tomorrows date
  viddir="$1"
  yesterday=`date +%F -d '-1 day'`
  today=`date +%F`
  tomorrow=`date +%F -d '+1 day'`

  echo "Yesterday's Date: $yesterday"
  echo "Today's Date: $today"
  echo ""
  echo "Find videos modified yesterday..."

  # Find videos in video path that were modified yesterday and exclude files newer than today
  # find /mnt/path -type f -name "*.mkv" -newermt 2016-01-29 ! -newermt 2016-01-30
  # find /mnt/path -type f -name "*.mkv" -newermt 2016-02-12 ! -newermt 2016-02-13
  find $viddir -maxdepth 1 -type f -name "*.mkv" -newermt $yesterday ! -newermt $today | grep "." > /dev/null

  # If find command finds files created yesterday, then
  if [ $? -eq 0 ]; then
    echo "Found videos, making yesterday's directory..."
    # Make a directory named yesterdays date, no error if the folder exists
    mkdir -p $viddir/$yesterday

    # If folder doesnt exist, copy template folder with h5ai and htaccess files to yesterdays date
    # if [ ! -d "$viddir/$yesterday" ]; then
    #   echo "Creating $yesterday folder..."
    #   cp -r $viddir/.template $viddir/$yesterday
    # fi
    echo "Moving files..."
    # Run the find files command again and execute a move command to move them in yesterdays folder
    # -maxdepth 1 means it will not search in subfolders
    find $viddir -maxdepth 1 -type f -name "*.mkv" -newermt $yesterday ! -newermt $today -exec mv -t $viddir/$yesterday/ {} \; > /dev/null
    # find number of files moved, and write to syslog
    files=`ls $viddir/$yesterday/*.mkv | wc -l`
    echo "$files files moved to video folder"
    logger videomove.sh - $files files moved to $viddir/$yesterday/ folder
  else
    # Otherwise, move along
    echo "No videos yesterday"
    logger videomove.sh - No files moved to $viddir/$yesterday/ folder
  fi
fi

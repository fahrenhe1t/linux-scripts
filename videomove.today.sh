#!/bin/bash
# videomove.today.sh - Moves security videos from root of FTP folder to a folder named todays date
#
echo ""
echo "videomove.sh - moves security .mkv videos"
echo ""
(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
# old expression, new expression to see if folder is not in command line below
# if [ "$1" == "" ] ; then
if [ -z "$1" ]; then
   echo "Script requires a path to videos.  Try $0 /mnt/path"
   echo ""
   exit 1
else
  # Set Variables - need vid folder, today and tomorrows date
  viddir="$1"
  today=`date +%F`
  tomorrow=`date '+%Y-%m-%d' -d '+1 day'`

  echo "Today's Date: $today"
  echo ""
  echo "Find videos modified today..."

  # Find videos in video path that were modified today and exclude files newer than today
  # find /mnt/path -type f -name "*.mkv" -newermt 2016-01-29 ! -newermt 2016-01-30
  # find /mnt/path -type f -name "*.mkv" -newermt 2016-02-12 ! -newermt 2016-02-13
  find $viddir -maxdepth 1 -type f -name "*.mkv" -newermt $today ! -newermt $tomorrow | grep "." > /dev/null

  # If find command finds files created today, then
  if [ $? -eq 0 ]; then
    echo "Found videos, making today's directory..."
    # Make a directory named todays date, no error if the folder exists
    # mkdir -p $viddir/$today

    # If folder doesnt exist, copy template folder with h5ai and htaccess files to todays date
    if [ ! -d "$viddir/$today" ]; then
      echo "Creating $today folder..."
      cp -r $viddir/.template $viddir/$today
    fi
    echo "Moving files..."
    # Run the find files command again and execute a move command to move them in todays folder
    # -maxdepth 1 means it will not search in subfolders
    find $viddir -maxdepth 1 -type f -name "*.mkv" -newermt $today ! -newermt $tomorrow -exec mv -t $viddir/$today/ {} \; > /dev/null
    # find number of files moved, and write to syslog
    files=`ls $viddir/$today/*.mkv | wc -l`
    echo "$files files moved to video folder"
    logger videomove.sh - $files files moved to $viddir
  else
    # Otherwise, move along
    echo "No videos today"
    logger videomove.sh - No files moved to $viddir
  fi
fi

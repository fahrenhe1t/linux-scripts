#!/bin/bash
####################################
#
# Backup to NFS mount script.
#
# adapted from: https://help.ubuntu.com/lts/serverguide/backup-shellscripts.html 
#
# crontab entry (executes daily at 12:00 am.):
# m h dom mon dow   command
#0 0 * * * bash /usr/local/bin/backup.sh
#
# Extract one file:
# tar -xzvf /mnt/backup/host-Monday.tgz -C /tmp etc/hosts
#
# View list of archive:
# tar -tzvf /mnt/backup/host-Monday.tgz
#
# Restore archive:
# sudo tar -xzvf /mnt/backup/host-Monday.tgz -C /
#
####################################

(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
# What to backup. 
backup_files="home/ var/spool/mail/ var/www/html/ etc/ root/ boot/ opt/"

# Where to backup to.
dest="/mnt/diskstation"

# Create archive filename.
day=$(date +%Y%m%d)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar -czf $dest/$archive_file -C / $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest

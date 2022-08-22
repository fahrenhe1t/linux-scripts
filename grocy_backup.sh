#!/bin/bash

# Grocy Backup Script Template
# ---
# Script backs up containers with SQLite databases, and deletes old backups after X days
# Creates backup scripts in format: grocy-<datetime>.sql.gz
# Backs up database with .dump option which creates a .sql file, then zips it.
# ** Backing up SQLite database requires sqlite3 **
#
#       sudo apt install sqlite3
#
# Restore database: gzip -d grocy-<datetime>.sql.gz && cat grocy-<datetime>.sql | sqlite3 /path/to/grocy.db

# Requires Root Access
(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1

app1db=/path/to/grocy.db # CHANGE to grocy.db path
backupdir=/path/to/db-backup # CHANGE to your backup storage path
log=/usr/bin/logger # Path to Logger - creates entry in syslog
keepdays=30 # How long to keep backup files
sqlitepath=/usr/bin/sqlite3 # default path to sqlite3 when installed
app1=grocy # name of app, app container, and backup file

# Grocy
# if database file exists then move forward
if [ -f "$app1db" ]; then
    echo Backing up $app1...
    echo Creating $app1 backup file...
    # Backup database
    $sqlitepath $app1db .dump | gzip > $backupdir/$app1-$(date +"%Y%m%d%H%M").sql.gz
    if [ $? -eq 0 ]; then
        # If backup is successful, log it and remove old backup files
        $log "$0 - $app1 backed up in $backupdir"
        echo $app1 backed up...
        echo Deleting old $app1 backups...
        OLD_BACKUPS=$(ls -1 $backupdir/$app1*.gz |wc -l)
        if [ $OLD_BACKUPS -gt $keepdays ]; then
            find $backupdir -name "$app1*.gz" -daystart -mtime +$keepdays -delete
        fi
        echo Backup for $app1 complete.
    else
        # Otherwise, assume backup failed
        echo "$app1 backup failed."
        $log "$0 - $app1 failed."
        exit 1
    fi
else
    # Database file does not exist; quit.
    echo
    echo "Check existence of db: $app1db"
    echo
    exit 1
fi
echo ""
echo "Backup for Databases completed"
echo ""

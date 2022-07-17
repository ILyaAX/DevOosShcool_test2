#!/bin/bash

cd /root/backup_s3/

        # creating a 100 kilobyte file -  dd-mm-YYYY-%H:%M.log
base64 /dev/urandom | head -c 100000 > $(date +%d-%m-%Y-%H:%M).log

        # deleting files older than 7 days
find /root/backup_s3/ -type f \( -iname "*.log" ! -iname ".sh" \) -cmin +5 -exec rm -f {} \;

        # send files to the s3 repository
s3cmd sync --delete-removed --exclude "backup*"  /root/backup_s3/ s3://ax_backup/

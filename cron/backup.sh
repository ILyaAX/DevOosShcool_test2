#!/bin/bash

cd /root/backup_cron/

        # creating a 100 kilobyte file -  dd-mm-YYYY-HH:MM.log
base64 /dev/urandom | head -c 100000 > $(date +%d-%m-%Y-%H:%M).log

        # send the created file to the remote server
rsync -avz --exclude '*.sh' /root/backup_cron/ root@89.208.228.219:/root/backup_cron/

        # on the remote server to delete files that are older than 7 days 
ssh root@89.208.228.219 "cd /root/backup_cron; find . -mtime +7 -exec rm -f {} \;; exit"

        # delete the created .log files
rm -rf *.log

# The script should be made executable and placed in the /etc/cron.daily/ folder
# The script name must not contain any dots.
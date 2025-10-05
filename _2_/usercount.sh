#!/usr/bin/bash

# Daily system-scheduled job that logs the number of users logged into the system
# Make sure to make this script exectuable by chmod +x usercount.sh

USER_COUNT=$(who | wc -l)
logger "Number of logged-in users at $(date +'%H-%m') is ${USER_COUNT}"
exit 0

# run make copy to copy file under /etc/cron.daily/

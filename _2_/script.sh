#!/usr/bin/bash

# ------------- LAB -----------
# Create a daily system job that counts number of users logged-in to the system.
# Log the result to the system.



# 1-  ----------- Edit the shell script for usercount  --------------

##!/usr/bin/bash

## Daily system-scheduled job that logs the number of users logged into the system
## Make sure to make this script exectuable by chmod +x usercount.sh

#USER_COUNT=$(who | wc -l)
#logger "Number of logged-in users at ${date +'%H-%m'} is ${USER_COUNT}"
#exit 0

## run make copy to copy file under /etc/cron.daily/

# 2- ---------- Copy the script under /etc/cron.daily/ -----------
sudo make copy

# 3- ---------- Add a custom crontab config file under /etc/cron.d/ -----------
# The file should configure the newly added script under /etc/cron.daily/ to run daily at 10 AM

## Run this daily jobs
#SHELL=/bin/bash
#PATH=/sbin:/bin:/usr/sbin:/usr/bin
#MAILTO=root
#00 10 * * * root run-parts /etc/cron.daily
## or 00 10 * * * root /etc/cron.daily/usercount.sh

# 4- ---------- Reload the crond service -----------
sudo systemctl reload crond.service

# 5- ----------------  At 10 AM, see the log message ------------------
 sudo journalctl -p notice | tail -100 | grep Number
# where 'notice' is the default log priority

exit $?

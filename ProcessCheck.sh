#!/bin/bash
# This script has been created for a server that had process frequently crash.
# Simply put this script to crontab to automaticaly revive the process.

#Please specify which process to watch and service to start in case the process stopped running.
#In this example memcached is used
ProcessName=memcached
ProcessStartCommand="service start memcached"
ServiceName=memcached

# Nginx processes are counted in this line.
CheckProcessCount=$(ps -e | grep $(echo $ProcessName) | awk -F' ' '{ print $4 }' | wc -l)

# Echo is used for confirming is process count command works.
echo $CheckProcessCount

#If nginx process does not exsist (which is process count less than 1) on the system them it will be started automatically.
if [ $CheckProcessCount -lt 1 ]
then
service $(echo $ServiceName) start
else echo > /dev/null
fi
#EOF

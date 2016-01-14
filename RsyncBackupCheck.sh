#!/bin/bash
#This script is written for a system that backup takes more than 24 hours. 
#If Rsync job does not finish in 24 minutes the job this script will not run.

RsyncCheck=`ps -e | grep rsync > /tmp/RsyncCheck.out`
RsyncCheckCount=`wc -l /tmp/RsyncCheck.out | cut -d' ' -f1`
echo $RsyncCheckCount
if [ "$RsyncCheckCount" -gt "0" ]
then
logger "Rsync job is going on..."
else
logger "Rsync Job is Starting"
rsync -avzh /backup/vm_backup/ /media/ibbsk01/vm_backup/
logger "Rsync Job Finished - IBBSK Backup"
fi
~

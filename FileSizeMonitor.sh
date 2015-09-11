#!/bin/bash
#Hasn't been tested yet.
LogFileSize=$(wc -l error.log)

#Lets say if the file reaches more than 1000 we will send email
if [ LogFileSize -gt 1000 ]
then
python mail.py mail@me.com Error.log_problem blablabla
else echo > /dev/null
fi

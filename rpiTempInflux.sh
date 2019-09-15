#!/bin/bash
# This file sends RaspBerry Pi's temperature to influx db.
# Put this file to crontab with
# sudo echo "@reboot bash /home/pi/scr/rpiTempInflux.sh" >> /var/spool/cron/crontabs/pi

source /etc/bash.bashrc
cmnd="/opt/vc/bin/vcgencmd measure_temp"
while true
do
        rpiTemp=$($cmnd | sed s/temp=//g | sed s/\'C//g)
        curl -i -XPOST 'http://localhost:8086/write?db=rpi' --data-binary "temp value=$rpiTemp"
        sleep 10
done

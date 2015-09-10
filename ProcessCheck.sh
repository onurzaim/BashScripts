# This script has been created for a server that nginx frequently crash. 
# Simply put this script to crontab to automaticaly revive the server.
# Nginx processes are counted in this line.
NginxProcessCount=$(ps -e | grep nginx | awk -F' ' '{ print $4 }' | wc -l)
# Echo is used for confirming is process count command works.
echo $NginxProcessCount
#If nginx process does not exsist (which is process count less than 1) on the system them it will be started automatically.
if [ $NginxProcessCount -lt 1 ]
then
exec /usr/local/nginx/sbin/nginx
else echo > /dev/null
fi
#EOF

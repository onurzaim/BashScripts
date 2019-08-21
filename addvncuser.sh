
#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]
then

	echo -e "Usage: addvncuser username portnu(x or xy) - last digits like if you want 5920 you should use 20"
	
else

	portNo=$(expr $(echo 2 | wc -m) - 1)
	if [ "$portNo" -eq 1 ]
	then 
		vncPort="590$2"
	else
		vncPort="59$2"
	fi

	echo "### Checking for Open Ports ###"
	portUser=$(lsof | grep $vncPort | grep vnc | grep llvm | awk '{ print $5 }' | uniq)

	if [ -n "$portUser" ]
	then
	echo -e "Warning: Port $vncPort is used by $portUser"
	exit

	else

	fileExist=$(ls -1 /etc/systemd/system/vncserver@$2.service | grep $2 | wc -l)
	portNo=$(expr $(echo 2 | wc -m) - 1)

	if [ "$fileExist" -gt 0 ]
		then
			echo -e "Warning: You already used this port no :$2 before please remove /etc/systemd/system/vncserver@$2.service"
			echo -e "command: rm /etc/systemd/system/vncserver@$2.service"
	else

#Create User
echo -e "### Adding User ###"
useradd $1 -m -d /home/$1 -s /bin/bash

echo -e "### Assign password to $1 ###"
passwd $1

#
su - $1 -c "vncserver"
killScreenNo=$(ls -1 /home/$1/.vnc/*.log | awk -F ':' '{ print $2 }' | awk -F '.' '{ print $1 }')
su - $1 -c "vncserver -kill :$killScreenNo"

echo '[Unit]' >> /etc/systemd/system/vncserver\@$2.service
echo 'Description=Remote desktop service (VNC)' >> /etc/systemd/system/vncserver\@$2.service
echo 'After=syslog.target network.target' >> /etc/systemd/system/vncserver\@$2.service
echo '' >> /etc/systemd/system/vncserver\@$2.service
echo '[Service]' >> /etc/systemd/system/vncserver\@$2.service
echo 'Type=forking' >> /etc/systemd/system/vncserver\@$2.service
echo 'User=NEWUSER' >> /etc/systemd/system/vncserver\@$2.service
echo 'Group=NEWUSER' >> /etc/systemd/system/vncserver\@$2.service
echo '' >> /etc/systemd/system/vncserver\@$2.service
echo '# Clean any existing files in /tmp/.X11-unix environment' >> /etc/systemd/system/vncserver\@$2.service
echo 'ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1' >> /etc/systemd/system/vncserver\@$2.service
echo 'ExecStart=/usr/bin/vncserver -geometry 1920x1080 :%i' >> /etc/systemd/system/vncserver\@$2.service
echo 'PIDFile=/home/NEWUSER/.vnc/%H:%i.pid' >> /etc/systemd/system/vncserver\@$2.service
echo 'ExecStop=/usr/bin/vncserver -kill :%i > /dev/null 2>&1' >> /etc/systemd/system/vncserver\@$2.service
echo '' >> /etc/systemd/system/vncserver\@$2.service
echo '[Install]' >> /etc/systemd/system/vncserver\@$2.service
echo 'WantedBy=multi-user.target' >> /etc/systemd/system/vncserver\@$2.service

sed -i "s/NEWUSER/$1/g" /etc/systemd/system/vncserver\@$2.service

systemctl daemon-reload
systemctl enable vncserver\@$2.service
systemctl start vncserver\@$2.service

echo ''
echo -e "VNC server with :$2 is Up!!!"

	fi

	fi

fi

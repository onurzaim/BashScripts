#!/bin/bash
#This scripts send mail from telnet with ehlo
Concurrent=$(curl http://my.url.com)

echo "$Concurrent"

(
sleep 1;
echo HELO ehlo.name;
sleep 1;
echo mail from: mail@address.com;
sleep 1;
echo rcpt to: mail.recipients@address.com;
sleep 1;
echo data;
sleep 1;
echo Subject: Subject Name;
echo Content-Type: text/html;
echo
echo
echo "$Concurrent";
echo .;
sleep 1;
echo quit
) | telnet my.mailserver.com 25

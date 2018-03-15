CURDATE=`date +%Y%m%d`
LocalDir="/home/USER"
RemoteDir="RemoteDir"

(sleep 1;
echo 
echo cd $RemoteDir;
sleep 1;
echo lcd $LocalDir;
sleep 1;
echo put FileName_$CURDATE.zip;
echo bye;
) | sshpass -p "PassWord321!" sftp UserName@12.34.56.78

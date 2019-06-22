connList=$(tail -20000 /web/logs/artamonline.access_log | awk -F ' ' ' { print $1 } ' | sort | uniq -c | sort -n)
sleep 2
connListNext=$(tail -20000 /web/logs/artamonline.access_log | awk -F ' ' ' { print $1 } ' | sort | uniq -c | sort -n)

#ipList=$(echo "$connList" | tail -10 | awk '{ print $2 }')
ipList=$(echo "$connList" | awk '{ print $2 }')
#connNumber=$(echo "$connList" | tail -10 | awk '{ print $1 }')
#connNumber=$(echo "$connList" | awk '{ print $1 }')

for i in $ipList
do
connNumberOld=$(echo "$connList" | grep $i | awk '{ print $1 }')
#sleep 2
connNumberNew=$(echo "$connListNext" | grep $i | awk '{ print $1 }')
calculateConn=$(echo $connNumberNew-$connNumberOld | bc)

echo $calculateConn $'\t' $i
done

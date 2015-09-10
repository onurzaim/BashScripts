# ilgili dizine gidilir

cd /scripts/erstream.ligtv.total

# timedata dosyasi degistirtiltir.

bash change.timedata.sh

# curl ile login olma bu satirlarda gerceklesir. Diari cookie ve header alinir.

curl "http://www.example.com/Home/Login" -H "Pragma: no-cache" -H "Origin: http://www.example.com" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: en-US,en;q=0.8,tr;q=0.6" -H "User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36" -H "Content-Type: application/x-www-form-urlencoded" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Cache-Control: no-cache" -H "Referer: http://clientstats.erstream.com/cassandra/Home/Index" -H "Cookie: sidebar_closed=0" -H "Connection: keep-alive" --data "username=user&password=pass&remember=1" --compressed -c cookie.txt -L --dump-header header

# parse edilecek json kodu bu komut ile alinir.
# time data dosyasi guncel zamani belirten dosyadir.
curl -b cookie.txt --data @timedata http://www.example.com | sed -n 1'p' | tr '}' '\n' > concurrent.list.txt

#Sadece ligTV canli mac sayilari cikartilir.
cat concurrent.list.txt | grep StringData | awk -F ':' '{ print $4 }' > StringDataOutput.txt

#Son 5 satir ayristilir ve yeni bir dosyaya yazilir.
tail -5 concurrent.list.ligtv.canli.txt > concurrent.list.ligtv.canli.5.txt

#Son 4 satir silinir.
sed -i '$ d' concurrent.list.ligtv.canli.5.txt
sed -i '$ d' concurrent.list.ligtv.canli.5.txt
sed -i '$ d' concurrent.list.ligtv.canli.5.txt
sed -i '$ d' concurrent.list.ligtv.canli.5.txt
abbix'e yollanir.
# Z
cat concurrent.list.ligtv.canli.5.txt

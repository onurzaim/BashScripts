# Install adafruit python modules and git hub library
#This script will monitor data coming from sm2302 sensor and send it to influxDB

#cmnd=$(sudo python3 /home/pi/Adafruit_Python_DHT/examples/AdafruitDHT.py 2302 17)
#d=`date +%Y:%m:%d-%H:%M:%S`

th () {
while true
do

        cmnd=$(sudo python3 /home/pi/Adafruit_Python_DHT/examples/AdafruitDHT.py 2302 17)
        d=`date +%Y:%m:%d-%H:%M:%S`
        echo "$d - $cmnd"
        temp=$(echo $cmnd | awk ' { print $1 } ' | awk -F'=' ' { print $2 } ' | sed "s/*//g")
        echo $temp
        humid=$(echo $cmnd | awk ' { print $2 } ' | awk -F'=' ' { print $2 } ' | sed "s/%//g")
        echo $humid

        curl -i -XPOST 'http://localhost:8086/write?db=th' --data-binary "temp value=$temp"
        curl -i -XPOST 'http://localhost:8086/write?db=th' --data-binary "humid value=$humid"

        sleep 10

done
}

th

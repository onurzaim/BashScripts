# Install adafruit python modules and git hub library
#This script will monitor data coming from sm2302 sensor and send it to influxDB

apt install python3-pip git
pip3 install Adafruit_DHT
git clone https://github.com/adafruit/Adafruit_Python_DHT.git
cd Adafruit_Python_DHT

#cmnd=$(sudo python3 /home/pi/Adafruit_Python_DHT/examples/AdafruitDHT.py 2302 17)
#d=`date +%Y:%m:%d-%H:%M:%S`

th () {
while true
do
host="10.0.0.100"
db="rpi"

while true
do

        cmnd=$(sudo python3 /home/pi/Adafruit_Python_DHT/examples/AdafruitDHT.py 11 17)
        d=`date +%Y:%m:%d-%H:%M:%S`
        echo "$d - $cmnd"
        temp=$(echo $cmnd | awk ' { print $1 } ' | awk -F'=' ' { print $2 } ' | sed "s/*//g")
        echo $temp
        humid=$(echo $cmnd | awk ' { print $2 } ' | awk -F'=' ' { print $2 } ' | sed "s/%//g")
        echo $humid

        curl -i -XPOST "http://$host:8086/write?db=$db" --data-binary "temp.backroom value=$temp"
        curl -i -XPOST "http://$host:8086/write?db=$db" --data-binary "humid.backroom value=$humid"

        sleep 10

### try this
### curl -i -XPOST 'http://localhost:8086/write?db=th' --data-binary "temp value=$temp humid value$humid"

        sleep 10

done
}

th

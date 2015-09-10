# This script will check kibana graph activity if you have the json query. 
# You can simply obtain the json query my clicking on the cork at right top of the graph.
# logservice.elastic.query.json file is the query used for evaluating the results you need.
cd /Path/to/script
#Kibana uses epoch time in ms form
GetKibanaDate=$(date +%s)000
#I want to recieve last 5 minute data
GetKibanaDateMinus5m=$(echo "$GetKibanaDate -300000" | bc)
#In logservice.elastic.query.json find the epoch time and place the time in a single line alone and rename them as var1 and var2
#This command will replace var1 and var2 with the most recent time and output as query_last.json
sed -e 's/var1/'$GetKibanaDateMinus5m'/' -e 's/var2/'$GetKibanaDate'/' logservice.elastic.query.json > query_last.json
# This command will send query to kibana server and output the filtered data to a file
curl -XGET 'http://logservice-pubsub.digiturk.aws:9200/logstash-2014.12.26/_search?pretty' --data @query_last.json | grep count | awk -F':' '{ print $2 }' > kibana_elastic_incidents.txt
# this command will sum all incidents in the file and send it to zabbix
zabbix_sender -z 127.0.0.1 -s hostname -k itemname -o $(awk '{s+=$1} END {print s}' kibana_elastic_incidents.txt)

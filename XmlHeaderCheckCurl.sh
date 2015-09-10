#This is a bashscript that uses curl to check a URL with xml post/get header
curl -X POST -H "Content-Type: text/xml" -F file=@loginadk.xml https://www.example.com/service

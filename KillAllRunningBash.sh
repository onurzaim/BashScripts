# This command will kill all processes with name "String". 
# This script used specificaly to kill bash scripts named "string"
kill $(ps -ax | grep string | awk ' { print $1 } ')

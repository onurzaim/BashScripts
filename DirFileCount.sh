#This script is made for for Sun Solaris 10.
#This script will list file count of a directory.
#Usage:
#DirPath="/Dir"
#DirFileCount.sh /$DirPath

$1 ' -> echo $1'
args=("$@")
cd $1
ListCount=$(ls -l | awk -F' ' '{ print $9 }' | wc -l)
ListMinusOne=$(echo $ListCount - 2 | bc)
echo "****"
echo List Line Number $ListCount
echo List will be counted $ListMinusOne
echo "****"
DirList=$(ls -l | awk -F' ' '{ print $9 }' | tail -$ListMinusOne)
for i in $DirList
do
        echo -e "$(find ./$i -type f | wc -l)\t files in $i directory"
        #echo -e "$(du ./$i -sh) files in $i"
done
~

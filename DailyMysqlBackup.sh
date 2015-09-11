## This script will fully backup your mysql servers' as dump file with a name Year_Day_Time.bzip format.

cd /backup
Yil=$(date +%Y)
Gun=$(date +%j)
Saat=$(date | awk -F' ' '{ print $4 }' | awk -F':' '{ print $1 }')
Dakika=$(date | awk -F' ' '{ print $4 }' | awk -F':' '{ print $2 }')
Saniye=$(date | awk -F' ' '{ print $4 }' | awk -F':' '{ print $3 }')
mysqldump -uusername -ppassword -h 127.0.0.1 --all-databases > Secbir-$DbName-$Yil-$Gun-$Saat$Dakika$Saniye.sql
bzip2 -z DbBackup-$DbName-$Yil-$Gun-$Saat$Dakika$Saniye.sql

# Move backup to remote server with scp. You must make trust with rsa keys.
scp DbBackup-$DbName-$Yil-$Gun-$Saat$Dakika$Saniye.sql.bz2 username@example.com:/backup/db

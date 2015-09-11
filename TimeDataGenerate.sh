# Baslangic saat derleri tayin edilir. Burada date komutundan faydalanildi

YilStart=$(date +%Y)
AyStart=$(date +%m)
GunStart=$(date +%d)
SaatStart=$(date +%k)

# 1 saat gerisi icin hesaplama

SaatStartMinus1Hr=$(echo -e $SaatStart-1 | bc)

# Test amacli echo

echo $SaatStartMinus1Hr

# Bitis saati tayin edilir.

YilEnd=$(date +%Y)
AyEnd=$(date +%m)
GunEnd=$(date +%d)
SaatEnd=$(date +%k)


SaatStartMinus3Hr=$(echo -e $SaatStart-1 | bc)
SaatStartMinus4Hr=$(echo -e $SaatStart-3 | bc)

# timedata.1 dosyasindaki varX'ler sed komutu ile degistirilir. timedata dosyasi konacak.

sed -e 's/var1/'$YilStart'/' -e 's/var2/'$AyStart'/'  -e 's/var3/'$GunStart'/'  -e 's/var4/'$SaatStartMinus4Hr'/'  -e 's/var5/'$YilEnd'/'  -e 's/var6/'$AyEnd'/'  -e 's/var7/'$GunEnd'/'  -e 's/var8/'$SaatStartMinus3Hr'/'  timedata.1 > timedata

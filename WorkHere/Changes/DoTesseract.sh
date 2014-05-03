rm -r *.temp

for i in *.jpg

do 

mkdir $i.temp
cp textcleaner.sh  $i.temp
cp $i $i.temp
cd $i.temp

./textcleaner.sh -c "0,50,0,0" -g -e normalize -f 15 -o 10 -u -s 2 -T -p 20 $i $i.cleaned.jpg


tesseract $i.cleaned.jpg $i.out

cd ..

done

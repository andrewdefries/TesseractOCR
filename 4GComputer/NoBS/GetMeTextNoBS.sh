
#Target=(`ls *.jpg`)
Target=(`ls img00085.jpg`)

touch $Target.txt

for i in "${Target[@]}"

do 
######
######
tesseract $i $i.txt

cat $i.txt | sed -n "/[a-z A-Z]/p" | wc -w > wordcount

wordcount=(`cat wordcount | cut -c 1-2`) 

if [ $wordcount -eq 0 ]
then
rm $i.txt
tries=1

while [ $tries -le 3 ]	

do
echo "$i"

convert -rotate 90 $i $i.rotatedL.jpg
tesseract $i.rotatedL.jpg $i.rotatedL.txt
convert -rotate -90 $i $i.rotatedR.jpg
tesseract $i.rotatedR.jpg $i.rotatedR.txt

tries=` expr $tries + 1`
done

fi

#######
#######
done

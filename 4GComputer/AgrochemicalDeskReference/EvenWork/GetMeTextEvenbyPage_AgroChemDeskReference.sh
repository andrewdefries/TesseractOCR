rm RunLog
#
gsutil -m ls gs://books_batch5/AgroChemicalsDeskReferenceNoMore/*.jpg | sed 's/gs:\/\/books_batch5\/AgrochemicalsDeskReferenceNoMore\///g'  > WorkList
touch DoneList
gsutil -m ls gs://agrochemical_desk_reference/*.jpg | sed 's/gs:\/\/agrochemical_desk_reference\///g'| sed 's/.ready.jpg/.jpg/g'  > DoneList 
comm -3 WorkList DoneList > RemainderList
######
cat RemainderList | sed -n '/.*[02468]\.jpg/p' |  sed 's/.jpg//g' | cut -c 1-19 > EvenWorkList
cat RemainderList | sed -n '/.*[13579]\.jpg/p' |  sed 's/.jpg//g' | cut -c 1-19 > OddWorkList
######
remainder_val=(`cat RemainderList | wc | cut -c 4-8`)
#xcrop=(`cat xcrop`)
#ycrop=(`cat ycrop`)
#xoffset=(`cat xoffset`)
#yoffset=(`cat yoffset`)
############
while [ $remainder_val -gt 0 ]

do
############
remainder=(`cat EvenWorkList`)
############
for i in "${remainder[@]}"
do
######
gsutil -m ls gs://books_batch5/AgroChemicalsDeskReferenceNoMore/*.jpg | sed 's/gs:\/\/books_batch5\/AgrochemicalsDeskReferenceNoMore\///g'  > WorkList
gsutil -m ls gs://agrochemical_desk_reference/*.jpg | sed 's/gs:\/\/agrochemical_desk_reference\///g'| sed 's/.ready.jpg/.jpg/g'  > DoneList 
comm -3 WorkList DoneList > RemainderList
######
cat RemainderList | sed -n '/.*[02468]\.jpg/p' |  sed 's/.jpg//g' | cut -c 1-19 > EvenWorkList
cat RemainderList | sed -n '/.*[13579]\.jpg/p' |  sed 's/.jpg//g' | cut -c 1-19 > OddWorkList
######
######
gsutil -m cp gs://books_batch5/AgroChemicalsDeskReferenceNoMore/$i.jpg .
#gsutil -m cp gs://books_batch4/ThePesticideManualLast/$i.jpg .
echo $i >> RunLog
convert $i.jpg -crop 3700x2696+248+132 $i.crop.jpg 
#convert $i.jpg -crop $xcropx$ycrop+$xoffset+$yoffset $i.crop.jpg 
convert -rotate -90 $i.crop.jpg $i.rotated.jpg
rm $i.crop.jpg
./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
rm $i.rotated.jpg
tesseract $i.ready.jpg $i
tesseract $i.ready.jpg $i hocr
hocr2pdf -i $i.ready.jpg -o $i.pdf < $i.html
######
gsutil -m cp $i.txt gs://agrochemical_desk_reference
gsutil -m cp $i.html gs://agrochemical_desk_reference
gsutil -m cp $i.pdf gs://agrochemical_desk_reference
gsutil -m cp $i.ready.jpg gs://agrochemical_desk_reference
######
rm $i.ready.jpg
rm $i.pdf
rm $i.txt
rm $i.html
rm $i.jpg
######
done
###########
done


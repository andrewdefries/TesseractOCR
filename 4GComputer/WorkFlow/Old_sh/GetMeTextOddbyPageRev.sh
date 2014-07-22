rm RunLog
#
gsutil -m ls gs://books_batch5/ThePesticideManualNoMore/*.jpg | sed 's/gs:\/\/books_batch5\/ThePesticideManualNoMore\///g'| sed 's/.jpg//g' > WorkList
touch DoneList
gsutil -m ls gs://the_pesticide_manual/*.txt | sed 's/gs:\/\/the_pesticide_manual\///g'| sed 's/.txt//g'  > DoneList 
comm -3 WorkList DoneList > RemainderList
######
cat RemainderList | sed -n '/.*[02468]/p' | sed '1!G;h;$!d' | cut -c 1-9 > EvenWorkListRev
cat RemainderList | sed -n '/.*[13579]/p' | sed '1!G;h;$!d' | cut -c 1-9 > OddWorkListRev
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
remainder=(`cat OddWorkList`)
############
for i in "${remainder[@]}"
do
######
gsutil -m ls gs://books_batch5/ThePesticideManualNoMore/*.jpg | sed 's/gs:\/\/books_batch5\/ThePesticideManualNoMore\///g'| sed 's/.jpg//g' > RevWorkList
gsutil -m ls gs://the_pesticide_manual/*.txt | sed 's/gs:\/\/the_pesticide_manual\///g'| sed 's/.txt//g'  > RevDoneList 
comm -3 RevWorkList RevDoneList > RevRemainderList
######
cat RevRemainderList | sed -n '/.*[02468]/p' | sed '1!G;h;$!d' | cut -c 1-9 > EvenWorkListRev
cat RevRemainderList | sed -n '/.*[13579]/p' | sed '1!G;h;$!d' | cut -c 1-9 > OddWorkListRev
######
######
gsutil -m cp gs://books_batch5/ThePesticideManualNoMore/$i.jpg .
#gsutil -m cp gs://books_batch4/ThePesticideManualLast/$i.jpg .
echo $i >> RunLog
convert $i.jpg -crop 3772x2640+356+76 $i.crop.jpg 
#convert $i.jpg -crop $xcropx$ycrop+$xoffset+$yoffset $i.crop.jpg 
convert -rotate 90 $i.crop.jpg $i.rotated.jpg
rm $i.crop.jpg
./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
rm $i.rotated.jpg
tesseract $i.ready.jpg $i
tesseract $i.ready.jpg $i hocr
hocr2pdf -i $i.ready.jpg -o $i.pdf < $i.html
######
gsutil -m cp $i.txt gs://the_pesticide_manual
gsutil -m cp $i.html gs://the_pesticide_manual
gsutil -m cp $i.pdf gs://the_pesticide_manual
gsutil -m cp $i.ready.jpg gs://the_pesticide_manual
######
rm $i.pdf
rm $i.txt
rm $i.html
rm $i.jpg
######
done
###########
done


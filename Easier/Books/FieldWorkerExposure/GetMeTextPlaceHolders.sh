rm *.html
rm *.svg
rm *.txt
rm *.pnm
rm *.pdf
rm *.jpg
rm RunLog

##Load the variables
targetbucket=(`cat TargetBucket`)
destinationbucket=(`cat DestinationBucket`)
gsutil mb $destinationbucket
##
gsutil -m ls $targetbucket/*.jpg | cut -d "/" -f5  > WorkList
touch DoneList
gsutil -m ls $destinationbucket/*.jpg | cut -d "/" -f5 | sed 's/.ready.jpg/.jpg/g'  > DoneList 
comm -3 WorkList DoneList > RemainderList
######
cat RemainderList | sed -n '/.*[02468]\.jpg/p' | sed 's/.jpg//g' > EvenWorkList
cat RemainderList | sed -n '/.*[13579]\.jpg/p' | sed 's/.jpg//g' > OddWorkList
######
cropeven=(`cat CropEven`)
cropodd=(`cat CropOdd`)
############
#Even Time##
############
remainder=(`cat EvenWorkList`)
############
for i in "${remainder[@]}"
do
######
targetbucket=(`cat TargetBucket`)
gsutil -m cp $targetbucket/$i.jpg .
echo $i >> RunLog
convert $i.jpg -crop $cropeven $i.crop.jpg 
convert -rotate -90 $i.crop.jpg $i.rotated.jpg
rm $i.crop.jpg
./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
rm $i.rotated.jpg
######
convert $i.ready.jpg $i.ready.pnm
potrace $i.ready.pnm -s
convert $i.ready.svg $i.ready.jpg
rm $i.ready.pnm
######
tesseract $i.ready.jpg $i
tesseract $i.ready.jpg $i hocr
hocr2pdf -i $i.ready.jpg -o $i.pdf < $i.html
######
gsutil -m cp $i.txt $destinationbucket
gsutil -m cp $i.html $destinationbucket
gsutil -m cp $i.pdf $destinationbucket
gsutil -m cp $i.ready.jpg $destinationbucket
gsutil -m cp $i.ready.svg $destinationbucket
######
rm $i.ready.jpg
rm $i.pdf
rm $i.txt
rm $i.html
rm $i.jpg
rm $i.ready.svg 
######
echo "##########"
echo "$i is done"
echo "##########"
######
done
############
#Odd Time###
############
remainder=(`cat OddWorkList`)
############
for i in "${remainder[@]}"
do
######
targetbucket=(`cat TargetBucket`)
gsutil -m cp $targetbucket/$i.jpg .
echo $i >> RunLog
convert $i.jpg -crop $cropodd $i.crop.jpg 
convert -rotate +90 $i.crop.jpg $i.rotated.jpg
rm $i.crop.jpg
./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
rm $i.rotated.jpg
######
convert $i.ready.jpg $i.ready.pnm
potrace $i.ready.pnm -s
convert $i.ready.svg $i.ready.jpg
rm $i.ready.pnm
######
tesseract $i.ready.jpg $i
tesseract $i.ready.jpg $i hocr
hocr2pdf -i $i.ready.jpg -o $i.pdf < $i.html
######
gsutil -m cp $i.txt $destinationbucket
gsutil -m cp $i.html $destinationbucket
gsutil -m cp $i.pdf $destinationbucket
gsutil -m cp $i.ready.jpg $destinationbucket
gsutil -m cp $i.ready.svg $destinationbucket
######
rm $i.ready.jpg
rm $i.pdf
rm $i.txt
rm $i.html
rm $i.jpg
rm $i.ready.svg 
######
echo "##########"
echo "$i is done"
echo "##########"
######
done
############
############
###########


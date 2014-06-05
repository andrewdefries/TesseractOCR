gsutil -m cp -R gs://books_batch4/ThePesticideManualLast .
###
##cp *.sh SecondaryMetabolism
##cd SecondaryMetabolism
###
############
############
ls *.jpg |  sed -n '/.*[02468]\.jpg/p' > Even
ls *.jpg |  sed -n '/.*[13579]\.jpg/p' > Odd
############
even=(`cat Even`)
odd=(`cat Odd`)
############
#
#
#
#
###########
###########
for i in "${even[@]}"
do
###########
#rotate, crop
#get values from imagej use record to see makeRectangle(608,56,3580,2668)
echo $i
convert $i -crop 3700x2696+248+132 $i.crop.jpg 
#rm $i

convert -rotate -90 $i.crop.jpg $i.rotated.jpg
rm $i.crop.jpg

#textcleaner
#./textcleaner.sh $i.rotated.jpg $i.ready.jpg
./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
rm $i.rotated.jpg

#tesseract time
tesseract $i.ready.jpg $i
tesseract $i.ready.jpg $i hocr
hocr2pdf -i $i.ready.jpg -o $i.pdf < $i.html

#
done
###########
###########
#
#
#
#
###########
###########
###########

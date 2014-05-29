gsutil -m ls gs://books_batch1 > Booklist

booklist=(`cat Booklist`)

for i in "$booklist"

do
###
echo "These are your books $i"
###
done

#######
#######
gsutil -m cp -R gs://books_batch1/ChemicalBiologyVol3/ .
###
#cp *.sh ChemicalBiologyVol2
cd ChemicalBiologyVol3
###
rm *.jpg.txt
rm *.jpg.pdf
rm *.jpg.html
rm *.ready.jpg
rm *.rotated.jpg
rm *.crop.jpg
############
ls |  sed -n '/.*[02468]\.jpg/p' > Even
ls |  sed -n '/.*[13579]\.jpg/p' > Odd
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
convert $i -crop 3840x2676+148+104 $i.crop.jpg 
#rm $i

convert -rotate 90 $i.crop.jpg $i.rotated.jpg
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
for i in "${odd[@]}"
do
###########
#rotate, crop
#get values from imagej use record to see makeRectangle(608,56,3580,2668)
echo $i
convert $i -crop 3952x2732+288+28 $i.crop.jpg 
rm $i
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

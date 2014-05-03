############
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
convert $i -crop 3580x2668+608+56 $i.crop.jpg 
convert -rotate -90 $i.crop.jpg $i.rotated.jpg
#textcleaner
#./textcleaner.sh $i.rotated.jpg $i.ready.jpg
./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
#tesseract time
tesseract $i.ready.jpg $i
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
convert $i -crop 3384x2652+736+200 $i.crop.jpg 
convert -rotate 90 $i.crop.jpg $i.rotated.jpg
#textcleaner
#./textcleaner.sh $i.rotated.jpg $i.ready.jpg
./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
#tesseract time
tesseract $i.ready.jpg $i
#   
done
###########
###########


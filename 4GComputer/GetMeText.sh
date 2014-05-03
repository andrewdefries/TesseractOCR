############
############
#gsutil cp -R gs://pesticides2crunch/PlantSubstances/Batch1 .
#gsutil cp -R gs://pesticides2crunch/SecondaryMetabolism .
###########
cp *.sh SecondaryMetabolism 
cd SecondaryMetabolism
###########
rm *.ready.jpg
rm *.rotated.jpg
rm *.crop.jpg
###########
ls | sed -n '/.*[02468]\.jpg/p' > Even
ls | sed -n '/.*[13579]\.jpg/p' > Odd
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
convert $i -crop 2948x1692+760+660 $i.crop.jpg 
rm $i
convert -rotate 90 $i.crop.jpg $i.rotated.jpg
rm  $i.crop.jpg
#textcleaner
./textcleaner.sh $i.rotated.jpg $i.ready.jpg
#./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
#tesseract time
rm $i.rotated.jpg
#rm $i.ready.jpg

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
convert $i -crop 3152x1864+520+496 $i.crop.jpg 
rm $i
convert -rotate -90 $i.crop.jpg $i.rotated.jpg
#textcleaner
./textcleaner.sh $i.rotated.jpg $i.ready.jpg
#./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
#tesseract time
tesseract $i.ready.jpg $i
#   
done
###########
###########


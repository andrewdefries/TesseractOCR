# save values in TesseractSpecsEven

# save values in TesseractSpecsOdd

#./CropVal.sh first
rm CropBatch.sh
touch CropBatch.sh

index=( "Even" "Odd" )

for i in "${index[@]}"

do

length=(`cat TesseractSpecs$i | wc -l`)
for ((j=1; j<=$length; j++))
do
Start=(`cat TesseractSpecs$i.Start | sed -n ${j}p`)
Stop=(`cat TesseractSpecs$i.Stop | sed -n ${j}p`)
CropVal=(`cat Crop$i | sed -n ${j}p`)

echo $Start
echo $Stop
echo $CropVal


for l in $(seq -f "%05g" $Start $Stop)
do
###
echo $i > go
value=$( grep -ic "Even" go)
if [ $value -eq 1 ]
then

#convert $i.jpg -crop $cropeven $i.crop.jpg 

echo $l | sed 's/^/img/' | sed 's/^/convert /' |  sed 's/$/.jpg -crop /' | sed -n '/.*[02468]\.jpg/p' | sed "s/$/$CropVal/" | sed "s/$/ img$l.crop.jpg/" >> CropBatch.sh

else

echo $l | sed 's/^/img/' | sed 's/^/convert /' |  sed 's/$/.jpg -crop /' | sed -n '/.*[13579]\.jpg/p' | sed "s/$/$CropVal/" | sed "s/$/ img$l.crop.jpg/" >> CropBatch.sh

fi
##
done


done
done

chmod +x CropBatch.sh

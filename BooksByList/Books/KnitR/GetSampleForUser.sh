targetbucket=(`cat TargetBucket`)


gsutil -m ls $targetbucket | shuf > ShuffledWorkList

######
cat ShuffledWorkList | sed -n '/.*[02468]\.jpg/p' | head -n 18 > EvenCropWorkList
cat ShuffledWorkList | sed -n '/.*[13579]\.jpg/p' |head -n 18 > OddCropWorkList
######

download4usereven=(`cat EvenCropWorkList`) 
download4userodd=(`cat OddCropWorkList`) 


####
####
mkdir Even2Crop
for m in "${download4usereven[@]}"

do
####
cd Even2Crop

gsutil -m cp $m .
echo "downloaded $m"
cd ..
####
done


####
####
mkdir Odd2Crop
for n in "${download4userodd[@]}" 

do
####
cd Odd2Crop

gsutil -m cp $n .
echo "downloaded $n"
cd ..
####
done


echo "Now save your crop values in TesseractSpecs"

##pico TesseractSpecs

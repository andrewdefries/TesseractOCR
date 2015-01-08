
######
ls *.crop.jpg | sed -n '/.*[02468]\.crop.jpg/p' | sed 's/.jpg//g' > EvenWorkList
ls *.crop.jpg | sed -n '/.*[13579]\.crop.jpg/p' | sed 's/.jpg//g' > OddWorkList
######
############
#Even Time##
############
remainder=(`cat EvenWorkList`)
############
for i in "${remainder[@]}"
do
######
convert -rotate -90 $i.jpg $i.rotated.jpg
echo "$i done"
######
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
convert -rotate +90 $i.jpg $i.rotated.jpg
echo "$i done"
######
done
############
############
###########

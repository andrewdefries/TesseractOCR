
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
##
######
convert $i.rotated.jpg $i.rotated.pnm
potrace $i.rotated.pnm -s
convert $i.rotated.svg $i.rotated.jpg
rm $i.rotated.pnm
######
tesseract $i.rotated.jpg $i
tesseract $i.rotated.jpg $i hocr
hocr2pdf -i $i.rotated.jpg -o $i.pdf < $i.html
######
##
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
######
convert $i.rotated.jpg $i.rotated.pnm
potrace $i.rotated.pnm -s
convert $i.rotated.svg $i.rotated.jpg
rm $i.rotated.pnm
######
tesseract $i.rotated.jpg $i
tesseract $i.rotated.jpg $i hocr
hocr2pdf -i $i.rotated.jpg -o $i.pdf < $i.html
######
echo "$i done"
######
done
############
############
###########

############
#Odd Time###
############
remainder=(`cat OddWorkList.ab`)
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
#convert $i.rotated.jpg -quality 5 $i.rotated.low.jpg
#hocr2pdf -i $i.rotated.low.jpg -o $i.pdf < $i.html
hocr2pdf -i $i.rotated.jpg -o $i.pdf < $i.hocr
######
echo "$i done"
######
done
############
############


for i in *.png 

do

convert $i -fill none -fuzz 5% -draw 'matte 0,0 floodfill' -flop  -draw 'matte 0,0 floodfill' -flop $i.backgroundcorrection.png

done

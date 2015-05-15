######
ls *.crop.jpg | sed -n '/.*[02468]\.crop.jpg/p' | sed 's/.jpg//g' > EvenWorkList
ls *.crop.jpg | sed -n '/.*[13579]\.crop.jpg/p' | sed 's/.jpg//g' > OddWorkList
######
split EvenWorkList -n 2
mv xaa EvenWorkList.aa
mv xab EvenWorkList.ab

split OddWorkList -n 2
mv xaa OddWorkList.aa 
mv xab OddWorkList.ab
##########
./Even.aa.sh & ./Odd.aa.sh & ./Even.ab.sh & ./Odd.ab.sh
echo "finished the ocr now"
###########
echo "writing the pdf now"

basename `pwd` > pdfname
Name=(`cat pdfname`)

gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=$Name.pdf -dBATCH *.pdf

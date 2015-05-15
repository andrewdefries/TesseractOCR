ls *.jpg | sed -n '/.*[02468]\.jpg/p' | sed 's/^/open(\"\/home\/chemdecisive\/Desktop\/OCR_Scripts\/HandbookOfPesticideToxicology\//g' | sed 's/$/\");/g' > EvenFijiList
ls *.jpg | sed -n '/.*[13579]\.jpg/p' | sed 's/^/open(\"\/home\/chemdecisive\/Desktop\/OCR_Scripts\/HandbookOfPesticideToxicology\//g' | sed 's/$/\");/g' > OddFijiList
 
var=(`cat EvenFijiList`)

for i in "${var[@]}"
do
echo $i
done

var=(`cat OddFijiList`)

for i in "${var[@]}"
do
echo $i
done

#split
split -l 44 EvenFijiList EvenFijiList.
split -l 44 OddFijiList OddFijiList.


echo "run(\"Record...\");" > opener
echo "run(\"Images to Stack\");" > closer

thelists=(`ls EvenFijiList.*`)
for i in "${thelists[@]}"
do
cat opener $i closer > tmp
mv tmp $i
done

thelists=(`ls OddFijiList.*`)
for i in "${thelists[@]}"
do
cat opener $i closer > tmp
mv tmp $i
done


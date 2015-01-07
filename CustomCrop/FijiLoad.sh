rm EvenOpenFiji.sh
rm OddOpenFiji.sh

touch EvenOpenFiji.sh
touch OddOpenFiji.sh


ls *.jpg | sed -n '/.*[02468]\.jpg/p' | sed 's/^/open(\"\/home\/cheminchi\/Desktop\/ReadHere\/OCR_4_DataMining\/AppliedDataMining\//g' | sed 's/$/\");/g' > EvenFijiList
ls *.jpg | sed -n '/.*[13579]\.jpg/p' | sed 's/^/open(\"\/home\/cheminchi\/Desktop\/ReadHere\/OCR_4_DataMining\/AppliedDataMining\//g' | sed 's/$/\");/g' > OddFijiList
 
var=(`cat EvenFijiList`)

for i in "${var[@]}"
do
echo $i
#printf "open(\"/home/cheminchi/Desktop/ReadHere/OCR_4_DataMining/AppliedDataMining/$i\");\"\n'  >> EvenOpenFiji.sh
done

var=(`cat OddFijiList`)

for i in "${var[@]}"
do
echo $i
#printf "\"open(\"/home/cheminchi/Desktop/ReadHere/OCR_4_DataMining/AppliedDataMining/$i\");\"\n'  >> OddOpenFiji.sh
done

#split

split -l 88 EvenFijiList EvenFijiList.
split -l 88 OddFijiList OddFijiList.

chmod +x EvenFijiList.*
chmod +x OddFijiList.*


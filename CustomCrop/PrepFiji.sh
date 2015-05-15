touch TesseractSpecsEven
echo "00000" > TesseractSpecsEven

touch TesseractSpecsOdd
echo "00001" > TesseractSpecsOdd

#basename `pwd` > workspace

pwd | sed 's/\//\\\//g' > workspace

workspace=(`cat workspace`)

cat FijiLoad.sh | sed "s/workspace/`echo $workspace`/g" > tmp

mv tmp FijiLoad.sh

chmod +x FijiLoad.sh


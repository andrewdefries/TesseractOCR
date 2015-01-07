index=( Even Odd )

for i in "${index[@]}"

do

cat TesseractSpecs$i | cut -c 1-5 > TesseractSpecs$i.Start
cat TesseractSpecs$i | cut -c 7-11 > TesseractSpecs$i.Stop

cat TesseractSpecs$i | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | cut -d "," -f3 |  sed 's/$/x/' > A
cat TesseractSpecs$i | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | cut -d "," -f4 |  sed 's/$/+/' > B
cat TesseractSpecs$i | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | cut -d "," -f2 > C
cat TesseractSpecs$i | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | cut -d "," -f1 |  sed 's/$/+/' > D


paste A B D C | sed 's/\t//g' | sed 's/ //g' > Crop$i

done



A=(`cat TesseractSpecs | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | cut -d "," -f3`)
B=(`cat TesseractSpecs | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | cut -d "," -f4`)
C=(`cat TesseractSpecs | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | cut -d "," -f2`)
D=(`cat TesseractSpecs | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | cut -d "," -f1`)

echo "${A}x${B}+${C}+${D}" > CropEven


##

A=(`cat TesseractSpecs | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | sed '1d' | cut -d "," -f3`)
B=(`cat TesseractSpecs | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | sed '1d' | cut -d "," -f4`)
C=(`cat TesseractSpecs | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | sed '1d' | cut -d "," -f2`)
D=(`cat TesseractSpecs | sed 's/.*[makeRectangle]//g' | sed 's/[();]//g' | sed '1d' | cut -d "," -f1`)

echo "${A}x${B}+${C}+${D}" > CropOdd


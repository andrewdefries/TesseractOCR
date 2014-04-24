gsutil cp gs://pesticides2crunch/diybookscanner/PesticideManual/Batch1/*.jpg .

for i in *.jpg


#
do
##
convert $i $i.png
tesseract $i.png $i.out
#tesseract $i.png $i.out hocr

##
done

echo "converted jpg to png"
##


#gsutil cp gs://pesticides2crunch/diybookscanner/PesticideManual/Batch1/*.jpg .

for i in *.png


#
do
##
#convert $i $i.png

tesseract $i $i.out
#tesseract $i.png $i.out hocr

##
done

echo "converted jpg to png"
##


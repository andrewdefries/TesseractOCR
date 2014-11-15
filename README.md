TesseractOCR
============

This repo documents full text extraction from archival photos of books using the Reetz book scanner (https://www.noisebridge.net/wiki/Bookscanner).

Tesseract is a freely available OCR software that can perform command line text extraction from images. Tesseract also has langauge support for multiple languages. 

See the Tesseract page for more info  https://code.google.com/p/tesseract-ocr/ 

Briefly, the workflow is as follows to extract text from high quality images:

Take pictures of source material, pre-process using imagemagick scripts (rotate, contrast, crop), input image to tesseract. 

You require a number of modules to get this workflow moving.

To build Tesseract working environment do
```
# tesseract dependencies
sudo apt-get install autoconf automake libtool
sudo apt-get install libpng12-dev
sudo apt-get install libjpeg62-dev
sudo apt-get install libtiff4-dev
sudo apt-get install zlib1g-dev
sudo apt-get install libicu-dev # (if you plan to make the training tools)
sudo apt-get install libleptonica-dev
sudo apt-get install tesseract-ocr

# otherwise install from source
wget http://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.01.eng.tar.gz
tar xf tesseract-ocr-3.01.eng.tar.gz

# imagemagick is a popular command line tool to perform image manipulations
sudo apt-get install imagemagick
sudo apt-get install graphicsmagick-libmagick-dev-compat
sudo apt-get install exactimage

# also copy to local the textcleaner.sh script
wget http://www.fmwconcepts.com/imagemagick/downloadcounter.php?scriptname=textcleaner&dirname=textcleaner

# consider getting potrace to make svg traces of images
 
```

A number of options are available to pre-process and determine the appropriate crop area. Here we use a combination of both gui and command line tools. The open source image editing tool FIJI or Fiji is Just Image J ( http://fiji.sc/wiki/index.php/Fiji) was used to determine the appropriate crop area. Since we were using tesseract locally and on the google cloud the gsutil tool was used to download a set of odd and even images for the user to determine a single crop box. The images were downloaded and the even indices where opened, made to stack, and a crop box was determined. The value was saved in a file.

GetSampleForUser.sh
```
targetbucket=(`cat TargetBucket`)

gsutil -m ls $targetbucket | shuf > ShuffledWorkList
######
cat ShuffledWorkList | sed -n '/.*[02468]\.jpg/p' | head -n 18 > EvenCropWorkList
cat ShuffledWorkList | sed -n '/.*[13579]\.jpg/p' |head -n 18 > OddCropWorkList
######
download4usereven=(`cat EvenCropWorkList`) 
download4userodd=(`cat OddCropWorkList`) 
######
# the download the files to local 
```

To crop the page to a specified area we supply imagemagick with command line options for the x and y bounding box to crop
```
cropeven=(`cat CropValue`)

convert input_image.jpg -crop $cropvalue outut_image.jpg
```

In our capture setup we used two digital cameras facing both the even and odd page for simultaneous page capture. This resulted in two images that required a rotation 90 degrees to the original page position. Imagemagick was used to rotate raw images.

```
# for odd pages
convert -rotate +90 input_image.jpg output_image.jpg

# for even pages
convert -rotate -90 input_image.jpg output_image.jpg

```

Tesseract takes the following command line options to convert an image to text
```
############
remainder=(`cat WorkList`)
############
for i in "${remainder[@]}"
do
######
targetbucket=(`cat TargetBucket`)
gsutil -m cp $targetbucket/$i.jpg .
echo $i >> RunLog
convert $i.jpg -crop $cropeven $i.crop.jpg 
convert -rotate -90 $i.crop.jpg $i.rotated.jpg
rm $i.crop.jpg
./textcleaner.sh -g -e stretch -f 25 -o 5 -s 1 $i.rotated.jpg $i.ready.jpg
rm $i.rotated.jpg
######
convert $i.ready.jpg $i.ready.pnm
potrace $i.ready.pnm -s
convert $i.ready.svg $i.ready.jpg
rm $i.ready.pnm
######
tesseract $i.ready.jpg $i
tesseract $i.ready.jpg $i hocr
hocr2pdf -i $i.ready.jpg -o $i.pdf < $i.html
######
```


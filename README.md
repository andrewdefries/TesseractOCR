TesseractOCR
============

Full text extraction using the Open Source Tesseract OCR software https://code.google.com/p/tesseract-ocr/ and imagemagick 

The workflow is as follows:

Take pictures of source material, pre-process using imagemagick scripts, feed to tesseract, use chemical dictionary to extract relevant textual information.

To build Tesseract working environment do:


sudo apt-get install autoconf automake libtool
sudo apt-get install libpng12-dev
sudo apt-get install libjpeg62-dev
sudo apt-get install libtiff4-dev
sudo apt-get install zlib1g-dev
sudo apt-get install libicu-dev # (if you plan to make the training tools)

sudo apt-get install libleptonica-dev

sudo apt-get install tesseract-ocr

wget http://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.01.eng.tar.gz

tar xf tesseract-ocr-3.01.eng.tar.gz

sudo apt-get install imagemagick

sudo apt-get install graphicsmagick-libmagick-dev-compat

sudo apt-get install exactimage

wget http://www.fmwconcepts.com/imagemagick/downloadcounter.php?scriptname=textcleaner&dirname=textcleaner

#Find work target
gsutil ls gs://pesticides2crunch/Local > WorkList

#Setup variable assignments
Work=(`cat WorkList`)

##
for i in "${WorkList[@]}"

do
########################
#Clean up names
cat $i | cut -c 30-60 | sed 's/[/]//g' > Book

Name=(`cat Book`)

#To use on google cloud
gsutil cp $i/*.jpg.pdf .

#local
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE="$Name" -dBATCH *.pdf

rm *.jpg.pdf

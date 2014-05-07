#Find work target
gsutil ls gs://pesticides2crunch/Local > WorkList

#Setup variable assignments
WorkList=(`cat WorkList`)

##
for i in "${WorkList[@]}"

do
########################
########################
#Clean up names
#cat $i | sed 's/gs:\///g' | cut -c 30-60 | sed 's/[/]//g' > Book
echo $i | cut -c 30-60 | sed 's/[/]/\.pdf/g' > Book

Name=(`cat Book`)

#To use on google cloud
gsutil cp $i*.jpg.pdf .

echo $i

#local
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE="$Name" -dBATCH *.pdf

rm *.jpg.pdf
############
echo "$Name"
###################
done

echo "Be sure to copy the books to gs://swap"

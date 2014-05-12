library(tm)


source_files <- list.files(recursive=TRUE, pattern = ".pdf")
render_files <- list.files(recursive=TRUE, pattern = ".txt")

##############################################
#load my corpus from folder
#other text files will be pulled in
##############################################

source <- DirSource(getwd()) #Be in Do if you want work done

MyCorpus <- Corpus(source, readerControl=list(reader=readPlain)) #load in documents


#get warnings and check

################################
#tm_map
#eliminate whitespace of corpus
################################

#NoWhite <-tm_map(MyCorpus, stripWhitespace) #whitespace

MyCorpus <-tm_map(MyCorpus, tolower) #Make lowerspace instance

#NoStop <- tm_map(MyCorpus, removeWords, stopwords("english"))

#Stemming <-tm_map(MyCorpus, stemDocument) #failed get java error


######################
#DocumentTermMatrix
######################

dtm <- DocumentTermMatrix(MyCorpus) 

d <-c("atrazine") ## Dictionary(c("aba", "abi1", "plants", "signalling", "abscisic", "stress", "pyrabactin", "hormone", "arabidopsis"))

refined<-inspect(DocumentTermMatrix(MyCorpus, list(dictionary = d)))

write.table(rownames(subset(refined,refined[,1]>=1)), file="Test.txt", quote=F)

system("cat Test.txt | cut -c 3-60 > ReadList")




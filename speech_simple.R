libs <- c("tm", "plyr", "class", "SnowballC")
lapply(libs, require, character.only=TRUE)
options(stringsAsFactors = TRUE)

#set your working directory using setwd('[path]') or going to Session > Set Working Directory > Choose Directory

#create a Corpus
docs <- Corpus(DirSource(getwd()))

#create a function for removing special characters
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))

#apply a function for removing special characters
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

#further cleanup
docs <- tm_map(docs, content_transformer(removePunctuation))
docs <- tm_map(docs, content_transformer(stripWhitespace))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, content_transformer(removeNumbers))
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, stemDocument)


#Create a Document Term Matrix
dtm <- DocumentTermMatrix(docs)

tdm <- TermDocumentMatrix(docs)



#See the term frequencies
freq_tdm <- colSums(as.matrix(tdm))
ord_tdm <- order(freq_tdm)
freq_tdm[head(ord_tdm)]

#most frequent terms
freq[tail(ord_tdm)]

#frequency of frequencies
head(table(freq_tdm), 15)
tail(table(freq_tdm), 15)

#dtm
#See the term frequencies
freq_dtm <- colSums(as.matrix(dtm))
ord_dtm <- order(freq_dtm)
freq_dtm[head(ord_dtm)]

#most frequent terms
freq_dtm[tail(ord_dtm)]

#frequency of frequencies
head(table(freq_dtm), 15)
tail(table(freq_dtm), 15)

#Difference between TermDocumentMatrix and DocumentTermMatrix
str(tdm)
str(dtm)

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
tdm <- TermDocumentMatrix(docs)

#See the term frequencies
freq <- colSums(as.matrix(tdm))
ord <- order(freq)
freq[head(ord)]

#most frequent terms
freq[tail(ord)]

#frequency of frequencies
head(table(freq), 15)
tail(table(freq), 15)


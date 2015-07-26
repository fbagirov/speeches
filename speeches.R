#initialize
libs <- c("tm", "plyr", "class")
lapply(libs, require, character.only=TRUE)
options(stringsAsFactors = FALSE)
candidates <- c("bush_gw","obama_gw")
pathname <- '/Users/feyzi/Dropbox/03_1-Online Teaching/2-UMUC/2015-2Summer/DATA630-9020-20150518-20150809-2190-(Les Pang)/WEBEX/20150724-Anomaly Detection and Text Mining/Text Mining/speeches'

#Clean the text
cleanCorpus <- function(corpus) {
  corpus.tmp <- tm_map(corpus, removePunctuation)
  corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
  corpus.tmp <- tm_map(corpus.tmp, tolower)
  corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords(kind = "english"))
  return(corpus.tmp)
}

#Build a candidate matrix for two candidates and attach name
generateTDM <- function(cand, path) {
  s.dir <- sprintf("%s/%s", path, cand)
  #for Mac, use 'UTF-8', for Windows, use 'ANSI'
  s.cor <- Corpus(DirSource(directory = s.dir, encoding = 'UTF-8'))
  s.cor.cl <- cleanCorpus(s.cor)
  s.tdm <- TermDocumentMatrix(s.cor.cl)
  s.tdm <- removeSparseTerms(s.tdm, 0.7)
  result <- list(name = cand, tdm = s.tdm)
}

tdm <- lapply(candidates, generateTDM, path = pathname)


install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)
install.packages("wordcloud2")
library(wordcloud2)

install.packages("SnowballC")
library(SnowballC)
install.packages("tm")
library(tm)

worldcl
#Create a vector containing only the text
text <- (content_review %>% filter(length(text) > 0))$text
# Create a corpus  
docs <- Corpus(VectorSource(text))

docs <- docs %>%
  tm_map(tolower) %>%
  #tm_map(PlainTextDocument) %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
#docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, stopwords("english"))

###
dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)
###
set.seed(1234) # for reproducibility 
wordcloud(words = df$word, freq = df$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35,            
          colors=brewer.pal(8, "Dark2"))


lwords <- c('bank', 'branch', 'hsbc', 'france', 'banks', 'years', 'one', 'customer', 'customers', 'people', 'can', 'day', 'days', 'banking',
'several', 'case', 'took', 'almos', 'asked', 'agency', 'answer', 'make', 'another', 'thank', 'number' , 'account', 'really', 'will',
 'always','lot', 'without', 'just', 'french', 'work', 'money', 'open', 'time', 'still', 'since', 'even', 'now', 'also',
  'especially', 'dont')


docs2 <- tm_map(docs, removeWords, lwords)

###
dtm2 <- TermDocumentMatrix(docs2) 
matrix2 <- as.matrix(dtm2) 
words2 <- sort(rowSums(matrix2),decreasing=TRUE) 
df2 <- data.frame(word = names(words2),freq=words2)
###
set.seed(1234) # for reproducibility 
wordcloud(words = df2$word, freq = df2$freq, min.freq = 1,
          max.words=100, random.order=FALSE, rot.per=0.35,            
          colors=brewer.pal(8, "Dark2"))

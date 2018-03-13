####### #Bitcoin Tweets Mining app was created 



#### Use the youtube video to follow https://www.youtube.com/watch?v=qWmMKmPVtgk

#Use the youtube video to follow part 2: https://www.youtube.com/watch?v=jk8e6RQGzqw


#### https://twitter.com/BitcoinTweets website url

###Consumer Key (API Key)	e8snPvrnYPRxLlD3q9cGgSB7v
#Consumer Secret (API Secret)	ZXeixJRMBKwOaWpjx0tdV4oj9oK8wEwgFe8Z7ykvEtJOOnS4Tx
#Access Level	Read and write (modify app permissions)
#Owner	gebanks90
#Owner ID	343070505

#Access Token	343070505-L45mKFbmUdivLwRCrBqVOZS0i53AEo50InU4ucuD
#Access Token Secret	li7JTCCX6VRRhwgzeRg5WFP3aetdPykDxDP5Ww9fgMR26
#Access Level	Read and write
#Owner	gebanks90
#Owner ID	343070505

api_key <- "e8snPvrnYPRxLlD3q9cGgSB7v"
api_secret <- "ZXeixJRMBKwOaWpjx0tdV4oj9oK8wEwgFe8Z7ykvEtJOOnS4Tx"
access_token <- "343070505-L45mKFbmUdivLwRCrBqVOZS0i53AEo50InU4ucuD"
access_token_secret <- 'li7JTCCX6VRRhwgzeRg5WFP3aetdPykDxDP5Ww9fgMR26'

library(readr)

# Install packages twitteR, tm, wordcloud


#load Library twitteR
library(twitteR)
library(wordcloud)
library(tm)
library(SnowballC)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)



#Getting Bitcoin Tweets



after.res.tweet.6   <- searchTwitter("My + resolution ", n = 5000, lang = 'en', since = '2018-01-28', until = '2018-01-29', resultType = "mixed")





after.res.tweet.7   <- searchTwitter("My + resolution ", n = 5000, lang = 'en', since = '2018-01-29', until = '2018-01-30', resultType = "mixed")

after.res.tweet.8   <- searchTwitter("My + resolution ", n = 5000, lang = 'en', since = '2018-01-30', until = '2018-01-31', resultType = "mixed")

after.res.tweet.9   <- searchTwitter("My + resolution ", n = 5000, lang = 'en', since = '2018-01-31', until = '2018-02-01', resultType = "mixed")




after.res.tweet.10   <- searchTwitter("My + resolution ", n = 5000, lang = 'en', since = '2018-02-01', until = '2018-02-02', resultType = "mixed")

after.res.tweet.11   <- searchTwitter("My + resolution ", n = 5000, lang = 'en', since = '2018-02-02', until = '2018-02-03', resultType = "mixed")

after.res.tweet.12   <- searchTwitter("My + resolution ", n = 5000, lang = 'en', since = '2018-02-03', until = '2018-02-04', resultType = "mixed")









res.tweet.3 <- twListToDF(c(after.res.tweet.6,after.res.tweet.7,after.res.tweet.8,after.res.tweet.9, after.res.tweet.10,after.res.tweet.11,after.res.tweet.12))
#head(af.tweet.1, n = 10)
#str(af.tweet.1)

write.csv(res.tweet.3, file =  "resolutions_dummy3.csv")

res.df <- read_csv("resolutions_dummy.csv")

res.df2 <- read_csv("resolutions_dummy2.csv")

res.df3 <- read_csv("resolutions_dummy3.csv")


res.tweetdf <- rbind(res.df,res.df2, res.df3)

############################################################################################


## Cleaning the text

res.tweetdf$text <- gsub("[^0-9A-Za-z///' ]", "  ",res.tweetdf$text)
#### remove http link
res.tweetdf$text <- gsub("http\\w+", " ",res.tweetdf$text)
#### remove rt
res.tweetdf$text <- gsub("rt ", "  ",res.tweetdf$text)
### remove at
res.tweetdf$text <- gsub("@\\w+", " ",res.tweetdf$text)

res.tweetdf$text <- tolower(res.tweetdf$text)

res.text.tweet <- subset(res.tweetdf, isRetweet == FALSE)


res.text.tweet <- res.text.tweet$text

#######
tweet.Corpus <- VCorpus(VectorSource(res.text.tweet))
#tweet.Corpus <- tm_map(tweet.Corpus, removeWords, stopwords())

#remove_url <- function(x) gsub("http[^[:space:]]*"," ",x)
#tweet.Corpus <- tm_map(tweet.Corpus, content_transformer(remove_url))


##### remove anything other than english letters and space

#removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*"," ",x)
#tweet.Corpus <- tm_map(tweet.Corpus, content_transformer(removeNumPunct))
tweet.Corpus <- tm_map(tweet.Corpus, removePunctuation)
tweet.Corpus <- tm_map(tweet.Corpus, content_transformer(tolower))
tweet.Corpus <- tm_map(tweet.Corpus, stripWhitespace)
Corpus.copy <- tweet.Corpus


#tweet.Corpus <- tm_map(tweet.Corpus, stemDocument)   ### if stemDocument doesn't run, install the package 'SnowballC'
#tweet.Corpus <- tm_map(tweet.Corpus, stemCompletion, dictionary = Corpus.copy)

myStopWords <- c("resolution", "2018", "2017", "my", "new", "years", "resolut", stopwords("en"),"amp", "lindseyytcrain", "morganwarn", "melindataub")
tweet.Corpus <-tm_map(tweet.Corpus, removeWords,myStopWords)


####create DocumentTermMatrix

tweet.dtm<- DocumentTermMatrix(tweet.Corpus)


#tweet.dtm <- TermDocumentMatrix(tweet.Corpus)

tweet.matrix <- as.matrix(tweet.dtm)


freq <- colSums(as.matrix(tweet.dtm)) 




library(wordcloud)
dark2 <- brewer.pal(6, "Dark2")
wordcloud(names(freq), freq, min.freq = 25, rot.per=0.2, colors=dark2) 

#wordcloud(tweet.Corpus, min.freq = 25, random.order = F)

library(qdap)

word_associate(res.text.tweet$text, match.string = c("resolution"), 
               stopwords = c(Top200Words, "chardonnay", "amp","lindseyytcrain", "morganwarn", "melindataub"), 
               network.plot = TRUE, cloud.colors = c("gray85", "darkred"))




###############################################################################################################################


### import package "sentimentr"
library(sentimentr)

res.tweetdf$text <- gsub("[^0-9A-Za-z///' ]", "  ",res.tweetdf$text)
#### remove http link
res.tweetdf$text <- gsub("http\\w+", " ",res.tweetdf$text)
#### remove rt
res.tweetdf$text <- gsub("rt", "  ",res.tweetdf$text)
### remove at
res.tweetdf$text <- gsub("@\\w+", "",res.tweetdf$text)

res.tweetdf$text <- tolower(res.tweetdf$text)


emo_res_tweets <- sentiment(res.text.tweet)
View(emo_res_tweets)


res.tweetdf$sentiment <- emo_res_tweets$sentiment  ## attaching the sentiment measure to every tweet
View(res.tweetdf)


### grabbing positive tweets, sample of 300

positive_tweets <- head(unique(res.tweetdf[order(emo_res_tweets$sentiment, decreasing = T),c(1,2) ] ) ,1000)
head(positive_tweets$text)

#grabbing negative tweets
negative_tweets <- head(unique(res.tweetdf[order(emo_res_tweets$sentiment, decreasing = F),c(1,2)]),1000)
head(negative_tweets$text)

# creating a table to create a wordcloud
write.table(positive_tweets$text, file = "/Users/georgesericcolbert/Desktop/Fall 2017/Data Mining-758T/NYProj/WordCloud/positiveres.txt",sep = " ")
write.table(negative_tweets$text, file = "/Users/georgesericcolbert/Desktop/Fall 2017/Data Mining-758T/NYProj/WordCloud/negativeres.txt",sep = " ")

#### 
library(tm)
tweet.Corpus.2 <- Corpus(DirSource(directory = "/Users/georgesericcolbert/Desktop/Fall 2017/Data Mining-758T/NYProj/WordCloud"))
summary(tweet.Corpus.2)

library(tm)

clean.tweet.Corpus.2 <- tm_map(tweet.Corpus.2, tolower)
clean.tweet.Corpus.2 <- tm_map(clean.tweet.Corpus.2, removeWords, stopwords())
clean.tweet.Corpus.2 <- tm_map(clean.tweet.Corpus.2, content_transformer(removeNumPunct))
clean.tweet.Corpus.2 <- tm_map(clean.tweet.Corpus.2, removePunctuation)
clean.tweet.Corpus.2 <- tm_map(clean.tweet.Corpus.2, stripWhitespace)
clean.tweet.Corpus.2 <- tm_map(clean.tweet.Corpus.2, stemDocument) 
clean.tweet.Corpus.2 <- tm_map(clean.tweet.Corpus.2, removeWords, myStopWords)

###### TermDocumentMatrix and DocumentTermMatrix do the same thing
tc2_tdm <- TermDocumentMatrix(clean.tweet.Corpus.2)

tc2_matrix <- as.matrix(tc2_tdm)

colnames(tc2_matrix) <- c("negative Tweets", "Postive Tweets")
comparison.cloud(tc2_matrix, max.words = 70, random.order = FALSE)









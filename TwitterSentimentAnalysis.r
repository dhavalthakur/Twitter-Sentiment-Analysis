#This is a R script to do Sentiment Analysis of Twitter accounts.
library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")
##############################
library("RGtk2")
consumer_key <- 'used the key provided by Twitter '
consumer_secret <- 'used the key provided by Twitter '
access_token <- 'used the key provided by Twitter '
access_secret <- 'used the key provided by Twitter '
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tweets <- userTimeline("narendramodi", n=200)
n.tweet <- length(tweets)
tweets.df <- twListToDF(tweets) 
head(tweets.df)
#moving hashtag , urls and other special charactersR
tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
tweets.df2 <- gsub("@.*","",tweets.df2)
head(tweets.df2)
#Getting Sentiment defining words
word.df <- as.vector(tweets.df2)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweets.df2, emotion.df) 
head(emotion.df2)
#Now we would extract  positive sentiment score
sent.value <- get_sentiment(word.df)
most.positive <- word.df[sent.value == max(sent.value)]
most.positive
#Now we would extract negative sentiment score
most.negative <- word.df[sent.value <= min(sent.value)]
most.negative 
#Extracting positive tweets
positive.tweets <- word.df[sent.value > 0]
head(positive.tweets)
#Extracting negative tweets
negative.tweets <- word.df[sent.value<0]
head(negative.tweets)
#Extracting Neutral Tweets
neutral.tweets <- word.df[sent.value ==0]
head(neutral.tweets)
#Alternate way so that we can display a small table for category of sentiments
category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
table(category_senti)
plot(table(category_senti), main="Twitter Sentiments")



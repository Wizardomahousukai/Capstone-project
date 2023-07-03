#Load libraries
library(shiny)
library(shiny)
library(tm)
library(data.table)


#load the data
load("projectdata.Rdata")


#What the predicted word is
word_predict <- function(sentence, n = 12){
  
  #text cleaning
  sentence <- tolower(removePunctuation(removeNumbers(sentence)))
  
  #split data
  words <- unlist(strsplit(sentence, split = " "))
  
  #last 5 words are the possible outcomes
  words <- tail(words, 5)
  
  word1 <- words[1]
  word2 <- words[2]

  
  df <- data.table()
  
  
  
  if (nrow(df)==0 & !is.na(word2)) {
    if(nrow(df) == 0) df <- subset(ngram3, w1==word1 & w2==word2)
    if(nrow(df) == 0) df <- subset(ngram2, w1==word2)
  }
  
  if (nrow(df)==0 & !is.na(word1)) {
    if(nrow(df) == 0) df <- subset(ngram2, w1==word1)
    if(nrow(df) == 0) df <- head(ngram1)
  }
  
  if(nrow(df) > 0){
    df$freq <- df$count / sum(df$count)
    output <- as.data.frame(head(df[order(-freq)], min(n, nrow(df))))
    output$count <- NULL
    output$freq <- NULL
    colnames(output) <- NULL
    output
  }
  
}


##What the server does

shinyServer(function(input, output) {
  
  ##Print the sentence
  output$prediction <- renderPrint({
    sentence <- input$sentence
    n <- input$n
    
    word_predict(sentence, n)
  })
  
})

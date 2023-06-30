library(shiny)
library(shiny)
library(tm)
library(data.table)


#load the data
load("C:/Users/Dell/Desktop/Data/projectdata.Rdata")

#function for predicting the next word
#it searches for matching n-grams and
#returns the top suggestions ranked by frequency
word_predict <- function(sentence, n = 12){
  
  #clean the text
  sentence <- tolower(removePunctuation(removeNumbers(sentence)))
  
  #splits the cleaned sentence into individual words and stores them in the words variable
  words <- unlist(strsplit(sentence, split = " "))
  
  #selects the last five words from the words variable
  words <- tail(words,2)
  
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

#logic of the server:
shinyServer(function(input, output) {
  
  # Predict next words
  output$prediction <- renderPrint({
    sentence <- input$sentence
    n <- input$n
    
    word_predict(sentence, n)
  })
  
})

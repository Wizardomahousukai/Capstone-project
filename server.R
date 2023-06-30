library(shiny)

source("C:/Users/Dell/Desktop/SBO.R")

load("t.rda")

t <- sbo_predtable(object = t.rda, # preloaded example dataset
                   N = 3, # Train a 3-gram model
                   dict = target ~ 0.75, # cover 75% of training corpus
                   .preprocess = sbo::preprocess, # Preprocessing transformation 
                   EOS = ".?!:;", # End-Of-Sentence tokens
                   lambda = 0.4, # Back-off penalization in SBO algorithm
                   L = 3L, # Number of predictions for input
                   filtered = "<UNK>" # Exclude the <UNK> token from predictions
)

p <- sbo_predictor(t)


shinyServer(
  function(input, output) {
    output$top1 = renderPrint({
      isolate(p(input$text1))
    })
    
  }
)

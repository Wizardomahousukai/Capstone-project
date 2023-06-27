library(shiny)

install.packages("sbo")
library(sbo)

head(sbo::twitter_train, 3)

word <- sbo_predictor(object = sbo::twitter_train, # preloaded example dataset
                      N = 3, # Train a 3-gram model
                      dict = target ~ 0.75, # cover 75% of training corpus
                      .preprocess = sbo::preprocess, # Preprocessing transformation 
                      EOS = ".?!:;", # End-Of-Sentence tokens
                      lambda = 0.4, # Back-off penalization in SBO algorithm
                      L = 3L, # Number of predictions for input
                      filtered = "<UNK>" # Exclude the <UNK> token from predictions
)

predictedword <- predict(word,"i love")

# Define server logic required to draw a histogram
function(input, output, session) {

    output$distPlot <- predictedword

}

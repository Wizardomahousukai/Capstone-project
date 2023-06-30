library(sbo)
head(sbo::twitter_train, 3)

p <- sbo_predictor(object = sbo::twitter_train, # preloaded example dataset
                   N = 3, # Train a 3-gram model
                   dict = target ~ 0.75, # cover 75% of training corpus
                   .preprocess = sbo::preprocess, # Preprocessing transformation 
                   EOS = ".?!:;", # End-Of-Sentence tokens
                   lambda = 0.4, # Back-off penalization in SBO algorithm
                   L = 3L, # Number of predictions for input
                   filtered = "<UNK>" # Exclude the <UNK> token from predictions
)

predict(p, "i love")

set.seed(840)
babble(p)

babble(p)

babble(p)

t <- sbo_predtable(object = sbo::twitter_train, # preloaded example dataset
                   N = 3, # Train a 3-gram model
                   dict = target ~ 0.75, # cover 75% of training corpus
                   .preprocess = sbo::preprocess, # Preprocessing transformation 
                   EOS = ".?!:;", # End-Of-Sentence tokens
                   lambda = 0.4, # Back-off penalization in SBO algorithm
                   L = 3L, # Number of predictions for input
                   filtered = "<UNK>" # Exclude the <UNK> token from predictions
)


p <- sbo_predictor(t) # This is the same as 'p' created above

save(t)
# ... and, in another session:
load("t.rda")

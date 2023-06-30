library(shiny)

library(tm)

CapstoneURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

download.file(CapstoneURL,destfile = "./Coursera-SwiftKey.zip",method = "curl")

unzip("./Coursera-SwiftKey.zip")

writtennews <- readLines("./final/en_US/en_US.news.txt", encoding = "UTF-8", skipNul=TRUE)

Writtenblogs <- readLines("./final/en_US/en_US.blogs.txt", encoding = "UTF-8", skipNul=TRUE)

Twitterposts <- readLines("./final/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul=TRUE)

newsCon <- file("./final/en_US/en_US.news.txt", open = "rb")


##Create the sample

linesinnews <- length(writtennews)

linesinposts <- length(Twitterposts)

linesinblogs <- length(Writtenblogs)

set.seed(10000)
sampleblogs <- sample(writtennews, length(linesinnews)*0.01)

sample_news <- sample(Writtenblogs, length(Writtenblogs)*0.01)

sample_twitter <- sample(Twitterposts, length(Twitterposts)*0.01)

Sample_combi=c(sampleblogs,sample_news,sample_twitter)


pre <- function(str,n){
  vs <- VectorSource(str)
  fp <- VCorpus(vs, readerControl = list(reader = readPlain, language = "en",load=TRUE))

  
  content <- fp$content[[1]]
  temp <- tail(unlist(strsplit(content,split=" ")),n)
  return(paste(temp,collapse =" "))
  
}

aboveword <- function(str,n){
  tail1 <- Twitterposts[grep(paste("^",pre(str,1)," ",sep=""),names(Twitterposts))]
  topn <- names(sort(tail1,decreasing = T))[1:n]
  sapply(strsplit(topn ,split=" "),function(x) x[2])
}



shinyServer(
  function(input, output) {
      output$topn = renderPrint({
      isolate(aboveword(input$text1,input$n))
    })
    
      output$top1 = renderPrint({
      isolate(aboveword(input$text1,1))
    })
    
  }
)

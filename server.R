library(shiny)

library(tm)

CapstoneURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

download.file(CapstoneURL,destfile = "./Coursera-SwiftKey.zip",method = "curl")

unzip("./Coursera-SwiftKey.zip")


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

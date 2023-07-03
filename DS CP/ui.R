library(shiny)

# Define UI for application
ui <- fluidPage(
  titlePanel('Type a word below and Joel will tell you the next word'),
  sidebarLayout(
    sidebarPanel(
      textInput('sentence', 'your next word is'),
    ),
    mainPanel(
      h4('The most predicted words are'),
      verbatimTextOutput('prediction')
    )
  )
)

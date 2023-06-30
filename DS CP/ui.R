library(shiny)

# Define UI for application
ui <- fluidPage(
  titlePanel('Type a word below prediction by Joel'),
  sidebarLayout(
    sidebarPanel(
      textInput('sentence', 'What will your sentence be'),
    ),
    mainPanel(
      h4('The most predicted words are'),
      verbatimTextOutput('prediction')
    )
  )
)
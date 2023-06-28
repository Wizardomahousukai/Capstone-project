#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# load shiny package
library(shiny)
# begin shiny UI
shinyUI(pageWithSidebar(
  headerPanel("Smart prediction technology for easier mobile typing by Joel Seah"),
  sidebarPanel(
    textInput(inputId="text1", label = "Please enter some words"),
  ),
  mainPanel(
    h3('Prediction result'),
    h4('Show the top n most likely words'),
    verbatimTextOutput("topn"),
    h4('Prediction result of the next word'),
    verbatimTextOutput("top1")
    
  )
))

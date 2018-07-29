
library(mxnet)
library(imager)
library(shiny)
library(jpeg)
library(OpenImageR)

shinyUI(pageWithSidebar(
  headerPanel(title = 'Image Classification',
              windowTitle = 'Image Classification'),
  sidebarPanel(
    includeCSS('css/boot.css'),
    fileInput('file', 'Upload a JPEG File:')
  ),
  mainPanel(
    h3("Image"),
    tags$hr(),
    plotOutput("originImage", height = 224, width = 224),
    tags$hr(),
    h3("What is it?"),
    tags$hr(),
    verbatimTextOutput("prediction")
  )
))

library(mxnet)
library(imager)
library(shiny)
library(jpeg)
library(OpenImageR)

function(input, output, session) {
  
  Image <- reactive({
    if (is.null(input$file)) {
      img <- readJPEG(source = "image/cat.jpg")
    } else {
      img <- readJPEG(source = input$file$datapath)
    }
    img <- resizeImage(image = img, width = 224, height = 224, method = "bilinear")
    img <- (img - min(img))/(max(img) - min(img))
    return(img)
  })
  
  output$originImage <- renderPlot({
    img <- Image()
    if (is.null(img)) {
      return()
    } else {
      par(mar = rep(0, 4))
      plot(NA, xlim = c(0.04, 0.96), ylim = c(0.96, 0.04), xaxt = "n", yaxt = "n", bty = "n")
      rasterImage(img, 0, 1, 1, 0, interpolate = FALSE)
    }
  })
  
  AI_pred <- reactive({
    img <- Image()
    if (is.null(img)) {
      return()
    } else {
      img <- preprocessing(img)
      pred_prob <- mxnet:::predict.MXFeedForwardModel(model = my_model, X = img)
      pred_prob <- as.numeric(pred_prob)
      names(pred_prob) <- synsets
      pred_prob <- sort(pred_prob, decreasing = TRUE)
      pred_prob <- formatC(pred_prob, 4, format = 'f')
      return(pred_prob)
    }
  })
  
  output$prediction <- renderPrint({
    ai_pred <- AI_pred()
    if (is.null(ai_pred)) {
      return()
    } else {
      head(ai_pred, 5)
    }
  })
  
}
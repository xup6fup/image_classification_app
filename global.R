
library(mxnet)
library(OpenImageR)

# 1. Load well-trained model

my_model <- mx.model.load(prefix = 'model/Inception-BN', iteration = 126)

# Download from http://data.dmlc.ml/models/imagenet/

# 2. Load label list

synsets <- readLines("model/chinese synset.txt")

# 3. Custom preprocess function

preprocessing <- function (img) {
  
  img <- img * 255
  img <- img - mean(img)
  dim(img) <- c(dim(img), 1)
  return(img)
  
}


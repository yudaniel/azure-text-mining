# Map 1-based optional input ports to variables
dataset1 <- maml.mapInputPort(1) # class: data.frame

#  get the label and text columns from the first input data set
text_column <- dataset1[,"text_column"]
label_column <- dataset1[,"label_column"]

# Load the R script from the Zip port in ./src/
source("src/text.preprocessing.R");

drawWordCloud(text_column, label_column, maxWords=50)

data.set <- dataset1
# Select data.frame to be sent to the output Dataset port
maml.mapOutputPort("data.set")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Please determine the required text preprocessing steps using the following flag
replace_special_chars <- TRUE
remove_duplicate_chars <- TRUE
replace_numbers <- TRUE
convert_to_lower_case <- TRUE
remove_default_stopWords <- FALSE
remove_given_stopWords <- TRUE
stem_words <- TRUE
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Map 1-based optional input ports to variables
dataset1 <- maml.mapInputPort(1) # class: data.frame
# get the label and text columns from the input data set
text_column <- dataset1[["text_column"]]
label_column <- dataset1[["label_column"]]

stopword_list <- NULL
result <- tryCatch({
   dataset2 <- maml.mapInputPort(2) # class: data.frame
   # get the stopword list from the second input data set
   stopword_list <- dataset2[[1]]
}, warning = function(war) {
   # warning handler
   print(paste("WARNING: ", war))
}, error = function(err) {
   # error handler
   print(paste("ERROR: ", err))
   stopword_list <- NULL
}, finally = {})

# Load the R script from the Zip port in ./src/
source("src/text.preprocessing.R");

text_column <- preprocessText(text_column,
                         replace_special_chars,
                         remove_duplicate_chars,
                         replace_numbers,
                         convert_to_lower_case,
                         remove_default_stopWords,
                         remove_given_stopWords,
                         stem_words,
                         stopword_list)

data.set <- data.frame(
                label_column,
                text_column,
                stringsAsFactors = FALSE
                )

# Select data.frame to be sent to the output Dataset port
maml.mapOutputPort("data.set")

###################################################
### Preparation of the Environment ####

# Clear environment
remove(list = ls())

# Create list with needed libraries
pkgs <- c("readr", "dplyr", "reticulate", "ggplot2", "Metrics","styler","tidyverse","rsample")

# Load each listed library and check if it is installed and install if necessary
for (pkg in pkgs) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}




###################################################
### Data Import ####

# Reading the data file
file_path <- file.path(getwd(), "0_DataPreparation/geordnet/Data.csv")
data <- read.csv(file_path)
names(data)

set_na_to_zero <- function(data, columns) {
  for (col in columns) {
    data[[col]][is.na(data[[col]])] <- 0
  }
  return(data)
}
#,"id", "Jahreszeit", "Fussballspiel", "Ferien"
columns_to_set_zero <- c(
  "Warengruppe", "Umsatz","Temperatur" ,"Bewoelkung","Windgeschwindigkeit",
  "Feiertag","id", "Jahreszeit", "Fussballspiel", "Ferien", "Temperaturkategorie",
  "KielerWoche", "Wochentag", "Flohmarkt" , "Kreuzfahrtschiffe", "Wettercode"
)

data <- set_na_to_zero(data, columns_to_set_zero)
data <- data %>%
  filter(Datum >= as.Date("2013-07-01") & Datum <= as.Date("2019-07-31"))




###################################################
### Data Preparation ####

# Preparation of independent variables ('features') by dummy coding the categorical variables
features <- as_tibble(model.matrix(Umsatz ~ Wettercode + Bewoelkung + Windgeschwindigkeit + Temperatur + as.factor(Jahreszeit) + as.factor(Temperaturkategorie) + as.factor(Warengruppe) + Fussballspiel + Ferien + Feiertag  + KielerWoche + as.factor(Wochentag) + Flohmarkt + Kreuzfahrtschiffe + Handballspiele + Diff_wind  + Diff_temp,data))
names(features)
features <- cbind(features, Datum =data$Datum , id=data$id )

# Construction of prepared data set
prepared_data <- tibble(label=data$Umsatz, features) %>%  # inclusion of the dependent variable ('label')
  filter(complete.cases(.)) # Handling of missing values (here: only keeping rows without missing values)




###################################################
### Selection of Training, Validation and Test Data ####
# Assuming your data is in the data frame 'ourdata_fussball'
# and the prepared data is in 'prepared_data'

# Train dataset (01.07.2013 to 31.07.2017)
train_data <- prepared_data %>%
  filter(Datum >= as.Date("2013-07-01") & Datum <= as.Date("2018-07-31"))

# Validation dataset (01.08.2017 to 31.07.2018)
#valid_data <- prepared_data %>%
#  filter(Datum >= as.Date("2017-08-01") & Datum <= as.Date("2018-07-31"))

# Test dataset (01.08.2018 and onwards, assuming you want the remaining data for testing)
test_data <- prepared_data %>%
  filter(Datum >= as.Date("2018-08-01"))

# Extract features and labels for training
training_features <- select(train_data, -c(label,id, Datum))
training_labels <- select(train_data, label)

# Extract features and labels for validation
#validation_features <- select(valid_data, -c(label,id, Datum))
#validation_labels <- select(valid_data, label)

# Extract features and labels for test
test_features <- select(test_data, -c(label, Datum))
test_labels <- select(test_data, label)



# Check the number of rows in each dataset
nrow_train <- nrow(training_features)
#nrow_valid <- nrow(validation_features)
nrow_test <- nrow(test_features)

# Print the number of rows in each dataset
cat("Number of rows in training dataset:", nrow_train, "\n")
#cat("Number of rows in validation dataset:", nrow_valid, "\n")
cat("Number of rows in test dataset:", nrow_test, "\n")

# Check the dimensions of the dataframes
cat("Training features dimensions:", dim(training_features), "\n")
#cat("Validation features dimensions:",
   # dim(validation_features), "\n")
cat("Test features dimensions:", dim(test_features), "\n")
cat("\n")
cat("Training labels dimensions:", dim(training_labels), "\n")
#cat("Validation labels dimensions:", dim(validation_labels), "\n")
cat("Test labels dimensions:", dim(test_labels), "\n")



###################################################
### Export of the prepared data ####

# Create subdirectory for the csv files
subdirectory <- "csv_data"
#dir.create(subdirectory)

# Export of the prepared data to subdirectory
write_csv(training_features, paste0(subdirectory, "/training_features.csv"))
#write_csv(validation_features, paste0(subdirectory, "/validation_features.csv"))
write_csv(test_features, paste0(subdirectory, "/test_features.csv"))
write_csv(training_labels, paste0(subdirectory, "/training_labels.csv"))
#write_csv(validation_labels, paste0(subdirectory, "/validation_labels.csv"))
write_csv(test_labels, paste0(subdirectory, "/test_labels.csv"))

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
data <- read.csv("https://raw.githubusercontent.com/MarleneSteinbach/team2-B-ckerei/main/0_DataPreparation/Gesamtdatensatz.csv?token=GHSAT0AAAAAACMNUPXXX4G6M7XWMJRIICMEZMYCB3Q")
names(data)
data <- na.omit(data, cols = c("Bewoelkung"))
# füge Datum und Warengruppe zu einer variable zusammen im Format 201801011 (01. Januar 2018, Warengruppe 1, entferne die Striche bei Datum)


data$id <- paste0(data$Datum, data$Warengruppe)
# entferne die Striche bei Datum
data$id <- gsub("-", "", data$id)




###################################################
### Data Preparation ####

# Preparation of independent variables ('features') by dummy coding the categorical variables
features <- as_tibble(model.matrix(Umsatz ~ Wettercode + Bewoelkung + Windgeschwindigkeit + Temperatur + as.factor(Jahreszeit) + as.factor(Temperaturkategorie) + as.factor(Warengruppe) + Fussballspiel + Ferien + Feiertag  + KielerWoche + as.factor(Wochentag) + Flohmarkt + Kreuzfahrtschiffe,data))
names(features)

# Construction of prepared data set
prepared_data <- tibble(label=data$Umsatz, features) %>%  # inclusion of the dependent variable ('label')
  filter(complete.cases(.)) # Handling of missing values (here: only keeping rows without missing values)




###################################################
### Selection of Training, Validation and Test Data ####

# Set a random seed for reproducibility
set.seed(42)
# Shuffle the data
prepared_data_shuffled <- prepared_data %>% sample_frac(1)


# Calculate the number of rows for each dataset
n_total <- nrow(prepared_data_shuffled)
n_training <- floor(0.7 * n_total)
n_validation <- floor(0.20 * n_total)


# Split the features and labels for training, validation, and test
training_features <-
  prepared_data_shuffled %>% select(-label) %>% slice(1:n_training)
validation_features <-
  prepared_data_shuffled %>% select(-label) %>% slice((n_training + 1):(n_training + n_validation))
test_features <-
  prepared_data_shuffled %>% select(-label) %>% slice((n_training + n_validation + 1):n_total)

training_labels <-
  prepared_data_shuffled %>% select(label) %>% slice(1:n_training)
validation_labels <-
  prepared_data_shuffled %>% select(label) %>% slice((n_training + 1):(n_training + n_validation))
test_labels <-
  prepared_data_shuffled %>% select(label) %>% slice((n_training + n_validation + 1):n_total)


# Check the dimensions of the dataframes
cat("Training features dimensions:", dim(training_features), "\n")
cat("Validation features dimensions:",
    dim(validation_features),
    "\n")
cat("Test features dimensions:", dim(test_features), "\n")
cat("\n")
cat("Training labels dimensions:", dim(training_labels), "\n")
cat("Validation labels dimensions:", dim(validation_labels), "\n")
cat("Test labels dimensions:", dim(test_labels), "\n")

###################################################
### Export of the prepared data ####

# Create subdirectory for the csv files
subdirectory <- "csv_data"
dir.create(subdirectory)

# Export of the prepared data to subdirectory
write_csv(training_features, paste0(subdirectory, "/training_features.csv"))
write_csv(validation_features, paste0(subdirectory, "/validation_features.csv"))
write_csv(test_features, paste0(subdirectory, "/test_features.csv"))
write_csv(training_labels, paste0(subdirectory, "/training_labels.csv"))
write_csv(validation_labels, paste0(subdirectory, "/validation_labels.csv"))
write_csv(test_labels, paste0(subdirectory, "/test_labels.csv"))

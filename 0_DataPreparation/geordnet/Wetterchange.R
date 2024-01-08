
#Füge Wetter change variables ein, die das Wetter im Verhältnis mit dem Wetter der letzten Woche beerechnen
# Ensure Datum is a Date variable.
ourdata_fussball$Datum <- as.Date(ourdata_fussball$Datum, format="%Y-%m-%d")

# Order the dataframe by Datum and ungroup if it was previously grouped
ourdata_fussball <- ourdata_fussball %>%
  ungroup() %>%
  arrange(Datum)

# Function to calculate rolling mean for a given column
calculate_rolling_mean <- function(data, column_name) {
  sapply(seq_along(data[[column_name]]), function(i) {
    start_index <- max(1, i - 6)
    current_values <- data[[column_name]][start_index:i]
    mean(current_values, na.rm = TRUE)
  })
}

# Add rolling mean and difference for Temperatur
ourdata_fussball <- ourdata_fussball %>%
  mutate(
    RollingMean_temp = calculate_rolling_mean(ourdata_fussball, "Temperatur"),
    Diff_temp = Temperatur - RollingMean_temp
  )

# Repeat the process for other variables
ourdata_fussball <- ourdata_fussball %>%
  mutate(
    RollingMean_wind = calculate_rolling_mean(ourdata_fussball, "Windgeschwindigkeit"),
    Diff_wind = Windgeschwindigkeit - RollingMean_wind,
    RollingMean_wetter = calculate_rolling_mean(ourdata_fussball, "Wettercode"),
    Diff_wetter = Wettercode - RollingMean_wetter,
    RollingMean_bewoelkung = calculate_rolling_mean(ourdata_fussball, "Bewoelkung"),
    Diff_bewoelkung = Bewoelkung - RollingMean_bewoelkung
  )

# View the data frame with the new variables
head(ourdata_fussball)


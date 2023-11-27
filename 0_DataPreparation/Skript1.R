library(styler)
library(dplyr)

# set working directory
setwd("")
wetter <- read.table("wetter.csv", head=TRUE, sep = ",")
umdat <- read.csv("umsatzdaten_gekuerzt.csv")
kiwo <- read.csv("kiwo.csv")
alle <- full_join(umdat, wetter, by = "Datum") %>%
  full_join(kiwo, by = "Datum")
as_tibble(alle)
nrow(umdat)

nrow(alle)
alle_gefiltert <- alle %>%
  filter(!is.na(Umsatz))
nrow(alle_gefiltert)



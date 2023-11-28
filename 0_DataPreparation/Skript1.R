library(styler)
library(dplyr)

# set working directory
setwd("")

# read files
wetter <- read.table("wetter.csv", head=TRUE, sep = ",")
umdat <- read.csv("umsatzdaten_gekuerzt.csv")
kiwo <- read.csv("kiwo.csv")

# join files together
alle <- full_join(umdat, wetter, by = "Datum") %>%
  full_join(kiwo, by = "Datum")
as_tibble(alle)

# check: Wie viele Zeilen haben wir jetzt?
nrow(umdat)
nrow(alle)

# wir wollen nur die haben, wo "Umsatz" auch enthalten ist.
# Wäre eventuell auch mit left join gegangen aber so geht's auch
alle_gefiltert <- alle %>%
  filter(!is.na(Umsatz))
nrow(alle_gefiltert)

# KIWO: Alle NAs sind ja eigentlich 0 Werte, also Transformieren:


replace(alle$KielerWoche, is.na(), 0)
ifelse(alle$KielerWoche == NA, 0)

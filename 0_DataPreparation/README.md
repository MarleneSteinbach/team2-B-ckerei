# Data Preparation
Datenimport: Für die Datenaufbereitung wurden zunächst die vorgegebenen CSV-Dateien kiwo, umsatz, wetter, training-ids und test-ids heruntergeladen.

Merging Data from different Sources: Wir haben über ein fulljoin by "Date" alle Daten gemergt. 

Data cleaning: Wir sind uns nicht sicher was damit gemeint ist, wir haben alle Daten genutzt wie sie waren.

Missing Values: Dann haben wir die Bewölkung mit der Hotdeckmethode und die Temperatur und Windgeschwindigkeit mit der linearen Interpolation imputiert.

Neue Variablen: Dann haben wir in separaten Skripten neue Variablen erstellt und in eine CSV geschrieben. Diese konnten wir dann in unser Hauptskript laden und zur bestehenden Tabelle hinzufügen. Unsere hinzugefügten Variablen hatten keine fehlenden Werte. 

Data Transformation: Wir haben Warengruppe, Wettercode, Jahreszeit, Temperaturkategorie, Art des Feiertags und Wochentag in eine kategorielle Variable transformiert

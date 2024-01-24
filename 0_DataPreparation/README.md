# Data Preparation
Das Skript in dem alles zusammengfasst ist trägt den Namen "Hauptskript.rmd" und befindet sich im unterordner geordnet
Datenimport: Für die Datenaufbereitung wurden zunächst die vorgegebenen CSV-Dateien kiwo, umsatz, wetter, training-ids und test-ids heruntergeladen.

Merging Data from different Sources: Wir haben über ein fulljoin by "Date" alle Daten gemergt. 

Data cleaning: Wir sind uns nicht sicher was damit gemeint ist, wir haben alle Daten genutzt wie sie waren.

Missing Values: Dann haben wir die Bewölkung mit der Hotdeckmethode und die Temperatur und Windgeschwindigkeit mit der linearen Interpolation imputiert.

Neue Variablen (Im Unterordner georndet): Dann haben wir in separaten Skripten neue Variablen erstellt und in eine CSV geschrieben. Diese konnten wir dann in unser Hauptskript laden und zur bestehenden Tabelle hinzufügen. Unsere hinzugefügten Variablen hatten keine fehlenden Werte. Wir waren uns nicht sicher, ob im übergordneten Ordner noch wihctige Dateien sind, daher haben wir dort nichts gelöscht.

Data Transformation: Wir haben Warengruppe, Wettercode, Jahreszeit, Temperaturkategorie, Art des Feiertags und Wochentag in eine kategorielle Variable transformiert

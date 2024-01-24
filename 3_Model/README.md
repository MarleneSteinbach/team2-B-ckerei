# Model Definition and Evaluation
Modell selection: Wir haben das neuronale Netzwerk basierend auf dem Baseline Modell implementiert. Dort haben wir ein sequentielles Netzwerk von Kerasflow optimiert, indem wir Inputlayer, Batchnormalisierung, Dense- und Dropout-Layer basierend auf den besten Ergebnissen verändert haben. Außerdem haben wir einen adam optimizer verwendet.

Feature engenierng: Dementsprechend haben wir alle Variablen, die im Baseline Modell vorkamen, durch eine Dummy Codierung aufbereitet und dann in das Jupyter Notebook geladen.

Hyperparameter tuning, Implementation und Evaluation metrics: Dann haben wir Faktoren wie Momentum, Lernrate und Anzahl der Epochen im Modelltraining optimiert, alles basierend auf MAPE, MSE und Kaggle-Score, wobei es wichtig war, dass die Unterschiede zwischen dem Validierungsdatensatz und dem Trainingsdatensatz für MAPE und MSE nicht zu groß waren. 

Unten finden Sie den Link zu unserem Jupyte Notebook.
https://colab.research.google.com/drive/1uE7dplG_tPheUb_f-Gk5-axo8tPNOAxJ?usp=sharing

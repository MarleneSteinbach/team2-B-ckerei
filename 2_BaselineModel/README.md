# Baseline Model
Feature Selection: Wir haben jegliche Variablen, außer Diff_temp und Diff_wind verwendet.

Implementation und Evaluation: 
Um unser Basismodell zu erstellen, haben wir die zuvor hinzugefügten und imputierten Variablen verwendet. Dabei haben wir zunächst alle Variablen einzeln aufgenommen und geprüft, ob es sich um eine kategoriale Variable handelt und diese als as.factor aufgenommen. Anschließend haben wir verschiedene Interaktionsterme hinzugefügt und die Güte des Modells anhand von MSE und R^2 bewertet, wobei wir versucht haben, Overfitting zu vermeiden.

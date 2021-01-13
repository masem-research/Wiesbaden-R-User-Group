
# TITLE: WRUG LRT in Binary Logistic Regression ---------------------------

# Modellvergleich: Konkurrierende Modelle 
#  Es gilt: Parsimonität 
#  Frage: Macht es statistisch Sinn, einen weiteren Parameter in das Modell
#   zu integrieren?
#
#  Eine Möglichkeit: Ist der Koeffizient signifikant!
#   Funktioniert auch ganz gut, wenn nur ein Koeffizient aufgenommen wird,
#    Faktor! Kontrastkodierung (Schulnoten A bis F) 
#    ID GradeA GradeB GradeC GradeD GradeE GradeF
#    1  0      1      0      0      0      0
#    2  1      0      0      0      0      0
#    3  ...
#    Bernoulli-verteilte Variable
#    R: nimmt die Dummy-Kodierung selbst vor! 
#     Referenzkategorie bleibt draußen!
#     Signifikanzniveau der Koeffizienten beziehen sich auf die Referenzkategorie
# 
# Wie teste ich galant die Aufnahme dieses Faktors? 
#
# Multilevelanalysen: Zwei Ebenen: Random Slope Modelle: Test ob Random Slope oder nur
#  Random Intercept Modell über Likelihood Ratio Test
#
# LRT: Deviance
#


# Packages ----------------------------------------------------------------

# --
# stats-Paket



# Data IO -----------------------------------------------------------------

# UCLA
binary <- read.csv("X:/cloud/masem_gmoeser/MASEM_AUSTAUSCH/OeffentlichkeitsArbeit/R User Gruppe/WRUG - LRT/binary.csv")

# GRE (Graduate Record Exam scores), 
# GPA (grade point average) 
# prestige of the undergraduate institution
# Zielvariable: admit to graduate school

head(binary)


# Einfaches Logistisches Modell -------------------------------------------

FirstLogitModel <- glm(formula = admit ~ gre, data = binary, family = binomial(link = "logit"))
summary(FirstLogitModel)

# LRT: Vergleich gegen das Null-Modell:
#  Intercept only model
NullLogitModel <- glm(formula = admit ~ 1, data = binary, family = binomial(link = "logit"))
summary(NullLogitModel)


# Zweites: Aufnahme der Variablen prestige of the undergraduate institution
SecondLogitModel <- glm(formula = admit ~ gre + factor(rank), data = binary, family = binomial(link = "logit"))


summary(SecondLogitModel)
# Ergebnis: Drei neue Koeffizienten!
table(binary$rank) # Referenz ist 1

## Nutzung der Deviance: Maß der Fehlanpassung



# Nutzung des LRT ---------------------------------------------------------

ModelComparison <- stats::anova(FirstLogitModel, SecondLogitModel)
# Was nun?
# Ist die Deviance-Änderung statistisch signifikant?
#  Chi2-verteilt

# Signifikanztest
pchisq(q = ModelComparison$Deviance[2], df = ModelComparison$Df[2], lower.tail = F)
# Interpretation: 
# Statistisch signifikant auf 5%!
# Somit kann das komplexere Modell nicht zugunsten des einfacheren Modells zurück gewiesen werden! 
# Somit macht die Aufnahme des Faktors hier aus statistischer Sicht Sinn!

# Auch Einsatz im lme4, glmnet-Paket, ...


# Ausblick Ende Januar ----------------------------------------------------

# Kontraste
# aod-Paket, Wald-Test, Testen von Kontrasten (ad-hoc-Tests, Bonferroni)































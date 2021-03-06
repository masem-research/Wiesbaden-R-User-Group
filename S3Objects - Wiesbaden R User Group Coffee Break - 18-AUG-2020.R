
##  Thema: S3-Objekte in R ----------------------------------------------------------
#    R Coffee Break der Wiesbaden R User Group am 19. August 2020
#    Guido Moeser

## S3 Objekte: Nutzung einer generischen Funktion: Hier sorgt die Objektklasse 
#   bei Aufruf einer Methode f�r die Wahl der f�r die Klasse geeigneten Methode


## Beispiel aus der Praxis (aber andere Daten!) -------------------------------------

## Berechnung der mittleren Ozon-Menge nach Monatstag
OzoneByDay <- tapply(X = airquality$Ozone, INDEX = airquality$Day, FUN = mean, na.rm = F)
## Ausgabe Ergebnis
OzoneByDay
# Hinweis: Die NA-Werte lassen sich nat�rlich vermeiden, sollten hier aber die 
#  grunds�tzliche Herangehensweise verdeutlichen:
#  Darstellung der >>g�ltigen<< Werte in einem Diagramm etc., dazu sollen pauschal alle 
#  fehlenden Werte ausgeschlossen werden:
# Dazu kann die Funktion generische Funktion na.omit verwendet werden: 
#  "na.omit returns the object with incomplete cases removed" (Zitat Funktionshilfe)
?na.omit
## Anwendung auf das Ergebnisobjekt der tapply()-Funktion:
na.omit(OzoneByDay)
## Ergebnis: Fehler! 

## Warum? (Wurde das Ergebnis mit aggregate erzeugt, klappt es:)
OzoneByDayAggregateFUN <- aggregate.data.frame(x = airquality[,"Ozone", drop = FALSE], by = list(airquality$Day), FUN = mean, na.rm = FALSE)
# entfernen der Tage mit fehlenden Werte
na.omit(OzoneByDayAggregateFUN)

## Wo ist also das Problem?
class(OzoneByDayAggregateFUN) # data.frame!
class(OzoneByDay) # array!
## Pr�fen wir die na.omit-Funktion
# Dazu mal ein Blick in die R Installationsversion:
# In https://cran.r-project.org/sources.html befindet sich der source-Code:
# z.B. R Version 4.0.2: https://cran.r-project.org/src/base/R-4/R-4.0.2.tar.gz
# R-code stats: R-4.0.2.tar.gz\R-4.0.2\src\library\stats\R
# na.omit: R-4.0.2.tar.gz\R-4.0.2\src\library\stats\R\nafns.R (na functions)

## Bitte hier mal alle na.omit-Funktionen inspizieren!

# Mit dem Befehl methods() k�nnen alle klassenspezifischen Methoden angezeigt werden:
methods(na.omit)

## Die generische (�ber-)-Funktion oder Methode ist sehr kurz in R S3-Objekten:
na.omit <- function(object, ...) UseMethod("na.omit")
## Eine generische S3 Methode zeichnet sich im Funktionsk�rper nur durch die Zeile
#   UseMethod("na.omit") aus

## Warum klappt es nun nicht?
#   L�sung: 
#   1. Es gibt keine na.omit-Methode f�r arrays!!
#   2. Die Methode f�r die default-Klasse kommt mit der Anzahl an Dimensionen
#       des tapply-Ergebnisobjekts nicht zurecht! (so viele Dimensionen wir Gruppen)

## Ausweg: Selbst eine Klasse für arrays bauen:
na.omit.array <- function(object, ...) {
  ## Quick and Dirty Ansatz - aufpassen bei Nutzung anderer array-Objekte!
  
  # array in ein Objekt der Klasse data.frame wandeln
  object <- data.frame(object)
  # die bestehende na.omit.data.frame Methode anwenden
  object <- na.omit(object)
  # Ergebnis zur�ckgeben
  return(object)
}


## Works!
class(OzoneByDay)
na.omit(OzoneByDay)








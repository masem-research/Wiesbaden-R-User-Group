## TITLE: Wiesbaden R User Coffee Break: dplyr ----------------------------

## References: Package vignettes recommended!
# dplyr <-> base R: https://cran.r-project.org/web/packages/dplyr/vignettes/base.html

## Idea of dplyr: Provides "verbs": funtions that correspond to typical data manipulation tasks

## Main task: Simplify your life when working with R!
##  In my view three main solutions:
#   1. tibble's instead of data.frame 
#   2. pipe operator %>%
#   3. dplyr "verbs"




# Package Handling --------------------------------------------------------

## Current dplyr version: 1.0.2 (28th of October 2020)
if (!require("dplyr")) install.packages("dplyr")
library(dplyr)

## Older vesions of dplyr
#   Overview: https://cran.r-project.org/src/contrib/Archive/dplyr/
# Use devtools to install an older (faster :-) ) version of dplyr
if (!require("devtools")) install.packages("dplyr")
library(devtools)
#install_version("dplyr", version = "0.8.5", repos = "http://cran.us.r-project.org")
library(dplyr)

# Currently loaded package version
packageVersion("dplyr")



# Data IO -----------------------------------------------------------------

# We will use some starwars dataset (dplyr package)




# Number 1: tibble --------------------------------------------------------

## A tibble is "a modern reimagining of the data frame"
#   Now stored in package "tibble" or simply install "tidyverse"


# Typical example: dplyr::starwars dataset
class(starwars)
# Just call a tibble and you see some of the major advantages:
starwars

## mtcars: datasets-package
class(mtcars)


# pipe-Operator -----------------------------------------------------------

## Second major advantage is the "pipe-operator"!

# "Rather than forcing the user to either save intermediate objects or nest functions, dplyr provides the %>% operator from magrittr. x %>% f(y) turns into f(x, y) so the result from one step is then “piped” into the next step. You can use the pipe to rewrite multiple operations that you can read left-to-right, top-to-bottom (reading the pipe operator as “then”)."

# <CTRL> + <Shift> + <M>


# "Verbs" -----------------------------------------------------------------


# Rows:
#   filter() chooses rows based on column values.
#   slice() chooses rows based on location.
#   arrange() changes the order of the rows.
#
# Columns:
#   select() changes whether or not a column is included.
#   rename() changes the name of columns.
#   mutate() changes the values of columns and creates new columns.
#   relocate() changes the order of the columns.
#
# Groups of rows:
#   summarise() collapses a group into a single row.

## First argument always the tibble or data.frame!
## It is not required that the input is a tibble, could be a data.frame as well



# Verb filter: Filter rows ------------------------------------------------

## How to do it in base R?
mtcars[mtcars$cyl == 6,, drop = FALSE]
mtcars[which(mtcars$cyl == 6),, drop = FALSE]
subset(x = mtcars, subset = cyl == 6, drop = FALSE)

## select a subset of rows in a data frame
filter(.data = mtcars, cyl == 6)

## with pipe-operator:
mtcars %>% filter(cyl == 6)


## another - not so interesting verb - arrange 
#   How arrange works:
mtcars %>% filter(cyl == 6) %>% arrange(gear) 

# desc:
mtcars %>% filter(cyl == 6) %>% arrange(desc(gear))


## and another - even less interesting - verb: slice()
mtcars %>% filter(cyl == 6) %>% arrange(desc(gear)) %>% slice(1:2)

## other slice-functions: 
#  - slice_head(), 
#  - slide_tail(), 
#  - slice_sample(), 
#  - slice_min(), 
#  - slice_max()

## Example: sample randomly two rows
mtcars %>% filter(cyl == 6) %>% arrange(desc(gear)) %>% slice_sample(n = 2)
## Bootstap: Sample 100
mtcars %>% filter(cyl == 6) %>% arrange(desc(gear)) %>% slice_sample(n = 100, replace = TRUE) -> mtcars_6cyl_bootstrapSample
mtcars_6cyl_bootstrapSample



# Verb select: Select columns ---------------------------------------------

## R base
mtcars[,c("mpg", "cyl", "carb"), drop = FALSE]
subset(x = mtcars, select = c(mpg, cyl, carb))

## select only mpg, cyl and carb
mtcars %>% select(mpg, cyl, carb) %>% filter(carb == 4) %>% arrange(desc(mpg))




# Verb mutate: Add new columns --------------------------------------------

# Example: wt (1000 lbs) in kg 

## base R
mtcars$wt_tsdkg <- mtcars$wt * 0.453592
# or use transform
transform(mtcars, wt_tsdkg = wt * 0.453592)

# 1 lbs ~ 0,453592 kg
mtcars %>% mutate(wt_tsdkg = wt * 0.453592)

# Please note: transmute() allows you to keep only the new variables



# summarise verb: Summarise values ----------------------------------------

# base R:
#  mean(), tapply(), aggregate(), by()

# it collapses a data frame into a single row
# usefult together with group_by()
mtcars %>% summarise(mpg, cyl)



# groupby -----------------------------------------------------------------

# Classical 2-dim cross-table
group_by(mtcars, am, gear) %>% summarise()






# Summary -----------------------------------------------------------------

# Web: https://cran.r-project.org/web/packages/dplyr/vignettes/base.html









 



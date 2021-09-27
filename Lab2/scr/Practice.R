library(tidyverse)
library(sf)
library(tmap)
library(RCurl)

t.names <- tibble(key = c(1,2,3),
                  name = c("Huey", "Dewey", "Louis"))

t.scores <- tibble(name = c("Huey", "Dewey", "Louis"), 
                   grade = c(45, 33, 99))

t.joined <- left_join(t.names, t.scores, by="name")
t.joined
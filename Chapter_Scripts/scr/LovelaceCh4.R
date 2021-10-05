# libraries
library(sf)
library(terra)
library(dplyr)
library(spData)
library(tmap)

#data to be used in Ch4
data("nz")
data("nz_height")
data("grain")
data("elev")

#check out dataset
glimpse(nz)

# filter to just canterbury
canterbury = nz %>% filter(Name == "Canterbury")

#spatial index to only heights in canterbury
canterbury_height = nz_height[canterbury,]

#visually display results
tm_shape(nz) + tm_polygons(col = "white") +
  tm_shape(canterbury) + tm_polygons(col = "gray") +
  tm_shape(canterbury_height) + tm_dots(col = "red")
#install.packages("rgdal")
library(raster)
library(rgdal)
cyano <- raster::raster(".\\data\\cyano_max_7day.tif")

plot(cyano)
summary(cyano)

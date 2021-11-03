library(tidyverse)
library(raster)
library(tmap)

myras <- raster::raster("./data/ts_2016.1007_1013.L4.LCHMP3.CIcyano.MAXIMUM_7day.tif")

plot(myras)

myras * 2

myras %>% values() %>% range(na.rm = T)

# What's different here?
(myras * 2) %>% values() %>% range(na.rm = T)

rcl = matrix(c(0, 1, 0, 2, 249, 1, 250, 256, 0), ncol = 3, byrow = TRUE)
rcl

validdata = reclassify(myras, rcl = rcl)
validdata
plot(validdata)

validRaster <- myras * validdata
plot(validRaster)

# NOAA transform for CHAMPLAIN data
# valid as of 2019-02-01 metadata
transform_champlain_olci <- function(x){
  
  10**(((3.0 / 250.0) * x) - 4.2)
}

myras.ci <- validRaster %>% transform_champlain_olci
plot(myras.ci)

myras_focal = focal(myras.ci, w = matrix(1, nrow = 3, ncol = 3), fun = max)
plot(myras_focal)

(myras_focal - myras.ci) %>% plot

# good practice
compareRaster(myras_focal, myras.ci)

myrasSep <- raster::raster("./data/ts_2016.0902_0908.L4.LCHMP3.CIcyano.MAXIMUM_7day.tif")
myrasOct <- raster::raster("./data/ts_2016.1007_1013.L4.LCHMP3.CIcyano.MAXIMUM_7day.tif")

# blooms get larger?
recSep <- reclassify(myrasSep, rcl = rcl)
recOct <- reclassify(myrasOct, rcl = rcl)

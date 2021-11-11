library(sf)
library(tidyverse)
library(tmap)   



#Reading Streams data 
streams <- sf::read_sf("./data/Streams_303_d_.shp") %>%
  sf::st_make_valid() 

crs <- st_crs(streams)

#Reading City data 

# City <- sf::read_sf("./data/City_Boundaries.shp") %>%
#   sf::st_make_valid() %>% st_transform(crs=crs)
# 
# st_crs(streams) == st_crs(City)

# Making the polygon(or shapefile), which is smaller than City or Stream, 
# to intersect w/ City or Stream 

Area1 <- list(rbind(c(604383.9, 4631214),
                       c(604383.9, 4637815),
                       c(616883.9, 4637815),
                       c(616883.9, 4631214),
                       c(604383.9, 4631214))) %>% 
  st_polygon() %>% 
  st_sfc() #this is what you were missing, st_sfc changes it from the sfg class to sfc class and 
                      #can then be read by tmap
class(Area1)

#map
tm_shape(Area1) + tm_polygons()

#you will need to convert coordinates in list for Area1 from
#meters to lat long coordinates and then make the st_sfc look like
# this: <- st_sfc(., crs=crs)


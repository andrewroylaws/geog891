#libraries
library(tidyverse)
library(sf)
library(GISTools)
library(tmap)

#data
streams <- sf::read_sf("./data/Streams_303_d_.shp")
counties <- sf::read_sf("./data/County_Boundaries-_Census.shp")

tm_shape(streams) + tm_lines()

counties_areas <- sf::st_area(counties)
counties <- counties %>% mutate(area = sf::st_area(counties))

#filter
lc <- counties %>% dplyr::filter(., NAME10 == "Lancaster")

#subset with spatial index
lc_303 <- streams[lc,]

#subset with intersection
lc_303ds <- sf::st_intersection(streams, lc)

tm_shape(counties) + tm_polygons() +
  tm_shape(lc) + tm_polygons(col = "red") +
  tm_shape(lc_303) + tm_lines(col = "blue") +
  tm_shape(lc_303ds) + tm_lines(col = "yellow")

#buffer
lc_303ds.crs <- sf::st_crs(lc_303ds)
lc_303ds.crs

buffs <- sf::st_buffer(lc_303ds, dist = 1000)

tm_shape(buffs) + tm_polygons(col = "Waterbody_")

#parks
parks <- sf::read_sf("./data/State_Park_Locations.shp")

#subset to lc
lc_parks <- sf::st_intersection(parks, lc)

#plot parks
tm_shape(lc_parks) + tm_dots(col = "AreaName", size = 1)

#combine plots
tm_shape(lc_303) + tm_lines(col = "Waterbody_") +
  tm_shape(lc_parks) + tm_dots(col = "AreaName", size = 1)

#final task
streams.feet <- sf::st_transform(streams, 102704)
sf::st_crs(streams.feet)
buff_streams <- sf::st_buffer(streams, dist = 800) #800 meters equals 1/2 mile

park_stream <- sf::st_intersection(buff_streams, parks)

tm_shape(park_stream) + tm_dots(col = "Waterbody_", size = 2)

#GISTools
poly.areas(counties) #throws error b/c its in sf

counties %>% as_Spatial() %>% poly.areas() #converts to sp but is in WGS84, needs to be projected

parks_p <- sf::st_transform(parks, 26914)
counties_p <- sf::st_transform(counties, 26914)

counties_p %>% as_Spatial() %>% poly.areas()

counties %>% sf::st_transform(., 26914) %>% sf::st_area() 

lc_303ds_p <- sf::st_transform(lc_303ds, 26914)
lc_parks_p <- sf::st_transform(lc_parks, 26914)

dist_proj <- sf::st_distance(lc_303ds_p, lc_parks_p)
dist_unpr <- sf::st_distance(lc_303ds, lc_parks)

dist_proj
dist_unpr

dist_diff <- dist_proj - dist_unpr
dist_diff <- daa.frame()

hist(dist_diff)

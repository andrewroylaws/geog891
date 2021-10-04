library(tidyverse)
library(GISTools)
library(sf)
library(tmap)

counties <- sf::read_sf("./data/County_Boundaries.shp") %>% sf::st_make_valid()

dams <- sf::read_sf("./data/Dam_or_Other_Blockage_Removed_2012_2017.shp") %>% sf::st_make_valid()

streams <- sf::read_sf("./data/Streams_Opened_by_Dam_Removal_2012_2017.shp") %>% sf::st_make_valid()

pa.counties <- counties %>% filter(STATEFP10 == 42)

# pa.dams <- dams[pa.counties,]

pa.dams <- st_intersection(dams, pa.counties)

st_intersects(dams, pa.counties)

dams %>% st_intersects(x = ., y = pa.counties)
dams %>% st_intersects(x = pa.counties, y = .)

dams %>% st_intersects(x = ., y = pa.counties, sparse = FALSE)

dams %>% st_within(x = ., y = pa.counties, sparse = FALSE)

c.tioga <- pa.counties %>% filter(NAME10 == "Tioga")
streams.tioga <- streams[c.tioga,]

streams.tioga %>% st_covered_by(., c.tioga)
tm_shape(c.tioga) + tm_polygons() + tm_shape(streams.tioga) + tm_lines(col = "blue")

streams.tioga %>% st_is_within_distance(., dams, 1)

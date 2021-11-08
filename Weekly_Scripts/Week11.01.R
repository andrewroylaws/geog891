library(tidyverse)
library(leaflet)
library(sf)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng = -96.703090, lat = 40.819288, popup="The Burnett Hall GIS Lab")

m

df <- data.frame(
  lat = rnorm(100),
  lng = rnorm(100),
  size = runif(100, 5, 20),
  color = sample(colors(), 100)
)

m2 <- leaflet(df) %>% addTiles()

m2$x

m2 %>% addCircleMarkers(radius = ~size, color = ~color, fill = FALSE)

m2 %>% addCircleMarkers(radius = runif(100, 4, 10), color = c('red'))

m <- leaflet() %>% setView(lng = -96.703090, lat = 40.81928, zoom = 14)
m %>% addTiles()

m %>% addProviderTiles(providers$CartoDB.PositronNoLabels)
m %>% addProviderTiles(providers$OpenRailwayMap)

parks <- sf::read_sf("./data/State_Park_Locations.shp")

# set up the map, zoom out a bit
mp <- leaflet(data = parks) %>% setView(lng = -96.703090, lat = 40.81928, zoom = 10)
mp %>% addTiles() %>% 
  addMarkers(popup = ~AreaName, label = ~AreaName)

streams <- sf::read_sf("./data/Streams_303_d_.shp")

ms <- leaflet(data = streams) %>% 
  setView(lng = -96.703090, lat = 40.81928, zoom = 10) %>% 
  addTiles() %>%
  addPolylines(., color = "blue", 
               popup = ~paste0(Waterbody_, " - ", Impairment))

lanc <- sf::st_read("./data/lancaster_county.shp") %>% st_make_valid()

muni <- st_read("./data/Municipal_Boundaries.shp") %>% st_make_valid()

lanc.muni <- muni[lanc,]

# do multiple layers by not passing the first "leaflet()" call a data argument
m.both <- leaflet() %>%
  setView(lng = -96.703090, lat = 40.81928, zoom = 10) %>% 
  addProviderTiles(providers$Stamen.Toner) %>%
  addMarkers(data = parks, popup = ~AreaName, label = ~AreaName) %>% 
  addPolylines(data = streams, color = "blue", 
               popup = ~paste0(Waterbody_, " - ", Impairment))
m.both

m3 <- leaflet() %>%
  setView(lng = -96.703090, lat = 40.81928, zoom = 10) %>% 
  addProviderTiles(providers$Stamen.Toner) %>%
  addMarkers(data = parks, popup = ~AreaName, label = ~AreaName) %>% 
  addPolylines(data = streams, color = "blue", 
               popup = ~paste0(Waterbody_, " - ", Impairment)) %>% 
  addPolygons(data=lanc.muni, popup = ~NAMELSAD, fillColor = "green", color = "red")


m3

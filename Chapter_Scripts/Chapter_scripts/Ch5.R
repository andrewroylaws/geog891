library(tidyverse)
library(GISTools)
library(sf)
library(tmap)
data(newhaven)

bb <- bbox(tracts)
grd <- GridTopology(cellcentre.offset = c(bb[1,1]-200, bb[2,1]-200),
                    cellsize = c(10000, 10000), cells.dim = c(5,5))
int.layer <- SpatialPolygonsDataFrame(
  as.SpatialPolygons.GridTopology(grd),
  data = data.frame(c(1:25)), match.ID = FALSE)
ct <- proj4string(blocks)
proj4string(int.layer) <- ct
proj4string(tracts) <- ct
names(int.layer) <- "ID"
print(int.layer)
plot(int.layer)

int.sf <- st_as_sf(int.layer)
tracts.sf <- st_as_sf(tracts)
int.res <- st_intersection(int.sf, tracts.sf)

p1 <- tm_shape(int.sf) + tm_borders(lty = 2) +
  tm_layout(frame = FALSE) +
  tm_text("ID", size = 0.7) +
  tm_shape(tracts.sf) + tm_borders(col = "red", lwd = 2)

p2 <- tm_shape(int.sf) + tm_borders(col = "white") +
  tm_shape(int.res) + tm_polygons("HSE_UNITS", palette = blues9) +
  tm_layout(frame = FALSE, legend.show = FALSE)

library(grid)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1,2)))
print(p1, vp=viewport(layout.pos.col = 1))
print(p2, vp=viewport(layout.pos.col = 2))

int.areas <- st_area(int.res)
tract.areas <- st_area(tracts.sf)

index <- match(int.res$T009075H_I, tracts$T009075H_I)
tract.areas <- tract.areas[index]
tract.prop <- as.vector(int.areas)/as.vector(tract.areas)

int.res$houses <- tracts$HSE_UNITS[index] * tract.prop

houses <- summarise(group_by(int.res, ID), count = sum(houses))

int.layer$houses <- 0
int.layer$houses[houses$ID] <- houses$count

tm_shape(int.layer) +
  tm_polygons("houses", palette = "Greens",
              style = "kmeans", title = "No. of houses") +
  tm_layout(frame = FALSE, legend.position = c(1,0.5)) +
  tm_shape(tracts.sf) + tm_borders(col = "black")

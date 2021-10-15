library(terra)

# EXAMPLE I MADE ---> IT WORKS.

r1 <- rast(ncols=10, nrows=10)
values(r1) <- 1:ncell(r1)
global(r1, "sum")
global(r1, "mean", na.rm=TRUE)

r2 <- rast(ncols=10, nrows=10)
values(r2) <- 101:200
global(r2, "sum")
global(r2, "mean", na.rm=TRUE)

r3 <- rast(ncols=10, nrows=10)
values(r3) <- 201:300
global(r3, "sum")
global(r3, "mean", na.rm=TRUE)

rr <- c(r1, r2, r3)
global(rr, "sum")
global(rr, "mean")

# Data, IT DOENNOT WORK

# read the data

P2011 <- rast("./2011_35603022s_WGS84.tif")

P2011

# Extract a each layer
P2011.b1 = P2011[[1]]
P2011.b2 = P2011[[2]]
P2011.b3 = P2011[[3]]


P2011.T = c(P2011.b1, P2011.b2, P2011.b3)

global(P2011.T, sum) 
global(P2011.b1, sum)
global(P2011.b2, sum)
global(P2011.b3, sum)
require(GISTools)
require(tmap)
library(maptools)

data(newhaven)

tmap_mode('view')
tmap_options(check.and.fix = TRUE)
tm_shape(blocks) + tm_borders() + tm_shape(breach) +
  tm_dots(col = "navyblue")

choose_bw <- function(spdf) {
  x <- coordinates(spdf)
  sigma <- c(sd(X[,1]), sd(X[,2])) * (2/(3 *nrow(X))) ^ (1/6)
  return(sigma/1000)
}

breach_ens <- smooth_map(breach, cover=blocks, bandwidth = choose_bw(breach))

#k function
require(spatstat)

data("bramblecanes")
plot(bramblecanes)

kf <- Kest(bramblecanes, correction = "border")
plot(kf)

mad.test(bramblecanes, Kest, verbose=FALSE)

dclf.test(bramblecanes, Kest, verbose=FALSE)

#L function
lf.env <- envelope(bramblecanes, Lest, correction="border")
plot(lf.env)
mad.test(bramblecanes, Lest, verbose=FALSE)

#G function
gf.env <- envelope(bramblecanes, Gest, correction="border")
plot(gf.env)

#cross L
clenv.bramble1 <- envelope(bramblecanes, Lcross, i=0, j=1, correction="border")
clenv.bramble2 <- envelope(bramblecanes, Lcross, i=0, j=2, correction="border")
plot(clenv.bramble1)
plot(clenv.bramble2)

dclf.test(bramblecanes, Lcross, i=0, j=1, correction="border", verbose=FALSE)
dclf.test(bramblecanes, Lcross, i=1, j=2, correction="border", verbose=FALSE)
dclf.test(bramblecanes, Lcross, i=0, j=2, correction="border", verbose=FALSE)

#IDW
detach("package:spatstat")
library(gstat)
data("fulmar")
s.grid <- spsample(fulmar.voro, type = "regular", n=6000)

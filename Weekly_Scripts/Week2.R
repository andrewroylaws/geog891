x <- seq(1:20)
x <- seq(1, 20, 1)
sum(x)
length(x)
typeof(8675309)
typeof(2)
typeof(integer(8675309))
typeof(rep(1, 10))
typeof(list(1, 2, 3, "orange"))

library(tidyverse)
mydf <- read_csv("./data/ne_counties.csv")
mydf

summary(mydf)
nrow(mydf)
ncol(mydf)
glimpse(mydf)
mydf$Total
summary(mydf$Total)
hist(mydf$Total)

dplyr::filter(mydf, Total > 10000 & MedHousInc < 40000)
mydf %>% dplyr::filter(., Total > 10000 & MedHousInc < 40000)

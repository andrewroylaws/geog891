library(tidyverse)
library(sf)
library(tmap)

t.names <- tibble(key = c(1,2,3),
                  name = c("Huey", "Dewey", "Louis"))

t.scores <- tibble(name = c("Huey", "Dewey", "Louis"), 
                   grade = c(45, 33, 99))

t.joined <- left_join(t.names, t.scores, by="name")
t.joined

t.wonkyNames <- tibble(nombre = c("Dewey", "Louis", "Huey"),
                       x = rep(999),
                       favoriteFood = c("banana", "apple", "carrot"))

t.joined2 <- left_join(t.names, t.wonkyNames, by= c("name"="nombre"))
t.joined2

bmps <- read_csv("./data/orig/BMPreport2016_landbmps.csv")

glimpse(bmps)

bmps <- bmps %>% mutate(., FIPS.trimmed = stringr::str_sub(GeographyName, 1, 5))

bmps %>% group_by(BMPType) %>% summarise(totalCost = sum(Cost, na.rm = TRUE)) %>% 
  ggplot(., aes(x=BMPType, y=totalCost)) +
  geom_bar(stat="identity") +
  theme_minimal()

twofactors <- bmps %>% group_by(StateAbbreviation, Sector) %>% summarise(totalCost =  sum(Cost))

bmps %>% ggplot(., aes(x = StateAbbreviation, y = AmountCredited)) +
  geom_boxplot(aes(fill = StateAbbreviation))

bmps %>%
  dplyr::filter(., AmountCredited > 1 & AmountCredited < 100) %>%
  ggplot(., aes(x = StateAbbreviation, y = AmountCredited)) +
  geom_boxplot(aes(fill = StateAbbreviation))

bmps %>%
  dplyr::filter(., AmountCredited > 1 & AmountCredited < 100) %>%
  ggplot(., aes(x = StateAbbreviation, y = AmountCredited)) +
  geom_boxplot(aes(fill = StateAbbreviation)) +
  facet_grid(Sector~.)

x = c(1,2,3,4,5)
7 %in% x
2 %in% x
c(4, 99, 1) %in% x

counties <- sf::read_sf("./data/orig/County_Boundaries.shp")
counties <- sf::st_make_valid(counties)

tmap_mode("view")
tm_shape(counties) + tm_polygons(col = "ALAND10")

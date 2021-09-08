library(tidyverse)
library(ggplot2)
mydf <- read_csv("./data/ne_counties.csv")
glimpse(mydf)

#plot 1
plot(mydf$Total, mydf$TotalUnits)

#plot 2
hist(mydf$M10to14Y, breaks = 20)

#plot 3 (customized)
ggplot(mydf, aes(x = Total, y = PerCapInc)) +
  geom_point(color = "blue") + 
  geom_smooth(method = "glm", color = "red")
  theme_minimal() +
  labs(x = "Total population", y = "Per capita income", title = "Some ggplot stuff!")

# create categorical data
mydf2 <- mydf %>% mutate(sizeCategory = ifelse(Total > 20000, "big", "small"))
summary(mydf2$sizeCategory)
summary(as.factor(mydf2$sizeCategory))

#plot 4
ggplot(mydf2, aes(x = Total, y = PerCapInc)) +
  geom_point(aes(shape = sizeCategory, color = sizeCategory), size = 3) +
  theme_minimal() +
  labs(x = "Total Pop", y = "Per capita income", title = "Reformated plot")

#plot 5 (boxplot)
mydf2 %>% ggplot(., aes(x = sizeCategory, y = PerCapInc)) +
  geom_boxplot(aes(fill = sizeCategory)) +
  theme_minimal() +
  labs(x = "Categorical size",
       y = "Per capita income",
       title = "Huzzah a boxplot",
       subtitle = "It's handly")
#plot 6 histogram
ggplot(mydf2, aes(x = Female)) +
  geom_histogram() +
  theme_minimal() +
  labs(x = "Population of women", y = "Count", title = "Histogram of women")

# make new df and histogram ----
mydf3 <- mydf %>% mutate(FAdvDeg = FMastDeg + FProfDeg + FDocDeg)
#glimpse(mydf3$FAdvDeg)
ggplot(mydf3, aes(x = FAdvDeg)) +
  geom_histogram(bins = 30) +
  theme_minimal() +
  labs(x = "Women with advanced degrees", y = "Count", title = "Populations of women with advanced degrees")

myfirstfunction <- function(x, y){
  return (x + y)
}

myfirstfunction(4, 8)
2 %% 1

evenOdd <- function(x,y){
  return(x %% 2 == y %% 2)
}

evenOdd(2, 10)
evenOdd(3.11, 3)

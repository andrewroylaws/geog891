library(tidyverse)

rainfall <- c(0.0, 2.1, 2.5, 0.1, 0.0, 0.0, 6.8, 3.1, 2.2)

f.storm.test <- function(rainfallAmount){
  if (rainfallAmount >= 3){
    print("big storm")
  } else {
    print("little storm")
  }
}

for(i in rainfall){
  f.storm.test(i)
  }

rainfall %>% purrr::map(., f.storm.test)

max(rainfall)

san <- which(rainfall == min(rainfall))
san

mydf <- read_csv("./data/ne_counties.csv")

max(mydf$MedValHous)
which(mydf$MedValHous == max(mydf$MedValHous)) %>% mydf[.,]

newdf <- mydf %>% mutate(deviation = MedValHous - max(MedValHous))

newdf  %>%  ggplot(., aes(x = deviation)) +
  geom_histogram() +
  theme_minimal()

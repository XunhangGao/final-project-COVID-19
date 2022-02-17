library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)

Trips_by_Distance_National <- read.csv("Trips_by_Distance_National.csv")

# Chart
national_data_2019 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2019/12/31") %>%
  group_by(Month) %>%
  summarise(Population.Staying.at.Home = sum(Population.Staying.at.Home),
            Population.Not.Staying.at.Home = sum(Population.Not.Staying.at.Home),
            Number.of.Trips = sum(Number.of.Trips)) %>%
  mutate(year = c("2019"))

national_data_2020 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2020/12/31" & Date >"2019/12/31") %>%
  group_by(Month) %>%
  summarise(Population.Staying.at.Home = sum(Population.Staying.at.Home),
            Population.Not.Staying.at.Home = sum(Population.Not.Staying.at.Home),
            Number.of.Trips = sum(Number.of.Trips)) %>%
  mutate(year = c("2020"))

national_data <- rbind(national_data_2019, national_data_2020)
  
num_trips <- ggplot(data = national_data) +
  geom_bar(mapping = aes(x = factor(Month), y = Number.of.Trips, fill = year), position = "dodge", stat='identity') +
  labs(x = "Month", y = "numb of trips", title = "Totoal Numbers of Trips by Month")

active_num_trips <- ggplotly(num_trips)


  
  
  
  

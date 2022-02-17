#Exploratory Analysis
#Summary
library(dplyr)
library(magrittr)
library(knitr)
library(tidyverse)
library(ggplot2)

######## Store all five values in the list `summary_info` please  ######

summary_info <- list()

# Please set working directory to source file location
# before running the code below

# Quarantine part in the summary 
# The latest level of quarantine required by the US government 

quarantine <- read.csv("stay-at-home-covid.csv")
summary_info$q_country_number <- quarantine %>%
                                 group_by(Entity) %>%
                                 summarise(number = n()) %>%
                                 nrow()

summary_info$q_latest_day <-  quarantine %>%
                              arrange(desc(Day)) %>%
                              head(1) %>%
                              pull(Day)

summary_info$q_us_latest <- quarantine %>%
                            filter(Entity == "United States") %>%
                            arrange(desc(Day)) %>%
                            head(1) %>%
                            pull(Day)

summary_info$q_us_latest_level <- quarantine %>%
                                  filter(Entity == "United States") %>%
                                  arrange(desc(Day)) %>%
                                  head(1) %>%
                                  pull(stay_home_requirements)


# Global vaccination rate
global_vaccination <- read.csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv") %>% 
  filter(date == max(date), location == "World") %>% 
  select(location, date, people_fully_vaccinated)

global_population <- read.csv("https://raw.githubusercontent.com/owid/covid-19-data/master/scripts/input/un/population_latest.csv") %>% 
  filter(entity == "World") %>% 
  select(entity, population)

summary_info$global_vaccination_rate <- round(global_vaccination$people_fully_vaccinated[1] / global_population$population[1],
                                              digits = 2)


# Unemployment values in summary

unemployment_world <- read.csv("unemployment-rate.csv")

organized_unemployment <- unemployment_world %>%
  group_by(Entity) %>%
  mutate(average = mean(Unemployment..total....of.total.labor.force...modeled.ILO.estimate.)) %>%
  summarize(change = max(Unemployment..total....of.total.labor.force...modeled.ILO.estimate.) - 
              min(Unemployment..total....of.total.labor.force...modeled.ILO.estimate.))

summary_info$unemploy_max <- organized_unemployment %>%
  filter(change == max(change)) %>%
  pull(Entity)

summary_info$unemploy_min <- organized_unemployment %>%
  filter(change == min(change)) %>%
  pull(Entity)

summary_info$unemploy_us <- organized_unemployment %>%
  filter(Entity == "United States") %>%
  pull(change)

summary_info$unemploy_rise <- organized_unemployment %>%
  filter(change > 0) %>%
  nrow


# Transportation Summary Info
Trips_by_Distance_National <- read.csv("Trips_by_Distance_National.csv")
avg_numb_trips_2019 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2019/12/31") %>%
  summarise(avg = mean(Number.of.Trips)) %>%
  pull(avg)
avg_numb_trips_2019 <- format(avg_numb_trips_2019, scientific = FALSE)

avg_numb_trips_2020 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2020/12/31" & Date >"2019/12/31") %>%
  summarise(avg = mean(Number.of.Trips)) %>%
  pull(avg)
avg_numb_trips_2020 <- format(avg_numb_trips_2020, scientific = FALSE)

# number of stay home
avg_numb_home_2019 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2019/12/31") %>%
  summarise(avg = mean(Population.Staying.at.Home)) %>%
  pull(avg)
avg_numb_home_2019 <- format(avg_numb_home_2019, scientific = FALSE)

avg_numb_home_2020 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2020/12/31" & Date >"2019/12/31") %>%
  summarise(avg = mean(Population.Staying.at.Home)) %>%
  pull(avg)
avg_numb_home_2020 <- format(avg_numb_home_2020, scientific = FALSE)

# trips distance
trips_10miles_2019 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2019/12/31") %>%
  mutate(total = Number.of.Trips..1 + Number.of.Trips.3.5 + Number.of.Trips.5.10) %>%
  summarise(total = mean(total)) %>%
  pull(total)
trips_10miles_2019 <- format(trips_10miles_2019, scientific = FALSE)

trips_500miles_2019 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2019/12/31") %>%
  mutate(total = Number.of.Trips.10.25 + Number.of.Trips.25.50 + Number.of.Trips.50.100 + Number.of.Trips.100.250 + Number.of.Trips.250.500 + Number.of.Trips...500) %>%
  summarise(total = mean(total)) %>%
  pull(total)
trips_500miles_2019 <- format(trips_500miles_2019, scientific = FALSE)

trips_10miles_2020 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2020/12/31" & Date >"2019/12/31") %>%
  mutate(total = Number.of.Trips..1 + Number.of.Trips.3.5 + Number.of.Trips.5.10) %>%
  summarise(total = mean(total)) %>%
  pull(total)
trips_10miles_2020 <- format(trips_10miles_2020, scientific = FALSE)

trips_500miles_2020 <- Trips_by_Distance_National %>%
  filter(Level == "National") %>%
  filter(Date <= "2020/12/31" & Date >"2019/12/31") %>%
  mutate(total = Number.of.Trips.10.25 + Number.of.Trips.25.50 + Number.of.Trips.50.100 + Number.of.Trips.100.250 + Number.of.Trips.250.500 + Number.of.Trips...500) %>%
  summarise(total = mean(total)) %>%
  pull(total)
trips_500miles_2020 <- format(trips_500miles_2020, scientific = FALSE)










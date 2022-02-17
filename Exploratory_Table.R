library(dplyr)

vaccination <- read.csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv")
population <- read.csv("https://raw.githubusercontent.com/owid/covid-19-data/master/scripts/input/un/population_latest.csv") %>% 
  select(entity, population)

colnames(population) <- c("location", "population")

countries <- vaccination %>% 
  filter(location != "World") %>% 
  filter(!grepl("OWID", iso_code)) %>% 
  select(location, daily_people_vaccinated) %>% 
  group_by(location) %>%
  summarise(total_vaccinated = sum(daily_people_vaccinated, na.rm = T))

country_vacc_rate <- left_join(countries, population, by = "location") %>% 
  mutate(vaccination_rate = round(total_vaccinated / population, digits = 2)) %>% 
  arrange(desc(vaccination_rate))

colnames(country_vacc_rate) <- c("Country", "Total Number of People Vaccinated",
                                 "Population", "Vaccinatoin Rate")

table <- kable(country_vacc_rate)

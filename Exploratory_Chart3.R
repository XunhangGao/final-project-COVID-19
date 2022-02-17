#Exploratory Analysis
#Chart 3: Unemployment

library(dplyr)
library(magrittr)
library(knitr)
library(tidyverse)
library(ggplot2)
library(plotly)
library(maps)
library(reshape2)

# Please set working directory to source file location
# before running the code below

unemployment_world <- read.csv("unemployment-rate.csv")

organized <- unemployment_world %>%
  group_by(Entity) %>%
  mutate(average = mean(Unemployment..total....of.total.labor.force...modeled.ILO.estimate.)) %>%
  summarize(change = max(Unemployment..total....of.total.labor.force...modeled.ILO.estimate.) - 
           min(Unemployment..total....of.total.labor.force...modeled.ILO.estimate.))

trends <- unemployment_world %>%
  select("Entity", "Year", "Unemployment..total....of.total.labor.force...modeled.ILO.estimate.") %>%
  filter(Year > 2009) %>%
  filter(Entity == "United States" | Entity == "United Kingdom" | Entity == "China" | 
           Entity == "South Asia" | Entity == "Australia" | 
           Entity == "East Asia & Pacific" | Entity == "Russia" | Entity == "European Union" | 
           Entity == "Latin America & Caribbean" | Entity == "Middle East & North Africa" | 
           Entity == "South Africa") %>%
  melt(id.vars = c("Year", "Entity"))

line_chart <- ggplot(trends, aes(Year, value)) +
  geom_line(aes(color = Entity), size = 1) +
  labs(x = "Year", y = "Unemployment Rate(%)", color = "Coutry/Region") +
  ggtitle("Unemployment rate (selected countries/regions), 2010 to 2020")

unemployment_chart <- ggplotly(line_chart)

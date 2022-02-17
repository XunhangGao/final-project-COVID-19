#Exploratory Analysis
#Chart 1

library(dplyr)
library(magrittr)
library(knitr)
library(tidyverse)
library(ggplot2)
library(plotly)

# Please set working directory to source file location
# before running the code below

quaran <- read.csv("stay-at-home-covid.csv")
world <- map_data("world") 

quaran$Entity <- str_replace(quaran$Entity, "United States", "USA")

dataset <- quaran %>%
           filter(Day == "2021-01-08") %>%
           left_join(world, by=c("Entity"= "region" ))

map <- ggplot(data = dataset,  aes(x=long, y=lat)) +
  geom_polygon(aes(group = group, fill = stay_home_requirements, 
                   text = paste("</br>Stay Home Requirment:",stay_home_requirements,"</br>Country:", Entity))) +
  scale_fill_continuous(name = "Stay Home Requirment")+
  ggtitle("Quarantine Level required by countries on Jan.08.2021") 
          
quarantine_map <- ggplotly(map,tooltip = c("text"))


          
library(shiny)
library(DT)
library(plotly)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(coronavirus)
library(reshape2)
library(shinydashboard)
library(shinyWidgets)

source("app_server.R")

#read data file
trips_state_2019 <- read.csv("Trips_State_2019.csv")
trips_state_2020 <- read.csv("Trips_State_2020.csv")
covid_state_2020 <- read.csv("Covid_State_2020.csv")
quaran <- read.csv("stay-at-home-covid.csv")
quaran_unique <- unique(quaran %>% select(Entity))
total_confirmed <- read.csv("total_confirmed.csv")
total_confirmed_clean <- total_confirmed %>% select(location, date, new_cases)



intro_tab <- tabPanel(
  title = "Introduction",
  fluidPage(
    h1("Introduction", style = "color:white"),
    img(src = "image.png", height = 100, width = 300),
    p("COVID-19 is a sudden global pandemic that has affected the lives of 
      people around the world, including us. Thus we're looking at one of the 
      most important things that's happening in the world, looking at this 
      outbreak from a data point of view. Each of our group members will focus 
      on one particular problem related to COVID-19 and analyze datasets 
      corresponding to our topics.", style = "color:white"),
    
    h4("Global vaccination rate: ", style = "color:white"),
    p("Since the outbreak of COVID-19, the development of vaccines has been one of the top concerns. There are now several types of vaccines available, 
      and it is highly recommended to take COVID vaccine before we go somewhere else.
      What we am interested in is the vaccination rate around the world.", style = "color:white"),
    uiOutput("Vacc_url", style = "color:white"),
    uiOutput("Vacc_url2", style = "color:white"),
    
    h4("Quarantine data: ", style = "color:white"),
    p("Another focusing point is about COVID-19 quarantine. We all know quarantine 
      is an essential part of COVID-19 and everyone has experienced quarantine as 
      a demand from the state order. Hence, we're interested in the quarantine level demanded of every country during the pandemic, 
      and how long were they required to do so. Our project will not be only focusing on the US, 
      it will also cover quarantine datasets from all over the world. ", style = "color:white"),
    uiOutput("Quan_url", style = "color:white"),
    
    h4("Transportation data: ", style = "color:white"),
    p("We will also investigate the impacts of COVID-19 on transportation. 
      Under the consequences, such as stay home order and lock down, brought by the spread of COVID-19, 
      transportation was one the areas that were seriously influenced. 
      Due to the reduction of flights, I had to cancel my trips several times. 
      Thus, we're interested to find out how transportation was affected by COVID-19. ", style = "color:white"),
    uiOutput("Tran_url", style = "color:white"),
    
    h4("Unemployment rate data: ", style = "color:white"),
    p("We are also interested about the unemployment rate during the COVID outbreak. Employment has always been a huge concern across the world historically, 
      but COVID has hit harder than expected as mass unemployment struck multiple countries. ", style = "color:white"),
    uiOutput("Unempoly_url", style = "color:white"),
    p(" "),
    
    h4("Below is an image shows the hotspots of COVID-19.", style = "color:white"),
    img(src = "hotspot_covid.png", height = 700, width = 1200)
  )
)

###quarantine part
plot_tab1 <- tabPanel(
  title = "Worldwide Quarantine Level",
  h2("COVID-19 Quarantine Analysis", style = "color:white"),
  h3("What are the quarantine levels demanded by every country during the pandemic?", style = "color:white"),
  p("In order to know the relationship between COVID-19 and quarantine, 
    we have to check the quarantine level required by the government during a tension period 
    of COVID-19 in each country. By looking at the graph below, 
    you can see how the quarantine level required by each country is 
    changing over time, which reflect the COVID circumstances in each country. ", style = "color:white"),
  p("There are four levels of stay_home_requirements measured for countries:", style = "color:white"),
  textOutput("zero_measure"),
  tags$head(tags$style("#zero_measure{color: white;}")),
  textOutput("one_measure"),
  tags$head(tags$style("#one_measure{color: white;}")),
  textOutput("two_measure"),
  tags$head(tags$style("#two_measure{color: white;}")),
  textOutput("three_measure"),
  tags$head(tags$style("#three_measure{color: white;}")),
  p(" "),
  p("Try to interact with the plot below and choose the country you want to see the quarantine level change :) ", style = "color:white"),
  
  selectInput(
    inputId = "level_country_select",
    label = h5("Select the country you want to see its quarantine level change overtime:", style = "color:white"),
    choices = as.list(quaran_unique$Entity),
    selected = "United States"
  ),
  
  plotlyOutput(outputId = "quar_level_change_country"),
  plotlyOutput(outputId = "new_cases")
)

###Transportation part
plot1_side <- sidebarPanel(
  h3("Comparison of Residents Transportation Tendencies", style = "color:black"),
  p("In this page, the bar plot on the right provides a vidulization of
    comparison of residents' transportation tendencies between 2019 and 2020
    under the influences of COVID-19, showing variation of different variables,
    such as numbers of trips, of different states in U.S., and also shows the
    cases of COVID-19 in 2020 to help illustrate its impacts on the variables
    .", style = "color:black"),
  selectInput(
    inputId = "state_input",
    label = "State Selection",
    choices = state_option,
    selected = "WA"
  ),
  selectInput(
    inputId = "data_input",
    label = "Data Group Selection",
    choices = data_option,
    selected = "Population Staying at Home"
  ),
  sliderInput(
    "trip_filter_2019",
    "Trips filter 2019 (population)",
    min = 0,
    max = 100000000,
    0
  ),
  sliderInput(
    "trip_filter_2020",
    "Trips filter 2020 (population)",
    min = 0,
    max = 100000000,
    0
  )
)

###Transportation part
plot1_main <- mainPanel(
  plotlyOutput("customized_plot")
)

plot_tab2 <- tabPanel(
  title = "Influences on Transportation",
  h2("Transportation Analysis", style = "color:white"),
  h3("How transportation was affected by COVID-19?", style = "color:white"),
  p("In order to figure out the question above, try to interact with the plot below.", style = "color:white"),
  plot1_side,
  plot1_main
)

###unemployment part
plot3_side <- sidebarPanel(
  helpText("Comparison to the US in level of unemployment from 2020 onwards.", style = "color:black"),
  selectInput("country",
              label = "Choose country/region to display",
              choices = c("South Africa", "Middle East & North Africa", "China", 
                          "South Asia", "Australia", "East Asia & Pacific", 
                          "Russia", "European Union", "Latin America & Caribbean",
                          "United Kingdom"),
              selected = "South Africa"
  )
)

plot3_main <- mainPanel(
  plotlyOutput("lineplot")
)


plot_tab3 <- tabPanel(
  title = "Comparison of Unemployment Rates",
  h2("Unemployment Analysis", style = "color:white"),
  h3("What is the unemployment rate during the COVID outbreak?", style = "color:white"),
  p("In order to figure out the question above, try to interact with the plot below.", style = "color:white"),
  plot3_side,
  plot3_main
)

###Vaccination part
table_tab <- tabPanel(
  title = "COVID-19 Vaccination Rate By Country",
  h2("COVID-19 Vaccination Rate Analysis", style = "color:white"),
  h3("What is the vaccination rate around the world?", style = "color:white"),
  p("In order to figure out the question above, try to interact with the table below.", style = "color:white"),
  DT::dataTableOutput("table"),
  tags$head(tags$style("#table{background: white;}")),
  tags$head(tags$style("#table{color: black;}")),
)

summary_tab <- tabPanel(
  title = "Summary Takeaways",
  h2("Summary", style = "color:white"),
  p(" "),
  h3("Vaccination Rate", style = "color:white"),
  p("After the outbreak of COVID-19, the development of vaccines has been one of
    the top concerns. There are now several types of vaccines available, and it 
    is highly recommended to take COVID vaccine before we go somewhere else to 
    protect ourselves. Now the global vaccination rate is 0.42, which counts the
    ratio of the number of people who got at least one shot.", style = "color:white"),
  
  h3("Global Quarantine Level", style = "color:white"),
  p("From the quarantine data analysis, we can see the highest stay_home_requirements for the US is 
    Level 2 which implies the government require not leaving house with exceptions 
    for daily exercise, grocery shopping, and ‘essential’ trips during the server 
    COVID period in the US. Thus we can see the US government was trying to eliminate 
    outdoor activities as much as possible when we have the highest cases. 
    We also can see countries like China and Pakistan required Level 3 quarantine sometimes 
    which only allows minimal exception of leaving house. Quarantine helps country to reduce the spread of 
    COVID-19 and when we correspond the quarantine level with new confirmed cases, 
    we can see these two variables are clearly correlated ", style = "color:white"),
  
  h3("Transportation", style = "color:white"),
  p("During the last year under the influences of COVID-19, transportation
    experienced dramatic variation. From the data, ignoring the distances of
    trips, the average number of trips by residents per day in 2019 is
    1352383954, and the average population staying at home in 2019 is 63388644.
    The average number of trips by residents per day in 2020 is 1002128303, and
    the average population staying at home in 2020 is 81237730. Among all trips,
    those with short distances were influenced the most, the numbers of
    trips within 10 miles havs decreased from 704303279 in 2019 to 522491647 in
    2020. Obviously, more people chose to stay at home while reducing the short
    trips due to COVID-19.", style = "color:white"),

  h3("Unemployment Rate", style = "color:white"),
  p("It is clear that employment and workforce is one area that has been severely 
    impacted due to the outbreak of COVID. From the overall statistics of countries 
    and regions from 1991 to 2020, we could compute the overall range of the change 
    in unemployment rates of all countries and regions listed in the dataset. Out 
    of the 235 countries/regions in the dataset, all of them (235) experiences an 
    increase in the unemployment rate. For the United States, there is a increase 
    of 5.96% in unemployment rates. We can also identify the country/region with 
    highest and lowest increase in unemployment rates, which are Belarus and North 
    Korea respectively.", style = "color:white"),
  p("` "),
  p("` "),
  p("` "),
  h5("Authors: Wenhui Gong, Jiani Zhu, David Gao, Yuqi Wang", style = "color:white"),
  h5("Date: 2021/12/09", style = "color:white")
)

ui <- navbarPage(
  title = "COVID-19 Analysis",
  includeCSS("style.css"),
  setBackgroundImage(src = "bg.png"),
  tags$style(type = 'text/css', 
           '.navbar { background-color: lavender;}'),

  intro_tab,
  table_tab, ##vaccine
  plot_tab1, ##quarantine
  plot_tab2, ##transport
  plot_tab3,
  summary_tab
)
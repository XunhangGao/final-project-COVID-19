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

#read data file
trips_state_2019 <- read.csv("Trips_State_2019.csv")
trips_state_2020 <- read.csv("Trips_State_2020.csv")
covid_state_2020 <- read.csv("Covid_State_2020.csv")
quaran <- read.csv("stay-at-home-covid.csv")
quaran_unique <- unique(quaran %>% select(Entity))
total_confirmed <- read.csv("total_confirmed.csv")
total_confirmed_clean <- total_confirmed %>% select(location, date, new_cases)

# input support
state_option <- trips_state_2019 %>%
  select(State.Postal.Code) %>%
  distinct(State.Postal.Code, .keep_all= TRUE)
state_option <- as.data.frame(state_option[order(state_option),])

covid_state_2020 <- covid_state_2020 %>%
  mutate(year = c("covid cases 2020"))

data_option <- list("Population Staying at Home" = "Population.Staying.at.Home",
                    "Population not Staying at Home" = 
                      "Population.Not.Staying.at.Home",
                    "Number of Trips" = "Number.of.Trips",
                    "Number of Trips ( < 1 mile)" = "Number.of.Trips.1",
                    "Number of Trips ( 1 to 3 miles)" = "Number.of.Trips.1.3",
                    "Number of Trips ( 3 to 5 miles)" = "Number.of.Trips.3.5",
                    "Number of Trips ( 5 to 10 miles)" = "Number.of.Trips.5.10",
                    "Number of Trips ( 10 to 25 miles)" = 
                      "Number.of.Trips.10.25",
                    "Number of Trips ( 25 to 50 miles)" = 
                      "Number.of.Trips.25.50",
                    "Number of Trips ( 50 to 100 miles)" = 
                      "Number.of.Trips.50.100",
                    "Number of Trips ( 100 to 250 miles)" = 
                      "Number.of.Trips.100.250",
                    "Number of Trips ( 250 to 500 miles)" = 
                      "Number.of.Trips.250.500",
                    "Number of Trips ( > 500 miles)" = "Number.of.Trips.500")

normal <- c(
  "Population Staying at Home",
  "Population Not Staying at Home",
  "Number of Trips",
  "Number of Trips ( < 1 mile)",
  "Number of Trips (1 to 3 miles)",
  "Number of Trips (3 to 5 miles)",
  "Number of Trips (5 to 10 miles)",
  "Number of Trips (10 to 25 miles)",
  "Number of Trips (25 to 50 miles)",
  "Number of Trips (50 to 100 miles)",
  "Number of Trips (100 to 250 miles)",
  "Number of Trips (250 to 500 miles)",
  "Number of Trips ( > 500 miles)"
)

c_name <- c(
  "Population.Staying.at.Home",
  "Population.Not.Staying.at.Home",
  "Number.of.Trips",
  "Number.of.Trips.1",
  "Number.of.Trips.1.3",
  "Number.of.Trips.3.5",
  "Number.of.Trips.5.10",
  "Number.of.Trips.10.25",
  "Number.of.Trips.25.50",
  "Number.of.Trips.50.100",
  "Number.of.Trips.100.250",
  "Number.of.Trips.250.500",
  "Number.of.Trips.500"
)

variable_option <- data.frame(normal, c_name)

source("Exploratory_Table.R")
source("Exploratory_Chart3.R")

server <- function(input, output) {
  
  
  #intro url
  
  VR_url <- a("GitHub Data on COVID-19 (coronavirus) Vaccinations", href="https://github.com/owid/covid-19-data/tree/master/public/data/vaccinations/")
  output$Vacc_url <- renderUI({
    tagList("Global vaccination rate data from:", VR_url)
  })
  
  VR2_url <- a("GitHub Latest Population", href="https://github.com/owid/covid-19-data/blob/master/scripts/input/un/population_latest.csv")
  output$Vacc_url2 <- renderUI({
    tagList("Global vaccination rate data also from:", VR2_url)
  })
  
  quarn_url <- a("Our World in Data", href="https://ourworldindata.org/grapher/stay-at-home-covid")
  output$Quan_url <- renderUI({
    tagList("Quarantine data from:", quarn_url)
  })
  
  trans_url <- a("U.S. Department of Transportation", href="https://data.bts.gov/Research-and-Statistics/Trips-by-Distance/w96p-f2qv")
  output$Tran_url <- renderUI({
    tagList("Transportation data from:", trans_url)
  })
  
  unempoly <- a("Our World in Data", href="https://ourworldindata.org/grapher/unemployment-rate?tab=table")
  output$Unempoly_url <- renderUI({
    tagList("Unemployment rate data from", unempoly)
  })
  
  ##table part
  output$table = DT::renderDataTable({
    country_vacc_rate
  })
  
  ##transportation part
  output$customized_plot <- renderPlotly({
    trips_2019 <- trips_state_2019 %>%
      filter(State.Postal.Code == input$state_input) %>%
      mutate(selected = !!as.name(input$data_input)) %>%
      select(year, Month, selected) %>%
      filter(selected >= input$trip_filter_2019)
    
    trips_2020 <- trips_state_2020 %>%
      filter(State.Postal.Code == input$state_input) %>%
      mutate(selected = !!as.name(input$data_input)) %>%
      select(year, Month, selected) %>%
      filter(selected >= input$trip_filter_2020)
    
    covid_2020 <- covid_state_2020 %>%
      filter(State.Postal.Code == input$state_input) %>%
      mutate(selected = cases) %>%
      select(year, Month, selected)
    
    result <- rbind(covid_2020, trips_2020, trips_2019)
    
    y_name <- variable_option %>%
      filter(c_name == input$data_input) %>%
      pull(normal)
    
    p <- ggplot(data = result) +
      geom_bar(mapping = aes(x = factor(Month), y = selected, fill = year, 
                             text = paste("</br>Month:", factor(Month), "</br>Data group value:",selected, "</br>Year:", year  )),
               position = "dodge", stat='identity') +
      labs(x = "Month", y = y_name,
           title = paste0("COVID-19 Impacts on ", y_name, " in ",
                          input$state_input),
           fill = "data group") +
      theme(rect = element_blank())
    p <- ggplotly(p,tooltip = c("text"))
    return(p)
  })
  

###quarantine part 
  output$zero_measure <- renderText({
    text1 <- "   0 - No measures"
    return(text1)
  })
  
  output$one_measure <- renderText({
    text2 <- "   1 - recommend not leaving house"
    return(text2)
  })
  
  output$two_measure <- renderText({
    text3 <- "   2 - require not leaving house with exceptions for daily exercise, grocery shopping, and ‘essential’ trips"
    return(text3)
  })
  
  output$three_measure <- renderText({
    text4 <- "   3 - Require not leaving house with minimal exceptions (e.g. allowed to leave only once every few days, or only one person can leave at a time, etc.)"
    return(text4)
  })
  
  output$quar_level_change_country <- renderPlotly({
    level_change <- quaran %>%
      group_by(Entity)  %>%
      filter(Entity == input$level_country_select) 
    
    level_change_plotly <- plot_ly(
      data = level_change,
      x = ~Day,
      y = ~stay_home_requirements,
      type = "scatter",
      mode = "lines",
      hoverinfo = 'text',
      text = ~paste("</br> Date:", Day,
                    "</br> Quarantine Level:", stay_home_requirements)
    ) %>%
      layout (
        title = paste("Quarantine level change of", input$level_country_select,"over time"),
        yaxis = list(title = "Quarantine level")
      )
    return(level_change_plotly)
    
  })
  
  output$new_cases <- renderPlotly({
    #get input country's lastest date
    lastest <- total_confirmed_clean %>%
               filter(location == input$level_country_select) %>%
               arrange(as.Date(date)) %>% tail(1) %>%
               pull(date)
    
    total_confirmed_clean_range <- total_confirmed_clean %>%
        filter(location == input$level_country_select) %>%
        filter(date >= as.Date("2020-01-01"), date <= lastest)
    
    #now create new cases trend line plot
    new_confirmed_plotly <- plot_ly(
      data = total_confirmed_clean_range,
      x = ~date,
      y = ~new_cases,
      type = "scatter",
      mode = "lines",
      hoverinfo = 'text',
      text = ~paste("</br> Date:", date,
                    "</br> Daily New Cases:", new_cases)
    ) %>%
      layout (
        title = paste("Daily New confirmed COVID cases in", input$level_country_select,"during the same period in the above plot"),
        yaxis = list(title = "Daily New Confirmed cases"),
        xaxis = list(title = "Date")
      )
    return(new_confirmed_plotly)
  })
  
  
  
  ###unemployment part
  output$lineplot <- renderPlotly({
    selected <- trends %>%
      filter(Entity == input$country | Entity == "United States")
    
    # line_chart <- ggplot(selected, aes(Year, value, )) +
    #   geom_line(aes(color = Entity), size = 1) +
    #   labs(x = "Year", y = "Unemployment Rate(%)", color = "Coutry/Region") +
    #   ggtitle("Unemployment rate (selected countries/regions), 2010 to 2020")
    # ggplotly(line_chart)
    
    # fix Hover Text and title
    line_chart <- plot_ly(
      data = selected,
      x = ~Year,
      y = ~value,
      color = ~Entity,
      type = "scatter",
      mode = "lines",
      hoverinfo = 'text',
      text = ~paste("</br> Year:", Year,
                    "</br> Unemployment Rate:", value,
                    "</br> Country:", Entity)
    ) %>%
      layout (
        title = paste("Unemployment rate of", input$country,"and United States, 2010 to 2020"),
        yaxis = list(title = "Unemployment Rate(%)"),
        xaxis = list(title = "Year"),
        color = "Coutry/Region"
      )
    return(line_chart)
    
    
  })

}
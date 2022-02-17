## Info201 Final Project
### COVID-19 Project
#### Members: Wenhui Gong, Jiani Zhu, David Gao, Yuqi Wang
##  

## Project Proposal

#### **Why are you interested in this field/domain?**
  * COVID-19 is a sudden global pandemic that has affected the lives of people around the world, including us. Thus we're looking at one of the most important things that's happening in the world, looking at this outbreak from a data point of view. Each of our group members will focus on one particular problem related to COVID-19 and analyze datasets corresponding to our topics.



#### **What other examples of data driven project have you found related to this domain (share at least 3)?**

  * **Global vaccination rate**: Since the outbreak of COVID-19, the development of vaccines has been one of the top concerns. There are now several types of vaccines available, and it is highly recommended to take COVID vaccine before we go somewhere else. What we am interested in is the vaccination rate around the world. The related project we found is [More Than 7.26 Billion Shots Given: Covid-19 Tracker](https://www.bloomberg.com/graphics/covid-vaccine-tracker-global-distribution/), which shows lots of data visualizations about global vaccination.


  * **Quarantine data**: Another focusing point is about COVID-19 quarantine. We all know quarantine is an essential part of COVID-19 and everyone has experienced quarantine as a demand from the state order. Hence, we're interested in the number of people who are demanded to quarantine during the pandemic, and how long were they required to do so. The research will not be only focusing on the US, it will also cover quarantine datasets from all over the world. One project we found related to this quarantine topic is [Timing of State and Territorial COVID-19 Stay-at-Home Orders and Changes in Population Movement](https://www.cdc.gov/mmwr/volumes/69/wr/mm6935a2.htm?s_cid=mm6935a2_w#References) from CDC.

  * **Transportation data**: We will also investigate the impacts of COVID-19 on transportation. Under the consequences, such as stay home order and lock down, brought by the spread of COVID-19, transportation was one the areas that were seriously influenced. Due to the reduction of flights, I had to cancel my trips several times. Thus, we're interested to find out how transportation was affected by COVID-19. One similar research project we found is the [Post-Pandemic Travel Trends and Public Transit](https://www.its.ucla.edu/project/post-pandemic-travel-trends-and-public-transit/) by UCLA Institute of Transportation Studies.

  * **Unemployment rate data**: We are also interested about the unemployment rate during the COVID outbreak. Employment has always been a huge concern across the world historically, but COVID has hit harder than expected as mass unemployment struck multiple countries. One project that brought our attention to this impact of COVID was the research on [Unemployment Rates During the COVID-19 Pandemic](https://sgp.fas.org/crs/misc/R46554.pdf) by the Congressional Research Service.






#### **What data-driven questions do you hope to answer about this domain (share at least 3)?**
Questions can be answered from data are answered under another section below.

  * **Global vaccination rate data**:
      - What is the global vaccination rate?

  * **Quarantine data**:
      - What is the total number of people who are required to quarantine during COVID-19 in the world?
      - How long were they required to stay quarantined?
      - How much does it cost the governments for the quarantine order?

  * **Transportation data**:
      - What influences did the increases on COVID-19 cases have on the frequencies of trips by residents?
      - Did COVID-19 have impacts on the distance of trips by residents? If yes, what range of distance was affected the most.
      - Did the influences on transportation caused by COVID-19 share a similar pattern across all states?

  * **Unemployment rate data**:
  	- How has the unemployment rate changed over the years?
  	- How has the unemployment rate changed with respect to historical employment (when COVID hasn’t started)?
  	- How does the unemployment rate differ between countries?
  	- Do new policies made during COVID improve the current unemployment situation? Are they impactful enough that employment returns to normal after such policies are announced?





#### **Where did you download the data (e.g., a web URL)?**

  * Global vaccination rate data from: [GitHub Data on COVID-19 (coronavirus) Vaccinations](https://github.com/owid/covid-19-data/tree/master/public/data/vaccinations)  and
  [GitHub Latest Population](https://github.com/owid/covid-19-data/blob/master/scripts/input/un/population_latest.csv) .

  * Quarantine data from: [Our World in Data](https://ourworldindata.org/grapher/stay-at-home-covid) .

  * Transportation data from: [U.S. Department of Transportation](https://data.bts.gov/Research-and-Statistics/Trips-by-Distance/w96p-f2qv) .

  * Unemployment rate data from: [Our World in Data](https://ourworldindata.org/grapher/unemployment-rate?tab=table) .





#### **How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?**

  * **Global vaccination rate data**: The vaccination data is in vaccination.csv, and it is maintained by _Our World In Data_. This dataset is about country-by-country data on global COVID-19 vaccinations based on public official sources.

  * **Quarantine data**: The Oxford Covid-19 Government Response Tracker (OxCGRT) collects this dataset. The OxCGRT is a research project undertaken by the University of Oxford, they’ve been collecting data about government policies targeted to COVID-19 and other COVID related topics such as vaccinations, travels, etc. Our quarantine dataset from OxCGRT is about quarantine levels that are acquired at the country level, for the duration since 2020-01-01 until today.

  * **Transportation data**: The dataset is collected by Maryland Transportation Institute and Center for Advanced Transportation Technology Laboratory at the University of Maryland, spanning from 2019 to 2021. This data contains the daily information on number of people staying or not staying  at home and the frequencies of trips by residents with different distances( with 9 different ranges ) on national, state, and county levels.

  * **Unemployment rate data**: This piece of data is collected and published by World Development Indicators - World Bank (2021.07.30), spanning from 1999 to 2020. The information it contains came from the International Labor Organization. The table represents unemployment rate (as percentage of workforce) per country to ensure comparability across countries and over time and minimize discrepancies.



#### **How many observations (rows) are in your data?**

  * **Global vaccination rate data**: There are 59782 rows in vaccinations.csv file and 245 rows in population_latest.csv file.

  * **Quarantine data**: There are 185 countries included and 123494 rows in my dataset. Each row in my dataset represents a quarantine level required by a particular country on a particular date. Each country may have different total rows since some countries have latest data provided on today and some countries only have data provided until October.

  * **Transportation data**: There are 3,280,238 rows in total in this dataset, including daily transportation data at nation, states, and counties level everyday from 2019 to 2021.

  * **Unemployment rate data**: There are 7050 rows in this dataset, which represents countries at each year during the data collection process (1999 to 2020).




#### **How many features (columns) are in the data?**

  * **Global vaccination rate data**: There are 14 columns in vaccinations.csv file and 5 columns in population_latest.csv file.

  * **Quarantine data**: There are 4 columns in my dataset. They are `Entity`, `Code`, `Day` and `stay_home_requirements`. The `Entity` is the country’s name; `Code` is an abbreviation of the countries’ names; `Day` is the date collected the countries’ quarantine requirements; and `stay_home_requirements` are the quarantine level required by countries. `stay_home_requirements` are scaled from 0 to 3: 0 - No measures; 1 - recommend not leaving house; 2 - require not leaving house with exceptions for daily exercise, grocery shopping, and ‘essential’ trips; 3 - Require not leaving house with minimal exceptions (e.g. allowed to leave only once every few days, or only one person can leave at a time, etc).


  * **Transportation data**: There are 22 columns in the dataset, including `Level (National, State, County)`, `Date (ie: 2019-01-01)`, `State FIPS`, `State Postal Code (ie: CA)`, `County FIPS`, `County Name (ie: King)`, `Population Staying at Home (INT)`, `Population Not Staying at Home (INT)`, `Number of Trips (INT)`, `Number of Trips <1(mile) (INT)`, `Number of Trips 1-3(miles) (INT)`, `Number of Trips 3-5(miles) (INT)`, `Number of Trips 5-10(miles) (INT)`, `Number of Trips 10-25(miles) (INT)`, `Number of Trips 25-50(miles) (INT)`, `Number of Trips 50-100(miles) (INT)`, `Number of Trips 100-250(miles) (INT)`, `Number of Trips 250-500(miles) (INT)`, `Number of Trips >=500(miles) (INT)`, `Row ID`, `Week (of each year)`, `Month (form 1 to 12)`.

  * **Unemployment rate data**: There are 4 columns in this dataset, `Entity` which refers to the country or region that is concerned, `Code` which refers to the country/region’s code, `Year` which refers to the year at which data was collected at that region, and `Unemployment, total (% of total labor force) (modeled ILO estimate)`, which calculates percentage of unemployment with respect to the total work force in that country or region.



#### **What questions (from above) can be answered using the data in this dataset?**

  * **Global vaccination rate data**:
    - **What is the global vaccination rate?**

      Since the datasets we found contain information about the total number of population vaccinated in each country, so by adding up the total number of population vaccinated in each country and divided by the total number of population in the world, we will be able to calculate the global vaccination rate.

  * **Quarantine data**:
    - **What are the quarantine levels required by each countries’ governments?**

      We are able to get the quarantine levels required by each country by grouping the `Entity` column as countries in the dataset and filter a `Day` the user want to check the quarantine level.

    - **How many countries were required with mandatory quarantine orders during the pandemic (e.g: Level 3)?**

      For this question, we are able to examine two cases. The first case is the user want to check how many countries have ever set quarantine level to level 3. For this case we are able to get the answer by filtering the `stay_home_requirements` equals to  `3` and checkout which country have set their level to mandatory.

      The second case is the user want to check how many countries are requiring mandatory quarantine right now. For this case, we are able to get the answer by filtering the `Day` to the latest date in the dataset, and filtering the `stay_home_requirements` equals to  `3`.

    - **How are countries' quarantine requirements changed over time?**

      We are able to get the overall changing trends of a country or several countries by filtering the `Entity` column equals to the country we want to check. Then we can get all the `stay_home_requirements` set by the government in the dataset over a time period.

  * **Transportation data**:
    - **What influences did the increases on COVID-19 cases have on the frequencies of trips by residents?**

      With this data, we can use the column of number of trips to find the change in pattern according to time, time before and after the spread of COVID-19.

    - **Did COVID-19 have impacts on the distance of trips by residents? If yes, what range of distance was affected the most.**

      Since the data contains data about numbers of trips with different distance from 0 to 500 miles, we can calculate the changes in average numbers of each month before and after the spread of COVID-19 to investigate trips with which range of distances were influenced the most.

    - **Did the influences on transportation caused by COVID-19 share a similar pattern across all states?**

      As the data contains states level records, this question can be solved by calculating the changes of average numbers of trips in each state across the time and check if numbers of all the states increase or decrease.

  * **Unemployment rate data**:
  	- **How has the unemployment rate changed over the years?**

      This question can be answered by calculating the difference between the maximum and minimum of each country/region's unemployment rate throughout the required timespan.

  	- **How has the unemployment rate changed with respect to historical employment (when COVID hasn’t started)?**

      For this question, two different portions of data needs to be selected from the original dataset (1. the unemployment rate data during 2019-2020 and 2. the unemployment data before that). A line chart could be made to better illustrate change in trends of the unemployment rate.

  	- **How does the unemployment rate differ between countries?**

      This question is a comparison between country/regions, so this difference can be demonstrated via calculating the trends for each variable in the country/region domain and comparing these data. When analyzing, making charts (bar chart or line chart) would be a clear way to show this difference in a straightforward manner.
      

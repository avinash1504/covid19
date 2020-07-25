library(readr)
covid_df<-read.csv("C:/Users/avinash/Desktop/covid19.csv")
View(covid_df )
dim(covid_df)
vector_cols<-colnames(covid)
vector_cols
head(covid_df)
library(tibble)
glimpse(covid_df)
library(dplyr)
covid_df_all_states <- covid_df %>% 
  filter(Province_State == "All States") %>% 
  select(-Province_State)
covid_df_all_states_daily<-covid_df_all_states%>%
  select(Date, Country_Region, active, hospitalizedCurr, daily_tested, daily_positive)
head(covid_df_all_states_daily)
covid_df_all_states_daily <- covid_df_all_states %>% 
  group_by(Country_Region) %>% 
  summarise(tested = sum(daily_tested), 
            positive = sum(daily_positive),
            active = sum(active),
            hospitalized = sum(hospitalizedCurr)) %>% 
  arrange(desc(tested))
covid_df_all_states_daily
covid_top_10<-head(covid_df_all_states_daily,10)
covid_top_10
countries<-covid3$Country_Region
tested_cases<-covid3$tested
positive_cases<-covid3$positive
active_cases<-covid3$active
hosptializes_cases<-covid3$hospitalized
names(tested_cases)<-countries
names(active_cases)<-countries
names(positive_cases)<-countries
names(hosptializes_cases)<-countries
positive_cases/tested_cases
positive_tested_top_3<-c("United Kingdom" = 0.11,"United States"=0.10,"Turkey"=0.08)
United_Kingdom<-c(0.11, 1473672, 166909, 0, 0)
United_States<-c(0.10, 17282363, 1877179, 0, 0)
Turkey<-c(0.08,2031192, 163941, 2980960, 0)
covid_mat<-rbind(United_Kingdom,United_States,Turkey)
colnames(covid_mat)<-c("ratio","tested","positive","active","hospitalised")
covid_mat
question <- "Which countries have had the highest number of positive cases against the number of tests?"
answer <- c("Positive tested cases" = positive_tested_top_3)
datasets <- list(
  original = covid_df,
  allstates = covid_df_all_states,
  daily = covid_df_all_states_daily,
  top_10 = covid_top_10
)
matrices <- list(covid_mat)
vectors <- list(vector_cols, countries)
data_structure_list <- list("dataframe" = datasets, "matrix" = matrices, "vector" = vectors)
covid_analysis_list <- list(question, answer, data_structure_list)
covid_analysis_list[[2]]

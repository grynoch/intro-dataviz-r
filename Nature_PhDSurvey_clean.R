#Cleaning the 2019 Nature PhD Survey results for the introductory data 
#visualization class with R and ggplot2 class July and August 2022

#by Tess Grynoch

#install libraries
library(tidyverse)
library(readxl)


#import data
phdsurvey <- read_xlsx("data/Nature_PhD survey_Anon_v1.xlsx")

#remove first row which is a second header row
#merge country columns into a single column
#remove blank email column and columns asking about being added to mailing lists
phdsurvey2 <- phdsurvey %>% 
  slice(-1) %>% 
  unite(country, 17:29, na.rm = TRUE) %>% 
  select(Q65.a, Q4, Q5, country) %>% 
  rename(id = Q65.a,
         homestudy = Q4, 
         region = Q5) %>% 
  mutate(country = str_replace_all(.$country, "_To study at a specific university","")) %>% 
  mutate(country = str_replace_all(.$country, "Other, please specify_","")) %>% 
  group_by(country, homestudy, region) %>% 
  summarise(Total = n())

write.csv(phdsurvey2, file ="data/Nature_PhDsurvey_Anon_v2",row.names = FALSE)  


  


#load packages from library
library(tidyverse);library(janitor)
setwd('specdata')
#load data from all ids into 1 df
pollutant_files <-  suppressWarnings(map_df(list.files('specdata',pattern = '*.csv') %>% 
                                     lapply(read.csv),data.frame) %>% 
  clean_names())
#function gives mean of selected station ids for nitrate or sulfate
pollutant_mean <- function(ids, pollutant, df = pollutant_files,removeNA = TRUE) {
  
  mean((df %>% filter(id %in% ids))[[pollutant]], na.rm = removeNA)
  
}


complete <- function(ids, df = pollutant_files) {

    complete <- df %>% 
      mutate(nobs = ifelse(!is.na(sulfate) & !is.na(nitrate),1,0)) %>% 
      group_by(id) %>% summarise(nobs = sum(nobs)) %>% 
      filter(id %in% ids)
as.data.frame(complete[match(ids, complete$id),])
}


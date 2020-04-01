
#load packages from library
library(tidyverse);library(janitor)
setwd('specdata')
#load data from all ids into 1 df
pollutant_files <-  suppressWarnings(map_df(list.files(pattern = '*.csv') %>% 
                                     lapply(read.csv),data.frame) %>% 
  clean_names())

#function gives complete cases per ids supplied
complete <- function(ids, df = pollutant_files) {

    complete <- df %>% 
      mutate(nobs = ifelse(!is.na(sulfate) & !is.na(nitrate),1,0)) %>% 
      group_by(id) %>% summarise(nobs = sum(nobs)) %>% 
      filter(id %in% ids)
as.data.frame(complete[match(ids, complete$id),])

}



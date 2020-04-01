
#load packages from library
library(tidyverse);library(janitor);library(magrittr)
setwd('specdata')
#load data from all ids into 1 df
pollutant_files <-  suppressWarnings(map_df(list.files(pattern = '*.csv') %>% 
                                              lapply(read.csv),data.frame) %>% 
                                       clean_names())
t <- complete(1:332)  
poll_noNA <- pollutant_files %>% 
    mutate(nobs = ifelse(!is.na(sulfate) & !is.na(nitrate),1,0)) %>% 
  filter(nobs > 0) %>% select(-nobs) %>% left_join(t, by = 'id') %>% 
  set_colnames(c('date','sulfate','nitrate','id','ncomplete'))

cor(poll_noNA$sulfate,poll_noNA$nitrate)

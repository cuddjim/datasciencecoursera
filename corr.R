
#load packages from library
library(tidyverse);library(janitor);library(magrittr)
setwd('specdata')
#load data from all ids into 1 df
pollutant_files <-  suppressWarnings(map_df(list.files(pattern = '*.csv') %>% 
                                              lapply(read.csv),data.frame) %>% 
                                       clean_names())

#from complete.R
t <- complete(1:332)  


#join complete cases to t to show how many complete cases per id, filter by threshold
#apply cor function to each remaining id
corr <- function(threshold) {
  poll_noNA_test <- pollutant_files %>% 
    mutate(nobs = ifelse(!is.na(sulfate) & !is.na(nitrate),1,0)) %>% 
    filter(nobs > 0) %>% select(-nobs) %>% left_join(t, by = 'id') %>% filter(nobs > threshold)
  sapply(unique(poll_noNA_test$id), function(x) {
    poll_noNA_test %<>%  filter(id == x)
    l <- unlist(list(cor(poll_noNA_test$sulfate,poll_noNA_test$nitrate)))
  })}

#test
test <- corr(150)
head(test)
summary(test)






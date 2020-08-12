library(janitor);library(tidyverse);library(lubridate);library(readxl)

setwd("C:/Users/jimmy/OneDrive/Documents/repos/datasciencecoursera/expl_data_analysis/week1")

power <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",
                  nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"') %>% 
  mutate_at(vars(-c(Date,Time)),~as.numeric(.)) %>%
  mutate(Date = as.Date(Date, format = '%d/%m/%Y')) %>% 
  filter(between(Date,as.Date('2007-02-01'),as.Date('2007-02-02'))) %>% 
  mutate(datetime = as.POSIXct(paste(.$Date,.$Time)))






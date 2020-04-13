setwd('rprog_data_ProgAssignment3-data')
library(janitor);library(tidyverse);library(magrittr)

best <- function(state, outcome) {
  
  # read in data, clean names, change to numeric for desired columns
  outcomes <- read.csv('outcome-of-Care-measures.csv',colClasses = 'character') %>% clean_names()
  
  names(outcomes) <- gsub('hospital_30_day_death_mortality_rates_from_','',names(outcomes))
  names(outcomes) <- gsub('_',' ', names(outcomes))
  
  t <- outcomes %T>% {options(warn = -1)} %>% mutate_at(vars('heart attack', 'heart failure','pneumonia'),~as.numeric(.)) %>% 
    select(state, 'hospital name','heart attack','heart failure','pneumonia')
  
  outcome_event <- outcome
  selected_state <-  state
  
  # stop conditions for state and outcome
  if((selected_state %in% t$state) == FALSE) 
  
      stop('invalid state')
  
    else if((outcome_event %in% names(t)) == FALSE)
    
      stop('invalid outcome')
  
    else

# return hospital name, sorted by hospital name alphabetically if tie
    t %<>% filter(state == selected_state) %>% 
      select(state, 'hospital name',one_of(outcome_event)) %>% 
      drop_na(3) %>% 
      filter(.[[3]] == min(.[[3]])) %>% arrange(.[[2]])

  t[,2]

}




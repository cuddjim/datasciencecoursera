# load librairies
library(tidyverse);library(janitor);library(formattable);library(ggplot2)
# get data
if(!file.exists('data.zip')) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = 'data.zip', method = "curl")
  unzip('data.zip', exdir = ".")
}

summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

# filter for coal source emissions, summarise emission by year
plot4_data <- summary %>% left_join(source, by = 'SCC') %>% select(SCC, EI.Sector, year, Emissions) %>% 
  filter(grepl('[Cc]oal',EI.Sector)) %>% group_by(year) %>% summarise(Emissions = sum(Emissions, na.rm = T))

# create plot
png('plot4.png', width = 500, height = 500)

plot(plot4_data$Emissions~plot4_data$year, pch = 1, 
     ylab="Emissions per year (Tons)", xlab="Year", main = 'Emissions per year, coal sources, US, 1999-2008')



dev.off()

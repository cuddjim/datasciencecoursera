# load librairies
library(tidyverse);library(janitor);library(formattable);library(ggplot2)
# get data
if(!file.exists('data.zip')) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = 'data.zip', method = "curl")
  unzip('data.zip', exdir = ".")
}

summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

# filter for Baltimore, summarise emission by year and type
plot3_data <- summary %>% filter(fips == 24510) %>% group_by(year,type) %>% summarise(Emissions = sum(Emissions, na.rm = T))

# create plot
png('plot3.png', width = 500, height = 500)

ggplot(data = plot3_data, mapping = aes(x = year, y = Emissions)) +
  geom_point() + facet_grid(. ~ type) + ggtitle('Total emissions Baltimore, 1999-2008, by type')


dev.off()

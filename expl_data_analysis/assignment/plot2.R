# load librairies
library(tidyverse);library(janitor);library(formattable);library(ggplot2)
# get data
if(!file.exists('data.zip')) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = 'data.zip', method = "curl")
  unzip('data.zip', exdir = ".")
}

summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

# filter for Baltimore, summarise emission by year (all types)
plot2_data <- summary %>% filter(fips == 24510) %>% group_by(year) %>% summarise(Emissions = sum(Emissions, na.rm = T))

# create plot
png('plot2.png', width = 500, height = 500)

plot(plot2_data$Emissions~plot2_data$year, pch = 1, yaxt = 'n',
     ylab="Emissions per year (Tons)", xlab="Year", main = 'Emissions per year, Baltimore, 1999-2008')
marks <- comma(seq(0, plyr::round_any(max(plot2_data$Emissions),1000000, f = ceiling), by = 500),0)
axis(2,at = marks, labels = marks)


dev.off()

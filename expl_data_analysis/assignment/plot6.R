# load librairies
library(tidyverse);library(janitor);library(formattable);library(plotly);library(orca)
# get data
if(!file.exists('data.zip')) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = 'data.zip', method = "curl")
  unzip('data.zip', exdir = ".")
}

summary <- readRDS("summarySCC_PM25.rds")
source <- readRDS("Source_Classification_Code.rds")

# filter for coal source emissions, summarise emission by year
plot6_data <- summary %>% left_join(source, by = 'SCC') %>% select(SCC, EI.Sector, fips, year, Emissions) %>% 
  mutate(fips = as.numeric(fips)) %>% filter(grepl('[Vv]ehicle',EI.Sector), fips == c(24510,6037)) %>% group_by(year, fips) %>% 
  summarise(Emissions = sum(Emissions, na.rm = T)) %>% 
  mutate(fips = gsub('24510','Baltimore',fips),
         fips = gsub('6037','Los Angeles',fips))

# create plot
plot6 <- plot_ly() %>% 
  add_trace(data = plot6_data %>% filter(fips == 'Baltimore'), type = 'scatter', mode = 'markers', 
            x = ~year, y = ~Emissions, legendgroup = ~fips, name = 'Baltimore',
            hoverinfo = 'text', 
            text = ~paste0('test')) %>% 
  add_trace(data = plot6_data %>% filter(fips == 'Los Angeles'), type = 'scatter', mode = 'markers', 
            x = ~year, y = ~Emissions, legendgroup = ~fips, name = 'Los Angeles') %>% 
  layout(title = paste0('<b>','Baltimore and LA vehicle emissions, 1999-2008','</b>'))

library(webshot);library(htmlwidgets)

saveWidget(as.widget(plot6), "temp.html")
webshot("temp.html", file = "plot6.png",
        cliprect = "viewport")

source('C:/Users/jimmy/OneDrive/Documents/repos/datasciencecoursera/expl_data_analysis/week1/get_data.R')

# plot1

png("plot1.png", width=500, height=500)
hist(power$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')


dev.off()

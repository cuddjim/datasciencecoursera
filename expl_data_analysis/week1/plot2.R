source('C:/Users/jimmy/OneDrive/Documents/repos/datasciencecoursera/expl_data_analysis/week1/get_data.R')

# plot2

png("plot2.png", width=500, height=500)
plot(power$Global_active_power~power$datetime, type = 'l', ylab="Global Active Power (kilowatts)", xlab="")


dev.off()

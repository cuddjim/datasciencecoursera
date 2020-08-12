source('C:/Users/jimmy/OneDrive/Documents/repos/datasciencecoursera/expl_data_analysis/week1/get_data.R')

# plot3

png("plot3.png", width=500, height=500)
plot(power$Sub_metering_1~power$datetime, type = 'l', ylab="Energy sub metering", xlab="")
lines(power$Sub_metering_2~power$datetime, type = 'l', col = 'red')
lines(power$Sub_metering_3~power$datetime, type = 'l', col = 'blue')
legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col = c('black','red','blue'), lty=1, lwd=1)


dev.off()

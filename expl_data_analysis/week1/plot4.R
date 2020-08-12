source('C:/Users/jimmy/OneDrive/Documents/repos/datasciencecoursera/expl_data_analysis/week1/get_data.R')

# plot4

png("plot4.png", width=500, height=500)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(power,{
plot(power$Global_active_power~power$datetime, type = 'l', ylab="Global Active Power (kilowatts)", xlab="")
plot(power$Voltage~power$datetime, type = 'l', ylab="Voltage", xlab="")
plot(power$Sub_metering_1~power$datetime, type = 'l', ylab="Energy sub metering", xlab="")
lines(power$Sub_metering_2~power$datetime, type = 'l', col = 'red')
lines(power$Sub_metering_3~power$datetime, type = 'l', col = 'blue')
legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col = c('black','red','blue'), lty=1, lwd=1)
plot(power$Global_reactive_power~power$datetime, type = 'l', ylab="Global_reactive_power", xlab="")
})
dev.off()

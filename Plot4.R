#First we'll read the file in. Because the data is in chronological order,
#I'll only load in the rows from the relevant dates. Cheating? Maybe.
#Working efficiently? Absolutely.

power_data <- read.table("household_power_consumption.txt", header=F, 
                         sep=';', na.strings = "?", skip=66637, nrows=2880)


#Now we need the headers for our selection of rows.
column_names <- read.table("household_power_consumption.txt", header=T, sep=';', nrows=1)
colnames(power_data) <- colnames(column_names)

#Creating a new "datetime" column by smashing together the Date and Time,
#and then convert that column to a datetime using strptime().
#Finally, convert other columns to numeric.
power_data$datetime <- paste(power_data$Date, power_data$Time, sep=' ') 
power_data$datetime <- strptime(power_data$datetime, "%d/%m/%Y %T")
power_data$Global_active_power <- as.numeric(as.character(power_data$Global_active_power))
power_data$Global_reactive_power <- as.numeric(as.character(power_data$Global_reactive_power))
power_data$Voltage <- as.numeric(as.character(power_data$Voltage))
power_data$Sub_metering_1 <- as.numeric(as.character(power_data$Sub_metering_1))
power_data$Sub_metering_2 <- as.numeric(as.character(power_data$Sub_metering_2))
power_data$Sub_metering_3 <- as.numeric(as.character(power_data$Sub_metering_3))

png(filename='plot4.png', height=480, width=480)

#Time to plot the data!

#Plot 4 - sets layout of output
par(mfrow=c(2,2))

#plot1
plot(power_data$datetime, power_data$Global_active_power, 
     type='l',
     xlab='',
     ylab='Global Active Power (kilowatts)')

#plot2
plot(power_data$datetime, power_data$Voltage, 
     type='l',
     xlab='datetime',
     ylab='Voltage')

#plot3
plot(power_data$datetime, power_data$Sub_metering_1,  
     type="l", 
     xlab='', 
     ylab='Energy sub metering')
lines(power_data$datetime, power_data$Sub_metering_2, col="red")
lines(power_data$datetime, power_data$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty='n',
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot4
plot(power_data$datetime, power_data$Global_reactive_power, 
     type='l',
     xlab='datetime',
     ylab='Global_reactive_power')

dev.off()

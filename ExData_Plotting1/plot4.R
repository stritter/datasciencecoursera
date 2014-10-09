# Approximating the required memory for reading the data: 2080000 [rows] * 9 [columuns] * 8 [bytes/Numeric] / 2^20 [MB/bytes] = 142.82 MB => Reading the complete data without prior subsetting should be fine on this computer

# Reading the data, Variables are seperated by ";", change "?" to "NA"
data<-read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")

# Changing the variable Date in data to class Date, as.Date("1/1/2007", "%d/%m/%Y")
data$Date<-as.Date(data$Date,"%d/%m/%Y")

# Creating new variable DateTime containing the date and time, class Date/Time, to be able to plot Date/Time on (x-axis) later
data$DateTime<-strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")

# Subsetting the data to the dates 2007-02-02 and 2007-02-01
subset_data<-subset(data, data$Date=="2007-02-02" | data$Date=="2007-02-01")

# Creating png file
png(file="plot4.png")

# Defining Multiple Base Plots
par(mfrow = c(2, 2))

# Framework for the Base Plots
with(subset_data, {
	
	# Base Plot 1: top,left
	# Plotting the subset for the variable Global_active_power (y-axis) and variable DateTime (x-axis) and sending to png file
	plot(subset_data$DateTime, subset_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
	
	# Base Plot 2: top, right
	# Plotting the subset for the variable Voltage (y-axis) and variable DateTime (x-axis) and sending to png file
	plot(subset_data$DateTime, subset_data$Voltage, type="l", xlab="datetime", ylab="Voltage")	
	
	# Base Plot 3: bottom, left
	# Plotting subset for the variables Sub_metering_1..3 (y-axis) and variable DateTime (x-axis) and sending to png file
	with(subset_data, plot(DateTime,Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))

	# Adding Sub_metering_2
	with(subset_data, lines(DateTime,Sub_metering_2,col="red"))

	# Adding Sub_metering_3
	with(subset_data, lines(DateTime,Sub_metering_3,col="blue"))

	# Adding legend
	legend("topright", lty=1, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
	
	# Base Plot 4: bottom right
	# Plotting the subset for the variable Global_reactive_power (y-axis) and variable DateTime (x-axis) and sending to png file
	plot(subset_data$DateTime, subset_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
	
})

# Closing the file device
dev.off()

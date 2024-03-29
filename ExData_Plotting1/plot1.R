# 	Approximating the required memory for reading the data: 2080000 [rows] * 9 [columuns] * 8 [bytes/Numeric] / 2^20 [MB/bytes] = 142.82 MB => Reading the complete data without prior subsetting should be fine on this computer

# Reading the data, Variables are seperated by ";", change "?" to "NA"
data<-read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")

# Changing the variable Date in data to class Date, as.Date("1/1/2007", "%d/%m/%Y")
data$Date<-as.Date(data$Date,"%d/%m/%Y")

# Creating new variable DateTime containing the date and time, class Date/Time, not required to print histogram in plot1
data$DateTime<-strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")

# Subsetting the data to the dates 2007-02-02 and 2007-02-01
subset_data<-subset(data, data$Date=="2007-02-02" | data$Date=="2007-02-01")

# Creating png file
png(file="plot1.png")

# Plotting a histogram of the sebset for the variable Global_active_power and sending to png file
hist(subset_data$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

# Closing the file device
dev.off()

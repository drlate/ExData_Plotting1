# read entire csv file
bigData <- read.csv("household_power_consumption.txt", sep=";", as.is = TRUE, na.strings="?", colClasses=c("character","character", rep("numeric",7)))

# format dates and subset data based on date range
dates <- as.Date(bigData$Date, "%d/%m/%Y")
valid <- (dates >= "2007-02-01") & (dates <= "2007-02-02")

smallData <- bigData[valid,]
smallData$Date <- as.POSIXlt(paste(smallData$Date,smallData$Time), format="%d/%m/%Y %H:%M:%S")
df <- within(smallData, rm(Time))

# remove temporary variables
rm(bigData)
rm(dates)
rm(valid)
rm(smallData)

#### plot3.R

png("plot3.png")
plot(x=df$Date, y=df$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(x=df$Date, y=df$Sub_metering_1)
lines(x=df$Date, y=df$Sub_metering_2, col="red")
lines(x=df$Date, y=df$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))
dev.off()

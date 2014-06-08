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

#### plot2.R
plot(x=df$Date, y=df$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(x=df$Date, y=df$Global_active_power)

dev.copy(png, file="plot2.png")
dev.off()

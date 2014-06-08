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

#### plot1.R

hist(df$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

dev.copy(png, file="plot1.png")
dev.off()

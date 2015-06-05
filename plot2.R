## Load the sqldf package
library(sqldf)

## Download and unzip the source data
fileName = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileName, "electricalpowerconsumption.zip")
unzip("electricalpowerconsumption.zip")

## Read in data from household_power_consumption.txt file. Note that the results
## here are filtered down to only those records from Feb 1 & 2, 2007.
initialData <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")

## Combine Date and Time column and format as valid Date/Time
tempDateTimeList <- paste(initialData[,1], initialData[,2])
tempDateTimeList <- strptime(tempDateTimeList, "%d/%m/%Y %H:%M:%S")

## Add new Date/Time column and remove old Date and Time columns
powerConsumptionData <- cbind(initialData,tempDateTimeList)
powerConsumptionData <- powerConsumptionData[,c(10,3:9)]

## Change new Date/Time column heading
colnames(powerConsumptionData)[1] <- "datetime"

## Specify the output type
png("plot2.png", width=480, height=480, units="px", pointsize=12, bg="white", res=NA, family="", restoreConsole=TRUE, type=c("windows", "cairo", "cairo-png"))

## Create the line graph
plot(powerConsumptionData$datetime, powerConsumptionData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Close the PNG device to create the file
dev.off()
## Load the sqldf package
library(sqldf)

## Download and unzip the source data
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
colnames(powerConsumptionData)[1] <- "DateTime"
if(!file.exists('data')) {
  dir.create('data')
}

library(httr)
library(dplyr)
if(!require(sqldf)) install.packages("sqldf")
library(sqldf)
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
GET(fileURL, write_disk("./data/household_power.zip", overwrite = TRUE))
unzip("./data/household_power.zip", exdir = "./data")

data <- read.csv.sql("./data/household_power_consumption.txt", sep = ";", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
df <- data %>% mutate(DateTime = as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))

png("plot3.png")
with(df, {
   plot(DateTime, Sub_metering_1, type = "l", col = "black", ylab="Energy sub metering")
   lines(DateTime,Sub_metering_2, col = "red")
   lines(DateTime,Sub_metering_3, col = "blue")
})
legend('topright', col= c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1)
dev.off()



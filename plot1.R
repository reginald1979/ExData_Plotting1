if(!file.exists('data')) {
   dir.create('data')
}

library(httr)
if(!require(sqldf)) install.packages("sqldf")
library(sqldf)
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
GET(fileURL, write_disk("./data/household_power.zip", overwrite = TRUE))
unzip("./data/household_power.zip", exdir = "./data")

data <- read.csv.sql("./data/household_power_consumption.txt", sep = ";", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
png("plot1.png")
hist(data$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red",
     main = "Global Active Power")
dev.off()



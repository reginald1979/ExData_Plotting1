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

png("plot2.png")
with(df, plot(Global_active_power~DateTime, ylab="Global Active Power (kilowatts)", xlab="", type = "l"))
dev.off()
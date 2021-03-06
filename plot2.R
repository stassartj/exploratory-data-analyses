library(tidyr)
library(readr)
Sys.setenv(LANG = "en")

if(!file.exists("data")){dir.create("data")}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data/data.zip")


unzip("./data/data.zip", exdir = "./data")
power_consumption <- read_delim("data/household_power_consumption.txt", 
                                ";", escape_double = FALSE, col_types = cols(Date = col_date(format = "%d/%m/%Y"), 
                                                                             Time = col_time(format = "%H:%M:%S")), 
                                na = "?", trim_ws = TRUE)


subpower_consumption<- subset(power_consumption, (power_consumption$Date >= as.Date("2007-02-01", "%Y-%M-%d")) & (power_consumption$Date <= as.Date("2007-02-02" , "%Y-%M-%d")))





subpower_consumption$datetime <- as.POSIXct(paste(subpower_consumption$Date, subpower_consumption$Time), format="%Y-%m-%d %H:%M:%S")
png("plot2.png", width = 480, height = 480)

plot(subpower_consumption$datetime, subpower_consumption$Global_active_power, type = "l", ylab = "Gloal Active Power (kilowatts)", xlab = "", main = NULL)
#please note the days are in Portuguese because my R is installed in Portuguese

dev.off()

dev.off()
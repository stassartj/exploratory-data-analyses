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





png("plot3.png", width = 480, height = 480)
plot(subpower_consumption$datetime, subpower_consumption$Sub_metering_1, type = "n", ylab = "Gloal Active Power (kilowatts)", xlab = "", main = NULL)
lines(subpower_consumption$datetime ,subpower_consumption$Sub_metering_1, type = "l")
lines(subpower_consumption$datetime,  subpower_consumption$Sub_metering_2, type = "l", col = "red")
lines(subpower_consumption$datetime,  subpower_consumption$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
#please note the days are in Portuguese because my R is installed in Portuguese

dev.off()
library(lubridate)

#reading in raw data
raw <- read.table("./household_power_consumption.txt",
                  sep = ";",na.strings = "?",
                  header = TRUE )
head(raw)

#converting date and time into datetime column
raw$Date <- as.Date(raw$Date, format = "%d/%m/%Y")
raw$Time <- strptime(raw$Time, format = '%H:%M:%S')
raw$DateTime = as.POSIXct(paste(raw$Date, 
                                format(raw$Time, "%H:%M:%S")))

#filtering
needed <- subset(raw, DateTime >= as.Date("2007-02-01")
                 & DateTime < as.Date("2007-02-03"))

#set graphics device
png(filename = "plot2.png")

#figure 2
plot(needed$DateTime, needed$Global_active_power, 
     type ="l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

dev.off()
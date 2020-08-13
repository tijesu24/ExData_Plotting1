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
png(filename = "plot3.png")

#figure 3
plot(x=needed$DateTime, needed$Sub_metering_1, 
     type ="n",
     ylab = "Energy sub metering",
     xlab = "")

lines(needed$DateTime, needed$Sub_metering_1)
lines(needed$DateTime, needed$Sub_metering_2, 
      col = 'red')
lines(needed$DateTime, needed$Sub_metering_3,
      col = "blue")
legend("topright", 
       col = c("black","blue", "red"),
       lty = 1 ,
       legend = c("Sub_metering_1","Sub_metering_2",
                  "Sub_metering_3"))


dev.off()
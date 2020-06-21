tbl <- read.table(file = "household_power_consumption.txt", dec = ".", stringsAsFactors = FALSE, 
          colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header = TRUE, sep = ";", na.strings = "?")

# subset data to datab and remove tb1
datab <- filter(tbl, Date%in%c("1/2/2007", "2/2/2007"))
rm(tbl)

# new column date_time for x axis
datab$Date <- as.Date(datab$Date, "%d/%m/%Y")
datab <- mutate(datab, date_time = as.POSIXct(paste(datab$Date, datab$Time, sep=" "), template = "%d/%m/%Y %H:%M:%S", tz = Sys.timezone()))


## creation of plot4

png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

# Top-left
# Line, x = time_date, y = Global Active Power
plot(x=datab$date_time, y = datab$Global_active_power, type="l", col = "black", xlab="", ylab="Global active power")

# Top-right
# Line, x = time_date, y = Voltage, ylab: datetime
plot(x=datab$date_time, y = datab$Voltage, type="l", col = "black", ylab="Voltage", xlab = "datetime")

# Bottom-left
# Plot 3
with(datab, 
     { plot(x=date_time, y = Sub_metering_1, type="l", col = "black", xlab="", ylab="Energy sub metering")
       lines(x=date_time, y = Sub_metering_2, type="l", col = "red")
       lines(x=date_time, y = Sub_metering_3, type="l", col = "blue")
       legend("topright", lty = "solid", col = c("black", "red", "blue"), 
                      legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
     })

# Bottom-right
# Line, x = time_date, y = Global_reactive_power, ylim[0.0:0.5], ylab: datetime
plot(x=datab$date_time, y = datab$Global_reactive_power, type="l", col = "black", ylab="Global_reactive_power", xlab = "datetime")
dev.off()
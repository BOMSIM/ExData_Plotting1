tbl <- read.table(file = "household_power_consumption.txt", dec = ".", stringsAsFactors = FALSE, 
          colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header = TRUE, sep = ";", na.strings = "?")

# subset data to datab and remove tb1
datab <- filter(tbl, Date%in%c("1/2/2007", "2/2/2007"))
rm(tbl)

# new column date_time for x axis
datab$Date <- as.Date(datab$Date, "%d/%m/%Y")
datab <- mutate(datab, date_time = as.POSIXct(paste(datab$Date, datab$Time, sep=" "), template = "%d/%m/%Y %H:%M:%S", tz = Sys.timezone()))


## creation of plot3

png("plot3.png", width=480, height=480)
with(datab, 
     { plot(x=date_time, y = Sub_metering_1, type="l", col = "black", xlab="", ylab="Energy sub metering")
       lines(x=date_time, y = Sub_metering_2, type="l", col = "red")
       lines(x=date_time, y = Sub_metering_3, type="l", col = "blue")
       legend("topright", lty = "solid", col = c("black", "red", "blue"), 
                  legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
     })
dev.off()
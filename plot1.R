tbl <- read.table(file = "household_power_consumption.txt", dec = ".", stringsAsFactors = FALSE, 
          colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header = TRUE, sep = ";", na.strings = "?")

# subset data to datab and remove tb1
datab <- filter(tbl, Date%in%c("1/2/2007", "2/2/2007"))
rm(tbl)

# new column date_time for x axis
datab$Date <- as.Date(datab$Date, "%d/%m/%Y")
datab <- mutate(datab, date_time = as.POSIXct(paste(datab$Date, datab$Time, sep=" "), template = "%d/%m/%Y %H:%M:%S", tz = Sys.timezone()))


## creation of plot1
png("plot1.png", width=480, height=480)
hist(datab$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylim = c(0,1200), 
     xlim = c(0,6), breaks = 12)
dev.off()
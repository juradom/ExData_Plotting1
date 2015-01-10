library(data.table)
library(sqldf) 

# reset working directory
setwd("~/Documents/Coursera/ExData/ExData_Plotting1")

## download file and unzip file; set working directory
if(!file.exists("household_power_consumption.txt")){
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./power_consumption.zip")
    unzip("./power_consumption.zip")
}

# alias text name
hpc.txt <- "household_power_consumption.txt"

#create user-defined colClass
setClass("euroDate")
setAs("character","euroDate", function(from) as.Date(from, format="%d/%m/%Y"))

# define hpc as a file with indicated format 
hpc <- read.table(hpc.txt, header = TRUE, 
                  sep = ";", na.strings = "?", 
                  colClasses = c("euroDate", "character","numeric", 
                                 "numeric", "numeric","numeric", 
                                 "numeric", "numeric","numeric")
                  )

# subset to keep only indicated rows 
filteredHPC <- hpc[which(hpc$Date %in% as.Date(c('2007-02-01','2007-02-02'))),]


# create plot and write to png
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))

# top left plot
DateTime <- paste(filteredHPC$Date," ",filteredHPC$Time)
x <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")
y1 <- HPCDateTime$Global_active_power
with(HPCDateTime, plot(x, y1, type = "l", 
                       ylab = "Global Active Power (kilowatts)",
                       xlab = ""))

# bottom left plot
x <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")
y2a <- HPCDateTime$Sub_metering_1
y2b <- HPCDateTime$Sub_metering_2
y2c <- HPCDateTime$Sub_metering_3

with(HPCDateTime, plot(x, y2a, type = "l", 
                       ylab = "Energy sub metering",
                       xlab = ""))
with(HPCDateTime, points(x, y2b, type = "l", pch = "|", col = "red", lwd = "1"))
with(HPCDateTime, points(x, y2c, type = "l", pch = "|", col = "blue", lwd = "1"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1), col = c("black","red","blue"))

# top right plot
y1 <- HPCDateTime$Voltage
with(HPCDateTime, plot(x, y1, type = "l", 
                       ylab = "Voltage",
                       xlab = "datetime"))

# bottom right plot
y1 <- HPCDateTime$Global_reactive_power
with(HPCDateTime, plot(x, y1, type = "l", 
                       ylab = "Global_reactive_power",
                       xlab = "datetime"))

dev.off()





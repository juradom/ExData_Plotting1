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
png(filename = "plot1.png", width = 480, height = 480)

plot1 <- hist(filteredHPC$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency",
     xlim=c(0, 6), ylim=c(0, 1200))

dev.off()





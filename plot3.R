#check if the file is downloaded in wd, if not, download it

filename <- "household_power_consumption.txt"
if(!any(list.files()==filename)) {
  fileurl<- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipname <- "power.zip"
  download.file(fileurl, destfile = zipname)
  unzip(zipname)  
}


alldata <- read.table(filename,header = TRUE, sep=";", na.strings = "?")

alldata$Date <- as.Date(alldata$Date, "%d/%m/%Y")

subvect <- (alldata$Date == "2007-02-01" | alldata$Date == "2007-02-02")
subdata <- alldata[subvect,]

tdots <- as.POSIXct(paste(subdata$Date,subdata$Time), format = "%Y-%m-%d %T")

GAP <- subdata$Global_active_power


# 
# 
png(file = "plot3.png", width = 480, height = 480, units = "px")
plot(tdots, GAP, type = "n", ylab = "Energy sub metering", xlab = "", ylim = c(0,40), yaxt = "n")
points(tdots, subdata$Sub_metering_1, type = "l", pch = ".")

points(tdots, subdata$Sub_metering_2, pch = ".", type = "l", col = "red")

points(tdots, subdata$Sub_metering_3, pch = ".", type = "l", col = "blue")

axis(side = 2, at = c(0,10,20,30))
legend("topright",legend= c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lty=1)

dev.off()
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

par(pch = '.', cex = 0.01)

png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(tdots,GAP, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
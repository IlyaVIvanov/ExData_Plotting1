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


GAP <- subdata$Global_active_power
##hGAP <- hist(GAP, plot - )
stogramma <- hist(GAP, plot = FALSE)

png(file = "plot1.png", width = 480, height = 480, units = "px")
plot(stogramma,
     xlab = "Global Active Power (kilowatts)", 
     col="red", 
     main="Global Active Power", 
     ylim = c(0,1200),)

axis(side = 2, at = c(0,200,400,600,800,100,1200))

dev.off()
# project 1 #

## download file
furl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("project1")){
  dir.create("project1")
}
download.file(furl, destfile="./project1/dat.zip")
unzip(zipfile="./project1/dat.zip", exdir = "./project1")

## processing data
dat<-read.table("./project1/household_power_consumption.txt",
                sep=";", na.strings="?", header=TRUE)
datsub<-rbind(subset(dat, as.Date(dat$Date, "%d/%m/%Y")=="2007-02-01"),
              subset(dat,as.Date(dat$Date, "%d/%m/%Y")=="2007-02-02"))
## plot data
png(filename = "./project1/plot1.png", width = 480, height = 480)
hist(datsub$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()
# Project1 Plot 2 #

##download data
furl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("project1")){
  dir.create("project1")
}
download.file(furl, destfile="./project1/dat.zip")
unzip(zipfile="./project1/dat.zip", exdir = "./project1")

##process data
dat<-read.table("./project1/household_power_consumption.txt",
                sep=";", na.strings="?", header=TRUE)
datsub<-rbind(subset(dat,as.Date(dat$Date, "%d/%m/%Y")=="2007-02-01"),
              subset(dat,as.Date(dat$Date, "%d/%m/%Y")=="2007-02-02"))
timesub<-strptime(paste(datsub$Date,datsub$Time), "%d/%m/%Y %H:%M:%S")
weeksub<-weekdays(timesub, abbreviate=TRUE)
elapsesub<-timesub-timesub[1]
nsub<-length(weeksub)
xaxissub<-seq(as.numeric(elapsesub[1]),
              as.numeric(elapsesub[nsub]),
              length.out=3
              )

##plot data
png(filename = "./project1/plot2.png", width = 480, height = 480)
with (datsub, plot(elapsesub,Global_active_power, type="l",
                   xaxt="n", xlab="",
                   ylab="Global Active Power (Kilowatts)"))
axis(side=1, at=xaxissub, labels=c("Thu", "Fri", "Sat"))
dev.off()
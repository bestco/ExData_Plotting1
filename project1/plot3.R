# Project1 Plot 3 #

##download data
furl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("project1")){
  dir.create("project1")
}
download.file(furl,destfile="./project1/dat.zip")
unzip(zipfile="./project1/dat.zip", exdir = "./project1")

##process data
dat<-read.table("./project1/household_power_consumption.txt",
                sep=";", na.strings="?", header=TRUE)
datsub<-rbind(subset(dat,as.Date(dat$Date, "%d/%m/%Y")=="2007-02-01"),
              subset(dat,as.Date(dat$Date, "%d/%m/%Y")=="2007-02-02")
              )
timesub<-strptime(paste(datsub$Date, datsub$Time), "%d/%m/%Y %H:%M:%S")
weeksub<-weekdays(timesub, abbreviate=TRUE)
elapsesub<-timesub-timesub[1]
nsub<-length(weeksub)
xaxissub<-seq(as.numeric(elapsesub[1]),
              as.numeric(elapsesub[nsub]),
              length.out=3
              )

##plot data
png(filename = "./project1/plot3.png", width = 480, height = 480)
with (datsub, plot(elapsesub, Sub_metering_1,type="l",
                   xaxt="n", col="black", xlab="",
                   ylab="Energy sub metering"
                   )
      )
with (datsub, lines(elapsesub, Sub_metering_2,type="l", col="red"))
with (datsub, lines(elapsesub, Sub_metering_3,type="l", col="blue"))
axis(side=1,at=xaxissub,labels=c("Thu", "Fri", "Sat"))
legend("topright", col=c("black", "red", "blue"),
       lwd=2, lty=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"
                )
       )
dev.off()


install.packages("data.table")
library(data.table)
library(lubridate)
data2<-data.table(read.table("./household_power_consumption.txt",sep=";",header=TRUE))

data2$Date<-as.Date(data2$Date,"%d/%m/%Y")


data3<-data2[which(data2$Date==as.Date("2007-02-02","%Y-%m-%d") | data2$Date==as.Date("2007-02-01","%Y-%m-%d")),]

data3$Global_active_power<-as.numeric(levels(data3$Global_active_power))[data3$Global_active_power]
data3$Global_reactive_power<-as.numeric(levels(data3$Global_reactive_power))[data3$Global_reactive_power]

Sys.setlocale('LC_TIME', 'C')

data3$czas<-as.POSIXct(paste(data3$Date,data3$Time,sep=" "))

data3$Sub_metering_1<-as.numeric(levels(data3$Sub_metering_1))[data3$Sub_metering_1]
data3$Sub_metering_2<-as.numeric(levels(data3$Sub_metering_2))[data3$Sub_metering_2]


png(file ="plot4.png",width=480,height=480) 
par(mfrow=c(2,2))
with(data3,{
  with(data3,plot(czas,Global_active_power,type="l",xlab="",ylab="Global active power (kilowatts)"))
  with(data3,plot(czas,Voltage,type="l",xlab="Datetime",col="black"))
  with(data3,plot(czas,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col="black"))
  with(data3,points(czas,Sub_metering_2,type="l",col="red"))
  with(data3,points(czas,Sub_metering_3,type="l",col="blue"))
  legend("topright",pch=1,col=c("black","red","blue"),legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))
  with(data3,plot(czas,Global_reactive_power,type="l",xlab="Datetime",col="black"))
})
dev.off()


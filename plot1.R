

install.packages("data.table")
library(data.table)
library(lubridate)

data2<-data.table(read.table("./household_power_consumption.txt",sep=";",header=TRUE))

data2$Date<-as.Date(data2$Date,"%d/%m/%Y")

data3<-data2[which(data2$Date==as.Date("2007-02-02","%Y-%m-%d") | data2$Date==as.Date("2007-02-01","%Y-%m-%d")),]

data3$Global_active_power<-as.numeric(levels(data3$Global_active_power))[data3$Global_active_power]
data3$Global_reactive_power<-as.numeric(levels(data3$Global_reactive_power))[data3$Global_reactive_power]


png(file ="plot1.png",width=480,height=480) 
with(data3,hist(Global_active_power,col="red",xlab="Global active power (kilowatts)",main="Global Active Power"))
dev.off()


## Load file
Global_Active_Power<-read.table("household_power_consumption.txt",header=TRUE,sep=";",,na.strings=c("?"))

## transform fields do valida datatypes
Global_Active_Power$Global_active_power <- as.numeric( as.character( Global_Active_Power$Global_active_power ) )
Global_Active_Power$Global_reactive_power <- as.numeric( as.character( Global_Active_Power$Global_reactive_power ) )
Global_Active_Power$Voltage <- as.numeric( as.character( Global_Active_Power$Voltage ) )
Global_Active_Power$Sub_metering_1 <- as.numeric( as.character( Global_Active_Power$Sub_metering_1 ) )
Global_Active_Power$Sub_metering_2 <- as.numeric( as.character( Global_Active_Power$Sub_metering_2 ) )
Global_Active_Power$Sub_metering_3 <- as.numeric( as.character( Global_Active_Power$Sub_metering_3 ) )

##create new DateTime field
dateTime <- paste( Global_Active_Power$Date, Global_Active_Power$Time )
Global_Active_Power$DateTime <- strptime( dateTime, format = "%d/%m/%Y %H:%M:%S" )
rm(dateTime)
## Set week days from PT to Eng
Sys.setlocale("LC_TIME","US")

## Filter File for 
Global_Active_Power <- subset(Global_Active_Power,Global_Active_Power$DateTime>=as.POSIXct('2007-02-01 00:00:00') &  Global_Active_Power$DateTime<as.POSIXct('2007-02-03 00:00:00'))

## create Plot3 to file
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")

plot(Global_Active_Power$DateTime,Global_Active_Power$Sub_metering_1,main=" ", type="l",xlab=" ",ylab="Energy sub metering")
lines(Global_Active_Power$DateTime,Global_Active_Power$Sub_metering_2,lty=1,pch=0,col="red")
lines(Global_Active_Power$DateTime,Global_Active_Power$Sub_metering_3,lty=1,pch=0,col="blue")
legend("topright",lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))

dev.off()



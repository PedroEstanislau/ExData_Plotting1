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

## create Plot1 to file
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(
        Global_Active_Power$Global_active_power, 
        breaks=12, 
        col="red", 
        main="Global Active Power", 
        xlab="Global Active Power (kilowatts)",
        freq=TRUE
        )
dev.off()


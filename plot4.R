library(dplyr)
library(lubridate)


if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip",
                method="curl")
  unzip("data.zip")  
}

power <- read.csv("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors=FALSE,na.strings="?")
power_t <- tbl_df(power)
power_2days <- filter(power_t,Date %in% c("1/2/2007","2/2/2007")) 
power_2days$DateTime<-dmy(power_2days$Date)+hms(power_2days$Time)
power_2days$DateTime<-as.POSIXlt(power_2days$DateTime)


png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))

#1st plot
plot(power_2days$DateTime,power_2days$Global_active_power, type= "l", ylab="Global Active Power (kilowatts)", xlab=NA)

#2nd plot
plot(power_2days$DateTime,power_2days$Voltage, type= "l", ylab="Voltage", xlab="datetime")

#3rd plot
plot(power_2days$DateTime,power_2days$Sub_metering_1, type= "l", ylab="Energy sub metering", xlab=NA, color="black")
lines(power_2days$DateTime, power_2days$Sub_metering_2, col="red")
lines(power_2days$DateTime, power_2days$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4th plot
plot(power_2days$DateTime,power_2days$Global_reactive_power, type= "l", ylab="Global_reactive_power", xlab="datetime")

dev.off()
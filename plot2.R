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


png("plot2.png",width=480,height=480)
plot(power_2days$DateTime,power_2days$Global_active_power, type= "l", ylab="Global Active Power (kilowatts)", xlab=NA)
dev.off()
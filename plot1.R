library(dplyr)

#setwd("~/ExData_Plotting")

if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip",
                method="curl")
  unzip("data.zip")  
}
power <- read.csv("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors=FALSE,na.strings="?")
power_t <- tbl_df(power)

power_2days <- filter(power_t,Date %in% c("1/2/2007","2/2/2007")) 

png("plot1.png",width=480,height=480)
hist(power_2days$Global_active_power,xlab="Global Active Power (kilowatts)", main="Global Active Power",c="red")
dev.off()
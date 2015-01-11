#read the data into a data frame
powerDS <- read.csv("household_power_consumption.txt", sep=";", colClasses=c("character", "character", rep("numeric", 7)), na.strings="?")

#just get the subset that is for Feb 1 and 2 in 2007
power2DS <- subset(powerDS, Date == "1/2/2007" | Date == "2/2/2007")

#create a new column that includes both date and time
power2DS$DateTime <- paste(power2DS$Date, power2DS$Time)

#convert the new DateTime column in to a POSIXlt column
power3DS <- transform(power2DS, DateTime=strptime(DateTime, format="%d/%m/%Y %H:%M:%S"))

#create a png graphics device
png(file="plot1.png")

#create a histogram plot
hist(power3DS$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

#finalize the png device
dev.off()
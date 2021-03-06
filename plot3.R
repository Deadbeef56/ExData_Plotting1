#read the data into a data frame
powerDS <- read.csv("household_power_consumption.txt", sep=";", colClasses=c("character", "character", rep("numeric", 7)), na.strings="?")

#just get the subset that is for Feb 1 and 2 in 2007
power2DS <- subset(powerDS, Date == "1/2/2007" | Date == "2/2/2007")

#create a new column that includes both date and time
power2DS$DateTime <- paste(power2DS$Date, power2DS$Time)

#convert the new DateTime column in to a POSIXlt column
power3DS <- transform(power2DS, DateTime=strptime(DateTime, format="%d/%m/%Y %H:%M:%S"))

#create a png graphics device
png(file="plot3.png")

#create an empty line plot
plot(power3DS$DateTime, power3DS$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")

#add line plot for Sub_metering_1
lines(power3DS$DateTime, power3DS$Sub_metering_1, type="l", col="black")

#add line plot for Sub_metering_2
lines(power3DS$DateTime, power3DS$Sub_metering_2, type="l", col="red")

#add line plot for Sub_metering_3
lines(power3DS$DateTime, power3DS$Sub_metering_3, type="l", col="blue")

#add legend box
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  lwd="2")

#finalize
dev.off()
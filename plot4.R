#script to generate a graphic from power consumption data

#step1 - Read original data from file into memory
origin_data <- read.csv("household_power_consumption.txt",sep=";")

#step2 - Select only interval between 2007-02-01 and 2007-02-02
data1<-origin_data[origin_data$Date=="1/2/2007",]
data2<-origin_data[origin_data$Date=="2/2/2007",]
origin_data2<-rbind(data1,data2)
rm(data1);rm(data2)

#step3 - Transform Date and Time in DateTime
origin_data3 <- data.frame(strptime(paste(origin_data2$Date,origin_data2$Time),"%d/%m/%Y %H:%M:%S"),origin_data2)
names(origin_data3) <- c("datetime","Date","Time","GAP","GRP","V","GI","SM1","SM2","SM3")

#step4 - Plot fourth graphic in screen device
#PLEASE NOTE: My language for Date Type is BRAZILIAN PORTUGUESE
# Thuesday=Quinta-feira, Friday=Sexta-feira, Saturday=Sábado
par(mfrow=c(2,2))
plot(origin_data3$datetime,as.numeric(paste(origin_data3$GAP)),type="l",xlab="",ylab="Global Active Power")

plot(origin_data3$datetime,as.numeric(paste(origin_data3$V)),type="l",xlab="datetime",ylab="Voltage")

plot(origin_data3$datetime,as.numeric(paste(origin_data3$SM1)),type="l",xlab="",ylab="Energy sub metering",col="black")
lines(origin_data3$datetime,as.numeric(paste(origin_data3$SM2)),type="l",col="red")
lines(origin_data3$datetime,as.numeric(paste(origin_data3$SM3)),type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,col=c("black","red","blue"),pt.cex=1,cex=.5)

plot(origin_data3$datetime,as.numeric(paste(origin_data3$GRP)),type="l",xlab="datetime",ylab="Global Reactive Power")

#step5 - Save PNG file from a copy of screen device
dev.copy(png,"plot4.png",width = 480,height = 480)
dev.off()

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

#step4 - Plot second graphic in screen device
#PLEASE NOTE: My language for Date Type is BRAZILIAN PORTUGUESE
# Thuesday=Quinta-feira, Friday=Sexta-feira, Saturday=Sábado
plot(origin_data3$datetime,as.numeric(paste(origin_data3$GAP)),type="l",xlab="",ylab="Global Active Power (kilowatts)")

#step5 - Save PNG file from a copy of screen device
dev.copy(png,"plot2.png",width = 480,height = 480)
dev.off()

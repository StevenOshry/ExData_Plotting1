# project1 - read in text file for 2 days of data
# set working directory to where text file is
df<- read.table("household_power_consumption.txt", sep=";",header=TRUE, 
                stringsAsFactors=FALSE, na.strings="?")
names(df)[1]="date_string"

df$Date<-as.Date(df$date_string, "%d/%m/%Y")
df2 <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")
# delete big data frame since we only need 2 days
rm(df)
df2$datetime <-strptime(paste(df2$date_string,df2$Time),"%d/%m/%Y %H:%M:%S" )


#plot 4
# 2 rows and 2 cols
par(mfrow=c(2,2))
par(mar=c(4,4,1,1))
# plot top left

with (df2, plot( datetime ,Global_active_power, type="l",  main="" 
                 ,xlab="",
                 ylab="Global Active Power")
)

#plot top right


with (df2, plot( datetime ,Voltage, type="l",  main="" 
                 ,xlab="datetime",
                 ylab="Voltage")
)
#plot lower left
#set up base
with(df2, plot( datetime ,Sub_metering_1, type="n",  main="" 
      ,xlab="",
      ylab="Energy sub metering",
      )
)
# add lines for each type of sub metering
with(df2, lines( datetime ,Sub_metering_1))
with(df2, lines( datetime ,Sub_metering_2, col="red") )
with(df2, lines( datetime ,Sub_metering_3, col="blue") )
# add legend in top right, use cex to make legend slightly smaller to look like example
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ),
       lty=c(1,1,1),col=c("black","red","blue"),x.intersp=0.3,cex=0.8,
       pt.cex=0.8, bty="n" )

#plot lower right
with (df2, plot( datetime ,Global_reactive_power, type="l",  main="" 
                 ,xlab="datetime",
                 ylab="Global_reactive_power", lty=1)
)

# write to png file

dev.copy(png,  width = 480, height = 480, units = "px", 'plot4.png')
dev.off()

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


#plot 3
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
       lty=c(1,1,1),col=c("black","red","blue"), cex=0.75)

# write to png file

dev.copy(png,  width = 480, height = 480, units = "px", 'plot3.png')
dev.off()

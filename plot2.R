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


#plot 2

with (df2, plot( datetime ,Global_active_power, type="l",  main="" 
      ,xlab="",
      ylab="Global Active Power (kilowatts)")
)
      dev.copy(png,  width = 480, height = 480, units = "px", 'plot2.png')
dev.off()

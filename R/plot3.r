# Plot 3


#### Following code same in all plots

# Setting working directory.
oldWD <- getwd()
setwd("C:/Users/Rocket Ship/Desktop/R")

# Downloading, unzipping data (if not already downloaded, unzipped).
# Code borrowed from David Hood 
# (https://class.coursera.org/getdata-006/forum/thread?thread_id=43#comment-401)
targetUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
targetLocalfile = "household_power_consumption.zip"
if (!file.exists(targetLocalfile)) {
  download.file(targetUrl, targetLocalfile) #may need modifying if binary etc
  library(tools)       # for md5 checksum
  sink("downloadMetadata.txt")
  print("Download date:")
  print(Sys.time() )
  print("Download URL:")
  print(targetUrl)
  print("Downloaded file Information")
  print(file.info(targetLocalfile))
  print("Downloaded file md5 Checksum")
  print(md5sum(targetLocalfile))
  sink()
}
unzippedFile = "household_power_consumption.txt"
if (!file.exists(unzippedFile)) {
  unzip(targetLocalfile) 
  sink("unzip_metadata.txt")
  print("Unzip date:")
  print(Sys.time() )
  print("Unzipped file Information")
  print(file.info(targetLocalfile))
  sink()
}

# Reading data into R
data <- read.csv2(paste("./", unzippedFile, sep=""), stringsAsFactors = FALSE)

# Getting dates/ times into useable format
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, format = "%d/%m/%Y %H:%M:%S", tz = "CET")

# Cutting unused dates
data <- data[as.Date(data$datetime) >= as.Date("2007-02-01"), ]
data <- data[as.Date(data$datetime) <= as.Date("2007-02-02"), ]




#### Code specific to plot 3

# Opening png device
png("plot3.png", width = 480, height = 480)

# Making plot
with(data, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(data, lines(datetime, Sub_metering_2, col = "red"))
with(data, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = colnames(data)[7:9])





#### Code same in all plots

# Closing png device
dev.off()

# Resetting previous working directory
setwd(oldWD)
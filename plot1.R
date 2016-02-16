           
## Expects "household_power_consumption.txt" in the current working diretory

library(data.table)
library(dplyr)

## read the data and filter it for just the two dates 2007-02-01 and 2007-02-02
dat <-
    fread("household_power_consumption.txt", stringsAsFactors = F,
          select = c("Date", "Global_active_power"), na.strings = c("?")) %>%
    filter(grepl("^0?[12]/0?2/2007$", Date))

## plot the required Histogram...
hist(dat$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (killowatts)")

## and copy the plot to PNG file "plot1.png" and close the device
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

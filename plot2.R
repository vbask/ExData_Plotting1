           
## Expects "household_power_consumption.txt" in the current working diretory

library(data.table)
library(dplyr)

## read the data and filter it for just the two dates 2007-02-01 and 2007-02-02
dat <-
  fread("household_power_consumption.txt",  na.strings = c("?"),
        select = c("Date", "Time", "Global_active_power"), stringsAsFactors=F) %>%
  filter(grepl("^0?[12]/0?2/2007$", Date)) %>%
  mutate(DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

## Create the plot-2 on the default screen device
with(dat, plot(DateTime, Global_active_power, type = "l", xlab = "",
               ylab = "Global Active Power (killowatts)"))

## copy the plot to PNG file: "plot2.png"
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()  # and close the device


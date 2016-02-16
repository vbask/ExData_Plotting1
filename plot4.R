
## Construction of "Plot 4" plots...
## Expects "household_power_consumption.txt" in the current working diretory

library(data.table)
library(dplyr)

par(mfrow = c(2, 2), mar = c(6, 4, 2, 2))

## read the data, and filter it for just the two dates 2007-02-01 and 2007-02-02
dat <-
  fread("household_power_consumption.txt", na.strings = c("?"),
        drop = c("Global_intensity"), stringsAsFactors=F) %>%
  filter(grepl("^0?[12]/0?2/2007$", Date)) %>%
  mutate(DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

## Construct plot-4 plots on the default screen device
with(dat, {
        ## plot: 1-1
        plot(DateTime, Global_active_power, type = "l",
             xlab = "", ylab = "Global Active Power")
        
        ## plot: 1-2
        plot(DateTime, Voltage, type = "l", xlab = "datetime")
              
        ## plot: 2-1
        plot(DateTime, Sub_metering_1, type = "l", col="black",
                       xlab = "", ylab = "Energy sub metering")
        points(DateTime, Sub_metering_2, type = "l", col="red")
        points(DateTime, Sub_metering_3, type = "l", col="blue")
        leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        legend("topright", col = c("black", "red", "blue"), legend = leg.txt,
               text.width = strwidth(leg.txt) + 5, bty = "n", cex = 0.7, lwd = 1)

        ## plot: 2-2
        plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
  })

## copy the plot to PNG file: "plot4.png"
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()  # and close the device


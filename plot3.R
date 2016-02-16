
## Expects "household_power_consumption.txt" in the current working diretory

library(data.table)
library(dplyr)

## Data variables needed for Plot-3
reqd_cols <- c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Read the data and filter it for just the two dates 2007-02-01 and 2007-02-02
dat <-
  fread("household_power_consumption.txt", na.strings = c("?"),
        select = reqd_cols, stringsAsFactors=F) %>%
  filter(grepl("^0?[12]/0?2/2007$", Date)) %>%
  mutate(DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

## Construct plot-3 on the default screen device
par(mar = c(8, 4, 4, 4), cex = 0.9) # set plot margins
with(dat, {
            plot(DateTime, Sub_metering_1, type = "l", col="black",
                 xlab = "", ylab = "Energy sub metering")
            points(DateTime, Sub_metering_2, type = "l", col="red")
            points(DateTime, Sub_metering_3, type = "l", col="blue")
        })

## Add Legend
leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", col = c("black", "red", "blue"), legend = leg.txt,
       text.width = strwidth(leg.txt) + 8, cex = 0.7, lwd = 1)

## Copy the plot to PNG file: "plot3.png", and close the device
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()


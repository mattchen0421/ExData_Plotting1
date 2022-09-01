library(tidyverse)
library(lubridate)
library(gridExtra)

power <- read.csv("household_power_consumption.txt", sep=";")
power_2 <- filter(power, Date %in% c("1/2/2007", "2/2/2007"))
power_2$datetime <- str_c(power_2$Date, power_2$Time, sep = "/")
power_2$datetime <- dmy_hms(power_2$datetime)
power_2$Global_active_power <- as.numeric(power_2$Global_active_power)
power_2$Sub_metering_1 <- as.numeric(power_2$Sub_metering_1)
power_2$Sub_metering_2 <- as.numeric(power_2$Sub_metering_2)
power_2$Sub_metering_3 <- as.numeric(power_2$Sub_metering_3)
power_2$Voltage <- as.numeric(power_2$Voltage)
power_2$Global_reactive_power <- as.numeric(power_2$Global_reactive_power)

p1 <- ggplot(power_2) +
    geom_line(mapping = aes(x = datetime,
                            y = Global_active_power),
              size = 0.1) +
    scale_x_datetime(date_labels = "%a",
                     date_breaks = "1 day") +
    labs(x = "", y = "Global Active Power")

p2 <- ggplot(power_2) +
    geom_line(mapping = aes(x = datetime,
                            y = Voltage),
              size = 0.1) +
    scale_x_datetime(date_labels = "%a",
                     date_breaks = "1 day") 

p3 <- ggplot(power_2) +
    geom_line(mapping = aes(x = datetime,
                            y = Sub_metering_1,
                            color = "Sub_metering_1"),
              size = 0.1) +
    geom_line(mapping = aes(x = datetime,
                            y = Sub_metering_2,
                            color = "Sub_metering_2"),
              size = 0.1) +
    geom_line(mapping = aes(x = datetime,
                            y = Sub_metering_3,
                            color = "Sub_metering_3"),
              size = 0.1) +
    scale_color_manual(name = "",
                       values = c("Sub_metering_1" = "black",
                                  "Sub_metering_2" = "red",
                                  "Sub_metering_3" = "blue")) +
    scale_x_datetime(date_labels = "%a",
                     date_breaks = "1 day") +
    labs(x = "", y = "Energy sub merging") +
    theme(legend.key.size = unit(2, "mm"),
          legend.position = c(0.7, 0.9))

p4 <- ggplot(power_2) +
    geom_line(mapping = aes(x = datetime,
                            y = Global_reactive_power),
              size = 0.1) +
    scale_x_datetime(date_labels = "%a",
                     date_breaks = "1 day") 

p5 <- grid.arrange(p1, p2, p3, p4, nrow = 2)


ggsave("plot4.png", p5,  width = 480, height = 480,
       units = "px", dpi = 80) 

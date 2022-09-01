library(tidyverse)
library(lubridate)

power <- read.csv("household_power_consumption.txt", sep=";")
power_2 <- filter(power, Date %in% c("1/2/2007", "2/2/2007"))
power_2$Global_active_power <- as.numeric(power_2$Global_active_power)

ggplot(power_2) +
    geom_histogram(mapping = aes(Global_active_power),bins = 25) +
    labs(title = "Global Active Power",
         x = "Global Active Power (kilowatts)",
         y = "February")

ggsave("plot1.png", width = 480, height = 480,
       units = "px", dpi = 150)                 

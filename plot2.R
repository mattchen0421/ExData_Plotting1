library(tidyverse)
library(lubridate)

power <- read.csv("household_power_consumption.txt", sep=";")
power_2 <- filter(power, Date %in% c("1/2/2007", "2/2/2007"))
power_2$datetime <- str_c(power_2$Date, power_2$Time, sep = "/")
power_2$datetime <- dmy_hms(power_2$datetime)
power_2$Global_active_power <- as.numeric(power_2$Global_active_power)

ggplot(power_2) +
    geom_line(mapping = aes(x = datetime,
                            y = Global_active_power),
              size = 0.1) +
    scale_x_datetime(date_labels = "%a",
                     date_breaks = "1 day") +
    labs(x = "", y = "Global Active Power (kilowatts)")

ggsave("plot2.png", width = 480, height = 480,
       units = "px", dpi = 150)   
    
    
    
   


setwd ("D:\\Raghu\\Material\\Coursera\\Exploratory Data Analysis\\Week 1")

date_time <- function(date, time) {
    return (strptime(paste(date, time), "%d/%m/%Y %H:%M:%S"))
}

load_hpc_data <- function() {
    hpc <- read.table("household_power_consumption.txt",
                     header=TRUE,
                     sep=";",
                     colClasses=c("character", "character", rep("numeric",7)),
                     na="?")

    # convert date and time variables to Date/Time class
    hpc$Time <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")
    hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

    # only use data from the dates 2007-02-01 and 2007-02-02
    dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
    hpc <- subset(hpc, Date %in% dates)
    
    return(hpc)
}

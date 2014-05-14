## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

setwd("D://Raghu//Material//Coursera//R Programming")
getwd()

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used  

pollutantmean <- function(directory, pollutant, id = 1:332) {
    files <- numeric(0)
    for(i in id) {
      read_files <- read.csv(paste0(directory, '/', sprintf('%03d', i), '.csv'))
      pol_files <- read_files[[pollutant]]
      files <- c(files, pol_files)
    }
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    mean(files, na.rm=TRUE)
}

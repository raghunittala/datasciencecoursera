## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

complete <- function(directory, id=1:332) {
  nobs <- integer(0)
  for(i in id){
    monitor <- read.csv(paste0(directory, '/', sprintf('%03d', i), '.csv'))
    nobs <- c(nobs, sum(complete.cases(monitor)))
  }
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  data.frame(id, nobs)
}  

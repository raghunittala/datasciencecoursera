rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses ="character")
    states <- sort(unique(data$State))
    
    ## Check that State and Outcome are Valid
    
    if (outcome == "heart attack") {
        outcomesdata <- data[, c(7, 11, 2)] }
    else if (outcome == "heart failure") {
        outcomesdata <- data[, c(7, 17, 2)] }
    else if (outcome == "pneumonia") {
        outcomesdata <- data[, c(7, 23, 2)] }
    else {
        stop("invalid outcome") }
    
    ## For each state, find the hospital of the given rank
    outcomesdata[, 2] <- suppressWarnings(as.numeric(outcomesdata[, 2]))
    removena <- na.omit(outcomesdata)

    if (num == "best") {
        num <- 1
    }
    else if (num == "worst") {}
    else if (as.numeric(num) > nrow(removena)) {
        return(NA)
    }

    rownum <- NULL    
    final <- NULL
    
    for (st in states){
        hospitals_list <- removena[removena$State == st, ]
        
        if (num == "worst") {
            rownum <- nrow(hospitals_list)
        }
        else {
            rownum <- as.numeric(num)
        }
        
        values <- hospitals_list[order(hospitals_list[, 1], hospitals_list[, 2], hospitals_list[, 3]),][rownum, ]
        if (nrow(values) > 0) {
            values$State <- rep(st, nrow(values))
        }
        else {
            return(NA)
        }
        final <- rbind(final, values)
    }
    
    result <- final[, c(3, 1)]
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    
    names(result) <- c("hospital", "state")
    
    return(result)
}

rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses ="character")
    
    states <- unique(data$State)
    
    ## Check that State and Outcome are Valid
    if (!(state %in% states)) {
        stop("invalid state") }
    else {
        statesdata <- data[data$State == state, ]}
    
    if (outcome == "heart attack") {
        outcomesdata <- statesdata[, c(7, 11, 2)] }
    else if (outcome == "heart failure") {
        outcomesdata <- statesdata[, c(7, 17, 2)] }
    else if (outcome == "pneumonia") {
        outcomesdata <- statesdata[, c(7, 23, 2)] }
    else {
        stop("invalid outcome") }

    outcomesdata[, 2] <- suppressWarnings(as.numeric(outcomesdata[, 2]))
    removena <- na.omit(outcomesdata)

    if (num == "best"){
        rownum <- 1
    }
    else if (num == "worst"){
        rownum <- nrow(removena)
    }
    else {
        if (num < nrow(removena)){
            rownum <- as.numeric(num)
        }
        else {
            return(NA)
        }
    }

    ## Return hospital name in that state with the given rank 30-day death rate

    final <- removena[order(removena[, 2], removena[, 3]),]
    return(final[rownum, 3])
}

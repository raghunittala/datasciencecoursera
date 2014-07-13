best <- function(state, outcome) {
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

	## Return hospital name in that state with lowest 30-day death rate
    outcomesdata[, 2] <- suppressWarnings(as.numeric(outcomesdata[, 2]))
    removena <- na.omit(outcomesdata[outcomesdata[, 2] == min(outcomesdata[, 2], na.rm = TRUE), ])
    
    final <- removena[order(removena[, 3]), ]
    return(final[1, 3])
}

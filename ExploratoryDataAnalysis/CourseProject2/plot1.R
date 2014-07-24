setwd("D:\\Raghu\\Material\\Coursera\\Exploratory Data Analysis\\Week 2")

library("plyr")

# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_mod <- transform(NEI, year=factor(year))

# Combining summarized results 
plot_data <- ddply(NEI_mod,.(year), summarize, sum=sum(Emissions))
png("plot1.png")

plot(plot_data$year, plot_data$sum,
    type="n", xlab="Year",
    ylab=expression(PM[2.5]~Emissions~(`in`~tons)), 
    main=expression(Total~PM[2.5]~Emissions~`in`~United~States),
    boxwex=0.05)

lines(plot_data$year, plot_data$sum)
dev.off()

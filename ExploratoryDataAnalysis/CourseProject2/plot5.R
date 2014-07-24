setwd("D:\\Raghu\\Material\\Coursera\\Exploratory Data Analysis\\Week 2")

library("plyr")
library("ggplot2")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get Baltimore emissions from motor vehicle sources
NEI_mod <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
NEI_mod_aggr <- aggregate(Emissions ~ year, data=NEI_mod, FUN=sum)

# plot
library(ggplot2)
png("plot5.png")

gplot <- ggplot(NEI_mod_aggr, aes(x=factor(year), y=Emissions))
y <- gplot + geom_bar(width=.5) +
    xlab("Year") +
    ylab(expression(Total~PM[2.5]~Emissions~each~year~(`in`~tons))) +
    ggtitle("Emissions from motor vehicle sources in Baltimore City")

print(y)
dev.off()

setwd("D:\\Raghu\\Material\\Coursera\\Exploratory Data Analysis\\Week 2")

library("plyr")
library("ggplot2")

# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Finding coal combustion-related sources
combustion_sources <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector),]

# Find emissions from coal combustion-related sources
emissions <- NEI[(NEI$SCC %in% combustion_sources$SCC), ]

# group the emissions by year
emissions_yearly <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

# plot
library(ggplot2)
png("plot4.png")

gplot <- ggplot(emissions_yearly, aes(x=factor(year), y=Emissions))
y <- gplot + geom_bar(width=.5) +
    xlab("Year") +
    ylab(expression(Total~PM[2.5]~Emissions~each~year~(`in`~tons))) +
    ggtitle("Emissions from coal combustion-related sources")

print(y)
dev.off()

setwd("D:\\Raghu\\Material\\Coursera\\Exploratory Data Analysis\\Week 2")

library("plyr")
library("ggplot2")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filtering Baltimore emissions from motor vehicle sources
NEI_bmore <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
NEI_bmore_aggr <- aggregate(Emissions ~ year, data=NEI_bmore, FUN=sum)

# Filtering Los Angeles emissions from motor vehicle sources
NEI_la <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
NEI_la_aggr <- aggregate(Emissions ~ year, data=NEI_la, FUN=sum)

NEI_bmore_aggr$County <- "Baltimore City, MD"
NEI_la_aggr$County <- "Los Angeles County, CA"
combined_emissions <- rbind(NEI_bmore_aggr, NEI_la_aggr)

# plot
png("plot6.png")
gplot <- ggplot(combined_emissions, aes(x=factor(year), y=Emissions, fill=County))

y <- gplot + geom_bar(width=.5) + 
    facet_grid(County  ~ ., scales="free") +
    xlab("Year") +
    ylab(expression(Total~PM[2.5]~Emissions~(`in`~tons))) + 
    ggtitle(expression("Motor vehicle emission variation\nin Baltimore and Los Angeles"))

print(y)
dev.off()
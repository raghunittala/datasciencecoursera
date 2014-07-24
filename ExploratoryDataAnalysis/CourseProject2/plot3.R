setwd("D:\\Raghu\\Material\\Coursera\\Exploratory Data Analysis\\Week 2")

library("plyr")
library("ggplot2")

# Loading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_mod <- transform(NEI,year=factor(year))
NEI_mod <- NEI_mod[NEI_mod$fips=="24510",]

# Combining summarized results 
plot_data <- ddply(NEI_mod,.(year,type),summarize,sum=sum(Emissions))
png("plot3.png")

# ggplot
gplot <- ggplot(plot_data, aes(year,sum))

# adding layers to gplot
y <- gplot + geom_bar(width=0.5) + 
    facet_grid(. ~ type) + xlab("Year") +
    ylab(expression(Total~PM[2.5]~Emissions~each~year~(`in`~tons))) +
    ggtitle(expression(PM[2.5]~Emissions~`in`~Baltimore~City))

print(y)
dev.off()

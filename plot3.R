#install.packages("reshape2")
library(reshape2)
library(ggplot2)

direct<- setwd("D:/Coursera/Exploratory_Data_Analysis/Course_Project_2/exdata_data_NEI_data")

#reading data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#we have to use ggplot2 and do it for baltimore city 
balt<- subset(NEI, fips == "24510") #data only for the baltimore city 

#fraction based on the source type and year
pm_type_balt<- tapply(balt$Emissions, list(balt$year, balt$type), FUN = sum)

#melting the data 
pm_melt<- melt(pm_type_balt)

pm_melt[, 1] <- as.character(pm_melt[, 1]) #converting the year from numeric to character

#plot with ggplot 2 

plt<-  ggplot(data = pm_melt, aes(x=Var2, y=value, fill=Var1))+ 
  geom_bar(position = "dodge", stat = "identity")+ 
  labs(x="Sources", y="Emission of PM2.5 (tons)", title = "Comparison of PM2.5 Emissions in Baltimore")


plt<- plt+ guides(fill=guide_legend(title="Year"))
plt

#Sources such as non-road, non-point and and on-road have seen decrease in emission 
  #from 1999 to 2008. 

#Only point source has seen increase in emission from 1999 to 2008. 

















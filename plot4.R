#install.packages("stringr")
library(stringr)
library(dplyr)
library(reshape2)
library(ggplot2)

direct<- setwd("D:/Coursera/Exploratory_Data_Analysis/Course_Project_2/exdata_data_NEI_data")

#reading data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subsetting the SCC codes for the coal and combustion related emissions 

comb<- SCC %>%  filter(str_detect(SCC.Level.One, "Comb"))
coal<- SCC %>%  filter(str_detect(SCC.Level.Four, "Coal"))
Coal_com<- intersect(comb$SCC, coal$SCC)

#subsetting the data based on the SCC codes found for coal combustion   
df_coal<- NEI[ NEI$SCC %in% Coal_com, ]

df_coal_year<- tapply(df_coal$Emissions, df_coal$year, FUN = sum)
df_coal_year_2<- melt(df_coal_year) 
df_coal_year_2[, 1]<- as.character(df_coal_year_2[, 1])

#now plotting
plt_4<-  ggplot(data = df_coal_year_2, aes(x=Var1, y= value ))+ 
  geom_bar(position = "dodge", stat = "identity", color= "red", fill="red")+ 
  labs(x="Year", y="Emission of PM2.5 (tons)", title = "Comparison of PM2.5 Emissions in United States")

plt_4

#in United States, emission from coal combustion related sources decreased from 1999 to 2002,
#then increased in 2005 and finally decreased in 2008. 
 







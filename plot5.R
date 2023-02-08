library(stringr)
library(dplyr)
library(reshape2)
library(ggplot2)

direct<- setwd("D:/Coursera/Exploratory_Data_Analysis/Course_Project_2/exdata_data_NEI_data")

#reading data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motor<- SCC %>%  filter(str_detect(SCC.Level.Two, "Vehicle"))

df_motor<- NEI[ NEI$SCC %in% motor$SCC, ]
df_motor_baltimore<- subset(df_motor, fips == "24510")

df_baltimore<- tapply(df_motor_baltimore$Emissions, df_motor_baltimore$year, FUN = sum)
df_baltimore_2<- melt(df_baltimore)
df_baltimore_2[,1] <- as.character(df_baltimore_2[,1])

#plotting with ggplot

plt_5<-  ggplot(data = df_baltimore_2, aes(x=Var1, y= value ))+ 
  geom_bar(position = "dodge", stat = "identity", color= "red", fill="red")+ 
  labs(x="Year", y="Emission of PM2.5 (tons)", title = "Comparison of PM2.5 Emissions in Baltimore")

plt_5

#Emissions of PM2.5 from motor vehicles have been reduced by more than half from 1999 to 2008.  



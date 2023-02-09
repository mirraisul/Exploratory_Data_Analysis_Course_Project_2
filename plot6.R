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
df_baltimore<- subset(df_motor, fips == "24510" )
df_callifornia <- subset(df_motor, fips == "06037" )

#for Baltimore
df_sum_baltimore<- tapply(df_baltimore$Emissions, df_baltimore$year, FUN = sum)
df_sum_baltimore_2<- melt(df_sum_baltimore)
df_sum_baltimore_2[,1] <- as.character(df_sum_baltimore_2[,1])

#for Callifornia 
df_sum_callifornia<- tapply(df_callifornia$Emissions, df_callifornia$year, FUN = sum)
df_sum_callifornia_2<- melt(df_sum_callifornia)
df_sum_callifornia_2[,1]<- as.character(df_sum_callifornia_2[,1])

#plotting with ggplot

#plot with ggplot 2 

plt_06_b<-  ggplot(data = df_sum_baltimore_2, aes(x=Var1, y=value, fill=Var1))+ 
  geom_bar(position = "dodge", stat = "identity")+ 
  labs(x="Year", y="Emission of PM2.5 (tons)",
       title = "PM2.5 Emissions in Baltimore") +guides(fill=FALSE)

plt_06_b

plt_06_c<-  ggplot(data = df_sum_callifornia_2, aes(x=Var1, y=value, fill=Var1))+ 
  geom_bar(position = "dodge", stat = "identity")+ 
  labs(x="Year", y="Emission of PM2.5 (tons)",
       title = "PM2.5 Emissions in Callifornia")+guides(fill=FALSE)

plt_06_c

library(patchwork)

plt_comb<- plt_06_b+plt_06_c

plt_comb

#Baltomore has seen great changes of PM2.5 emission from 1999 to 2008.




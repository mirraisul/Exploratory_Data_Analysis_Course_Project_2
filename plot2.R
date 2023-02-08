rm(list = ls())
direct<- setwd("D:/Coursera/Exploratory_Data_Analysis/Course_Project_2/exdata_data_NEI_data")

#reading data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data for Baltimore city, Maryland (fips == "24510")
balt<- subset(NEI, fips == "24510")

#Sub-setting data for different years in Baltimore city 
balt_99<- subset(balt, year==1999)
total_balt_99<- sum(balt_99$Emissions)
  
balt_02<- subset(balt, year==2002)
total_balt_02<- sum(balt_02$Emissions)

balt_05<- subset(balt, year==2005)
total_balt_05<- sum(balt_05$Emissions)

balt_08<- subset(balt, year==2008)
total_balt_08<- sum(balt_08$Emissions)

#creating a data frame 
df_balt<- data.frame(pm_values=c(total_balt_99, total_balt_02, total_balt_05, total_balt_08),
                year=c(1999, 2002, 2005, 2008))

#Now plotting the result 
barplot(df_balt$pm_values, df_balt$year, names.arg = df_balt$year, col= "red", ylim = c(0, 3500),
        xlab = "Year", ylab = "Emission of PM2.5 (tons)", main = "Comparison of PM2.5 Emissions in Baltimore")


#So, the emission of PM2.5 decreased from 1999 to 2008 in Baltimore city



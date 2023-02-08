rm(list = ls())
direct<- setwd("D:/Coursera/Exploratory_Data_Analysis/Course_Project_2/exdata_data_NEI_data")

#reading data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Sub-setting data for different years 
pm_99<- subset(NEI, year==1999)
total_pm_99<- sum(pm_99[, "Emissions"])

pm_02<- subset(NEI, year==2002)
total_pm_02<- sum(pm_02[, "Emissions"])

pm_05<- subset(NEI, year==2005)
total_pm_05<- sum(pm_05[, "Emissions"])

pm_08<- subset(NEI, year==2008)
total_pm_08<- sum(pm_08[, "Emissions"])

#creating a data frame 
df<- data.frame(pm_values=c(total_pm_99, total_pm_02, total_pm_05, total_pm_08),
                year=c(1999, 2002, 2005, 2008))


#Now plotting the result 
barplot(df$pm_values, df$year, names.arg = df$year, col = "red", ylim = c(0, 8e+06),
        xlab = "Year", ylab = "Emission of PM2.5 (tons)", main = "Comparison of PM2.5 Emissions")

#So, the bar plot says that the emission of PM2.5 decreases from 1999 to 2008















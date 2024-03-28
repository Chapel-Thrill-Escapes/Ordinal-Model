#EDA and Updated Data Formulation
rm(list = ls()) #Cleans our environment 
#
if (!require(readxl)) {install.packages("readxl"); library(readxl)} #Allows for the importing of excel sheets as datasets. 
if (!require(tidyverse)) {install.packages("tidyverse"); library(tidyverse)} #Installs and imports tidyverse for more effective cleaning
if (!require(dplyr)) {install.packages("dplyr"); library(dplyr)} #Imports the dplyr package
if (!require(ggplot2)) {install.packages("ggplot2"); library(ggplot2)}
#
#Importing our 6 excel sheets as one full excel sheet, with appropximately 500 + rows. 
report_bookings_full <- read_excel("~/Downloads/CTE_data/report_bookings_full.xls") #
dim(report_bookings_full) #Checks to see that our data was correctly imported
names(report_bookings_full) #Column names of our dataframe
head(report_bookings_full) #First 5 rows. We can use the name "Thomas Altman", which has three rows, as a method to gauge
#whether our data is later correclty grouped. If there is eventually only one row for Thomas Altman, then the data is correctly grouped.
# 
report_bookings_full <- report_bookings_full %>% filter(Status == "normal") 
#Cleaning Data 
#Selecting rows of interest 
report_bookings_subset <- select(report_bookings_full, "Booking number", "Start", 
"Participants","On-Campus Student ($12)", "Private event", "Customer - How did you hear about us?")
#
head(report_bookings_subset); names(report_bookings_subset) #Runs both commands to see the first five rows and the variable names
#that were sampled. 
#
View(report_bookings_full)
View(report_bookings_subset)
#Grouping by START Date and Time. 
class(report_bookings_subset$Start) #R has already identified the Start column to be a date and time object
report_subset_grouped <- group_by(report_bookings_subset, Start) %>% summarize(Participants = sum(Participants))
View(report_subset_grouped)
ggplot(report_subset_grouped, aes(x = Participants)) + 
geom_histogram()
head(report_subset_grouped)
dim(report_subset_grouped)


View(report_bookings_subset %>% filter(Start == as.POSIXct("2023-01-31 18:30:00")))
View(report_bookings_subset %>% filter(Start == as.POSIXct("2023-01-31 15:30:00")))



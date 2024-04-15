#EDA and Updated Data Formulation
rm(list = ls()) #Cleans our environment 
#
if (!require(readxl)) {install.packages("readxl"); library(readxl)} #Allows for the importing of excel sheets as datasets. 
if (!require(tidyverse)) {install.packages("tidyverse"); library(tidyverse)} #Installs and imports tidyverse for more effective cleaning
if (!require(dplyr)) {install.packages("dplyr"); library(dplyr)} #Imports the dplyr package
if (!require(ggplot2)) {install.packages("ggplot2"); library(ggplot2)}
if (!require(readr)) {install.packages("readr"); library(readr)}
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
#
#Data Cleaning; Representing Character Variables as Categorical Variables using 0 and 1. 
#
#Dealing with the variable "Private Event"
class(report_bookings_subset$`Private event`) #Already correctly classified as a
#logical (categorical) variable. 
report_bookings_subset$`Private event` <- factor(report_bookings_subset$`Private event`, labels = c(0, 1)) #Reclassifies
#the variale "Private event" as a factor with two NUMERICAL levels: 0 and 1. 
class(report_bookings_subset$`Private event`) #Now classified as factor. 
#
#Similar re-classification for the "Method" ("Customer - How did you hear about us?") variable
#
#Renaming column
#colnames(report_bookings_subset)[colnames(report_bookings_subset) == "`Customer - How did you hear about us?`"] <- "Method"; colnames(report_bookings_subset)
#
colnames(report_bookings_subset)[6] <- "Method"; colnames(report_bookings_subset) #Renaming correctly occured. 
class(report_bookings_subset$Method)
#
discretized_levels <- c(0, 1, 2, 3, 4, 5, 6, 7, 8) #Numeric levels to what we want to discretize "Method" to. 
report_bookings_subset$Method <- factor(report_bookings_subset$Method, levels = unique(report_bookings_subset$Method), labels = discretized_levels)
report_bookings_subset$Method #Checks to see changes were correctly/effectively were made; they were. 
#
#
#Grouping by START Date and Time. 
colnames(report_bookings_subset) #All columns within our current subset; this line was run as a reminder of what columns
#we are working with. 
#
#
class(report_bookings_subset$Start) #R has already identified the Start column to be a date and time object
report_subset_grouped <- group_by(report_bookings_subset, `Booking number`)
View(report_subset_grouped)
#
#Creates a histogram to analyze the distribution of "Participants" values; we want SOME level of balancein the distribution. 
ggplot(report_subset_grouped, aes(x = Participants)) + geom_histogram() + ggtitle("Distribution of Participants")
#The distribution IS in fact, to some level, balanced. It is enough for us to work with. 
#
write.csv(report_subset_grouped, "FinalData.csv") #Exports the data as a csv file






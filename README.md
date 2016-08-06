# Coursea Data Cleaning Course Assignment
by Tan Yih Siang
last updated 06-Aug-2016

## Objective of this assignment
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

## Source of Data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Files in the project
1. README.MD - This file
2. CodeBook.MD - Explaining the approach used and how the tidy data sets are created
3. load.R - This is the R script that handles the downloading of the data, loading of the data to data frames. The load function() in this script will also perform the steps 1, 3 and 4 in the assignment to
  * Merge the x, y and subject files
  * Merge the training and test sets
  * Labels the variables using descriptive names
  * Use descriptive names for the activities in the data set
4. run_analysis.R - This is the R script that will perform step 2 and step 5 of the assignment. The getTinyDataSets() function will creates the tidy set for step 2 and tiny set for step 5 and return these two tidy data sets as a list.

## How to run
1. Checkout both load.R and run_analysis.R to your local disk
2. From R Studio, set the working directory to where you have checkout the scripts `setwd(`directory`)`
3. Load in the run_analysis.R script. It will inturn load the load.R.
4. Run `dataSets <- getTinyDataSets()` 
5. Use `dataSets$firstTidySet` to get the data set for mean and standad deviation
6. Use `dataSets$secondTidySet` to get the data set for aggregated average for each variable for each activity and each subject

```
source("run_analysis.R")
dataSets <- getTinyDataSets(cleanup=TRUE)
firstDataSet <- dataSets$firstTidySet
secondDataSet <- dataSets$secondTidySet
```

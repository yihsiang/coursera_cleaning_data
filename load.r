library("data.table")
library("dplyr")
library("lubridate")

# Load train set function to read in the individual train set data files into data tables
# Load will also address assignment step 1 to merge the training and the test 
# sets to create one data set, which can be retrieve using the getMerged() function
load <- function() {
    # Set the data working directory. Change this if necessary to point to location 
    # of your data file
    dataDir <- "./UCI HAR Dataset/"
    savedMergedFilename <- "har.rdata"
    sourceDataZipFileName <- "./sourcedata.zip"
    merged <- NULL
    
    # If directory does not exist, download the zip file and extract the data
    if (!file.exists(sourceDataZipFileName)) {
        sourceURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(sourceURL,dest=sourceDataZipFileName, mode="wb")
    }
    if (!file.exists(dataDir)) {
        unzip("sourcedata.zip", exdir="./")
    }
    
    # Read the files
    xTrain <- fread(paste(dataDir,"./train/X_train.txt",sep=""))
    subjectTrain <- read.delim(paste(dataDir,"./train/subject_train.txt",sep=""),header=FALSE,sep="")
    xTest <- fread(paste(dataDir,"./test/X_test.txt",sep=""))
    subjectTest <- read.delim(paste(dataDir,"./test/subject_test.txt",sep=""),header=FALSE,sep="")
    featureLabels <- fread(paste(dataDir,"./features.txt",sep=""))[[2]]
    activityLabels <- fread(paste(dataDir,"./activity_labels.txt",sep=""))[[2]]
    yTrain <- read.delim(paste(dataDir,"./train/y_train.txt",sep=""),header=FALSE,sep="")
    yTest <- read.delim(paste(dataDir,"./test/y_test.txt",sep=""),header=FALSE,sep="")

    # Make the featureLabels more descriptive
    # replace all variable names starting with "t" with "time"
    featureLabels <- gsub("^t","time",featureLabels)
    # replace all variable names starting with "f" with "frequency"
    featureLabels <- gsub("^f","frequency",featureLabels)
    # Replace all variable names with "Acc" with "Accelerometer"
    featureLabels <- gsub("Acc","Accelerometer",featureLabels)
    # Replace all variable names with "Gyro" with "Gyroscope"
    featureLabels <- gsub("Gyro","Gyroscope",featureLabels)
    # Replace all variable names with "Mag","Magnitude"
    featureLabels <- gsub("Mag","Magnitude",featureLabels)
    # Replace the repeating "BodyBody" with just "Body"
    featureLabels <- gsub("BodyBody","Body",featureLabels)
    # Replace "mean" with "Mean" and "std" with "StdDev"
    featureLabels <- gsub("mean[(]","Mean",featureLabels)
    featureLabels <- gsub("std[(]","StdDev",featureLabels)
    # Replace the "(),-" with ""
    featureLabels <- gsub("[(),-]","",featureLabels)

    
    
    # Set the column names. For the x data sets, the features name are set based on the values read from features.txt 
    colnames(xTrain) <- featureLabels
    colnames(xTest) <- featureLabels
    colnames(subjectTrain) <- c("subject")
    colnames(subjectTest) <- c("subject")
    colnames(yTrain) <- c("activity")
    colnames(yTest) <- c("activity")
    
    # Merge the subject and activity file to the feature
    xTrain <- cbind(xTrain, subjectTrain)
    xTrain <- cbind(xTrain, yTrain)
    xTest <- cbind(xTest, subjectTest) 
    xTest <- cbind(xTest, yTest)
    
    # Convert subject and activity to factors. Activity fator labels will
    # be loaded from the activity_label.txt
    # This addresses assignment step 3 to user descriptive activity names 
    # to name the activities in the data set
    xTrain$activity <- factor(xTrain$activity, labels=activityLabels)
    xTest$activity <- factor(xTest$activity, labels=activityLabels)
    xTrain$subject <- factor(xTrain$subject)
    xTest$subject <- factor(xTest$subject)
    
    
    # The following are set of functions to get the various data sets
    getxTrain <- function() { return(xTrain) }
    getxTest <- function() { return(xTest) }
    getMerged <- function() { 
        if (is.null(merged)) {
            merged <<- rbind(xTrain, xTest)
        }
        return(merged)
    }
    getFeatureLabels <- function() { return(featureLabels) }
    getSubjectTrain <- function() { return(subjectTrain) }
    getSubjectTest <- function() { return(subjectTest) }
    getActivityLabels <- function() { return(activityLabels) }
    getyTrain <- function() { return(yTrain) }
    getyTest <- function() { return(yTest) }
    getAll <- function() {
        return(list(xTrain=getxTrain(),
                    xTest=getxTest(),
                    merged=getMerged(),
                    featureLabels=getFeatureLabels(),
                    subjectTrain=getSubjectTrain(),
                    subjectTest=getSubjectTest(),
                    activityLabels=getActivityLabels(),
                    yTrain=getyTrain(),
                    yTest=getyTest()))
    }
    
    # Functions to save or load the merged data set from disk
    saveMergedToDisk <- function() { m = getMerged(); save(m,file=savedMergedFilename,sep="") }
    loadMergedFromDisk <- function() { merged <<- load(savedMergedFilename,sep="") }
    
    # Clean up function to delete the data directory. This frees up space on the disk
    cleanup <- function() {
        if (dir.exists(dataDir)) { unlink(dataDir,recursive = TRUE) }
        if(file.exists(sourceDataZipFileName)) { unlink(sourceDataZipFileName) }
    }
    
    # load() returns a list of functions that can be used by the calling R script to perform load, 
    # get the data sets and cleanup
    return(list(getMerged=getMerged,
                getAll=getAll,
                saveMergedToDisk=saveMergedToDisk,
                loadMergedFromDisk=loadMergedFromDisk,
                cleanup=cleanup))
}
# Source the load function that we will use to read all the data
source("load.r")

# Returns a list of two data sets
# First data set is the tiny data set cleaned up till step 4
# Second data set is the tiny data set created in step 5 for the average of each variable for each activity for each subject
getTinyDataSets <- function(cleanup=FALSE) {
    # Load the data files and get the merged data set
    load <- load()
    dataSet <- load$getMerged()
    
    # Get the feature labels and only get those with "mean(" and "std(" in their names
    # This addresses the assignment step 2 to extract only the measurements on the mean 
    # and standard deviation for each measurement.
    featureLabels <- load$getAll()$featureLabels
    featureLabels <- featureLabels[grep(".*Mean|.*StdDev",featureLabels)]
    # Extract out only those columns for Mean and StdDev
    firstTinySet <- subset(dataSet, select = c("subject","activity",featureLabels))
    
    # Aggregate the ata by subject + activity into the second tiny set.
    # This addresses the assignment step 5 to create a second, independent 
    # tidy data set with the average of each variable for each activity and each subject.
    secondTinySet <- aggregate(. ~ subject + activity, FUN=mean, data=firstTinySet)
    
    # Clean up the data files
    if (cleanup) {
        load$cleanup()
    }
    
    # Return a list of two data frames
    returnVal <- list(firstTinySet,secondTinySet)
    names(returnVal) <- c("firstTidySet","secondTidySet")
    
    write.table(secondTinySet,file="step5dataset.txt",row.names = FALSE)
    
    return(returnVal)
    
}
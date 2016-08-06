# Code Book for Coursea Data Cleaning Course Assignment
by Tan Yih Siang
last updated 06 Aug 2016

## Source of Data
One of the most exciting areas in all of data science right now is wearable computing - see for example this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data used for this assignment represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for this assignment will be downloaded from the following URL
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Description of the Data
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity was captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### For each record it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables.
* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file with 561 variables.
* Its activity label. 
* An identifier of the subject who carried out the experiment. Each subject is identified by a number (e.g. 1, 2, 3)

### Datafiles in the source data set
1. Common files
    * `README.txt`
    * `features_info.txt`: Shows information about the variables used on the feature vector.
    * `features.txt`: List of all features. 
    * `activity_labels.txt`: Links the class labels with their activity name (e.g. WALKING, STANDING).

2. Data of the subjects involved in the training set
    * `train/X_train.txt`: Training set feature vector. Each row contains 561 variables of each feature measured.
    * `train/y_train.txt`: Training labels. This links the measurement of the features to the activities performed
    * `train/subject_test.txt`: Subject labels. Each row identifies the subject who performed the activity for each window sample.

3. Data of the subjects involved in the testing set
    * `test/X_test.txt`: Similar to training set, except this is from the testing set
    * `test/y_test.txt`: Similar to training set, except this is from the testing set
    * `test/subject_test.txt`: Similar to training set, except this is from the testing set

4. For the purpose of this assignment, the files from 'Inertial Signals' directory for both training and testing sets were not used.


## How Data is Manupulated to get the Tidy Sets

### Features
1. All 561 features in x_train.txt and x_test.txt were labelled in sequenced based on the feature names loaded from features.txt
2. The following were applied to the feature names to have more descriptive names
    * All names starting with "t" were replaced with "time"
    * All names starting with "f" were replaced with "frequency"
    * All names with "Acc" were replaced with "Accelerometer"
    * All names with "Gyro" were replaced with "Gyroscope"
    * All names with "Mag" were replaced with "Magnitude"
    * All names with "mean" were replaced with "Mean"
    * All names with "std" were replaced with "StdDev" for standard deviation
    * All names with repeated "BodyBody" were replace with "Body"
    * All names with "(", ")", "," and "-" were stripped of it

### Subjects
There is no manupulation of the subject IDs. Subjects were retained as the number that represents them (e.g. 1, 2, 3)

### Activities
Activities were replaced with labels loaded in sequence based on the activities names from the activity_labels.txt

### Creating the merged data set
A merged data set is created by merging the records from training and testing into one data set. Subject and activities are also added as columns to the merged data set.

### First data set
The first data set is a merge of both training and testing set. Only the Mean and StdDev (Standard Deviation) variables extracted
There are total of 10,299 measures for the 30 subjects involved in the training or testing set
There are 75 variables in the data set


```
> nrow(firstDataSet)
[1] 10299
> sort(summary(firstDataSet))
  8   9  10   5   2   7  11   4  12  22  14   6  13  15   3  29   1  20  19  18  16  17  23  27  24 
281 288 294 302 302 308 316 317 320 321 323 325 327 328 341 344 347 354 360 364 366 368 372 376 381 
 28  30  26  21  25 
382 383 392 408 409 
> names(firstDataSet)
 [1] "subject"                                       "activity"                                     
 [3] "timeBodyAccelerometerMeanX"                    "timeBodyAccelerometerMeanY"                   
 [5] "timeBodyAccelerometerMeanZ"                    "timeBodyAccelerometerStdDevX"                 
 [7] "timeBodyAccelerometerStdDevY"                  "timeBodyAccelerometerStdDevZ"                 
 [9] "timeGravityAccelerometerMeanX"                 "timeGravityAccelerometerMeanY"                
[11] "timeGravityAccelerometerMeanZ"                 "timeGravityAccelerometerStdDevX"              
[13] "timeGravityAccelerometerStdDevY"               "timeGravityAccelerometerStdDevZ"              
[15] "timeBodyAccelerometerJerkMeanX"                "timeBodyAccelerometerJerkMeanY"               
[17] "timeBodyAccelerometerJerkMeanZ"                "timeBodyAccelerometerJerkStdDevX"             
[19] "timeBodyAccelerometerJerkStdDevY"              "timeBodyAccelerometerJerkStdDevZ"             
[21] "timeBodyGyroscopeMeanX"                        "timeBodyGyroscopeMeanY"                       
[23] "timeBodyGyroscopeMeanZ"                        "timeBodyGyroscopeStdDevX"                     
[25] "timeBodyGyroscopeStdDevY"                      "timeBodyGyroscopeStdDevZ"                     
[27] "timeBodyGyroscopeJerkMeanX"                    "timeBodyGyroscopeJerkMeanY"                   
[29] "timeBodyGyroscopeJerkMeanZ"                    "timeBodyGyroscopeJerkStdDevX"                 
[31] "timeBodyGyroscopeJerkStdDevY"                  "timeBodyGyroscopeJerkStdDevZ"                 
[33] "timeBodyAccelerometerMagnitudeMean"            "timeBodyAccelerometerMagnitudeStdDev"         
[35] "timeGravityAccelerometerMagnitudeMean"         "timeGravityAccelerometerMagnitudeStdDev"      
[37] "timeBodyAccelerometerJerkMagnitudeMean"        "timeBodyAccelerometerJerkMagnitudeStdDev"     
[39] "timeBodyGyroscopeMagnitudeMean"                "timeBodyGyroscopeMagnitudeStdDev"             
[41] "timeBodyGyroscopeJerkMagnitudeMean"            "timeBodyGyroscopeJerkMagnitudeStdDev"         
[43] "frequencyBodyAccelerometerMeanX"               "frequencyBodyAccelerometerMeanY"              
[45] "frequencyBodyAccelerometerMeanZ"               "frequencyBodyAccelerometerStdDevX"            
[47] "frequencyBodyAccelerometerStdDevY"             "frequencyBodyAccelerometerStdDevZ"            
[49] "frequencyBodyAccelerometerJerkMeanX"           "frequencyBodyAccelerometerJerkMeanY"          
[51] "frequencyBodyAccelerometerJerkMeanZ"           "frequencyBodyAccelerometerJerkStdDevX"        
[53] "frequencyBodyAccelerometerJerkStdDevY"         "frequencyBodyAccelerometerJerkStdDevZ"        
[55] "frequencyBodyGyroscopeMeanX"                   "frequencyBodyGyroscopeMeanY"                  
[57] "frequencyBodyGyroscopeMeanZ"                   "frequencyBodyGyroscopeStdDevX"                
[59] "frequencyBodyGyroscopeStdDevY"                 "frequencyBodyGyroscopeStdDevZ"                
[61] "frequencyBodyAccelerometerMagnitudeMean"       "frequencyBodyAccelerometerMagnitudeStdDev"    
[63] "frequencyBodyAccelerometerJerkMagnitudeMean"   "frequencyBodyAccelerometerJerkMagnitudeStdDev"
[65] "frequencyBodyGyroscopeMagnitudeMean"           "frequencyBodyGyroscopeMagnitudeStdDev"        
[67] "frequencyBodyGyroscopeJerkMagnitudeMean"       "frequencyBodyGyroscopeJerkMagnitudeStdDev"    
[69] "angletBodyAccelerometerMeangravity"            "angletBodyAccelerometerJerkMeangravityMean"   
[71] "angletBodyGyroscopeMeangravityMean"            "angletBodyGyroscopeJerkMeangravityMean"       
[73] "angleXgravityMean"                             "angleYgravityMean"                            
[75] "angleZgravityMean"   
```

### Second Data Set
The second data set is a merge of the training and testing sets. The average of only the Mean and StdDev (Standard Deviation) variables were extracted by subject and activity performed
There are total of 180 averages for the 30 subjects involved in the training or testing set for the 6 activities performed (i.e. 30 subjects x 6 activities = 180 rows)
There are 75 variables in the data set. The feature measurements values are averages


## License of the Data Source
License:
Use of this data source in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
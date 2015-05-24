---
title: "Codebook"
author: "Abrar Ali"
date: "May 24, 2015"
output:
  html_document:
    keep_md: yes
---
 
##Description
This code book describes the variables, the data, and any transformations or work that was performed to clean up the data. 

###Collection of the raw data
The actual dataset for this project is labeled Human Activity Recognition Using Smartphones. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###Notes on the original (raw) data 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The data that was used includes these files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


##Creating the tidy datafile
This section describes in detail how tidy data was generated out of the raw data.

###Guide to create the tidy data file

These were the steps that were performed to create the tidy data file after the data was downloaded:
  
  1. The training and the test sets were merged to create one data set.
  2. From this data set only the measurements on the mean and standard deviation were extracted.
  3. Descriptive activity names were used to name the activities in the data set.
  4. The data set was named with descriptive variable names.
  5. From this data set a second, independent tidy data set was created with the average of each variable for each activity and each subject.
 
###Cleaning of the data

This is how the run_analysis.R script carried out these steps:

  1.  Read the training, testing dataset.
  2.  Read the names of the features and the activity labels.
  3.  Combine the training and testing x datasets by rows and name the features
  4.  Combine the training and testing y datasets by rows, map the activity id to activity label, add the label to y dataset and name both columns.
  6.  Combine the training and testing subject datasets by rows and name the only column.
  7.  Combine the complete x, y and subject datasets by binding them as columns.
  8.  Extract only the mean and standard deviation measurements from the complete data.
  9.  Add the y and subject datasets as columns
  10. Melt the data frame choosing the activity & subject as id variables, and the mean and standard as measured variables
  11. Cast the data frame based on subject and activity label, and calculating the mean of all variables for each subset.
  12. Write the tidy data to a file
 
##Description of the variables in the tidy_data.txt file

The variables in the tidy dataset capture the mean, standard deviation and mean frequency measurements (where applicable) and then grouped based on subject and activity for the features described below.

The features selected for this dataset come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
 
    Name of variable           Number of variables
     (appended with 
      -mean(),
      -std() & 
      -meanFreq())
     
      subject                           1        
      activityLabel                     1
      tBodyAcc-XYZ                      6
      tGravityAcc-XYZ                   6
      tBodyAccJerk-XYZ                  6
      tBodyGyro-XYZ                     6
      tBodyGyroJerk-XYZ                 6
      tBodyAccMag                       2
      tGravityAccMag                    2
      tBodyAccJerkMag                   2
      tBodyGyroMag                      2
      tBodyGyroJerkMag                  2
      fBodyAcc-XYZ                      9
      fBodyAccJerk-XYZ                  9
      fBodyGyro-XYZ                     9
      fBodyAccMag                       3
      fBodyAccJerkMag                   3
      fBodyGyroMag                      3
      fBodyGyroJerkMag                  3
  
    Total number of variables is 81 with 180 different observations.
 

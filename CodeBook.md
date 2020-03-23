---
title: "CodeBook"
author: "Arthur Wang"
date: "3/23/2020"
output: html_document

# Peer-graded Assignment: Getting and Cleaning Data Course Project

## CodeBook

This run_analysis.R script fulfills all the requirements in the project description as follows:

0. Set the working directory "./UCI HAR Dataset" containing all original files.
   Load the "dplyr" package for data.frame manipulation.


1. Merges the training and the test sets to create one data set.

    a. Read and assign training and the test sets to data.frame "training" and "test".

      "training" <- "./train/X_train.txt": 7352 rows (obs.), 561 columns (variables)
       contains training data set with recorded features/measurements

      "test" <- "./test/X_test.txt": 2947 rows, 561 columns 
       contains test data set with recorded features/measurements

    b. Merges the training and the test sets to create one data set
       "combine" (10299 rows, 561 columns) is created by merging "training" and "test" using rbind()         function

2. Extracts only the measurements on the mean and standard deviation for each measurement   
   NOTE: All variables contain "mean" or "std" are extracted. 

    a. Read features data set as "features" <- "./features.txt": 561 rows, 2 column;
       Set the 2nd column as a character vector. contain all feature information derived from the            accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

    b. Name the column names of "combine" by the 2nd column of "features"; All letters are set in the        lower case.  

    c. Extract the positions of elements in the 2nd column of "features" that contain "mean" or "std"; 
       Create the new dataframe "tidyData" that only includes the columns whose names are selected           features: 10299 rows, 79 columns

3. Uses descriptive activity names to name the activities in the data set

    a. Read the training and test labels that contain codes of activitie; Merge two data sets.
       "train_labels" <- "./train/Y_train.txt": 7352 rows, 1 column
       "test_labels" <- "./test/Y_test.txt": 7352 rows, 1 column;
       "labels" (10299 rows, 1 column) is created by merging "train_labels" and "test_labels" using          rbind() function

    b. Read the corresponding activity information.
       "activities" <- "./activity_labels.txt": 6 rows, 2 columns

    c. Assign the activitiy information to the "labels" data set by matching each level/rows of "labels"     with the 2nd column of "activities" serving as labels for the factor vector.

    d. Add a new variable with the assigned activitiy information called "activity" to the "tidyData":     10299 rows, 80 columns

    e. Remove all the "_" in the "activity" variable of "tidyData"

4. Appropriately labels the data set with descriptive variable names.
   To rename the variables in "tidyData", substitute the following characters in the colnames:
        "acc", "gyro", "bodybody", "mag", "^t" (^ means starting with), "^f", "-mean", "-std", "-x",         "-y","-z", and "()", 

   to the following: 
         "accelerometer", "gyroscope", "body", "magnitude", "time", "frequency", "mean", "std", "x", "y",     "z",and "".

5. From the data set in step 4, creates a second, independent tidy data set with the average of each        variable for each activity and each subject.

    a. Read subject ID data sets with column names of "subject" and merge them.
      "test_subject" <- "./subject_test.txt" : 2947 rows, 1 column 
       contains test data of 9/30 volunteer test subjects being observed.
       "train_subject" <- "./subject_train.txt" : 7352 rows, 1 column 
       contains train data of 21/30 volunteer subjects being observed
       "subjects" (10299 rows, 1 column) is created by merging "train_subject" and "test_subject" using      rbind() function

    b. Use cbind() function to merge the "subjects" with "tidyData" (i.e. a new variable named "subject"     is created): 10299 rows, 81 columns

    c. Use group_by() function to group the modified "tidyData" by variables "subject"; and calculate the mean of each column for grouped dataframe using mean() function.
       Create the "finaltidyData": 180 rows, 81 columns to store the calculated means.

6. Save the "finaltidyData" data set under the working directory


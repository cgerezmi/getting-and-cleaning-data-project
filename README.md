# getting-and-cleaning-data-project

## Description

This is the repository for the Course Project of "Getting and Cleaning Data" course.

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.
	
## Source

A full description is available at the site where the data was obtained: [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here is the data file for the project: [Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Project Summary
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Process-Steps from the source to target (tidy.txt)
+ STEP 1 & 2
	- Read "features.txt" and "activity_labels.txt" files as datasets
	- Read test files
	- Read train files
	- Merge (row bind) datasets in terms of variable types (x, y, subject)
	- Extract desired features from X dataset and reshape it
	- Merge (column bind) all three (x, y ,ssubject) datasets in order to make a single dataset, called "data"
+ STEP 3
	- Join "activity" dataset with "data" dataset and assign it to temporary dataset 
	- Reshape "data" dataset by assigning that temporary dataset (except unnecessary, first comumn) 
	- Rename first column name of the new "data" dataset
	- Remove temporary dataset
+ STEP 4
	- Rename unclear column names with clear ones
+ STEP 5
	- load plyr package (because of ddply function)
	- find means of the measurement variables (group by subject and activity)
	- write that tidy dataset into tidy.txt file

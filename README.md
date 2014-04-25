## Getting and Cleaning Data Project
###Overview
This document describes the data and the procedure used for this project.
More detailed information can be found in the comments of the code.

###Input Data:
The input data consist of 561 measurements for 30 subjects each doing 6 different activities.
The data are broken into two sets originally intended for machine learning; a training set and a test set, each with x inputs and y outputs.

The data are summarized as follows:

* features = 561 obs, 2 var - Contains a feature ID and feature description for 561 measurements
* X\_train = 7352 obs, 561 vars - Contains the measurements for each feature
* X\_test = 2947 obs, 561 vars - Contains the measurements for each feature
* y\_train = 7352 obs, 1 var - Contains the activity number for each observation in X\_train
* y\_test = 2947 obs, 1 var - Contains the activity number for each observation in X\_test
* subject\_train = 7352 obs, 1 var - Contains the subject number for each observation in X\_train
* subject\_test = 2947 obs, 1 var - Contains the subject number for each observation in X\_test
* activities = 6 obs, 2 var - Contains names of the activities for each activity number

Detailed information on how the measurements were made and what the measurements represent can be found in features\_info.txt in the input dataset folder.

###Goal
The goal of the project is to find all variables that represent mean or standard deviation values and produce a dataset that averages these values by subject and activity.

There are 79 variables that have mean, std or meanFreq in the name. These were selected for analysis.

* train data = 7352 obs, 79 vars
* test data = 2947 obs, 79 vars

The final data is a table of the mean of each variable by subject and activity. This results in a table of 180 rows (30 subjects * 6 activities) and 81 columns (subject, activity and 79 measurements).

The final data are written to tidy.csv.

###Procedure:
####Setup
For the script to run, the input data should be extracted to the same directory as run\_analysis.R. In other words, you should have the folder "UCI HAR Dataset" and run\_analysis.R in the same working directory.

The input data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

####Analysis
The following describes the procedure used in run_analysis.R to manipulate the data and produce a tidy output dataset:

1. Get feature names by reading features.txt and subsetting just the names column
2. Get feature subset for mean and std dev using grep and sorting an array of column indices
3. Read X\_train data from X\_train.txt and provide column names from features data
4. Subset X\_train for std and mean only
5. Read subject\_train data from subject\_train.txt and provide column name
6. Add subject column to X\_train using cbind
7. Read X\_test data from X\_test.txt and provide column names from features data
8. Subset X\_test for std and mean only
9. Read subject\_test data from subject\_test.txt and provide column name
10. Add subject column to X\_test using cbind
11. Add X\_test rows to X\_train using rbind
12. Read y\_train and y\_test files and provide column names
13. Add y\_test rows to y\_train using rbind
14. Add factors for y\_train activity names using cut
15. Merge X columns with y column using cbind
16. Create tidy dataset with the mean of each measurement for each subject and activity using melt and dcast
17. Write tidy dataset to file using write.table

####Notes:
* Since the datasets are large, memory was released when it was no longer needed. This would allow the script to scale better if even larger datasets were used.
* A variable, maxrows, was used to reduce the amount of data read in for testing. This sped up the testing phase.
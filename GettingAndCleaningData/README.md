Coursera Getting and Cleaning Data
======================

Repository for Coursera Getting and Cleaning Data module. Contains all programming assignments 


Files in this Repo
======================
CodeBook.md - this codebook describes all the values
run_analysis.R - actual R code for the course project
tidy_data.txt - the tidy data set according to the instructions
tidy_data_with_means.txt - second, independent tidy data set with the average of each variable for each activity and each subject


run_analysis.R - Goals
======================
This R script does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This script should be run in a folder of the Samsung data (the zip had this folder: UCI HAR Dataset) The script assumes it has in it's working directory these files and folders: activity_labels.txt, features.txt, test/, train/

The output is created in two files - tidy_data.txt and tidy_data_with_means.txt

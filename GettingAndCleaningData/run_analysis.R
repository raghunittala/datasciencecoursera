# This R script gets and performs some cleaning on human activity data, built
# from recordings of subjects performing daily activities while carrying
# smartphone. The full description of the data set is available at:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Step 1: Merges the training and the test sets to create one data set.
# setwd("D:\\Raghu\\Material\\Coursera\\Getting and Cleaning Data\\UCI HAR Dataset")

# Loading training data sets
trainData <- read.table(".\\train\\X_train.txt")
trainLabel <- read.table(".\\train\\y_train.txt")
trainSubject <- read.table(".\\train\\subject_train.txt")

# Loading testing data sets
testData <- read.table(".\\test\\X_test.txt")
testLabel <- read.table(".\\test\\y_test.txt")
testSubject <- read.table(".\\test\\subject_test.txt")

# Loading Features data
features <- read.table("features.txt")

# Loading Activity Labels data
activity_labels <- read.table("activity_labels.txt")

# Joining the respective data sets using rbind
joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)

# Step2. Extracts only the measurements on the mean and standard 
# deviation for each measurement. 

# Using descriptive names
names(joinData) <- features$V2
names(joinLabel) <- "activity"
names(joinSubject) <- "subjectId"

# Creating one dataset by joining all the data sets using cbind
mergeData <- cbind(joinData, joinLabel, joinSubject)
meanstdcols <- grep("mean\\(\\)|std\\(\\)|activity|subjectId", names(mergeData))
mergeData <- mergeData[, meanstdcols]

names(mergeData) <- gsub("\\(\\)", "", names(mergeData)) # remove "()"
names(mergeData) <- gsub("mean", "Mean", names(mergeData))
names(mergeData) <- gsub("std", "Std", names(mergeData))
names(mergeData) <- gsub("-", "", names(mergeData))

# write out the 1st dataset to a txt file
write.table(mergeData, "tidy_data.txt")

# Step 3: Uses descriptive activity names to name the activities in the data set
# Step 4: Appropriately labels the data set with descriptive variable names. 
mergeData$activity <- factor(mergeData$activity, labels=c("Walking",
    "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

# STep 5: Creates a second, independent tidy data set with the average of
# each variable for each activity and each subject. 
library("reshape2")
melted <- melt(mergeData, id=c("subjectId","activity"))
result <- dcast(melted, subjectId+activity ~ variable, mean)

# write out the 2nd dataset to a txt file
write.table(result, "tidy_data_with_means.txt")

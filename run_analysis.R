## Author/Student Name: Subhasis Datta
## Course Name: Getting and Cleaning Data
## Program: JHU Data Science Specialization
## Due Date: April 26, 2015
## Project Requirements / Description:
## Objective: Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Install package "plyr" if not already loaded
library(plyr)

## Download the UCI data set from the repository as identified in the project from the URl provided and Unzip 
## Data Set source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## Create Folder in local directory and create File Path for the data file to point to

MyLocalDataPath = "UCI HAR Dataset/"
ProjecFilePath <- function(filepath) {
  paste(MyLocalDataPath, filepath, sep="")
}

## Step 1: Merge the training and the test data sets to create a Merged Data Set

TrainXData <- read.table(MyLocalDataPath("train/X_train.txt"))
TestYData <- read.table(MyLocalDataPath("test/X_test.txt"))
MergedXData <- rbind(TrainData, TestData)

## Remove variables not needed
rm(TrainData, TestData)

TrainYData <- read.table(MyLocalDataPath("train/y_train.txt"))
TestYData <- read.table(MyLocalDataPath("test/y_test.txt"))
MergedYData <- rbind(TrainYData, TestYData)

## Remove variables not needed
rm(TrainYData, TestYData)

SubjectTrainData <- read.table(MyLocalDataPath("train/subject_train.txt"))
SubjectTestData <- read.table(MyLocalDataPath("test/subject_test.txt"))
MergedSubjectData <- rbind(SubjectTrainData, SubjectTestData)

## Remove variables not needed
rm(SubjectTrainData, SubjectTestData)

## Step 2: Extract only the measurements on the mean and standard deviation for each measurement

FeaturesData <- read.table(MyLocalDataPath("features.txt"))
FinalFeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
MergedXData <- MergedXData[, FinalFeatures]

# we set and clean column names
names(MergedXData) <- features[FinalFeatures, 2]
# we remove unwanted characters from column names
names(MergedXData) <- gsub("\\(|\\)", "", names(MergedXData))
names(MergedXData) <- tolower(names(MergedXData))

## Remove variables not needed
rm(FinalFeatures, features)

## Step 3: Use descriptive activity names to name the activities in the data set
## Step 4. Appropriately labels the data set with descriptive activity names.

ActivityLabels <- read.table(MyLocalDataPath("activity_labels.txt"))

## Clean Up Names
ActivityLabels[, 2] = gsub("_", "", tolower(as.character(ActivityLabels[, 2])))
MergedYData[,1] = ActivityLabels[MergedYData[,1], 2]

## Name column
names(MergedYData) <- "activity"

## label SubjectData
names(SubjectData) <- "subjectnumber"

# Step: 4  & 5 Merge everthing together and save into a file: MergedXData, MergedYData, SubjectData

FinalMerged<- cbind(SubjectData, MergedXData, MergedYData)
write.table(FinalMerged, "tidy_data.txt")

## Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
ExcludedColumns = which(names(FinalMerged) %in% c("subjectnumber", "activity"))
Finalresult <- ddply(FinalMerged, .(subjectnumber, activity), .fun=function(x){ colMeans(x[,-ExcludedColumns]) })

write.table(Finalresult, "average_data.txt")

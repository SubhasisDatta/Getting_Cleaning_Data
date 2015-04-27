## CodeBook.md
## This code book describes the variables, the data, and any transformations or work that you performed to clean up the data 
# Author/Student Name: Subhasis Datta
# Course Name: Getting and Cleaning Data
# Program: JHU Data Science Specialization
# Due Date: April 26, 2015
# Project Requirements / Description:
# Objective: Create one R script called run_analysis.R that does the following: 1. Merges the training and the test sets to create one data set. 2. Extracts only the measurements on the mean and standard deviation for each measurement. 3. Uses descriptive activity names to name the activities in the data set 4. Appropriately labels the data set with descriptive activity names.5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Install package "plyr" if not already loaded

# Download the UCI data set from the repository as identified in the project from the URl provided and Unzip 
# Data Set source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# Create Folder in local directory and create File Path for the data file to point to

Variable: MyLocalDataPath created to identify the path where all the data sets that have been unzipped are stored with their appropriate folder structure under train, test and the other folders or files as needed by the R Program

# Step 1: Merge the training and the test data sets to create a Merged Data Set

Variable: TrainXData reads the Train X Data from the appropriate folder data file in table format

Variable: TestYData reads the Test X Data from the appropriate folder data file in table format


# Remove variables and tables not needed - Train and Test X Data


Variable: TrainYData reads the Train Y Data from the appropriate folder data file in table format

Variable: TestYData reads the Test Y Data from the appropriate folder data file in table format

Variable: MergedYData merges the Train and Test Data in a single table

# Remove variables and tables not needed - Train and Test Y Data

Variable: SubjectTrainData reads the Train Subjects Data from the appropriate folder data file in table format

Variable: SubjectTestData reads the Test Subjects Data from the appropriate folder data file in table format

Variable: MergedSubjectData merges the Train and Test Subjects Data in a single table


# Remove variables and tables not needed - Train and Test Subject Data

# Step 2: Extract only the measurements on the mean and standard deviation for each measurement

Variable: FeaturesData reads the Featuires Data from the appropriate folder data file in table format

Variable FinalFeatures identifies and selects the features that are Mean and Standard Deviation

Variable MergedXData contains the Final features in the Merged X Data

# Remove variables and tables not needed - Merged X Data variable

# Remove unwanted characters from column names and covert to lower case the Merged Data set

# Remove variables not needed
# Remove variables and tables not needed - Final Features and Features Data 


# Step 3: Use descriptive activity names to name the activities in the data set
# Step 4. Appropriately labels the data set with descriptive activity names.

ActivityLabels <- read.table(MyLocalDataPath("activity_labels.txt"))

# Clean Up Names
ActivityLabels[, 2] = gsub("_", "", tolower(as.character(ActivityLabels[, 2])))
MergedYData[,1] = ActivityLabels[MergedYData[,1], 2]

# Name the correct column as Activity in the Merged Data set

# Name the correct column as SubjectNumber in the Subject 
Data

# Step: 4  & 5 Merge everthing together and save into a single table from MergedXData, MergedYData, SubjectData

Variable: FinalMerged is the table with the merged SubjectData, MergedXData, MergedYData

# Write the Table from the FinalMerged to a "tidy_data.txt" text file

# Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

Variable ExcludedColumns exclude all irrelevant except the avreage and standard devaiation variables 

Variable Finalresult is the final version of the results table after the excluded columns

# Write the Table from the Finalresult to a "average_data.txt" text file

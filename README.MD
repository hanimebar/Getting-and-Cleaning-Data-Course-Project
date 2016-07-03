# Getting and Cleaning Data Course Project
This project required us to create an R-script that would take a set of data 
from various files, in various folders, and merge it to create a single data-
set that can be analysed once it runs through R. 

# Instructions
1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Files Provided by the Instructors

a zipped folder with the title dataset.zip, once extracted, the following were found  main folder UCI HAR Dataset

'Test' folder

'Train' folder

'activity_labels.txt'

'features.txt'

'features_info.txt'

'README.txt'

On inspection of the 'Test' folder

'subject_test.txt'

'X_test.txt'

'y_test.txt'

Intertial Signals folder

On inspection of the 'Train' folder

'subject_train.txt'

'X_train.txt'

'y_train.txt'

Intertial Signals folder

The inertial signals folder had several .txt files which we did not go through as they contained data 
that was not goig to be used for the project.

# Script description

First I needed to Download the files mentioned above for the assignment followed by unzipping them. This included making the a directory and path to be used for R to collect the data.

if(!file.exists("./GaCDAssignment")){dir.create("./GaCDAssignment")}

download.file(fileURL, destfile = "./GaCDAssignment/dataset.zip")

unzip(zipfile="./GaCDAssignment/dataset.zip", exdir="./GaCDAssignment")

Creating a path to the dataset for R to pick the data from

folder <- file.path("./GaCDAssignment", "UCI HAR Dataset")

files <- list.files(folder, recursive=TRUE)

UCI_dataset <- list.files(folder, recursive=TRUE)

Creating the tables for each variable after looking what's inside each .txt file.  Before this step though I also broke down what the main variables are.  x (train and test), y (train and test) subject (train and test), features and train or test and finally also using the labels provided by the study.

  X_Train <- read.table(file.path(folder, "train", "X_train.txt"), header=FALSE)
  
  X_Test <- read.table(file.path(folder, "test", "X_test.txt"), header=FALSE)
  
  Y_Train <- read.table(file.path(folder, "train", "y_train.txt"), header=FALSE)
  
  Y_Test <- read.table(file.path(folder, "test", "y_test.txt"), header=FALSE)
  
  Subject_Train <- read.table(file.path(folder, "train", "subject_train.txt"), header=FALSE)
  
  Subject_Test <- read.table(file.path(folder,"test", "subject_test.txt"), header=FALSE)
  
  Features <- read.table(file.path(folder, "features.txt"), header=FALSE)
  
  Activity_Labels = read.table(file.path(folder, "activity_labels.txt"), header=FALSE)

Creating the common column labels and then merging the data -  the  x and y train/test, subject, and activity labels/movements.  This will conclude part 1 of the assignment.

  colnames(X_Train) <- Features[, 2]
  
  colnames(Y_Train) <- "Activity"
  
  colnames(Subject_Train) <- "Subject"
  
  colnames(X_Test) <- Features[, 2]
  
  colnames(Y_Test) <- "Activity"
  
  colnames(Subject_Test) <- "Subject"
  
  colnames(Activity_Labels) <- c("Activity", "Movement")
  
  Train <- cbind(Y_Train, Subject_Train, X_Train) ## merge the train data
  
  Test <- cbind(Y_Test, Subject_Test, X_Test) ## merge the test data
  
  All <- rbind(Train, Test) ## merge all the data

# Part 2 Extracts only the measurements on the mean and standard deviation for each measurement.  

If you look at the features.txt, and read features_info.txt you will find measurements that contain mean() and std() after some measurements - which have now been linked together with the  data through our merging of files above.  So, we just want to get this data. 

  MeanStdFeatures <- Features$V2[grep("mean\\(\\)|std\\(\\)", Features$V2)]
  
  selectedNames <- c(as.character(MeanStdFeatures), "Subject", "Activity")
  
  All_MeanStd <- subset(All, select=selectedNames)

# Part 3 Uses descriptive activity names to name the activities in the data set.  

Since we have the Activity Labels provided, with ids for each then we can update them to have the lable names. 

Activity_Labels2 <- read.table(file.path(folder, "activity_labels.txt"), header=FALSE)

All$Activity <- factor(All$Activity, labels=as.character(Activity_Labels2$V2))

## Part 4 Appropriately labels the data set with descriptive variable names. 

When you look at the data, it is in the shortened format like tGravityAccMag-std() which is not UNtidy, but we can expand those terms for the laymen to better to understand what they represent.  So this part asks us to clarify these terms. When you read the features_info.txt, you can pick out what some of these terms are. t = time, f = frequency, Acc = Accelerometer, Gyro = Gyrscope, mag = magnitude, jerk = Jerk (eg 'signals', not Donald Trump). 

  names(All) <- gsub("^f", "Frequency", names(All))
  
  names(All) <- gsub("^t", "time", names(All))
  
  names(All) <- gsub("Mag", "Magnitude", names(All))
  
  names(All) <- gsub("Acc", "Accerlerometor", names(All))
  
  names(All) <- gsub("Gyro", "Gyroscope", names(All))
  
  names(All) <- gsub("std()", "Standard Deviation", names(All))
  
  names(All) <- gsub("mean()", "MEAN", names(All))
  
  names(All) <- gsub("BodyBody", "Body", names(All))

## Part 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

I understand this as taking the "All" data that I've worked on and creating a new data set, which is now tidy, that gets the average of the three variables we've been looking at: Subject, Activity, and Features..

  library(plyr)
  
  Tidy_Data <- aggregate(.~Subject + Activity, All, mean)
  
  Tidy_Data <- Tidy_Data[order(Tidy_Data$Subject, Tidy_Data$Activity),]
  
  write.table(Tidy_Data, file="tidyUCIHARDataset.txt", row.names=FALSE)
  
  

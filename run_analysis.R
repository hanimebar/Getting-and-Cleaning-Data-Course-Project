## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation
##    for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject.

## Downloading the files for the assignment followed by unzipping


if(!file.exists("./GaCDAssignment")){dir.create("./GaCDAssignment")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./GaCDAssignment/dataset.zip")
unzip(zipfile="./GaCDAssignment/dataset.zip", exdir="./GaCDAssignment")

## creating a path to the dataset for R to pick the data from

folder <- file.path("./GaCDAssignment", "UCI HAR Dataset")
files <- list.files(folder, recursive=TRUE)
UCI_dataset <- list.files(folder, recursive=TRUE)

## creating the tables for each variable after looking what's inside
## each .txt file.  Before this step though I also broke down what
## the main variables are.  x (train and test), y (train and test), 
## subject (train and test), features and train or test and finally 
## also using the labels provided by the study.

X_Train <- read.table(file.path(folder, "train", "X_train.txt"), header=FALSE)
X_Test <- read.table(file.path(folder, "test", "X_test.txt"), header=FALSE)
Y_Train <- read.table(file.path(folder, "train", "y_train.txt"), header=FALSE)
Y_Test <- read.table(file.path(folder, "test", "y_test.txt"), header=FALSE)
Subject_Train <- read.table(file.path(folder, "train", "subject_train.txt"), header=FALSE)
Subject_Test <- read.table(file.path(folder,"test", "subject_test.txt"), header=FALSE)
Features <- read.table(file.path(folder, "features.txt"), header=FALSE)
Activity_Labels = read.table(file.path(folder, "activity_labels.txt"), header=FALSE)

## creating the common column labels and then merging the data -  the  x and y 
## train/test, subject, and activity labels/movements.  This will conclude 
## part 1 of the assignment.

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

## Part 2 Extracts only the measurements on the mean and standard deviation
## for each measurement.  If you look at the features.txt, and read 
## features_info.txt you will find measurements that contain mean() and std()
## after some measurements - which have now been linked together with the 
## data through our merging of files above.  So, we just want to get this
## data. 

MeanStdFeatures <- Features$V2[grep("mean\\(\\)|std\\(\\)", Features$V2)]
selectedNames <- c(as.character(MeanStdFeatures), "Subject", "Activity")
All_MeanStd <- subset(All, select=selectedNames)

## Part 3 Uses descriptive activity names to name the activities in the 
## data set.  Since we have the Activity Labels provided, with ids for each
## then we can update them to have the lable names. 

Activity_Labels2 <- read.table(file.path(folder, "activity_labels.txt"), header=FALSE)
All$Activity <- factor(All$Activity, labels=as.character(Activity_Labels2$V2))

## Part 4 Appropriately labels the data set with descriptive variable names
## When you look at the data, it is in the shortened format like 
## tGravityAccMag-std() which is not UNtidy, but we can expand those terms for the laymen
## be better to understand what they represent.  So this part asks us to clarify
## these terms. When you read the features_info.txt, you can pick out what some of these
## terms are. t = time, f = frequency, Acc = Accelerometer, Gyro = Gyrscope,
## mag = magnitude, jerk = Jerk (signals). 

names(All) <- gsub("^f", "Frequency", names(All))
names(All) <- gsub("^t", "time", names(All))
names(All) <- gsub("Mag", "Magnitude", names(All))
names(All) <- gsub("Acc", "Accerlerometor", names(All))
names(All) <- gsub("Gyro", "Gyroscope", names(All))
names(All) <- gsub("std()", "Standard Deviation", names(All))
names(All) <- gsub("mean()", "MEAN", names(All))
names(All) <- gsub("BodyBody", "Body", names(All))

## Part 5: From the data set in step 4, creates a second, independent tidy data
## set with the average of each variable for each activity and each subject. I  
## understand this as taking the "All" data that I've worked on and creating a
## new data set, which is now tidy, that gets the average of the three variables
## we've been looking at: Subject, Activity, and Features..

library(plyr)
Tidy_Data <- aggregate(.~Subject + Activity, All, mean)
Tidy_Data <- Tidy_Data[order(Tidy_Data$Subject, Tidy_Data$Activity),]
write.table(Tidy_Data, file="tidyUCIHARDataset.txt", row.names=FALSE)

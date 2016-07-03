# Getting-and-Cleaning-Data-Course-Project Code Book

## In this section I will try to explain what each code from the script does and what the data is telling us

***from the tidydataRscript***

**GaCDAssignment**: stands for 'Getting and Cleaning Data Assignment', it is the folder name on the student's computer for the project.

**fileUrl**: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**folder**: the location of the UCI HAR Dataset provided for the project

**UCI_Dataset**: character vector that lists all the files inside the *UCI HAR Folder* which was unzipped from the *fileUrl*

**X_Train**: all the training set values extracted from the *x_train.txt* and put into a table. (7352 obs. of 561 vars.)

**X_Test**: all the test values extracted from the *x_test.txt* and put into a table. (2947 obs. of 561 vars.)

**Y_Train**: all the training set labels extracted from the *y_train.txt* and put into a table (7352 obs. of 1 var.)

**Y_Test**:  all the test labels extracted from the *Y_test.txt* and put into a table. (2947 obs. of 1 var.)

**Subject_Train**: a set of identifiers for each individual subject (person) who performed the activity for the training, per window sample. (they look like illegible symbols in the *subject_train.txt* file). (7352 obs. of 1 var.)

**Subject_Test**: a set of identifiers for each individual subject (person) who performed the activity for the testing, per window sample. (they look like illegible symbols in the *subject_test.txt* file). (2947 obs. of 1 var.)

**Features**: the list of all the features extracted from the *features.txt* file and put into a table. (561 obs. of 2 vars.)

**Activity_Labels**: a key that shows the class labels and the activity name associated with it, extracted from the *activity_labels.txt* file.  (6 obs. of 2 vars.) **NB** *: the column names in this set are "Activity" and "Movement".*

**Activity_Labels2**:  a key that shows the class labels and the activity name associated with it, extracted from the *activity_labels.txt* file.  (6 obs. of 2 vars.). **NB** *: the column names in this set are unchanged.*

**Train**: the merged *training* dataset (7352 obs. of 563 vars)

**Test**: the merged *test* dataset (2947 obs. of 563 vars.)

**All**: the total merged *test* and *train* unaggregated-yet-to-be tidy dataset. (10299 obs. of 563 vars.) 

**MeanStdFeatures** : the mean() and std() values as extracted from the **Features** dataset. 

**selectedNames**: a dataset of all mean() and std() values as extracted from **MeanStdFeatures** but only focusing on those under "Subject" and "Activity".

**All_MeanStd**: a dataset that now takes **All** and only extracts the std() and mean() data within the provided dataset. (10299 obs. of 68 vars)

**Tidy_Data**:  the aggregated tidy data set from the merged data in **All** containing 180 obs. from 479 vars. 

# Codes from the provided test files

## These signals were used to estimate variables of the feature vector for each pattern

*'-XYZ'* is used to denote 3-axial signals in the X, Y and Z directions

- 't': stands for 'time'
- 'f': stand for 'frequency'
- 'Body': acceleration signal data measured as coming from the Body. 
- 'Gravity': acceleration signal data meaured as coming from gravity.
- 'Jerk': body linear acceleration and angular velocity (ie : a signal, and not like Donald trump)
- 'Acc': Accelerometer reading
- 'Gyro': Gyroscope reading
- 'Mag': calculated magnitude of the three-dimensional signals. 

## The above then can be applied to the labels below

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

## The set of variables that were estimated from these signals are: 

**mean()**: Mean value

**std()**: Standard deviation

**mad()**: Median absolute deviation 

**max()**: Largest value in array

**min()**: Smallest value in array

**sma()**: Signal magnitude area

**energy()**: Energy measure. Sum of the squares divided by the number of values. 

**iqr()**: Interquartile range 

**entropy()**: Signal entropy

**arCoeff()**: Autorregresion coefficients with Burg order equal to 4

**correlation()**: correlation coefficient between two signals

**maxInds()**: index of the frequency component with largest magnitude

**meanFreq()**: Weighted average of the frequency components to obtain a mean frequency

**skewness()**: skewness of the frequency domain signal 

**kurtosis()**: kurtosis of the frequency domain signal 

**bandsEnergy()**: Energy of a frequency interval within the 64 bins of the FFT of each window.

**angle()**: Angle between to vectors.

## Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle()
variable:

gravityMean

tBodyAccMean

tBodyAccJerkMean

tBodyGyroMean

tBodyGyroJerkMean

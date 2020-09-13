# Getting-and-Cleaning-Data-Course-Project
The purpose of this script is to use the UCI HAR dataset and make an analysis about it using Data Science.
## Files used from the initial dataset:
1. features.txt - includes the descriptions for features measured
2. train/X_train.txt - includes the measurements of the features in train set (one row - 1 measurement of 561 features)
3. test/X_test.txt - includes the measurements of the features in test set
4. train/subject_train.txt - subject for each measurement from the train set
5. test/subject_test.txt - subject for each measurement from the test set
6. train/y_train.txt - activity (from 1 to 6) for each measurement from the train set
7. test/y_test.txt - activity (from 1 to 6) for each measurement from the test set

## Analysis steps
1. Download the necessary files from the web
2. Selecting the files and putting them into dataframe so R can deal with them
3. Filtering the features with "mean" and "standard deviation" using the grep function
4. Name the columns with descriptive feature names
5. Give descriptive names to the activities adding a new column "Activity"
6. Create a melted tidy dataset with the selected and the new columns using the reshape2 package.  

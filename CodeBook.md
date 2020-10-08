# Data 

## Source Data - From URI HAR Dataset
* x_train.txt, y_train.txt, subject_train.txt
* x_test.txt, y_test.txt, subject_test.txt

* Features.txt - contains the correct variable name, which corresponds to each column of x_train.txt and x_test.txt 

* Features_info.txt - Provide description of each features

* Activity_labels.txt - contains the desciptive names for each activity label, which corresponds to each number in the y_train.txt and y_test.txt

# Steps to process the data

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Create tidy data set with the average of each variable for each activity and each subject.


## Output 

* tidyData.txt - is the output from run_analysis.R

# Descriptions

## Identififiers
The first two columns - Subject and Activity - are Identifiers.

* Subject: the ID of the Subject
* Activity: the Name of the Activity performed by the subject when measurements were taken

## Measurements
The variables remaining are just the calculatd means and standard deviations of the sets of data 


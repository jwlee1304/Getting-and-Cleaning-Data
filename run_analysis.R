
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each variable for each activity and each subject.


# Load Packages 
library(reshape2)


# Get dataset from web
dataPath <- getwd()
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataURL, file.path(dataPath, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")



# 1. Merge the training and the test sets to create one data set
# training data
X_train <- read.table(paste(sep = "", dataPath, "/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste(sep = "", dataPath, "/UCI HAR Dataset/train/y_train.txt"))
subject_train <- read.table(paste(sep = "", dataPath, "/UCI HAR Dataset/train/subject_train.txt"))


# test data
X_test <- read.table(paste(sep = "", dataPath, "/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste(sep = "", dataPath, "/UCI HAR Dataset/test/y_test.txt"))
subject_test <- read.table(paste(sep = "", dataPath, "/UCI HAR Dataset/test/subject_test.txt"))


# merge the training and the test sets
X_data <- rbind(X_train, X_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

## 2. Extract only the measurements on the mean and standard deviation for each measurement.

# Features 
feature <- read.table(paste(sep = "", dataPath, "/UCI HAR Dataset/features.txt"))

# Activity Labels
a_label <- read.table(paste(sep = "", dataPath, "/UCI HAR Dataset/activity_labels.txt"))
a_label[,2] <- as.character(a_label[,2])

# Extract feature cols & names with 'mean' and std'
selectedCols <- grep("-(mean|std).*", as.character(feature[,2]))
selectedColNames <- feature[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)


# 3. Uses descriptive activity names to name the activities in the data set
# Extract data by cols & using descriptive name

X_data <- X_data[selectedCols]
allData <- cbind(subject_data, y_data, X_data)
colnames(allData) <- c("Subject", "Activity", selectedColNames)

allData$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
allData$Subject <- as.factor(allData$Subject)


# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each variable for each activity and each subject.

# Create tidy data set
meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidyData.txt", row.names = FALSE, quote = FALSE)


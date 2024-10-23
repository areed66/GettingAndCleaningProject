
# Getting and Cleaning Course Project

# if file does not exist in directory then download zip file from URL link
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, "Coursera_DS3_Final.zip", method="curl")
}  

# Checking if folder exists and unzip file
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

# import all variables from each file downloaded
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


# 1) Merge the training and the test sets to create one data set.

m <- cbind(rbind(subject_train, subject_test), rbind(x_train, x_test), rbind(y_train, y_test))
str(m)


# 2) Extract only the measurements on the mean and standard deviation for each measurement.
td <- m %>% select(subject, code, contains("mean"), contains("std"))
str(td)

# 3) Uses descriptive activity names to name the activities in the data set

td$code <- activities[td$code, 2]
head(td$code)


# 4) Appropriately labels the data set with descriptive variable names.

names(td)[2] = "activity"
names(td)<-gsub("Mag", "Magnitude", names(td))
names(td)<-gsub("-mean()", "Mean", names(td), ignore.case = TRUE)
names(td)<-gsub("-std()", "STD", names(td), ignore.case = TRUE)
names(td)<-gsub("Acc", "Accelerometer", names(td))
names(td)<-gsub("^t", "Time", names(td))
names(td)<-gsub("^f", "Frequency", names(td))
names(td)<-gsub("tBody", "TimeBody", names(td))
names(td)<-gsub("BodyBody", "Body", names(td))
names(td)<-gsub("Gyro", "Gyroscope", names(td))
names(td)<-gsub("-freq()", "Frequency", names(td), ignore.case = TRUE)
names(td)<-gsub("angle", "Angle", names(td))
names(td)<-gsub("gravity", "Gravity", names(td))


# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

new_data <- td %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))


write.table(new_data, "NewData.txt", row.name=FALSE)

new_data

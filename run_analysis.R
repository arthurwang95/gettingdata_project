## Assume the working directory "./UCI HAR Dataset" containing all original files has been created.

setwd ("./UCI HAR Dataset")
library (dplyr)

## 1. Merges the training and the test sets to create one data set.


training <- read.table ("./train/X_train.txt", header = FALSE)
test <- read.table ("./test/X_test.txt", header = FALSE)
combine <- rbind(training, test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
###   NOTE: All variables contain "mean" or "std" are extracted.
features <- read.table ("./features.txt", header = FALSE, colClasses = c("integer", "character"))
names(combine) <- tolower (features[,2])
tidyData <- combine [,grep ("mean|std", features[,2])] 


## 3. Uses descriptive activity names to name the activities in the data set
train_labels <- read.table("./train/Y_train.txt", header = F)
test_labels <- read.table("./test/Y_test.txt", header = F)
labels <- rbind (train_labels, test_labels)

activities <- read.table("./activity_labels.txt", header = F)
tidyData <- mutate (tidyData, activity = tolower (factor (labels[[1]], labels = activities[,2])))
tidyData$activity <-sub("_", "", tidyData$activity)

## 4. Appropriately labels the data set with descriptive variable names.
names(tidyData)<-gsub("acc", "accelerometer", names(tidyData))
names(tidyData)<-gsub("gyro", "gyroscope", names(tidyData))
names(tidyData)<-gsub("bodybody", "body", names(tidyData))
names(tidyData)<-gsub("mag", "magnitude", names(tidyData))
names(tidyData)<-gsub("^t", "time", names(tidyData))
names(tidyData)<-gsub("^f", "frequency", names(tidyData))
names(tidyData)<-gsub("-mean", "mean", names(tidyData))
names(tidyData)<-gsub("-std", "std", names(tidyData))
names(tidyData)<-gsub("-x$", "x", names(tidyData))
names(tidyData)<-gsub("-y$", "y", names(tidyData))
names(tidyData)<-gsub("-z$", "z", names(tidyData))
names(tidyData)<-gsub("[()]", "", names(tidyData))


## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##   average of each variable for each activity and each subject.

test_subject <- read.table("./test/subject_test.txt", col.names = "subject")
train_subject <- read.table("./train/subject_train.txt", col.names = "subject")
subject <- rbind (train_subject, test_subject)
tidyData_new <- cbind(subject, tidyData)
finaltidyData <- tidyData_new %>% group_by (subject, activity) %>% summarise_all(funs(mean))

## Save the final tidy data set under the working directory
write.table(finaltidyData, "finaltidyData.txt", row.name=FALSE)



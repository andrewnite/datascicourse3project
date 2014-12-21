# Packages
install.packages("dplyr")
library("dplyr")

# Test datasets
xTest <- read.table("test/X_test.txt")
activityTest <- read.table("test/y_test.txt")
subjectTest <- read.table("test/subject_test.txt")

# Train datasets
xTrain <- read.table("train/X_train.txt")
activityTrain <- read.table("train/y_train.txt")
subjectTrain <- read.table("train/subject_train.txt")

# General datasets
activityLabels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
featureLabels <- read.table("features.txt", stringsAsFactors = FALSE)

# Name the activityLabels
colnames(activityLabels)<-c("activityId", "activityName")

# Combine the 'Test' datasets
combinedTest <- cbind(subjectTest, activityTest, xTest)

# Combine the 'Train' datasets
combinedTrain <- cbind(subjectTrain, activityTrain, xTrain)

# Combine the 'Test' and 'Train' data
combinedDataset <- rbind(combinedTest, combinedTrain)

# Set the colnames of the Combined Dataset
combinedColNames<-as.list(rbind("subjectId", "activityId", featureLabels[2]))
colnames(combinedDataset)<-combinedColNames[[1]]

# Merge with the 'Activity Lookup' table to get the Activity Name
combinedDataset <- merge(combinedDataset, activityLabels, by.x="activityId", by.y = "activityId")

# Get col names which contain mean() or std()
onlyColNames<-combinedColNames[[1]][grepl("mean()|std()", combinedColNames[[1]])]

# Include these columns
includeColNames <- c("subjectId", "activityId", "activityName", onlyColNames)

# Strip the combined dataset to only the necessary columns
trimmedCombinedDataset <- combinedDataset[includeColNames]

# All the colNames without the first 3
colsToSummarize <- names(trimmedCombinedDataset)[-1:-3]

# Get each of the column means grouped by subject id and activity id
grpd <- group_by(trimmedCombinedDataset, subjectId, activityId, activityName)
dots <- sapply(colsToSummarize ,function(x) substitute(mean(x), list(x=as.name(x))))
resultDataset <- do.call(summarise, c(list(.data=grpd), dots))

# Write to a text file
write.table(resultDataset, "cleanedDataset.txt", row.name=FALSE)


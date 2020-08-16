X_train <- read.table("train/X_train.txt")               ## reads training set
y_train <- read.table("train/y_train.txt")               ## reads training labels
subject_train <- read.table("train/subject_train.txt")   ## reads subjects


X_test <- read.table("test/X_test.txt")              ## reads test set
y_test <- read.table("test/y_test.txt")              ## reads test labels    
subject_test <- read.table("test/subject_test.txt")  


activity_names <- read.table("activity_labels.txt")   ## reads activity name
features <- read.table("features.txt")   ## reads features
subjects = rbind(subject_train, subject_test)
labels = rbind(y_train, y_test)
##Merging the training and the test sets to create one data set.
mergedSets <- rbind(X_train, X_test) 
mergedSets$labels <- labels 
mergedSets$subjects <- subjects 
colnames(mergedSets) <- features$V2   ## assign col names

##Extracting only the measurements on the mean and standard deviation for each measurement.
subset <- grepl("mean()|std()", names(mergedSets))
df2 <- mergedSets[,subset]
df2 <- cbind(subjects, labels, df2)
colnames(df2)[1]<-"subject"
colnames(df2)[2]<-"activity"


##Uses descriptive activity names to name the activities in the data set
library(qdapTools)
df2[,2] <- lookup(df2[,2], activity_names, key.reassign = NULL,
                  missing = NA)  


write.table(df2,"tidy-data.txt", row.name=FALSE) ## writes the new data into txt format


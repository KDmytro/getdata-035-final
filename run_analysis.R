X_test <- read.table("data/test/X_test.txt")
subject_test <- read.table("data/test/subject_test.txt")
y_test <- read.table("data/test/y_test.txt")

X_train <- read.table("data/train/X_train.txt")
subject_train <- read.table("data/train/subject_train.txt")
y_train <- read.table("data/train/y_train.txt")

y <- rbind(y_test, y_train)
subject <- rbind(subject_test,subject_train)
X <- rbind(X_test, X_train)

rm(X_train,subject_train,y_train,X_test,subject_test,y_test)

features <- read.table("data/features.txt",stringsAsFactors=F)
columns <- make.names(features$V2)
full_set <- cbind(subject,y,X)
names(full_set) <- c("Subject","Activity",columns)
activity_lbls <- read.table("data/activity_labels.txt",stringsAsFactors=F)
full_set$Activity <- as.factor(full_set$Activity)
levels(full_set$Activity) <- activity_lbls$V2

right_columns <- grepl("([.]mean[.][.]|[.]std[.][.])",columns)

summary_set <- full_set[,c(TRUE,TRUE,right_columns)]

library(dplyr)
summary_final <- group_by(summary_set,Subject, Activity) %>% summarize_each("mean")
write.table(summary_final, "data/summary_final.txt", row.names = FALSE)

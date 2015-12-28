# ***************************************
# SECTION 1 - LOADING DATA
# ***************************************

# loading test data
X_test <- read.table("data/test/X_test.txt")
subject_test <- read.table("data/test/subject_test.txt")
y_test <- read.table("data/test/y_test.txt")

# loading train data
X_train <- read.table("data/train/X_train.txt")
subject_train <- read.table("data/train/subject_train.txt")
y_train <- read.table("data/train/y_train.txt")

# binding by rows both sets of data into 3 combined sets - X, sebject, y
X <- rbind(X_test, X_train)
subject <- rbind(subject_test,subject_train)
y <- rbind(y_test, y_train)

# creating full set by combining measurements from subject, y, X
full_set <- cbind(subject,y,X)

# removing source data from active memory
rm(X_train,subject_train,y_train,X_test,subject_test,y_test)

# ***************************************
# SECTION 2 - LABELING THE DATA
# ***************************************

# extracting list of features
features <- read.table("data/features.txt",stringsAsFactors=F)

# converting title to proper names
columns <- make.names(features$V2)

#labeling names in the full_set
names(full_set) <- c("Subject","Activity",columns)

# extracting list of activities and applying them as factor levels in the full_set
activity_lbls <- read.table("data/activity_labels.txt",stringsAsFactors=F)
full_set$Activity <- as.factor(full_set$Activity)
levels(full_set$Activity) <- activity_lbls$V2

# ***************************************
# SECTION 3 - SELECTING MEASUREMENTS
# ***************************************

# filter all features that contain ".mean.." and ".std.."
right_columns <- grepl("([.]mean[.][.]|[.]std[.][.])",columns)
summary_set <- full_set[,c(TRUE,TRUE,right_columns)]

# ***************************************
# SECTION 4 - CREATING A SUMMARY TABLE
# ***************************************

library(dplyr)
summary_final <- group_by(summary_set,Subject, Activity) %>% summarize_each("mean")

# ***************************************
# SECTION 5 - WRITING SUMMARY FILE
# ***************************************

write.table(summary_final, "data/summary_final.txt", row.names = FALSE)

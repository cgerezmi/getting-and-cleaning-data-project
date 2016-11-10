# -------------------------------------
#           STEP 1 & 2
# -------------------------------------

# Load common datasets
features            <- read.table("./UCI HAR Dataset/features.txt")
activity            <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Load "test" datasets
test_x              <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y              <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject        <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Load "train" datasets
train_x             <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y             <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject       <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Merge "test" and "train" datasets separately
data_x              <- rbind(test_x, train_x)
data_y              <- rbind(test_y, train_y)
data_subject        <- rbind(test_subject, train_subject)

# Remove unnecessary datasets
remove(test_x, test_y, test_subject)
remove(train_x, train_y, train_subject)

# Name columns for each dataset
names(data_x)       <- features[,2]
names(data_y)       <- "activity"
names(data_subject) <- "subject"

# Replace "data_x" with its subset, according to the given criteria (mean or std)
desired_col_index   <- grep("mean\\(\\)|std\\(\\)", names(data_x))
data_x              <- data_x[,desired_col_index]; remove(desired_col_index)

# Merge datasets as a single dataset (data)
data                <- cbind(data_subject, data_y, data_x)
remove(data_x, data_y, data_subject)

# -------------------------------------
#           STEP 3
# -------------------------------------
data_tmp            <- merge(activity, data, by.x = "V1", by.y = "activity", all = FALSE)
data                <- data_tmp[,-1] ; remove(data_tmp);
names(data)[1]      <- "activity"

# -------------------------------------
#           STEP 4
# -------------------------------------
names(data)         <- gsub("-mean\\()","Mean",names(data))
names(data)         <- gsub("-std\\()","StdDev",names(data))
names(data)         <- gsub("-","Of",names(data))
names(data)         <- gsub("^f","freq",names(data))
names(data)         <- gsub("^t","time",names(data))
names(data)         <- gsub("Mag","Magnitude",names(data))
names(data)         <- gsub("Acc","Accelaration",names(data))

# -------------------------------------
#           STEP 5
# -------------------------------------
library(plyr)
data_tidy <- ddply(data, .(subject, activity), function(x) colMeans(x[, 3:68]))
write.csv(data_tidy, "tidy.csv", row.names = FALSE)
remove(data_tidy)

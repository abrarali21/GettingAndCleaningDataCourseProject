library(reshape2) # used for melt() & dcast()

# Read the training dataset
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Read the testing dataset
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read the names of the features
features <- read.table("./UCI HAR Dataset/features.txt")

# Read the activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Combine the training and testing x datasets by rows and name the features
combined_x <- rbind(x_train, x_test)
names(combined_x) <- features[,2]

# Combine the training and testing y datasets by rows
combined_y <- rbind(y_train, y_test)

# Map the activity id to activity label, add the label to y dataset and name both columns
combined_y[,2] <- activity_labels[combined_y[,1],2]
names(combined_y) <- c("activityId", "activityLabel")

# Combine the training and testing subject datasets by rows and name the only column
combined_subject <- rbind(subject_train, subject_test)
names(combined_subject) <- "subject"

# Combine the complete x, y and subject datasets by binding them as columns
complete_dat <- cbind(combined_x, combined_y, combined_subject)

# Extract only the mean and standard deviation measurements from the complete data
mean_std_fnames <- grep ("mean|std", features[,2], value=TRUE)
mean_std_dat <- complete_dat[,mean_std_fnames]

# Add the y and subject datasets as columns
mean_std_dat <- cbind(mean_std_dat, combined_y, combined_subject)

# Melt the data frame choosing the activity & subject as id variables, 
# and the mean and standard as measured variables
melt_dat <- melt(mean_std_dat, c("activityId", "activityLabel", "subject"),
                  measure.vars = mean_std_fnames)

# Cast the data frame based on subject and activity label, 
# and calculating the mean of all variables for each subset
dcast_dat = dcast(melt_dat, subject + activityLabel ~ variable, mean)

# Write the tidy data to a file
write.table(dcast_dat, file = "./tidy_data.txt", row.name = FALSE)

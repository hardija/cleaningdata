library(reshape2)

# For testing set maxrows = 20, set maxrows = -1 for all
#maxrows = 20
maxrows = -1

# Find the columns for std and mean
features = read.csv("./UCI HAR Dataset/features.txt", sep=" ", header=FALSE)
features = features[,2]             # Just keep the feature names
std_idx = grep("std", features)         # Find the column indices for std dev
mean_idx = grep("mean", features)       # Find the column indices for mean
# Clean up the feature names
features = gsub("-", "_", features)
features = gsub("\\(", "", features)
features = gsub("\\)", "", features)
features = gsub(",", "_", features)
featureCols = sort(c(std_idx, mean_idx))     # Combine std and mean columns and sort
numFeatures = length(features)      # Remember the number of features (used below)

# Clean up memory
if (maxrows == -1) rm(list=c("std_idx", "mean_idx"))

# Read X train data and provide column names
X_train = read.fwf("./UCI HAR Dataset/train/X_train.txt", rep(16, numFeatures), col.names=features, n=maxrows)
# Subset on mean and std dev
X_train = X_train[,featureCols]
# Add subject information
subject_train = read.fwf("./UCI HAR Dataset/train/subject_train.txt", c(5), col.names=c("Subject"), n=maxrows)
X_train = cbind(subject_train, X_train)
# Clean up memory
if (maxrows == -1) rm("subject_train")

# Read X test data and provide column names
X_test = read.fwf("./UCI HAR Dataset/test/X_test.txt", rep(16, numFeatures), col.names=features, n=maxrows)
# Subset on mean and std dev
X_test = X_test[,featureCols]
# Add subject information
subject_test = read.fwf("./UCI HAR Dataset/test/subject_test.txt", c(5), col.names=c("Subject"), n=maxrows)
X_test = cbind(subject_test, X_test)
# Clean up memory
if (maxrows == -1) rm(list=c("subject_test", "features", "featureCols"))

# Combine train and test rows
X_train = rbind(X_train, X_test)
# Clean up memory
if (maxrows == -1) rm("X_test")

# Read y train data and provide column names
y_train = read.fwf("./UCI HAR Dataset/train/y_train.txt", c(5), col.names=c("Activity"), n=maxrows)
# Read y test data and provide column names
y_test = read.fwf("./UCI HAR Dataset/test/y_test.txt", c(5), col.names=c("Activity"), n=maxrows)

# Combine train and test rows
y_train = rbind(y_train, y_test)
# Clean up memory
if (maxrows == -1) rm("y_test")

# Add factors for activity names
activities = read.fwf("./UCI HAR Dataset/activity_labels.txt", c(2, 18), col.names=c("id", "Activity"))
y_train[,1] = cut(y_train[,1], c(0,activities[,1]), labels=activities[,2])

# Combine X and y columns
data = cbind(X_train, y_train)
# Clean up memory
if (maxrows == -1) rm(list=c("X_train", "y_train", "activities"))

# Write out the data set (not required)
# Don't include row names or the column names get shifted
#write.table(data, file="./output.csv", sep=",", row.names=FALSE)

# Create a tidy dataset with the average of each variable for each activity and each subject
molten = melt(data, id=c("Subject","Activity"))
tidy = dcast(molten, Subject + Activity ~ variable, mean)
# Clean up memory
if (maxrows == -1) rm(list=c("data", "molten"))

write.table(tidy, file="./tidy.csv", sep=',', row.names=FALSE)

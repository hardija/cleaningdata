###Input Data:
subjects = 30
features = 561
train data = 7352 obs, 128 vars
test data = 2947 obs, 128 vars
x_train = 7352 obs, 561 vars
y_train = 7352 obs, 1 var
x_test = 2947 obs, 561 vars
y_test = 2947 obs, 1 var

Procedure:
get feature names from features.txt
get feature subset for mean and std dev
read x_train file and provide column names
subset x_train for std and mean only
read subject_train file and provide column name
add subject column to x_train => cbind

read x_test file and provide column names
subset x_test for std and mean only
read subject_test file and provide column name
add subject column to x_test => cbind

merge x_train rows with x_test rows => rbind

read y_train and y_test files and provide column names
merge y_train rows with y_test rows

add factors for y

merge x columns with y column => cbind

Output data:


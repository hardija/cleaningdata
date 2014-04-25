###Input Data:
*subjects = 30
*features = 561
*train data = 7352 obs, 128 vars
*test data = 2947 obs, 128 vars
*x_train = 7352 obs, 561 vars
*y_train = 7352 obs, 1 var
*x_test = 2947 obs, 561 vars
*y_test = 2947 obs, 1 var

Procedure:
1. get feature names from features.txt
2. get feature subset for mean and std dev
3. read x_train file and provide column names
4. subset x_train for std and mean only
5. read subject_train file and provide column name
6. add subject column to x_train => cbind
7. read x_test file and provide column names
8. subset x_test for std and mean only
9. read subject_test file and provide column name
10. add subject column to x_test => cbind
11. merge x_train rows with x_test rows using rbind
12. read y_train and y_test files and provide column names
13. merge y_train rows with y_test rows
14. add factors for y
15. merge x columns with y column => cbind

Output data:


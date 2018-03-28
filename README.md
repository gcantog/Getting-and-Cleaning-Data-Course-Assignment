# Getting-and-Cleaning-Data-Course-Assignment
Cleaning Data Assignment

Description of the Variables:
=========================================

subject_train = read.table("subject_train.txt")
subject_test = read.table("subject_test.txt")
X_train = read.table("X_train.txt")
X_test = read.table("X_test.txt")
Y_train = read.table("y_train.txt")
Y_test = read.table("y_test.txt")
features = read.table("features.txt",stringsAsFactors=FALSE)
features2 = features[,2]
activity = read.table("activity_labels.txt")

# features reads the table'features.txt' which contains a List of all features.

# activity: reads the table 'activity_labels.txt'which Links the class labels with their activity name.

# xtrain: reads the table 'train/X_train.txt' which contains Training set.

# ytrain: reads the table'train/y_train.txt' which contains Training labels.

# xtest:reads the table 'test/X_test.txt'which contains Test set.

# y_test:reads the table 'test/y_test.txt'which contains Test labels.

# subject train and subject trainn read the table 'train/subject_train.txt'respectively: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 








- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

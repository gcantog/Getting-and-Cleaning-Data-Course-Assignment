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

 	##features reads the table'features.txt' which contains a List of all features.

	 ##activity: reads the table 'activity_labels.txt'which Links the class labels with their activity name.

 	##xtrain: reads the table 'train/X_train.txt' which contains Training set.

 	##ytrain: reads the table'train/y_train.txt' which contains Training labels.

	 ##xtest:reads the table 'test/X_test.txt'which contains Test set.

 	##y_test:reads the table 'test/y_test.txt'which contains Test labels.

	 ##subject train and subject trainn read the table 'train/subject_train.txt'respectively: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
	 

				Y<- rbind(Y_train,Y_test)
				subject <- rbind(subject_train,subject_test)
				X<- rbind(X_train,X_test)	
				
	## I merge the training and the test sets to create one data set.
	
				act= left_join(Y,activity, 'V1')
	## I give names to the activities
	
				dataset = as.data.frame(cbind(subject,act[,2],X))
	## I put evertything underone dataset
	
				colnames(dataset) <- c("Subject","Activity", features2)
				st=grep("std\\(\\)", names(dataset), value=TRUE)
				me=grep("mean\\(\\)", names(dataset), value=TRUE)
				stme=c("Subject","Activity",st,me)
				trimmed = dataset[,stme]
	## I rename the columns and select the ones for std and mean only
	
				label<-gsub("^t","time",names(trimmed))
				label2<-gsub("^f","freq",label)
				label3<-gsub("Acc","Accelerometer",label2)
				label4<-gsub("BodyBody","Body",label3)
				colnames(trimmed) <- c(label4)
	## I relabel the columns to show proper names
				
				final=trimmed%>% 
        			group_by(Subject,Activity)%>%
       				 summarise_all(mean)
				final
	## I group the data set by Subject & Activity and summarize all calculating the average by Subject by Activity.
	
				
	

Description of the script:
=========================================

There are 2 sets of data in the beginning, the "test" data and the "train" data with 3 files each of them (2X3= 6 files). There is aso a file called "features" that needs to be read into R as it is containing our future dataset columns. Also there is a file called "activity_labels.txt" with the list of activities. 

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The first step is to read all of them into R:

				subject_train = read.table("subject_train.txt")

				subject_test = read.table("subject_test.txt")

				X_train = read.table("X_train.txt")

				X_test = read.table("X_test.txt")

				Y_train = read.table("y_train.txt")

				Y_test = read.table("y_test.txt")

				features = read.table("features.txt",stringsAsFactors=FALSE)

				features2 = features[,2]  ##this is to select the column containing the names

				activity = read.table("activity_labels.txt")

 	##features reads the table'features.txt' which contains a List of all features.
	 ##activity: reads the table 'activity_labels.txt'which Links the class labels with their activity name.
 	##xtrain: reads the table 'train/X_train.txt' which contains Training set.
 	##ytrain: reads the table'train/y_train.txt' which contains Training labels.
	 ##xtest:reads the table 'test/X_test.txt'which contains Test set.
 	##y_test:reads the table 'test/y_test.txt'which contains Test labels.
	 ##subject train and subject train read the table 'train/subject_train.txt'respectively: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
	 
The second step is to merge the datasets "train" and "test" X,Y and Subject files respectively, turning 6 files into 3 sets of data	 

				Y<- rbind(Y_train,Y_test)
				subject <- rbind(subject_train,subject_test)
				X<- rbind(X_train,X_test)	

The "Y" set of data is showing the activities, now I need to put them a name that is shown under "activity" with the left_join function of the dplyr package:

				install.packages("dplyr")
				require(dplyr) ## this will install the package and load it
				act= left_join(Y,activity, 'V1')
	## This give names to the activities

The next step is to merge all the data, X,act(which in the second column is showing Y with names) and subject.I put evertything under one dataset, for that  I merge the training and the test sets to create one data set.

				dataset = as.data.frame(cbind(subject,act[,2],X))
		
Now I need name the fit two columns stating what they represent and add the rest of the column names loaded under "features2" 

				colnames(dataset) <- c("Subject","Activity", features2)
				
I need to select only the columns containing std() and mean(). The folowing set of code is what does that:

				st=grep("std\\(\\)", names(dataset), value=TRUE)
				me=grep("mean\\(\\)", names(dataset), value=TRUE)
				stme=c("Subject","Activity",st,me)
				trimmed = dataset[,stme]

The next bit of code will relabel some of the  columns in order to show proper names for the columns; changing t for time, f for freq, etc.	
	
				label<-gsub("^t","time",names(trimmed))
				label2<-gsub("^f","freq",label)
				label3<-gsub("Acc","Accelerometer",label2)
				label4<-gsub("BodyBody","Body",label3)
				label5<-gsub("[-()]"," ",label4)
				colnames(trimmed) <- c(label5)
	
As a last step, I group the data set by Subject & Activity and summarize all calculating the average by Subject by Activity. This will give me a single figure (average) per subject per activity

				final=trimmed%>% 
        			group_by(Subject,Activity)%>%
       				 summarise_all(mean)
				final
				
In order to load the final data, I upload my data set as a txt file created with write.table() using row.name=FALSE

				write.table(final,row.name=FALSE)

	
				
	

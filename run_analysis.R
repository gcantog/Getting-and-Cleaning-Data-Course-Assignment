subject_train = read.table("subject_train.txt")
subject_test = read.table("subject_test.txt")
X_train = read.table("X_train.txt")
X_test = read.table("X_test.txt")
Y_train = read.table("y_train.txt")
Y_test = read.table("y_test.txt")
features = read.table("features.txt",stringsAsFactors=FALSE)
features2 = features[,2]
activity = read.table("activity_labels.txt")
                  
Y<- rbind(Y_train,Y_test)
subject <- rbind(subject_train,subject_test)
X<- rbind(X_train,X_test)

install.packages("dplyr")
require(dplyr)

act= left_join(Y,activity, 'V1') 

dataset = as.data.frame(cbind(subject,act[,2],X))

colnames(dataset) <- c("Subject","Activity", features2)

st=grep("std\\(\\)", names(dataset), value=TRUE)
me=grep("mean\\(\\)", names(dataset), value=TRUE)

stme=c("Subject","Activity",st,me)

trimmed = dataset[,stme]

label<-gsub("^t","time",names(trimmed))
label2<-gsub("^f","freq",label)
label3<-gsub("Acc","Accelerometer",label2)
label4<-gsub("BodyBody","Body",label3)
label5<-gsub("[-()]"," ",label4)



colnames(trimmed) <- c(label5)

final=trimmed%>% 
        group_by(Subject,Activity)%>%
        summarise_all(mean)
final

write.table(final,row.name=FALSE)

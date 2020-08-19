xtrain<-read.table("X_train.txt")
ytrain<-read.table("y_train.txt")
ytest<-read.table("y_test.txt")
xtest<-read.table("x_test.txt")
activitylabels<-read.table("activity_labels.txt")
features<-read.table("features.txt")
subject_text<-read.table("subject_test.txt")
subject_test<-read.table("subject_test.txt")
subject_train<-read.table("subject_train.txt")
colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(subject_train) = "subjectId"
colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"
colnames(activitylabels) <- c('activityId','activityType')
merge_train = cbind(ytrain, subject_train, xtrain)
merge_test = cbind(ytest, subject_test, xtest)
Allanalysis<-rbind(merge_test,merge_train)
columnnames<-colnames(Allanalysis)
Mean_Std = (grepl("activityId" , columnnames) | grepl("subjectId" , columnnames) | grepl("mean.." , columnnames) | grepl("std.." , columnnames))
MeanAndStdData <- Allanalysis[ , Mean_Std == TRUE]
ActivityNames <-merge(MeanAndStdData, activitylabels, by='activityId', all.x=TRUE)
FinalDataAverage<-ActivityNames
FinalDataAverage<-tbl_df(FinalDataAverage)
FinalDataAverage<-group_by(FinalDataAverage,activityId,subjectId)
FinalDataAverage<-summarise_if(FinalDataAverage,is.numeric,mean)


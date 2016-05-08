---
title: "README"
author: "Vinicio De Sola"
date: "May 8, 2016"
output: html_document
---



The first step is to load the required libraries. I will be usisng dplyr and reshape 2


```r
library(dplyr)
library(reshape2)
```


The second step is to create the directory where the data will be stored and processed. We first do a verificaction to see if the directory exists. If not, create the directory. Then, we will download the file, if it doesn't exists. In my Windows the way to create proper files is to set the download mode as "wb"


```r
if(!file.exists("./data")){
        dir.create("./data")
}
if(!file.exists("./data/UCI.zip")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL,destfile = "./data/UCI.zip", mode = "wb")
}
```


The third step is to unzip the file. First, we will do a verification to see if the file has already been unzipped. If not, unzip.


```r
if(!file.exists("UCI HAR Dataset")){
        unzip("data/UCI.zip",exdir = "./data")
}
```


The fourth step is to look at all the files on the UCI folder. We will use the list.files funcion, with the recursive argument set as true. Then we will print on the console these files


```r
pathfolder <- file.path("./data","UCI HAR Dataset")
txtfiles <- list.files(pathfolder,recursive = TRUE)
txtfiles
```

```
##  [1] "activity_labels.txt"                         
##  [2] "features.txt"                                
##  [3] "features_info.txt"                           
##  [4] "README.txt"                                  
##  [5] "test/Inertial Signals/body_acc_x_test.txt"   
##  [6] "test/Inertial Signals/body_acc_y_test.txt"   
##  [7] "test/Inertial Signals/body_acc_z_test.txt"   
##  [8] "test/Inertial Signals/body_gyro_x_test.txt"  
##  [9] "test/Inertial Signals/body_gyro_y_test.txt"  
## [10] "test/Inertial Signals/body_gyro_z_test.txt"  
## [11] "test/Inertial Signals/total_acc_x_test.txt"  
## [12] "test/Inertial Signals/total_acc_y_test.txt"  
## [13] "test/Inertial Signals/total_acc_z_test.txt"  
## [14] "test/subject_test.txt"                       
## [15] "test/X_test.txt"                             
## [16] "test/y_test.txt"                             
## [17] "train/Inertial Signals/body_acc_x_train.txt" 
## [18] "train/Inertial Signals/body_acc_y_train.txt" 
## [19] "train/Inertial Signals/body_acc_z_train.txt" 
## [20] "train/Inertial Signals/body_gyro_x_train.txt"
## [21] "train/Inertial Signals/body_gyro_y_train.txt"
## [22] "train/Inertial Signals/body_gyro_z_train.txt"
## [23] "train/Inertial Signals/total_acc_x_train.txt"
## [24] "train/Inertial Signals/total_acc_y_train.txt"
## [25] "train/Inertial Signals/total_acc_z_train.txt"
## [26] "train/subject_train.txt"                     
## [27] "train/X_train.txt"                           
## [28] "train/y_train.txt"
```

After seeing all the files, and reading the README.txt of the data, we won't use the text files on the Inertial Signals Folder, because our interest is on the results on the experiment, not the technical variables of the test. We will use the read.table and the text files list's results

Read the subject files

```r
subjectTrain<-read.table(file.path(pathfolder,txtfiles[26]))
subjectTest<-read.table(file.path(pathfolder,txtfiles[14]))
```
Read the Activity files (named labes on the Readme.txt)

```r
activityTrain <- read.table(file.path(pathfolder,txtfiles[28]))
activityTest <-read.table(file.path(pathfolder,txtfiles[16]))
```
Read the data sets (features)

```r
setTrain <- read.table(file.path(pathfolder,txtfiles[27]))
setTest <- read.table(file.path(pathfolder,txtfiles[15]))
```
Read the features names

```r
features <- read.table(file.path(pathfolder,txtfiles[2]))
```
Read the activity labels names

```r
act_labels <- read.table(file.path(pathfolder,txtfiles[1]))
```

Now we will combine all the data. First we will merge both sets of features using rbind, because both are a set of observations. Then we will rbind the subjects and the activities. Finally, we will cbind the subjects, the features, and the activities

Combine the features sets

```r
set <- rbind(setTrain,setTest)
```
Assign the names of each feature to a column

```r
features <- features[,2] #Transform the data frame in a factor vector
for (i in 1:length(features)){ #Loop for all the variables names on features
        oldname <- paste("V",i,sep="") #Create oldname pasting V with i
        newname <- as.character(features[i]) #Create newname transforming features in character
        names(set)[names(set)==oldname]<-newname #Replacing oldname with newname
}
```
Combine the subjects

```r
subject <- rbind(subjectTrain,subjectTest)
names(subject)<-"subject"
```
Combine the activities

```r
activity <- rbind(activityTrain,activityTest)
```
Assign to each activity a descriptive character label

```r
act_labels[,2] <- gsub("_","",tolower(as.character(act_labels[,2])))
activity[,1]<- act_labels[activity[,1],2]
names(activity)<-"activity"
```
Combine all in one data set

```r
unifiedset <- cbind(subject,activity,set)
unifiedset <-tbl_df(unifiedset) #For better reading and printing
```

This last data set is the answer of assignment part 1 and part 3


To subset the data so only the mean() and std() are shown, I will use the grep function and the use of regular expressions


```r
featureswanted <- grep("-mean\\(\\)|-std\\(\\)",features)+2 
```
I added 2 because of the order of my variables on the unified set

```r
unifiedset<-unifiedset[,c(1:2,featureswanted)]
options(width = 110)
unifiedset
```

```
## Source: local data frame [10,299 x 68]
## 
##    subject activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y
##      (int)    (chr)             (dbl)             (dbl)             (dbl)            (dbl)            (dbl)
## 1        1 standing         0.2885845      -0.020294171        -0.1329051       -0.9952786       -0.9831106
## 2        1 standing         0.2784188      -0.016410568        -0.1235202       -0.9982453       -0.9753002
## 3        1 standing         0.2796531      -0.019467156        -0.1134617       -0.9953796       -0.9671870
## 4        1 standing         0.2791739      -0.026200646        -0.1232826       -0.9960915       -0.9834027
## 5        1 standing         0.2766288      -0.016569655        -0.1153619       -0.9981386       -0.9808173
## 6        1 standing         0.2771988      -0.010097850        -0.1051373       -0.9973350       -0.9904868
## 7        1 standing         0.2794539      -0.019640776        -0.1100221       -0.9969210       -0.9671859
## 8        1 standing         0.2774325      -0.030488303        -0.1253604       -0.9965593       -0.9667284
## 9        1 standing         0.2772934      -0.021750698        -0.1207508       -0.9973285       -0.9612453
## 10       1 standing         0.2805857      -0.009960298        -0.1060652       -0.9948034       -0.9727584
## ..     ...      ...               ...               ...               ...              ...              ...
## Variables not shown: tBodyAcc-std()-Z (dbl), tGravityAcc-mean()-X (dbl), tGravityAcc-mean()-Y (dbl),
##   tGravityAcc-mean()-Z (dbl), tGravityAcc-std()-X (dbl), tGravityAcc-std()-Y (dbl), tGravityAcc-std()-Z
##   (dbl), tBodyAccJerk-mean()-X (dbl), tBodyAccJerk-mean()-Y (dbl), tBodyAccJerk-mean()-Z (dbl),
##   tBodyAccJerk-std()-X (dbl), tBodyAccJerk-std()-Y (dbl), tBodyAccJerk-std()-Z (dbl), tBodyGyro-mean()-X
##   (dbl), tBodyGyro-mean()-Y (dbl), tBodyGyro-mean()-Z (dbl), tBodyGyro-std()-X (dbl), tBodyGyro-std()-Y
##   (dbl), tBodyGyro-std()-Z (dbl), tBodyGyroJerk-mean()-X (dbl), tBodyGyroJerk-mean()-Y (dbl),
##   tBodyGyroJerk-mean()-Z (dbl), tBodyGyroJerk-std()-X (dbl), tBodyGyroJerk-std()-Y (dbl),
##   tBodyGyroJerk-std()-Z (dbl), tBodyAccMag-mean() (dbl), tBodyAccMag-std() (dbl), tGravityAccMag-mean()
##   (dbl), tGravityAccMag-std() (dbl), tBodyAccJerkMag-mean() (dbl), tBodyAccJerkMag-std() (dbl),
##   tBodyGyroMag-mean() (dbl), tBodyGyroMag-std() (dbl), tBodyGyroJerkMag-mean() (dbl), tBodyGyroJerkMag-std()
##   (dbl), fBodyAcc-mean()-X (dbl), fBodyAcc-mean()-Y (dbl), fBodyAcc-mean()-Z (dbl), fBodyAcc-std()-X (dbl),
##   fBodyAcc-std()-Y (dbl), fBodyAcc-std()-Z (dbl), fBodyAccJerk-mean()-X (dbl), fBodyAccJerk-mean()-Y (dbl),
##   fBodyAccJerk-mean()-Z (dbl), fBodyAccJerk-std()-X (dbl), fBodyAccJerk-std()-Y (dbl), fBodyAccJerk-std()-Z
##   (dbl), fBodyGyro-mean()-X (dbl), fBodyGyro-mean()-Y (dbl), fBodyGyro-mean()-Z (dbl), fBodyGyro-std()-X
##   (dbl), fBodyGyro-std()-Y (dbl), fBodyGyro-std()-Z (dbl), fBodyAccMag-mean() (dbl), fBodyAccMag-std() (dbl),
##   fBodyBodyAccJerkMag-mean() (dbl), fBodyBodyAccJerkMag-std() (dbl), fBodyBodyGyroMag-mean() (dbl),
##   fBodyBodyGyroMag-std() (dbl), fBodyBodyGyroJerkMag-mean() (dbl), fBodyBodyGyroJerkMag-std() (dbl)
```
We subset the data selecting the first (subject) and second (activity) column with the features wanted. This data set is the answer of part 2

To appropriately label the data set with descriptive variables names, I will change the names of the unified set using the function gsub and regular expressions. I will eliminate the parenthesis on the mean() and std(), relabel t as time, Acc as Acceleration, Mag as Magnitude, f as frequency, BodyBody as Body, and std as standard-deviation. The reasoning behind the last substitution is that std is not very descriptive and accepts many interpretations.


```r
descriptivenames<- names(unifiedset)
descriptivenames <- gsub("\\(\\)","",descriptivenames)
descriptivenames <- gsub("^t","time",descriptivenames)
descriptivenames <- gsub("Acc","Acceleration",descriptivenames)
descriptivenames <- gsub("Mag","Magnitude",descriptivenames)
descriptivenames <- gsub("^f","frequency",descriptivenames)
descriptivenames <- gsub("BodyBody","Body", descriptivenames)
descriptivenames <- gsub("std","standard-deviation",descriptivenames)
names(unifiedset) <- descriptivenames
names(unifiedset)
```

```
##  [1] "subject"                                                  
##  [2] "activity"                                                 
##  [3] "timeBodyAcceleration-mean-X"                              
##  [4] "timeBodyAcceleration-mean-Y"                              
##  [5] "timeBodyAcceleration-mean-Z"                              
##  [6] "timeBodyAcceleration-standard-deviation-X"                
##  [7] "timeBodyAcceleration-standard-deviation-Y"                
##  [8] "timeBodyAcceleration-standard-deviation-Z"                
##  [9] "timeGravityAcceleration-mean-X"                           
## [10] "timeGravityAcceleration-mean-Y"                           
## [11] "timeGravityAcceleration-mean-Z"                           
## [12] "timeGravityAcceleration-standard-deviation-X"             
## [13] "timeGravityAcceleration-standard-deviation-Y"             
## [14] "timeGravityAcceleration-standard-deviation-Z"             
## [15] "timeBodyAccelerationJerk-mean-X"                          
## [16] "timeBodyAccelerationJerk-mean-Y"                          
## [17] "timeBodyAccelerationJerk-mean-Z"                          
## [18] "timeBodyAccelerationJerk-standard-deviation-X"            
## [19] "timeBodyAccelerationJerk-standard-deviation-Y"            
## [20] "timeBodyAccelerationJerk-standard-deviation-Z"            
## [21] "timeBodyGyro-mean-X"                                      
## [22] "timeBodyGyro-mean-Y"                                      
## [23] "timeBodyGyro-mean-Z"                                      
## [24] "timeBodyGyro-standard-deviation-X"                        
## [25] "timeBodyGyro-standard-deviation-Y"                        
## [26] "timeBodyGyro-standard-deviation-Z"                        
## [27] "timeBodyGyroJerk-mean-X"                                  
## [28] "timeBodyGyroJerk-mean-Y"                                  
## [29] "timeBodyGyroJerk-mean-Z"                                  
## [30] "timeBodyGyroJerk-standard-deviation-X"                    
## [31] "timeBodyGyroJerk-standard-deviation-Y"                    
## [32] "timeBodyGyroJerk-standard-deviation-Z"                    
## [33] "timeBodyAccelerationMagnitude-mean"                       
## [34] "timeBodyAccelerationMagnitude-standard-deviation"         
## [35] "timeGravityAccelerationMagnitude-mean"                    
## [36] "timeGravityAccelerationMagnitude-standard-deviation"      
## [37] "timeBodyAccelerationJerkMagnitude-mean"                   
## [38] "timeBodyAccelerationJerkMagnitude-standard-deviation"     
## [39] "timeBodyGyroMagnitude-mean"                               
## [40] "timeBodyGyroMagnitude-standard-deviation"                 
## [41] "timeBodyGyroJerkMagnitude-mean"                           
## [42] "timeBodyGyroJerkMagnitude-standard-deviation"             
## [43] "frequencyBodyAcceleration-mean-X"                         
## [44] "frequencyBodyAcceleration-mean-Y"                         
## [45] "frequencyBodyAcceleration-mean-Z"                         
## [46] "frequencyBodyAcceleration-standard-deviation-X"           
## [47] "frequencyBodyAcceleration-standard-deviation-Y"           
## [48] "frequencyBodyAcceleration-standard-deviation-Z"           
## [49] "frequencyBodyAccelerationJerk-mean-X"                     
## [50] "frequencyBodyAccelerationJerk-mean-Y"                     
## [51] "frequencyBodyAccelerationJerk-mean-Z"                     
## [52] "frequencyBodyAccelerationJerk-standard-deviation-X"       
## [53] "frequencyBodyAccelerationJerk-standard-deviation-Y"       
## [54] "frequencyBodyAccelerationJerk-standard-deviation-Z"       
## [55] "frequencyBodyGyro-mean-X"                                 
## [56] "frequencyBodyGyro-mean-Y"                                 
## [57] "frequencyBodyGyro-mean-Z"                                 
## [58] "frequencyBodyGyro-standard-deviation-X"                   
## [59] "frequencyBodyGyro-standard-deviation-Y"                   
## [60] "frequencyBodyGyro-standard-deviation-Z"                   
## [61] "frequencyBodyAccelerationMagnitude-mean"                  
## [62] "frequencyBodyAccelerationMagnitude-standard-deviation"    
## [63] "frequencyBodyAccelerationJerkMagnitude-mean"              
## [64] "frequencyBodyAccelerationJerkMagnitude-standard-deviation"
## [65] "frequencyBodyGyroMagnitude-mean"                          
## [66] "frequencyBodyGyroMagnitude-standard-deviation"            
## [67] "frequencyBodyGyroJerkMagnitude-mean"                      
## [68] "frequencyBodyGyroJerkMagnitude-standard-deviation"
```

This last data set is the answer of part 4

For the last part we will create a new tidy data set with the average of each variable for each activity and each subject. The three main properties of tidy data are, according to Hadley Wickham,: 1) Each variable forms a column, 2) Each observation forms a row and 3) Each type of observational unit forms a table. The third property is a given, and we will group and summarize the unified data to form a tidy data set


```r
tidydata <-unifiedset %>% group_by(subject,activity) %>% summarise_each(funs(mean))
write.table(tidydata,"tidydata.txt")
options(width = 110)
tidydata
```

```
## Source: local data frame [180 x 68]
## Groups: subject [?]
## 
##    subject          activity timeBodyAcceleration-mean-X timeBodyAcceleration-mean-Y
##      (int)             (chr)                       (dbl)                       (dbl)
## 1        1            laying                   0.2215982                -0.040513953
## 2        1           sitting                   0.2612376                -0.001308288
## 3        1          standing                   0.2789176                -0.016137590
## 4        1           walking                   0.2773308                -0.017383819
## 5        1 walkingdownstairs                   0.2891883                -0.009918505
## 6        1   walkingupstairs                   0.2554617                -0.023953149
## 7        2            laying                   0.2813734                -0.018158740
## 8        2           sitting                   0.2770874                -0.015687994
## 9        2          standing                   0.2779115                -0.018420827
## 10       2           walking                   0.2764266                -0.018594920
## ..     ...               ...                         ...                         ...
## Variables not shown: timeBodyAcceleration-mean-Z (dbl), timeBodyAcceleration-standard-deviation-X (dbl),
##   timeBodyAcceleration-standard-deviation-Y (dbl), timeBodyAcceleration-standard-deviation-Z (dbl),
##   timeGravityAcceleration-mean-X (dbl), timeGravityAcceleration-mean-Y (dbl), timeGravityAcceleration-mean-Z
##   (dbl), timeGravityAcceleration-standard-deviation-X (dbl), timeGravityAcceleration-standard-deviation-Y
##   (dbl), timeGravityAcceleration-standard-deviation-Z (dbl), timeBodyAccelerationJerk-mean-X (dbl),
##   timeBodyAccelerationJerk-mean-Y (dbl), timeBodyAccelerationJerk-mean-Z (dbl),
##   timeBodyAccelerationJerk-standard-deviation-X (dbl), timeBodyAccelerationJerk-standard-deviation-Y (dbl),
##   timeBodyAccelerationJerk-standard-deviation-Z (dbl), timeBodyGyro-mean-X (dbl), timeBodyGyro-mean-Y (dbl),
##   timeBodyGyro-mean-Z (dbl), timeBodyGyro-standard-deviation-X (dbl), timeBodyGyro-standard-deviation-Y
##   (dbl), timeBodyGyro-standard-deviation-Z (dbl), timeBodyGyroJerk-mean-X (dbl), timeBodyGyroJerk-mean-Y
##   (dbl), timeBodyGyroJerk-mean-Z (dbl), timeBodyGyroJerk-standard-deviation-X (dbl),
##   timeBodyGyroJerk-standard-deviation-Y (dbl), timeBodyGyroJerk-standard-deviation-Z (dbl),
##   timeBodyAccelerationMagnitude-mean (dbl), timeBodyAccelerationMagnitude-standard-deviation (dbl),
##   timeGravityAccelerationMagnitude-mean (dbl), timeGravityAccelerationMagnitude-standard-deviation (dbl),
##   timeBodyAccelerationJerkMagnitude-mean (dbl), timeBodyAccelerationJerkMagnitude-standard-deviation (dbl),
##   timeBodyGyroMagnitude-mean (dbl), timeBodyGyroMagnitude-standard-deviation (dbl),
##   timeBodyGyroJerkMagnitude-mean (dbl), timeBodyGyroJerkMagnitude-standard-deviation (dbl),
##   frequencyBodyAcceleration-mean-X (dbl), frequencyBodyAcceleration-mean-Y (dbl),
##   frequencyBodyAcceleration-mean-Z (dbl), frequencyBodyAcceleration-standard-deviation-X (dbl),
##   frequencyBodyAcceleration-standard-deviation-Y (dbl), frequencyBodyAcceleration-standard-deviation-Z (dbl),
##   frequencyBodyAccelerationJerk-mean-X (dbl), frequencyBodyAccelerationJerk-mean-Y (dbl),
##   frequencyBodyAccelerationJerk-mean-Z (dbl), frequencyBodyAccelerationJerk-standard-deviation-X (dbl),
##   frequencyBodyAccelerationJerk-standard-deviation-Y (dbl),
##   frequencyBodyAccelerationJerk-standard-deviation-Z (dbl), frequencyBodyGyro-mean-X (dbl),
##   frequencyBodyGyro-mean-Y (dbl), frequencyBodyGyro-mean-Z (dbl), frequencyBodyGyro-standard-deviation-X
##   (dbl), frequencyBodyGyro-standard-deviation-Y (dbl), frequencyBodyGyro-standard-deviation-Z (dbl),
##   frequencyBodyAccelerationMagnitude-mean (dbl), frequencyBodyAccelerationMagnitude-standard-deviation (dbl),
##   frequencyBodyAccelerationJerkMagnitude-mean (dbl),
##   frequencyBodyAccelerationJerkMagnitude-standard-deviation (dbl), frequencyBodyGyroMagnitude-mean (dbl),
##   frequencyBodyGyroMagnitude-standard-deviation (dbl), frequencyBodyGyroJerkMagnitude-mean (dbl),
##   frequencyBodyGyroJerkMagnitude-standard-deviation (dbl)
```



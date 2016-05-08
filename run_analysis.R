# The first step is to load the required libraries. I will be usisng dplyr and 
# reshape 2

library(dplyr)
library(reshape2)

# The second step is to create the directory where the data will be stored and 
# processed. We first do a verificaction to see if the directory exists. If not,
# create the directory. Then, we will download the file, if it doesn't exists. 
# In my Windows the way to create proper files is to set the download mode as "wb"

if(!file.exists("./data")){
        dir.create("./data")
}
if(!file.exists("./data/UCI.zip")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL,destfile = "./data/UCI.zip", mode = "wb")
}


# The third step is to unzip the file. First, we will do a verification to see if
# the file has already been unzipped. If not, unzipped.

if(!file.exists("UCI HAR Dataset")){
        unzip("data/UCI.zip",exdir = "./data")
}

# The fourth step is to look at all the files on the UCI folder. We will use the
# list.files funcion, with the recursive argument set as true. Then we will print
# on the console these files

pathfolder <- file.path("./data","UCI HAR Dataset")
txtfiles <- list.files(pathfolder,recursive = TRUE)

# After seeing all the files, and reading the README.txt of the data, we won't
# use the text files on the Inertial Signals Folder, because our interest is 
# on the results on the experiment, not the technical variables of the test.
# We will use the read.table and the text files list's results

# Read the subject files
subjectTrain<-read.table(file.path(pathfolder,txtfiles[26]))
subjectTest<-read.table(file.path(pathfolder,txtfiles[14]))
# Read the Activity files (named labes on the Readme.txt)
activityTrain <- read.table(file.path(pathfolder,txtfiles[28]))
activityTest <-read.table(file.path(pathfolder,txtfiles[16]))
# Read the data sets (features)
setTrain <- read.table(file.path(pathfolder,txtfiles[27]))
setTest <- read.table(file.path(pathfolder,txtfiles[15]))
# Read the features names
features <- read.table(file.path(pathfolder,txtfiles[2]))
# Read the activity labels names
act_labels <- read.table(file.path(pathfolder,txtfiles[1]))

# Now we will combine all the data. First we will merge both sets of features using
# rbind, because both are a set of observations. Then we will rbind the subjects
# and the activities. Finally, we will cbind the subjects, the features, and the
# activities

# Combine the features sets
set <- rbind(setTrain,setTest)
# Assign the names of each feature to a column
features <- features[,2] #Transform the data frame in a factor vector
for (i in 1:length(features)){ #Loop for all the variables names on features
        oldname <- paste("V",i,sep="") #Create oldname pasting V with i
        newname <- as.character(features[i]) #Create newname transforming features in character
        names(set)[names(set)==oldname]<-newname #Replacing oldname with newname
}
# Combine the subjects
subject <- rbind(subjectTrain,subjectTest)
names(subject)<-"subject"
# Combine the activities
activity <- rbind(activityTrain,activityTest)
# Assign to each activity a descriptive character label
act_labels[,2] <- gsub("_","",tolower(as.character(act_labels[,2])))
activity[,1]<- act_labels[activity[,1],2]
names(activity)<-"activity"
# Combine all in one data set
unifiedset <- cbind(subject,activity,set)
unifiedset <-tbl_df(unifiedset) #For better reading and printing
# This last data set is the answer of assignment part 1 and part 3

# To subset the data so only the mean() and std() are shown, I will use the
# grep function with the regular expression -mean\\(\\)|-std\\(\\)

featureswanted <- grep("-mean\\(\\)|-std\\(\\)",features)+2 
# I added 2 because of the order of my variables on the unified set
unifiedset<-unifiedset[,c(1:2,featureswanted)]
# We subset the data selecting the first (subject) and second (activity) column
# with the features wanted. This data set is the answer of part 2

# To appropriately label the data set with descriptive variables names, I will
# change the names of the unified set using the function gsub and regular expressions
# I will eliminate the parenthesis on the mean() and std(), relabel t as time, 
# Acc as Acceleration, Mag as Magnitude, f as frequency, BodyBody as Body, and
# std as standard-deviation. The reasoning behind the last substitution is that std
# is not very descriptive and accepts many interpretations.

descriptivenames<- names(unifiedset)
descriptivenames <- gsub("\\(\\)","",descriptivenames)
descriptivenames <- gsub("^t","time",descriptivenames)
descriptivenames <- gsub("Acc","Acceleration",descriptivenames)
descriptivenames <- gsub("Mag","Magnitude",descriptivenames)
descriptivenames <- gsub("^f","frequency",descriptivenames)
descriptivenames <- gsub("BodyBody","Body", descriptivenames)
descriptivenames <- gsub("std","standard-deviation",descriptivenames)
names(unifiedset) <- descriptivenames

# This last data set is the answer of part 4

# For the last part we will create a new tidy data set with the average of each
# variable for each activity and each subject. The three main properties of tidy 
# data are, according to Hadley Wickham,: 1) Each variable forms a column, 
# 2) Each observation forms a row and 3) Each type of observational unit forms a 
# table. The third property is a given, and we will group and summarize the unified
# data to form a tidy data set

tidydata <-unifiedset %>% group_by(subject,activity) %>% summarise_each(funs(mean))
write.table(tidydata,"tidydata.txt")

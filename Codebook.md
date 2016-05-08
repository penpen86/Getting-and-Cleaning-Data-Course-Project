---
title: "CodeBook"
author: "Vinicio De Sola"
date: "May 8, 2016"
output: html_document
---



# Original Data Set Information

[Source](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS\, WALKING\_DOWNSTAIRS\, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

The original data, once merged, has 561 variables (named features on the original data), and 10299 observations (rows). The Study Design was described before.

# Code Book

Once processed, the tidy data has 66 variables (measurements), and two factors (subject and activity). It's aggregated by the mean in 180 observations and grouped by subject and activity. 

The data is alphabetically sorted by the activity factor. The units of the measurements are not specified on the original data set, but the dimensions should be lenght/time² (acceleration units). 

The data is tidy because we have one column per variable measured, and one observation for each variable in a different row. I use a wide tidy set


|**Variable Name** |               **Description**                           |
|------------------------------|-----------------------------------------|
|subject | ID of the subject who performs every activity. Ranges from 1 to 30|
|activity | Activity name (laying, sitting, standing, walking, walkingdownstairs, walkingupstairs)|
|timeBodyAcceleration-mean-X  | Mean of the measurement (numeric value)|                            
|timeBodyAcceleration-mean-Y  | Mean of the measurement (numeric value)|                            
|timeBodyAcceleration-mean-Z | Mean of the measurement (numeric value)|                             
|timeBodyAcceleration-standard-deviation-X  | Mean of the measurement (numeric value)|              
timeBodyAcceleration-standard-deviation-Y | Mean of the measurement (numeric value)               
timeBodyAcceleration-standard-deviation-Z  | Mean of the measurement (numeric value)              
timeGravityAcceleration-mean-X  | Mean of the measurement (numeric value)                         
timeGravityAcceleration-mean-Y | Mean of the measurement (numeric value)                          
timeGravityAcceleration-mean-Z | Mean of the measurement (numeric value)                          
timeGravityAcceleration-standard-deviation-X | Mean of the measurement (numeric value)            
timeGravityAcceleration-standard-deviation-Y | Mean of the measurement (numeric value)            
timeGravityAcceleration-standard-deviation-Z | Mean of the measurement (numeric value)            
timeBodyAccelerationJerk-mean-X | Mean of the measurement (numeric value)                         
timeBodyAccelerationJerk-mean-Y | Mean of the measurement (numeric value)                         
timeBodyAccelerationJerk-mean-Z | Mean of the measurement (numeric value)                         
timeBodyAccelerationJerk-standard-deviation-X | Mean of the measurement (numeric value)           
timeBodyAccelerationJerk-standard-deviation-Y | Mean of the measurement (numeric value)           
timeBodyAccelerationJerk-standard-deviation-Z | Mean of the measurement (numeric value)           
timeBodyGyro-mean-X | Mean of the measurement (numeric value)                                     
timeBodyGyro-mean-Y | Mean of the measurement (numeric value)                                     
timeBodyGyro-mean-Z | Mean of the measurement (numeric value)                                     
timeBodyGyro-standard-deviation-X | Mean of the measurement (numeric value)                       
timeBodyGyro-standard-deviation-Y | Mean of the measurement (numeric value)                       
timeBodyGyro-standard-deviation-Z | Mean of the measurement (numeric value)                       
timeBodyGyroJerk-mean-X | Mean of the measurement (numeric value)                                 
timeBodyGyroJerk-mean-Y | Mean of the measurement (numeric value)                                 
timeBodyGyroJerk-mean-Z  | Mean of the measurement (numeric value)                                
timeBodyGyroJerk-standard-deviation-X | Mean of the measurement (numeric value)                   
timeBodyGyroJerk-standard-deviation-Y | Mean of the measurement (numeric value)                   
timeBodyGyroJerk-standard-deviation-Z | Mean of the measurement (numeric value)                   
timeBodyAccelerationMagnitude-mean | Mean of the measurement (numeric value)                      
timeBodyAccelerationMagnitude-standard-deviation | Mean of the measurement (numeric value)        
timeGravityAccelerationMagnitude-mean | Mean of the measurement (numeric value)                   
timeGravityAccelerationMagnitude-standard-deviation | Mean of the measurement (numeric value)     
timeBodyAccelerationJerkMagnitude-mean | Mean of the measurement (numeric value)                  
timeBodyAccelerationJerkMagnitude-standard-deviation | Mean of the measurement (numeric value)    
timeBodyGyroMagnitude-mean | Mean of the measurement (numeric value)                              
timeBodyGyroMagnitude-standard-deviation | Mean of the measurement (numeric value)                
timeBodyGyroJerkMagnitude-mean | Mean of the measurement (numeric value)                          
timeBodyGyroJerkMagnitude-standard-deviation | Mean of the measurement (numeric value)            
frequencyBodyAcceleration-mean-X | Mean of the measurement (numeric value)                        
frequencyBodyAcceleration-mean-Y | Mean of the measurement (numeric value)                        
frequencyBodyAcceleration-mean-Z | Mean of the measurement (numeric value)                        
frequencyBodyAcceleration-standard-deviation-X | Mean of the measurement (numeric value)          
frequencyBodyAcceleration-standard-deviation-Y | Mean of the measurement (numeric value)          
frequencyBodyAcceleration-standard-deviation-Z | Mean of the measurement (numeric value)          
frequencyBodyAccelerationJerk-mean-X | Mean of the measurement (numeric value)                    
frequencyBodyAccelerationJerk-mean-Y | Mean of the measurement (numeric value)                    
frequencyBodyAccelerationJerk-mean-Z | Mean of the measurement (numeric value)                    
frequencyBodyAccelerationJerk-standard-deviation-X | Mean of the measurement (numeric value)      
frequencyBodyAccelerationJerk-standard-deviation-Y | Mean of the measurement (numeric value)      
frequencyBodyAccelerationJerk-standard-deviation-Z | Mean of the measurement (numeric value)      
frequencyBodyGyro-mean-X | Mean of the measurement (numeric value)                                
frequencyBodyGyro-mean-Y | Mean of the measurement (numeric value)                               
frequencyBodyGyro-mean-Z  | Mean of the measurement (numeric value)                               
frequencyBodyGyro-standard-deviation-X  | Mean of the measurement (numeric value)                 
frequencyBodyGyro-standard-deviation-Y  | Mean of the measurement (numeric value)                 
frequencyBodyGyro-standard-deviation-Z  | Mean of the measurement (numeric value)                 
frequencyBodyAccelerationMagnitude-mean  | Mean of the measurement (numeric value)                
frequencyBodyAccelerationMagnitude-standard-deviation | Mean of the measurement (numeric value)   
frequencyBodyAccelerationJerkMagnitude-mean | Mean of the measurement (numeric value)             
frequencyBodyAccelerationJerkMagnitude-standard-deviation | Mean of the measurement (numeric value)
frequencyBodyGyroMagnitude-mean | Mean of the measurement (numeric value)                         
frequencyBodyGyroMagnitude-standard-deviation | Mean of the measurement (numeric value)           
frequencyBodyGyroJerkMagnitude-mean | Mean of the measurement (numeric value)                     
frequencyBodyGyroJerkMagnitude-standard-deviation | Mean of the measurement (numeric value)

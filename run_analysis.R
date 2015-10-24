#########################################################################################################
# Getting and Cleaning Data - Project.
# This script satisfies requirements 1-5 of the project and prints the final data set
#########################################################################################################

#clear vars to start fresh
rm(list = ls())

#########################################################################################################
#Load the x, y (as descriptive labels) and subject datasets into a single dataframe and return it.
#params:
# dataType - either "train" or "test"
#return:
# the single dataframe with all the relevant data for the assignment
loadAndProcessDataSet <- function(dataType) {
    
    #build filepaths and load the dataset
    dataDirectory <- "UCI HAR Dataset/"
    xPath <- paste(dataDirectory, dataType, "/X_", dataType, ".txt", sep= "")
    yPath <- paste(dataDirectory, dataType, "/y_", dataType, ".txt", sep= "")
    subjectPath <- paste(dataDirectory, dataType, "/subject_", dataType, ".txt", sep= "")
    
    xFrame <- read.table(xPath)
    yFrame <- read.table(yPath)
    subjectFrame <- read.table(subjectPath)
    
    
    #load feature names and apply as column names to x frame
    featuresPath <- "UCI HAR Dataset/features.txt"
    featuresFrame <- read.table(featuresPath)
    featureNames <- featuresFrame[,2]
    colnames(xFrame) <- featureNames
    
    #Select only columns that represent the mean and standard deviation measurements.
    #Sort in order to select the columns in the order they appear in the data
    desiredFeatureIndices <- sort(c(grep("-std\\(\\)", featureNames), grep("-mean\\(\\)", featureNames)))
    xFrame <- xFrame[,desiredFeatureIndices]
    
    #load description of activity labels
    labelsPath <- "UCI HAR Dataset/activity_labels.txt"
    labelsFrame <- read.table(labelsPath)
    
    #combine descriptive activity labels (from yFrame) with xFrame
    xFrame$ActivityLabel <- factor(yFrame[,1], labels = labelsFrame[,2])
    #combine subject into xFrame
    xFrame$Subject <- subjectFrame[,1]
    
    return(xFrame)
}

#load training and test data and combine into single data frame with 
trainingData <- loadAndProcessDataSet("train")
testData <- loadAndProcessDataSet("test")
combinedData = rbind(trainingData, testData)

#split the dataset by the activity label, and by the subject. Calculate means and combine into one dataframe
splitActivity <- split(combinedData[,1:66], combinedData$ActivityLabel)
splitSubject <- split(combinedData[,1:66], combinedData$Subject)
#calculate means for splits
activityMeans <- as.data.frame(sapply(splitActivity, colMeans))
subjectMeans <- as.data.frame(sapply(splitSubject, colMeans))

#rename the columns to make them more descriptive
colnames(activityMeans) <- paste("Label:", colnames(activityMeans))
colnames(subjectMeans) <- paste("Subject:", colnames(subjectMeans))

#combine means calculated using the two splits
tidyData <- cbind(activityMeans, subjectMeans)

print(tidyData)




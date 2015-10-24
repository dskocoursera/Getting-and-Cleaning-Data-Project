# Getting-and-Cleaning-Data-Project
Project for the "Getting and Cleaning Data" coursera course.


## Instructions

The script run_analysis.R is designed to be run with the working directory set as the directory that contains the dataset directory ("UCI HAR Dataset").

## Explanation

I created the function "loadAndProcessDataSet" which loads the data from either the training or testing set and carries out the project steps 2 to 4. Once the function is run for both sets, the dataframes are simply bound by rows.
The final processing for step 5 is achieved via split and sapply, with some column renaming for clarity, and finally a column bind of the dataframes.

## Output

Finally, the processed dataset of step 5 is output to the console. That is: "the average of each variable for each activity and each subject". Columns specify the groupings (either an activity label or a subject number) and rows represent the measurement variable that the mean was calculated over. This can easily be reversed with t().

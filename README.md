# GettingAndCleaningProject
This is the Getting a Cleaning in R Final Project.  This was a submission done by Andrew Reed.  Instructions are below.

Dataset can be found below.
https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones

Files
CodeBook.md describes the process of the model and how the data was tranformed and cleaned.

run_analysis.R is the code that runs the transformations.  
> First, Training and test datasets are combined and merged into one dataset.

> Second, the mean and standard devaiations for each value was extracted.

> Third, takes the more descriptive activity names and labels them under the code column.

> Fourth, uses the more descriptive names and approprately applies each label to each variable.

> Finally, creates a new tidy dataset and gives the mean of the variable for each renamed activity.

TidyData.txt is the final results fo the data after run_analysis.

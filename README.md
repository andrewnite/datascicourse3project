Getting and Cleaning Data - Course Project- Andrew Smith
=======

This repository contains information on Andrew Smith's submission for the Data Science track Course 3 project.

The file in the repository named run_analysis.R contains the script which reads the test/train data and formats it into a clean set of data.

These are the steps which are performed in the run_analysis.R script in order to create the cleaned dataset.

<ul>
<li>Install and reference the 'dplyr' CRAN package used later in the script for summarising data</li>
<li>Read in the 'X_test', 'y_test' and 'subject_test' datasets and assign to variables</li>
<li>Read in the 'X_train', 'y_train' and 'subject_train' datasets and assign to variables</li>
<li>Read in the generic data text files which contain the data regarding activity and feature labels.  Name the columns of the activity labels data - required to easily merge with the final dataset at a label point.</li>
<li>Combine the columns of the subject, activity and 'metric readings' for both the test and train folders using cbind</li>
<li>Combine the 'Test' and 'Train' datasets by union using the rbind (row bind) command</li>
<li>The combined dataset currently has no column names - the column names need to be programmatically set.  SubjectId and ActivityId are set manually.  To set the remaining columns the 'feature' (from 'features.txt') dataset was used to get a list of all of the names for these columns.  Use the 'colnames' R function to set the column names of the combined dataset.</li>
<li></li>

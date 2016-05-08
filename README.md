


# Getting and Cleaning Data - Course Project

This is the repository for the Getting and Cleaning Data Course Project for Johns Hopkins University, imparted on Coursera.

# Raw Data

The data used was recollected by the Univesitat Politecnica de Catalunya and was obtained via the [UCI Website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Source of the data <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

# R Code and Script walkthrough

In the [run_analysis.R](https://github.com/penpen86/Getting-and-Cleaning-Data-Course-Project/blob/master/run_analysis.R) is the R code used to read, merge, process, and tidy the data. In the [Script_Walkthrough.md](https://github.com/penpen86/Getting-and-Cleaning-Data-Course-Project/blob/master/Script_Walkthrough.md) is a detailed walkthrough of the R code, with some middle results and a preview of the merged data and the tidy data. The prerequisites need it for running the R code are the installation of the dplyr and reshape2 packages.

The result of this script is a [tidy data set](https://github.com/penpen86/Getting-and-Cleaning-Data-Course-Project/blob/master/tidydata.txt). The problem in which we are going to use this data is not specified, so using the assumption that each variable is an independent measurements and [Hadley's paper](http://vita.had.co.nz/papers/tidy-data.pdf) we produce a tidy data set with each variable as a column in a wide format.

# CodeBook

In [Codebook.md](https://github.com/penpen86/Getting-and-Cleaning-Data-Course-Project/blob/master/Codebook.md) is a brief description of the original data (for an expansive description go to the [README](https://github.com/penpen86/Getting-and-Cleaning-Data-Course-Project/tree/master/UCI-HAR-Dataset) file of the original source) and the Code Book of the tidy data.

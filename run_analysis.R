library(tidyr)
library(reshape2)
library(beepr)
# run_analysis.R

# Download the dataset from the internet
rawDir <- "./rawData"
rawUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
rawFile <- "rawData.zip"
rawDF <- paste(rawDir, "/", rawFile, sep = "")
dataDir <- "./rawData/rawData"

# Checks if the directory already exists, else it is created
if (!file.exists(rawDir)) {
  dir.create(rawDir)
  download.file(url = rawUrl, destfile = rawDF)
}
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(zipfile = rawDF, exdir = dataDir)
}

# merging {train, test} data set by row
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# train 
xtrain <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/X_train.txt"))
ytrain <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/Y_train.txt"))
strain <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/subject_train.txt"))

# test 
xtest <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/X_test.txt"))
ytest <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/Y_test.txt"))
stest <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/subject_test.txt"))
beep(sound=2)
# merge data
xdata <- xtrain %>%
          rbind(xtest)
ydata <- ytrain %>%
          rbind(ytest)
sdata <- strain %>%
          rbind(stest)
beep(sound=2)

## get info
# feature info
feat <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))

# activity labels
actLabel <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
actLabel[,2] <- as.character(actLabel[,2])

# extract feature cols & names named 'mean, std'
selectedCols <- grep("-(mean|std).*", as.character(feat[,2]))
selectedColNames <- feat[selectedCols, 2]
#remove the "-"s and join the word "mean" or "std" to the last one
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)


# extract data by cols & using descriptive name
xdata <- xdata[selectedCols]
allData <- cbind(sdata, ydata, xdata)
colnames(allData) <- c("Person", "Activity", selectedColNames)

allData$Activity <- factor(allData$Activity, levels = actLabel[,1], labels = actLabel[,2])
allData$Subject <- as.factor(allData$Person)


#5. generate tidy data set
meltedData <- allData %>%
                melt(id = c("Subject", "Activity"))
tidyData <- meltedData %>%
              dcast(Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidyDataset.txt", row.names = FALSE, quote = FALSE)
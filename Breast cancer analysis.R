# Breast Cancer Prediction using k-Nearest Neighbors (Hybrid Version)
# Author: Ayomide Ibikunle
# Dataset: Wisconsin Breast Cancer Data

# ---------------------------
# Load Libraries
# ---------------------------
library(ggplot2)
library(dplyr)
library(class)
library(gmodels)
library(randomForest)
# ---------------------------
# Step 1: Load and Prepare Data
# ---------------------------
# Import dataset
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)

#Examine the structure of the dataset
str(wbcd)

# Drop ID column
wbcd <- wbcd[-1]

# table of diagnosis
table(wbcd$diagnosis)

# Convert diagnosis to factor with labels
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant"))

# table or proportions with more informative labels
round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)

# ---------------------------
# Step 2: Exploratory Data Analysis
# ---------------------------

# Diagnosis distribution
ggplot(wbcd, aes(x = diagnosis, fill = diagnosis)) +
  geom_bar(width = 0.6) +
  theme_minimal() +
  labs(title = "Diagnosis Distribution", x = "Diagnosis", y = "Count")

# Histogram of radius_mean by diagnosis
ggplot(wbcd, aes(x = radius_mean, fill = diagnosis)) +
  geom_histogram(bins = 30, alpha = 0.6, position = "identity") +
  theme_minimal() +
  labs(title = "Radius Mean Distribution by Diagnosis")

# Summary of selected features
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

# Normalize the Data
# Min-max normalization function
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
# test normalization function - result should be identical
normalize(c(1, 2, 3, 4, 5))
normalize(c(10, 20, 30, 40, 50))

# Apply normalization to features (excluding diagnosis)
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

#Check normalization result
summary(wbcd_n$area_mean)

# ---------------------------
# Step 3: Train-Test Split
# ---------------------------

# Manual split (first 469 rows for train, remaining 100 for test)
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]
head(wbcd_n,5)
head(wbcd_train_labels,5)

# Corresponding labels
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

#To use knn() function to classify the test data
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)


# ---------------------------
# Step 4:Evaluate Model Performance
# ---------------------------

# Create the cross tabulation of predicted vs. actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = FALSE)

# ---------------------------
# Step 5: Improving model performance 
# ---------------------------
# use the scale() function to z-score standardize a data frame
wbcd_z <- as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)


# re-classify test cases
wbcd_train <- wbcd_z[1:469, ]
wbcd_test <- wbcd_z[470:569, ]
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]


wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)


# Create the cross tabulation of predicted vs. actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = FALSE)

# Try multiple k values
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=1)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=5)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=11)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=15)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=21)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=27)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)




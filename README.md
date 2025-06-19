## Breast Cancer Classification using k-NN Algorithm
This R project classifies breast tumors as **Benign** or **Malignant** using the **k-Nearest Neighbors (kNN)** algorithm based on the Wisconsin Breast Cancer Dataset, with `ggplot2` used for data visualization and base R functions for data processing and model evaluation.

## Dataset Overview
**Observations:** 569 biopsy records each with 32 features

**Features:** One feature is an identification number, another is the cancer diagnosis and 30 are numeric-valued laboratory measurements.

**Target Variable:** diagnosis – labeled as either Benign or Malignant

**Class Imbalance:** ~63% Benign, ~37% Malignant

## Project Workflow
## Data Loading & Preprocessing
• Imported the dataset using read.csv()
• Removed the non-informative id column
• Recoded the diagnosis column using factor()

## Exploratory Data Analysis
•Used base R functions (summary(), table(), prop.table()) to explore feature distributions and class proportions
• Visualized feature distributions with ggplot2 (e.g., radius_mean by diagnosis)
• Created a custom normalize() function to apply min-max scaling using lapply()
• Manually split the data into training (469 rows) and test (100 rows) sets

## Model Training 
• Applied the kNN algorithm using class::knn()

## Evaluating Model Preformance
• Evaluated predictions using gmodels::CrossTable() to assess classification performance.

## Improving Model Performance
• The standardized data was used to create new training and test sets.
• Performance did not improve compared to the original min-max normalized version.
• Accuracy remained slightly lower across multiple values of k. 
• Evaluation with CrossTable() showed that performance was comparable to or slightly better than the min-max normalized version.
• Tested multiple k values (1, 5, 11, 15, 21, 27) to compare performance

## Results Summary
• The accuracy was computed for each k to identify the best-performing model
• The highest accuracy (98%) was achieved with k = 21, while k = 5 also performed well at 97%.
• The model made 2 false negative predictions (malignant tumors predicted as benign), which is especially serious in medical diagnosis. This shows the importance of minimizing such errors in real-world health applications.

## Key Takeaways
• k-Nearest Neighbors (kNN) can be a highly effective model for medical classification tasks when properly preprocessed and tuned.
• Feature scaling significantly affects kNN performance. In this case, min-max normalization outperformed z-score standardization.
• Testing multiple k values helped identify the optimal configuration, with k = 21 achieving up to 98% accuracy.
• While accuracy was high, the presence of false negatives shows the need for caution, especially in sensitive applications like cancer detection.

## Recommendation
• Focus on reducing false negatives, as they are critical in medical diagnosis.
• Try other models like Logistic Regression or Random Forest for comparison.
• Use cross-validation and additional metrics like precision, recall, and F1 score for better evaluation.
• Handle class imbalance with techniques like SMOTE.
 







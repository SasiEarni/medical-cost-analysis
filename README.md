# medical-cost-analysis
Correlation-based statistical analysis exploring how health factors relate to medical insurance costs using hypothesis testing and visualisation.

Analysis Project of Medical Costs.
Project Overview:

This assignment will examine the variables affecting the medical insurance fees. The major research question is as follows: What factors are most related to insurance charges? The data used to analyze it is a set of demographic and medical data, such as age, BMI, sex, child number, region, and insurance fees.

Dataset:
The following fields are present in the dataset insurance.csv:
•	age: Age of the policyholder
•	sex (changed to gender): Gender of the policyholder (male/female)
•	bmi: Body Mass Index
•	children: Number of children covered by the insurance plan
•	smoker: Smoking status (yes/no)
•	region: Residential region
•	charges: Insurance charges (target variable)

The dataset did not detect any missing ones.

Project Steps:
1. Data Exploration
•	Learned about the structure of the dataset with the help of str and summary.
•	Missing values were checked with the help of is.na and colSums.
•	Confirmed that the dataset does not have missing values.

2. Outlier Detection & Handling
•	Determined outliers in bmi and charges through the use of boxplots (boxplot.stats()).
•	Added outliers flags (BMIoutlier and chargesoutlier).
•	Produced cleaned data sets in the absence of outliers on BMI (ds225nobmioutliers) and charges (ds225nochargesoutliers).
•	Comparison of summary statistics prior to and post-outlier removal.

3. Distribution Analysis
•	Plotted both bmi and charges histograms and density plots.
•	Normality tests, Shapiro-Wilk tests on bmi and charges.
•	Plotted the effect of the removal of outliers through boxplots.

4. Correlation Analysis
•	Translated categorical variables (smoker, gender, region) to numeric form in order to calculate correlations.
•	created a correlation table of numerical variables: age, bmi, children, smokernum, gendernum, regionnum, charges.

Key correlations computed:
•	BMI vs Charges
•	Age vs Charges
•	Smoker vs Charges
•	Children vs Charges

5. Hypothesis Testing
•	T-tests to compare insurance expenses were conducted:
•	Among smokers and non-smokers.
•	Across genders (male vs female).

6. Scatterplots
Plotted scatterplots for:
•	BMI vs Charges
•	Age vs Charges
•	Children vs Charges

Included regressive lines to graph trends.

7. Correlation Heatmap
Developed a heatmap of correlation coefficients of numeric variables to provide a visual summary of relationships.

8. Modeling
•	Simple Linear Regression: The modeled insurance charges were based on BMI.
•	Multiple Linear Regression: Modeled both insurance costs with age, BMI, smoking status, and children.
•	To establish the main predictors of insurance charges, model summaries and regression were created.

Key Findings:
•	The insurance charges are most correlated with smoking status.
•	Insurance charges also have a positive relationship with age and BMI.
•	Children's size is not as positively associated.
•	There is little association between gender and region, and charges.
The elimination of outliers will give a more desirable distribution and a stronger analysis.

Output Files:

•	BoxplotofchargesOutliers.png - Boxplot of charges before and after removing outliers.
•	Combinedvisualization.png - Histograms and density plots of Charges and BMI.
•	scatterbmicharges.png - BMI Versus Charges Scatterplot.
•	scatteragecharges.png -age vs charges scatterplot.
•	scatterchildrencharges.png - Scatter Plot of Children vs Charges.
•	heatmap data - Correlation heatmap data.

Tools and Libraries
•	R programming language
•	Base R is used in data analysis and data visualization.

Conclusion:
The analysis establishes the main factors that can affect the insurance premiums, but smoking condition, age, and BMI are the most important ones. Risk assessment, calculation of premiums, and customized health interventions can be carried out based on this insight.

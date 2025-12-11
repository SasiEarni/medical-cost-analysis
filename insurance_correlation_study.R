###############################################
# MEDICAL COST ANALYSIS PROJECT
# Research Question:
# Which factors are most strongly correlated with insurance charges?
###############################################

# Load dataset
ds225 <- read.csv("insurance.csv")

########################################################
# 1. DATA EXPLORATION
########################################################

# View structure
str(ds225)

# Summary statistics
summary(ds225)

#Checking total missing values
sum(is.na(ds225))

#Checking missing values per column
colSums(is.na(ds225))

########################################################
# 2. OUTLIER DETECTION & HANDLING
########################################################

# Detect outliers in BMI
BMI_outliers <- boxplot.stats(ds225$bmi)$out
BMI_outliers

# Detect outliers in charges
charges_outliers <- boxplot.stats(ds225$charges)$out
charges_outliers

# Boxplots
boxplot(ds225$bmi, main = "Boxplot of BMI", ylab = "BMI")
boxplot(ds225$charges, main = "Boxplot of Charges", ylab = "Charges")

# Add flag variables
ds225$BMI_outlier <- ds225$bmi %in% BMI_outliers
ds225$charges_outlier <- ds225$charges %in% charges_outliers

# Create cleaned datasets
ds225_no_bmi_out <- ds225[!ds225$bmi %in% BMI_outliers, ]
ds225_no_charge_out <- ds225[!ds225$charges %in% charges_outliers, ]

#Created new datasets without outliers
ds225_no_bmi_outliers <- ds225[!ds225$bmi %in% BMI_outliers, ]
ds225_no_charges_outliers <- ds225[!ds225$charges %in% charges_outliers, ]

#Summary before and after
summary(ds225$bmi)
summary(ds225$charges)
summary(ds225_no_charges_outliers$charges)

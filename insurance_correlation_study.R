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

########################################################
# 3. CORRELATION ANALYSIS
########################################################

# Convert categorical variables for correlation
ds225$smoker_num <- ifelse(ds225$smoker == "yes", 1, 0)
ds225$sex_num <- ifelse(ds225$sex == "male", 1, 0)
ds225$region_num <- as.numeric(as.factor(ds225$region))

# Select numeric columns only
numeric_ds225 <- ds225[, c("age", "bmi", "children", "smoker_num", "sex_num", "region_num", "charges")]

# Compute correlation matrix
cor_matrix <- cor(numeric_ds225)

# Display matrix
cor_matrix

########################################################
# 4. INDIVIDUAL CORRELATIONS
########################################################

# BMI vs charges
cor(ds225$bmi, ds225$charges)

# Age vs charges
cor(ds225$age, ds225$charges)

# Smoker vs charges (numeric)
cor(ds225$smoker_num, ds225$charges)

# Children vs charges
cor(ds225$children, ds225$charges)

########################################################
# 5. SCATTERPLOTS
########################################################

# BMI vs Charges
png("scatter_bmi_charges.png", width = 800, height = 500)
plot(ds225$bmi, ds225$charges,
     main = "Scatterplot: BMI vs Charges",
     xlab = "BMI",
     ylab = "Charges",
     pch = 19,
     col = "blue")
abline(lm(bmi ~ charges, data = ds225), col = "red", lwd = 2)
dev.off()

# Age vs Charges
png("scatter_age_charges.png", width = 800, height = 500)
plot(ds225$age, ds225$charges,
     main = "Scatterplot: Age vs Charges",
     xlab = "Age",
     ylab = "Charges",
     col = "green")
abline(lm(age ~ charges, data = ds225), col = "red", lwd = 2)
dev.off()

# Children vs Charges
png("scatter_children_charges.png", width = 800, height = 500 )
plot(ds225$children, ds225$charges,
     main = "Scatterplot: Children vs Charges",
     xlab = "Children",
     ylab = "Charges",
     col = "purple")
abline(lm(children ~ charges, data = ds225), col = "red", lwd = 2)
dev.off()


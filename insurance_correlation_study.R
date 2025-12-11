###############################################
# MEDICAL COST ANALYSIS PROJECT
# Research Question:
# Which factors are most strongly correlated with insurance charges?
###############################################

# Load dataset
ds225 <- read.csv("insurance.csv")

# Renaming column 'sex' to 'gender'
colnames(ds225)[2] <- "gender"

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
# 3. DISTRIBUTIONS (HISTOGRAMS + DENSITY + SHAPIRO)
########################################################

#Visual comparison of Box plots
png("Boxplot_of_charges_Outliers.png", width = 1920, height = 1080, res = 150)
par(mfrow=c(1,2))
boxplot(ds225$charges, main="Before Removing Outliers", ylab = "Charges")
boxplot(ds225_no_charges_outliers$charges, main="After Removing Outliers", ylab = "Charges")
dev.off()
#saving Boxplot_of_charges_Outliers.png

#Histograms for BMI, charges
hist(ds225$bmi,
     main = "Histogram of BMI",
     xlab = "BMI",
     col = "lightblue",
     border = "black")

#Histogram for Charges
hist(ds225$charges,
     main = "Histogram of Charges",
     xlab = "Charges",
     col = "lightgreen",
     border = "black")

#Denisity plot for BMI
plot(density(ds225$bmi),
     main = "Density Plot of BMI",
     xlab = "BMI",
     ylab = "Density")

#Density plot for Charges
plot(density(ds225$charges),
     main = "Density Plot of Charges",
     xlab = "Charges",
     ylab = "Density")


#Combined Visualization of Density and Histogram plots for BMI and Charges
png("Combined_visualization.png", width = 1920, height = 1080, res = 150)
par(mfrow = c(2,2))
hist(ds225$bmi, main = "Histogram of BMI", col = "lightblue", xlab = "BMI")
plot(density(ds225$bmi), main = "Density of BMI")

#charges
hist(ds225$charges, main = "Histogram of Charges", col = "lightgreen", xlab = "Charges")
plot(density(ds225$charges), main = "Density of Charges")
par(mfrow = c(1,1))
dev.off()
#saving Combined Visualization of Density and Histogram plots for BMI and Charges.png

#Shapiro test for BMI
shapiro.test(ds225$bmi)

#Shapiro test for Charges
shapiro.test(ds225$charges)

########################################################
# 4. CORRELATION ANALYSIS
########################################################

# Convert categorical variables for correlation
ds225$smoker_num <- ifelse(ds225$smoker == "yes", 1, 0)
ds225$gender_num <- ifelse(ds225$gender == "male", 1, 0)
ds225$region_num <- as.numeric(as.factor(ds225$region))

# Select numeric columns only
numeric_ds225 <- ds225[, c("age", "bmi", "children", "smoker_num", "gender_num", "region_num", "charges")]

# Compute correlation matrix
cor_matrix <- cor(numeric_ds225)

# Display matrix
cor_matrix

########################################################
# 5. INDIVIDUAL CORRELATIONS
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
# 6. HYPOTHESIS TESTING (T-TEST)
########################################################

# T-test for smoker vs non-smoker
t.test(charges ~ smoker, data = ds225)

# T-test for gender (male vs female)
t.test(charges ~ gender, data = ds225)


########################################################
# 7. SCATTERPLOTS
########################################################

# BMI vs Charges
png("scatter_bmi_charges.png", width = 1920, height = 1080, res = 150)
plot(ds225$bmi ~ ds225$charges,
     main = "Scatterplot: BMI vs Charges",
     xlab = "BMI",
     ylab = "Charges",
     pch = 19,
     col = "blue")
abline(lm(bmi ~ charges, data = ds225), col = "red", lwd = 2)
dev.off()
#saving scatter_bmi_charges.png


# Age vs Charges
png("scatter_age_charges.png", width = 1920, height = 1080, res = 150)
plot(ds225$age ~ ds225$charges,
     main = "Scatterplot: Age vs Charges",
     xlab = "Age",
     ylab = "Charges",
     col = "green")
abline(lm(age ~ charges, data = ds225), col = "red", lwd = 2)
dev.off()
#saving scatter_age_charges.png

# Children vs Charges
png("scatter_children_charges.png", width = 1920, height = 1080, res = 150 )
plot(ds225$children ~ ds225$charges,
     main = "Scatterplot: Children vs Charges",
     xlab = "Children",
     ylab = "Charges",
     col = "purple")
abline(lm(children ~ charges, data = ds225), col = "red", lwd = 2)
dev.off()
#saving scatter_children_charges.png

#######################
#Additionally
########################################################
#HEATMAP WITH CORRELATION NUMBERS (BASE R)
########################################################

heatmap_data <- cor_matrix

png("heatmap_data.png", width = 1920, height = 1080, res = 150)

# Added xlab = "" and ylab = "" to remove the axis labels
image(1:ncol(heatmap_data),
      1:nrow(heatmap_data),
      t(heatmap_data[nrow(heatmap_data):1, ]),
      axes = FALSE,
      main = "Correlation Heatmap",
      xlab = "",  # Removes the x-axis label
      ylab = "")  # Removes the y-axis label

# Add axis labels
axis(1, at = 1:ncol(heatmap_data), labels = colnames(heatmap_data))
axis(2, at = 1:nrow(heatmap_data), labels = rev(rownames(heatmap_data)))

# Add numeric correlation values
for (i in 1:nrow(heatmap_data)) {
  for (j in 1:ncol(heatmap_data)) {
    text(j, nrow(heatmap_data)-i+1,
         labels = round(heatmap_data[i, j], 2))
  }
}

dev.off()
#saving heatmap_data.png.png


########################################################
# PREP FOR MODELING
########################################################

# Simple linear model: BMI → Charges
lm_bmi <- lm(charges ~ bmi, data = ds225)
summary(lm_bmi)

# Multi-variable model
lm_full <- lm(charges ~ age + bmi + smoker_num + children, data = ds225)
summary(lm_full)

########################################################
# END OF SCRIPT
########################################################

df <- insurence
ds225 <- insurance

#Checking total missing values
sum(is.na(ds225))

#Checking missing values per column
colSums(is.na(ds225))

# Detect outliers for BMI
BMI_outliers <- boxplot.stats(ds225$bmi)$out
BMI_outliers

# Detect outliers for charges
charges_outliers <- boxplot.stats(ds225$charges)$out
charges_outliers

#Boxplots for visualization

boxplot(ds225$bmi, main = "Boxplot of BMI", ylab = "BMI")
boxplot(ds225$charges, main = "Boxplot of Charges", ylab = "Charges")

#Added new columns to flag outlier rows
ds225$BMI_outlier <- ds225$bmi %in% BMI_outliers
ds225$charges_outlier <- ds225$charges %in% charges_outliers

#Created new datasets without outliers
ds225_no_bmi_outliers <- ds225[!ds225$bmi %in% BMI_outliers, ]
ds225_no_charges_outliers <- ds225[!ds225$charges %in% charges_outliers, ]

#Summary before and after
summary(ds225$bmi)
summary(ds225$charges)
summary(ds225_no_charges_outliers$charges)

#Visual comparison of Box plots
png("Boxplot_of_charges_Outliers.png", width = 800, height = 500)
par(mfrow=c(1,2))
boxplot(ds225$charges, main="Before Removing Outliers", ylab = "Charges")
boxplot(ds225_no_charges_outliers$charges, main="After Removing Outliers", ylab = "Charges")
dev.off()

# Calculate correlation value
correlation_value <- cor(ds225$bmi, ds225$charges, method = "pearson")
correlation_value

# Correlation test
cor.test <- cor.test(ds225$bmi, ds225$charges, method = "pearson")
cor.test

# Scatter plot for BMI vs Charges
png("scatter_bmi_charges.png", width = 800, height = 500)

plot(ds225$bmi, ds225$charges,
     main = "Scatterplot: BMI vs Charges",
     xlab = "BMI",
     ylab = "Charges",
     pch = 19,
     col = "blue")

abline(lm(charges ~ bmi, data = ds225), col = "red", lwd = 2)

dev.off()


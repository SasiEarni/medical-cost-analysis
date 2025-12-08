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

#Shapiro test for BMI
shapiro.test(ds225$bmi)

#Shapiro test for Charges
shapiro.test(ds225$charges)

#Combined Visualization of Density and Histogram plots for BMI and Charges
png("Combined_visualization.png", width = 800, height = 500)
par(mfrow = c(2,2))
hist(ds225$bmi, main = "Histogram of BMI")
plot(density(ds225$bmi), main = "Density of BMI")
hist(ds225$charges, main = "Histogram of Charges")
plot(density(ds225$charges), main = "Density of Charges")
par(mfrow = c(1,1))
dev.off()

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


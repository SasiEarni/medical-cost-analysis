df <- insurance

# Calculate correlation value
correlation_value <- cor(df$bmi, df$charges, method = "pearson")
correlation_value

# Correlation test
cor.test <- cor.test(df$bmi, df$charges, method = "pearson")
cor.test

# Scatter plot for BMI vs Charges
png("scatter_bmi_charges.png", width = 800, height = 500)

plot(df$bmi, df$charges,
     main = "Scatterplot: BMI vs Charges",
     xlab = "BMI",
     ylab = "Charges",
     pch = 19,
     col = "blue")

abline(lm(charges ~ bmi, data = df), col = "red", lwd = 2)

dev.off()

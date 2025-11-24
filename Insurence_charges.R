df <- insurance

correlation_value <- cor(df$bmi, df$charges, method = "pearson")
correlation_value

cor.test <- cor.test(df$bmi, df$charges, method = "pearson")
cor.test

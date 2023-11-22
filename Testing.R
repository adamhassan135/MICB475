library(tidyverse)
library(dplyr)

data <- read_delim("tanz_col_metadata.txt", delim="\t")
spec(data)
tanzania_data <- data %>% filter(Location == "TANZANIA")
colombia_data <- data %>% filter(Location == "COLUMBIA")
tanzania_age <- tanzania_data$age_years
colombia_age <- colombia_data$age_years
age_test_result <- wilcox.test(tanzania_age, colombia_age)
print(age_test_result)
ks_result <- ks.test(tanzania_age, colombia_age)
print(ks_result)


#proportion of men to women in tanzania, or men to women in general 

#307, #325 

#119 women tanz 

#129 men tanz 

#178 men col 

#206 women 

data2 <- matrix(c(129, 178, 119, 206), nrow = 2, byrow = TRUE)
rownames(data) <- c("Men", "Women")
colnames(data) <- c("Tanzania", "Columbia")
result <- chisq.test(data)
print(result)





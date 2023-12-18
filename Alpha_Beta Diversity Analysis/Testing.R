library(tidyverse)
library(dplyr)

#November 10th 2023
#bringing in the data
data <- read_delim("tanz_col_metadata.txt", delim="\t")

#reading ther data and filtering the data
spec(data)
tanzania_data <- data %>% filter(Location == "TANZANIA")
colombia_data <- data %>% filter(Location == "COLUMBIA")
tanzania_age <- tanzania_data$age_years
colombia_age <- colombia_data$age_years

tanzania_sex <- tanzania_data$sex
colombia_sex <- colombia_data$sex

tanzania_data_women <- tanzania_data %>% filter(sex == "FEMALE")
colombia_data_women <- colombia_data %>% filter(sex == "FEMALE")
tanzania_data_men <- tanzania_data %>% filter(sex == "MALE")
colombia_data_men <- colombia_data %>% filter(sex == "MALE")

#running wilcox test to determine if age distribution is significantly differnet
age_test_result <- wilcox.test(tanzania_age, colombia_age)

#printing results 
print(age_test_result)

#kruskal wallis test on age distribution to double check 
ks_result <- ks.test(tanzania_age, colombia_age)

print(ks_result)


#proportion of men to women in tanzania, or men to women in general 

#Manually examined the size of each filter to see size of each group
#easier to run test this way

#307, #325 

#119 women tanz 

#129 men tanz 

#178 men col 

#206 women 
#create matrix 
data2 <- matrix(c(130, 177, 119, 206), nrow = 2, byrow = TRUE)

#name rows in matrix
rownames(data2) <- c("Men", "Women")

#name columns in matrix 
colnames(data2) <- c("Tanzania", "Columbia")

#run chi square to see gender distribution and print results 
result <- chisq.test(data2)
print(result)





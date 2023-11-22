#Step 1: Calling upon the necesssary packages for diversity analysis
library(vegan)
library(tidyverse)
library(picante)
library(phyloseq)
library(ape)
library(ggforce)
library(ggpubr)
library(ggplot2)

#Step 2: Loading in Phyloseq Object
load("tanz_col_rare.txt")

#Step 3: Generating Shannon Diversity Graph for Tanzania and Columbia
compare_means(Shannon ~ Location, data = tanz_col_sampdat_wdiv)

gg_richness <- plot_richness(tanz_col_rare, x ="Location",measures=c("Shannon")) +geom_boxplot()+ stat_compare_means(label = "p.signif", method = "wilcox.test",ref.group = ".all.") + stat_compare_means(method="wilcox.test", label.x = 1.4, label.y = 1.3)
gg_richness
#Saving the alpha diversity plot
ggsave(filename = "Tanzania_Columbia_Shannongraph.jpg", plot =gg_richness, height=5, width=5)

#Step 4: Showing Shannon Diversity values for every sample based on location (Tanzania or Columbia)

Shannon_Diveristy_Values <- estimate_richness(tanz_col_rare,measures =c("Shannon"))

#Joining together meta dat table and Shannon Diversity Values into a singular data frame
Shannon_Diversity_Values_withmetadata <- data.frame(tanz_col_sampdat, Shannon_Diveristy_Values)

#Only keeping the location meta data category and removing all other columns 
Shannon_Diversity_Values_Location_Only <- select(Shannon_Diversity_Values_withmetadata, "Location", "Shannon")

#Saving Table as a txt file
write.table(Shannon_Diversity_Values_Location_Only, file="Shannon_Diversity_Values.txt", sep ="\t", row.names= FALSE)

#Generating Weighted Unifrac PCOA plot and Beta Diversity Analysis
#step 1: Determining Phylogenetic Distances
weighted_unifrac_distance <- distance(tanz_col_rare, method = "unifrac")

#Step 2:Generating Co-ordinate System for PCOA plot
pcoa_Tanz_Col_unifrac <-ordinate(tanz_col_rare, method = "PCoA", distance =weighted_unifrac_distance)

#Step 3:Generation of Actual PCoA plot and seperating based on location e.g Tanzania and Columbia
pcoa_plot_unifrac_Tanz_Col <-plot_ordination(tanz_col_rare, pcoa_Tanz_Col_unifrac,color = "Location", shape = "Location")

ggsave(filename ="Tanzania_Columbia_PCOA_Unifrac_Plot.jpg", plot=pcoa_plot_unifrac_Tanz_Col)

#Statistical Analysis on Shannon Diversity metrics via linear regression
#Step 1: Generating all known diversity metrics using the estimate richness command
alphadiv_tanz_col <- estimate_richness(tanz_col_rare)

#Step 2: Extracting the Meta data table from phyloseq object 
tanz_col_sampdat <- sample_data(tanz_col_rare)

#Step 3:Joining meta data and alpha diversity metrics together in a singular object
tanz_col_sampdat_wdiv <- data.frame(tanz_col_sampdat, alphadiv_tanz_col)

#Step 4:Determining if data is skewed
allCounts <- as.vector(otu_table(tanz_col_rare))
allCounts <- allCounts[allCounts>0]
hist(allCounts)
#Clearly data is skewed so Wilcoxon Rank sum Test is the best choice for statistical analysis on Shannon Diversity Metric

#Step 5: Carrying out Wilcoxon Test upon Shannon Diversity Metric
wilcox.test(Shannon ~ Location, data =tanz_col_sampdat_wdiv, exact = FALSE)
#P-value recorded was < 2.2e-16 which is below the 0.05 cut off point meaning that the Shannon diversity values
#between the Tanzania and Columbia are significantly different from each other.

#Statistical Significance on Beta Diversity Weighted Unifrac using PERMANOVA and pseudo F ratio
#Step 1: Generating a distance matrix for weighted unifrac
dm_unifrac_tanz_col <- UniFrac(tanz_col_rare, weighted=TRUE)

#Step 2:Running the Adonis Function
Beta_Diversity_Tanz_Col_Significance<-adonis2(dm_unifrac_tanz_col ~ Location, data =tanz_col_sampdat_wdiv)
#P value was less than 0.001 meaning that there is significant differences in terms of beta diversity between the Columbia and Tanzania Samples

#Step 3: Generating new PCOA plot that has significance
pcoa_plot_unifrac_Tanz_Col_significance_included <-plot_ordination(tanz_col_rare,pcoa_Tanz_Col_unifrac, color ="Location", shape="Location") +
 stat_ellipse(type = "norm") + annotate("text", x = 0, y = -0.35, label = "PERMANOVA, p < 0.001")
pcoa_plot_unifrac_Tanz_Col_significance_included
#Saving New PCoA plot with ellipses surrounding groups of significance
ggsave(filename = "Tanzania_Columbia_PCOA_Unifrac_Plot_significance.jpg", pcoa_plot_unifrac_Tanz_Col_significance_included, height=4, width=6)


#sex 
women_tanz_col <- Shannon_Diversity_Values_withmetadata %>% filter(sex == "FEMALE")
man_tanz_col <- Shannon_Diversity_Values_withmetadata %>% filter(sex == "MALE")

#age 
age_18_40 <- Shannon_Diversity_Values_withmetadata %>% filter(age_years > 18 & age_years < 40)
age_40_plus <- Shannon_Diversity_Values_withmetadata %>% filter(age_years > 40)

#sex and location
women_tanz <- women_tanz_col %>% filter(Location == "TANZANIA")
women_col <- women_tanz_col %>% filter(Location == "COLUMBIA")
men_tanz <- women_tanz_col %>% filter(Location == "TANZANIA")
men_col <- women_tanz_col %>% filter(Location == "COLUMBIA")

#age and location
age_18_40_tanzania <- age_18_40 %>% filter(Location == "TANZANIA")
age_18_40_columbia <- age_18_40 %>% filter(Location == "COLUMBIA")
age_40_plus_tanzania <- age_40_plus %>% filter(Location == "TANZANIA")
age_40_plus_colombia <- age_40_plus %>% filter(Location == "COLUMBIA")

#age and location and gender 
age_18_40_tanzania_women <- age_18_40_tanzania %>% filter(sex == "FEMALE")
age_18_40_columbia_women <- age_18_40_columbia %>% filter(sex == "FEMALE")
age_18_40_tanzania_men <- age_18_40_tanzania %>% filter(sex == "MALE")
age_18_40_columbia_men <- age_18_40_columbia %>% filter(sex == "MALE")
age_40_plus_tanzania_women <- age_40_plus_tanzania %>% filter(sex == "FEMALE")
age_40_plus_colombia_women <- age_40_plus_colombia %>% filter(sex == "FEMALE")
age_40_plus_tanzania_men <- age_40_plus_tanzania %>% filter(sex == "MALE")
age_40_plus_colombia_men <- age_40_plus_colombia %>% filter(sex == "MALE")

model1 <- lm(Shannon_Diversity_Values_withmetadata$Shannon ~ Shannon_Diversity_Values_withmetadata$age_years, data = Shannon_Diversity_Values_withmetadata)
model2 <- lm(age_18_40_tanzania$Shannon ~ age_18_40_tanzania$age_years, data = age_18_40_tanzania)
model3 <- lm(age_18_40_columbia$Shannon ~ age_18_40_columbia$age_years, data = age_18_40_columbia)


agevshannon <- ggplot(Shannon_Diversity_Values_withmetadata, aes(x = Shannon_Diversity_Values_withmetadata$age_years, y = Shannon_Diversity_Values_withmetadata$Shannon )) +
  geom_point() +             
  geom_smooth(method = "lm")

agevshannontanzania <- ggplot(age_18_40_tanzania, aes(x = age_18_40_tanzania$age_years, y = age_18_40_tanzania$Shannon )) +
  geom_point() +                
  geom_smooth(method = "lm")

agevshannoncolombia <- ggplot(age_18_40_columbia, aes(x = age_18_40_columbia$age_years, y = age_18_40_columbia$Shannon )) +
  geom_point() +                
  geom_smooth(method = "lm")

agevshannoncolombia40plus <- ggplot(age_40_plus_colombia, aes(x = age_40_plus_colombia$age_years, y = age_40_plus_colombia$Shannon )) +
  geom_point() +                
  geom_smooth(method = "lm")

agevshannontanzania40plus <- ggplot(age_40_plus_tanzania, aes(x = age_40_plus_tanzania$age_years, y = age_40_plus_tanzania$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

women_general <- ggplot(women_tanz_col, aes(x = women_tanz_col$age_years, y = women_tanz_col$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

man_general <- ggplot(man_tanz_col, aes(x = man_tanz_col$age_years, y = man_tanz_col$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

womenvshannontanz <- ggplot(women_tanz, aes(x = women_tanz$age_years, y = women_tanz$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")
womenvshannoncol <- ggplot(women_col, aes(x = women_col$age_years, y = women_col$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")
menvshannontanz <- ggplot(men_tanz, aes(x = men_tanz$age_years, y = men_tanz$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")
menvshannoncol <- ggplot(men_col, aes(x = men_col$age_years, y = men_col$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")
  
men18to40tanzvshannon<- ggplot(age_18_40_tanzania_men, aes(x = age_18_40_tanzania_men$age_years, y = age_18_40_tanzania_men$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

men18to40colvshannon<- ggplot(age_18_40_columbia_men, aes(x = age_18_40_columbia_men$age_years, y = age_18_40_columbia_men$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

women18to40tanzvshannon<- ggplot(age_18_40_tanzania_women, aes(x = age_18_40_tanzania_women$age_years, y = age_18_40_tanzania_women$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

women18to40colvshannon<- ggplot(age_18_40_columbia_women, aes(x = age_18_40_columbia_women$age_years, y = age_18_40_columbia_women$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

men40plustanzvshannon<- ggplot(age_40_plus_tanzania_men, aes(x = age_40_plus_tanzania_men$age_years, y = age_40_plus_tanzania_men$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

men40pluscolvshannon<- ggplot(age_40_plus_colombia_men, aes(x = age_40_plus_colombia_men$age_years, y = age_40_plus_colombia_men$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

women40plustanzvshannon<- ggplot(age_40_plus_tanzania_women, aes(x = age_40_plus_tanzania_women$age_years, y = age_40_plus_tanzania_women$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")

women40pluscolvshannon<- ggplot(age_40_plus_colombia_men, aes(x = age_40_plus_colombia_men$age_years, y = age_40_plus_colombia_men$Shannon )) +
  geom_point() +               
  geom_smooth(method = "lm")








agevshannon
agevshannontanzania
agevshannoncolombia
agevshannoncolombia40plus
agevshannontanzania40plus
women_general
man_general
womenvshannontanz
womenvshannoncol
menvshannontanz
menvshannoncol
men18to40tanzvshannon
men18to40colvshannon
women18to40tanzvshannon
women18to40colvshannon
men40plustanzvshannon
men40pluscolvshannon
women40plustanzvshannon
women40pluscolvshannon

#women and men over 40 lose more diversity in tanz than in col 



ggsave("filename.png", agevshannon)






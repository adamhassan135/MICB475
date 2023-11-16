#Step 1: Calling upon the necesssary packages for diversity analysis
library(vegan)
library(tidyverse)
library(picante)
library(phyloseq)
library(ape)
library(ggforce)

#Step 2: Loading in Phyloseq Object
load("tanz_col_rare.txt")

#Step 3: Generating Shannon Diversity Graph for Tanzania and Columbia
gg_richness <- plot_richness(tanz_col_rare, x ="Location",measures=c("Shannon")) +geom_boxplot()

#Saving the alpha diversity pot
ggsave(filename = "Tanzania_Columbia_Shannongraph.jpg", plot =gg_richness)

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

#Statistical Significance on Beta Diversity Weighted Unifrac using PERMANOVA and psuedo F ratio
#Step 1: Generating a distance matrix for weighted unifrac
dm_unifrac_tanz_col <- UniFrac(tanz_col_rare, weighted=TRUE)

#Step 2:Running the Adonis Function
Beta_Diversity_Tanz_Col_Significance<-adonis2(dm_unifrac_tanz_col ~ Location, data =tanz_col_sampdat_wdiv)
#P value was less than 0.001 meaning that there is significant differences in terms of beta diversity between the Columbia and Tanzania Samples

#Step 3: Generating new PCOA plot that has significance
pcoa_plot_unifrac_Tanz_Col_significance_included <-plot_ordination(tanz_col_rare,pcoa_Tanz_Col_unifrac, color ="Location", shape="Location") +
 stat_ellipse(type = "norm")

#Saving New PCoA plot with elipses surrounding groups of significance
ggsave(filename ="Tanzania_Columbia_PCOA_Unifrac_Plot_significance.jpg", plot=pcoa_plot_unifrac_Tanz_Col_significance_included)












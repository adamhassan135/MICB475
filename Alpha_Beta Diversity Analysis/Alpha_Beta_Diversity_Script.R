#Step 1: Calling upon the necesssary packages for diversity analysis
library(vegan)
library(tidyverse)
library(picante)
library(phyloseq)
library(ape)

#Step 2: Loading in Phyloseq Object
load("tanz_col_rare.txt")

#Step 3: Generating Shannon Diversity Graph for Tanzania and Columbia
gg_richness <- plot_richness(tanz_col_rare, x ="Location",measures=c("Shannon")) +geom_boxplot()

#Saving the alpha diversity pot
ggsave(filename = "Tanzania_Columbia_Shannongraph.jpg", plot =gg_richness)


#Generating Weighted Unifrac PCOA plot and Beta Diversity Analysis
#step 1: Determining Phylogenetic Distances
weighted_unifrac_distance <- distance(tanz_col_rare, method = "unifrac")

#Step 2:Generating Co-ordinate System for PCOA plot
pcoa_Tanz_Col_unifrac <-ordinate(tanz_col_rare, method = "PCoA", distance =weighted_unifrac_distance)

#Step 3:Generation of Actual PCoA plot and seperating based on location e.g Tanzania and Columbia
pcoa_plot_unifrac_Tanz_Col <-plot_ordination(tanz_col_rare, pcoa_Tanz_Col_unifrac,color = "Location", shape = "Location")

ggsave(filename ="Tanzania_Columbia_PCOA_Unifrac_Plot.jpg", plot=pcoa_plot_unifrac_Tanz_Col)


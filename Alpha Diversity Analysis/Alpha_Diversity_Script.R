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
ggsave(filename = "Tanzania_Columbia_Shannongraph.jpg", plot =gg_richness)

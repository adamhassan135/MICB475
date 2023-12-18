#Step 1: Loading all the packages requried for core microbiome analysis
library(tidyverse)
library(phyloseq)
library(microbiome)
library(ggVennDiagram)
library(indicspecies)

#sTEP 2: Loading Unrarefied phylo seq object that was generated from previous analysis
load("../Core_Microbiome_Analysis/tanz_col_phyloseq_final.txt")

#Step 3: Converting OTU table to relative abundance
tanz_col_RA <- transform_sample_counts(tanz_col_phyloseq_final, fun=function(x) x/sum(x))

#Step 4: Subsetting data into Tanzania and Columbia groups
Tanzania_stat <- subset_samples(tanz_col_RA, Location=="TANZANIA")
Colombia_stat <- subset_samples(tanz_col_RA, Location=="COLOMBIA")

#Step 5: Setting up the thresholds for prevalence and abundance
Tanzania_ASVs <- core_members(Tanzania_stat, detection=0.001, prevalence = 0.10)
Colombia_ASVs <- core_members(Colombia_stat, detection=0.001, prevalence = 0.10)

#Step 6: Generating Venn Diagram
#Combining The Tanzania and Columbia subsetted data into a singular list
Tanzania_Columbia_ASVs_together <- list(Tanzania =Tanzania_ASVs, Colombia =Columbia_ASVs)
#Actually making the Venn Diagram
Venndigram <- ggVennDiagram(x= Tanzania_Columbia_ASVs_together)
ggsave("tanz_col_VennDiagram.jpeg", Venndigram)



#Indicator Species Analaysis

#Step 1:Grouping Organisms based on the genus level and then determining their relative abundance
#Grouping organims based on the genus level
tanz_col_genus <- tax_glom(tanz_col_phyloseq_final, "Genus", NArm = FALSE) 
#Determining Relative Abundance of Organisms
tanz_col_genus_RA <- transform_sample_counts(tanz_col_genus, fun=function(x) x/sum(x))

#Step 2:Multipath Function and Determining the indicator value for each individual ASV
isa_tanz_col <- multipatt(t(otu_table(tanz_col_genus_RA)), cluster = sample_data(tanz_col_genus_RA)$`Location`)
summary(isa_tanz_col)
#Step 3: Conversion of ASV ID into actual Taxonomic Names
#Generating Taxa table and changing row name into ASV
taxtable <- tax_table(tanz_col_phyloseq_final) %>% as.data.frame() %>% rownames_to_column(var="ASV")
#Joining together with indicator table
Indicator_Species_Analysis_Table_tanz_col <- isa_tanz_col$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% view()

view(Indicator_Species_Analysis_Table_tanz_col)

#Step 4: Saving Indicator Taxa Table
write.table(Indicator_Species_Analysis_Table_tanz_col, file="Indicator_Taxa_Table.txt", sep= "\t", row.names=FALSE)
  





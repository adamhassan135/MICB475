#Step 1: Calling Upon the Packages Required for Analysis
library(vegan)
library(tidyverse)
library(ape)
library(phyloseq)

#Step 2: Loading in all data (tax, otu, meta, and phylogenetic tree)
#Meta data file load in 
metafp <- "../MICB475/tanz_col_export/tanz_col_metadata.txt"
meta <- read_delim(metafp, delim ="\t")

#Features table file load in
otufp <- "../MICB475/tanz_col_export/tanz_col_feature_table.txt"
otu <- read_delim(otufp, delim="\t", skip = 1)

#Taxonomy file load in
taxfp <-"../MICB475/tanz_col_export/taxonomy.tsv"
tax <- read_delim(taxfp, delim ="\t")

#Phylogenetic Tree file load in
phylotreefp <-"../MICB475/tanz_col_export/tree.nwk"
phylotree <- read.tree(phylotreefp)

#Step 3: Formatting all files in format acceptable for Phyloseq
#Removing index column within feature table (otu) and converting to a matrix instead of tibble object type
otu_mat <- as.matrix(otu[,-1])
#Creating new first column within features tables (otu) and making it the OTU ID and the new index
rownames(otu_mat) <- otu$`#OTU ID`
#Generate the phyloseq OTU object from adjusted otu table
OTU <- otu_table(otu_mat, taxa_are_rows = TRUE)

#Removing index column within meta data table and converting into a data frame object type
samp_df <- as.data.frame(meta[,-1]) 
#Creating new first column within meta data table with the #sampleID as the new index
rownames(samp_df)<- meta$'#SampleID'
#Generating the Phyloseq meta data object from adjusted meta data table
SAMP <- sample_data(samp_df)

#Removing confidence column within tax table and separating the taxon table into individual columns for taxonomic groups
#Converting the tax table into a matrix too
tax_mat <- tax %>% select(-Confidence)%>%
  separate(col=Taxon, sep="; ", into = c("Domain","Phylum","Class","Order","Family","Genus","Species")) %>%
  as.matrix()
#Remove first column within new tax table and replace the index with the feature ID column
tax_mat <- tax_mat[,-1]
rownames(tax_mat) <- tax$`Feature ID`
#Converting newly formed tax table into phyloseq recognizable object
TAX <- tax_table(tax_mat)

#Step 4: Generating Phyloseq object
tanz_col_phyloseq <- phyloseq(OTU, SAMP, TAX, phylotree)

#Step 5: Processor Functions(removal of non bacterial sequences and bad samples)
#Removing non bacterial sequences (i.e mitochondrial, chloroplast)
tanz_col_phyloseq_filt <-subset_taxa(tanz_col_phyloseq, Domain == "d__Bacteria", 
Class!="c__Chloroplast" & Family !="f__Mitochondria")

#Step 6:Removing ASVs that have too little reads and samples that have too little reads

#Removing ASVs that have counts lower than 5 
tanz_col_phyloseq_filt_nolow <- filter_taxa(tanz_col_phyloseq_filt, function(x) sum(x)>5, prune = TRUE)
#Removing Samples that have less than 100 reads within them
tanz_col_phyloseq_final <- prune_samples(sample_sums(tanz_col_phyloseq_filt_nolow)>100, tanz_col_phyloseq_filt_nolow)

#Step 7: Saving Unrarified Phyloseq Object for later analysis
save(tanz_col_phyloseq_final, file="tanz_col_phyloseq_final.txt")

#Step 8: Rareifying Phyloseq Object
rarefaction_curve <-rarecurve(t(as.data.frame(otu_table(tanz_col_phyloseq_final))), cex=0.1)
#Carrying out rarefaction process and setting sampling depth of 22172 reads minimum
tanz_col_rare <-rarefy_even_depth(tanz_col_phyloseq_final, rngseed = 1, sample.size = 22172)

#Step 9:Saving Rarefied Phyloseq Object
save(tanz_col_rare, file="tanz_col_rare.txt")







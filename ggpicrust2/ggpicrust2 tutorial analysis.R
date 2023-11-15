
install.packages("ggpicrust2")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

pkgs <- c("phyloseq", "ALDEx2", "SummarizedExperiment", "Biobase", "devtools", 
          "ComplexHeatmap", "BiocGenerics", "BiocManager", "metagenomeSeq", 
          "Maaslin2", "edgeR", "lefser", "limma", "KEGGREST", "DESeq2")

for (pkg in pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE))
    BiocManager::install(pkg)
}



library(readr)
library(ggpicrust2)
library(tibble)
library(tidyverse)
library(ggprism)
library(patchwork)
library(DESeq2)

#Importing the pahtway PICrsut2
abundance_file <- "output/pathways_out/path_abun_unstrat.tsv"
abundance_data <- read_delim(abundance_file, delim = "\t", col_names = TRUE, trim_ws = TRUE)
abundance_data  =as.data.frame(abundance_data)
rownames(abundance_data) = abundance_data$pathway
abundance_data = abundance_data[,-1]


metadata <- read_delim(
  "output/metadata_categorized_CL.txt",
  delim = "\t",
  escape_double = FALSE,
  trim_ws = TRUE
)

parkinsons_only_metadata = metadata %>%
  filter(disease != "Healthy")


# Workflow for MetaCyc Pathway and EC

# Load MetaCyc pathway abundance and metadata EXAMPLE DATASET STARTS HERE####################
data("metacyc_abundance") #loading example abundance table
data("metadata") # loading example metadata
library("ggh4x")

# Perform pathway DAA using LinDA method
# Please change column_to_rownames() to the feature column if you are not using example dataset
# Please change group to "your_group_column" if you are not using example dataset
metacyc_daa_results_df <- pathway_daa(abundance = metacyc_abundance %>% column_to_rownames("pathway"), metadata = metadata, group = "Environment", daa_method = "LinDA")

# Annotate MetaCyc pathway results without KO to KEGG conversion
metacyc_daa_annotated_results_df <- pathway_annotation(pathway = "MetaCyc", daa_results_df = metacyc_daa_results_df, ko_to_kegg = FALSE)

# Generate pathway error bar plot (OPTIONAL)
# Please change column_to_rownames() to the feature column
# Please change Group to metadata$your_group_column if you are not using example dataset
pathway_errorbar(abundance = metacyc_abundance %>% column_to_rownames("pathway"), daa_results_df = metacyc_daa_annotated_results_df, Group = metadata$Environment, ko_to_kegg = FALSE, p_values_threshold = 0.05, order = "group", select = NULL, p_value_bar = TRUE, colors = NULL, x_lab = "description")

# Generate pathway heatmap
# Please change column_to_rownames() to the feature column if you are not using example dataset
# Please change group to "your_group_column" if you are not using example dataset
feature_with_p_0.05 <- metacyc_daa_results_df %>% filter(p_adjust < 0.05)
pathway_heatmap(abundance = metacyc_abundance %>% filter(pathway %in% feature_with_p_0.05$feature) %>% column_to_rownames("pathway"), metadata = metadata, group = "Environment")

# Generate pathway PCA plot
# Please change column_to_rownames() to the feature column if you are not using example dataset
# Please change group to "your_group_column" if you are not using example dataset
pathway_pca(abundance = metacyc_abundance %>% column_to_rownames("pathway"), metadata = metadata, group = "Environment")


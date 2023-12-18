
# October 5th, 2023
Work done on server
 user:10.19.139.107
 pwd: Biome1241
### navigating to working directory

(qiime2-2023.7) root@7c22cd5c6acc:~# cd data/
(qiime2-2023.7) root@7c22cd5c6acc:~/data# cd tanzania_demux/

### Transfer of Manifest file to QIIME2 (in separate terminal window)
PS C:\Users\trush\Documents\475\project_2> scp tanzania_colombia_manifest.txt root@10.19.139.107:/data/tanzania_demux


### Demultiplexing using the manifest file on QIIME2
(qiime2-2023.7) root@7c22cd5c6acc:~/data/tanzania_demux# qiime tools import \
  --type "SampleData[SequencesWithQuality]" \
  --input-format SingleEndFastqManifestPhred33V2 \
  --input-path ./tanzania_colombia_manifest.txt \
  --output-path ./tanzania_colombia_demux_seqs.qza
Imported ./tanzania_colombia_manifest.txt as SingleEndFastqManifestPhred33V2 to ./tanzania_colombia_demux_seqs.qza


### Creating a visualization of demultiplexed samples 
qiime demux summarize \
  --i-data tanzania_colombia_demux.qza \
  --o-visualization tanzania_colombia_demux_seqs.qzv

### Transfer of tanzania_colombia_demux_seqs.qzv to local machine (in separate terminal window)
PS C:\Users\trush\Documents\475\project_2> scp root@10.19.139.107:/data/tanzania_demux/tanzania_colombia_demux_seqs.qzv .

### Importing and demultiplexing the Colombia dataset
(qiime2-2023.7) root@7c22cd5c6acc:/data/colombia_demux# qiime tools import \
  --type "SampleData[SequencesWithQuality]" \
  --input-format SingleEndFastqManifestPhred33V2 \
  --input-path /mnt/datasets/project_2/colombia/colombia_manifest.txt \
  --output-path /colombia_demux_seqs.qza

### Creating a visualization of demultiplexed Colombia samples 
(qiime2-2023.7) root@7c22cd5c6acc:~/data/colombia_demux#
qiime demux summarize \
  --i-data colombia_demux_seqs.qza \
  --o-visualization colombia_demux_seqs.qzv


### transfer of colombia_demux_seqs.qzv to local machine (in separate terminal window)
PS C:\Users\trush\Documents\475\project_2> scp root@10.19.139.107:/data/colombia_demux/colombia_demux_seqs.qzv .


### Importing and demultiplexing the Tanzania dataset
(qiime2-2023.7) root@7c22cd5c6acc:/data/tanzania_demux# qiime tools import \
  --type "SampleData[SequencesWithQuality]" \
  --input-format SingleEndFastqManifestPhred33V2 \
  --input-path /mnt/datasets/project_2/tanzania/tanzania_manifest.txt \
  --output-path ./tanzania_demux_seqs.qza

### Creating a visualization of demultiplexed Colombia samples 
(qiime2-2023.7) root@7c22cd5c6acc:~/data/colombia_demux#
qiime demux summarize \
  --i-data tanzania_demux_seqs.qza \
  --o-visualization tanzania_demux_seqs.qzv

### transfer of tanzania_demux_seqs.qzv to local machine (in separate terminal window)
PS C:\Users\trush\Documents\475\project_2> scp root@10.19.139.107:/data/tanzania_demux/tanzania_demux_seqs.qzv .

###
TB (5-Oct-2023)

# Oct 8th, 2023

# Determine ASVs with DADA2
(qiime2-2023.7) root@7c22cd5c6acc:~/data/tanzania_demux# # Determine ASVs with DADA2
qiime dada2 denoise-single \
  --i-demultiplexed-seqs tanzania_colombia_demux_seqs.qza \
  --p-trim-left 0 \
  --p-trunc-len 210 \
  --o-representative-sequences tanzania_colombia_rep-seqs.qza \
  --o-table tanzania_colombia_table.qza \
  --o-denoising-stats tanzania_colombia_stats.qza

### END
TB (8-Oct-2023)

# Oct 9, 2023 

## Taxonomic analysis
qiime feature-classifier classify-sklearn \
  --i-classifier /mnt/datasets/classifiers/silva-138-99-515-806-nb-classifier.qza \
  --i-reads tanzania_colombia_rep-seqs.qza \
  --o-classification tanz_col_taxonomy.qza

## Generation of Taxonomy.qzv
qiime metadata tabulate \
  --m-input-file tanz_col_taxonomy.qza \
  --o-visualization tanz_col_taxonomy.qzv
  
## Taxonomy barplots
qiime taxa barplot \
  --i-table tanzania_colombia_table.qza \
  --i-taxonomy tanz_col_taxonomy.qza \
  --m-metadata-file Combined_Tazania_Columbia_Datasets.txt \
  --o-visualization tanz_col_taxa-bar-plots.qzv

## Filtering table to remove mitochondrial and chloroplast data
qiime taxa filter-table \
  --i-table tanzania_colombia_table.qza \
  --i-taxonomy tanz_col_taxonomy.qza \
  --p-exclude mitochondria,chloroplast \
  --o-filtered-table tanz_col_filtered_table.qza

## Exporting Table.qza file
qiime tools export \
  --input-path tanz_col_filtered_table.qza \
  --output-path /data/tanz_col_export

### END
TB (9-Oct-2023)


# Oct 10th, 2023

## Exporting Taxonomy File 
(qiime2-2023.7) root@7c22cd5c6acc:/data/tanzania_demux# qiime tools export \
  --input-path tanz_col_taxonomy.qza \
  --output-path /data/tanz_col_export

## Generate a tree for phylogenetic diversity analyses
(qiime2-2023.7) root@7c22cd5c6acc:/data/tanz_col_export# qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences tanzania_colombia_rep-seqs.qza \
  --o-alignment tanz_col_aligned-rep-seqs.qza \
  --o-masked-alignment tanz_col_masked-aligned-rep-seqs.qza \
  --o-tree tanz_col_unrooted-tree.qza \
  --o-rooted-tree tanz_col_rooted-tree.qza 

## Exporting Tree file 
(qiime2-2023.7) root@7c22cd5c6acc:/data/tanzania_demux# qiime tools export \
  --input-path tanz_col_rooted-tree.qza \
  --output-path /data/tanz_col_export

## generation of feature table.qzv 
qiime feature-table summarize \
  --i-table tanz_col_filtered_table.qza \
  --o-visualization tanz_col_filtered_table.qzv \
  --m-sample-metadata-file Combined_Tazania_Columbia_Datasets.txt


## generation of alpha rarefaction data 
qiime diversity alpha-rarefaction \
  --i-table tanz_col_filtered_table.qzv \
  --i-phylogeny tanz_col_rooted-tree.qza \
  --p-max-depth 95000 \
  --m-metadata-file Combined_Tazania_Columbia_Datasets.txt \
  --o-visualization tanz_col_alpha-rarefaction.qzv

### END
TB (10-Oct-2023)
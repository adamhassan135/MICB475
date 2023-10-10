# MICB475 Laboratory Notebook AJJBN23
#### **Team 2**

Adam Abdirahman Hassan, Joshua Jin, Trushaan Bundhoo, Timothy Bernas, and Farbod Nematifar





# Table of Contents
|Project Code|Experiment#|Title|Start Date|
|------------|-----------|-----|----------|
|#P001      |W4-TM|Week 4 Team Meeting|26-Sept-2023|
|#P001      |W5-TM|Week 5 Team Meeting|3-Oct-2023|
# Project Codes
#P001- Combining of Tanzania and Columbia Data set in Preparation for Manifest File Generation


## W4-TM: Week 4- Team Meeting 1 (26-Sept-2023)
### Start
### Team Meeting 1 Agenda
1. Selecting a Data and Research Question
2. Getting a timeline for the proposal

### **Meeting Minutes**
* Get a better understanding of what exactly we want to research with these 2 data sets
* That we will eventually have to create a new manifest file within QIIME2 attempting to reconcile the 2 pathways
* Get a github account ready and start our laboratory notebook 

### Team Meeting 1 Conclusions/Next Week Tasks
   * Decided on combining Hadza and Colombia datasets to compare the two
   * Decided to designate Adam with combining datasets via excel

 ### End   
 -AA (26-Sept-2023)

## W5-TM: Week 5- Team Meeting 2 (3-Oct-2023)
### Start
### Team Meeting 2 Agenda 
1. What to do with a combined dataset once finished
2. Iron out research proposal
3. Iron out our next tasks

### **Meeting Minutes**
* Talked about the breakdown of tasks as well as the delegation of tasks amongst indidviuals
* Worked out our overarching research question and the smaller aims within the larger question
* Talked about the tasks that are required to puruse the research project in question

### Stuff We did 

### Team Meeting 2 Conclusions/Things to do for next week
  * Chad told us to google how to make our manifest file/ask Evelyn
  * Trush will process the datasets once Adam puts them into qiime
  * Complete QIIME processing by next week if possible


### Team Meeting 3 Agenda
1. Discuss if we did everything properly 
2. Discuss further steps after making feature-table.txt
3. Discuss what the proposal should further look like

### Team Meeting 3 Conclusions 
  * 


### End
-AA (3-Oct-2023)
# Stuff We did 

### September 26, 2023

Adam started the github lab notebook 

Adam combined datasets

Adam tried to iron out a research proposal 

### October 3rd, 2023

Josh moved everything over from google docs to github 

### October 4th, 2023 
Github Integration Test w/ Desktop -- Trushaan

Completed manifest file -- Timothy 
(note on the txt file, it's tab limited so you should be able to treat it like a tsv file, don't convert the excel file into a csv, it changes the sample ids)



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

# Oct 5th, 2023 End (Trushaan)

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

# Oct 8, 2023 END (Trushaan)

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


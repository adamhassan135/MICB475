# MICB475 Laboratory Notebook AJJBN23
#### **Team 2**

Adam Abdirahman Hassan, Joshua Jin, Trushaan Bundhoo, Timothy Bernas, and Farbod Nematifar





# Table of Contents
|Project Code|Experiment#|Title|Start Date|
|------------|-----------|-----|----------|
|#P001      |W4-TM|Week 4 Team Meeting|26-Sept-2023|
|#P001      |W5-TM|Week 5 Team Meeting|3-Oct-2023|
|#P001      |W6-TM|Week 6 Team Meeting|10-Oct-2023|
|#P001      |W8-TM|Week 8 Team Meeting|24-Oct-2023|
|#P001      |W9-TM|Week 9 Team Meeting|31-Oct-2023|
|#P001      |W10-TM|Week 10 Team Meeting|7-Nov-2023|
|#P001      |W11-TM|Week 11 Team Meeting|16-Nov-2023|
# Project Codes
#P001- Combining of Tanzania and Columbia Data sets and QIIME analysis


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

### Team Meeting 2 Conclusions/Things to do for next week
  * Chad told us to google how to make our manifest file/ask Evelyn
  * Trush will process the datasets once Adam puts them into qiime
  * Complete QIIME processing by next week if possible

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

## W6-TM: Week 6- Team Meeting 3 (10-Oct-2023) 
### Team Meeting 3 Agenda
1. Discuss if we did everything properly 
2. Discuss further steps after making feature-table.txt
3. Discuss what the proposal should further look like

### Team Meeting 3 Meeting Minutes:
  * It was okay to use Silva, we're good with everything Trushaan has done up to this point
  * We should use Shannon's and Weighted Unifrac to look at differences in functional analysis
      * Ensure that the datasets are age and sex matched in R using subset_sample
      * Prop.test in R will be a proportions test to see if our male/female proportions are significantly different
      * Man Whitney for age- version of a T test- if significance is found, we can proceed as normal and mention it, or we can run a multi-linear regression every time instead of a statistical significance test. Tutorial here: https://www.datacamp.com/tutorial/multiple-linear-regression-r-tutorial     .06 is sort of where we should do a multi-linear. However, if it's like .07 or smt it's chill
      * In order to see if the significance leads to positive or negative correlation, we'll have to graph it and see visually
      * Differences in Microbiome composition in Hunter-gatherer diets against a Westernized diet across age and sex in adults
      * We split up the research aims amongst our different group members
      * Joshua Jin will do the diversity metrics (Aim 1)
      * Adam Abdirahman Hassan will do the differential analysis between groups in terms of taxa (Aim 2)
      * Timothy Bernas will do the Functional Analysis (Aim 3)
      * Farbod Nematifar will look at subsetting the data based on sex and age differences (Aim 4)
      * Trushaan Bundhoo will carry ou the introduction for our research proposal

  ### Team Meeeting Conclusions and what to do next week
* We will attempt to create a rough draft of our reserach proposal done by next week to show to our primary teaching assistant in Chad Poloni
* Each individual has been assigned an aim and has a rough idea in how to start that aim

### END
JJ (10-Oct-2023)

## Proposal
https://docs.google.com/document/d/1bDtrnNiY9EcHu5q0Ehg8QPYso1jSjeHoKq1wGk8cbDk/edit?usp=sharing

## W8-TM: Week 8- Team Meeting #5 (24-Oct-2023)
Start
### Team Meeting #5 Agenda 
1. Get a critique regarding the methods of our paper (Statistical Analysis, Graphs, what is acceptable P values and so on)
2. Get a better understanding of what is acceptable format for our figures and graphs
3. What are acceptable parameters for setting abudnance and prevalence during core microbiome analysis for aim 2 of our reserach project
   
### Meeting Minutes
* We were simply told to make necessary adjustments to our proposal and this will be outlined within a document given to us some time next week by Chad Poloni.   
* Ended up agreeing that P value of <0.05 would be considered significant and would suffice.
* Also agreed upon the fact that the graphs that R produces will be sufficient for our manuscript
* We were told that there is no clear standard for setting abundance and prevalence and that it is fundamentally up to us what we want to do

### Team Meeting Conclusions and What to do Next Week
* We will make the adjustments to our proposal based on the feedback that we recieve some time next week
* We will begin to do our R analysis for each of our indivdiual aims and have something prepared for next week.

### END
AA (24-Oct-2023)

## W9-TM: Week 9- Team Meeting #6 (31-Oct-2023)
Start
### Team Meeting #6 Agenda
1. Going over proposal final time
2. Determining how to display indicator species analysis for core microbiome analysis (table)
3. Question regarding displaying species within venn diagram.

### Meeting Minutes
* Talked about the code required for carrying out biochemical pathway analysis for aim 3 regarding functional analysis

### Potential Code to use for Biochemical Pathway Analysis
https://github.com/xia-lab/MicrobiomeAnalystR/blob/master/README.md

### Team Meeting Conclusions and What to do Next Week
* We will continue to work on our individual aims in preparation for creating our figures for our manuscript

### END
AA (31-Oct-2023)

## W10-TM : Week 10- Team Meeting #7 (7-Nov-2023)
Start
### Team Meeting #7 Agenda
1. Figuring out how to alleviate issues in regards to the usage of picrust2 for functional analysis
2. Figuring out potential alternatives to picrust2 if the fixes are not figured out.

### Meeting Minutes
* Talked about that for now we should move on from functional analysis via PICRUST2 and should focus on completing other aims 1 and 2 in particular.
* Talked about how to improve aim 2 we should zone in on the top 5 genera that are found within tanzania and columbia datasets respectively and do some digging in regards to the research on health implications.
* Talked abotu how to best approach alpha and beta diversity for our combined data sets.

### Team Meeting Conclusions and What to do Next Week
* We will attempt to fully complete aim 1/2 and show it to our main TA Chad for our next meeting.

### END
AA (7-Nov-2023)

## W11-TM : Week 11- Team Meeting #7 (16-Nov-2023)
Start
### Team Meeting #8 Agenda
1. Look over our attempts to complete aims 1/2 for our project








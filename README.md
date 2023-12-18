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
|#P001      |W12-TM|Week 12 Team Meeting|21-Nov-2023|
|#P001      |W13-TM|Week 13 Team Meeting|28-Nov-2023|
# Project Codes
#P001- Tanzania and Colombia combination data anlaysis


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


## W12- TM : Week 12- Team Meeting #9 (21-Nov-2023)
Start 
### Team Meeting #9 Agenda 
1. Ask how to connect Functional Analysis Pathways to Indicator Species
2. Ask how to better visualize PiCRUST Heat Map
3. Ask how to read all PiCRUST outputs + KO pathway TSV file
4. Ask how to narrow down our indicator species 

### Meeting Minutes 

*Talked about our PICRUSt analysis and what is important 
*Talked about how to narrow down our indicator species
*Talked about how to carry out our sex and age confound analysis 

### Team Meeting Conclusions and What to do Next Week

1. Finalize indicator species table. One table of 10 of each, Colombia and Tanzania's indicator species - Probably Adam will do this. Write in a column saying this is backed by literature, or not, Evelyn said we could rely purely on numbers as well. 
2. Finalize PCA plot titled "Functional Diversity is Higher in Colombia Microbiomes" or something like that. Include in the figure caption very basic info, such as statistical analysis used, the fact that analysis was used with picrust, etc, etc. Crop out the P values. 
3. Write a skeleton structure of what we want to cover for our proposal and use the same thing for our manuscript.
4. Don't use the heat map. It's trash. 
   

### END 
JJ (21-Nov-2023)
### Work done on 21-Nov-2023 
- added significance indicators and performed statistical analysis on the figures for alpha and beta diversity 
- changed the shannon graph test from wilcoxon to kruskal-wallis 
TB

## W13- TM: Week 13- Team Meeting #10 (28-Nov-2023)
Start
### Team Meeting #10 Agenda
1. Go over slides that we prepared for the upcoming meeting on Dec.5th or Dec.7th

### Meeting Minutes
* Talked about ways that we could improve our presentation slides and what is expected when we should present

### Team Meeting Conclusions and What to do Next Week
* We will continue writing the manuscript and get as much done for the rough draft manuscript due on December 10th

### End
-AA (28-Nov-2023)
### Presentation and Final Paper
https://docs.google.com/presentation/d/11SDMi5dXWnvHkX7xN6CsoRfdqz02K2kkiT7qUyvSNOU/edit?usp=sharing
https://docs.google.com/document/d/1qT8bYZPFdBTiBRVsgSuAKUt-OsJqcpSn-fCT7JvJbwg/edit?usp=sharing

### Metagenome Prediction with PICRUSt2
picrust2_pipeline.py -s ~/data/picrust2_prep/take2/DADA2/tanzcol/tanzcol_repseqs.fasta \
-i ~/data/picrust2_prep/take2/filtered/tanzcol/tanzcol_freqfiltabun.biom \
-o ./picrust2take2/tanzcol -p 1

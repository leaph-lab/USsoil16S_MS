library(vegan)
library(MASS)

setwd("C:/Users/shann/Desktop/Research/16s_share/Current_data/MultiCoLa")

M1<-read.table("input.txt",header=TRUE,row.names=1)
M2<-read.csv("MultiCoLa_input2.csv",header=TRUE,row.names=1)
M3<-read.csv("MultiCoLa_input3.csv",header=TRUE,row.names=1)

#1)Obtain a matrix for each taxonomic level + 2 -> 7 levels, so 9 matrices
source("taxa.pooler.1.4.r")
all_taxa_pooled1<-taxa.pooler(M1)
16
5
n
y

all_taxa_pooled2<-taxa.pooler(M2)
618
5
n
y

all_taxa_pooled3<-taxa.pooler(M3)
618
6
n
y


#The output (all_taxa_pooled) is a list of matrices for each taxonomic
#level and two other matrices describing the
#occurrence of each OTU: one for only OTUs with a complete
#annotation and another one with all the OTUs


#2)Application of successive cutoffs on each original matrix
source("COtables.1.4.r")

#truncated.DS.i<-COtables(all_taxa_pooled[[i]], Type="ADS",typem="dominant")
#truncated.DS.OTUs<-COtables(all_taxa_pooled[[9]], Type="ADS",typem="dominant")

#Type = Type of cutoff: all dataset-,”ADS”, or sample-,”SAM”, based;
#typem = choice of the fraction of the matrix to work on: “dominant” types or “rare” types.


#3)Calculation of Spearman (or Pearson, Kendall) correlations and Procrustes correlations between the
#original dataset and the truncated ones
source("cutoff.impact.1.4.r") #automatically calculates truncated datasets
corr.all1<-cutoff.impact(all_taxa_pooled1,Type="ADS",corcoef="spearman",typem="rare")
n
corr.all2<-cutoff.impact(all_taxa_pooled2,Type="ADS",corcoef="spearman",typem="rare")
n
corr.all3<-cutoff.impact(all_taxa_pooled3,Type="ADS",corcoef="spearman",typem="rare")
n

source("cutoff.impact.fig.1.4.r")
output.all1<-cutoff.impact.fig(corr.all1)
output.all2<-cutoff.impact.fig(corr.all2)
output.all3<-cutoff.impact.fig(corr.all3)

save.image("MultiCoLA.RData")


library(vegan)
library(MASS)

setwd("C:/Users/shann/Desktop/Research/16s_share/Current_data/MultiCoLa")

M3<-read.csv("MultiCoLa_input3.csv",header=TRUE,row.names=1)

#1)Obtain a matrix for each taxonomic level + 2 -> 6 levels, so 8 matrices
source("taxa.pooler.1.4.r")
all_taxa_pooled3<-taxa.pooler(M3)
618
6
n
y

#2)Application of successive cutoffs on each original matrix
#Type = Type of cutoff: all dataset-,”ADS”, or sample-,”SAM”, based;
#typem = choice of the fraction of the matrix to work on: “dominant” types or “rare” types.
source("COtables.1.4.r")
#truncated.DS.i<-COtables(all_taxa_pooled[[i]], Type="ADS",typem="dominant")
truncated.DS.i<-COtables(all_taxa_pooled3[[8]], Type="ADS",typem="rare")



#3)Calculation of Spearman (or Pearson, Kendall) correlations and Procrustes correlations between the
#original dataset and the truncated ones
source("cutoff.impact.1.4.r") #automatically calculates truncated datasets
corr.all3<-cutoff.impact(all_taxa_pooled3,Type="ADS",corcoef="spearman",typem="dominant")
n
corr.all3<-cutoff.impact(all_taxa_pooled3,Type="SAM",corcoef="spearman",typem="rare")
n



source("cutoff.impact.fig.1.4.r")
output.all3<-cutoff.impact.fig(corr.all3)
y
n
output.all3<-cutoff.impact.fig(corr.all3)
n
y


save.image("MultiCoLA_6Tax_RData")

library("iCAMP")
library("ape")

setwd("D:/Jingqiu Liao/R_Scripts")


# Pairwise phylogenetic distance matrix
tree<-read.tree("new_rOTU_tree.nwk")
PatristicDistMatrix<-cophenetic(tree)
dis = PatristicDistMatrix
#write.csv(dis, "Modified/OTU_distance_matrix.csv")

# Community matrix
#comm = read.csv("Modified/OTU_rar_trans.csv")
comm=read.csv("OTU_trans.csv")
rownames(comm) <- comm[,1]
comm[,1] <- NULL

# Rare and abundant taxa distances
#dis1 = read.csv("Modified/rOTU_abun_dism.csv")
#dis1 = read.csv("Modified/rOTU_rare_dism.csv")
#dis1=read.csv("df_abun_trans.csv")
# dis1=read.csv("df_rare.csv")
# dis1=read.csv("df_spe.csv")
# dis1=read.csv("df_gen.csv")
#rownames(dis1) <- dis1$OTU_ID
#dis1$OTU_ID <- NULL


# NTI_data = NTI.p(comm, dis=dis, nworker = 16, memo.size.GB = 12, weighted = TRUE,
# 	rand = 1000, check.name = TRUE, output.MNTD = FALSE,
# 	sig.index= "NTI", silent=FALSE)
# 
# write.csv(NTI_data, "NTI_abun.csv",row.names=FALSE)
#write.csv(NTI_data, "NTI_abundant_taxa.csv",row.names=FALSE)
#write.csv(NTI_data, "NTI_rare_taxa.csv",row.names=FALSE)


BNTI_data = bNTIn.p(comm, dis, nworker = 16, memo.size.GB = 12, weighted = TRUE,
 	rand = 1000, output.bMNTD = FALSE, sig.index= "SES", unit.sum = NULL,
 	correct.special = FALSE, detail.null=FALSE, ses.cut=1.96,
 	dirichlet = FALSE)

write.csv(BNTI_data, "BNTI_all.csv",row.names=FALSE)
#write.csv(BNTI_data, "BNTI_abundant_taxa.csv",row.names=FALSE)
#write.csv(BNTI_data, "BNTI_rare_taxa.csv",row.names=FALSE)



# Example
# signmntd = NTI.p(comm = comm, dis = pd, weighted = TRUE,
# 			nworker = 8, sig.index = "all")
# 
# NTI=sigmntd$SES
# CMNTD=sigmntd$Confidence
# RCMNTD=sigmntd$RC


# Sample
# data("example.data")
# comm=example.data$comm
# pd=example.data$pd
# nworker=2 # parallel computing thread number.
# rand.time=4 # usually use 1000 for real data.
# sigmntd=NTI.p(comm=comm, dis=pd, nworker = nworker,
#               weighted = TRUE, rand = rand.time,
#               sig.index="all")
# NTI=sigmntd$SES
# CMNTD=sigmntd$Confidence
# RCMNTD=sigmntd$RC


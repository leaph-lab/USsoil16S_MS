

# Load required library
library(data.table)

# Set the file path
file_path_env <- "../../Input/environ_all.csv"
file_path_bnti = "../../Input/BNTI_all.csv"


env_dat <- fread(file_path_env, header = TRUE)
bnti_dat = fread(file_path_bnti, header = TRUE)

env_names = colnames(env_dat)[-1]

# If you want to set the first column as row names
bnti_dat <- bnti_dat[, -1]
sam_names = colnames(bnti_dat)
bnti_mat = as.matrix(bnti_dat)

n_sam = length(sam_names)
n_var = ncol(env_dat)-1
all_dat = matrix(0, (n_sam^2-n_sam)/2, n_var*2+3)

my_count = 1
for(i in 1:(n_sam-1)){
  for(j in (i+1):n_sam){
    all_dat[my_count,1] = bnti_mat[i,j]
    all_dat[my_count,2] = i
    all_dat[my_count,3] = j
    index_1 = which(env_dat[,1] == sam_names[i])
    index_2 = which(env_dat[,1] == sam_names[j])
    all_dat[my_count, 4:ncol(all_dat)] =c(unlist(as.vector( env_dat[index_1,-1] )), unlist(as.vector( env_dat[index_2,-1] )))
    my_count= my_count+1
  }
}

file_path <- "all_dat.RData"

# Save the matrix to the RData file
save(all_dat, file = file_path)

load("all_dat.RData")

# library(dHSIC)
# index_rnd = which(all_dat[,1]>2 | all_dat[,1]< -2)
# x = all_dat[index_rnd,5]
# y = all_dat[index_rnd,5+n_var]
# dhsic(list(x,y),kernel=c("gaussian","gaussian"))

index_det = which(all_dat[,1]>2 | all_dat[,1]< -2)
pval_det = numeric(n_var)
for(i in 4:(3+n_var) ){
  x = all_dat[index_det,i]
  y = all_dat[index_det,i+n_var]
  cor_test <- cor.test(x, y, alternative = "greater", "spearman")
  pval_det[i-3] = cor_test$p.value
}

pval_det = p.adjust(pval_det, method = "fdr")


index_rnd = which(all_dat[,1]<=2 & all_dat[,1]>= -2)
pval_rnd = numeric(n_var)
for(i in 4:(3+n_var) ){
  x = all_dat[index_rnd,i]
  y = all_dat[index_rnd,i+n_var]
  cor_test <- cor.test(x, y, alternative = "greater")
  pval_rnd[i-3] = cor_test$p.value
}

pval_rnd = p.adjust(pval_rnd, method = "fdr")



# Load required libraries
library(ggplot2)
library(tidyr)

# Assuming you have these vectors already:
# pvalues1 - first vector of p-values
# pvalues2 - second vector of p-values
# env_names - vector of environmental variable names

# Create a data frame
df <- data.frame(
  env = env_names,
  pvalue1 = log(pval_det),
  pvalue2 = -log(pval_rnd)
)

# Create the plot

ggplot(df, aes(x = env)) +
  # Lines for Group 1
  geom_segment(aes(y = 0, yend = pvalue1, xend = env, color = "Deterministic"), 
               linewidth = 0.5) +
  # Points for Group 1
  geom_point(aes(y = pvalue1, color = "Deterministic"), size = 3) +
  # Lines for Group 2
  geom_segment(aes(y = 0, yend = pvalue2, 
                   xend = env, color = "Stochastic"), 
               linewidth = 0.5) +
  # Points for Group 2
  geom_point(aes(y = pvalue2, color = "Stochastic"), 
             size = 3) +
  scale_color_manual(values = c("Deterministic" = "#CD6155", "Stochastic" = "#5499C7"),
                     name = "") +
  labs(y="Adjusted P values (log)")+
  theme_minimal() +
  labs(x = "", 
       title = "Correlations between environmental variables and ecological processes") +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    legend.position = "top"
  ) + geom_hline(yintercept=-4, linetype="dashed", 
                   color = "grey", linewidth=1)



# Save the plot (optional)
ggsave("../output/env_ecological_processes.pdf", dpi=800, width = 8, height = 4)

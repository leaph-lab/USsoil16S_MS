library(devtools)
# install_github("zdk123/SpiecEasi")
library(SpiecEasi)
library(igraph)
library(readxl)
library(ggraph)
library(RColorBrewer)
library(readr)

myargs = commandArgs(trailingOnly=TRUE)

mag <- read_csv(myargs[1], col_types = cols(col_skip()))
mag <- data.matrix(mag)
color_file_path <- myargs[2]
attri <- read_excel(color_file_path, sheet = 1)

se.mb.mag <- spiec.easi(mag, method='mb', lambda.min.ratio=1e-2,
                        nlambda=20, pulsar.params=list(rep.num=50, ncores=8))
ig.mb <- adj2igraph(getRefit(se.mb.mag))
am.coord <- layout.fruchterman.reingold(ig.mb)

ig.mb <- set_vertex_attr(ig.mb, "group", index = V(ig.mb), as.character(attri$Phylum))
E(ig.mb)$weight <- edge.betweenness(ig.mb)

res <- edge_density(ig.mb, loops=F)
print(res)

res <- igraph::degree(ig.mb, mode="in",loops = F)%>%sort(decreasing = TRUE)
print('degree')
print('degree')
print(res)

res <-  igraph::closeness(ig.mb, mode="all")%>%sort(decreasing = TRUE)
print('closeness')
print('closeness')
print(res)

res <-  igraph::betweenness(ig.mb, directed=F)%>%sort(decreasing = TRUE)
print('betweenness')
print('betweenness')
print(res)


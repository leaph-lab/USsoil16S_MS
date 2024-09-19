library(devtools)
#devtools::install_github("zdk123/SpiecEasi")
library(SpiecEasi)
library(igraph)
library(readxl)
library(ggraph)
library(RColorBrewer)
library(readr)

myargs = commandArgs(trailingOnly=TRUE)

mag <- read_csv(myargs[1], col_types = cols(col_skip()))
mag <- data.matrix(mag)
attri <- read_excel(myargs[2], sheet = 1)

se.mb.mag <- spiec.easi(mag, method='mb', lambda.min.ratio=1e-2,
                          nlambda=20, pulsar.params=list(rep.num=50, ncores=8))
ig.mb <- adj2igraph(getRefit(se.mb.mag))
am.coord <- layout.fruchterman.reingold(ig.mb)

ig.mb <- set_vertex_attr(ig.mb, "group", index = V(ig.mb), as.character(attri$Phylum))
E(ig.mb)$weight <- edge.betweenness(ig.mb)

optbeta <- as.matrix(symBeta(getOptBeta(se.mb.mag)))
edge_cols <-  ifelse(optbeta>0, '#F6DDCC', '#D6DBDF')[upper.tri(optbeta) & optbeta!=0]
E(ig.mb)$color=edge_cols

pal <- brewer.pal(12, "Paired")
pal <- colorRampPalette(pal)(length(unique(V(ig.mb)$group)))
group_color <- pal[as.numeric(as.factor(vertex_attr(ig.mb, "group")))]

vsize <- rowMeans(clr(mag, 1))+6

pdf(file = myargs[3], width = 30,  height = 20)

par(mar=c(0,0,0,0))
plot(ig.mb, layout=am.coord, vertex.size=0.1*vsize+2,
     edge.width=(0.005*E(ig.mb)$weight+1)*0.1,
     edge.color=E(ig.mb)$color,
     vertex.label.color = NA,
     vertex.color = group_color,
     vertex.label = NA)

legend('topright', legend = unique(V(ig.mb)$group), col = unique(group_color), 
       pch = 19, bty = "n", title="Phylum",
       pt.cex = 1.5, cex = 0.8, text.col = "black", text.font =3, horiz = FALSE)

legend('bottomright', legend = c('Positive', 'Negative'), col = unique(E(ig.mb)$color), 
       lty = 11, bty = "n", lwd=3, title="Edge", cex=0.8, text.col = "black",  horiz = FALSE)

# Save edge weights to CSV file
write.csv(optbeta, myargs[4])

dev.off()
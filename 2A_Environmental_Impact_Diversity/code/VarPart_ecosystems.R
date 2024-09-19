library(vegan)
library(tidyverse)

env_forest = read.csv("../../Input/VPA/env_VPA_Forest.csv", row.names = 1)
shannon_forest = read.csv("../../Input/VPA/shannon_VPA_Forest.csv", row.names = 1)

env_barren = read.csv("../../Input/VPA/env_VPA_Barren.csv", row.names = 1)
shannon_barren = read.csv("../../Input/VPA/shannon_VPA_Barren.csv", row.names = 1)

env_wetland = read.csv("../../Input/VPA/env_VPA_Wetland.csv", row.names = 1)
shannon_wetland = read.csv("../../Input/VPA/shannon_VPA_Wetland.csv", row.names = 1)

env_shrubland = read.csv("../../Input/VPA/env_VPA_Shrubland.csv", row.names = 1)
shannon_shrubland = read.csv("../../Input/VPA/shannon_VPA_Shrubland.csv", row.names = 1)

env_herbaceous = read.csv("../../Input/VPA/env_VPA_Herbaceous.csv", row.names = 1)
shannon_herbaceous = read.csv("../../Input/VPA/shannon_VPA_Herbaceous.csv", row.names = 1)

env_steppe = read.csv("../../Input/VPA/env_VPA_Steppe.csv", row.names = 1)
shannon_steppe = read.csv("../../Input/VPA/shannon_VPA_Steppe.csv", row.names = 1)

env_lists <- list(
  `Forest and Woodland` = env_forest,
  Barren = env_barren,
  Wetland = env_wetland,
  Shrubland = env_shrubland,
  Herbaceous = env_herbaceous,
  `Steppe and Savanna` = env_steppe
)

shannon_ls <- list(
  `Forest and Woodland` = shannon_forest[,c(1)],
  Barren = shannon_barren[,c(1)],
  Wetland = shannon_wetland[,c(1)],
  Shrubland = shannon_shrubland[,c(1)],
  Herbaceous = shannon_herbaceous[,c(1)],
  `Steppe and Savanna` = shannon_steppe[,c(1)]
)

shannon_colors <- list(
  `Forest and Woodland` = '#45B39D',
  Barren = '#666666',
  Wetland = '#1E90FF',
  Shrubland = '#CD6155',
  Herbaceous = '#A0522D',
  'Steppe and Savanna'  = '#AF7AC5'
)

VarPart <- function(env_lists, shannon_ls, shannon_colors){
  for (shannon in names(shannon_ls)){
    env_ls <- list(
      Geo = env_lists[[shannon]][,c(1:3)],
      Soil = env_lists[[shannon]][,c(4:20)],
      Climate = env_lists[[shannon]][,c(21:24)],
      Landuse = env_lists[[shannon]][,c(25:34)]
    )
    response <- varpart(shannon_ls[[shannon]], env_ls$Geo, env_ls$Soil, env_ls$Climate, env_ls$Landuse)
    pdf(paste0("../output/", shannon, "_VPA.pdf"), width=5, height=5)
    plot(response, digits=2, Xnames = c('Geo', 'Soil', 'Climate', 'Landuse'), bg = c(shannon_colors[[shannon]]))
    title(main = shannon)
    dev.off()
  }
}

VarPart(env_lists, shannon_ls, shannon_colors)

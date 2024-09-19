library(vegan)
library(tidyverse)

df_env_sub = read.csv("../../Input/VPA/env_VPA.csv", row.names = 1)
df_shannon = read.csv("../../Input/VPA/shannon_VPA.csv", row.names = 1)


env_ls <- list(
  Geo = df_env_sub[,c(1:3)],
  Soil = df_env_sub[,c(4:20)],
  Climate = df_env_sub[,c(21:24)],
  Landuse = df_env_sub[,c(25:34)]
)

shannon_ls <- list(
  `All taxa` = df_shannon[,c(1)],
  `Abundant taxa` = df_shannon[,c(2)],
  `Rare taxa` = df_shannon[,c(3)],
  Generalists = df_shannon[,c(4)],
  Specialists = df_shannon[,c(5)]
)

shannon_colors <- list(
  `All taxa` = 'grey',
  `Abundant taxa` = '#5499C7',
  `Rare taxa` = '#D4AC0D',
  Generalists = '#EC7063',
  Specialists = '#45B39D'
)

VarPart <- function(env_ls, shannon_ls, shannon_colors){
  for (shannon in names(shannon_ls)){
    response <- varpart(shannon_ls[[shannon]], env_ls$Geo, env_ls$Soil, env_ls$Climate, env_ls$Landuse)
    pdf(paste0("../output/", shannon, "_VPA.pdf"), width=5, height=5)
    plot(response, digits=2, Xnames = c('Geo', 'Soil', 'Climate', 'Landuse'), bg = c(shannon_colors[[shannon]]))
    title(main = shannon)
    dev.off()
  }
}

VarPart(env_ls, shannon_ls, shannon_colors)

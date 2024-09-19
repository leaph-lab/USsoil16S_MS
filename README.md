# US Soil Microbiome 16S

## Build environment and run Jupyter

```bash
mamba env create --file environment.yml
```

To update the environment, run

```bash
mamba env update --file environment.yml  --prune
```

To run Jupyter, run

```bash
mamba activate leaph-US_soil_microbiome_16s
jupyter lab
```

To deactivate the environment, run

```bash
conda deactivate
```

**Note:** While most analyses in the Jupyter notebooks depend on the latest version of `seaborn` and `pandas`, some require `statannotations` which depends on `seaborn>=0.9.0,<0.12` and `pandas>=0.23.0,<2.0.0`. Please use `environment_stat.yml` to build a new environment for these analyses.

## Following R packages might have to be installed

- vegan (install.packages('vegan'))
- tidyverse (install.packages('tidyverse'))
- hash (install.packages('hash'))
- MASS (install.packages('MASS'))

## Repository structure

Each folder contains the code and output files for each key analysis. Folder Input has the input files for all the key analyses.

## 1. Composition and structure of the US soil microbiome

### 1A. Microbial composition

This section includes analyses:

- alpha and beta diversity distribution
- Correlations among alpha diversity indices
- Correlations among beta diversity indices
- Phylum composition
- Phylogenetic tree

### 1B. Ecosystems

This section includes analyses:

- Ecosystem prevalence
- Abiotic environmental conditions compared among ecosystems
- Shannon diversity compared among ecosystems
- Beta diversity compared among ecosystems
- Taxa (i.e., phylum, class, order, family, genus, species, and OTU) associated with ecosystems

### 1C. Ecotypes

This section includes analyses for four ecotypes (i.e., abundant taxa, rare taxa, generalists, specialists):

- Site distribution of ecotypes
- Number of OTUs representing each ecotype compared among ecosystems
- Proportion of phyla that OTUs representing for each ecotype
- Enrichment analysis at the phylum level

## 2. Influence of environmental factors on microbial diversity

### 2A. Environmental impact on diversity

This section includes analyses for all taxa, each ecotype, and each ecosystem:

- Correlations between environmental variables and Shannon diversity
- VPA analysis quantifying the contributions of environmental factor groups
- Distance decay relationships

### 2B. Machine learning

This section includes machine learning model development to predict Shannon diversity with environmental variables:

- Model performance
- Quantification of feature importance

## 3. Microbial interaction

### 3A. Co-occurrence network

This section includes analyses to construct co-occurrence network for all OTUs and each ecosystem using SpiecEasi.

### 3B. Network metrics analysis

This section includes analyses:

- Network edge weights for all OTUs
- Network comparison (edge weights, node density, closeness, betweenness) among ecosystems
- Network node metrics comparison for ecotypes
- Network node metrics comparison for phyla


## 4. Microbial community assembly

### 4A. Quantification of community assemble processes

This section includes analyses to quantify the importance of stochastic (Drift, Limited dispersal, Homogenizing dispersal) and deterministic (homogenous selection, heterogeneous selection) on the microbial community assembly for all taxa, each ecotype, and each ecosystem.

### 4B. Influence of environmental factors on community assembly

This section includes analyses to quantify the contributions of environmental variables driving community assembly for all taxa, each ecotype, and each ecosystem

## Methods

This section includes analyses:

- Calculation of Shannon and weighted unifrac diversity for microbial ecological groups
- Identification of microbial ecological groups, including abundant taxa, rare taxa, generalists, specialists
- Validation of cutoffs used to classify abundant and rare taxa using MultiCoLa
- Calculation of NTI and betaNTI
- Calculation of RCbray

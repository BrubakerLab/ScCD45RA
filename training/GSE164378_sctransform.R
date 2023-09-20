library(scran)
library(Seurat)
library(RColorBrewer)
library(slingshot)
library(monocle)
library(gam)
library(ggplot2)
library(plyr)
library(MAST)
library(clusterExperiment)
library(monocle3)

# Assuming you have a Seurat object called 'srat'
srat = readRDS('GSE164378_preprocessed.rds')

# Determine how many cells you want after downsampling
desired_num_cells <- 80000 # Let's say you want to downsample to 80,000 cells

# Randomly select cells
set.seed(123) # Set a seed for reproducibility
cells_to_keep <- sample(Cells(srat), size = desired_num_cells)

# Subset Seurat object to only keep the randomly selected cells
srat_downsampled <- subset(srat, cells = cells_to_keep)
saveRDS(srat_downsampled,'srat_downsampled.rds')

srat = readRDS('srat_downsampled.rds')
srat = SCTransform(object = srat, n_cells = 8000, min_cells = 0, verbose = FALSE, vst.flavor = "v2", vars.to.regress = c("S_G2M_diff","mt_frac")) 
saveRDS(srat,'srat_downsampled_stablized.rds')

srat = RunPCA(srat, verbose = FALSE)
HVG = VariableFeatures(srat)

mat <- Seurat::GetAssayData(object = srat, slot = 'scale.data')
pca <- srat[["pca"]]

# Get the total variance:
total_variance <- sum(matrixStats::rowVars(mat))

eigValues = (pca@stdev)^2  ## EigenValues
varExplained = eigValues / total_variance

PCs = Loadings(srat, reduction = "pca")
X_pca =pca@cell.embeddings

counts = srat[["SCT"]]@counts
logcounts = srat[["SCT"]]@data
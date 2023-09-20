library(Seurat)
library(SeuratDisk)
library(ggplot2)
library(patchwork)

reference <- LoadH5Seurat("data/pbmc_multimodal.h5seurat")
srat <- readRDS('GSE144434.rds') #GSE150132.rds)
srat =   SCTransform(srat, verbose = FALSE)
anchors <- FindTransferAnchors(
  reference = reference,
  query = srat,
  normalization.method = "SCT",
  reference.reduction = "spca",
  dims = 1:50
)
srat <- MapQuery(
  anchorset = anchors,
  query = srat,
  reference = reference,
  refdata = list(
    celltype.l1 = "celltype.l1",
    celltype.l2 = "celltype.l2",
    predicted_ADT = "ADT"
  ),
  reference.reduction = "spca", 
  reduction.model = "wnn.umap"
)
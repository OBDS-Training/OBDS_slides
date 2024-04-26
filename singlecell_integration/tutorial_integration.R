library(Seurat)
library(SeuratData)
library(SeuratWrappers)
library(Azimuth)
library(ggplot2)
library(patchwork)
options(future.globals.maxSize = 1e9)

# load in the pbmc systematic comparative analysis dataset
obj <- LoadData("pbmcsca")
obj <- subset(obj, nFeature_RNA > 1000)
obj <- RunAzimuth(obj, reference = "pbmcref")
# currently, the object has two layers in the RNA assay: counts, and data
obj

obj[["RNA"]] <- split(obj[["RNA"]], f = obj$Method)
obj

obj <- NormalizeData(obj)
obj <- FindVariableFeatures(obj)
obj <- ScaleData(obj)
obj <- RunPCA(obj)

obj <- FindNeighbors(obj, dims = 1:30, reduction = "pca")
obj <- FindClusters(obj, resolution = 2, cluster.name = "unintegrated_clusters")

obj <- RunUMAP(obj, dims = 1:30, reduction = "pca", reduction.name = "umap.unintegrated")
# visualize by batch and cell type annotation
# cell type annotations were previously added by Azimuth
DimPlot(obj, reduction = "umap.unintegrated", group.by = c("Method", "predicted.celltype.l2"))

obj <- IntegrateLayers(
  object = obj, method = CCAIntegration,
  orig.reduction = "pca", new.reduction = "integrated.cca",
  verbose = FALSE
)

## skip

obj <- JoinLayers(obj)
obj

obj[["RNA"]] <- split(obj[["RNA"]], f = obj$Method)

options(future.globals.maxSize = 3e+09)
obj <- SCTransform(obj)
obj <- RunPCA(obj, npcs = 30, verbose = F)
obj2 <- IntegrateLayers( # still fails
  object = obj,
  method = RPCAIntegration,
  normalization.method = "SCT",
  verbose = F
)
obj2 <- RPCAIntegration(object = obj, assay = "SCT", layers = "data", scale.layer = "scale.data", features = VariableFeatures(obj))

obj <- FindNeighbors(obj, dims = 1:30, reduction = "integrated.dr")
obj <- FindClusters(obj, resolution = 2)

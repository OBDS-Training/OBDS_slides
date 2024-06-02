library(Seurat)
library(SeuratWrappers)
library(patchwork)
library(ggplot2)

pbmv1 <- readRDS("data/pbmcv1_filtered.rds")
pbmv2 <- readRDS("data/pbmcv2_filtered.rds")
pbmc <- merge(pbmv1, pbmv2)
# table(pbmc$orig.ident)
# hist(pbmc$nFeature_RNA, 100)
# Layers(pbmc)
# pbmc <- JoinLayers(pbmc, layers = Layers(pbmc))

# Based on https://satijalab.org/seurat/articles/seurat5_integration

## Layers in the Seurat v5 object

obj <- pbmc
# obj[["RNA"]] <- split(obj[["RNA"]], f = obj$orig.ident)
obj <- NormalizeData(obj)
obj <- FindVariableFeatures(obj)
obj <- ScaleData(obj)
obj <- RunPCA(obj)
obj <- FindNeighbors(obj, dims = 1:30, reduction = "pca")
obj <- FindClusters(obj, resolution = 2, cluster.name = "unintegrated_clusters")
obj <- RunUMAP(obj, dims = 1:30, reduction = "pca", reduction.name = "umap.unintegrated")
# visualize by batch and cell type annotation
# cell type annotations were previously added by Azimuth
DimPlot(obj, reduction = "umap.unintegrated", group.by = c("orig.ident"))

## Perform streamlined (one-line) integrative analysis

obj <- IntegrateLayers(
  object = obj, method = CCAIntegration,
  orig.reduction = "pca", new.reduction = "integrated.cca",
  verbose = FALSE
)

obj <- IntegrateLayers(
  object = obj, method = RPCAIntegration,
  orig.reduction = "pca", new.reduction = "integrated.rpca",
  verbose = FALSE
)

obj <- IntegrateLayers(
  object = obj, method = HarmonyIntegration,
  orig.reduction = "pca", new.reduction = "harmony",
  verbose = FALSE
)

# Requires SeuratWrappers package
obj <- IntegrateLayers(
  object = obj, method = FastMNNIntegration,
  new.reduction = "integrated.mnn",
  verbose = FALSE
)

## TODO: install a conda environment on the OBDS cluster
## - Install miniforge (https://github.com/conda-forge/miniforge)
## - Activate Conda 'base' environment
## - Create Conda environment
obj <- IntegrateLayers(
  object = obj, method = scVIIntegration,
  new.reduction = "integrated.scvi",
  conda_env = "/Users/kevin/miniforge3/envs/scvi-env", verbose = FALSE
)

obj <- FindNeighbors(obj, reduction = "integrated.cca", dims = 1:30)
obj <- FindClusters(obj, resolution = 2, cluster.name = "cca_clusters")
obj <- RunUMAP(obj, reduction = "integrated.cca", dims = 1:30, reduction.name = "umap.cca")
p1 <- DimPlot(
  obj,
  reduction = "umap.cca",
  group.by = c("orig.ident", "cca_clusters"),
  combine = FALSE, label.size = 2
)

## TODO: requires scVIIntegration above
# obj <- FindNeighbors(obj, reduction = "integrated.scvi", dims = 1:30)
# obj <- FindClusters(obj, resolution = 2, cluster.name = "scvi_clusters")
# obj <- RunUMAP(obj, reduction = "integrated.scvi", dims = 1:30, reduction.name = "umap.scvi")
# p2 <- DimPlot(
#   obj,
#   reduction = "umap.scvi",
#   group.by = c("Method", "predicted.celltype.l2", "scvi_clusters"),
#   combine = FALSE, label.size = 2
# )

## Alternative
obj <- FindNeighbors(obj, reduction = "integrated.mnn", dims = 1:30)
obj <- FindClusters(obj, resolution = 2, cluster.name = "mnn_clusters")
obj <- RunUMAP(obj, reduction = "integrated.mnn", dims = 1:30, reduction.name = "umap.mnn")
p2 <- DimPlot(
  obj,
  reduction = "umap.mnn",
  group.by = c("orig.ident", "mnn_clusters"),
  combine = FALSE, label.size = 2
)

wrap_plots(c(p1, p2), ncol = 2, byrow = F)

p1 <- VlnPlot(
  obj,
  features = "rna_CD8A", group.by = "unintegrated_clusters"
) + NoLegend() + ggtitle("CD8A - Unintegrated Clusters")
p2 <- VlnPlot(
  obj, "rna_CD8A",
  group.by = "cca_clusters"
) + NoLegend() + ggtitle("CD8A - CCA Clusters")
p3 <- VlnPlot(
  obj, "rna_CD8A",
  group.by = "mnn_clusters"
) + NoLegend() + ggtitle("CD8A - MNN Clusters")
p1 | p2 | p3

obj <- RunUMAP(obj, reduction = "integrated.rpca", dims = 1:30, reduction.name = "umap.rpca")
p4 <- DimPlot(obj, reduction = "umap.unintegrated", group.by = c("cca_clusters"))
p5 <- DimPlot(obj, reduction = "umap.rpca", group.by = c("cca_clusters"))
p6 <- DimPlot(obj, reduction = "umap.mnn", group.by = c("cca_clusters"))
p4 | p5 | p6

obj <- JoinLayers(obj)
obj

# SCT

options(future.globals.maxSize = 3e+09)
obj <- SCTransform(obj)
obj <- RunPCA(obj, npcs = 30, verbose = F)
obj <- IntegrateLayers( # fails
  object = obj,
  method = RPCAIntegration,
  normalization.method = "SCT",
  verbose = F
)
obj <- FindNeighbors(obj, dims = 1:30, reduction = "integrated.dr")
obj <- FindClusters(obj, resolution = 2)

# SCT v4

# integrate datasets
obj <- SCTransform(obj)
obj <- RunPCA(obj)
obj <- RunUMAP(obj, dims = 1:30)
# obj <- IntegrateLayers(object = obj, method = CCAIntegration,
#   orig.reduction = "pca", new.reduction = "integrated.cca",
#   assay = "SCT", verbose = FALSE)

anchors <- FindIntegrationAnchors(object.list = SplitObject(obj, split.by = "orig.ident"))
integrated <- IntegrateData(anchorset = anchors)

features_for_integration <- SelectIntegrationFeatures(
  object.list = SplitObject(obj, split.by = "orig.ident"),
  nfeatures = 3000
)
length(features_for_integration)

anchors_for_integration <- FindIntegrationAnchors(
  object.list = SplitObject(obj, split.by = "orig.ident"),
  anchor.features = features_for_integration,
  normalization.method = "SCT",
  dims = 1:30,
  reduction = "cca"
)
anchors_for_integration
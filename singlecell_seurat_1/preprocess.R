library(Seurat)
library(ggplot2)

# Read10X ----

read10x_data <- Read10X(
    data.dir = "data/10x_pbmc1k_v3/filtered_feature_bc_matrix"
)

# CreateSeuratObject ----

seurat_object <- CreateSeuratObject(
    counts = read10x_data,
    project = "pbmc5k",
    min.cells = 3,
    min.features = 200
)

# PercentageFeatureSet ----

seurat_object[["percent_mt"]] <- PercentageFeatureSet(
    seurat_object, pattern = "^MT-")

# subset ----

seurat_object <- subset(
    x = seurat_object,
    subset = nCount_RNA > 4500 & percent_mt < 15 & nFeature_RNA > 1500
)

# NormalizeData ----

seurat_object <- NormalizeData(
    object = seurat_object,
    normalization.method = "LogNormalize"
)

# FindVariableFeatures ----

seurat_object <- FindVariableFeatures(seurat_object, selection.method = "vst", nfeatures = 2000)

# ScaleData ----

seurat_object <- ScaleData(seurat_object)

# RunPCA ----

seurat_object <- RunPCA(seurat_object, features = VariableFeatures(object = seurat_object))

# RunUMAP ----

seurat_object <- RunUMAP(seurat_object, dims = 1:10)

# FindNeighbors ----

seurat_object <- FindNeighbors(seurat_object, dims = 1:10)

# FindClusters ----

seurat_object <- FindClusters(seurat_object, resolution = 0.3)

# FindAllMarkers ----

seurat_markers_all <- FindAllMarkers(
    seurat_object,
    only.pos = TRUE,
    min.pct = 0.25,
    logfc.threshold = 0.25
)

library(Seurat)
library(ggplot2)

# Read10X ----

read10x_data <- Read10X(
    data.dir = "data/filtered_feature_bc_matrix"
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

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

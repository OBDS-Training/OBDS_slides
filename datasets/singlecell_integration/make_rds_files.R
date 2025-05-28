library(Seurat)

## v2

read10x_data <- Read10X(
  data.dir = "v2/filtered_feature_bc_matrix"
)

seurat_object <- CreateSeuratObject(
  counts = read10x_data[["Gene Expression"]],
  project = "v2",
  min.cells = 3,
  min.features = 200
)

seurat_object <- AddMetaData(
  object = seurat_object,
  metadata = PercentageFeatureSet(seurat_object, pattern = "^MT-"),
  col.name = "percent_mt"
)

seurat_after_qc <- subset(
  x = seurat_object,
  subset = nCount_RNA > 1500 & percent_mt < 10 & nFeature_RNA > 750
)

saveRDS(seurat_after_qc, "pbmcv2_filtered.rds")

## v3

read10x_data <- Read10X(
  data.dir = "v3/filtered_feature_bc_matrix"
)

seurat_object <- CreateSeuratObject(
  counts = read10x_data,
  project = "v3",
  min.cells = 3,
  min.features = 200
)

seurat_object <- AddMetaData(
  object = seurat_object,
  metadata = PercentageFeatureSet(seurat_object, pattern = "^MT-"),
  col.name = "percent_mt"
)

seurat_after_qc <- subset(
  x = seurat_object,
  subset = nCount_RNA > 1500 & percent_mt < 10 & nFeature_RNA > 750
)

saveRDS(seurat_after_qc, "pbmcv3_filtered.rds")

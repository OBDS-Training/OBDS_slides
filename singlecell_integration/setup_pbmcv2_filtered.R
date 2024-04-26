library(Seurat)

read10x_data <- Read10X(
  data.dir = "data/../10x_pbmc1k_v2/filtered_feature_bc_matrix"
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
  subset = nCount_RNA > 2500 & percent_mt < 10 & nFeature_RNA > 1000
)

saveRDS(seurat_after_qc, "data/pbmcv2_filtered.rds")

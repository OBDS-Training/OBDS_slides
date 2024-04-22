library(Seurat)

read10x_data <- Read10X(
  data.dir = "data/10x_pbmc5k_nextgem/filtered_feature_bc_matrix"
)

seurat_object <- CreateSeuratObject(
  counts = read10x_data,
  project = "pbmc5k",
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
  subset = nCount_RNA > 4500 & percent_mt < 15 & nFeature_RNA > 1500
)

seurat_after_qc <- NormalizeData(
  object = seurat_after_qc,
  normalization.method = "LogNormalize"
)

seurat_after_qc <- FindVariableFeatures(
  object = seurat_after_qc
)

seurat_after_qc <- ScaleData(
  object = seurat_after_qc,
  vars.to.regress = "percent_mt"
)

seurat_after_qc <- RunPCA(seurat_after_qc)

seurat_after_qc <- RunUMAP(seurat_after_qc, dims = 1:20)

seurat_after_qc <- FindNeighbors(seurat_after_qc, dims = 1:20)

seurat_after_qc <- FindClusters(seurat_after_qc, resolution = 0.5)

saveRDS(seurat_after_qc, "data/seurat_after_qc.rds")

library(Seurat)
library(ggplot2)
library(cowplot)

seurat_after_qc <- readRDS("data/seurat_after_qc.rds")

umap_lognorm <- UMAPPlot(
  object = seurat_after_qc,
  dims = 1:2,
  label = TRUE,
  pt.size = 1.5,
  group.by = "RNA_snn_res.0.5"
)

seurat_after_qc <- SCTransform(
  object = seurat_after_qc,
  vars.to.regress = "percent_mt"
)

seurat_after_qc <- RunPCA(seurat_after_qc, reduction.name = "pca_sct")
seurat_after_qc <- RunUMAP(seurat_after_qc, reduction = "pca_sct", reduction.name = "umap_sct", dims = 1:20)
seurat_after_qc <- FindNeighbors(seurat_after_qc, reduction = "pca_sct", dims = 1:20)
seurat_after_qc <- FindClusters(seurat_after_qc, resolution = 0.5, reduction = "pca_sct")

umap_sct <- DimPlot(
    object = seurat_after_qc,
    reduction = "umap_sct",
    dims = 1:2,
    label = TRUE,
    pt.size = 1.5,
    group.by = "SCT_snn_res.0.5"
  )

umap_cowplot <- cowplot::plot_grid(umap_lognorm, umap_sct, nrow = 1)

ggsave2("img/umap_lognorm_vs_sct.png", umap_cowplot, width = 10, height = 5, dpi = 300)


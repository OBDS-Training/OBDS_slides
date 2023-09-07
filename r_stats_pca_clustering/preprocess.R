data("airway")
airway$dex <- relevel(airway$dex, "untrt")

airway <- as(airway, "SingleCellExperiment")

airway <- scater::logNormCounts(x = airway)

pca_use_rows <- assay(airway, "logcounts") %>% 
  rowVars() %>% 
  order(decreasing = TRUE) %>% 
  head(500)

airway_pca <- prcomp(t(assay(airway, "logcounts")[pca_use_rows, ]), 8)
reducedDim(airway, "PCA") <- airway_pca$x

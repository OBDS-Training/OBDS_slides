data("airway")
airway$dex <- relevel(airway$dex, "untrt")

airway <- as(airway, "SingleCellExperiment")

airway <- scater::logNormCounts(x = airway)
reducedDim(airway, "PCA") <- prcomp(t(assay(airway, "logcounts")), 8)$x

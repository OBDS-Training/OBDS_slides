library(tidyverse)
library(matrixStats)

output_data_dir <- here::here("r_dimensionality_reduction_and_clustering/data")

# Prepare output folder
dir.create(output_data_dir)

# SC ----

# Read full normalised matrix
mat <- read.csv(here::here("data/aulicino/logcount_matrix.txt"), header = TRUE, sep = "\t")
mat <- as.matrix(mat)

# Re-export gene information
gene_metadata <- read.csv(here::here("data/aulicino/gene_metadata.txt"), header = TRUE, sep = "\t")
gene_subset_metadata <- gene_metadata[rownames(mat), c("gene_id", "gene_name")]
write.csv(gene_subset_metadata, file.path(output_data_dir, "gene_metadata.csv"), row.names = FALSE, quote = FALSE)

# Read cell metadata
# Subset cells and metadata
cell_metadata <- read.csv(here::here("data/aulicino/cell_metadata.txt"), header = TRUE, sep = "\t")
cell_metadata <- cell_metadata[colnames(mat), ]
write.csv(cell_metadata, file.path(output_data_dir, "cell_metadata.csv"), row.names = FALSE, quote = FALSE)

# Subset genes
row_order <- head(order(rowVars(mat), decreasing = TRUE), 1000)
mat <- mat[row_order, ]
write.csv(mat, file.path(output_data_dir, "logcounts.csv"), quote = FALSE)

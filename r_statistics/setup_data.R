library(tidyverse)
library(matrixStats)

# SC ----

# Read full normalised matrix
mat <- read.csv("../data/aulicino/logcount_matrix.txt", header = TRUE, sep = "\t")
mat <- as.matrix(mat)

# Re-export gene information
gene_metadata <- read.csv("../data/aulicino/gene_metadata.txt", header = TRUE, sep = "\t")
gene_subset_metadata <- gene_metadata[rownames(mat), c("gene_id", "gene_name")]
write.csv(gene_subset_metadata, "data/gene_metadata.csv", row.names = FALSE, quote = FALSE)

# Read cell metadata
# Subset cells and metadata
cell_metadata <- read.csv("../data/aulicino/cell_metadata.txt", header = TRUE, sep = "\t")
cell_metadata <- cell_metadata[colnames(mat), ]
cell_subset_metadata <- subset(cell_metadata, Time == "6h" & Infection %in% c("Mock", "STM-LT2") & Status %in% c("Uninfected", "Infected"), c("Sample", "Infection"))
write.csv(cell_subset_metadata, "data/cell_metadata.csv", row.names = FALSE, quote = FALSE)

mat <- mat[, cell_subset_metadata$Sample]

# Subset genes
row_order <- head(order(rowVars(mat), decreasing = TRUE), 1000)
mat <- mat[row_order, ]
write.csv(mat, "data/logcounts.csv", quote = FALSE)

# GO:gene mapping ----

library(biomaRt)
mart <- useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl")

# subset to biological processes associated with genes in the universe
out <- getBM(attributes = c("ensembl_gene_id", "go_id", "namespace_1003"), filters = "ensembl_gene_id", values = gene_metadata$gene_id, mart = mart)
out2 <- out %>% 
  filter(namespace_1003 == "biological_process" & go_id != "") %>% 
  unique()

# subset to gene sets with 10 to 100 genes in the universe
keep_go <- out2 %>% 
  group_by(go_id) %>% 
  summarise(n = n(), .groups = "keep") %>% 
  filter(n >= 10 & n <= 100) %>% 
  ungroup() %>% 
  pull(go_id)

gene_go_bp_subset <- subset(out2, go_id %in% keep_go, c("ensembl_gene_id", "go_id"))
write.csv(gene_go_bp_subset, "data/human_go_bp.csv", quote = FALSE, row.names = FALSE)

# GO definitions ----

library(GO.db)
# columns(GO.db)

go_subset <- AnnotationDbi::select(GO.db, keys = unique(gene_go_bp_subset$go_id), columns = c("GOID", "TERM"))
write.csv(go_subset, "data/go_info.csv", quote = TRUE, row.names = FALSE)

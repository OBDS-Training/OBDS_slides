library(ExperimentHub)

ehub <- ExperimentHub()
eh2011 <- ehub[["EH2011"]]

# eh2011

library(xlsx)

exprs <- assay(eh2011, "exprs")
exprs <- exprs[order(rowVars(exprs), decreasing = TRUE), ]
exprs <- head(exprs, 1000)
exprs <- round(exprs, digits = 3)
exprs <- data.frame(
    gene = rownames(exprs),
    exprs
)
# View(exprs)

write.xlsx(exprs, "eh2011.full.xlsx", "exprs", row.names = FALSE)

sample_data <- colData(eh2011)
# head(sample_data)

write.xlsx(sample_data, "eh2011.full.xlsx", "sample_info", row.names = FALSE, append = TRUE)

gene_data <- rowData(eh2011)
write.xlsx(gene_data, "eh2011.full.xlsx", "gene_info", row.names = FALSE, append = TRUE)

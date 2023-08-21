library("airway")
library("DESeq2")

data("airway")
airway$dex <- relevel(airway$dex, "untrt")

dds <- DESeqDataSet(airway, ~ 0 + dex + cell)

dds <- DESeq(dds)
deseq2_res <- results(dds, contrast = list("dextrt", "dexuntrt"))
# head(deseq2_res)


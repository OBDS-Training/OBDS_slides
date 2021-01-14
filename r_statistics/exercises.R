library(tidyverse)
library(ggplot2)
library(cowplot)

# Generate distributions ----

x <- rnorm(n = 1000, mean = 10, sd = 5)

summary(x)

mean(x)
sd(x)

quantile(x = x, probs = seq(0, 1, 0.1))

x_df <- tibble(value = x)

ggplot() +
  geom_histogram(aes(value), x_df, color = "black", fill = "grey")

ggplot() +
  geom_histogram(aes(value), x_df, color = "black", fill = "grey") +
  geom_vline(xintercept = mean(x), color = "red") +
  geom_vline(xintercept = mean(x) + sd(x) * c(-1, 1), color = "blue", linetype = "dashed") +
  geom_vline(xintercept = mean(x) + mad(x) * c(-1, 1), color = "green", linetype = "dashed")

x_million <- rnorm(n = 1E6, mean = 10, sd = 5)

ggplot() +
  geom_histogram(aes(value), tibble(value = x_million), color = "black", fill = "grey")

# Query distribution ----

x <- tibble(
  quantile = seq(from = -5, to = 5, by = 0.01),
  pnorm = pnorm(q = quantile, mean = 0, sd = 1)
)
ggplot(x) +
  geom_point(aes(quantile, pnorm))


x <- tibble(
  quantile = seq(from = 0, to = 1, by = 0.01),
  qnorm = qnorm(p = quantile, mean = 0, sd = 1)
)
ggplot(x) +
  geom_point(aes(quantile, qnorm))

x <- tibble(
  quantile = seq(from = -5, to = 5, by = 0.01),
  dnorm = dnorm(x = quantile, mean = 0, sd = 1)
)
ggplot(x) +
  geom_point(aes(quantile, dnorm))

1 - pnorm(q = 2, mean = 0, sd = 1)

pnorm(q = 2, mean = 0, sd = 1) - pnorm(q = -2, mean = 0, sd = 1)

1 - (pnorm(q = 2, mean = 0, sd = 1) - pnorm(q = -2, mean = 0, sd = 1))
  
# Empirical cumulative distribution function ----

out <- ecdf(iris$Sepal.Length)

plot(out)

knots(out)
sort(unique(iris$Sepal.Length))

# ANOVA ----

summary(iris)

ggplot(iris, aes(Sepal.Length)) +
  geom_density() +
  cowplot::theme_cowplot()

ggplot(iris, aes(Sepal.Length)) +
  geom_density(aes(color = Species)) +
  cowplot::theme_cowplot()

shapiro.test(iris$Sepal.Length)

shapiro.test(iris$Sepal.Length[iris$Species == "setosa"])
shapiro.test(iris$Sepal.Length[iris$Species == "versicolor"])
shapiro.test(iris$Sepal.Length[iris$Species == "virginica"])

out <- aov(Sepal.Length ~ Species, data = iris)
summary(out)

# Linear regression ----

ggplot(ChickWeight, aes(Time, weight, color = as.factor(Diet))) +
  geom_smooth(formula = y ~ x, method = "lm") +
  geom_point()

out <- lm(weight ~ Time * Diet, ChickWeight)
summary(out)

ChickWeight$Diet <- relevel(ChickWeight$Diet, "3")
out <- lm(weight ~ Time * Diet, ChickWeight)
summary(out)

ggplot(ChickWeight, aes(Time, weight, color = as.factor(Diet))) +
  geom_smooth(formula = y ~ x, method = "lm") +
  geom_point() +
  geom_abline(intercept = 18.2503, slope = 11.4229)

# Multiple testing correction ----

mat <- read.csv("data/logcounts.csv", row.names = 1)
dim(mat)

cell_data <- read.csv("data/cell_metadata.csv")
rownames(cell_data) <- cell_data$Sample
cell_data <- cell_data[colnames(mat), ]
head(cell_data)

test_row <- function(index, matrix) {
  test_data <- data.frame(
    value = as.numeric(mat[index, ]),
    group = cell_data$Infection
  )
  out <- wilcox.test(value ~ group, test_data)
  out$p.value
}

result_pvalues <- vapply(
  X = seq_len(nrow(mat)), FUN = test_row, FUN.VALUE = numeric(1), matrix = mat)
names(result_pvalues) <- rownames(mat)
hist(result_pvalues, breaks = 100)

result_bh <- p.adjust(result_pvalues, method = "BH")
hist(result_bh, breaks = 100)

table(result_bh < 0.05)

# Over-Representation Analysis ----

go_table <- read.csv("data/human_go_bp.csv")
go_list <- split(go_table$ensembl_gene_id, go_table$go_id)

gene_data <- read.csv("data/gene_metadata.csv")

test_geneset <- function(geneset, query, universe) {
  geneset <- intersect(geneset, universe)
  query <- intersect(query, universe)
  cross_table <- tibble(
    gene_id = universe,
    x = factor(universe %in% geneset, c(TRUE, FALSE)),
    query = factor(universe %in% query, c(TRUE, FALSE)),
  )
  test_table <- table(cross_table$x, cross_table$query)
  if (sum(test_table[1, ]) < 10) {
    return(NA)
  }
  pvalue <- fisher.test(test_table)$p.value
  pvalue
}

de_genes <- names(result_bh)[result_bh < 0.05]
go_pvalues <- vapply(X = go_list, FUN = test_geneset, FUN.VALUE = numeric(1), query = de_genes, universe = gene_data$gene_id)

go_bh <- p.adjust(go_pvalues, method = "BH")
hist(go_bh, breaks = 100)
ggplot(tibble(p.value = go_bh), aes(p.value)) +
  geom_histogram(bins = 20, fill = "grey", color = " black") +
  scale_y_log10() +
  scale_x_continuous(limit = c(0, 1))

table(go_bh < 0.05)

go_info <- read.csv("data/go_info.csv")
rownames(go_info) <- go_info$GOID

View(go_info[names(sort(go_bh)), ])

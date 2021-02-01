library(tidyverse)
library(cowplot)
library(reshape2)
library(Rtsne)

# PCA ----

mat <- read.csv("data/logcounts.csv", row.names = 1)
dim(mat)

prcomp_out <- prcomp(x = t(mat), scale. = TRUE)

cell_data <- read.csv("data/cell_metadata.csv", row.names = 1)
head(cell_data)

plot_data <- bind_cols(
  sample = rownames(prcomp_out$x),
  cell_data,
  prcomp_out$x %>% as_tibble() %>% dplyr::select(PC1, PC2)
)

gg_pca <- ggplot(plot_data) +
  geom_point(aes(PC1, PC2, color = Time)) +
  theme_cowplot()
ggplot(plot_data) +
  geom_point(aes(PC1, PC2, color = Infection)) +
  theme_cowplot()
ggplot(plot_data) +
  geom_point(aes(PC1, PC2, color = Status)) +
  theme_cowplot()

# Choose number of PC ----

scree_table <- tibble(
  PC = seq_along(prcomp_out$sdev),
  sdev = prcomp_out$sdev,
  # PC = 1:length(prcomp_out$sdev),
  percent_var = sdev^2 / sum(sdev^2),
  var_cumsum = cumsum(percent_var)
)

scree_table %>% 
  head(50) %>% 
  ggplot(aes(PC, percent_var)) +
  geom_col(fill = "grey") +
  geom_point() +
  scale_x_continuous(breaks = seq_along(scree_table$PC)) +
  labs(y = "% Variance explained", title = "Percentage of Variance Explained") +
  theme_cowplot()

ggplot(head(scree_table, 200), aes(PC, var_cumsum)) +
  geom_line() + geom_point() +
  geom_hline(yintercept = 0.9) +
  scale_x_continuous(breaks = seq_along(scree_table$PC)) +
  labs(y = "Cumulative % Variance explained", title = "Cumulative Percentage of Variance Explained") +
  theme_cowplot() +
  theme(axis.text.x = element_text(size=rel(0.5)))

# Identify the groups of cells best separated by the top PC ----

plot_data <- bind_cols(
  sample = rownames(prcomp_out$x),
  cell_data,
  prcomp_out$x %>% as_tibble() %>% dplyr::select(PC1)
)

ggplot(plot_data) +
  geom_density(aes(PC1, fill = Status), color = "black", alpha = 0.5) +
  facet_grid(Time~Infection) +
  theme_cowplot()
  
# Identify top genes for a given PC ----

prcomp_out$rotation %>%
  melt(varnames = c("gene", "PC"), value.name = "loading") %>% 
  as_tibble() %>% 
  filter(PC == "PC1") %>% 
  mutate(loading_abs = abs(loading)) %>% 
  top_n(n = 20, wt = loading_abs) %>% 
  arrange(desc(loading_abs))

# Visualise expression of top genes for given PC ----

plot_data <- bind_cols(
  gene = as.numeric(mat["ENSG00000172183", ]),
  cell_data,
  prcomp_out$x %>% as_tibble() %>% dplyr::select(PC1, PC2)
)

ggplot(plot_data) +
  geom_point(aes(PC1, PC2, color = gene)) +
  theme_cowplot()

# Run t-SNE ----

# Handle duplicates
# prcomp_out$x <- prcomp_out$x + rnorm(prod(dim(prcomp_out$x)), 0, 1E-6)

tsne_out <- Rtsne(prcomp_out$x[, 1:25])

# Visualise t-SNE ----

tsne_data <- tsne_out$Y
colnames(tsne_data) <- paste0("TSNE", 1:2)

tsne_plot_data <- bind_cols(
  sample = rownames(prcomp_out$x),
  cell_data[rownames(prcomp_out$x), ] %>% as_tibble(),
  tsne_out$Y %>% as_tibble()
)

gg_tsne <- ggplot(tsne_plot_data, aes(V1, V2, color = Time)) +
  geom_point() +
  labs(x = "t-SNE 1", y = "t-SNE 2") +
  theme_cowplot()

plot_grid(gg_pca, gg_tsne)

# Compute UMAP ----

library(umap)
umap_out <- umap(d = prcomp_out$x[, 1:25])

# Visualise UMAP ----

umap_plot_data <- bind_cols(
  sample = rownames(prcomp_out$x),
  cell_data[rownames(prcomp_out$x), ] %>% as_tibble(),
  umap_out$layout %>% as_tibble()
)

gg_umap <- ggplot(umap_plot_data, aes(V1, V2, color = Time)) +
  geom_point() +
  labs(x = "UMAP 1", y = "UMAP 2") +
  theme_cowplot()

plot_grid(
  gg_pca + guides(color = "none"),
  gg_tsne + guides(color = "none"),
  gg_umap + guides(color = "none"))

# k-means clustering ----

kmeans_scree <- lapply(seq_len(30), function(x) {
  out <- kmeans(x = prcomp_out$x[, 1:25], centers = x)
  tibble(
    k = x,
    totss = out$totss,
    betweenss = out$betweenss,
    withinss_sum = sum(out$withinss)
  )
}) %>% 
  bind_rows()

# How many clusters? ----

kmeans_scree %>% 
  ggplot(aes(k, withinss_sum)) +
  geom_line(linetype = "F1") +
  geom_point() +
  labs(title = "sum(withinss)") +
  cowplot::theme_cowplot()

# Visualise clusters on t-SNE, compare to known labels ----

tsne_plot_data <- tsne_plot_data %>% 
  mutate(kmeans = as.factor(kmeans(x = prcomp_out$x, centers = 4)$cluster))

gg_kmean <- ggplot() +
  geom_point(aes(V1, V2, color = kmeans), tsne_plot_data) +
  labs(x = "t-SNE 1", y = "t-SNE 2") +
  theme_cowplot()

plot_grid(gg_tsne, gg_kmean)

table(tsne_plot_data$Time, tsne_plot_data$kmeans)

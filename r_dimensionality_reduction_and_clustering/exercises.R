library(tidyverse)
library(cowplot)
library(reshape2)
library(Rtsne)

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

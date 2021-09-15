BiocManager::install("BiocPkgTools")
BiocManager::install("visNetwork")
library(BiocPkgTools)
library(visNetwork)
library(igraph)
g = buildPkgDependencyIgraph(buildPkgDependencyDataFrame())
g2 = subgraphByDegree(g, 'GEOquery')
visIgraph(g2, smooth = TRUE, layout = "layout_nicely")
# layout_with_sugiyama
# layout_with_mds
# layout_with_lgl
# layout_with_kk
# layout_with_graphopt
# layout_with_gem
# layout_with_fr
# layout_with_dh
# layout_randomly
# layout_on_grid
# layout_nicely
# layout_in_circle
# layout_as_tree
# layout_as_star
# layout_as_bipartite
# attributes(g2)
# ?layout_nicely
# str(E(g2))

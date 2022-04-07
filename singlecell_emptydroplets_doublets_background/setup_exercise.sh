#################
# Configuration #
#################

resource_dir="/project/obds/albrecht/resources/seurat_1"

##########
# Script #
##########

mkdir -p $resource_dir

cd $resource_dir

wget https://cf.10xgenomics.com/samples/cell-exp/3.0.2/5k_pbmc_v3_nextgem/5k_pbmc_v3_nextgem_raw_feature_bc_matrix.tar.gz

tar xvzf 5k_pbmc_v3_nextgem_raw_feature_bc_matrix.tar.gz

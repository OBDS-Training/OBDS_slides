# Contents

## Dependencies

```
renv::install('tidyverse')
BiocManager::install('ALL')
BiocManager::install('hgu95av2.db')
BiocManager::install('GO.db')
BiocManager::install('BiocStyle')

stopifnot(require(matrixStats))
stopifnot(require(cowplot))
stopifnot(require(AnnotationDbi))
```

## General

- [x] Learning objectives
- [x] R is built for statistics: distributions and tests

## Work with probability distributions

- [x] List of probability distributions
- [x] The standard normal distributions
- [x] Parameterising the normal distribution
- [x] Parameterising the binomail distribution
- [x] Exercise: generate and visualise a distribution
- [x] Exercise: query a probability distribution
- [x] Exercise: empirical cumulative distribution function

## Work with statistical tests

- [x] The five steps of hypothesis testing
- [x] Parametric and non-parametric tests
- [x] The parametric t-test
- [x] The non-parametric wilcoxon test
- [x] Paired t-test
- [x] Analysis of Variance (ANOVA)
- [x] Linear regression
- [x] Fisher's Exact Test
- [x] Warning about interpreting the result of inadequate tests
- [x] Choosing a test
- [x] Knowledge assumptions - Central tendency
- [x] Knowledge assumptions - Normality
- [x] Quantile-Quantile Plots (QQ plot) 
- [x] Exercise: Statistical tests (iris data set).
- [x] Exercise: Linear regression (ChickWeight data set)

## Multiple testing correction

- [x] Introduction
- [x] Distribution of p-values under the null hypothesis
- [x] Bonferroni and Benjamini-Hochberg
- [x] Practical illustration of the null hypothesis before and after correction
- [x] Exercise: Two-group comparison and multiple testing correction (gene expression data)
- [x] Exercise: Over-representation analysis (gene expression data)

## Conclusion

- [x] Further reading
- [x] References

## Setup

- [x] Create a folder `week5/stats/` in the cohort shared folder
- [x] Upload gene expression data files in that folder

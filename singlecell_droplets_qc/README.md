# Assessing doublets and background in single-cell data

## Instructor(s)

<!--
Instructors should be listed in the order:
- Speaker
- Helper
-->

- Kevin Rue-Albrecht (@kevinrue)
- Devika Agarwal (@deevdevil88)

Past instructors:

- Lucy Garner (@lucygarner)

## Lesson goals and objectives

<!--
Refer to:
https://github.com/Bioconductor/BioC2019/blob/master/docs/workshop-syllabus.md#a-note-about-learning-goals-and-objectives-bloom
https://cft.vanderbilt.edu/guides-sub-pages/blooms-taxonomy/
-->

### Learning goals

<!--
High-level "big picture" objectives of the learning process.
-->

- Understand the origin of doublets and background signal in single-cell data.
- Describe methods and metrics for identifying artefacts.

### Learning objectives

<!--
More concrete and measurable outputs.
-->

- Import single-cell data from files into the R session.
- Apply methods to identify doublets.
- Apply methods to remove background noise from single-cell data.

## Pre-requisites

- A clone of the shared GitHub repository for this course.
- A working installation of [R](https://www.r-project.org/) (≥ 4.0) including the [renv](https://rstudio.github.io/renv/articles/renv.html) package.
- A working installation of [RStudio](https://rstudio.com/).

## Data sets

- Publicly available data sets distributed by [10X Genomics](https://www.10xgenomics.com/resources/datasets/).
  + A raw matrix prior to filtering.
  + A filtered matrix for the same data set, produced by by [Cell Ranger](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger)

## Time outline

| Activity                                      |  Time |
|-----------------------------------------------|-------|
| Setup                                         |  9:30 |
| Lecture: Doublets                             | 10:00 |
| Import raw data                               | 10:30 |
| **Morning Break**                             | 10:50 |
| Run `scDblFinder`                             | 11:00 |
| Visualise doublets                            | 12:00 |
| **Lunch Break**                               | 12:30 |
| Lecture: Background RNA                       | 13:30 |
| Apply `decontX`                               | 14:00 |
| **Afternoon Break**                           | 14:50 |
| Visualise the effect of decontamination       | 15:00 |
| **Day End**                                   | 16:00 |

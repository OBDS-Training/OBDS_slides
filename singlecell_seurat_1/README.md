# Single-cell analysis using Seurat, part 1

<!--
This title should match exactly the link in the main README.
-->

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
This should be no more than 3 bullet points.
-->

- Describe the preparation of sequencing libraries for single-cell genomics.
- Understand the core steps of a single-cell RNA-sequencing analysis workflow.
- Describe how to access information stored in a Seurat object.

### Learning objectives

<!--
More concrete and measurable outputs.
This can range from 3 to 8 bullet points.
-->

- Create a Seurat object.
- Access information stored in a Seurat object.
- Perform the steps of a Seurat workflow in a simple scenario.
- Visualise, interpret, and discuss information produced at each step of a simple workflow.

## Pre-requisites

<!--
May be a combination of:
- Requirements asked from participants before the day.
- Links to other OBDS course days with goals or objectives feeding in this day.
-->

- An account on the CCB cluster or [RStudio Cloud](https://rstudio.cloud/).
- Alternatively, a working installation of [R](https://www.r-project.org/) (4.1.2) and [RStudio Desktop](https://www.rstudio.com/products/rstudio/download/).
- A clone of the shared GitHub repository for this course.

## Data sets

<!--
Ideally, links to data sets that participants must download.
Even better, we add a page to this repository, that lists all data sets used; and this section links to some of those data sets.
Realistically, a list describing data sets that we will make them download on the day.
-->

- [5k Peripheral blood mononuclear cells (PBMCs) from a healthy donor (Next GEM)](https://support.10xgenomics.com/single-cell-gene-expression/datasets/3.0.2/5k_pbmc_v3_nextgem)

## Time outline

<!--
Breakdown of time segments for lecture and exercises addressing the objectives listed above.
These are example times; adapt time, and insert/remove rows as needed.
Requirements:
- The day starts at 9:30
- There is a 10+ min break in the morning
- There is a 1+ h lunch break
- There is a 10+ min break in the afternoon
- The day ends at 16:00
-->

| Activity                                      |  Time |
|-----------------------------------------------|-------|
| Setup                                         |  9:30 |
| Single-cell genomics                          | 10:00 |
| Import data and create a Seurat object        | 10:15 |
| **Morning Break**                             | 10:50 |
| Quality control, visualisation and filtering  | 11:00 |
| Normalisation                                 | 12:00 |
| **Lunch Break**                               | 12:30 |
| Highly variable features and scaling          | 13:30 |
| Dimensionality reduction and visualisation    | 14:15 |
| **Afternoon Break**                           | 14:50 |
| Clustering                                    | 15:00 |
| Cluster markers and visualisation             | 15:15 |
| End-of-day GitHub wrap-up                     | 15:45 |
| **Day End**                                   | 16:00 |

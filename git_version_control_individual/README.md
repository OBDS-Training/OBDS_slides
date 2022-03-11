# Version control using git and GitHub

## Instructor(s)

- Kevin Rue-Albrecht (@kevinrue)
- Nicki Gray (@nickigray)

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

- Understand what version control is and when to use it.
- Identify where git stores information.
- Practice how to record changes in git.

### Learning objectives

<!--
More concrete and measurable outputs.
-->

- Set up an SSH key pair.
- Configure git.
- _Initialise_ a personal repository for this course, on GitHub.
- _Clone_ a copy of the repository on the teaching cluster.
- Create and edit files in the repository on the teaching cluster, and _commit_ those changes.
- _Push_ your changes to the GitHub clone of the repository.
- Edit files on the GitHub clone of the repository.
- _Pull_ updates from the GitHub clone to the clone of the repository on the teaching cluster.
- Examine the _log_ of the shared repository, on GitHub and on the teaching cluster.

## Pre-requisites

- A [GitHub](https://github.com/) account.
- An account on the teaching cluster.

## Data sets

N/A

## Time outline

| Activity                                      |  Time |
|-----------------------------------------------|-------|
| Setup                                         |  9:30 |
| Introduction to version control               |  9:45 |
| Set up SSH key pairs                          | 10:00 |
| Configure git for the first time              | 10:15 |
| Initialise a repository on GitHub             | 10:30 |
| `git clone`                                   | 10:45 |
| **Morning Break**                             | 10:50 |
| The `.git` sub-directory                      | 11:10 |
| The `.gitignore` file                         | 11:15 |
| `git status`                                  | 11:20 |
| Editing files                                 | 11:25 |
| `git add`                                     | 11:30 |
| The staging area                              | 11:35 |
| `git commit`                                  | 11:40 |


| Working on branches                           | 11:00 |
| Create a branch                               | 11:15 |
| Make & track changes                          | 11:30 |
| The staging area                              | 12:00 |
| Record changes                                | 12:15 |
| **Lunch Break**                               | 12:30 |
| Share changes with others                     | 13:30 |
| Incorporate changes to the base branch        | 13:45 |
| Create a pull request                         | 14:00 |
| Review a pull request                         | 14:15 |
| Merge a pull request                          | 14:30 |
| **Afternoon Break**                           | 14:50 |
| Browse the repository history                 | 15:00 |
| View past commits and differences.            | 15:15 |
| Revert changes                                | 15:30 |
| Reset a repository to an earlier commit       | 15:45 |
| **Day End**                                   | 16:00 |

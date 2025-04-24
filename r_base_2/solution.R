#####################
# OBDS base R day 2 #
#####################

# Exercise ---- 

# Workspace management ----

# Open a new script and write code to create three new objects (any type, any name, any value).

a <- 1
b <- "some text"
c <- TRUE

# Save your script.

## macOS: Command-S

## Windows: Control-S

## RStudio menu bar:
## - File
## - Save as...

# Save all objects in your workspace to an .RData file.

save.image(file = "workspace.RData")

# Write one object in your workspace to a file using saveRDS().

saveRDS(a, "a.rds")

# Remove one object from your workspace.

rm(b)

# Prove that the object was removed.

ls()

# Remove all objects from your workspace.

rm(list = ls())

# Display your working directory.

getwd()

# Create a new directory and set the working directory in that new directory.

dir.create("new_dir")
setwd("new_dir")

# Restore objects saved in the .RData file to your workspace.

load("../workspace.RData")

# Restore the object saved in the RDS file to your workspace under a different name.

a_restored <- readRDS("../a.rds")

# Set the working directory back one level up from the new directory.

setwd("..")

# Exercise ----

# Descriptive statistics ----

# Use readRDS() to load the file, my_day2matrix.rds, and assign the object to the name m.

m <- readRDS("data/my_day2matrix.rds")

# Compute the sum of values in each row and add those values as a new column in the matrix.

rowSums(m)
m <- cbind(m, rowSums(m))

# Run the command data("ToothGrowth") to load the builtin data set ToothGrowth.

data("ToothGrowth")

# Open the help page for the ToothGrowth data set, to learn more about it.

?ToothGrowth

# What is the class of the ToothGrowth object?

class(ToothGrowth)

# What type of data is stored in each column of the ToothGrowth data set?

typeof(ToothGrowth$len)
typeof(ToothGrowth$supp)
typeof(ToothGrowth$dose)
# or
str(ToothGrowth)

# What is the mean tooth length across all observations in the data set?

mean(ToothGrowth$len)

# What is maximum value of tooth length?

max(ToothGrowth$len)

# What is minimum value of tooth length?

min(ToothGrowth$len)

# Can you use the functions rowSums() and colSums() on the ToothGrowth object?

try(rowSums(ToothGrowth))
try(colSums(ToothGrowth))

# Exercise ----

# Sorting data frames ----

# Load the airquality data set.

data("airquality")

# Open the help page for this data set.

?airquality

# Examine the data set.

head(airquality)

# Display the column names of the airquality data frame.

colnames(airquality)

# Sort the data frame by increasing value in the Ozone column.

airquality[order(airquality$Ozone), ]

# Sort the data frame by Month in increasing order and Temp in decreasing order.

airquality_sorted <- airquality[order(airquality$Month, airquality$Temp, decreasing = c(FALSE, TRUE)), ]

# Write the latest sorted data frame to a text file format of your choice.

write.table(x = airquality_sorted, file = "airquality_sorted.txt", quote = FALSE, sep = "\t", row.names = FALSE)

# Exercise ----

# Merging data frames ----
# Run the code below to create two data frames.

buildings <- data.frame(
    site = c(1, 2, 3),
    name = c("b1", "b2", "b3"))

survey_data <- data.frame(
    survey = c("A", "A", "A", "B", "B", "B"),
    location = c(1, 2, 3, 2, 3, 1),
    efficiency = c(51, 64, 70, 71, 80, 58))

# What is the shared information in these two data frames?

## site and location

# Use the merge() function to combine the two data frames by the shared information into a new data frame called buildings_survey.

merge(x = buildings, y = survey_data, by.x = "site", by.y = "location")

# Exercise ----

# Summarising groups of data ----

# Compute the mean of each numeric column each month in the `airquality` data frame using `aggregate()`.
# Make sure NA values are removed.

aggregate(x = airquality, by = list(Month = airquality$Month), FUN = mean, na.rm = TRUE)

# Compute the mean of the Solar.R column each month.
# Make sure the grouping column is called Month in the return value.
# Make sure NA values are removed.

aggregate(x = airquality["Solar.R"], by = list(Month = airquality$Month), FUN = mean, na.rm = TRUE)

# Exercise ----

# Writing a function ----

# Write a function to calculate the hypotenuse of a triangle given the length of the other two sides.
# Run the function you have created with different values.
# 
# Note:
#     
#     - To find the hypotenuse, add the squares of the other sides, then take the square root, i.e. √a2 + b2

hypothenuse <- function(a, b) {
    sqrt(a^2 + b^2)
}

hypothenuse(1, 2)

# Exercise ----

# Apply ----

# Part 1 ----

# Create a vector of integers from 1 to 10.

v <- 1:10

# Compute the log2 of each value in the vector using either lapply() or sapply().

lapply(v, log2)
sapply(v, log2)

# Compare the outputs of lapply() and sapply() in the previous step.

## List and vector

# Part 2 ----

# Create a list of four elements, each element being a vector of type either numeric or logical.

l <- list(
    c(1, 5, 2),
    c(TRUE, FALSE),
    c(101, 202, 303, 404),
    c(TRUE, TRUE, FALSE)
)

# Compute the sum of each vector in the list using either lapply() or sapply().

lapply(l, sum)
sapply(l, sum)

# Part 3 ----

# Use sapply() on the list that you created in part 2, to repeat each element of each vector three times.
# i.e., 1, 2, 3 should become 1, 1, 1, 2, 2, 2, 3, 3, 3

sapply(l, rep, each = 3)

# Exercise ----

# Loops and conditions ----

# Write a for loop that iterates over the integers 1 to 7 and prints the number raised to the power of three.

for (i in 1:7) {
    print(i**3)
}

# Write a for loop that iterates over the names of the columns in the builtin data set iris and prints each column name together with the number of characters in that column name.
# - Example output: Sepal.Length: 12
# - Hint: use the functions print(), paste0(), and nchar().
# - Remember to read the help page of each function to learn more about them.

for (n in colnames(iris)) {
    print(paste0(n, ": ", nchar(n)))
}

# Use the ifelse() function to print the name of colours that are made up of four characters in the vector my_colours below.

my_colours <- c("red", "orange", "purple", "yellow", "pink", "blue")
ifelse(nchar(my_colours) == 4, my_colours, NA)

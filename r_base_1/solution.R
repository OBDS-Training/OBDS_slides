#####################
# OBDS base R day 1 #
#####################

## Exercise ----

### Vectors ----

# - Assign the values 1 to 200 to a vector named `a`.

a <- 1:200
a

# - Multiply each element of the vector by 123 and assign the result to a new object named `b`.

b <- a * 123
b

# - Print the value of the 44^th^ element of the vector `b`.

b[44]

# - Extract the first fifteen elements of `b` and assign them to a new vector named `b_sub`.

b_sub <- b[1:15]

# - Append the numbers `24108` and `24231` to the object `b_sub`.

c(b_sub, 24108, 24231)

# - Assign the values `'actb'`, `100`, `3.4` to a vector named `m`.

m <- c('actb', 100, 3.4)
m

# - Print the second element of `m`.
#   Is it what you would expect? Why?

m[2]

# - Multiply the second element of `m` by `4`.
# What happens? Why?

try(
  m[2] * 4
)

## NOTE: Try try() function is only here to prevent the predictable error
##       from crashing the script.

# - Make a vector `c` that contains four *named* character scalars.

c <- c(fruit = "banana", institute = "WIMM", course = "WIMM", date = "today")
c

# - Display the names of the elements in `c`.
names(c)

## Exercise ----

### Matrices, arrays, and lists ----

# - Assign a matrix that contains the integers 1 to 9 in three rows and three columns (filled by column) to an object named `m1`.

m1 <- matrix(data = 1:9, nrow = 3, byrow = FALSE)
m1

# - Extract the number `8` using indexing by row and column.

m1[2, 3]

# - Assign a matrix that contains the integers 1 to 12 in three rows and four columns (filled by row) to an object named `m2`.

m2 <- matrix(data = 1:12, nrow = 3, byrow = TRUE)
m2

# - Add column and row names to the matrix `m2` (you choose the names).

rownames(m2) <- c("ONE", "TWO", "THREE")
colnames(m2) <- c("one", "two", "three", "four")
m2

# - Assign an array that contains the integers 1 to 24 along dimensions of lengths 4, 2 and 3 to an object named `a`.

a <- array(data = 1:24, dim = c(4, 2, 3))
a

# - Extract the number `15` using indexing by the three dimensions.

a[3, 2, 2]

# - Extract the matrix in the last dimension of the array and assign to a new object named `last_matrix`.

last_matrix <- a[, , dim(a)[3]]
last_matrix

# - Assign a list of five items of different data types to a list named `l`.

l <- list(
  c(1, 3, 4),
  c(1+3i, 3-1i),
  c(TRUE, FALSE, TRUE),
  c("hello", "world"),
  c(6L, 2L, 3L)
)
l

# - Extract the elements at position 3 and 5 of `l` as a single new list.

l[c(3, 5)]

## Exercise ----

### Data frames ----

# - Assign data from the file `coding_gene_region.bed` to an object named `gene_data`.

gene_data <- read.table("data/coding_gene_region.bed")
head(gene_data)

# - Display the dimensions of the data frame and the type of data in each column.

dim(gene_data)
str(gene_data)

# - Set column names to: `chr`, `start`, `end`, `name`, `score`, and `strand`.

colnames(gene_data) <- c("chr", "start", "end", "name", "score", "strand")

# - Prove that you have (re)named the columns.

head(gene_data)

# - Display the value at row 30, column 3.

gene_data[30, 3]

# - Assign the column named `start` to a new object named `start_position`.

start_position <- gene_data$start

# - Calculate the length of each gene and assign that value to a new column named `length`.

gene_data$length <- gene_data$end - gene_data$start

# - Prove that you have added the new column.

head(gene_data)

# - Assign rows where the gene length is between 100kb and 200kb to a new object named `filtered_gene_data`.

filtered_gene_data <- subset(gene_data, length >= 100E3 & length <= 200E3)
dim(filtered_gene_data)

# - Export `filtered_gene_data` to a file named `filtered_gene_regions.tsv`, using tabulation as a field delimiter.
#   Include column names but not row names.

write.table(filtered_gene_data, "filtered_gene_regions.tsv", sep = "\t", quote = FALSE, row.names = FALSE)

## Exercise (bonus) ----

### Indexing vectors ----

# Run the code below to initialise data for this exercise.

movie <- c(
  "Whatever Works", "It Follows", "Love and Mercy", "The Goonies", "Jiro Dreams of Sushi", "There Will be Blood", "Moon",
  "Spice World", "Serenity", "Finding Vivian Maier")
year <- c("2009", "2015", "2015", "1985", "2012", "2007", "2009", "1988", "2005", "2014")
boxoffice <- c(35, 15, 15, 62, 3, 10, 321, 79, 39, 1.5)
genre <- c("Comedy", "Horror", "Drama", "Adventure", "Drama", "SciFi", "Comedy", "Documentary", "SciFi", "Documentary")

# - What is the name of the 10^th^ movie?
movie[10]

# - What are the genres of the first four movies?
genre[1:4]

# - In the movie names, 'Spice World' should be 'The Naked Gun’.
#   Correct the name.
movie[movie == "Spice World"] <- "The Naked Gun"

# - What were the names of the movies made before the year 1990?
movie[year %in% c("1985", "1988")]
# OR
movie[as.integer(year) < 1990]

# - What were the names of the movies in the 'Comedy' genre?
movie[genre == "Comedy"]

#   - What were their combined total box office?
sum(boxoffice)

# - What is the name of the movie that made less than $50 million dollars *and* was a documentary?
movie[boxoffice < 50 & genre == "Documentary"]

## Exercise (bonus) ----

### Scalars and vectors ----

# - Create a vector with values `1` to `10` in three ways: once using `c()`, once using `start:end`, and once using `seq()`.

c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
1:10
seq(1, 10, 1)

# - Create a vector with values `2.1`, `4.1`, `6.1`, `8.1` in two ways, once using `c()` and once using `seq()`.

c(2.1, 4.1, 6.1, 8.1)
seq(2.1, 8.1, 2)

# - Create a vector with values `0`, `5`, `10`, `15` in three ways: using `c()`, `seq()` with the `by=` argument, and `seq()` with the `length.out=` argument.

c(0, 5, 10, 15)
seq(0, 15, by=5)
seq(0, 15, length.out=4)

# - Create a vector with values `101`, `102`, `103`, `200`, `205`, `210`, `1000`, `1100`, `1200` using a combination of the functions `c()` and `seq()`.

c(seq(101, 103, 1),
  seq(200, 210, 5),
  seq(1000, 1200, 100))

# - Create a vector that repeats the integers from `1` to `5`, ten times.
#   That is: `1`, `2`, `3`, `4`, `5`, `1`, `2`, `3`, `4`, `5`, ....
#   The length of the vector should be `50`.

rep(1:5, times=10)

# - Now, create the same vector as before, but this time repeat `1`, ten times, then `2`, ten times, and so on.
#   That is: `1`, `1`, ..., `2`, `2`, ..., `5`, `5`.
#   The length of the vector should also be `50`.

rep(1:5, each=10)

## Exercise (bonus) ----

### Data frames ----

# Run the code below to initialise data for this exercise.

vector1 <- 1:10 
vector2 <- letters[1:10] 
vector3 <- rnorm(10, sd = 10) 
df <- data.frame(vector1, vector2, vector3)

# - Look up the help page for the function `rnorm()`.
#   What does it do?

?rnorm

# - Print the last two columns of `df`, once by integer position, once by column name.

df[,2:3]
df[,c( ncol(df) - 1, ncol(df) )]
df[, c("vector2", "vector3")]

# - Print the values in the column `vector2` where the value in the column `vector3` is positive.

df[ df$vector3 > 0, "vector2"]

# - Look up the help page for the function `paste()`.
#   Create a vector that, for each row, combines the values across all the columns of `df` separated by a underscore.

paste(df$vector1, df$vector2, df$vector3, sep="_")

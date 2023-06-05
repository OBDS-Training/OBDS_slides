# Exercise ----

# Vectors ----

# Assign the values 1 to 200 to a vector named a.

a <- 1:200
a

# Multiply each element of the vector by 123 and assign the result to a new object named b.

b<- a * 123
b

# Print the value of the 44th element of the vector b.

b[44]

# Extract the first fifteen elements of b and assign them to a new vector named b_sub.

b_sub <- b[1:44]

# Append the numbers 24108 and 24231 to the object b_sub.

c(b_sub, 24108, 24231)

# Assign the values 'actb', 100, 3.4 to a vector named m.

m <- c('actb', 100, 3.4)
m

# Print the second element of m. Is it what you would expect? Why?

m[2]

# Multiply the second element of m by 4. What happens? Why?

m[2] * 4

# Make a vector c that contains four named character scalars.

c <- c(fruit = "banana", institute = "WIMM", course = "WIMM", date = "today")
c

# Display the names of the elements in c.
names(c)

# Exercise ----

## Matrice, arrays, and lists ----

# Assign a matrix that contains the integers 1 to 9 in three rows and three columns (filled by column) to an object named m1.

m1 <- matrix(data = 1:9, nrow = 3, byrow = FALSE)
m1

# Extract the number 8 using indexing by row and column.

m1[2, 3]

# Assign a matrix that contains the integers 1 to 12 in three rows and four columns (filled by row) to an object named m2.

m2 <- matrix(data = 1:12, nrow = 3, byrow = TRUE)
m2

# Add column and row names to the matrix m2 (you choose the names).

rownames(m2) <- c("ONE", "TWO", "THREE")
colnames(m2) <- c("one", "two", "three", "four")
m2

# Assign an array that contains the integers 1 to 24 along dimensions of lengths 4, 2 and 3 to an object named a.

a <- array(data = 1:24, dim = c(4, 2, 3))
a

# Extract the number 15 using indexing by the three dimensions.

a[3, 2, 2]

# Extract the matrix in the last dimension of the array and assign to a new object named last_matrix.

last_matrix <- a[, , dim(a)[3]]
last_matrix

# Assign a list of five items of different data types to a list named l.

l <- list(
    c(1, 3, 4),
    c(1+3i, 3-1i),
    c(TRUE, FALSE, TRUE),
    c("hello", "world"),
    c(6L, 2L, 3L)
)
l

# Extract the elements at position 3 and 5 of l as a single new list.

l[c(3, 5)]

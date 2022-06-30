install.packages('yarrr')

library(yarrr)

## 16.1 Why would you want to write your own function?
# Create a function and have the function do the repeated works

# Create a function called piratehist
piratehist <- function(x, ...) {
  
  # Create a customized histogram  
  hist(x,
       col = gray(.5, .2),
       border = "white",
       yaxt = "n",
       ylab = "",
       ...)
  
  # Calculate the conf interval
  ci <- t.test(x)$conf.int
  
  # Define and add top-text
  top.text <- paste(
    "Mean = ", round(mean(x), 2),
    " (95% CI [", round(ci[1], 2),
    ", ", round(ci[2], 2), 
    "]), SD = ", round(sd(x), 2), 
    sep = "")
  
  mtext(top.text, side = 3)
}

# Create a pirate histogram!
piratehist(pirates$age,
           xlab = "Age",
           main = "Pirates' Ages")

head(pirates)

## 16.2 The structure of a custom function

# The basic structure of a function
NAME <- function(ARGUMENTS) {
  
  ACTIONS
  
  return(OUTPUT)
  
}

# 16.2.1 Creating my.mean()
# Create the function my.mean()
my.mean <- function(x) {   # Single input called x
  
  output <- sum(x) / length(x) # Calculate output
  
  return(output)  # Return output to the user after running the function
  
}



data <- c(3, 1, 6, 4, 2, 8, 4, 2)
my.mean(data)
mean(data)

# 16.2.2 Specifying multiple inputs

oh.god.how.much.did.i.spend <- function(grogg,
                                        port,
                                        crabjuice) {
  
  output <- grogg * 1 + port * 3 + crabjuice * 10
  
  return(output)
}

oh.god.how.much.did.i.spend(grogg = 10,
                            port = 3,
                            crabjuice = 0)

# 16.2.3 Including default values for arguments
# Including default values for function arguments
oh.god.how.much.did.i.spend <- function(grogg = 0,
                                        port = 0,
                                        crabjuice = 0) {
  
  output <- grogg * 1 + port * 3 + crabjuice * 10
  
  return(output)
}

oh.god.how.much.did.i.spend(port = 5)

## 16.3 Using if, then statements in functions
is.it.true <- function(x) {
  
  if(x == TRUE) {print("x was true!")}
  if(x == FALSE) {print("x was false!")}
  
}
is.it.true(TRUE)
is.it.true(FALSE)
is.it.true(10>0)
is.it.true(10<0)


show.me <- function(x, what) {
  
  if(what == "plot") {
    
    hist(x, yaxt = "n", ylab = "", border = "white", 
         col = "skyblue", xlab = "",
         main = "Ok! I hope you like the plot...")
    
  }
  
  if(what == "stats") {
    
    print(paste("Yarr! The mean of this data be ", 
                round(mean(x), 2),
                " and the standard deviation be ", 
                round(sd(x), 2),
                sep = ""))
    
  }
  
  if(what == "tellmeajoke") {
    
    print("I am a pirate, not your joke monkey.")
    
  }
}


show.me(x = pirates$beard.length, 
        what = "plot")

show.me(x = pirates$beard.length, 
        what = "stats")

show.me(what = "tellmeajoke")


## 16.4 A worked example: plot.advanced()

plot.advanced <- function (x = rnorm(100),
                           y = rnorm(100),
                           add.mean = FALSE,
                           add.regression = FALSE,
                           p.threshold = .05,
                           add.modeltext = FALSE,
                           ...  # Optional further arguments passed on to plot
) {
  
  # Generate the plot with optional arguments
  #   like main, xlab, ylab, etc.
  plot(x, y, ...)
  
  # Add mean reference lines if add.mean is TRUE
  if(add.mean == TRUE) {
    
    abline(h = mean(y), lty = 2)
    abline(v = mean(x), lty = 2)
  }
  
  # Add regression line if add.regression is TRUE
  if(add.regression == TRUE) {
    
    model <- lm(y ~ x)  # Run regression
    
    p.value <- anova(model)$"Pr(>F)"[1] # Get p-value
    
    # Define line color from model p-value and threshold
    if(p.value < p.threshold) {line.col <- "red"}
    if(p.value >= p.threshold) {line.col <- "black"}
    
    abline(lm(y ~ x), col = line.col, lwd = 2) # Add regression line
    
  }
  
  # Add regression equation text if add.modeltext is TRUE
  if(add.modeltext == TRUE) {
    
    # Run regression
    model <- lm(y ~ x)
    
    # Determine coefficients from model object
    coefficients <- model$coefficients
    a <- round(coefficients[1], 2)
    b <- round(coefficients[2], 2)
    
    # Create text
    model.text <- paste("Regression Equation: ", a, " + ",
                        b, " * x", sep = "")
    
    # Add text to top of plot
    mtext(model.text, side = 3, line = .5, cex = .8)
    
  }
}


plot.advanced(x = pirates$age,
              y = pirates$tchests,
              add.regression = TRUE,
              add.modeltext = TRUE,
              p.threshold = .05,
              main = "plot.advanced()",
              xlab = "Age", ylab = "Treasure Chests Found",
              pch = 16,
              col = gray(.2, .3))

# 16.4.1 Seeing function code
# just type in the function name without parenthesis
plot.advanced


# 16.4.2 Using stop() to completely stop a function and print an error

do.stats <- function(mat) {
  
  if(is.matrix(mat) == F) {stop("Argument was not a matrix!")}
  
  # Only run if argument is a matrix!
  print(paste("Thanks for giving me a matrix. The matrix has ", nrow(mat), 
              " rows and ", ncol(mat), 
              " columns. If you did not give me a matrix, the function would have stopped by now!", 
              sep = ""))
  
}

do.stats(mat = "This is a string, not a matrix") 

do.stats(mat = matrix(1:10, nrow = 2, ncol = 5))

# 16.4.3 Using vectors as arguments
oh.god.how.much.did.i.spend <- function(drinks.vec) {
  
  grogg <- drinks.vec[1]
  port <- drinks.vec[2]
  crabjuice <- drinks.vec[3]
  
  output <- grogg * 1 + port * 3 + crabjuice * 10
  
  return(output)
  
}

oh.god.how.much.did.i.spend(c(1, 5, 2))

# 16.4.4 Storing and loading your functions to and from a function file with source()

#  put all of your custom R functions into a single R script with a name like customfunctions.R
# load all your functions into any R session by using the source() function. 
# Evaluate all of the code in my custom function R script
# source(file = "Users/Nathaniel/Dropbox/Custom_Pirate_Functions.R")

# 16.4.5 Testing functions

# you can’t actually test the code line-by-line until you’ve defined the input objects 
# in some other way. To do this, include temporary hard-coded values for the inputs at 
# the beginning of the function code.

#* For example, consider the following function called remove.outliers. The goal of 
#* this function is to take a vector of data and remove any data points that are outliers.
#* This function takes two inputs x and outlier.def, where x is a vector of numerical 
#* data, and outlier.def is used to define what an outlier is: if a data point is 
#* outlier.def standard deviations away from the mean, then it is defined as an outlier 
#* and is removed from the data vector.

remove.outliers <- function(x, outlier.def = 2) {
  
  # Test values (only used to test the following code)
  #  x <- c(rep(1, 100), 999)
  #  outlier.def <- 2
  
  is.outlier <- x > (mean(x) + outlier.def * sd(x)) | 
    x < (mean(x) - outlier.def * sd(x))
  
  x.nooutliers <- x[is.outlier == FALSE]
  
  return(x.nooutliers)
  
}


x <- c(rep(1, 100), 999)
outlier.def <- 2

res=remove.outliers (x, 2)

# 16.4.6 Using ... as a wildcard argument


hist.advanced <- function(x, add.ci = TRUE, ...) {
  
  hist(x, # Main Data
       ... # Here is where the additional arguments go
  )
  
  if(add.ci == TRUE) {
    
    ci <- t.test(x)$conf.int # Get 95% CI
    segments(ci[1], 0, ci[2], 0, lwd = 5, col = "red")
    
    mtext(paste("95% CI of Mean = [", round(ci[1], 2), ",",
                round(ci[2], 2), "]"), side = 3, line = 0)
  }
}

hist.advanced(x = rnorm(100), add.ci = TRUE,
              main = "Treasure Chests found",
              xlab = "Number of Chests",
              col = "lightblue")



### Chapter 17 Loops
# One of the golden rules of programming is D.R.Y.   Don’t repeat yourself."
# To tell R to do something over and over, we use a loop. 

# SLOW way to convert any values that aren't equal to "Y", or "N" to NA
survey.df$q.1[(survey.data$q1 %in% c("Y", "N")) == FALSE] <- NA
survey.df$q.2[(survey.data$q2 %in% c("Y", "N")) == FALSE] <- NA
# . ... Wait...I have to type this 98 more times?!
# .
# . ... My god this is boring...
# .
survey.df$q.100[(survey.data$q100 %in% c("Y", "N")) == FALSE] <- NA



# FAST way to convert values that aren't "Y", or "N" to NA
for(i in 1:100) { # Loop over all 100 columns
  temp <- survey.df[, i]  # Get data for ith column and save in a new temporary object temp
  temp[(temp %in% c("Y", "N")) == FALSE] <- NA # Convert invalid values in temp to NA
  survey.df[, i] <- temp # Assign temp back to survey.df!
} # Close loop!



## 17.1 What are loops?

# General structure of a loop
for(loop.object in loop.vector) {
  
  LOOP.CODE
  
}

# Print the integers from 1 to 10
for(i in 1:10) {
  
  print(i)
}

# 17.1.2 Adding the integers from 1 to 100

# Loop to add integers from 1 to 100
current.sum <- 0 # The starting value of current.sum
for(i in 1:100) {
  
  current.sum <- current.sum + i # Add i to current.sum
  
}

current.sum # Print the result!
sum(1:100)
n<-100
n*(n+1)/2

cal<-function(n){
  
  output<-n*(n+1)/2
  return (output)
}

cal(200)

## 17.2 Creating multiple plots with a loop
head(examscores)

par(mfrow = c(2, 2))  # Set up a 2 x 2 plotting space

# Create the loop.vector (all the columns)
loop.vector <- 1:4

for (i in loop.vector) { # Loop over loop.vector
  
  # store data in column.i as x
  x <- examscores[,i]
  
  # Plot histogram of x
  hist(x,
       main = paste("Question", i),
       xlab = "Scores",
       xlim = c(0, 100))
}



## 17.3 Updating a container object with a loop


# Create a container object of 4 NA values
failure.percent <- rep(NA, 4)
for(i in 1:4) { # Loop over columns 1 through 4
  
  # Get the scores for the ith column
  x <- examscores[,i] 
  
  # Calculate the percent of failures
  failures.i <- mean(x < 50)  
  
  # Assign result to the ith value of failure.percent
  failure.percent[i] <- failures.i 
  
}
failure.percent

# Calculate failure percent without a loop
failure.percent <- rep(NA, 4)
failure.percent[1] <- mean(examscores[,1] < 50)
failure.percent[2] <- mean(examscores[,2] < 50)
failure.percent[3] <- mean(examscores[,3] < 50)
failure.percent[4] <- mean(examscores[,4] < 50)
failure.percent


# 17.4 Loops over multiple indices with a design matrix

#* Let’s say you want to calculate the mean, median, and standard deviation of some 
#* quantitative variable for all combinations of two factors. For a concrete example, 
#* let’s say we wanted to calculate these summary statistics on the age of pirates for 
#* all combinations of colleges and sex.
#* 
#* #* To do this, we’ll start by creating a design matrix. This matrix will have all 
#* combinations of our two factors. To create this design matrix matrix, we’ll use the 
#* expand.grid() function. This function takes several vectors as arguments, and returns 
#* a dataframe with all combinations of values of those vectors.

design.matrix <- expand.grid("college" = c("JSSFP", "CCCC"), # college factor
                             "sex" = c("male", "female"), # sex factor
                             "median.age" = NA, # NA columns for our future calculations
                             "mean.age" = NA, #...
                             "sd.age" = NA, #...
                             stringsAsFactors = FALSE)

for(row.i in 1:nrow(design.matrix)) {
  
  # Get factor values for current row
  college.i <- design.matrix$college[row.i]
  sex.i <- design.matrix$sex[row.i]
  
  # Subset pirates with current factor values
  data.temp <- subset(pirates, 
                      college == college.i & sex == sex.i)
  
  # Calculate statistics
  median.i <- median(data.temp$age)
  mean.i <- mean(data.temp$age)
  sd.i <- sd(data.temp$age)
  
  # Assign statistics to row.i of design.matrix
  design.matrix$median.age[row.i] <- median.i
  design.matrix$mean.age[row.i] <- mean.i
  design.matrix$sd.age[row.i] <- sd.i
  
}

design.matrix


## 17.5 The list object

#* Let’s say you are conducting a loop where the outcome of each index is a vector. 
#* However, the length of each vector could change - one might have a length of 1 and 
#* one might have a length of 100. How can you store each of these results in one object?
#* Unfortunately, a vector, matrix or dataframe might not be appropriate because their 
#* size is fixed. The solution to this problem is to use a list(). A list is a special 
#* object in R that can store virtually anything. You can have a list that contains 
#* several vectors, matrices, or dataframes of any size. If you want to get really 
#* Inception-y, you can even make lists of lists (of lists of lists….).

# Create a list with vectors of different lengths
number.list <- list(
  "a" = rnorm(n = 10),
  "b" = rnorm(n = 5),
  "c" = rnorm(n = 15))

number.list

# Give me the first element in number.list
number.list[[1]]

# Give me the element named b
number.list$b

# Create an empty list with 5 elements
samples.ls <- vector("list", 5)

for(i in 1:5) {
  samples.ls[[i]] <- rnorm(n = i, mean = 0, sd = 1)
}

samples.ls

samples.ls[2]




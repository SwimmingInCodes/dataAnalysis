# 2. Getting Started
# packages
install.packages("yarrr")

# Load package. We have to load a package in every new R session
library("yarrr")

# ? brings the information about pirates in Files/Plots window
?pirates

# shows the first 6 rows
head(pirates)

# Make a pirateplot using the pirateplot() function
#  from the yarrr package!
pirateplot(formula=weight ~ Time,
           data = ChickWeight,
           pal='xmen') # pal means palette

pirateplot(formula = weight ~ Diet,
           data=ChickWeight)

# 2.4 Reading and writing codes

# Define a vector a as the integers from 1 to 5
a<-1:5

# Print a
a

# Get the average
mean(a)

# Create vector object
seq(from =0, to=100, by=2)
seq(1, 10)
data<-c(1,2,3,4,5)
mean(data)
mean(c(1,2,3,4,5))
head(ChickWeight)

# 3 JUMP IN

# Install the yarrr package
install.packages('yarrr')

# Load the package
library(yarrr)

# 3.1 Exploring data

# ? gives us some information about the dataset.
?pirates

# Look at the first few rows of the data
head(pirates)

# Shows the column names
names(pirates)

# View the entire dataset in a new window
View(pirates)


# 3.2 Descriptive statistics
# $ sign is used to access to a particular column
mean(pirates$age)
max(pirates$height)

# How many pirates are there of each sex?
table(pirates$sex)

# Calculate the mean age, separately for each sex
aggregate(formula= age ~ sex,
          data=pirates,
          FUN=mean)

# 3.3 Plotting
# Create scatterplot
plot(x=pirates$height,
     y=pirates$weight,
     main='Weight vs Height',
     xlab='Height (in cm)',
     ylab='Weight (in kg)',
     pch = 16,
     col=gray(.0, .1))
grid()


# Create a linear regression model
model <- lm(formula = weight ~ height, 
            data = pirates)

abline(model, col = 'blue')      # Add regression to plot


# create a pirateplot using the pirateplot() function 
# to show the distribution of pirate’s age based on their favorite sword

pirateplot(formula = age ~ sword.type,
           data=pirates,
           main='Pirateplot of ages by favorite sword',
           pal='pony',
           theme=3)


# Create another pirateplot showing the relationship between sex and height using 
# a different plotting theme and the "pony" color palette:
pirateplot(formula = height ~ sex,               # Plot weight as a function of sex
           data = pirates,                       
           main = "Pirateplot of height by sex",
           pal = "pony",                         # Use the info color palette
           theme = 3)                            # Use theme 3



# The "pony" palette is contained in the piratepal() function. 
# Let’s see where the "pony" palette comes from…

pirateplot(palette='pony',
           plot.result=TRUE,
           trans=.1)


# 3.4 Hypothesis tests

# Age by headband t-test
t.test(formula = age ~ headband,
       data=pirates,
       alternative='two.sided')
# --> With a p-value of 0.7259, we don’t have sufficient evidence say there is a difference 
# in the men age of pirates who wear headbands and those that do not.

# Next, let’s test if there a significant correlation between a pirate’s height and weight 
# using the cor.test() function:
cor.test(formula = ~ height + weight,
         data=pirates)
# There is a significant (positive) relationship between a pirate’s height and weight.


# Let’s do an ANOVA testing if there is a difference between the number of tattoos pirates 
# have based on their favorite sword

tat.sword.lm<-lm(formula = tattoos ~ sword.type,
                 data=pirates)

anova(tat.sword.lm)
# --> the number of tattoos pirate’s have are different based on their favorite sword.


# 3.5 Regression analysis
# run a regression analysis to see if a pirate’s age, weight, and number of tattoos 
# (s)he has predicts how many treasure chests he/she’s found

# Create a linear regression model: DV = tchests, IV = age, weight, tattoos
tchests.model <- lm(formula = tchests ~ age + weight + tattoos,
                    data = pirates)

# Show summary statistics
summary(tchests.model)
# --> only significant predictor of the number of treasure chests that a pirate has found is his/her age. 
# There does not seem to be significant effect of weight or tattoos.


# 3.6 Bayesian Statistics

# Let’s do a Bayesian version of our earlier t-test asking if pirates who wear a headband are older or 
# younger than those who do not.

# Install and load the BayesFactor package
install.packages('BayesFactor')
library(BayesFactor)

install.packages("yarrr")
library(yarrr)

# Bayesian t-test comparing the age of pirates with and without headbands
ttestBF(formula = age ~ headband,
        data = pirates)

# -->we got a Bayes factor of 0.12 which is strong evidence for the null hypothesis 
# (that the mean age does not differ between pirates with and without headbands)


## Chapter 4 The Basics
# R revolves around two things: objects and functions.
# An object is a thing – like a number, a dataset, a summary statistic like a mean or standard deviation, 
# or a statistical test. Objects come in many different shapes and sizes in R. There are simple objects like 
# which represent single numbers, vectors (like our tattoos object above) which represent several numbers, 
# more complex objects like dataframes which represent tables of data, and even more complex objects 
# like hypothesis tests or regression which contain all sorts of statistical information.

# What is a function? A function is a procedure that typically takes one or more objects as arguments 
# (aka, inputs), does something with those objects, then returns a new object.

# Create a new object called a with a value of 100
a <- 100
# To change an object, you must assign it again!

# 4.4.3 How to name objects
# Valid object names
group.mean <- 10.21
my.age <- 32
FavoritePirate <- "Jack Sparrow"
sum.1.to.5 <- 1 + 2 + 3 + 4 + 5

# Invalid object names!
famale ages <- 50 # spaces
5experiment <- 50 # starts with a number
a! <- 50 # has an invalid character

# 4.4.3.1 R is case-sensitive!
# 4.4.4 Example: Pirates of The Caribbean

blackpearl.usd=867490
blackpearl.eur=blackpearl.usd*0.88
blackpearl.eur

deadman.usd <- 1066215812

deadman.usd / blackpearl.usd



## Chapter 5 Scalars and vectors

# Crew information
captain.name <- "Jack"
captain.age <- 33

crew.names <- c("Heath", "Vincent", "Maya", "Becki")
crew.ages <- c(19, 35, 22, 44)
crew.sex <- c(rep("M", times = 2), rep("F", times = 2))
crew.ages.decade <- crew.ages / 10

# Earnings over first 10 days at sea
days <- 1:10
gold <- seq(from = 10, to = 100, by = 10)
silver <- rep(50, times = 10)
total <- gold + silver

# 5.1 Scalars
# A scalar object is just a single value like a number or a name
# Examples of numeric scalers
a <- 100
b <- 3 / 100
c <- (a + b) / b

# Scalars don’t have to be numeric, they can also be characters (also known as strings). In R, 
# you denote characters using quotation marks. Here are examples of character scalars:
# Examples of character scalers
d <- "ship"
e <- "cannon"
f <- "Do any modern armies still use cannons?"


# 5.2 Vectors
# A vector object is just a combination of several scalars stored as a single object.
# Create an object a with the integers from 1 to 5
a <- c(1, 2, 3, 4, 5)
a

a <- c(1, 2, 3, 4, 5)
b <- c(6, 7, 8, 9, 10)
x <- c(a, b)
x

# 5.2.1 a:b
# returns a vector of numbers from the starting point a to the ending point b in steps of 1
1:10
10:1
2.5:10.5

# 5.2.2 seq()
# Create the numbers from 1 to 10 in steps of 1
seq(from = 1, to = 10, by = 1)
# Integers from 0 to 100 in steps of 10
seq(from = 0, to = 100, by = 10)
# Create 10 numbers from 1 to 5
seq(from = 1, to = 5, length.out = 10)
# 3 numbers from 0 to 100
seq(from = 0, to = 100, length.out = 3)

# 5.2.3 rep()
# repeat a scalar (or vector) a specified number of times, or to a desired length
rep(x = 3, times = 10)
rep(x = c(1, 2), each = 3)
rep(x = 1:3, length.out = 10)
rep(x = 1:3, each = 2, times = 2)
rep(x = 1:3, times = 2, each = 2)

# Warning! Vectors contain either numbers or characters, not both
my.vec <- c("a", 1, "b", 2, "c", 3)
my.vec

# 5.3 Generating random data

# 5.3.1.1 replace = TRUE

# Draw 10 samples from the integers 1:5 with replacement
sample(x = 1:5, size = 10, replace = TRUE)
# We CAN'T draw 10 samples without replacement from a vector with length 5
sample(x = 1:5, size = 10)

# Weighted sampling
sample(x = c("a", "b"), 
       prob = c(.9, .1),
       size = 10, 
       replace = TRUE)

# 5.3.1.2 Ex: Simulating coin flips
sample(x = c("H", "T"), # The possible values of the coin
       size = 10,  # 10 flips
       replace = TRUE) # Sampling with replacement

sample(x = c("H", "T"),
       prob = c(.8, .2), # Make the coin biased for Heads
       size = 10,
       replace = TRUE)

# 5.3.1.3 Ex: Coins from a chest
# Let’s say the chest has 100 coins: 20 gold, 30 silver, and 50 bronze. 
# Let’s draw 10 random coins from this chest.
# Create chest with the 100 coins

chest <- c(rep("gold", 20),
           rep("silver", 30),
           rep("bronze", 50))

# Draw 10 coins from the chest
sample(x = chest,
       size = 10)

# See all distributions included in Base R
?Distributions

# 5.3.2 Normal (Gaussian)

# 5 samples from a Normal dist with mean = 0, sd = 1
rnorm(n = 5, mean = 0, sd = 1)

# 3 samples from a Normal dist with mean = -10, sd = 15
rnorm(n = 3, mean = -10, sd = 15)

# 5.3.3 Uniform

# 5 samples from Uniform dist with bounds at 0 and 1
runif(n = 5, min = 0, max = 1)

# 10 samples from Uniform dist with bounds at -100 and +100
runif(n = 10, min = -100, max = 100)

# 5.3.4 Notes on random samples
# 5.3.4.1 Random samples will always change

# Draw a sample of size 5 from a normal distribution with mean 100 and sd 10
rnorm(n = 5, mean = 100, sd = 10)

# Do it again!
rnorm(n = 5, mean = 100, sd = 10)

# 5.3.4.2 Use set.seed() to control random samples

# Fix sampling seed to 100, so the next sampling functions always produce the same values
set.seed(100)

# The result will always be -0.5022, 0.1315, -0.0789
rnorm(3, mean = 0, sd = 1)





# Chapter 6 Vector functions

# 10 students from two different classes took two exams. Here are three vectors showing the data
midterm <- c(62, 68, 75, 79, 55, 62, 89, 76, 45, 67)
final <- c(78, 72, 97, 82, 60, 83, 92, 73, 50, 88)
# How many students are there?
length(midterm)
# Add 5 to each midterm score (extra credit!)
midterm <- midterm + 5
midterm
# Difference between final and midterm scores
final - midterm
# Each student's average score
(midterm + final) / 2
# Mean midterm grade
mean(midterm)
# Standard deviation of midterm grades
sd(midterm)
# Highest final grade
max(final)
# z-scores
midterm.z <- (midterm - mean(midterm)) / sd(midterm)
final.z <- (final - mean(final)) / sd(final)


# 6.1 Arithmetic operations on vectors
a <- c(1, 2, 3, 4, 5)
b <- c(10, 20, 30, 40, 50)

a + 100
a + b
(a + b) / 10

# Take the integers from 1 to 10, then add 100 to each
1:10 + 100

a <- 1:10
a / 100
a ^ 2

# 6.1.1 Basic math with multiple vectors
c(1, 2, 3, 4, 5) + c(1, 2, 3, 4, 5)

a <- 1:5
b <- 1:5

ab.sum <- a + b
ab.sum
ab.diff <- a - b
ab.diff
ab.prod <- a * b
ab.prod

# 6.1.2 Ex: Pirate Bake Sale
pies <- c(3, 6, 2, 10, 4)
cookies <- c(70, 40, 40, 200, 60)
total.sold <- pies + cookies
total.sold


# 6.2 Summary statistics
tattoos <- c(4, 50, 2, 39, 4, 20, 4, 8, 10, 100)
min(tattoos)
mean(tattoos)
sd(tattoos)
sum(tattoos )
var(tattoos )
range(tattoos )
quantile(tattoos , probs=.2)
summary(tattoos )

# 6.2.1 length()
a <- 1:10
length(a)  

b <- seq(from = 1, to = 100, length.out = 20)
length(b)  
length(c("This", "character", "vector", "has", "six", "elements."))
length("This character scalar has just one element.")

# 6.2.2 Additional numeric vector functions
round(c(2.231, 3.1415), digits=2)
ceiling(c(5.1, 7.9))
floor(c(5.1, 7.9))
7 %% 3 # modular division


# 6.2.3 Sample statistics from random samples
# 5 samples from a Normal dist with mean = 10 and sd = 5
x <- rnorm(n =100000, mean = 10, sd = 5)

# What are the mean and standard deviation of the sample?
mean(x)
sd(x)

# 6.3 Counting statistics
vec <- c(1, 1, 1, 5, 1, 1, 10, 10, 10)
gender <- c("M", "M", "F", "F", "F", "M", "F", "M", "F")

unique(vec)
unique(gender)

table(vec)
table(gender)


table(vec) / sum(table(vec))
table(gender) / sum(table(gender))



# 6.4 Missing (NA) values
a <- c(1, 5, NA, 2, 10)
mean(a)


# To tell a descriptive statistic function to ignore missing (NA) values, 
# include the argument na.rm = TRUE in the function. 

mean(a, na.rm = TRUE)


# 6.5 Standardization (z-score)
# A common task in statistics is to standardize variables – also known as calculating z-scores. 
# The purpose of standardizing a vector is to put it on a common scale which allows you to compare it to 
# other (standardized) variables. To standardize a vector, you simply subtract the vector by its mean,
# and then divide the result by the vector’s standard deviation.

a <- c(5, 3, 7, 5, 5, 3, 4)
mean(a)
sd(a)

# Create a new vector called a.z which is a standardized version of a
a.z <- (a - mean(a)) / sd(a)
a.z

# The mean of a.z should now be 0, and the standard deviation of a.z should now be 1
mean(a.z)
sd(a.z)

# 6.5.1 Ex: Evaluating a competition
pirat<-c('Heidi', 'Andrew', 'Becki', 'Madisen', 'David')
grogg <- c(12, 8, 1, 6, 2)
climbing <- c(100, 520, 430, 200, 700)

grogg.z <- (grogg - mean(grogg)) / sd(grogg)
climbing.z <- (climbing - mean(climbing)) / sd(climbing)

grogg.z
climbing.z

average.z <- (grogg.z + (climbing.z)) / 2
round(average.z, 1)


# Chapter 7 Indexing Vectors with [ ]
# Boat sale. Creating the data vectors
boat.names <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j")
boat.colors <- c("black", "green", "pink", "blue", "blue", 
                 "green", "green", "yellow", "black", "black")
boat.ages <- c(143, 53, 356, 23, 647, 24, 532, 43, 66, 86)
boat.prices <- c(53, 87, 54, 66, 264, 32, 532, 58, 99, 132)
boat.costs <- c(52, 80, 20, 100, 189, 12, 520, 68, 80, 100)

# What was the price of the first boat?
boat.prices[1]

# What were the ages of the first 5 boats?
boat.ages[1:5]

# What were the names of the black boats?
boat.names[boat.colors == "black"]

# What were the prices of either green or yellow boats?
boat.prices[boat.colors == "green" | boat.colors == "yellow"]

# Change the price of boat "s" to 100
boat.prices.new=boat.prices[boat.names == "j"] <- 100
boat.prices
boat.prices.new
# What was the median price of black boats less than 100 years old?
median(boat.prices[boat.colors == "black" & boat.ages < 100])

# How many pink boats were there?
sum(boat.colors == "pink")

# What percent of boats were younger than 100 years old?
mean(boat.ages < 100)


# 7.1 Numerical Indexing

# What is the first boat name?
boat.names[1]

# What are the first five boat colors?
boat.colors[1:5]

# What is every second boat age?
boat.ages[seq(1, 5, by = 2)]

# What is the first boat age (3 times)
boat.ages[c(1, 1, 1)]
## [1] 143 143 143

# If it makes your code clearer, you can define an indexing object before doing your actual indexing. 
# For example, let’s define an object called my.index and use this object to index our data vector


my.index <- 3:5
boat.names[my.index]

# 7.2 Logical Indexing


a <- c(1, 2, 3, 4, 5)
b=a[c(TRUE, FALSE, TRUE, FALSE, TRUE)]
b

# Which ages are > 100?
boat.ages > 100

# Which ages are equal to 23?
boat.ages == 23

# Which boat names are equal to c?
boat.names == "c"


# Which boats had a higher price than cost?
boat.prices > boat.costs

# Which boats had a lower price than cost?
boat.prices < boat.costs

# What were the prices of boats older than 100?
boat.prices[boat.ages > 100]

# Which boats are older than 100 years?
boat.ages > 100

# Writing the logical index by hand (you'd never do this!)
#  Show me all of the boat prices where the logical vector is TRUE:
boat.prices[c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, FALSE, FALSE)]


# Doing it all in one step! You get the same answer:
boat.prices[boat.ages > 100]


# 7.2.1 & (and), | (or), %in%

# Which boats had prices greater than 200 OR less than 100?
boat.prices > 200 | boat.prices < 100

# What were the NAMES of these boats
boat.names[boat.prices > 200 | boat.prices < 100]

# Boat names of boats with a color of black OR with a price > 100
boat.names[boat.colors == "black" | boat.prices > 100]

# Names of blue boats with a price greater than 200
boat.names[boat.colors == "blue" & boat.prices > 200]

# Which boats were eithe black or brown, AND had a price less than 100?
(boat.colors == "black" | boat.colors == "brown") & boat.prices < 100

# What were the names of these boats?
boat.names[(boat.colors == "black" | boat.colors == "brown") & boat.prices < 100]

x <- c("a", "t", "a", "b", "z")
x == "a" | x == "b" | x == "c" | x == "d"
x %in% c("a", "b", "c", "d")

# 7.2.2 Counts and percentages from logical vectors
x <- c(1, 2, 3, -5, -5, -5, -5, -5)
x>0
sum(x>0)
mean(x>0)

# 7.2.3 Additional Logical functions
# is.na(x)	Which values in x are NA?	
is.na(c(2, NA, 5))
# is.finite(x)	Which values in x are numbers?
is.finite(c(NA, 89, 0))
# duplicated(x)	Which values in x are duplicated?
duplicated(c(1,4,1,2))
# which(x)	Which values in x are TRUE?
which(c(TRUE, FALSE, TRUE))

# A vector of sex information
sex <- c("m", "m", "f", "m", "f", "f")

# Which values of sex are m?
which(sex == "m")

# Which values of sex are f?
which(sex == "f")


# 7.3 Changing values of a vector
a <- rep(1, 10)
a[1:5] <- 9
a
a[6:10] <- 0
a

# x is a vector of numbers that should be from 1 to 10
x <- c(5, -5, 7, 4, 11, 5, -2)
# Assign values less than 1 to 1
x[x < 1] <- 1
# Assign values greater than 10 to 10
x[x > 10] <- 10
# Print the result!
x


a <- rep(1, 10)
a[1:5] <- c(9, 9, 9, 9, 9)
a
a[1:5] <- 9
a

# 7.3.1 Ex: Fixing invalid responses to a Happiness survey

# Assigning and indexing is a particularly helpful tool when, for example, you want to remove invalid 
# values in a vector before performing an analysis. For example, let’s say you asked 10 people how happy 
# they were on a scale of 1 to 5 and received the following responses:

happy <- c(1, 4, 2, 999, 2, 3, -2, 3, 2, 999)
(happy%in% 1:5)
(happy%in% 1:5)==FALSE
invalid<-(happy%in% 1:5)==FALSE
invalid
# Convert any invalid values in happy to NA
happy[invalid] <- NA
happy

# Include na.rm = TRUE to ignore NA values
mean(happy, na.rm = TRUE)


##Chapter 8 Matrices and Dataframes

# -----------------------------
# Basic dataframe operations
# -----------------------------

# Create a dataframe of boat sale data called bsale
bsale <- data.frame(name = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j"),
                    color = c("black", "green", "pink", "blue", "blue", 
                              "green", "green", "yellow", "black", "black"),
                    age = c(143, 53, 356, 23, 647, 24, 532, 43, 66, 86),
                    price = c(53, 87, 54, 66, 264, 32, 532, 58, 99, 132),
                    cost = c(52, 80, 20, 100, 189, 12, 520, 68, 80, 100),
                    stringsAsFactors = FALSE)   # Don't convert strings to factors!

# Explore the bsale dataset:
head(bsale)     # Show me the first few rows
str(bsale)      # Show me the structure of the data
View(bsale)     # Open the data in a new window
names(bsale)    # What are the names of the columns?
nrow(bsale)     # How many rows are there in the data?

# Calculating statistics from column vectors
mean(bsale$age)       # What was the mean age?
table(bsale$color)    # How many boats were there of each color?
max(bsale$price)      # What was the maximum price?

# Adding new columns
bsale$id <- 1:nrow(bsale)
bsale$age.decades <- bsale$age / 10
bsale$profit <- bsale$price - bsale$cost

# What was the mean price of green boats?
with(bsale, mean(price[color == "green"]))

# What were the names of boats older than 100 years?
with(bsale, name[age > 100])

# What percent of black boats had a positive profit?
with(subset(bsale, color == "black"), mean(profit > 0))

# Save only the price and cost columns in a new dataframe
bsale.2 <- bsale[c("price", "cost")]

# Change the names of the columns to "p" and "c"
names(bsale.2) <- c("p", "c")

# Create a dataframe called old.black.bsale containing only data from black boats older than 50 years
old.black.bsale <- subset(bsale, color == "black" & age > 50)


# 8.1 What are matrices and dataframes?

# a matrix or dataframe as a combination of n vectors, where each vector has a length of m.
# a matrix can contain either character or numeric columns, 
# a dataframe can contain both numeric and character columns.

# If dataframes are more flexible than matrices, why do we use matrices at all? The answer is that, 
# because they are simpler, matrices take up less computational space than dataframes. 
# Additionally, some functions require matrices as inputs to ensure that they work correctly.

# 8.2 Creating matrices and dataframes
# 8.2.1 cbind(), rbind()
x <- 1:5
y <- 6:10
z <- 11:15

# Create a matrix where x, y and z are columns
cbind(x, y, z)

# Create a matrix where x, y and z are rows
rbind(x, y, z)

# 8.2.2 matrix()
cbind(c(1, 2, 3, 4, 5),
      c("a", "b", "c", "d", "e"))


# Create a matrix of the integers 1:10, with 5 rows and 2 columns

matrix(data = 1:10,
       nrow = 5,
       ncol = 2)

# Now with 2 rows and 5 columns
matrix(data = 1:10,
       nrow = 2,
       ncol = 5)

# 8.2.3 data.frame()

# Create a dataframe of survey data
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))
survey
str(survey)

# 8.2.3.1 stringsAsFactors = FALSE

# By default, the data.frame() function will automatically convert any string columns to a specific 
# type of object called a factor in R. A factor is a nominal variable that has a well-specified possible 
# set of values that it can take on. For example, one can create a factor sex that can only take on the values
# "male" and "female".


# Show me the structure of the survey dataframe
str(survey)

# Create a dataframe of survey data WITHOUT factors
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23),
                     stringsAsFactors = FALSE)

survey
str(survey)

# 8.2.4 Dataframes pre-loaded in R

# ChickWeight:	Experiment on the effect of diet on early growth of chicks.
# InsectSprays:	The counts of insects in agricultural experimental units treated with different insecticides.
# ToothGrowth:	Length of odontoblasts (cells responsible for tooth growth) in 60 guinea pigs.
# PlantGrowth:	Results from an experiment to compare yields (as measured by dried weight of plants) 
                # obtained under a control and two different treatment conditions.


# 8.3 Matrix and dataframe functions

# 8.3.1 head(), tail(), View()

# head() shows the first few rows
head(ChickWeight)
# tail() shows he last few rows
tail(ChickWeight)
# View() opens the entire dataframe in a new window
View(ChickWeight)


# 8.3.2 summary(), str()

# Print summary statistics of ToothGrowth to the console
summary(ToothGrowth)
# Print additional information about ToothGrowth to the console
str(ToothGrowth)


# 8.4 Dataframe column names

# What are the names of columns in the ToothGrowth dataframe?
names(ToothGrowth)
# Return the len column of ToothGrowth
ToothGrowth$len
# What is the mean of the len column of ToothGrowth?
mean(ToothGrowth$len)
# Give me a table of the supp column of ToothGrowth.
table(ToothGrowth$supp)
# Give me the len AND supp columns of ToothGrowth
head(ToothGrowth[c("len", "supp")])


# 8.4.1 Adding new columns
# Create a new dataframe called survey
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "age" = c(24, 25, 42, 56, 22))


# Add a new column called sex to survey
survey$sex <- c("m", "m", "f", "f", "m")
survey

# 8.4.2 Changing column names

# Change name of 1st column of df to "a"
names(df)[1] <- "a"
# Change name of 2nd column of df to "b"
names(df)[2] <- "b"
# Change the name of the first column of survey to "participant.number"
names(survey)[1] <- "participant.number"
survey


# Warning!!!: Change column names with logical indexing to avoid errors!
# To avoid these issues, it’s better to change column names using a logical vector using the format 
# names(df)[names(df) == "old.name"] <- "new.name". Here’s how to read this: “Change the names of df, 
# but only where the original name was "old.name", to "new.name".


# Change the column name from age to age.years
names(survey)[names(survey) == "age"] <- "years"
survey

# 8.5 Slicing dataframes

# 8.5.1 Slicing with [, ]
# Return row 1
df[1, ]
# Return column 5
df[, 5]
# Rows 1:5 and column 2
df[1:5, 2]

# Give me the rows 1-6 and column 1 of ToothGrowth
ToothGrowth[1:6, 1]

# Give me rows 1-3 and columns 1 and 3 of ToothGrowth
ToothGrowth[1:3, c(1,3)]

# Give me the 1st row (and all columns) of ToothGrowth
ToothGrowth[1, ]

# Give me the 2nd column (and all rows) of ToothGrowth
ToothGrowth[, 2]


# 8.5.2 Slicing with logical vectors
# Create a new df with only the rows of ToothGrowth where supp equals VC
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]
head(ToothGrowth)

# Create a new df with only the rows of ToothGrowth where supp equals OJ and dose < 1

ToothGrowth.OJ.a <- ToothGrowth[ToothGrowth$supp == "OJ" &
                                  ToothGrowth$dose < 1, ]


ToothGrowth.OJ.a 


# 8.5.3 Slicing with subset()
# Argument: Description
# x:	A dataframe you want to subset
# subset: A logical vector indicating the rows to keep
# select: The columns you want to keep

# Get rows of ToothGrowth where len < 20 AND supp == "OJ" AND dose >= 1
subset(x = ToothGrowth,
       subset = len < 20 &
         supp == "OJ" &
         dose >= 1)
# Get rows of ToothGrowth where len > 30 AND supp == "VC", but only return the len and dose columns
subset(x = ToothGrowth,
       subset = len > 30 & supp == "VC",
       select = c(len, dose))

# 8.6 Combining slicing with functions

# What is the mean tooth length of Guinea pigs given OJ?
# Step 1: Create a subsettted dataframe called oj

oj <- subset(x = ToothGrowth,
             subset = supp == "OJ")
# Step 2: Calculate the mean of the len column from
# the new subsetted dataset
mean(oj$len)

# We can also get the same solution using logical indexing
# Step 1: Create a subsettted dataframe called oj
oj <- ToothGrowth[ToothGrowth$supp == "OJ",]
# Step 2: Calculate the mean of the len column from
#  the new subsetted dataset
mean(oj$len)

# Or we can do it all in one line by only referring to column vectors:
mean(ToothGrowth$len[ToothGrowth$supp == "OJ"])


# 8.6.1 with()
# The with() function helps to save you some typing when you are using multiple columns from a dataframe. 
# Specifically, it allows you to specify a dataframe (or any other object in R) once at the beginning of a 
# line – then, for every object you refer to in the code in that line, R will assume you’re referring to 
# that object in an expression.

health <- data.frame("age" = c(32, 24, 43, 19, 43),
                     "height" = c(1.75, 1.65, 1.50, 1.92, 1.80),
                     "weight" = c(70, 65, 62, 79, 85))
# Calculate bmi
health$weight / health$height ^ 2

# Save typing by using with()
with(health, height / weight ^ 2)

# Long code
health$weight + health$height / health$age + 2 * health$height
# Short code that does the same thing
with(health, weight + height / age + 2 * height)


## Chapter 9 Importing, saving and managing data

# Code:	Description
# ls():	Display all objects in the current workspace
# rm(a, b, ..):	Removes the objects a, b… from your workspace
# rm(list = ls()):	Removes all objects in your workspace
# getwd():	Returns the current working directory
# setwd(file = "dir)	:Changes the working directory to a specified file location
# list.files():	Returns the names of all files in the working directory
# write.table(x, file = "mydata.txt", sep):	writes the object x to a text file called mydata.txt. 
                                           # Define how the columns will be separated with 
                                           # sep (e.g.; sep = "," for a comma–separated file, and 
                                           # sep = \t" for a tab–separated file).
# save(a, b, .., file = "myimage.RData):	Saves objects a, b, … to myimage.RData
# save.image(file = "myimage.RData")	:Saves all objects in your workspace to myimage.RData
# load(file = "myimage.RData"):	Loads objects in the file myimage.RData
# read.table(file = "mydata.txt", sep, header):	Reads a text file called mydata.txt, 
                                          #define how columns are separated with 
                                          # sep (e.g. sep = "," for comma-delimited files, and 
                                          # sep = "\t" for tab-delimited files), and whether there 
                                          # is a header column with header = TRUE

# 9.2 The working directory
# Print my current working directory
getwd()
# Change my working directory to the following path
setwd(dir = "D:\0_EverydayPractice\0dataAnalysis\R")

# 9.3 Projects in RStudio
# If you’re using RStudio, you have the option of creating a new R project. A project is simply a working 
# directory designated with a .RProj file. When you open a project 
# (using File/Open Project in RStudio or by double–clicking on the .Rproj file outside of R), 
# the working directory will automatically be set to the directory that the .RProj file is located in.
# It is recommended creating a new R Project whenever you are starting a new research project. 
# Once you’ve created a new R project, you should immediately create folders in the directory which will 
# contain your R code, data files, notes, and other material relevant to your project

# 9.4 The workspace
# The workspace (aka your working environment) represents all of the objects and functions you have either 
# defined in the current session, or have loaded from a previous session. When you started RStudio for the 
# first time, the working environment was empty because you hadn’t created any new objects or functions. 
# However, as you defined new objects and functions using the assignment operator <-, these new objects were 
# stored in your working environment. When you closed RStudio after defining new objects, you likely got a 
# message asking you “Save workspace image…?”" This is RStudio’s way of asking you if you want to save all 
# the objects currently defined in your workspace as an image file on your computer.

# 9.4.1 ls()
# Print all the objects in my workspace
ls()

# 9.5 .RData files
# The best way to store objects from R is with .RData files. .RData files are specific to R and can store 
# as many objects as you’d like within a single file. Think about that. If you are conducting an analysis 
# with 10 different dataframes and 5 hypothesis tests, you can save all of those objects in a single file 
# called ExperimentResults.RData.

# 9.5.1 save()
# Create some objects that we'll save later
study1.df <- data.frame(id = 1:5, 
                        sex = c("m", "m", "f", "f", "m"), 
                        score = c(51, 20, 67, 52, 42))

score.by.sex <- aggregate(score ~ sex, 
                          FUN = mean, 
                          data = study1.df)

study1.htest <- t.test(score ~ sex, 
                       data = study1.df)

# Save three objects as a new .RData file in the data folder of my current working directory
save(study1.df, score.by.sex, study1.htest,
     file = "data/study1.RData")
# Once you do this, you should see the study1.RData file in the data folder of your working directory. 
# This file now contains all of your objects that you can easily access later using the load() 
# function (we’ll go over this in a second…).

# 9.5.2 save.image()
# If you have many objects that you want to save, then using save can be tedious as you’d have to 
# type the name of every object. To save all the objects in your workspace as a .RData file, use the 
# save.image() function. For example, to save my workspace in the data folder located in my working 
# directory, I’d run the following:

# Save my workspace to complete_image.RData in the data folder of my working directory
save.image(file = "data/projectimage.RData")
# Now, the projectimage.RData file contains all objects in your current workspace.

# 9.5.3 load()

# Load objects in study1.RData into my workspace
load(file = "data/study1.RData")
# Load objects in projectimage.RData into my workspace
load(file = "data/projectimage.RData")

# 9.5.4 rm()
# To remove objects from your workspace, use the rm() function. Why would you want to remove objects? 
# At some points in your analyses, you may find that your workspace is filled up with one or more objects 
# that you don’t need – either because they’re slowing down your computer, or because they’re 
# just distracting.

# Remove huge.df from workspace
rm(huge.df)
# Remove ALL objects from workspace
rm(list = ls())


# 9.6 .txt files

# While .RData files are great for saving R objects, sometimes you’ll want to export data 
# (usually dataframes) as a simple .txt text file that other programs can also read. 
# To do this, use the write.table() function.

# 9.6.1 write.table()
# Write the pirates dataframe object to a tab-delimited
#  text file called pirates.txt in my working directory

write.table(x = pirates,
            file = "pirates.txt",  # Save the file as pirates.txt
            sep = "\t")            # Make the columns tab-delimited

# 9.6.2 read.table()
# If you have a .txt file that you want to read into R, use the read.table() function

# Read a tab-delimited text file called mydata.txt 
# from the data folder in my working directory into
# R and store as a new object called mydata

mydata <- read.table(file = 'data/mydata.txt',    # file is in a data folder in my working directory
                     sep = '\t',                  # file is tab--delimited
                     header = TRUE,               # the first row of the data is a header row
                     stringsAsFactors = FALSE)    # do NOT convert strings to factors!!



# 9.6.3 Reading files directly from a web URL

# Read a text file from the web
fromweb <- read.table(file = 'http://goo.gl/jTNf6P',
                      sep = '\t',
                      header = TRUE)
fromweb

# 9.7 Excel, SPSS, and other data files

# import SPSS or Excel files directly in R, I always recommend first exporting/saving the original SPSS or 
# Excel files as text .txt. files – both SPSS and Excel have options to do this. Then, once you have exported 
# the data to a .txt file, you can read it into R using read.table().
# If you try to export an Excel file to a text file, it is a good idea to clean the file as much as 
# you can first by, for example, deleting unnecessary columns, making sure that all numeric columns have
# numeric data, making sure the column names are simple (ie., single words without spaces or special  characters). 

# If you absolutely have to read a non-text file into R, check out the package called foreign 
# (install.packages("foreign")). This package has functions for importing Stata, SAS and SPSS 
# files directly into R. To read Excel files, try the package xlsx (install.packages("xlsx")). 

# There are many functions other than read.table() for importing data. For example, the functions read.csv 
# and read.delim are specific for importing comma-separated and tab-separated text files. In practice, 
# these functions do the same thing as read.table, but they don’t require you to specify a sep argument. 


## Chapter 10 Advanced dataframe manipulation

# ------------------
# Basic operations
# ------------------

# Exam data
exam <- data.frame(
  id = 1:5,
  q1 = c(1, 5, 2, 3, 2),
  q2 = c(8, 10, 9, 8, 7),
  q3 = c(3, 7, 4, 6, 4))

# Demographic data
demographics <- data.frame(
  id = 1:5,
  sex = c("f", "m", "f", "f", "m"),
  age = c(25, 22, 24, 19, 23))

# Combine exam and demographics
combined <- merge(x = exam, 
                  y = demographics, 
                  by = "id")

# Mean q1 score for each sex
aggregate(formula = q1 ~ sex, 
          data = combined, 
          FUN = mean)


# Median q3 score for each sex, but only for those
#   older than 20
aggregate(formula = q3 ~ sex, 
          data = combined,
          subset = age > 20,
          FUN = mean)

# Many summary statistics by sex using dplyr!
library(dplyr)
combined %>% group_by(sex) %>%
  summarise(
    q1.mean = mean(q1),
    q2.mean = mean(q2),
    q3.mean = mean(q3),
    age.mean = mean(age),
    N = n())


# 10.1 order(): Sorting data

# Sort the pirates dataframe by height
pirates <- pirates[order(pirates$height),]

# Look at the first few rows and columns of the result
pirates[1:5, 1:4]

# Sort the pirates dataframe by height in decreasing order
pirates <- pirates[order(pirates$height, decreasing = TRUE),]

# Look at the first few rows and columns of the result
pirates[1:5, 1:4]

# Sort the pirates dataframe by sex and then height
pirates <- pirates[order(pirates$sex, pirates$height),]

# 10.2 merge(): Combining data

# Argument:	Description
# x, y:	Two dataframes to be merged
# by	: A string vector of 1 or more columns to match the data by. For example, by = "id" will combine columns 
      # that have matching values in a column called "id". by = c("last.name", "first.name") will combine 
      # columns that have matching values in both "last.name" and "first.name"
# all:	A logical value indicating whether or not to include rows with non-matching values of by.

# Results from a risk survey
risk.survey <- data.frame(
  "participant" = c(1, 2, 3, 4, 5),
  "risk.score" = c(3, 4, 5, 3, 1))

happiness.survey <- data.frame(
  "participant" = c(4, 2, 5, 1, 3),
  "happiness.score" = c(20, 40, 50, 90, 53))

# Combine the risk and happiness surveys by matching participant.id
combined.survey <- merge(x = risk.survey,
                         y = happiness.survey,
                         by = "participant",
                         all = TRUE)

# Print the result
combined.survey


# 10.3 aggregate(): Grouped aggregation
#Argument:	Description
#formula:	A formula in the form y ~ x1 + x2 + ... where y is the dependent variable, and x1, x2… are the 
          # independent variables. For example, salary ~ sex + age will aggregate a salary column at every 
          # unique combination of sex and age
#FUN:	A function that you want to apply to y at every level of the independent variables. E.g.; mean, or max.
#data:	The dataframe containing the variables in formula
#subset:	A subset of data to analyze. For example, subset(sex == "f" & age > 20) would restrict the analysis to females older than 20. You can ignore this argument to use all data.

# General structure of aggregate()
aggregate(formula = dv ~ iv, # dv is the data, iv is the group 
          FUN = fun, # The function you want to apply
          data = df) # The dataframe object containing dv and iv

# The WRONG way to do grouped aggregation. We should be using aggregate() instead!
mean(ChickWeight$weight[ChickWeight$Diet == 1])
mean(ChickWeight$weight[ChickWeight$Diet == 2])
mean(ChickWeight$weight[ChickWeight$Diet == 3])
mean(ChickWeight$weight[ChickWeight$Diet == 4])

# Calculate the mean weight for each value of Diet
aggregate(formula = weight ~ Diet,  # DV is weight, IV is Diet
          FUN = mean,               # Calculate the mean of each group
          data = ChickWeight)       # dataframe is ChickWeight

head(ChickWeight)



# Calculate the mean weight for each value of Diet, But only when chicks are less than 10 weeks old

aggregate(formula = weight ~ Diet,  # DV is weight, IV is Diet
          FUN = mean,               # Calculate the mean of each group
          subset = Time < 10,       # Only when Chicks are less than 10 weeks old
          data = ChickWeight)       # dataframe is ChickWeight


# Calculate the mean weight for each value of Diet and Time, But only when chicks are 0, 2 or 4 weeks okd

aggregate(formula = weight ~ Diet + Time,  # DV is weight, IVs are Diet and Time
          FUN = mean,                      # Calculate the mean of each group
          subset = Time %in% c(0, 2, 4),   # Only when Chicks are 0, 2, and 4 weeks old
          data = ChickWeight)              # dataframe is ChickWeight


# 10.4 dplyr

# The dplyr package allows you to do all kinds of analyses quickly and easily. 
# It is especially useful for creating tables of summary statistics across specific groups of data.

install.packages("dplyr")     # Install dplyr (only necessary once)
library("dplyr")              # Load dplyr


# dplyr works by combining objects (dataframes and columns in dataframes), functions (mean, median, etc.), 
# and verbs (special commands in dplyr). In between these commands is a new operator called the pipe which 
# looks like this: %>%}. The pipe simply tells R that you want to continue executing some functions or verbs 
# on the object you are working on. You can think about this pipe as meaning ‘and then…’

# Template for using dplyr
my.df %>%                  # Specify original dataframe
  filter(iv3 > 30) %>%     # Filter condition
  group_by(iv1, iv2) %>%   # Grouping variable(s)
  summarise(
    a = mean(col.a),       # calculate mean of column col.a in my.df
    b = sd(col.b),         # calculate sd of column col.b in my.df
    c = max(col.c))        # calculate max on column col.c in my.df, ...


pirates.agg <- pirates %>%                   # Start with the pirates dataframe
  filter(headband == "yes") %>% # Only pirates that wear hb
  group_by(sex, college) %>%    # Group by these variables
  summarise( 
    age.mean = mean(age),      # Define first summary...
    tat.med = median(tattoos), # you get the idea...
    n = n()                    # How many are in each group? 
  ) # End

# Print the result
pirates.agg


movies %>% # From the movies dataframe...
  filter(genre != "Horror" & time > 50) %>% # Select only these rows
  group_by(rating, sequel) %>% # Group by rating and sequel
  summarise( #
    frequency = n(), # How many movies in each group?
    budget.mean = mean(budget, na.rm = T),  # Mean budget?
    revenue.mean = mean(revenue.all), # Mean revenue?
    billion.p = mean(revenue.all > 1000)) # Percent of movies with revenue > 1000?


# 10.4.1 Additional dplyr help

# In fact, you can perform almost all of your R tasks, from loading, to managing, to saving data, 
# in the dplyr framework. For more tips on using dplyr, check out the dplyr vignette at https://cran.r-project.org/web/packages/dplyr/vignettes/introduction.html. 
# Or open it in RStudio by running the following command:

# Open the dplyr introduction in R
vignette("introduction", package = "dplyr")


# 10.5 Additional aggregation functions

# 10.5.1 rowMeans(), colMeans()
# To easily calculate means (or sums) across all rows or columns in a matrix or dataframe, 
# use rowMeans(), colMeans(), rowSums() or colSums().

# Some exam scores
exam <- data.frame("q1" = c(1, 0, 0, 0, 0),
                   "q2" = c(1, 0, 1, 1, 0),
                   "q3" = c(1, 0, 1, 0, 0),
                   "q4" = c(1, 1, 1, 1, 1),
                   "q5" = c(1, 0, 0, 1, 1))

# What percent did each student get correct?
rowMeans(exam)
# What percent of students got each question correct?
colMeans(exam)

# 10.5.2 apply family

# There is an entire class of apply functions in R that apply functions to groups of data. 
# For example, tapply(), sapply() and lapply() each work very similarly to aggregate(). 
# For example, you can calculate the average length of movies by genre with tapply() as follows.

with(movies, tapply(X = time,        # DV is time
                    INDEX = genre,   # IV is genre
                    FUN = mean,      # function is mean
                    na.rm = TRUE))   # Ignore missing
# tapply(), sapply(), and lapply() all work very similarly, their main difference is in the structure of 
# their output. For example, lapply() returns a list (we’ll cover lists in a future chapter).




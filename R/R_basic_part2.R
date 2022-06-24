library(yarrr)



## Chapter 11 Plotting (I)

# basic scatterplot

plot(x = 1:10,
     y = 1:10,
     xlab = "X Axis label",
     ylab = "Y Axis label",
     main = "Main Title")


# 11.1 Colors
# color argument (usually col) that allows you to specify the color
# To see all 657 color names in R, run the code colors(). 
# Or to see an interactive demo of colors, run demo("colors").
colors()
demo('wheat3')
# 11.1.1 Colors by name

#11.1.2 gray()
# level: Lightness: level = 0 => totally black, level = 1 => totally white, 
# alpha: Transparency: alpha = 0 => totally transparent, alpha = 1 => not transparent at all.

# Plot with Standard Colors
plot(x = pirates$height, 
     y = pirates$weight, 
     col = "blue", 
     pch = 16, 
     main = "col ='blue'")

# Plot with transparent colors using the transparent() function in the yarrr package
plot(x = pirates$height, 
     y = pirates$weight, 
     col = yarrr::transparent("blue", trans.val = .9), 
     pch = 16, 
     main = "col = yarrr::transparent('blue', .9)")



# 11.2 Plotting arguments

plot(x = 1:10,                         # x-coordinates
     y = 1:10,                         # y-coordinates
     type = "p",                       #  'l': lines, 'p': points, 'b': lines & points, 'n': no plotting
     main = "My First Plot",
     xlab = "This is the x-axis label",
     ylab = "This is the y-axis label",
     xlim = c(0, 11),                  # Min and max values for x-axis
     ylim = c(0, 11),                  # Min and max values for y-axis
     col = "blue",                     # Color of the points
     pch = 16,                         # Type of symbol (16 means Filled circle)
     cex = 1)                          # Size of the symbols


library(ggpubr)

# x <- c(sapply(seq(5, 25, 5), function(i) rep(i, 5)))
# y <- rep(seq(25, 5, -5), 5)
# 
# plot(x, y, pch = 1, cex = 3, yaxt = "n", xaxt = "n",
#      ann = FALSE, xlim = c(1, 29), ylim = c(0, 30), lwd = 1)
# text(x - 1.5, y, 1:25)

ggpubr::show_point_shapes()


# 11.4 Histogram: hist()
# x: vector of values
# breaks: bin size (?hist for details)
# freq: freq = TRUE shows frequencies, freq = FALSE shows probabilities
# colrr, border: colors of the bin filling and borer

hist(x = ChickWeight$weight,
     main = "Two Histograms in one",
     xlab = "Weight",
     ylab = "Frequency",
     breaks = 20,
     freq=TRUE, 
     xlim = c(0, 500),
     col = gray(0, .5))

hist(x = ChickWeight$weight[ChickWeight$Diet == 1],
     main = "Two Histograms in one",
     xlab = "Weight",
     ylab = "Frequency",
     breaks = 20,
     freq=TRUE,
     xlim = c(0, 500),
     col = gray(0, .5))

hist(x = ChickWeight$weight[ChickWeight$Diet == 2],
     breaks = 30,
     add = TRUE, # Add plot to previous one!
     col = gray(1, .8))


# 11.5 Barplot: barplot()

# Calculate mean weights for each time period
diet.weights <- aggregate(weight ~ Time, 
                          data = ChickWeight,
                          FUN = mean)
View(diet.weights)

# Create barplot
barplot(height = diet.weights$weight,
        names.arg = diet.weights$Time,
        xlab = "Week",
        ylab = "Average Weight",
        main = "Average Chicken Weights by Time",
        col = "mistyrose")


# 11.5.1 Clustered barplot

swim.data <- cbind(c(2.1, 3), # Naked Times
                   c(1.5, 3)) # Clothed Times

colnames(swim.data) <- c("Naked", "Clothed")
rownames(swim.data) <- c("No Shark", "Shark")

# Print result
swim.data

barplot(height = swim.data,
        beside = TRUE,                        # Put the bars next to each other
        legend.text = TRUE,                   # Add a legend
        col = c(transparent("green", .2), 
                transparent("red", .2)),
        main = "Swimming Speed Experiment",
        ylab = "Speed (in meters / second)",
        xlab = "Clothing Condition",
        ylim = c(0, 4))

# 11.6 pirateplot()

yarrr::pirateplot(formula = weight ~ Time, # dv is weight, iv is Diet
                  data = ChickWeight,
                  main = "Pirateplot of chicken weights",
                  xlab = "Diet",
                  ylab = "Weight")

# 11.6.1 Pirateplot themes
yarrr::pirateplot(formula = height ~ sex + headband,    # DV = height, IV1 = sex, IV2 = headband
                  data = pirates,           
                  theme = 3,
                  main = "Pirate Heights",
                  pal = "gray")

# 11.6.2 Customizing pirateplots

# element:	color:	opacity
#points:	point.col, point.bg:	point.o
#beans:	bean.f.col, bean.b.col:	bean.f.o, bean.b.o
#bar:	bar.f.col, bar.b.col:	bar.f.o, bar.b.o
#inf:	inf.f.col, inf.b.col:	inf.f.o, inf.b.o
#avg.line:	avg.line.col:	avg.line.o

#* Note: Arguments with .f. correspond to the filling of an element, 
#* while .b. correspond to the border of an element:


pirateplot(formula = weight ~ Time,
           data = ChickWeight,
           theme = 0,
           main = "Fully customized pirateplot",
           pal = "southpark", # southpark color palette
           bean.f.o = .6, # Bean fill
           point.o = .3,  # Points
           inf.f.o = .7,  # Inference fill
           inf.b.o = .8,  # Inference border
           avg.line.o = 1, # Average line
           bar.f.o = .5,  # Bar
           inf.f.col = "white", # Inf fill col
           inf.b.col = "black", # Inf border col
           avg.line.col = "black", # avg line col
           bar.f.col = gray(.8), # bar filling color
           point.pch = 21,
           point.bg = "white",
           point.col = "black",
           point.cex = .7)
#* If you don’t want to start from scratch, you can also start with a theme, and then make 
pirateplot(formula = weight ~ Time,
           data = ChickWeight,
           main = "Adjusting an existing theme",
           theme = 2,  # Start with theme 2
           inf.f.o = 0, # Turn off inf fill
           inf.b.o = 0, # Turn off inf border
           point.o = .2,   # Turn up points
           bar.f.o = .5, # Turn up bars
           bean.f.o = .4, # Light bean filling
           bean.b.o = .2, # Light bean border
           avg.line.o = 0, # Turn off average line
           point.col = "black") # Black points



#* selective adjustments:
# Reducing a pirateplot to a (at least colorful) barplot
pirateplot(formula = weight ~ Diet,
           data = ChickWeight,
           main = "Reducing a pirateplot to a (horrible) barplot",
           theme = 0,                                    # Start from scratch
           pal = "black",
           inf.disp = "line",                            # Use a line for inference
           inf.f.o = 1,                                  # Turn up inference opacity
           inf.f.col = "black",                          # Set inference line color
           bar.f.o = .3)  

#* additional arguments to pirateplot() that you can use to complete customize the look of 
#* your plot. To see them all, look at the help menu with ?pirateplot

# Element:	Argument:	Examples
# Background color:	back.col:	back.col = 'gray(.9, .9)'
# Gridlines:	gl.col, gl.lwd, gl.lty:	gl.col = 'gray', gl.lwd = c(.75, 0), gl.lty = 1
# Quantiles:	quant, quant.lwd, quant.col:	quant = c(.1, .9), quant.lwd = 1, quant.col = 'black'
# Average line:	avg.line.fun:	avg.line.fun = median
# Inference Calculation:	inf.method:	inf.method = 'hdi', inf.method = 'ci'
# Inference Display:	inf.disp:	inf.disp = 'line', inf.disp = 'bean', inf.disp = 'rect'


# Additional pirateplot customizations
pirateplot(formula = weight ~ Diet, 
           data = ChickWeight,
           main = "Adding quantile lines and background colors",
           theme = 2,
           cap.beans = TRUE,
           back.col = transparent("blue", .95), # Add light blue background
           gl.col = "gray", # Gray gridlines
           gl.lwd = c(.75, 0),
           inf.f.o = .6, # Turn up inf filling
           inf.disp = "bean", # Wrap inference around bean
           bean.b.o = .4, # Turn down bean borders
           quant = c(.1, .9), # 10th and 90th quantiles
           quant.col = "black") # Black quantile lines


# 11.7 Low-level plotting functions

# Function:	Outcome
# points(x, y):	Adds points
# abline(), segments():	Adds lines or segments
# arrows():	Adds arrows
# curve():	Adds a curve representing a function
# rect(),polygon():	Adds a rectangle or arbitrary shape
# text(), mtext():	Adds text within the plot, or to plot margins
# legend():	Adds a legend
# axis():	Adds an axis

# 11.7.1 Starting with a blank plot

# Create a blank plotting space
plot( x = 1,                
     xlab = "X Label", 
     ylab = "Y Label",
     xlim = c(0, 100), 
     ylim = c(0, 100),
     main = "Blank Plotting Canvas",
     type = "n")

# 11.7.2 points()
# To add new points to an existing plot, use the points() function. 
?points()


# Create a blank plot
plot(x = 1,
     type = "n",
     xlim = c(100, 225), 
     ylim = c(30, 110),
     pch = 16,
     xlab = "Height", 
     ylab = "Weight",
     main = "Adding points to a plot with points()")

View(pirates)
# Add coral2 points for male data
points(x = pirates$height[pirates$sex == "male"],
       y = pirates$weight[pirates$sex == "male"],
       pch = 16,
       col = transparent("coral2", trans.val = .8))


# Add steelblue points for female data
points(x = pirates$height[pirates$sex == "female"],
       y = pirates$weight[pirates$sex == "female"],
       pch = 16,
       col = transparent("steelblue3", trans.val = .8))

# 11.7.3 abline(), segments(), grid()

# Argument:	Outcome
# h, v:	Locations of horizontal and vertical lines (for abline() only)
# x0, y0, x1, y1:	Starting and ending coordinates of lines (for segments() only)
# lty:	Line type. 1 = solid, 2 = dashed, 3 = dotted, …
# lwd:	Width of the lines specified by a number. 1 is the default (.2 is very thin, 5 is very thick)
# col:	Line color


plot(x = pirates$weight,
     y = pirates$height,
     xlab = "weight",
     ylab = "height",
     main = "Adding reference lines with abline", 
     pch = 16, 
     col = gray(.5, .2))

# Add horizontal line at mean height
abline(h = mean(pirates$height), 
       lty = 2)                        # Dashed line

# Add vertical line at mean weight
abline(v = mean(pirates$weight),
       lty = 2)                        # Dashed line



# add a regression line (also called a line of best fit) to a scatterplot by entering a 
# regression object created with lm() as the main argument to abline():

# Add a regression line to a scatterplot
plot(x = pirates$height,
     y = pirates$weight,
     pch = 16,
     col = transparent("purple", .7),
     main = "Adding a regression line to a scatterplot()")

# Add the regression line
abline(lm(weight ~ height, data = pirates), 
       lty = 2)

# with the segments() function, you specify the beginning and end points of the segments with 
# the arguments x0, y0, x1, and y1.

# Before and after data
before <- c(2.1, 3.5, 1.8, 4.2, 2.4, 3.9, 2.1, 4.4)
after <- c(7.5, 5.1, 6.9, 3.6, 7.5, 5.2, 6.1, 7.3)

# Create plotting space and before scores
plot(x = rep(1, length(before)), 
     y = before, 
     xlim = c(.5, 2.5), 
     ylim = c(0, 11),
     ylab = "Score", 
     xlab = "Time",
     main = "Using segments() to connect points", 
     xaxt = "n")

# Add after scores
points(x = rep(2, length(after)), y = after)

# Add connections with segments()
segments(x0 = rep(1, length(before)), 
         y0 = before, 
         x1 = rep(2, length(after)), 
         y1 = after, 
         col = gray(0, .5))

# Add labels
mtext(text = c("Before", "After"), 
      side = 1, at = c(1, 2), line = 1) # mtext: add test to plot margins




# Add grid lines
plot(pirates$age,
     pirates$beard.length,
     pch = 16,
     col = gray(.1, .2), 
     main = "Add grid lines to a plot with grid()")

# Add gridlines
grid()

# 11.7.4 text()

# Argument:	Outcome
# x, y:	Coordinates of the labels
# labels:	Labels to be plotted
# cex:	Size of the labels
# adj:	Horizontal text adjustment. adj = 0 is left justified, adj = .5 is centered, and adj = 1 is right-justified
# pos:	Position of the labels relative to the coordinates. pos = 1, puts the label below the coordinates, 
        # while 2, 3, and 4 put it to the left, top and right of the coordinates respectively


plot( 1,
     xlim = c(0, 10), 
     ylim = c(0, 10), 
     type = "n")

text(x = c(1, 5, 9),
     y = c(9, 5, 1),
     labels = c("Put", "text", "here"))

# create a scatterplot of data, and add data labels above each point by including the pos = 3 argument:

# Create data vectors
height <- c(156, 175, 160, 172, 159, 165, 178)
weight <- c(65, 74, 69, 72, 66, 75, 75)
id <- c("andrew", "heidi", "becki", "madisen", "david", "vincent", "jack")

# Plot data
plot(x = height, 
     y = weight, 
     xlim = c(155, 180), 
     ylim = c(65, 80), 
     pch = 16,
     col = yarrr::piratepal("xmen"))

# Add id labels
text(x = height, 
     y = weight,
     labels = id, 
     pos = 3,
     cex=0.5)            # Put labels above the points


# separate the text into separate lines. To do this, add the text \n

plot(1, 
     type = "n",
     main = "The \\n tag",
     xlab = "", ylab = "")

# Text withoutbreaks
text(x = 1, y = 1.3, labels = "Text without \\n", font = 2)
text(x = 1, y = 1.2,
     labels = "Haikus are easy. But sometimes they don't make sense. Refrigerator",
     font = 3) # italic font
abline(h = 1, lty = 2)


# Text with  breaks
text(x = 1, y = .92, labels = "Text with \\n", font = 2)
text(x = 1, y = .7,
     labels = "Haikus are easy\nBut sometimes they don't make sense\nRefrigerator",
     font = 3)   # italic font


# 11.7.5 Combining text and numbers with paste()
# The paste function will be helpful to you anytime you want to combine either multiple strings, 
# or text and strings together.

# Create the plot
plot(x = ChickWeight$Time,
     y = ChickWeight$weight, 
     col = gray(.3, .5), 
     pch = 16,
     main = "Combining text with numeric scalers using paste()")
# Add reference line
abline(h = mean(ChickWeight$weight), 
       lty = 2)
# Add text
text(x = 3, 
     y = mean(ChickWeight$weight), 
     labels = paste("Mean weight =", 
                    round(mean(ChickWeight$weight), 2)),
     cex=0.8,
     pos = 3)

# 11.7.6 curve()

# expr: ou can either use base functions in R like expr = $x^2$, expr = x + 4 - 2, or 
# use your own custom functions such as expr = my.fun, where my.fun is previously defined 
# (e.g.; my.fun <- function(x) {dnorm(x, mean = 10, sd = 3))
# add: A logical value indicating whether or not to add the curve to an existing plot. 
# If add = FALSE, then curve() will act like a high-level plotting function and create a new plot. 
# If add = TRUE, then curve() will act like a low-level plotting function.

# Plot the function x^2 from -10 to +10
curve(expr = x^2, 
      from = -10, 
      to = 10, 
      lwd = 2)


# Plot the normal distribution with mean = 22 and sd = 3
# Create a function
my.fun <- function(x) {dnorm(x, mean = 2, sd = 3)}
curve(expr = my.fun, 
      from = -10, 
      to = 10, lwd = 2)

# create curves of several mathematical formulas.
# Create plotting space
plot(1, 
     xlim = c(-5, 5), 
     ylim = c(-5, 5),
     type = "n", 
     main = "Plotting function lines with curve()",
     ylab = "", 
     xlab = "")

# Add x and y-axis lines
abline(h = 0)
abline(v = 0)

# set up colors
col.vec <- piratepal("google")
col.vec
# x ^ 2
curve(expr = x^2, 
      from = -5, to = 5,
      add = TRUE, 
      lwd = 3, 
      col = col.vec[1])

# sin(x)
curve(expr = sin, 
      from = -5, to = 5,
      add = TRUE, 
      lwd = 3, 
      col = col.vec[2])

# dnorm(mean = 2, sd = .2)
my.fun <- function(x) {return(dnorm(x, mean = 2, sd = .2))}
curve(expr = my.fun, 
      from = -5, to = 5,
      add = TRUE, 
      lwd = 3, col = col.vec[3])

# Add legend
legend("bottomright",
       legend = c("x^2", "sin(x)", "dnorm(x, 2, .2)"),
       col = col.vec[1:3], 
       lwd = 3)



# 11.7.7 legend()

# Create plot with data from females
plot(x = pirates$age[pirates$sex == "female"], 
     y = pirates$tattoos[pirates$sex == "female"],
     xlim = c(0, 50),
     ylim = c(0, 20),
     pch = 16, 
     col = yarrr::transparent("red", .7),
     xlab = "Age", 
     ylab = "Tattoos", 
     main = "Adding a legend with legend()")

# Add data from males
points(x = pirates$age[pirates$sex == "male"], 
       y = pirates$tattoos[pirates$sex == "male"],
       pch = 16, 
       col = yarrr::transparent("blue", .7))

# Add legend
legend("bottomright",
       legend = c("Females", "Males"),
       col = transparent(c('red', 'blue'), .5),
       pch = c(16, 16),
       cex=0.7,
       bg = "white")


# more low-level plotting functions

plot(1, xlim = c(1, 100), 
     ylim = c(1, 100),
     type = "n", 
     xaxt = "n", 
     yaxt = "n",
     ylab = "", 
     xlab = "", 
     main = "Adding simple figures to a plot")

text(25, 95, labels = "rect()")
rect(xleft = 10, 
     ybottom = 70,
     xright = 40, 
     ytop = 90, 
     lwd = 2, 
     col = "coral")

text(25, 60, labels = "polygon()")
polygon(x = runif(6, 15, 35),
        y = runif(6, 40, 55),
        col = "skyblue")

text(25, 30, labels = "segments()")
segments(x0 = runif(5, 10, 40),
         y0 = runif(5, 5, 25),
         x1 = runif(5, 10, 40),
         y1 = runif(5, 5, 25), 
         lwd = 2)

text(75, 95, labels = "symbols(circles)")
symbols(x = runif(3, 60, 90),
        y = runif(3, 60, 70),
        circles = c(1, .1, .3),
        add = TRUE, 
        bg = gray(.5, .1))

text(75, 30, labels = "arrows()")
arrows(x0 = runif(3, 60, 90),
       y0 = runif(3, 10, 25),
       x1 = runif(3, 60, 90),
       y1 = runif(3, 10, 25),
       length = .1, 
       lwd = 2)

#* The runif() function generates random deviates of the uniform distribution and is written as 
#* runif(n, min = 0, max = 1) . We may easily generate n number of random samples within any interval, 
#* defined by the min and the max argument.
runif(3, 60, 90)



# 11.8 Saving plots to a file with pdf(), jpeg() and png()

# Step 1: Call the pdf command to start the plot
pdf(file = "/Users/ndphillips/Desktop/My Plot.pdf",   # The directory you want to save the file in
    width = 4, # The width of the plot in inches
    height = 4) # The height of the plot in inches

# Step 2: Create the plot with R code
plot(x = 1:10, 
     y = 1:10)
abline(v = 0) # Additional low-level plotting commands
text(x = 0, y = 1, labels = "Random text")

# Step 3: Run dev.off() to create the file!
dev.off()



# 11.9 Examples
# Drwa a modified version of a scatterplot

# Turn a boring scatterplot into a  balloonplot! 

# Create some random correlated data
x <- rnorm(50, mean = 50, sd = 10)
y <- x + rnorm(50, mean = 20, sd = 8)


# Set up the plotting space
plot(1, 
     bty = "n",  # controls the box style of base
     xlim = c(0, 100),
     ylim = c(0, 100),
     type = "n", xlab = "", ylab = "", 
     main = "Turning a scatterplot into a balloon plot!")

# Add gridlines
grid()

# Add Strings with segments()
segments(x0 = x + rnorm(length(x), mean = 0, sd = .5), 
         y0 = y - 10, 
         x1 = x, 
         y1 = y, 
         col = gray(.1, .95),
         lwd = .5)

# Add balloons
points(x, y, 
       cex = 2, # Size of the balloons
       pch = 21, 
       col = "white", # white border
       bg = yarrr::piratepal("basel"))  # Filling color



# Scatterplot with size and color of each point reflect how many tattoos the pirate has


# Just the first 100 pirates
pirates.r <- pirates[1:100,]
plot(x = pirates.r$height,
     y = pirates.r$weight,
     xlab = "height",
     ylab = "weight",
     main = "Specifying point sizes and colors with a 3rd variable",
     cex = pirates.r$tattoos  / 8,          # Point size reflects how many tattoos they have
     col = gray(1 - pirates.r$tattoos / 20)) # color reflects tattoos
grid()



## Chapter 12 Plotting (II)

# 12.1 More colors
# 12.1.1 piratepal()

yarrr::piratepal("all")

# Show me the basel palette
yarrr::piratepal("basel",            
                 plot.result = TRUE,
                 trans = .1)          # Slightly transparent

# Show me the pony palette
yarrr::piratepal("pony",            
                 plot.result = TRUE,
                 trans = .1)          # Slightly transparent

# Show me the evildead palette
yarrr::piratepal("evildead",            
                 plot.result = TRUE,
                 trans = .1)          # Slightly transparent

# Once you find a color palette you like, you can save the colors as a vector and assigning the result to
# an object. 

# Save the South Park palette to a vector
google.cols <- piratepal(palette = "google", 
                         trans = .2)

# Create a barplot with the google colors
barplot(height = 1:5,
        col = google.cols,
        border = "white",
        main = "Barplot with the google palette")



# 12.1.2 RColorBrewer
library("RColorBrewer")
display.brewer.all()

# 12.1.3 colorRamp2
# Generating colors that represent numerical data is with the function colorRamp2 
# in the circlize package (the same package that creates that really cool chordDiagram from Chapter 1). 
# The colorRamp2 function allows you to easily generate shades of colors based on numerical data.


# Create color function from colorRamp2

# color the points as a function of the number of packs of cigarettes per week that person smokes, 
# where a value of 0 packs is colored Blue, 10 packs is Orange, and 30 packs is Red. Moreover, 
# you want the values in between these break points of 0, 10 and 30 to be a mix of the colors.

smoking.colors <- circlize::colorRamp2(breaks = c(0, 15, 25),
                                       colors = c("blue", "green", "red"),
                                       transparency = .2)

plot(1, 
     xlim = c(-.5, 31.5), 
     ylim = c(0, .2),
     type = "n", 
     xlab = "Cigarette Packs",
     yaxt = "n", 
     ylab = "", 
     bty = "n",
     main = "colorRamp2 Example")

segments(x0 = c(0, 15, 30),
         y0 = rep(0, 3),
         x1 = c(0, 15, 30),
         y1 = rep(.1, 3),
         lty = 2)

points(x = 0:30,
       y = rep(.1, 31), 
       pch = 16,
       col = smoking.colors(0:30))

text(x = c(0, 15, 30), 
     y = rep(.15, 3),
     labels = c("Blue", "Green", "Red"))


# to plot data showing the relationship between the number of drinks someone has on average per week 
# and the resulting risk of some adverse health effect. 

# Create Data
drinks <- round(rnorm(100, mean = 10, sd = 4), 2)
smokes <- drinks + rnorm(100, mean = 5, sd = 2)
risk <- 1 / (1 + exp(-(drinks + smokes) / 20 + rnorm(100, mean = 0, sd = 1)))

# Create color function from colorRamp2
smoking.colors <- circlize::colorRamp2(breaks = c(0, 15, 30),
                                       colors = c("blue", "green", "red"),
                                       transparency = .3)

# Bottom Plot
par(mar = c(4, 4, 5, 1))
plot(x = drinks, 
     y = risk, 
     col = smoking.colors(smokes),
     pch = 16, cex = 1.2, main = "Plot of (Made-up) Data",
     xlab = "Drinks", ylab = "Risk")

mtext(text = "Point color indicates smoking rate", line = .5, side = 3)


# 12.1.4 Getting colors with a kuler
# use a color kuler. A color kuler is a tool that allows you to determine the exact RGB values 
# for a color on a screen. On a Mac, you can use the program called “Digital Color Meter.”

# Store the colors of google as a vector:
google.col <- c(
  rgb(19, 72, 206, maxColorValue = 255),    # Google blue
  rgb(206, 45, 35, maxColorValue = 255),    # Google red
  rgb(253, 172, 10, maxColorValue = 255),   # Google yellow
  rgb(18, 140, 70, maxColorValue = 255))    # Google green

# Print the result
google.col

plot(1, 
     xlim = c(0, 7), 
     ylim = c(0, 1),
     type = "n", 
     main = "Using colors stolen from a webpage")

points(x = 1:6, 
       y = rep(.4, 6),
       pch = 16,
       col = google.col[c(1, 2, 3, 1, 4, 2)],
       cex = 4)

text(x = 1:6, 
     y = rep(.7, 6),
     labels = c("G", "O", "O", "G", "L", "E"), 
     col = google.col[c(1, 2, 3, 1, 4, 2)],
     cex = 3)



# 12.2 Plot Margins
# You can adjust the size of the margins by specifying a margin parameter using the syntax 
# par(mar = c(bottom, left, top, right)), where the arguments bottom, left … are the size of 
# the margins. The default value for mar is c(5.1, 4.1, 4.1, 2.1). To change the size of the 
# margins of a plot you must do so with par(mar) before you actually create the plot.

# First Plot with small margins
par(mar = c(2, 2, 2, 2)) # Set the margin on all sides to 2
plot(1:10)
mtext("Small Margins", side = 3, line = 1, cex = 1.2)
mtext("par(mar = c(2, 2, 2, 2))", side = 3)

# Second Plot with large margins
par(mar = c(5, 5, 5, 5)) # Set the margin on all sides to 6
plot(1:10)
mtext("Large Margins", side = 3, line = 1, cex = 1.2)
mtext("par(mar = c(5, 5, 5, 5))", side = 3)

# 12.3 Arranging plots with par(mfrow) and layout()

par(mfrow = c(2, 2)) # Create a 2 x 2 plotting matrix
# The next 4 plots created will be plotted next to each other

# Plot 1
hist(rnorm(100))

# Plot 2
plot(pirates$weight, 
     pirates$height, 
     pch = 16, 
     col = gray(.3, .1))

# Plot 3
pirateplot(weight ~ Diet, 
           data = ChickWeight, 
           pal = "info", 
           theme = 3)

# Plot 4
boxplot(weight ~ Diet, 
        data = ChickWeight)

# Put plotting arrangement back to its original state
par(mfrow = c(1, 1))



# 12.3.1 Complex plot layouts with layout()

# mat: A matrix indicating the location of the next N figures in the global plotting space.
# widths: A vector of values for the widths of the columns of the plotting space
# heights: A vector of values for the widths of the columns of the plotting space

layout.matrix <- matrix(c(0, 2, 3, 1), nrow = 2, ncol = 2)
layout.matrix

layout(mat = layout.matrix,
       heights = c(1, 2), # Heights of the two rows, the height of first row is 1 and the second is 2
       widths = c(2, 2)) # Widths of the two columns, the width of the first column is 2 and the second is 2

layout.show(3)

# Now we’re ready to put the plots together
# Set plot layout
layout(mat = matrix(c(2, 1, 0, 3), 
                    nrow = 2, 
                    ncol = 2),
       heights = c(1, 2),    # Heights of the two rows
       widths = c(2, 1))     # Widths of the two columns

# Plot 1: Scatterplot
par(mar = c(5, 4, 0, 0))
plot(x = pirates$height, 
     y = pirates$weight,
     xlab = "height", 
     ylab = "weight", 
     pch = 16, 
     col = yarrr::piratepal("pony", trans = .7))

# Plot 2: Top (height) boxplot
par(mar = c(0, 4, 0, 0))
boxplot(pirates$height, xaxt = "n",
        yaxt = "n", bty = "n", yaxt = "n",
        col = "white", frame = FALSE, horizontal = TRUE)

# Plot 3: Right (weight) boxplot
par(mar = c(5, 0, 0, 0))
boxplot(pirates$weight, xaxt = "n",
        yaxt = "n", bty = "n", yaxt = "n",
        col = "white", frame = F)



# 12.4 Additional plotting parameters

par(mfrow = c(1, 1))

par(bg = gray(.9)) # Create a light gray background
hist(x = rnorm(100), col = "skyblue")



# A more complex example
parrot.data <- data.frame(
  "ship" = c("Drunken\nMonkeys", "Slippery\nSnails", "Don't Ask\nDon't Tell", "The Beliebers"),
  "Green" = c(200, 150, 100, 175),
  "Blue " = c(150, 125, 180, 242))

# Set background color and plot margins
par(bg = rgb(61, 55, 72, maxColorValue = 255),
    mar = c(6, 6, 4, 3))

plot(1, xlab = "", ylab = "", xaxt = "n",
     yaxt = "n", main = "", bty = "n", type = "n",
     ylim = c(0, 250), xlim = c(.25, 5.25))

# Add gridlines
abline(h = seq(0, 250, 50), 
       lty = 3, 
       col = gray(.95), lwd = 1)

# y-axis labels
mtext(text = seq(50, 250, 50),
      side = 2, at = seq(50, 250, 50),
      las = 1, line = 1, col = gray(.95))

# ship labels
mtext(text = parrot.data$ship,
      side = 1, at = 1:4, las = 1,
      line = 1, col = gray(.95))

# Blue bars
rect(xleft = 1:4 - .35 - .04 / 2,
     ybottom = rep(0, 4),
     xright = 1:4 - .04 / 2,
     ytop = parrot.data$Blue,
     col = "lightskyblue1", border = NA)

# Green bars
rect(xleft = 1:4 + .04 / 2,
     ybottom = rep(0, 4),
     xright = 1:4 + .35 + .04 / 2,
     ytop = parrot.data$Green,
     col = "lightgreen", border = NA)

legend(4.2, 250, c("Blue", "Green"),
       col = c("lightskyblue1", "lightgreen"), pch = rep(15, 2),
       bty = "n", pt.cex = 1.5, text.col = "white")

# Additional margin text
mtext("Number of Green and Blue parrots on 4 ships", 
      side = 3, cex = 1.5, col = "white")
mtext("Parrots", side = 2, col = "white", line = 3.5)
mtext("Source: Drunken survey on 22 May 2015", side = 1,
      at = 0, adj = 0, line = 3, font = 3, col = "white")










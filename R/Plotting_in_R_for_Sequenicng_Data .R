# Reference: "https://www.youtube.com/watch?v=QPwo7cEzMIk&list=PL-IR12W3BZkXGfIjRtMgAw1Ff0liWX_Aj&index=4"
# ==========================================================
#
#      chapter 1 -- Basics
#      •   Reading in data
#      •   Creating a quick plot
#      •   Saving publication-quality plots in multiple 
#          file formats (.png, .jpg, .pdf, and .tiff)
#
# ==========================================================
getwd()

library(ggplot2)

filename <- "data/Encode_HMM_data.txt"

# Select a file and read the data into a data-frame
my_data <- read.csv(filename, sep="\t", header=FALSE)
head(my_data)

# Rename the columns so we can plot things more easily without looking up which column is which
names(my_data)[1:4] <- c("chrom","start","stop","type")

head(my_data)

ggplot(my_data, aes(x=chrom, fill=type)) + geom_bar()


# Save the plot to a file

# Different file formats:
png("plot.png", width=1000, height=600)
ggplot(my_data, aes(x=chrom,fill=type)) + geom_bar()
dev.off()

tiff("plot.tiff", width=1000, height=600)
ggplot(my_data, aes(x=chrom, fill=type)) + geom_bar()
dev.off()

jpeg("plot.jpg")
ggplot(my_data, aes(x=chrom, fill=type)) + geom_bar()
dev.off()

pdf("plot.pdf")
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()
dev.off()

# High-resolution:
png("plot_hi_res.png", 1000, 1000)
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()
dev.off()




# ==========================================================
#
#      Chapter 2 -- Importing and downloading data
#      •   Importing data from Excel
#      •   Downloading from UCSC
#      •   Downloading from ENSEMBL
#      •   Downloading from ENCODE
#
# ==========================================================

# Getting data from Excel
# Get the excel file from this paper: "Gene expression profiling of breast cell lines identifies potential new basal 
# markers". Supplementary table 1. Go into excel and save it as "Tab Delimited Text (.txt)"


filename <- "data/micro_array_results_table1.txt"

my_data <- read.csv(filename, sep="\t", header=TRUE)
head(my_data)


# Where to find publicly available big data
# UCSC -- RefSeq genes from table browser
# Ensembl -- Mouse regulatory features MultiCell
# ENCODE -- HMM: wgEncodeBroadHmmGm12878HMM.bed



# ==========================================================
#
#      Lesson 3 -- Interrogating your data
#      •   Counting categorical variables
#      •   Mean, median, standard deviation
#      •   Finding issues
#
# ==========================================================



library(ggplot2)

filename <- "data/Encode_HMM_data.txt"

my_data <- read.csv(filename, sep="\t", header=FALSE)
head(my_data)
names(my_data)[1:4] <- c("chrom","start","stop","type")

head(my_data)

ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()

#############     Now let's take a closer look at our data     ###############
head(my_data)

# We can see how big our data is:
dim(my_data)

# We can ask our data some questions:
summary(my_data)

# We can break these down by column to see more:
summary(my_data$chrom)
summary(my_data$type)
summary(my_data$start)
summary(my_data$stop)


# We can even make a new column by doing math on the other columns
my_data$size = my_data$stop - my_data$start

# So now there's a new column
head(my_data)

# Basic statistics:
summary(my_data$size)

mean(my_data$size)
sd(my_data$size)

median(my_data$size)
max(my_data$size)
min(my_data$size)


# Let's think about the issues and in the next lesson we will learn how to deal with them
ggplot(my_data, aes(x=chrom, fill=type)) + geom_bar()

# 1)    Chromosomes in the wrong order, and the "chr" prefixes don't fit on the x-axis
# 2)    Too many types
# 3)    Bad names for the types

# ==> Fix above like below

# 1)    Remove "chr" prefix from chromosome names
# 2)    Order the chromosomes correctly
# 3)    Pick a subset of the types and rename them
 

# ==========================================================
#
#      Chapter 4 -- Filtering and cleaning up data
#      •   Removing "chr" prefixes
#      •   Getting chromosomes in the right order
#      •   Filtering out excess data
#      •   Renaming categories
#
# ==========================================================
head(my_data)
summary(my_data$chrom)
summary(my_data$type)

# Remove the "chr" prefix
my_data$chrom <- factor(gsub("chr", "", my_data$chrom))
# levels = possibilities/categories

# See the result
summary(my_data$chrom)

ggplot(my_data, aes(x=chrom, fill=type)) +geom_bar()

# Reorder the chromosomes numerically
# my_data$chrom <- factor(my_data$chrom, levels=c(seq(1, 22), "X", "Y"))

my_data$chrom<-factor(my_data$chrom, levels=c(seq(1:22), "x", "Y"))

summary(my_data$chrom)

ggplot(my_data, aes(x=chrom, fill=type)) + geom_bar()


# Now let's do something about those types.
summary(my_data$type)

# Filter to just a few types I'm interested in
my_data<-my_data[my_data$type %in% c('1_Active_Promoter', '4_Strong_Enhancer', '8_Insulator'), ]

summary(my_data$type)

# Rename the types
library(plyr) # this library has a useful revalue() function
my_data$type <- revalue(my_data$type, c("1_Active_Promoter"="Promoter", 
                                        "4_Strong_Enhancer"="Enhancer",
                                        "8_Insulator"="Insulator")
                        )

summary(my_data$type)
df_pro=my_data[my_data$type=="Promoter", ]
head(df_pro)
unique(my_data$type)
# Check the plot again
ggplot(my_data, aes(x=chrom, fill=type)) + geom_bar()



# ==========================================================
#
#      Chapter 5 -- Tweaking everything in your plots
#      •   Text, axis labels
#      •   Legends
#      •   Color palettes
#      •   Sizes, fonts, line-widths, tick-marks, 
#          grid-lines, and background-colors
#
# ==========================================================


# Loading, filtering, etc. from chapter 1-4:

library(ggplot2)

filename <- "data/Encode_HMM_data.txt"
my_data <- read.csv(filename, sep="\t", header=FALSE)
names(my_data)[1:4] <- c("chrom","start","stop","type")

# Reorder chromosomes and cut their names down
my_data$chrom <- factor(gsub("chr", "", my_data$chrom, fixed=TRUE), levels=c(seq(1,22),"X","Y"))

# Filter to just a few types I'm interested in
my_data <- my_data[my_data$type %in% c("1_Active_Promoter","4_Strong_Enhancer","8_Insulator"),]

# Rename the types
library(plyr) # this library has a useful revalue() function
my_data$type <- revalue(my_data$type, c("1_Active_Promoter"="Promoter", 
                                        "4_Strong_Enhancer"="Enhancer",
                                        "8_Insulator"="Insulator"))

# Check the plot again
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()

# ==========================================================

# The basics
ggplot(my_data, aes(x=chrom, fill=type)) + geom_bar()

# Add a plot title
ggplot(my_data, aes(x=chrom,fill=type)) + geom_bar() + labs(title="Regulatory features by chromosome")

# Change axis and legend labels
ggplot(my_data, aes(x=chrom,fill=type)) + geom_bar() + labs(x = "Chromosome", y="Count", fill="Feature")


# Save the plot to easily try new things:
basic <- ggplot(my_data, aes(x=chrom, fill=type)) + geom_bar() + labs(x = "Chromosome", y="Count", fill="Feature")
# Now when we run "basic" it makes the plot
basic

# Add theme with modifications to the basic plot, for instance with bigger text
basic + theme_gray(base_size = 20)
# But it only affects that plot, so the next plot we make is back to normal
basic

# You can also set a theme that will affect all the plots you make from now on
theme_set(theme_gray(base_size = 20))
basic

# To recover the default theme:
theme_set(theme_gray())
basic

# I prefer larger text myself
theme_set(theme_gray(base_size = 16))
basic

#==============================================================================
# Color palettes:

library(RColorBrewer)
display.brewer.all()

basic + scale_fill_brewer(palette="Set1")
basic + scale_fill_brewer(palette="Pastel1")
basic + scale_fill_brewer(palette="YlOrRd")

basic + scale_fill_manual(values = c("green","blue","red"))

colors()

# What happens if we need a lot of colors?
chrom_plot <- ggplot(my_data, aes(x=type, fill=chrom)) + geom_bar()
chrom_plot

# rainbow is confusing, but color palettes are too short:
chrom_plot + scale_fill_brewer(type="qual", palette=1)


# to get the colors from a palette:
palette1 <- brewer.pal(9,"Set1")
palette1

palette2 <- brewer.pal(8,"Set2")
palette2

palette3 <- brewer.pal(9,"Set3")
palette3

# We can use a quick pie chart to see the colors:
pie(rep(1,length(palette1)),col=palette1)
pie(rep(1,length(palette2)),col=palette2)
pie(rep(1,length(palette3)),col=palette3)

# We can just stick a few color palettes together
big_palette <- c(palette1, palette2, palette3)
big_palette

# Pie chart of all the colors together:
pie(rep(1,length(big_palette)), col=big_palette)


chrom_plot + scale_fill_manual(values = big_palette)

# To shuffle the colors:
chrom_plot + scale_fill_manual(values = sample(big_palette))


# if you want to keep the colors the same every time you plot, 
# use set.seed()
set.seed(5)
# use different numbers until you find your favorite colors
chrom_plot + scale_fill_manual(values = sample(big_palette))

# This is possible, because:
# Fun fact: "Random" numbers from a computer aren't really random


# Color-blind safe palettes:
display.brewer.all(colorblindFriendly=TRUE)
# Mixing them might remove the color-friendly-ness so be careful
# Finding a set of 23 colors that a color-blind person can distinguish is a challenge

basic + scale_fill_brewer(palette="Set2")


# Done with colors
#======================================================================

# Default:
theme_set(theme_gray())


# Basic, normal plot:
basic

# Two basic themes:
basic + theme_gray() # the default
basic + theme_bw() # black and white

# Fonts and font sizes for everything at once
basic + theme_gray(base_size = 24, base_family = "Times New Roman")


# Font size for labels, tick labels, and legend separately ##############################
basic + theme(axis.text=element_text(size=20)) # numbers on axes
basic + theme(axis.title=element_text(size=20)) # titles on axes
basic + theme(legend.title=element_text(size=20)) # legend title
basic + theme(legend.text=element_text(size=20,family="Times New Roman"))
# legend category labels

basic + theme(
  legend.text=element_text(size=20,family="Times New Roman"),
  axis.title=element_text(size=30),
  axis.text=element_text(size=20)
) # Mix and match


# Change background color
basic + theme(panel.background = element_rect(fill="pink"))
basic + theme(panel.background = element_rect(fill="white"))

# Change grid-lines
basic + theme(panel.grid.major = element_line(colour = "blue"), panel.grid.minor = element_line(colour = "red"))

# Remove all gridlines:
basic + theme(panel.grid.major = element_line(NA), 
              panel.grid.minor = element_line(NA))

# Thin black major grid lines on y-axis, the others are removed
basic + theme(panel.grid.major.y = element_line(colour = "black",size=0.2), 
              panel.grid.major.x = element_line(NA),
              panel.grid.minor = element_line(NA))



# Change tick-marks
basic # normal ticks
basic + theme(axis.ticks = element_line(size=2))
basic + theme(axis.ticks = element_line(NA))
basic + theme(axis.ticks = element_line(color="blue",size=2))
basic + theme(axis.ticks = element_line(size=2), # affects both x and y
              axis.ticks.x = element_line(color="blue"), # x only
              axis.ticks.y = element_line(color="red"))  # y only

# Place legend in different locations
basic + theme(legend.position="top")
basic + theme(legend.position="bottom")
basic + theme(legend.position=c(0,0)) # bottom left
basic + theme(legend.position=c(1,1)) # top right
basic + theme(legend.position=c(0.8,0.8)) # near the top right

# Remove legend title
basic + labs(fill="")
basic + labs(fill="") + theme(legend.position=c(0.8,0.8))

# Remove legend completely
basic + guides(fill=FALSE)


# clear background, axis lines but no box, no grid lines, basic colors, no legend
publication_style <- basic + guides(fill=FALSE) 
+ theme(axis.line = element_line(size=0.5),
        panel.background = element_rect(fill=NA,size=rel(20)), 
        panel.grid.minor = element_line(colour = NA), 
        axis.text = element_text(size=16), 
        axis.title = element_text(size=18)) 

publication_style

publication_style + scale_y_continuous(expand=c(0,0)) # to stop the bars from floating above the x-axis


# You can set the theme with all these changes and have it apply to all the future plots
theme_set(theme_gray()
          +theme(axis.line = element_line(size=0.5),
                 panel.background = element_rect(fill=NA,size=rel(20)), 
                 panel.grid.minor = element_line(colour = NA), 
                 axis.text = element_text(size=16), 
                 axis.title = element_text(size=18)))

basic

# These tweaks aren't part of the theme, so you will still have to add them separately to each plot
basic + scale_y_continuous(expand=c(0,0)) + guides(fill=FALSE)


# and you can always reset to defaults with:
theme_set(theme_gray())
basic


# ==========================================================
#
#      Chapter 6 -- Plot 
#      •   Bar plots
#      •   Histograms
#      •   Scatter plots
#      •   Box plots
#      •   Violin plots
#      •   Density plots
#      •   Dot-plots
#      •   Line-plots for time-course data
#      •   Pie charts
#      •   Venn diagrams (compare two or more lists of genes)
#
# ==========================================================


library(ggplot2)
theme_set(theme_gray(base_size = 18))

# Loading the data
filename <- "data/variants_from_assembly.bed"

my_data <- read.csv(filename, sep="\t", quote='', stringsAsFactors=TRUE, header=FALSE)

head(my_data)
names(my_data)
names(my_data) <- c("chrom","start","stop","name","size","strand","type","ref.dist","query.dist")

head(my_data)
summary(my_data$chrom)

# Filtering and polishing data
my_data <- my_data[my_data$chrom %in% c(seq(1,22),"X","Y","MT"),]

# ordering chromosomes
my_data$chrom <- factor(my_data$chrom, levels=c(seq(1,22),"X","Y","MT"))
# ordering types
my_data$type <- factor(my_data$type, levels=c("Insertion","Deletion","Expansion","Contraction"))

####################################################################


# Creating a bar plot
ggplot(my_data, aes(x=chrom,fill=type)) + geom_bar()

# Creating a histogram
ggplot(my_data, aes(x=size, fill=type)) + geom_bar()
ggplot(my_data, aes(x=size, fill=type)) + geom_bar() + xlim(0,500)
ggplot(my_data, aes(x=size, fill=type)) + geom_bar(binwidth=5) + xlim(0,500)

# Creating scatter plot
ggplot(my_data, aes(x=ref.dist, y=query.dist)) + geom_point()
# color by type (categorical)
ggplot(my_data, aes(x=ref.dist, y=query.dist, color=type)) + geom_point()
ggplot(my_data, aes(x=ref.dist, y=query.dist, color=type)) + geom_point() + xlim(-500,500) + ylim(-500,500)
# color by size (numerical)
ggplot(my_data, aes(x=ref.dist, y=query.dist,color=size)) + geom_point() + xlim(-500,500) + ylim(-500,500)

ggplot(my_data, aes(x=ref.dist, y=query.dist,color=size)) + geom_point() + xlim(-500,500) + ylim(-500,500) + scale_colour_gradient(limits=c(0,500))

# Creating box plots
ggplot(my_data, aes(x=type, y=size)) + geom_boxplot()
ggplot(my_data, aes(x=type, y=size, fill=type)) + geom_boxplot()
ggplot(my_data, aes(x=type, y=size, fill=type)) + geom_boxplot() + coord_flip()

# Creating violin plots
ggplot(my_data, aes(x=type, y=size)) + geom_violin()
ggplot(my_data, aes(x=type, y=size, fill=type)) + geom_violin() + ylim(0,1000) + guides(fill=FALSE)
ggplot(my_data, aes(x=type, y=size, fill=type)) + geom_violin(adjust=0.2) + ylim(0,1000) + guides(fill=FALSE)
# default adjust is 1, lower means finer resolution

# You can log-scale any numerical axis on any plot
ggplot(my_data, aes(x=type, y=size, fill=type)) + geom_violin() + 
  scale_y_log10()

# Creating a density plot
ggplot(my_data, aes(x=size, fill=type)) + geom_density() + xlim(0,500)
# similar to this histogram:
ggplot(my_data, aes(x=size, fill=type)) + geom_bar(binwidth=5) + xlim(0,500)

ggplot(my_data, aes(x=size, fill=type)) + geom_density(position="stack") + xlim(0, 500)
ggplot(my_data, aes(x=size, fill=type)) + geom_density(alpha=0.5) + xlim(0, 500)

# multifaceted plots:
ggplot(my_data, aes(x=size, fill=type)) + geom_density() + xlim(0, 500) + facet_grid(type ~ .)


# Creating dot plots
ggplot(my_data, aes(x=size, fill=type)) + geom_dotplot()
# a dot plot makes more sense with fewer observations where each individual item matters, 
# so let's grab the largest events only
large_data <- my_data[my_data$size>5000,  ] # [rows,columns]
ggplot(large_data, aes(x=size,fill=type)) + geom_dotplot(method="histodot")
# careful, they don't stack automatically, so some of the dots are behind others
ggplot(large_data, aes(x=size, fill=type)) + geom_dotplot(method="histodot", stackgroups=TRUE)


# Time-course data for line plot
filename <- "time_course_data.txt"
time_course <- read.csv(filename, sep=",", quote='', stringsAsFactors=TRUE, header=TRUE)
time_course

# line plot:
ggplot(time_course, aes(x=seconds, y=value, colour=sample)) + geom_line()
ggplot(time_course, aes(x=seconds, y=value, colour=sample)) + geom_line(size=3)


# Any plot can be made in polar coordinates:
# line plot
ggplot(time_course, aes(x=seconds, y=value, colour=sample)) + geom_line(size=3) + coord_polar()

# violin plot
ggplot(my_data, aes(x=type, y=size, fill=type)) + geom_violin(adjust=0.5) + ylim(0, 1000) + coord_polar()
# bar plot
ggplot(my_data, aes(x=size, fill=type)) + geom_bar(binwidth=5) + xlim(0,500) + coord_polar()


# Pie charts
type_counts = summary(my_data$type)
type_counts

pie(type_counts)
pie(type_counts, col=brewer.pal(length(type_counts), "Set1"))


# Gene lists for Venn Diagram
listA <- read.csv("genes_list_A.txt",header=FALSE)
A <- listA$V1
A

listB <- read.csv("genes_list_B.txt",header=FALSE)
B <- listB$V1
B

listC <- read.csv("genes_list_C.txt",header=FALSE)
C <- listC$V1
C

listD <- read.csv("genes_list_D.txt",header=FALSE)
D <- listD$V1
D

length(A)
length(B)
length(C)
length(D)

# install package VennDiagram
library(VennDiagram)

# This function only works by saving directly to a file

venn.diagram(list("list C"=C, "list D"=D), 
             fill = c("yellow","cyan"), 
             cex = 1.5, 
             filename="Venn_diagram_genes_2.png")

venn.diagram(list(A = A, C = C, D = D), 
             fill = c("yellow","red","cyan"), 
             cex = 1.5,
             filename="Venn_diagram_genes_3.png")

venn.diagram(list(A = A, B = B, C = C, D = D), 
             fill = c("yellow","red","cyan","forestgreen"), 
             cex = 1.5,
             filename="Venn_diagram_genes_4.png")


# ==========================================================
#
#      Chapter 7 -- Multifaceted figures
#      •   Grids of plots by chromosome, variant type, etc. 
#      •   Make a figure as an inset in another figure 
#          automatically -- without Photoshop or Illustrator
#
# ==========================================================

library(ggplot2)
# reset theme
theme_set(theme_gray())

# Loading the data
filename <- "data/variants_from_assembly.bed"
my_data <- read.csv(filename, sep="\t", quote='', stringsAsFactors=TRUE, header=FALSE)
names(my_data) <- c("chrom","start","stop","name","size","strand","type","ref.dist","query.dist")

head(my_data)

# Filtering and polishing data
my_data <- my_data[my_data$chrom %in% c(seq(1, 22), "X", "Y", "MT"),]

# ordering chromosomes
my_data$chrom <- factor(gsub("chr", "", my_data$chrom), levels=c(seq(1, 22), "X", "Y", "MT"))

# ordering types
my_data$type <- factor(my_data$type, levels=c("Insertion", "Deletion", "Expansion", "Contraction"))

############# Multifacetting figures ############

ggplot(my_data, aes(x=size, fill=type)) + geom_density(alpha=0.5) + xlim(0,500) 

ggplot(my_data, aes(x=size, fill=type)) + geom_density() + xlim(0,500)  + facet_grid(type ~ .)

ggplot(my_data, aes(x=size, fill=type)) + geom_density() + xlim(0,500)  + facet_grid(. ~ type)

# plot + facet_grid(rows ~ columns)

# Facet on type and chrom
ggplot(my_data, aes(x=size, fill=type)) + geom_density() + xlim(0,500)  + facet_grid(chrom ~ type)
ggplot(my_data, aes(x=size, fill=type)) + geom_density() + xlim(0,500)  + facet_grid(type ~ chrom)

# Not always pretty, but it sure is fun
ggplot(my_data, aes(x=size, fill=type)) + geom_bar() + xlim(0, 500)  + facet_grid(chrom ~ type)
ggplot(my_data, aes(x=type, y=size, color=type, fill=type)) + geom_boxplot() + facet_grid(chrom ~ .)
ggplot(my_data, aes(x=type, y=size, color=type, fill=type)) + geom_violin() + facet_grid(chrom ~ .)
ggplot(my_data, aes(x=ref.dist, y=query.dist, color=type, fill=type)) + xlim(0,500) + ylim(0,500) + geom_point() + facet_grid(chrom ~ type)
ggplot(my_data, aes(x=size,fill=type)) + geom_dotplot() + xlim(5000,10000) + facet_grid(chrom ~ type)


# Inset figures:

# Our special publication-style theme from Lesson 5 "Tweaking everything in your plots"
theme_set(theme_gray() + 
            theme(
              axis.line = element_line(size=0.5),
              panel.background = element_rect(fill=NA,size=rel(20)), 
              panel.grid.minor = element_line(colour = NA), 
              axis.text = element_text(size=16), 
              axis.title = element_text(size=18)
            )
)

big_plot <-  ggplot(my_data, aes(x=size, fill=type)) + 
  geom_bar(binwidth=100) +  
  guides(fill=FALSE) + 
  scale_y_continuous(expand=c(0,0)) # Move bars down to X-axis

big_plot


small_plot <- ggplot(my_data, aes(x=size, fill=type)) 
+ geom_bar(binwidth=5) 
+ xlim(0,500) 
+ theme(axis.title=element_blank()) 
+ scale_y_continuous(expand=c(0,0))
small_plot

# Where to put the smaller plot:
library(grid)
vp <- viewport(width = 0.8, height = 0.7, x = 0.65, y = 0.65)
# width, height, x-position, y-position of the smaller plot

png("inset_plot.png")
print(big_plot)
print(small_plot, vp = vp)
dev.off()


# ==========================================================
#
#      Chapter 8 -- Heatmaps
#      •   Dendrograms
#      •   To cluster or not to cluster
#      •   Flipping axes
#      •   Specifying distance calculation and clustering methods
#      •   Annotate sides of heatmap with associated data
#          (chromosomes, genders, samples)
#      •   Coloring branches in dendrograms
#
# ==========================================================
# The ComplexHeatmap package is downloaded from the bioconductor website, not from the packages tab like we did with the other packages
# https://bioconductor.org/packages/release/bioc/html/ComplexHeatmap.html

# Run the first time to install:
# source("https://bioconductor.org/biocLite.R")
# biocLite("ComplexHeatmap")


library(ComplexHeatmap)


# Heatmap from single-cell copy number data

# Select a data file
filename <- "data/copy_number_data.txt"

# Read the data into a data.frame
my_data <- read.table(filename, sep="\t", quote="", stringsAsFactors=FALSE, header=TRUE)

head(my_data)

dim(my_data) # (rows columns)

nrow(my_data) # rows: locations (bins) in genome
ncol(my_data) # columns: cells

# Make the heatmap data into a matrix
my_matrix <- as.matrix(my_data[  ,c(4:100)]) # [all rows, columns 4-100]
# leave out the first 3 columns (chrom,start,end) since they don't belong in the heatmap itself

# We can check the classes:
class(my_data)
class(my_matrix)

head(my_matrix)

# Save chromosome column for annotating the heatmap later
chromosome_info <- data.frame(chrom = my_data$CHR)
chromosome_info

## Now we make our first heatmap 

# Default parameters
Heatmap(my_matrix)

# Flip rows and columns around
my_matrix <- t(my_matrix)  # "transpose"
Heatmap(my_matrix)

# Keep genome bins in order, not clustered
Heatmap(my_matrix, cluster_columns=FALSE)

fontsize <- 0.6

# Put cell labels on the left side
Heatmap(my_matrix, cluster_columns=FALSE,
        row_names_side = "left", 
        # row_hclust_side = "left",
        row_names_gp=gpar(cex=fontsize))

# Make the dendrogram wider
Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        # row_hclust_side = "right",
        row_names_gp=gpar(cex=fontsize),
        # row_hclust_width = unit(3, "cm")
)

# Different distance calculation methods
# "euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski", "pearson", "spearman", "kendall"
# euclidean is the default

# Different clustering methods
# "ward.D", "ward.D2", "single", "complete", "average" (= UPGMA), "mcquitty" (= WPGMA), "median" (= WPGMC) or "centroid" (= UPGMC)

# Watch the dendrogram and heatmap change when we change the methods
Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        # row_hclust_side = "left",
        row_names_gp=gpar(cex=0.3),
        # row_hclust_width = unit(3, "cm"),
        clustering_distance_rows ="maximum",
        clustering_method_rows = "ward.D")


# Coloring clusters in dendrogram

# install dendextend
library(dendextend)
# Need to build dendrogram first so we can use it for the color_brances() function
# 1. calculate distances (method="maximum")
# 2. cluster (method="ward.D")
dend = hclust(dist(my_matrix, method="maximum"), method="ward.D")

Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        # row_hclust_side = "left",
        row_names_gp=gpar(cex=fontsize),
        # row_hclust_width = unit(3, "cm"),
        cluster_rows = color_branches(dend, k = 3))


# We can split the heatmap into clusters

Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        # row_hclust_side = "left",
        row_names_gp=gpar(cex=0.3),
        # row_hclust_width = unit(3, "cm"),
        clustering_distance_rows ="maximum",
        clustering_method_rows = "ward.D",
        km=2) # number of clusters you want



# Split columns of plot up into chromosomes using extra_info
chromosome_info

chromosome.colors <- c(rep(c("black","white"), 11), "red")
chromosome.colors

names(chromosome.colors) <- paste("chr", c(seq(1,22), "X"), sep="")
chromosome.colors


Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        # row_hclust_side = "left",
        row_names_gp=gpar(cex=0.3),
        # row_hclust_width = unit(3, "cm"),
        clustering_distance_rows ="maximum",
        clustering_method_rows = "ward.D",
        km=2, # number of clusters you want
        bottom_annotation = HeatmapAnnotation(df=chromosome_info, 
                                              col = list(chrom=chromosome.colors),
                                              show_legend=FALSE)
)



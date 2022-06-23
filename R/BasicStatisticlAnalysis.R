# Topics 
# Mean, Median
# Pearson Correlation
# Regression Analyses
# T-Test
# ANOVA
# Heatmap
# PCA

# Parametric test: Regression, Comparison, or Correlation
# 1. Correlation: Correlation test check whether two variables are related without assuming
#                 cause-and-effect relationships
# 2. Regression: Used to test cause-and-effect relationships, which comes with equations then 
#                it can be used for prediction
# 3. Comparison: Comparison tests look for differences among group means such as t-test

# Sample data in Iris
# 1. Sepal Length, 2. Sepal Width, 3. Petal Length, 4. Petal Width, 5. Species (Setosa, Versicolr, Virgina)

iris
iris<- iris # assign iris to a new object (iris), we can see data structure by clicking iris in Environment

iris$Petal.Length # select a column
x<-iris$Sepal.Length
x

mean(x)
median(x)

# Correlation - Pearson Correlation between 2 variables
cor(iris$Sepal.Length, iris$Petal.Length, method='pearson')



par('mar')
par(mar=c(1, 1, 1,1))
par('mar')

# Plot out the data
plot(iris$Sepal.Length, iris$Petal.Length)

# Regression - Linear Regression Model
# To model the data onto a straight line using two variables, lm=linear model
model<-lm(iris$Petal.Length~iris$Sepal.Length, data=iris)
summary(model)
View(model)

# Add line to the plot

dev.off()
par(mar = c(5, 4, 4, 2) + 0.1)
plot(iris$Sepal.Length, iris$Petal.Length, 
     xlab='Sepla Lenghth', 
     ylab='Petal Length')
abline(lm(iris$Petal.Length ~ iris$Sepal.Length, data=iris))

# Comparison - T-test
# T-test is used when two set of population data are normally distributed
data1<- subset(iris$Petal.Length, iris$Species=="setosa")
data2<- subset(iris$Petal.Length, iris$Species=="virginica")
length(data1)
length(data2)

t.test(data1, data2)

# Comparison - ANOVA
# Analysis Of Variance

aov.model<-aov(Petal.Length ~ Species, data=iris)
summary(aov.model)


# Data Visualization: Heatmap with Hierarchical Clustering

install.packages("pheatmap")

library(pheatmap)
pheatmap(iris[, 1:4],
         cluster_row=TRUE,
         cluster_cols = TRUE,
         clustering_method = "complete")


# Data Visualization: PCA with FactorMineR
# FactorMineR contains functions for PCA and relating visualization tools



library(FactoMineR)
library(factoextra)
iris.pca=PCA(iris[, 1:4], scale.unit = TRUE, ncp=5)
fviz_pca_ind(iris.pca, col.ind=iris$Species)



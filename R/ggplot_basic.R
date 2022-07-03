
library(palmerpenguins)

name<-c('Kason', 'John', 'Chloe', 'Lynn')
age<-c(20, 45, 34, 25)
gender<-c(rep(c('M', 'F'), each=2))

persons<-data.frame(name, age, gender)

persons


dat<-iris
View(dat)


library(ggplot2)

# syntax: ggplot(df, aes(x=x, y=y)) ggplot call dataframe, set axes and add plot type

plot(iris$Sepal.Length, iris$Sepal.Width)


ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
  geom_point() +
  theme_bw() +       # grey background is now gone
  xlab('Sepal Length') +
  ylab('Sepal Width')

# we can also save above code into a varialbe

scatplot_sepal<- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
  geom_point() +
  theme_bw() +       # grey background is now gone
  xlab('Sepal Length') +
  ylab('Sepal Width')

scatplot_sepal



box<-ggplot(iris, aes(x=Species, y=Sepal.Length, fill=Species)) +
  geom_boxplot()+
  theme_bw()
box

hist(iris$Sepal.Width)

hist<-ggplot(iris, aes(x=Sepal.Width, fill=Species)) +
  geom_histogram(binwidth=0.2, color='black', alpha=0.2)+
  theme_bw()
hist

density<-ggplot(iris, aes(x=Sepal.Width, fill=Species)) +
  geom_density(stat='density', alpha=I(0.2))

ggsave('boxyIris.png', box, device=png)
dev.off()

# save plot to file without using ggsave
# save the plot by writing directly to a graphics device. To do this, you can open a regular 
# R graphics device such as png() or pdf(), print the plot, and then close the device using 
# dev.off(). 

d<-ggplot(iris, aes(x=Sepal.Width, fill=Species)) +
  geom_density(stat='density', alpha=I(0.2))

png('irisDensity.png')
print(d)
dev.off()



# Advanced ggplot

ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) + 
  geom_point() +
  geom_smooth (method='lm') +
  theme_bw() + 
  xlim(0, 10)+
  ylim(0, 5)+
  xlab('Sepal Length') +
  ylab('Sepal Width') +
  facet_grid(~Species)


ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) + 
  geom_point() +
  geom_smooth (method='lm') +
  theme_bw() + 
  xlim(0, 10)+
  ylim(0, 5)+
  xlab('Sepal Length') +
  ylab('Sepal Width') +
  facet_grid(Species~.)

# split facet_grid horizontally (facet_grid(Category~.))
# split facet_grid vertically (facet_grid(~Category))

# density plot with facet_grid
ggplot(iris, aes(x=Sepal.Width, fill=Species)) +
  geom_density(stat='density', alpha=0.2) +
  facet_grid(~Species)

ggplot(iris, aes(x=Sepal.Width, fill=Species)) +
  geom_density(stat='density', alpha=0.2) +
  facet_grid(Species~.)






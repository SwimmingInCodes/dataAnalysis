
##############################
##### ANOVA test using R #####
##############################

# source: "https://www.scribbr.com/statistics/anova-in-r/"

#* ANOVA is a statistical test for estimating how a quantitative dependent variable changes according to the levels of
#* one or more categorical independent variables. 
#* ANOVA tests whether there is a difference in means of the groups at each level of the independent variable. 
#* The null hypothesis (H0) of the ANOVA is no difference in means, and the alternate hypothesis (Ha) is that the means are different from one another. 
#*
#* Here, a one-way ANOVA (one independent variable) and a two-way ANOVA (two independent variables) will be conducted
#* on a sample dataset contains observations from an imaginary study of the effects of fertilizer type and planting density on crop yield.

## One-way ANOVA example
# In the one-way ANOVA, we test the effects of 3 types of fertilizer on crop yield.

## Two-way ANOVA example
# In the two-way ANOVA, we add an additional independent variable: planting density. We test the effects of 3 types of fertilizer 
# and 2 different planting densities on crop yield.

install.packages(c('ggplot2','ggpubr', 'tidyverse', 'broom', 'AICcomdavg'))
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)

##################################
### STEP1:Load the data inot R ###
##################################

crop.data<- read.csv('crop.data.csv', header=T, colClasses = c('factor', 'factor', 'factor', 'numeric'))

head(crop.data)
summary(crop.data)

####################################
### STEP2:Perform the ANOVA test ###
####################################

#* ANOVA tests whether any of the group means are different from the overall mean of the data by checking the variance 
#* of each individual group against the overall variance of the data. If one or more groups falls outside the range of 
#* variation predicted by the null hypothesis (all group means are equal), then the test is statistically significant.

## One-way ANOVA

one.way <- aov(yield ~ fertilizer, data=crop.data)

summary(one.way)

# The p-value of the fertilizer variable is low (p < 0.001), so it appears that the type of fertilizer used has a real 
# impact on the final crop yield.


## Two-way ANOVA


two.way<-aov(yield ~ fertilizer + density, data=crop.data)
summary(two.way)

# Adding planting density to the model seems to have made the model better: it reduced the residual variance 
# (the residual sum of squares went from 35.89 to 30.765), and both planting density and fertilizer are statistically 
# significant (p-values < 0.001).

## Adding interactions between variables 

# Sometimes you have reason to think that two of your independent variables have an interaction effect rather than an 
# additive effect
#* To test whether two variables have an interaction effect in ANOVA, simply use an asterisk instead of a plus-sign in the model:

interaction <- aov(yield ~ fertilizer*density, data = crop.data)
summary(interaction)

#* In the output table, the ‘fertilizer:density’ variable has a low sum-of-squares value and a high p-value, which means there is 
#* not much variation that can be explained by the interaction between fertilizer and planting density.

## Adding a blocking variable

# If you have grouped your experimental treatments in some way, or if you have a confounding variable that might affect the 
# elationship you are interested in testing, you should include that element in the model as a blocking variable.'

# For example, in many crop yield studies, treatments are applied within ‘blocks’ in the field that may differ in soil texture, 
# moisture, sunlight, etc. To control for the effect of differences among planting blocks we add a third term, ‘block’, to our 
# ANOVA


blocking <- aov(yield ~ fertilizer + density + block, data = crop.data)
summary(blocking)

#* The ‘block’ variable has a low sum-of-squares value (0.486) and a high p-value (p = 0.48), so it’s probably not adding much 
#* information to the model. It also doesn’t change the sum of squares for the two independent variables, which means that it’s 
#* not affecting how much variation in the dependent variable they explain.

#######################################
### Step 3: Find the best-fit model ###
#######################################

#* There are now four different ANOVA models to explain the data. How do you decide which one to use? 
#* The Akaike information criterion (AIC) is a good test for model fit. In AIC model selection, we compare the information value 
#* of each model and choose the one with the lowest AIC value (a lower number means more information explained!)

library(AICcmodavg)

model.set<-list(one.way, two.way, interaction, blocking)
model.names<-c('one.way', 'two.way', 'interaction', 'blocking')

aictab(model.set, modnames=model.names)

# From these results, it appears that the two.way model is the best fit. The two-way model has the lowest AIC value, and 71% of 
# the AIC weight, which means that it explains 71% of the total variation in the dependent variable that can be explained by 
# the full set of models.

# The model with blocking term contains an additional 15% of the AIC weight, but because it is more than 2 delta-AIC 
# worse than the best model, it probably isn’t good enough to include in your results.

##########################################
### Step 4: Check for homoscedasticity ###
##########################################

# To check whether the model (two.way model) fits the assumption of homoscedasticity, look at the model diagnostic plots in R using 
# the plot() function:
# Homoscedasticity, or homogeneity of variances, is an assumption of equal or similar variances in different groups being compared. 

par(mfrow=c(2,2))
plot(two.way)

# The diagnostic plots show the unexplained variance (residuals) across the range of the observed data.
# The red line representing the mean of the residuals should be horizontal and centered on zero 
# (or on one, in the scale-location plot), meaning that there are no large outliers that would cause bias in the model.
# From these diagnostic plots we can say that the model fits the assumption of homoscedasticity.
# If your model doesn’t fit the assumption of homoscedasticity, you can try the Kruskall-Wallis test instead.


####################################
### Step 5: Do a post-hoc test   ###
####################################

# ANOVA tells us if there are differences among group means, but not what the differences are. 
# To find out which groups are statistically different from one another, you can perform a Tukey’s 
# Honestly Significant Difference (Tukey’s HSD) post-hoc test for pairwise comparisons:

tukey.two.way<-TukeyHSD(two.way)
tukey.two.way

# From the post-hoc test results, we see that there are statistically significant differences 
# (p < 0.05) between fertilizer groups 3 and 1 and between fertilizer types 3 and 2. There is also 
# a significant difference between the two different levels of planting density.


############################################
### Step 6: PLot the results in a graph  ###
############################################


# When plotting the results of a model, it is important to display:

# the raw data
# summary information, usually the mean and standard error of each group being compared
# letters or symbols above each group being compared to indicate the groupwise differences.



# we need to show which of the combinations of fertilizer type + planting density are statistically 
# different from one another. In other words,  which group means are statistically different from one 
# another so we can add this information to the graph.

## <Find the groupwise differences>
tukey.plot.aov<-aov(yield ~ fertilizer*density, data=crop.data)
tukey.plot.test<-TukeyHSD(tukey.plot.aov)
plot(tukey.plot.test, las = 1)

#* The significant groupwise differences are any where the 95% confidence interval doesn’t include zero. 
#* This is another way of saying that the p-value for these pairwise differences is < 0.05.

## <Make a data frame with the group labels>

# summarize the original data using fertilizer type and planting density as grouping variables.
mean.yield.data <- crop.data %>% group_by(fertilizer, density) %>% summarize(
  yield=mean(yield)
)

mean.yield.data

# add the group labels as a new variable in the data frame.
# Aa (representing 1:1), b (representing all the intermediate combinations), and c (representing 3:2).

mean.yield.data$group <- c('a', 'b', 'b', 'b', 'b', 'c')

mean.yield.data



## <Plot the raw data>


two.way.plot<-ggplot(crop.data, 
                     aes(x=density, y=yield, group=fertilizer)) + 
                     geom_point(cex=1.5, 
                                pch=1.0, 
                                position=position_jitter(w=0.1, h=0)
                                )

two.way.plot

# Add the means and standard errors to the graph

two.way.plot <- two.way.plot +
  stat_summary(fun.data = 'mean_se', geom = 'errorbar', width = 0.2) +
  stat_summary(fun.data = 'mean_se', geom = 'pointrange') +
  geom_point(data=mean.yield.data, aes(x=density, y=yield))

two.way.plot
# This is very hard to read, since all of the different groupings for fertilizer type are stacked on top of 
# one another. 

## <Split up the data>

two.way.plot <- two.way.plot +
  geom_text(data=mean.yield.data, label=mean.yield.data$group, vjust = -8, size = 5) +
  facet_wrap(~ fertilizer)

two.way.plot

## <Make the graph ready for publication>
# In this step we will remove the grey background and add axis labels.

two.way.plot <- two.way.plot +
  theme_classic2() +
  labs(title = "Crop yield in response to fertilizer mix and planting density",
       x = "Planting density (1=low density, 2=high density)",
       y = "Yield (bushels per acre)")

two.way.plot

##################################
### Step 7: Report the results ###
##################################

# state the results of the ANOVA test. 
# A brief description of the variables you tested
# The f-value, degrees of freedom, and p-values for each independent variable
# What the results mean.


# We found a statistically-significant difference in average crop yield by both fertilizer type 
# (f(2)=9.018, p < 0.001) and by planting density (f(1)=15.316, p<0.001).
 
# A Tukey post-hoc test revealed that fertilizer mix 3 resulted in a higher yield on average 
# than fertilizer mix 1 (0.59 bushels/acre), and a higher yield on average than fertilizer mix 2
# (0.42 bushels/acre). Planting density was also significant, with planting density 2 resulting
# in an higher yield on average of 0.46 bushels/acre over planting density 1.

# A subsequent groupwise comparison showed the strongest yield gains at planting density 2, 
# fertilizer mix 3, suggesting that this mix of treatments was most advantageous for crop growth 
# under our experimental conditions.


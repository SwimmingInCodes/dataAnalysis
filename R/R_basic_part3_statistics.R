## Chapter 13 Hypothesis Tests
library(yarrr) # Load yarrr to get the pirates data

# 1 sample t-test
# Are pirate ages different than 30 on average?
t.test(x = pirates$age, 
       mu = 30)

# 2 sample t-test
# Do females and males have different numbers of  tattoos?
sex.ttest <- t.test(formula = tattoos ~ sex,
                    data = pirates, 
                    subset = sex %in% c("male", "female"))
sex.ttest # Print result

## Access specific values from test
sex.ttest$statistic
sex.ttest$p.value
sex.ttest$conf.int

# Correlation test
# Is there a relationship between age and height?
cor.test(formula = ~ age + height,
         data = pirates)

# Chi-Square test
# Is there a relationship between college and favorite pirate?
chisq.test(x = pirates$college,
           y = pirates$favorite.pirate)


# 13.1 A short introduction to hypothesis tests
#  there is a stereotype that European pirates have more body piercings than American pirates. 
#  But is this true? To answer this, I conducted a survey where I asked 10 American and 10 European 
#  pirates how many body piercings they had.

# Body piercing data
american.bp <- c(3, 5, 2, 1, 4, 4, 6, 3, 5, 4)
european.bp <- c(6, 5, 7, 7, 6, 3, 4, 6, 5, 4)

# Store data in a dataframe
bp.survey <- data.frame("bp" = c(american.bp, european.bp),
                        "group" = rep(c("American", "European"), each = 10),
                        stringsAsFactors = FALSE)


yarrr::pirateplot(bp ~ group,
                  data = bp.survey,
                  main = "Body Piercing Survey",
                  ylab = "Number of Body Piercings",
                  xlab = "Group", 
                  theme = 2, point.o = .8, cap.beans = TRUE)


# 13.1.1 Null v Alternative Hypothesis

# Null hypothesis is that American and European pirates have the same number of body piercings on average.
# Alternative hypothesis is that American and European pirates do not have the same number of piercings on average.
# 1-sided (also called 1-tailed) hypothesis:
   # alternative hypothesis could be that European pirates have more piercings on average than American pirates.
# 2-sided (also called 2-tailed) alternative hypothesis:
   # American and European pirates simply differ in their average number of piercings, without stating which 
   # group has more piercings than the other.


# 13.1.2 Descriptive statistics

# Pring descriptive statistics of the piercing data
summary(american.bp)
summary(european.bp)

# 13.1.3 Test Statistics
# An test statistic compares descriptive statistics, and determines how different they are
# To calculate a test statistic from a two-sample t-test, we can use the t.test() function in R.

# Conduct a two-sided t-test comparing the vectors american.bp and european.bp
#  and save the results in an object called bp.test
bp.test <- t.test(x = american.bp,
                  y = european.bp,
                  alternative = "two.sided")

# Print the main results
bp.test

# It looks like our test-statistic is -2.52. If there was really no difference between the groups of pirates, 
# we would expect a test statistic close to 0. Because test-statistic is -2.52, this makes us think that there 
# really is a difference. However, in order to make our decision, we need to get the p-value from the test.

# 13.1.4 p-value
# The p-value is a probability that reflects how consistent the test statistic is with the hypothesis that 
# the groups are actually the same. 

# 13.1.4.1 Definition of a p-value: Assuming that there the null hypothesis is true 
# (i.e.; that there is no difference between the groups), what is the probability that we would have gotten
#  a test statistic as far away from 0 as the one we actually got?
# What is the p-value from our t-test?
bp.test$p.value
#* The p-value we got was 0.02, this means that, assuming the two populations of American and European pirates have 
#* the same number of body piercings on average, the probability that we would obtain a test statistic as large 
#* as -2.52 is 2.1%. p value is less than 0.05, then we reject the null hypothesis


# 13.2 Hypothesis test objects: htest

# htest objects contain all the major results from a hypothesis test, from the test statistic 
# (e.g.; a t-statistic for a t-test, or a correlation coefficient for a correlation test), to the p-value, 
# to a confidence interval. 

# T-test comparing male and female heights stored in a new htest object called height.htest
height.htest <- t.test(formula = height ~ sex,
                       data = pirates,
                       subset = sex %in% c("male", "female"))


# Once you’ve created an htest object, you can view a print-out of the main results by just evaluating the 
# object name:
# Print main results from height.htest
height.htest

# Show me all the elements in the height.htest object
names(height.htest)  ## for python, that is dir(height.htest)

# Get the t test statistic 
height.htest$statistic 

# Get the p-value
height.htest$p.value


# Get a confidence interval for the mean
height.htest$conf.int


# 13.3 T-test: t.test()
# To compare the mean of 1 group to a specific value, or to compare the means of 2 groups, you do a t-test.

?t.test

tattoo.ttest <- t.test(x = pirates$tattoos,  # Vector of data
                       mu = 5)               # Null: Mean is 5

# Print the result
tattoo.ttest

# Because 2e-16 is less than 0.05, we would reject the null hypothesis that the true mean is equal to 5.

tattoo.ttest <- t.test(x = pirates$tattoos,
                       mu = 9.5)  # Null: Mean is 9.4

tattoo.ttest
# Just as we predicted! The test statistic decreased to just -0.67, and the p-value increased to 0.51. 
# In other words, our sample mean of 9.43 is reasonably consistent with the hypothesis that the true 
# population mean is 9.50.


# 13.3.2 2-sample t-test

# Fomulation of a two-sample t-test
# Method 1: Formula
t.test(formula = y ~ x,  # Formula
       data = df) # Dataframe containing the variables

# Alternatively, if the data you want to compare are in individual vectors (not together in a dataframe), 
# you can use the vector notation:

# Method 2: Vector
t.test(x = x,  # First vector
       y = y)  # Second vector


# 2-sample t-test
#  IV = eyepatch (0 or 1)
#  DV = tattoos

tat.patch.htest <- t.test(formula = tattoos ~ eyepatch,
                          data = pirates)

# Show me all of the elements in the htest object
names(tat.patch.htest)

# Confidence interval for mean differences
tat.patch.htest$conf.int

# 13.3.2.1 Using subset to select levels of an IV

# If your independent variable has more than two values, the t.test() function will return an error because it 
# doesn’t know which two groups you want to compare. For example, let’s say I want to compare the number of 
# tattoos of pirates of different ages. Now, the age column has many different values, so if I don’t tell 
# t.test() which two values of age I want to compare, I will get an error like this:

# Will return an error because there are more than
#  2 levels of the age IV

# t.test(formula = tattoos ~ age,
#        data = pirates)  --> this causes error
# Use the subset argument and indicate which values of the IV you want to test using the %in% operator.


# Compare the tattoos of pirates aged 29 and 30:
tatage.htest <- t.test(formula = tattoos ~ age,
                       data = pirates,
                       subset = age %in% c(29, 30))  # Compare age of 29 to 30
tatage.htest

# Is there an effect of college on # of tattoos
#  only for female pirates?

tat.college.htest<-t.test(formula = tattoos ~ college,
       data = pirates,
       subset = sex == "female")

tat.college.htest


# 13.4 Correlation: cor.test()

#* In a correlation test, you are accessing the relationship between two variables on a ratio or interval scale: 
#* like height and weight, or income and beard length. The test statistic in a correlation test is called 
#* a correlation coefficient and is represented by the letter r. The coefficient can range from -1 to +1, 
#* with -1 meaning a strong negative relationship, and +1 meaning a strong positive relationship. 
#* The null hypothesis in a correlation test is a correlation of 0, which means no relationship at all:
#

# Correlation Test
#   Correlating two variables x and y

# Method 1: Formula notation
##  Use if x and y are in a dataframe
cor.test(formula = ~ x + y,
         data = df)

# Method 2: Vector notation
## Use if x and y are separate vectors
cor.test(x = x,
         y = y)


# Is there a correlation between a pirate's age and
#  the number of parrots (s)he's owned?

# Method 1: Formula notation
age.parrots.ctest <- cor.test(formula = ~ age + parrots,
                              data = pirates)
# Print result
age.parrots.ctest


# Method 2: Vector notation
age.parrots.ctest <- cor.test(x = pirates$age,
                              y = pirates$parrots)

# Print result
age.parrots.ctest

names(age.parrots.ctest)

#  95% confidence interval of the correlation
#   coefficient
age.parrots.ctest$conf.int


# Is there a correlation between age and 
#  number parrots ONLY for female pirates?

cor.test(formula = ~ age + parrots,
         data = pirates,
         subset = sex == "female")


# 13.5 Chi-square: chsq.test()
# we test whether or not there is a difference in the rates of outcomes on a nominal scale
# (like sex, eye color, first name etc.). The test statistic of a chi-square text is  
# chi-squared and can range from 0 to Infinity. The null-hypothesis of a chi-square test is that  
# chi-square= 0 which means no relationship.

# A key difference between the chisq.test() and the other hypothesis tests we’ve covered is that chisq.test() 
# requires a table created using the table() function as its main argument.

# 13.5.0.1 1-sample Chi-square test

# you are testing if there is a difference in the number of members of each category in the vector. 
# Or in other words, are all category memberships equally prevalent? 

# Frequency table of pirate colleges
table(pirates$college)

# Are all colleges equally prevelant?
college.cstest <- chisq.test(x = table(pirates$college))
college.cstest

# Indeed, with a test statistic of 99.86 and a tiny p-value, we can safely reject the null hypothesis and 
# conclude that certain college are more popular than others.


# 13.5.0.2 2-sample Chi-square test

# Test to see if the frequency of one nominal variable depends on a second nominal variable, 
# you’d conduct a 2-sample chi-square test.

# Do pirates that wear eyepatches have come from different colleges
#  than those that do not wear eyepatches?

table(pirates$eyepatch, 
      pirates$college)

# Is there a relationship between a pirate's
# college and whether or not they wear an eyepatch?

colpatch.cstest <- chisq.test(x = table(pirates$college,
                                        pirates$eyepatch))

colpatch.cstest
# --> we would conclude that we fail to reject the null hypothesis and state that we do not have enough information to 
# determine if pirates from different colleges differ in how likely they are to wear eye patches.

# 13.5.1 Getting APA-style conclusions with the apa function
test.result <- t.test(age ~ headband,
                      data = pirates)
test.result
yarrr::apa(test.result) # results are returned in a simple one line statement way




age.parrots.ctest <- cor.test(formula = ~ age + parrots,
                              data = pirates)

age.parrots.ctest
yarrr::apa(age.parrots.ctest)



## Chapter 14 ANOVA
# compare means of three levels of one or two nominal variables (factors)
# testing the effect of one or more nominal (aka factor) independent variable(s) on a numerical dependent variable.
# For example, let’s say you want to test how well each of three different cleaning fluids are at getting poop off of your 
# poop deck.To test this, you could do the following: over the course of 300 cleaning days, you clean different areas of 
# the deck with the three different cleaners. You then record how long it takes for each cleaner to clean its portion of 
# the deck. At the same time, you could also measure how well the cleaner is cleaning two different types of poop that 
# typically show up on your deck: shark and parrot. Here, your independent variables cleaner and type are factors, and your dependent variable time is numeric.

head(poopdeck)

# visualize the poopdeck data
pirateplot(formula = time ~ cleaner + type,
           data = poopdeck,
           ylim = c(0, 150),
           xlab = "Cleaner",
           ylab = "Cleaning Time (minutes)",
           main = "poopdeck data",
           back.col = gray(.97), 
           cap.beans = TRUE, 
           theme = 2)
# Question|	Analysis|	Formula
# Is there a difference between the different cleaners on cleaning time (ignoring poop type)?|
  # One way ANOVA	| time ~ cleaner
# Is there a difference between the different poop types on cleaning time (ignoring which cleaner is used)	
  # One-way ANOVA	| time ~ type
# Is there a unique effect of the cleaner or poop types on cleaning time?	
  # Two-way ANOVA	| time ~ cleaner + type
# Does the effect of cleaner depend on the poop type?	
  #Two-way ANOVA with interaction term |	time ~ cleaner * type


# 14.1 Full-factorial between-subjects ANOVA

#* We cover just one type of ANOVAs called full-factorial, between-subjects ANOVAs. These are 
#* the simplest types of ANOVAs which are used to analyze a standard experimental design. 
#* In a full-factorial, between-subjects ANOVA, participants (aka, source of data) are randomly 
#* assigned to a unique combination of factors – where a combination of factors means a 
#* specific experimental condition. For example, consider a psychology study comparing the 
#* effects of caffeine on cognitive performance. The study could have two independent 
#* variables: drink type (soda vs. coffee vs. energy drink), and drink dose (.25l, .5l, 1l). 
#* In a full-factorial design, each participant in the study would be randomly assigned to 
#* one drink type and one drink dose condition. In this design, there would be 3 x 3 = 9 
#* conditions. Here, we refer to full-factorial between-subjects ANOVAs as 'standard' ANOVAs
#* 

# 14.1.1 What does ANOVA stand for?

#* ANOVA actually uses variances to determine whether or not there are ‘real’ differences in 
#* the means of groups. Specifically, it looks at how variable data are within groups and 
#* compares that to the variability of data between groups. If the between-group variance 
#* is large compared to the within group variance, the ANOVA will conclude that the groups 
#* do differ in their means. If the between-group variance is small compared to the within 
#* group variance, the ANOVA will conclude that the groups are all the same. 
#* See Figure~ for a visual depiction of an ANOVA.

# 14.2 4 Steps to conduct an ANOVA

# Step 1: Create an aov object
mod.aov <- aov(formula = y ~ x1 + x2 + ...,
               data = data)

# Step 2: Look at a summary of the aov object
summary(mod.aov)


# Step 3: Calculate post-hoc tests
TukeyHSD(mod.aov)

# Step 4: Look at coefficients 
# If necessary, interpret the nature of the group differences by creating a linear regression 
# object using lm() using the same arguments you used in the aov() function in Step 1.
mod.lm <- lm(formula = y ~ x1 + x2 + ...,
             data = data)

summary(mod.lm)

# 14.3 Ex: One-way ANOVA
# set cleaning time time as the dependent variable and the cleaner type cleaner as 
# the independent variable. 

yarrr::pirateplot(time ~ cleaner, 
                  data = poopdeck, 
                  theme = 2, 
                  cap.beans = TRUE,
                  main = "formula = time ~ cleaner")

# Step 1: aov object with time as DV and cleaner as IV
cleaner.aov <- aov(formula = time ~ cleaner,
                   data = poopdeck)
# Step 2: Look at the summary of the anova object
summary(cleaner.aov)

# The main result from our table is that we have a significant effect of cleaner on cleaning 
# time (F(2, 597) = 5.29, p = 0.005. However, the ANOVA table does not tell us which levels of
# the independent variable differ. In other words, we don’t know which cleaner is better than
# which. To answer this, we need to conduct a post-hoc test.

#* If you’ve found a significant effect of a factor, you can then do post-hoc tests to test 
#* the difference between each all pairs of levels of the independent variable. 
#* One of the most common post-hoc tests for standard ANOVAs is the Tukey Honestly 
#* Significant Difference (HSD) test. To see additional information about the Tukey HSD test
#* 
#* # Step 3: Conduct post-hoc tests
TukeyHSD(cleaner.aov)
#* This table shows us pair-wise differences between each group pair. The diff column shows us
#* the mean differences between groups (which thankfully are identical to what we found in the 
#* summary of the regression object before), a confidence interval for the difference, and a p-value testing the null hypothesis that the group differences are not different.

# Step 4: Create a regression object
cleaner.lm <- lm(formula = time ~ cleaner,
                 data = poopdeck)

# Show summary
summary(cleaner.lm)

#* As you can see, the regression table does not give us tests for each variable like the ANOVA 
#* table does. Instead, it tells us how different each level of an independent variable is from 
#* a default value. You can tell which value of an independent variable is the default variable 
#* just by seeing which value is missing from the table. In this case, I don’t see a coefficient
#*  for cleaner a, so that must be the default value.
#* The intercept in the table tells us the mean of the default value. In this case, the mean 
#* time of cleaner a was 66.02. The coefficients for the other levels tell us that cleaner b is,
#*on average 0.42 minutes faster than cleaner a, and cleaner c is on average 6.94 minutes 
#* faster than cleaner a. Not surprisingly, these are the same differences we saw in the Tukey
#* HSD test!

# 14.4 Ex: Two-way ANOVA
# Step 1: Create ANOVA object with aov()
cleaner.type.aov <- aov(formula = time ~ cleaner + type,
                        data = poopdeck)

# Step 2: Get ANOVA table with summary()
summary(cleaner.type.aov)
# --> It looks like we found significant effects of both independent variables

# Step 3: Conduct post-hoc tests
TukeyHSD(cleaner.type.aov)
# --> The only non-significant group difference we found is between cleaner b and cleaner a. 
# All other comparisons were significant.

# Step 4: Look at regression coefficients
cleaner.type.lm <- lm(formula = time ~ cleaner + type,
                      data = poopdeck)

summary(cleaner.type.lm)
#* Now we need to interpret the results in respect to two default values (here, cleaner = a and type = parrot). 
#* The intercept means that the average time for cleaner a on parrot poop was 54.36 minutes. 
#* Additionally, the average time to clean shark poop was 23.33 minutes slower than when 
#* cleaning parrot poop. 

# 14.4.1 ANOVA with interactions
# Testing whether or not the effect of one variable depends on another variable
# Question is "Does the effect of cleaners depend on the type of poop they are used to clean? "

# Step 1: Create ANOVA object with interactions
cleaner.type.int.aov <- aov(formula = time ~ cleaner * type,
                            data = poopdeck)

# Step 2: Look at summary table
summary(cleaner.type.int.aov)
# --> the effectiveness of a cleaner depends on the type of poop it’s being applied to.

# To understand the nature of the difference, we’ll look at the regression coefficients from 
# a regression object:

# Step 4: Calculate regression coefficients
cleaner.type.int.lm <- lm(formula = time ~ cleaner * type,
                          data = poopdeck)

summary(cleaner.type.int.lm)
# --> cleaner = "a" and type = "parrot" are the defaults. Again, we can interpret the coefficients as 
# differences between a level and the default.
# --> The interaction terms tell us how the effect of cleaners changes when one is cleaning shark poop. 
# The negative estimate (-16.96) for cleanerb:typeshark means that cleaner b is, on average 16.96 minutes 
# faster when cleaning shark poop compared to parrot poop. Because the previous estimate for cleaner b 
# (for parrot poop) was just 8.06, this suggests that cleaner b is slower than cleaner a for parrot poop, 
# but faster than cleaner a for shark poop. Same thing for cleaner c which simply has stronger effects in 
# both directions.

# 14.5 Type I, Type II, and Type III ANOVAs
# These types differ in how they calculate variability (specifically the sums of of squares)
# TypeI: balanced data (equal numbers of observation in each group), standard aov() function in R
# TypeII and TypeIII: unbalanced data, use the Anova() function in the car package

# Step 1: Calculate regression object with lm()
time.lm <- lm(formula = time ~ type + cleaner,
              data = poopdeck)

# Type I ANOVA - aov()
time.I.aov <- aov(time.lm)

# Type II ANOVA - Anova(type = 2)
time.II.aov <- car::Anova(time.lm, type = 2)

# Type III ANOVA - Anova(type = 3)
time.III.aov <- car::Anova(time.lm, type = 3)

time.I.aov
time.II.aov
time.III.aov

# Are observations in the poopdeck data balanced?
with(poopdeck,
     table(cleaner, type))

# 14.6 Getting additional information from ANOVA objects

# Show me what's in my aov object
names(cleaner.type.int.aov)
# For example, the "fitted.values" contains the model fits for the dependent variable (time) for every 
# observation in our dataset. 

# Add the fits for the interaction model to the dataframe as int.fit
poopdeck$int.fit <- cleaner.type.int.aov$fitted.values

# Add the fits for the main effects model to the dataframe as me.fit
poopdeck$me.fit <- cleaner.type.aov$fitted.values

head(poopdeck)

# You can use these fits to see how well (or poorly) the model(s) were able to fit the data. 
# For example, we can calculate how far each model’s fits were from the true data as follows:

# How far were the interaction model fits from the data on average?
mean(abs(poopdeck$int.fit - poopdeck$time))

# How far were the main effect model fits from the data on average?
mean(abs(poopdeck$me.fit - poopdeck$time))

# the interaction model was off from the data by 15.35 minutes on average, while the main effects model was 
# off from the data by 16.54 on average. This is not surprising as the interaction model is more complex 
# than the main effects only model. However, just because the interaction model is better at fitting the 
# data doesn’t necessarily mean that the interaction is either meaningful or reliable.


## 14.7 Repeated measures ANOVA using the lme4 package
# If you are conducting an analyses where you’re repeating measurements over one or more third variables, 
# like giving the same participant different tests, you should do a mixed-effects regression analysis. 
# To do this, you should use the lmer function in the lme4 package. For example, in our poopdeck data, 
# we have repeated measurements for days. That is, on each day, we had 6 measurements. Now, it’s possible 
# that the overall cleaning times differed depending on the day. We can account for this by including random 
# intercepts for day by adding the (1|day) term to the formula specification. For more tips on mixed-effects 
# analyses, check out this great tutorial by Bodo Winter at http://www.bodowinter.com/tutorial/bw_LME_tutorial2.pdf.



# install.packages(lme4)  # If you don't have the package already
library(lme4)

# Calculate a mixed-effects regression on time with
#  Two fixed factors (cleaner and type)
#  And one repeated measure (day)

my.mod <- lmer(formula = time ~ cleaner + type + (1|day),
               data = poopdeck)


my.mod


### Chapter 15 Regression

## 15.1 The Linear Model

#  predict a continuous variable of interest (the response or dependent variable) on the basis of one or more 
# other variables (the predictor or independent variables).

# The linear model takes the following form, where the x values represent the predictors, while the beta values
# represent weights.
# y=β0+ β1x1 + β2x2 + ...βnxn
# we could define the value of a diamond as βweight × weight+ βclarity × clarity.
# Where βweight indicates how much a diamond’s value changes as a function of its weight, and βclarity


## 15.2 Linear regression with lm()
# formula |  If you want to include all columns (excluding y) as independent variables, just enter y ~ .

# 15.2.1 Estimating the value of diamonds with lm()
# The dataset includes data on 150 diamonds sold at an auction. Here are the first few rows of the dataset:

library(yarrr)
head(diamonds)

# Create a linear model of diamond values
#   DV (Dependent Variable) = value, IVs (Independent Variable) = weight, clarity, color

diamonds.lm <- lm(formula = value ~ weight + clarity + color,
                  data = diamonds)

# Print summary statistics from diamond model
summary(diamonds.lm)

# Which components are in the regression object?
names(diamonds.lm)

# The coefficients in the diamond model
diamonds.lm$coefficients

# Coefficient statistics in the diamond model
summary(diamonds.lm)$coefficients


# 15.2.2 Getting model fits with fitted.values
# To see the fitted values from a regression object (the values of the dependent variable predicted by the 
# model), access the fitted.values attribute from a regression object with $fitted.values.

# Add the fitted values as a new column in the dataframe
diamonds$value.lm <- diamonds.lm$fitted.values

# Show the result
head(diamonds)



# Plot the relationship between true diamond values and linear model fitted values

plot(x = diamonds$value,                          # True values on x-axis
     y = diamonds.lm$fitted.values,               # fitted values on y-axis
     xlab = "True Values",
     ylab = "Model Fitted Values",
     main = "Regression fits of diamond values")

abline(b = 1, a = 0)                             # Values should fall around this line!


# 15.2.3 Using predict() to predict new data from a model

# Create a dataframe of new diamond data
diamonds.new <- data.frame(weight = c(12, 6, 5),
                           clarity = c(1.3, 1, 1.5),
                           color = c(5, 2, 3))

# Predict the value of the new diamonds using
#  the diamonds.lm regression model
predict(object = diamonds.lm,     # The regression model
        newdata = diamonds.new)   # dataframe of new data

# Create a regression model with interactions between 
#   IVS weight and clarity
diamonds.int.lm <- lm(formula = value ~ weight * clarity,
                      data = diamonds)

# Show summary statistics of model coefficients
summary(diamonds.int.lm)$coefficients


# 15.2.5 Center variables before computing interactions!
# *Why are all the variables now non-significant? Does this mean that there is really no 
# relationship between weight and clarity on value after all? 
#  when you include interaction terms in a model, you should always center the independent 
# variables first. Centering a variable means simply subtracting the mean of the variable 
# from all observations.

# Create centered versions of weight and clarity
diamonds$weight.c <- diamonds$weight - mean(diamonds$weight)
diamonds$clarity.c <- diamonds$clarity - mean(diamonds$clarity)

# Create a regression model with interactions of centered variables
diamonds.int.lm <- lm(formula = value ~ weight.c * clarity.c,
                      data = diamonds)

# Print summary
summary(diamonds.int.lm)$coefficients

# 15.2.6 Getting an ANOVA from a regression model with aov()
# Once you’ve created a regression object with lm() or glm(), you can summarize the results 
# in an ANOVA table with aov():

# Create ANOVA object from regression
diamonds.aov <- aov(diamonds.lm)

# Print summary results
summary(diamonds.aov)

# 15.3 Comparing regression models with anova()
# A good model not only needs to fit data well, it also needs to be parsimonious.

# If the resulting p-value is sufficiently low (usually less than 0.05), we conclude that the 
# more complex model is significantly better than the simpler model, and thus favor the more 
# complex model. If the p-value is not sufficiently low (usually greater than 0.05), 
# we should favor the simpler model.

# The models will differ in their complexity – that is, the number of independent variables
# they use.

# model 1: 1 IV (only weight)
diamonds.mod1 <- lm(value ~ weight, data = diamonds)

# Model 2: 2 IVs (weight AND clarity)
diamonds.mod2 <- lm(value ~ weight + clarity, data = diamonds)

# Model 3: 3 IVs (weight AND clarity AND color)
diamonds.mod3 <- lm(value ~ weight + clarity + color, data = diamonds)

# Compare model 1 to model 2
anova(diamonds.mod1, diamonds.mod2)
# --> As you can see, the result shows a Df of 1 (indicating that the more complex model has one additional parameter),
# and a very small p-value (< .001). This means that adding the clarity IV to the model did lead to a significantly 
# improved fit over the model 1.

# Next, let’s use anova() to compare model 2 and model 3. This will tell us whether adding color 
# (on top of weight and clarity) further improves the model:
# Compare model 2 to model 3
anova(diamonds.mod2, diamonds.mod3)
# --> The result shows a non-significant result (p = 0.21). Thus, we should reject model 3 and 
# stick with model 2 with only 2 IVs.


## 15.4 Regression on non-Normal data with glm()

# Family name | Description
# "binomial"	| Binary logistic regression, useful when the response is either 0 or 1.
# "gaussian" |	Standard linear regression. Using this family will give you the same result as lm()
# "Gamma"| 	Gamma regression, useful for highly positively skewed data
# "inverse.gaussian" |	Inverse-Gaussian regression, useful when the dv is strictly positive and skewed to the right.
# "poisson"| 	Poisson regression, useful for count data. For example,   How many parrots has a pirate owned over his/her lifetime?“

# When your dependent variable does not follow a nice bell-shaped Normal distribution, you need to use the 
# Generalized Linear Model (GLM). the GLM is a more general class of linear models that change the distribution 
# of your dependent variable. In other words, it allows you to use the linear model even when your dependent variable 
# isn’t a normal bell-shape. Here are 4 of the most common distributions you can can model with glm():

## 15.5 Logistic regression with glm(family = "binomial")
# Create a binary variable indicating whether or not
#   a diamond's value is greater than 190
diamonds$value.g190 <- diamonds$value > 190

# Conduct a logistic regression on the new binary variable
diamond.glm <- glm(formula = value.g190 ~ weight + clarity + color,
                   data = diamonds,
                   family = binomial)
summary(diamond.glm)$coefficients

# Add logistic fitted values back to dataframe as new column pred.g190
diamonds$pred.g190 <- diamond.glm$fitted.values

head(diamonds[c("weight", "clarity", "color", "value", "pred.g190")])

# Predict the 'probability' that the 3 new diamonds will have a value greater than 190
# Create a dataframe of new diamond data
diamonds.new <- data.frame(weight = c(12, 6, 5),
                           clarity = c(1.3, 1, 1.5),
                           color = c(5, 2, 3))


predict(object = diamond.glm,
        newdata = diamonds.new)
#--> They are logit-transformed probabilities. To turn them back into probabilities, 
# we need to invert them by applying the inverse logit function:

# Get logit predictions of new diamonds
logit.predictions <- predict(object = diamond.glm,
                             newdata = diamonds.new
)

# Apply inverse logit to transform to probabilities
#  (See Equation in the margin)
prob.predictions <- 1 / (1 + exp(-logit.predictions))

# Print final predictions!
prob.predictions
# --> So, the model predicts that the probability that the three new diamonds will be valued over 190 is 99.23%, 2.86%, 
# and 40.38% respectively.

# 15.5.1 Adding a regression line to a plot
# Scatterplot of diamond weight and value
plot(x = diamonds$weight,
     y = diamonds$value,
     xlab = "Weight",
     ylab = "Value",
     main = "Adding a regression line with abline()"
)

# Calculate regression model
diamonds.lm <- lm(formula = value ~ weight,
                  data = diamonds)

# Add regression line
abline(diamonds.lm,
       col = "red", lwd = 2)


# 15.5.2 Transforming skewed variables prior to standard regression

# The distribution of movie revenus is highly skewed.
# If you have a highly skewed variable that you want to include in a regression analysis, you can do one of two things. 
# Option 1 is to use the general linear model glm() with an appropriate family (like family = "gamma"). 
# Option 2 is to do a standard regression analysis with lm(), but before doing so, transforming the variable into something less 
# skewed. For highly skewed data, the most common transformation is a log-transformation.


hist(movies$revenue.all, 
     main = "Movie revenue\nBefore log-transformation")

# Create a new log-transformed version of movie revenue
movies$revenue.all.log <- log(movies$revenue.all)

# Distribution of log-transformed revenue is much less skewed
hist(movies$revenue.all.log, 
     main = "Log-transformed Movie revenue")

#Daniel "Tom" Gehman
#Professor Kennedy
#Final Data 180

library('readxl')
setwd("C:/Users/gehmand/OneDrive - Carlisle Area School District/Desktop/Data 180 dTomGehman/DATA180/Final")
loandefaults = read.csv("loan_default_data_set.csv")

#Question 1
#part a
dim(loandefaults) #20000x21, i.e., 20000 observations/rows and 21 variables/columns

#part b
colnames(loandefaults)

#part c
head(loandefaults) #All of the variables are numerical except for rep_education (ordinal and categorical) and Def_ind (binary and categorical).  

#part d
for (i in colnames(loandefaults)){
  cat(i, ":: ", sum(is.na(loandefaults[[i]]))/nrow(loandefaults)*100, "% \n")
}
#only pct_card_over_50_uti and rep_income have missing values.  They are missing 9.79% and 7.795% respectively. 

#part e
#There are a few ways to deal with these missing values.  
#If finding summary statistics of each column, the values should be deleted.  
#When displaying data, it should be noted to the reader that there is a certain percentage of missing values.  
#Depending on my goal, I could delete the two columns with missing values from the dataset, or I could delete all observations with any missing values.  

#part f
#This data has predictor variables and a definite response variable.  
#Therefore, it would make the most sense to apply a supervised learning model.  
#Supervised learning requires a predictor and response to be established, while unsupervised learning has no predictors/responses.  

#part g
library('dplyr')
loandefaults = filter(loandefaults, !(is.na(pct_card_over_50_uti)|is.na(rep_income)))
dim(loandefaults) #Observations reduced to 16653


#Question 2
#part a
summary(loandefaults)

#part b
#additionally find modes of each
names(sort(-table(loandefaults$num_card_inq_24_month)))[1]#0
names(sort(-table(loandefaults$tot_amount_currently_past_due)))[1]#0
names(sort(-table(loandefaults$credit_age)))[1]#295

#num_card_inq_24_month is right-skewed.  It has a median of 0 and a mean of 1.044.  
#Most of the data are 0s (mode=0) with some higher numbers that contribute to the mean.  
#tot_amount_currently_past_due is similar.  The median of 0 is much less than the mean of 354.2.  
#It is right-skewed.
#credit age is close to being centered.  The median is 281, and the mean is 280.9.  
#By this metric, it is very slightly left-skewed, almost symmetrical (bell-shaped).  
#The mode is 295, which is a bit higher than I'd expect.  This implies a bit of a further left skew, 
#but not much since the mean and median are still so similar.  

#part c
library('ggplot2')
ggplot(loandefaults, aes(num_card_inq_24_month)) + geom_histogram() #this confirms the strong right skew
ggplot(loandefaults, aes(tot_amount_currently_past_due)) + geom_histogram() #this confirms the strong right skew
ggplot(loandefaults, aes(credit_age)) + geom_histogram() #this shows a strong bell shape.  

#part d
print(levels(factor(loandefaults$rep_education))) #the 4 categories
#one way to assign numbers would be through a levels system, where each category gets a number
#These categories seem to have a natural order that could be 0-other, 1-high_school, 2-college, 3-graduate
#This solution creates one variable and has a hierarchy.  

#Additionally, another option is to have four variables created, each representing a level.  
#A 1 or 0 is assigned for each object depending on whether or not it matches the level.  
#E.g., an account with college ed would be assigned 1 for "college" and 0 for all others.  
#This solution has no hierarchy.  It makes a sparse matrix with multiple variables.  



#note: add labels to histograms
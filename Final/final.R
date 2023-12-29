#Daniel "Tom" Gehman
#Professor Kennedy
#Final Data 180
# 40/40. Good job. 
library('readxl')
#setwd("C:/Users/gehmand/OneDrive - Carlisle Area School District/Desktop/Data 180 dTomGehman/DATA180/Final")
loandefaults = read.csv("C:/Users/rodge/OneDrive/Desktop/DATA 180 -Intoduction to Data Science/DATA-180-Introduction-to-Data-Science--Section-2/data/loan_default_data_set.csv")

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
#Depending on my goal, I could delete/ignore the two columns with missing values from the dataset, or I could delete all observations with any missing values.  

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
#mean & med are in the summary stats
#additionally find modes of each
names(sort(-table(loandefaults$num_card_inq_24_month)))[1]#0
names(sort(-table(loandefaults$tot_amount_currently_past_due)))[1]#0
names(sort(-table(loandefaults$credit_age)))[1]#295

#num_card_inq_24_month is right-skewed.  It has a median of 0 and a mean of 1.044.  
#Most of the data are 0s (mode=0) with some higher numbers that contribute to the mean.  
#tot_amount_currently_past_due is similar.  The median of 0 is much less than the mean of 354.2.  
#It has a mode of 0 as well; it is right-skewed.
#credit age is close to being centered.  The median is 281, and the mean is 280.9.  
#By this metric, it is very slightly left-skewed, almost symmetrical (bell-shaped).  
#The mode is 295, which is a bit higher than I'd expect.  This implies a bit of a left skew, 
#but not much since the mean and median are still so similar.  

#part c
library('ggplot2')
ggplot(loandefaults, aes(num_card_inq_24_month)) + geom_histogram(binwidth=1) + labs(title="Recent Card Inquiries", x="Number of Card Inquiries in Last 24 Months", y="Frequency")
#this confirms the strong right skew

ggplot(loandefaults, aes(tot_amount_currently_past_due)) + geom_histogram() + labs(title="Amounts Currently Past Due", x="Total Amount Past Due ($)", y="Frequency") 
#this confirms the strong right skew

ggplot(loandefaults, aes(credit_age)) + geom_histogram() + labs(title="Credit Ages", y="Frequency", x="Age (months) of first credit product obtained by the applicant")
#this shows a strong bell shape.  The left skew is real but very small as expected.  

#part d
print(levels(factor(loandefaults$rep_education))) #the 4 categories
#one way to assign numbers would be through a levels system, where each category gets a number
#These categories seem to have a natural order that could be 0-other, 1-high_school, 2-college, 3-graduate
#or 1-high_school, 2-college, 3-graduate, and 4-other
#or even 1-other 2-high_school, 3-college, and 4-graduate
#This solution creates one variable and has a hierarchy.  
#A disadvantage is that I'm unsure of how the "other" category would fit in the hierarchy.  

#Additionally, another option is to have four binary variables created, each representing a level.  
#A 1 or 0 is assigned for each object depending on whether or not it matches the level. 
#Four variables would be created, e.g., "isCollege", "isGraduate", "isHigh_school", and "isOther"
#E.g., an account with college ed would be assigned 1 for "isCollege" and 0 for all others.  
#This solution has no hierarchy.  It makes a sparse section of the dataframe, adding multiple variables (not just one like the other option).  


#Question 3
#part a
ggplot(loandefaults, aes(ifelse(Def_ind==1, "Defaulted", "Not Defaulted"), fill=as.factor(Def_ind)))+geom_bar()+scale_fill_manual(values=c("green", "red"))+labs(title="Loans Defaulted", y="Frequency", x="Account Status", subtitle="Defaulted after an account was approved and opened with bank XYZ\nin the past 18 months.  ")
#There are two categories, Defaulted and Not Defaulted (1 and 0).  Most of the loans have not been defaulted (~15,000), but about 2,000 have.  

#part b
ggplot(loandefaults, aes(rep_education, fill=rep_education))+geom_bar()+labs(title="Educations Level of Account Holders", x="Education Level", y="Frequency")
#There are four categories.  A majority (~10,000) of account holders have a college education.  
#Fewer than 5,000 have a high school education or less, and fewer than 2,500 have been to graduate school.  
#A small number are in the "other" category.  

#part c
ggplot(loandefaults, aes(rep_income/1000))+geom_histogram()+labs(title="Incomes of Account Holders", x="Income (thousands of dollars)", y="Frequency")
#The incomes appear bell-shaped with a mean, median, and mode of about $170,000.  

#part d
ggplot(loandefaults, aes(tot_balance))+geom_boxplot()+labs(title="Account Balances", x="Balance ($)")
#Based on the boxplot, the five number summary appears to be:  
 #Min=0
 #Q1=90,000
 #Med=110,000
 #Q3=125,000
 #max=200,000
#There are many outliers.  
#There appears to be at least a dozen upper outliers and a dozen lower outliers (but there could be more since they overlap on the plot).  

#Actual values to confirm:  
min(loandefaults$tot_balance) #minimum=0
quantile(loandefaults$tot_balance, .25) #q1=92,141.84
median(loandefaults$tot_balance) #med=107,739.6
quantile(loandefaults$tot_balance, .75) #q3=122,931.8
max(loandefaults$tot_balance) #max=200,000

#the upper and lower fence can be given by
median(loandefaults$tot_balance)+1.5*(quantile(loandefaults$tot_balance, .25)-quantile(loandefaults$tot_balance, .75))
median(loandefaults$tot_balance)-1.5*(quantile(loandefaults$tot_balance, .25)-quantile(loandefaults$tot_balance, .75))
#This is reflected on the plot, and there are many outliers on each side.  Not surprising for a data set this large.  

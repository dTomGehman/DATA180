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
#This data has many independent variables and no dependent variable.  
#Therefore, it would make the most sense to apply an unsupervised learning model.  
#Supervised learning would require a predictor and response to be established, which is not the case here.  

#part g
library('dplyr')
loandefaults = filter(loandefaults, !(is.na(pct_card_over_50_uti)|is.na(rep_income)))
dim(loandefaults) #Observations reduced to 16653


#Question 2
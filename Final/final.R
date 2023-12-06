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

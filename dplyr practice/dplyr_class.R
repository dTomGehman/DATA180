library(MASS) #load mass first
library(dplyr)


ls(Cars93)
Cars93_Ex1 = select(Cars93, Type, EngineSize, DriveTrain, MPG.city) #select columns
head(Cars93_Ex1)

Cars93_Ex2 = filter(Cars93, Type=="Small") #select rows
head(Cars93_Ex2)

Cars93_Ex3 = select(filter(Cars93, Horsepower>150), Model, EngineSize, Horsepower, MPG.highway)
head(Cars93_Ex3)

Cars93_Ex5 = select(filter(Cars93, Horsepower>120 & Type=="Small"), Model, EngineSize, Horsepower, MPG.highway) #and operator
head(Cars93_Ex5) 

Cars93_Ex6 = select(filter(Cars93, Horsepower>120 | Type=="Small"), Model, EngineSize, Horsepower, MPG.highway) # or operator
head(Cars93_Ex6)
library("MASS") #load library
head(Cars93) #display first 6 observations
help(Cars93) #display help panel on side
ls(Cars93) #list variables

Cars93$Type #list values of one variable, e.g., Type
Cars93$Price

table(Cars93$AirBags) #display distributions, categorical var like Airbags
table(Cars93$AirBags) /nrow(Cars93) #calc rel freq using number of rows
round(table(Cars93$AirBags) /nrow(Cars93), 3) #round prev to 3 dec

#disp bar plot in side panel
barplot(table(Cars93$AirBags) ,ylab="Frequency", cex.lab=1.3, col=c(2, 3, 4))


#display list of first 20 colors
colors()[1:20] #colors outputs list.  [] slices list

#set palette
palette(c("red", "orchid1", "yellow4", "tomato2"))
palette()

#restore default palette
palette("default")

barplot(sort(table(Cars93$Manufacturer)/length(Cars93$Manufacturer),decreasing=T), ylab="Relative Frequency", xlab="Manufacturer", cex.names=.5, cex.axis=1.2, cex.lab=1.2)



Cars93$Weight
stem(Cars93$Weight) #stem&leaf plot

#dot plots
stripchart(Cars93$MPG.city, method="stack", pch=16, cex.axis=1.2, cex.lab=1.2, xlab="Miles per Gallon")
stripchart(Cars93$MPG.city, method="jitter", pch=16, cex.axis=1.2, cex.lab=1.2, xlab="Miles per Gallon")

#cex.axis - size of axis markings
#cex.lab - label size
#method - arrangement (jitter or stack)
#xlab - label underneath


hist(Cars93$MPG.city, cex.lab=1.2, cex.axis=1.2, breaks=seq(15, 50, 5), xlab="MPG city")


#plot(CArs93$Horsepower, Cars93$MPG.highway)

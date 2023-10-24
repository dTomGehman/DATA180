x=matrix(c(1,1,2,3,1,4), nrow=3, byrow=T)

dist(x)
dist(x, method="manhattan")
dist(x, method="minkowski", p=5, upper=T)

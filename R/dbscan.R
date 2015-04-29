matrixSimmilarity = as.matrix(simmilarityMatrix, as.is=T, row.names=colnames(simmilarityMatrix))

install.packages("fpc")
library("fpc")

dbscan(dataMatrix, eps=0.01,MinPts= 10, method="dist", showplot=T)

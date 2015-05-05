#install.packages("fpc")
library("fpc")

matrixSimmilarity <- read.delim("~/GitHub/mestrado_UFCG/Java Workspace/DiversificationAlgorithms/data/allItem_Category.tsv")
matrixSimmilarity = matrixSimmilarity[,c(1:1883)]

matrixSimmilarity = as.matrix(matrixSimmilarity, as.is=T, rownames=colnames(matrixSimmilarity))

dissimilarity = 1.0-matrixSimmilarity

# k nearest neighbours
f <- function(a) {
  a_sorted = sort(a,decreasing=F)
  a_sorted = a_sorted[c(2:20)]
  x = mean(a_sorted)
  return (x)
}

plot(sort(apply(dissimilarity, 1, f)),xlab="k-nearest neighbour distance", ylab="Sorted Points", main="Average K-Dist sorted plot")
hist(matrixSimmilarity[matrixSimmilarity!=0.0])

results = dbscan(data = dissimilarity, eps=0.15, MinPts= 20, method="dist", showplot=T,)
results

results$cluster

dbscan(data = dissimilarity, eps=0.15, MinPts= 20, method="dist", showplot=T,)


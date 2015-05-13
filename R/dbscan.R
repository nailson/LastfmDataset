#install.packages("fpc")
library("fpc")

#matrixSimmilarity = matrix_simmilarity[,c(1:8962)]
matrixSimmilarity <- read.delim("~/GitHub/mestrado_UFCG/Java Workspace/DiversificationAlgorithms/data/allItem_Category.tsv")
matrixSimmilarity = UserMatrixSimmilarity
matrixSimmilarity = matrixSimmilarity[,c(1:8761)]

matrixSimmilarity = as.matrix(matrixSimmilarity, )

dissimilarity = 1.0-matrixSimmilarity

# k nearest neighbours
f <- function(a) {
  a_sorted = sort(a,decreasing=F)
  a_sorted = a_sorted[c(2:50)]
  x = mean(a_sorted)
  return (x)
}

plot(sort(apply(dissimilarity, 1, f)),xlab="k-nearest neighbour distance", ylab="Sorted Points", main="Average K-Dist sorted plot")
hist(matrixSimmilarity[matrixSimmilarity!=0.0])

results = dbscan(data = dissimilarity, eps=0.17, MinPts= 20, method="dist", showplot=T,)

results

cluster.stats(d = dissimilarity, clustering= results$cluster)

clustered_users = data.frame(user=substring(colnames(dissimilarity),2), cluster=results$cluster)

boxplot(results)

dbscan(data = dissimilarity, eps=0.14, MinPts= 20, method="dist", showplot=T,)


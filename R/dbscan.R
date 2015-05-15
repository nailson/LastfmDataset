#install.packages("fpc")
library("fpc")

matrixSimmilarity <- read.delim("~/GitHub/mestrado_UFCG/Java Workspace/DiversificationAlgorithms/data/allItem_Category.tsv")
matrixSimmilarity = UserMatrixSimmilarity
matrixSimmilarity = matrixSimmilarity[,c(1:8761)]

matrixSimmilarity = as.matrix(matrixSimmilarity, )

dissimilarity = 1.0-matrixSimmilarity

hist(matrixSimmilarity[matrixSimmilarity!=0.0])

# k nearest neighbours to discober the eps value
f <- function(a) {
  a_sorted = sort(a,decreasing=F)
  a_sorted = a_sorted[c(2:50)]
  x = mean(a_sorted)
  return (x)
}
plot(sort(apply(dissimilarity, 1, f)),xlab="k-nearest neighbour distance", ylab="Sorted Points", main="Average K-Dist sorted plot")


# pamk : partitioning around medoids clustering with the number of clusters estimated by optimum average silhouette width
# input : data, krange, criterion, usepam, scaling, alpha, diss, critout, ns, ...
pamk(data=dissimilarity, krange=2:10,criterion="asw", usepam=TRUE,)

# dbscan : Generates a density based clustering of arbitrary shape
# input : data, eps, minPoints, scale, method, seeds, showplot, countmode, ...
results = dbscan(data = dissimilarity, eps=0.17, MinPts= 20, method="dist", showplot=T,)
results
dbscanCBI

cluster.stats(d = dissimilarity, clustering= results$cluster)

clustered_users = data.frame(user=substring(colnames(dissimilarity),2), cluster=results$cluster)

boxplot(results)

dbscan(data = dissimilarity, eps=0.14, MinPts= 20, method="dist", showplot=T,)


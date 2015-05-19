#install.packages("fpc")
#install.packages("mgcv")

library("fpc")
library("mgcv")

matrixSimmilarity <- read.delim("~/GitHub/mestrado_UFCG/Java Workspace/DiversificationAlgorithms/data/allItem_Category.tsv")
matrixSimmilarity = UserMatrixSimmilarity
matrixSimmilarity = matrixSimmilarity[,c(1:8723)]

matrixSimmilarity = as.matrix(matrixSimmilarity, )

dissimilarity = 1.0-matrixSimmilarity
rm(matrixSimmilarity)
rm(UserMatrixSimmilarity)

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
pamkResult = pamk(data=dissimilarity, krange=2:10,criterion="asw", usepam=TRUE,)
save(pamkResult, file='pamkResult.rda')
load(file="C:/Users/Nailson/Dropbox/pamkResult.rda", )

pamkResult
pamkResult$pamobject$silinfo$clus.avg.widths

clustered_users = data.frame(user=substring(colnames(dissimilarity),2), cluster=pamkResult$pamobject$clustering)
write.table(clustered_users, quote=F, sep="\t", file="pamk.tsv")

# dbscan : Generates a density based clustering of arbitrary shape
# input : data, eps, minPoints, scale, method, seeds, showplot, countmode, ...
results = dbscan(data = dissimilarity, eps=0.25, MinPts= 100, method="dist", showplot=F, )
results

#  Validate Cluster dbscan
clusterStatsdbscan = cluster.stats(d = dissimilarity, clustering= results$cluster)
clustered_users = data.frame(user=substring(colnames(dissimilarity),2), cluster=results$cluster)

boxplot(results)


# kmeans
resultKmeans = kmeans(dissimilarity, centers=8)
save(resultKmeans, file='resultKmeans.rda')
load(file="resultKmeans.rda", )
clustered_users = data.frame(user=substring(colnames(dissimilarity),2), cluster=resultKmeans$cluster)
write.table(clustered_users, quote=F, sep="\t", file="kmeans.tsv")

# Validate Cluster Kmeans
resultKmeans$size
resultKmeans$totss
clusterStatsKmeans = cluster.stats(d = dissimilarity, clustering= resultKmeans$cluster, silhouette=T)

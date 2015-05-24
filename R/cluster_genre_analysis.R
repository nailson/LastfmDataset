library("ggplot2")

merged = merge(allItem_Category, clustered_users_dbscan, by.x="User", by.y="user")

colsumsCluster = merged[,c(-1)]
colsumsCluster = data.frame(user = colnames(colsumsCluster), atrib_sum=  colSums(colsumsCluster) )
colsumsCluster = colsumsCluster [ order(-colsumsCluster$atrib_sum), ]
plot(colsumsCluster$atrib_sum[-1])

cluster_0 = merged[merged$cluster == 0,]

colsumsCluster_0 = data.frame(user = colnames(cluster_0[,-1]), atrib_sum=  colSums(cluster_0[,-1]) )
colsumsCluster_0 = colsumsCluster_0 [ order(-colsumsCluster_0$atrib_sum), ]
plot(colsumsCluster_0$atrib_sum[-1])

cluster_1 = merged[merged$cluster == 1,]

colsumsCluster_1 = data.frame(user = colnames(cluster_1[,-1]), atrib_sum=  colSums(cluster_1[,-1]) )
colsumsCluster_1 = colsumsCluster_1 [ order(-colsumsCluster_1$atrib_sum), ]
plot(colsumsCluster_1$atrib_sum[-1])


cluster_2 = merged[merged$cluster == 2,]

colsumsCluster_2 = data.frame(user = colnames(cluster_2[,-1]), atrib_sum=  colSums(cluster_2[,-1]) )
colsumsCluster_2 = colsumsCluster_2 [ order(-colsumsCluster_2$atrib_sum), ]
plot(colsumsCluster_2$atrib_sum[-1])



cluster_3 = merged[merged$cluster == 3,]

colsumsCluster_3 = data.frame(user = colnames(cluster_3[,-1]), atrib_sum=  colSums(cluster_3[,-1]) )
colsumsCluster_3 = colsumsCluster_3 [ order(-colsumsCluster_3$atrib_sum), ]
plot(colsumsCluster_3$atrib_sum[-1])

cluster_4 = merged[merged$cluster == 4,]

colsumsCluster_4 = data.frame(user = colnames(cluster_4[,-1]), atrib_sum=  colSums(cluster_4[,-1]) )
colsumsCluster_4 = colsumsCluster_4 [ order(-colsumsCluster_4$atrib_sum), ]
plot(colsumsCluster_4$atrib_sum[-1])


cluster_5 = merged[merged$cluster == 5,]

colsumsCluster_5 = data.frame(user = colnames(cluster_5[,-1]), atrib_sum=  colSums(cluster_5[,-1]) )
colsumsCluster_5 = colsumsCluster_5 [ order(-colsumsCluster_5$atrib_sum), ]
plot(colsumsCluster_5$atrib_sum[-1])


cluster_6 = merged[merged$cluster == 6,]

colsumsCluster_6 = data.frame(user = colnames(cluster_6[,-1]), atrib_sum=  colSums(cluster_6[,-1]) )
colsumsCluster_6 = colsumsCluster_6 [ order(-colsumsCluster_6$atrib_sum), ]
plot(colsumsCluster_6$atrib_sum[-1])


top5Genres = data.frame( cluster = 0, genre_id=as.numeric(substr ( x = colsumsCluster_0$user[c(1:5)], 2, 100)), rank=c(1:5), atrib_sum = colsumsCluster_0$atrib_sum[c(1:5)]/sum(colsumsCluster_0$atrib_sum) )
top5Genres = rbind(top5Genres,  data.frame( cluster = 1, genre_id=as.numeric(substr ( x = colsumsCluster_1$user[c(2:6)], 2, 100)) , rank=c(1:5), atrib_sum = colsumsCluster_1$atrib_sum[c(2:6)]/sum(colsumsCluster_1$atrib_sum[-1])) )
top5Genres = rbind(top5Genres,  data.frame( cluster = 2, genre_id=as.numeric(substr ( x = colsumsCluster_2$user[c(2:6)], 2, 100)) , rank=c(1:5), atrib_sum = colsumsCluster_2$atrib_sum[c(2:6)]/sum(colsumsCluster_2$atrib_sum[-1])) )
top5Genres = rbind(top5Genres,  data.frame( cluster = 3, genre_id=as.numeric(substr ( x = colsumsCluster_3$user[c(2:6)], 2, 100)) , rank=c(1:5), atrib_sum = colsumsCluster_3$atrib_sum[c(2:6)]/sum(colsumsCluster_3$atrib_sum[-1])) )
top5Genres = rbind(top5Genres,  data.frame( cluster = 4, genre_id=as.numeric(substr ( x = colsumsCluster_4$user[c(2:6)], 2, 100)) , rank=c(1:5), atrib_sum = colsumsCluster_4$atrib_sum[c(2:6)]/sum(colsumsCluster_4$atrib_sum[-1])) )
top5Genres = rbind(top5Genres,  data.frame( cluster = 5, genre_id=as.numeric(substr ( x = colsumsCluster_5$user[c(2:6)], 2, 100)) , rank=c(1:5), atrib_sum = colsumsCluster_5$atrib_sum[c(2:6)]/sum(colsumsCluster_5$atrib_sum[-1])) )
top5Genres = rbind(top5Genres,  data.frame( cluster = 6, genre_id=as.numeric(substr ( x = colsumsCluster_6$user[c(2:6)], 2, 100)) , rank=c(1:5), atrib_sum = colsumsCluster_6$atrib_sum[c(2:6)]/sum(colsumsCluster_6$atrib_sum[-1])) )

top5Genres = merge(top5Genres, categories, by.x="genre_id", by.y="V2")
top5Genres$V1 = substring (top5Genres$V1, 29, 1000)
top5Genres = top5Genres[order(top5Genres$cluster, top5Genres$rank),]


p <- ggplot(top5Genres, aes(top5Genres$cluster, top5Genres$atrib_sum))
p + geom_point(aes(colour = factor(top5Genres$V1), size = top5Genres$atrib_sum), ) + scale_size_continuous(range = c(5,22))+scale_x_continuous(breaks=c(0,1,2,3,4,5,6))


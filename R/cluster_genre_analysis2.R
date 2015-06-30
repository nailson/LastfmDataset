#install.packages('reshape2')
library("ggplot2")
library('reshape2') 
colnames(map_genre) = c("V1","V2")

merged = merge(allItem_Category, clustered_users_dbscan, by.x="User", by.y="user")

colsumsCluster = merged[,c(-1)]
x = colnames(colsumsCluster)[colnames(colsumsCluster)!="cluster"]

mdat <- melt(merged, measure = x) 

z = aggregate(mdat$value, by= list(mdat$cluster, mdat$variable), FUN = mean)
colnames(z) = c("cluster","V2", "count")
z$V2 = substring(z$V2, 2)

new_z = merge(z, map_genre, by.x="V2", by.y="V2")
new_z$V1 = substring( new_z$V1, 29)

tops_genres = aggregate(new_z$count, by=list(new_z$V1), FUN = sum)
tops_genres = tops_genres[order(-tops_genres$x),]

genres = tops_genres$Group.1[c(1:10)]

top_genres_result = new_z[  new_z$V1%in%genres,]
top_genres_result$count = top_genres_result$count*100

top_genres_result = top_genres_result[top_genres_result$cluster!=0,]
write.table(top_genres_result[,c(4,3)], col.names = F, row.names = F, sep="\t", quote = F, file="dots_plot.tsv")


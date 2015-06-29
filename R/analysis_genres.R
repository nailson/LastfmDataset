

# READ FILES
artist_genre_norm <- read.delim("../new data/artist relation/artist_genre_norm.tsv", header=F)
dataset <- read.delim("../new data/dataset.tsv", header=F)


#Aggregating Genre by Weight
genre_aggregate = aggregate(artist_genre_norm$V3, by=list(artist_genre_norm$V2), FUN=sum )
genre_aggregate = genre_aggregate[order(-genre_aggregate$x),]
plot(genre_aggregate$x, main="Aggregation of sum of weights by Genre", ylab = "Aggregate Weight")
x = head(genre_aggregate, 10)
colnames(x) = c("id","sum")
x = merge(x, map_genre, by.x="id", by.y="V2")

#Aggregating Artist by length of Genres
artist_aggregate = aggregate(artist_genre_norm$V1, by=list(artist_genre_norm$V1), FUN=length )
artist_aggregate = artist_aggregate[order(-artist_aggregate$x),]
summary(artist_aggregate$x)
hist(artist_aggregate$x)

# Aggregating Genre by Length
genre_aggregate2 = aggregate(artist_genre_norm$V1, by=list(artist_genre_norm$V2), FUN=length )
genre_aggregate2 = genre_aggregate2[order(-genre_aggregate2$x),]
plot(sort(genre_aggregate2$x,decreasing=T))
x = head(genre_aggregate2, 10)
colnames(x) = c("id","sum")
x = merge(x, map_genre, by.x="id", by.y="V2")
x = x[order(-x$sum),]


# Aggregating by Dataset
colnames(dataset) = c("id_user", "V1", "weight")
artists_weight_aggregate = aggregate(dataset$weight, by=list(dataset$V1), FUN=sum )
colnames(artists_weight_aggregate) = c("V1","weight_artist")
x = merge(artists_weight_aggregate, artist_genre_norm, by="V1")
x$all_weights = x$weight_artist * x$V3

group_all_weights = aggregate(x$all_weights, by=list(x$V2), FUN=sum )
group_all_weights = group_all_weights[order(-group_all_weights$x),]
sum_all_weights = sum(group_all_weights$x)

group_all_weights$normalized = group_all_weights$x / sum_all_weights
group_all_weights = group_all_weights[,c(1,3)]
colnames(group_all_weights) = c("id","sum")

group_all_weights = merge(group_all_weights, map_genre, by.x="id", by.y="V2")
group_all_weights = group_all_weights[order(-group_all_weights$sum),]
group_all_weights = group_all_weights[,c(3,2)]
head(group_all_weights, 10)

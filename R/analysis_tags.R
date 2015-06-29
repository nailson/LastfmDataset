

# READ FILES
artist_tags_norm <- read.delim("../new data/artist relation/artist_tags_norm.tsv", header=F)
dataset <- read.delim("../new data/dataset.tsv", header=F)
map_tags <- read.delim("../new data/map/map_tags.tsv", header=F)

artist_tags_norm = artist_tags_norm[artist_tags_norm$V1%in%dataset$V2,]
length(unique(artist_tags_norm$V1))
plot(sort(artist_tags_norm$V3, decreasing=T), main="Weights by Tags", ylab = "Weight")

#Aggregating Artist by length of Tags
artist_aggregate = aggregate(artist_tags_norm$V1, by=list(artist_tags_norm$V1), FUN=length )
artist_aggregate = artist_aggregate[order(-artist_aggregate$x),]
summary(artist_aggregate$x)
hist(artist_aggregate$x)

#Aggregating Genre by Weight
tag_aggregate = aggregate(artist_tags_norm$V3, by=list(artist_tags_norm$V2), FUN=sum )
tag_aggregate = tag_aggregate[order(-tag_aggregate$x),]
summary(tag_aggregate$x)
plot(tag_aggregate$x, main="Aggregation of sum of weights by Tag", ylab = "Aggregate Weight")
x = head(tag_aggregate, 10)
colnames(x) = c("id","sum")
x = merge(x, map_tags, by.x="id", by.y="V2")
x = x[order(-x$sum),]

# Aggregating Genre by Length
genre_aggregate2 = aggregate(artist_tags_norm$V1, by=list(artist_tags_norm$V2), FUN=length )
genre_aggregate2 = genre_aggregate2[order(-genre_aggregate2$x),]
plot(sort(genre_aggregate2$x,decreasing=T))
x = head(genre_aggregate2, 10)
colnames(x) = c("id","sum")
x = merge(x, map_tags, by.x="id", by.y="V2")
x = x[order(-x$sum),]
summary(genre_aggregate2$x)



# Aggregating by Dataset
colnames(dataset) = c("id_user", "V1", "weight")
artists_weight_aggregate = aggregate(dataset$weight, by=list(dataset$V1), FUN=sum )
colnames(artists_weight_aggregate) = c("V1","weight_artist")
x = merge(artists_weight_aggregate, artist_tags_norm, by="V1")
x$all_weights = x$weight_artist * x$V3

group_all_weights = aggregate(x$all_weights, by=list(x$V2), FUN=sum )
group_all_weights = group_all_weights[order(-group_all_weights$x),]
sum_all_weights = sum(group_all_weights$x)

group_all_weights$normalized = group_all_weights$x / sum_all_weights
group_all_weights = group_all_weights[,c(1,3)]
colnames(group_all_weights) = c("id","sum")

group_all_weights = merge(group_all_weights, map_tags, by.x="id", by.y="V2")
group_all_weights = group_all_weights[order(-group_all_weights$sum),]
group_all_weights = group_all_weights[,c(3,2)]
summary(group_all_weights$sum)
head(group_all_weights, 10)

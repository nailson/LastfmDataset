

# READ FILES
artist_origin__norm <- read.delim("~/GitHub/LastfmDataset/new data/artist relation/artist_origin__norm.tsv", header=F)
dataset <- read.delim("../new data/dataset.tsv", header=F)
map_origin <- read.delim("~/GitHub/LastfmDataset/new data/map/map_origin.tsv", header=F, dec=",")

artist_origin__norm = artist_origin__norm[artist_origin__norm$V1%in%dataset$V2,]
length(unique(artist_origin__norm$V2))
plot(sort(artist_origin__norm$V3, decreasing=T), main="Weights by Origin", ylab = "Weight")

#Aggregating Artist by length of Tags
artist_aggregate = aggregate(artist_origin__norm$V1, by=list(artist_origin__norm$V1), FUN=length )
artist_aggregate = artist_aggregate[order(-artist_aggregate$x),]
summary(artist_aggregate$x)
hist(artist_aggregate[ artist_aggregate$x<6,c("x")] , main="Histogram subjects by Artists", xlab = "Number of Subjects")


#Aggregating Genre by Weight
sub_aggregate = aggregate(artist_origin__norm$V3, by=list(artist_origin__norm$V2), FUN=sum )
sub_aggregate = sub_aggregate[order(-sub_aggregate$x),]
summary(sub_aggregate$x)
plot(sub_aggregate$x[c(-1)], main="Aggregation of sum of weights by Origin", ylab = "Aggregate Weight")
x = head(sub_aggregate[c(-1),], 10)
colnames(x) = c("id","sum")
x = merge(x, map_origin, by.x="id", by.y="V1")
x = x[order(-x$sum),]



# Aggregating by Dataset
colnames(dataset) = c("id_user", "V1", "weight")
artists_weight_aggregate = aggregate(dataset$weight, by=list(dataset$V1), FUN=sum )
colnames(artists_weight_aggregate) = c("V1","weight_artist")
x = merge(artists_weight_aggregate, artist_origin__norm, by="V1")
x$all_weights = x$weight_artist * x$V3

group_all_weights = aggregate(x$all_weights, by=list(x$V2), FUN=sum )
group_all_weights = group_all_weights[order(-group_all_weights$x),]
sum_all_weights = sum(group_all_weights$x)

group_all_weights$normalized = group_all_weights$x / sum_all_weights
group_all_weights = group_all_weights[,c(1,3)]
colnames(group_all_weights) = c("id","sum")

group_all_weights = merge(group_all_weights, map_origin, by.x="id", by.y="V1")
group_all_weights = group_all_weights[order(-group_all_weights$sum),]
group_all_weights = group_all_weights[,c(3,2)]
summary(group_all_weights$sum)
head(group_all_weights, 10)
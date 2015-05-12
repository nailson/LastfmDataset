
# get only th artists that have genre information
artists_category <- read.delim("~/GitHub/LastfmDataset/data/artists_category.tsv", header=F)

user_id = data.frame( username = sort(unique(artist_user$V1)))
user_id$id = c(1:length(user_id$username))

write.table(user_id, file="user_table.tsp", sep="\t", row.names=F, col.names=F, quote=F)

new_dataset =  merge(artist_user, user_id, by.x="V1", by.y="username")
colnames(new_dataset) = c("username", "mbid", "weight", "id_user")

mapping_LF_dbpedia_artists <- read.delim("~/GitHub/LastfmDataset/data/mapping_LF_dbpedia_artists.tsv", header=F, dec=",", quote="'")
new_dataset2 = merge( new_dataset, x, by.x="mbid", by.y="V3" )
dataset = new_dataset2[,c("id_user", "V1", "weight")]
colnames(dataset) = c("id_user", "V1", "weight")

write.table(dataset, file="dataset.tsv", sep="\t", row.names=F, col.names=F, quote=F)


# some analysis from data
user_aggregate = aggregate(dataset$id_user, by=list(dataset$id_user), FUN=length )
summary(user_aggregate$x)
boxplot(user_aggregate$x)
hist(user_aggregate$x)

# remove users with less than 20 artists
users_coldstart = user_aggregate[ user_aggregate$x < 30, 1]
dataset = dataset[ !(dataset$id_user%in%users_coldstart), ]

# analysis of user weight
weight_aggregate = aggregate(dataset$weight, by=list(dataset$id_user), FUN=sum )
summary(weight_aggregate$x)
plot(sort(weight_aggregate$x))
boxplot(weight_aggregate$x[weight_aggregate$x<50000])

length(weight_aggregate$x[weight_aggregate$x<50000])
users_outliers = weight_aggregate[weight_aggregate$x>100000,1]
dataset = dataset[ !(dataset$id_user%in%users_outliers), ]

# aggregate of length artists
artists_aggregate = aggregate(dataset$V1, by=list(dataset$V1), FUN=length )
summary(artists_aggregate$x)
plot(sort(artists_aggregate$x))
head(artists_aggregate[order(-artists_aggregate$x),])

# aggregate of artists weight
artists_weight_aggregate = aggregate(dataset$weight, by=list(dataset$V1), FUN=sum )
summary(artists_weight_aggregate$x)
plot(sort(artists_weight_aggregate$x))
artists_weight_aggregate = artists_weight_aggregate[order(-artists_weight_aggregate$x),]
head(artists_weight_aggregate, n=10)
plot(artists_weight_aggregate[c(1:1000),c("x")])

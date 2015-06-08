
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
hist(user_aggregate$x, main="number of Artists in User profile", xlab = "Artists in profile")

# remove users with less than 30 artists
users_coldstart = user_aggregate[ user_aggregate$x < 50, 1]
dataset = dataset[ !(dataset$id_user%in%users_coldstart), ]

# remove profiles with more than 200 relations
length(user_aggregate[ user_aggregate$x > 200, 1])
head(user_aggregate[ user_aggregate$x > 200, ], n=20)
split.data <- split(dataset, dataset$id_user)
subsetted.data <- lapply(split.data, FUN = function(x) head(x, 200)) # or ..., FUN = head, 5) like above
dataset <- do.call("rbind", subsetted.data)
head(dataset)


# analysis of user weight
weight_aggregate = aggregate(as.numeric(dataset$weight), by=list(dataset$id_user), FUN=sum )
summary(weight_aggregate$x)
plot(sort(weight_aggregate$x), main="Aggregation of sum of weights by User", ylab = "Aggregate Weight")
boxplot(weight_aggregate$x,outline = F)

length(weight_aggregate$x[weight_aggregate$x<120000])

users_outliers = weight_aggregate[weight_aggregate$x>200000,1]
x = dataset[ (dataset$id_user==users_outliers), ]
dataset = dataset[ !(dataset$id_user%in%users_outliers), ]

# aggregate of length artists
artists_aggregate = aggregate(dataset$V1, by=list(dataset$V1), FUN=length )
summary(artists_aggregate$x)
plot(sort(artists_aggregate$x))
head(artists_aggregate[order(-artists_aggregate$x),],n=20)
length(artists_aggregate[artists_aggregate$x<5,1])

# aggregate of artists weight
artists_weight_aggregate = aggregate(dataset$weight, by=list(dataset$V1), FUN=sum )
summary(artists_weight_aggregate$x)
plot(sort(artists_weight_aggregate$x), main="Aggregation of sum of weights by Artist", ylab = "Aggregate Weight")
artists_weight_aggregate = artists_weight_aggregate[order(-artists_weight_aggregate$x),]
head(artists_weight_aggregate[order(-artists_weight_aggregate$x),], n=10)
plot(artists_weight_aggregate[c(1:1000),c("x")])

# removing low weights
summary(dataset$weight)
plot(sort(log(dataset$weight, base=10)), main="Sorted User weight", ylab = "Weight", )
boxplot(dataset$weight, outline=F)
usersoutlier = dataset[dataset$weight > 50000,1]

x = dataset[ (dataset$id_user==usersoutlier), ]
dataset = dataset[ !(dataset$id_user%in%usersoutlier), ]

length(dataset[dataset$weight < 10,1])

dataset = dataset[dataset$weight >= 10,]

dataset[dataset$id_user==91,]

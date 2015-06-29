
# READ DATASET
dataset <- read.delim("../new data/dataset.tsv", header=F)
colnames(dataset) = c("id_user", "V1", "weight")

#write.table(dataset, file="dataset.tsv", sep="\t", row.names=F, col.names=F, quote=F)


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

length(weight_aggregate$x[weight_aggregate$x>200000])

users_outliers = weight_aggregate[weight_aggregate$x>300000,1]
x = dataset[ (dataset$id_user%in%users_outliers), ]
dataset = dataset[ !(dataset$id_user%in%users_outliers), ]


# aggregate of length artists
artists_aggregate = aggregate(dataset$V1, by=list(dataset$V1), FUN=length )
summary(artists_aggregate$x)
boxplot(artists_aggregate$x, outline=F)
plot(sort(artists_aggregate$x,decreasing = T), main="Frequency of Artists in Profile", ylab = "Frequency")
head(artists_aggregate[order(-artists_aggregate$x),],n=20)
length(artists_aggregate[artists_aggregate$x<5,1])

# aggregate of artists weight
artists_weight_aggregate = aggregate(dataset$weight, by=list(dataset$V1), FUN=sum )
summary(artists_weight_aggregate$x)
plot(sort(artists_weight_aggregate$x, decreasing = T), main="Aggregation of sum of weights by Artist", ylab = "Aggregate Weight")
artists_weight_aggregate = artists_weight_aggregate[order(-artists_weight_aggregate$x),]
head(artists_weight_aggregate[order(-artists_weight_aggregate$x),], n=10)
plot(artists_weight_aggregate[c(1:500),c("x")])
sum_top = sum(artists_weight_aggregate[ c(1:500), c("x")])
sum_all = sum(artists_weight_aggregate[ , c("x")]) 
percentage = sum_top / sum_all

# removing low weights
summary(dataset$weight)
plot(sort(log(dataset$weight, base=10),decreasing=T), main="Sorted User weight", ylab = "Weight (log 10)", )
boxplot(dataset$weight, outline=F)
usersoutlier = dataset[dataset$weight > 40000,1]

x = dataset[ (dataset$id_user%in%usersoutlier), ]
dataset = dataset[ !(dataset$id_user%in%usersoutlier), ]

length(dataset[dataset$weight < 10,1])

dataset = dataset[dataset$weight >= 10,]

dataset[dataset$id_user==91,]



artists_weight_aggregate = aggregate(dataset$normalized, by=list(dataset$V1), FUN=sum )
plot(sort(artists_weight_aggregate$x))
x = artists_weight_aggregate[order(-artists_weight_aggregate$x),]
x = dataset[ (dataset$id_user==usersoutlier), ]
dataset = dataset[ !(dataset$id_user%in%usersoutlier), ]

summary(artists_weight_aggregate$x)


plot(sort(dataset$normalized))
usersoutlier = dataset[dataset$normalized > 0.4,1]
x = dataset[ (dataset$id_user%in%usersoutlier), ]
dataset = dataset[ !(dataset$id_user%in%usersoutlier), ]
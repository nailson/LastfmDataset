

map_genre <- read.delim("~/GitHub/LastfmDataset/new data/map/map_genre.tsv", header=F)

artist_genre <- read.delim("~/GitHub/LastfmDataset/new data/artist relation/artist_genre.tsv", header=F)

x = artist_genre[!(artist_genre$V2%in%map_genre$V1),]

x = data.frame( V1 = unique(x$V2))

length(x$V1)
1510+1679
x$V2 = c(1511:3189)

map_genre = rbind(map_genre, x)

map_genre = map_genre[, c(2,1)]

colnames(map_genre) = c("id_genre", "V2")

new_artist_genre = merge(artist_genre, map_genre, by="V2")

new_artist_genre = new_artist_genre[order(new_artist_genre$V1, new_artist_genre$id_genre), c(2,3)]

write.table(new_artist_genre, file="artist_genre_final.tsv", col.names=F, row.names=F, quote=F, sep="\t")

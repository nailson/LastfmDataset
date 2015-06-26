
# READ FILES
map_genre <- read.delim("../new data/map/map_genre.tsv", header=F)
artist_genre <- read.delim("../new data/artist relation/artist_genre.tsv", header=F)


# NOT in MAP
x = artist_genre[!(artist_genre$V2%in%map_genre$V1),]
x = data.frame( V1 = unique(x$V2))
#x = x[order(x$V1),]
#write.table(x, file="new_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")

# NEW ID TO NEW GENRE
length_id = length(map_genre$V1)+1
x$V2 = c(length_id:(length_id+length(x$V1) - 1))

# BIND NEW GENRES TO MAP
map_genre = rbind(map_genre, x)
map_genre = map_genre[, c(2,1)]
colnames(map_genre) = c("id_genre", "V2")
map_genre = unique(map_genre)
length(unique(map_genre$V2))
#write.table(map_genre, file="map_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")


# CHANGE URL TO ID IN ARTIST_GENRE FILE
new_artist_genre = merge(artist_genre, map_genre, by="V2")
new_artist_genre = new_artist_genre[order(new_artist_genre$V1, new_artist_genre$id_genre), c(2,3)]
new_artist_genre = new_artist_genre[order(new_artist_genre$V1, new_artist_genre$id_genre),]

# WRITE NEW FINAL ARTIST_GENRE_FINAL
write.table(new_artist_genre, file="artist_genre_final.tsv", col.names=F, row.names=F, quote=F, sep="\t")

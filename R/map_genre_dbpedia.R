

all_MusicGenre_dbpedia <- read.table("../new data/dbpedia relations/all_MusicGenre_dbpedia.tsv", quote="")
map_genre <- read.delim("../new data/map/map_genre.tsv", header=F)



z = data.frame( V1 = all_MusicGenre_dbpedia[ !(all_MusicGenre_dbpedia$V1%in%map_genre$V1), ])
z = unique(z)
length_id = length(map_genre$V1)+1
z$V2 = c(length_id:(length_id+length(z$V1) - 1))

z = rbind(map_genre, z)
map_genre = rbind(map_genre, z)
map_genre = map_genre[, c(2,1)]
colnames(map_genre) = c("id_genre", "V2")
#write.table(map_genre, file="map_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")

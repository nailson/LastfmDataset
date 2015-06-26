
# READ TABLE
dataset <- read.delim("../new data/dataset.tsv", header=F)
artist_id_genre <- read.delim("../new data/artist relation/artist_genre_final.tsv", header=F)
map_dbpedia <- read.delim("../new data/map/map_dbpedia.tsv", header=F, quote="")


# FIND ARTISTS THAT NOT HAVE GENRE
x = data.frame( V1 = unique(dataset[!(dataset$V2%in%artist_id_genre$V1),2]))

# MERGE WITH MAP DBPEDIA
x = merge(x,map_dbpedia, by="V1")



# WRITE NOT HAVE GENRE
write.table(x, file="not_have_genre.tsv", col.names=F, row.names=F, sep="\t", quote=F )


# READ FILES
artists_origin <- read.delim("../new data/artist relation/artists_origin.tsv", header=F)
dataset <- read.delim("../new data/dataset.tsv", header=F)
map_dbpedia <- read.delim("../new data/map/map_dbpedia.tsv", header=F)
all_artist_origin <- read.delim("C:/Users/Nailson/Dropbox/UFCG/Arquivos/all Artists from dbpedia with origin", header=F)

# FIND ARTISTS THAT NOT HAVE TAGS
x = data.frame( V1 = unique(dataset[ !(dataset$V2%in%artists_origin$V1),2]) )

# MERGE WITH MAP ARTISTS
x = merge(x,map_dbpedia, by="V1")
x = unique(x)
x = x[order(x$V1),]
#write.table(x, file="not_have_origin.tsv", col.names=F, row.names=F, quote=F, sep="\t")


# MERGE WITH MAP ALL SUBJECTS
colnames(all_artist_origin) = c("url","orig")
z = merge(x, all_artist_origin, by.x="V2", by.y="url")
z = z[,c(2,3)]
z = z[order(z$V1),]
colnames(z) = c("V1","V2")

artists_origin = rbind(artists_origin, z)
artists_origin = unique(artists_origin)
artists_origin = artists_origin[order(artists_origin$V1), ]
write.table(artists_origin, file="artists_origin.tsv", col.names=F, row.names=F, quote=F, sep="\t")

# rbind 
artists_origin = rbind(artists_origin, artist_origin2)
artists_origin = unique(artists_origin)
artists_origin$V1 = as.numeric(artists_origin$V1)
artists_origin = artists_origin[order(artists_origin$V1),]
write.table(artists_origin, file="artists_origin.tsv", col.names=F, row.names=F, quote=F, sep="\t")

# READ FILES
artist_AssociatedMA <- read.delim("../new data/artist relation/artist_AssociatedMA.tsv", header=F)
dataset <- read.delim("../new data/dataset.tsv", header=F)
map_dbpedia <- read.delim("../new data/map/map_dbpedia.tsv", header=F)
all_Artists_AssociatedMA <- read.delim("C:/Users/Nailson/Dropbox/UFCG/Arquivos/all Artists from dbpedia with associatedMusicalArtist", header=F)


# FIND ARTISTS THAT NOT HAVE TAGS
x = data.frame( V1 = unique(dataset[ !(dataset$V2%in%artist_AssociatedMA$V1),2]) )

# MERGE WITH MAP ARTISTS
x = merge(x,map_dbpedia, by="V1")
x = unique(x)
x = x[order(x$V1),]
#write.table(x, file="not_have_AssociatedMA.tsv", col.names=F, row.names=F, quote=F, sep="\t")


colnames(all_Artists_AssociatedMA) = c("url","subj")
z = merge(x, all_Artists_AssociatedMA, by.x="V2", by.y="url")
z = z[,c(2,3)]
colnames(z) = c("V1","V2")


artist_AssociatedMA = rbind(artist_AssociatedMA, z)
artist_AssociatedMA = unique(artist_AssociatedMA)
artist_AssociatedMA$V1 = as.numeric(artist_AssociatedMA$V1)
artist_AssociatedMA = artist_AssociatedMA[order(artist_AssociatedMA$V1), ]
write.table(artist_AssociatedMA, file="artist_AssociatedMA.tsv", col.names=F, row.names=F, quote=F, sep="\t")

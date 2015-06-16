

artist_tags <- read.delim("../new data/artist relation/artist_tags.tsv", header=F)

dataset <- read.delim("../new data/dataset.tsv", header=F)

x = data.frame( V1 = unique(dataset[ !(dataset$V2%in%artist_tags$V1),2]) )

map_artists <- read.delim("../new data/map/map_artists.tsv", header=FALSE, quote="")

x = merge(x,map_artists, by="V1")

x = x[,c(1,4)]
y = unique(x[ x$V2!="","V2"])
write.table(y[,2], file="not_have_tag_mbid.tsv", col.names=F, row.names=F, quote=F, sep="\n")

y = unique(x[ x$V3.x!="","V3.x"])
write.table(y, file="not_have_tag_name.tsv", col.names=F, row.names=F, quote=F, sep="\n")

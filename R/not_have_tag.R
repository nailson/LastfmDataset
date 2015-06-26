
# READ FILES
artist_tags <- read.delim("../new data/artist relation/artist_tags.tsv", header=F)
dataset <- read.delim("../new data/dataset.tsv", header=F)
map_artists <- read.delim("../new data/map/map_artists.tsv", header=FALSE, quote="")


# FIND ARTISTS THAT NOT HAVE TAGS
x = data.frame( V1 = unique(dataset[ !(dataset$V2%in%artist_tags$V1),2]) )

# MERGE WITH MAP ARTISTS
x = merge(x,map_artists, by="V1")


# WRITE NOT HAVE LIST BY MBID
y = unique(x[ x$V2!="","V2"])
write.table(y, file="not_have_tag_mbid.tsv", col.names=F, row.names=F, quote=F, sep="\n")

# WRITE NOT HAVE LIST BY NAME
y = unique(x[ x$V3!="","V3"])
write.table(y, file="not_have_tag_name.tsv", col.names=F, row.names=F, quote=F, sep="\n")

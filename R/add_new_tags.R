
# READ FILES
artist_tags <- read.delim("../new data/artist relation/artist_tags.tsv", header=F)
map_artists <- read.delim("../new data/map/map_artists.tsv", header=FALSE, quote="")
map_tags <- read.delim("../new data/map/map_tags.tsv", header=FALSE, quote="")
tags <- read.delim("tags.tsv", header=FALSE, quote="")

# NOT IN MAP
x = data.frame( V1 = unique(dataset[ !(dataset$V2%in%artist_tags$V1),2]) )

# MERGE NOT TAGS WITH MAP TAGS
x = merge(x,map_artists, by="V1")
x = merge(x, tags, by.x="V2.x", by.y = "artistMbid")
x = unique(x)
x = x[ ,c("V1","tagname","tagcount") ]

#
not_tag = x[ !(x$tagname%in%map_tags$names), ]
not_tag = unique(not_tag$tagname)
new_tag = data.frame( names = new_tag, id= c(265025: 298966) )

#
map_tags = rbind(map_tags, new_tag)
map_tags = unique(map_tags)
write.table(map_tags, file="map_tags.tsv", col.names=F, row.names=F, quote=F, sep="\t")

#
tag_by_name = merge(z, map_tags, by.x="tagname", by.y="names")
tag_by_name = tag_by_name[,c("V1","id","tagcount")]
colnames(tag_by_name) = c("V1","V2","V3")

artist_tags = rbind(artist_tags, tag_by_name)

# WRITE FILES
write.table(artist_tags, file="artist_tags.tsv", col.names=F, row.names=F, quote=F, sep="\t")

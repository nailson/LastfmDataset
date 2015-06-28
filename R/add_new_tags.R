
# READ FILES
artist_tags <- read.delim("../new data/artist relation/artist_tags_final.tsv", header=F)
map_artists <- read.delim("../new data/map/map_artists.tsv", header=FALSE, quote="")
map_tags <- read.delim("../new data/map/map_tags.tsv", header=FALSE, quote="")
tags <- read.delim("tags.tsv", header=FALSE, quote="")
dataset <- read.delim("../new data/dataset.tsv", header=F)

# NOT IN MAP
x = data.frame( V1 = unique(dataset[ !(dataset$V2%in%artist_tags$V1),2]) )

# MERGE NOT TAGS WITH MAP TAGS
x = merge(x,map_artists, by="V1")
x = unique(x)
x = x[ ,c("V1","tagname","tagcount") ]
write.table(x, file="new_genre.tsv", col.names=F, row.names=F, quote=F, sep="\t")

# INSERT NEW TAGS
not_tag = x[ !(tolower(x$tagname)%in%tolower(map_tags$V1)), ]
not_tag = unique(not_tag$tagname)

length_map = tail(map_tags$V2,1)
new_tag = data.frame( names = not_tag, id= c((length_map+1): (length_map+length(not_tag))) )
colnames(new_tag) = colnames(map_tags)

# BIND INTO MAP TAGS
map_tags = rbind(map_tags, new_tag)
map_tags = unique(map_tags)
write.table(map_tags, file="map_tags.tsv", col.names=F, row.names=F, quote=F, sep="\t")


#
tag_by_name = merge(z, map_tags, by.x="tag", by.y="V1")
tag_by_name = tag_by_name[,c("V1","V2","weight")]
colnames(tag_by_name) = c("V1","V2","V3")

artist_tags = rbind(artist_tags, tag_by_name)

# WRITE FILES
write.table(artist_tags, file="artist_tags.tsv", col.names=F, row.names=F, quote=F, sep="\t")


# by mbid
tags_mbid <- read.delim("C:/Users/Nailson/Dropbox/tags_mbid.txt", header=F)
colnames(tags_mbid) = c("mbid","tag","weight","url")

new_tags = merge(tags_mbid, map_artists, by.x="mbid", by.y="V2")
new_tags = unique(new_tags)
new_tags = new_tags[,c("V1","tag","weight")]
new_tags = new_tags[ new_tags$weight>0, ]

colnames(new_tags) = c("id","tag","weight")
tag_by_name = merge(new_tags, map_tags, by.x="tag", by.y="V1")
tag_by_name = tag_by_name[,c("id","V2", "weight")]
colnames(tag_by_name) = c("V1","V2","V3")

tag_by_name = unique(tag_by_name)
artist_tags = rbind(artist_tags, tag_by_name)
artist_tags = artist_tags[order(artist_tags$V1, -artist_tags$V3, artist_tags$V2),]
artist_tags = unique(artist_tags)
write.table(artist_tags, file="artist_tags.tsv", col.names=F, row.names=F, quote=F, sep="\t")

# by name

tags_name <- read.delim("C:/Users/Nailson/Dropbox/tags_name.txt", header=F)

tags_name$V1 = apply(tags_name, 1,  FUN=URLdecode )
tags_name[tags_name$V1%in%x$V3,]
colnames(tags_name) = c("name","tag","weight","url")
z = merge(tags_name, x , by.x="name", by.y="V3")
z = z[,c("V1","tag","weight")]
z = unique(z)
z = z[z$weight>0,]


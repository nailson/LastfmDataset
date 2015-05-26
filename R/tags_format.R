
tags = tags[-1,]

colnames(tags) = c("mbid", "name","count", "url")

tags_name =  unique(tags$name)
tags_name = data.frame(id=c(1:length(tags_name)), name = tags_name)

write.table(map_tags, file="map_tags.tsv", col.names = T, row.names = F, sep="\t", quote = F)

tags$name = as.character(tags$name)
tags_id$name = as.character(tags_id$name)

new_tags = merge(tags, tags_id, by.x="name", by.y="id")

new_tags = merge(new_tags, mapping_lf_dbpedia_artists, by.x="mbid", by.y="V4")

new_tags = data.frame ( artist_id = new_tags$V1, tag_id = new_tags$id, weigth = new_tags$count)

new_tags = new_tags[order(new_tags$artist_id, new_tags$tag_id),]

write.table(tags, file="tags.tsv", col.names = F, row.names = F, sep="\t", quote = F)


new_tags = y
new_tag = aggregate(new_tags$artist_id, by=list(new_tags$artist_id), FUN=length)

x = unique(new_tags$artist_id, new_tags$tag_id, new_tags$)

x = data.frame(id=x)
y = merge(x, mapping_lf_dbpedia_artists, by.y="V1", by.x="id")
y=unique(y)



new_tag = aggregate(.~artist_id, new_tags, FUN=head, 10)
setkey(new_tags,artist_id)
new_tag = new_tags[,lapply(.artist_id,function(x) head(x,10)),by = key(new_tags)]
id=c(251179:length(x)

x =  tags[!(unique(tags$name)%in%tags_id$name),c("name")]
x = data.frame(id=c(251179:251199), name=x)
tags_id = rbind(tags_id, x)



mapping_LF_dbpedia_artists = mapping_LF_dbpedia_artists[mapping_LF_dbpedia_artists$V1%in%artists_category2$V1,]


new_tag = merge(tags, tags_id, by.x="name", by.y="name")

new_tag$mbid = sapply(as.character(new_tag$mbid), URLdecode, USE.NAMES = FALSE)

new_tag2 = merge(new_tag,mapping_LF_dbpedia_artists, by.x="mbid", by.y="V3")
new_tag = new_tag2[,c("V1","id","count")]
colnames(new_tag) = c("artist_id","tag_id","weigth")
x = rbind(x, new_tag)

x = unique(x)
x = x[,c("V1","id","count")]

colnames(new_tags) = c("artist_id","tag_id","weigth")
colnames(x) = c("artist_id","tag_id","weigth")
x = rbind(new_tags, x)
x = unique(x)
x = x[order(x$artist_id, x$tag_id, x$weigth),]

write.table(y$V4, file="artists_name.tsv", col.names = T, row.names = F, sep="\t", quote = F)



tags = merge(tags, mapping_LF_dbpedia_artists, by.x="artistMbid.", by.y="V4")


tags = merge(tags, mapping_LF_dbpedia_artists, by.x="artistMbid.", by.y="V4")


new_tags$V1 =  sapply(as.character(new_tags$V1), URLdecode, USE.NAMES = FALSE)

tags1= merge(new_tags, mapping_LF_dbpedia_artists, by.x="V1", by.y="V3")

x = merge(tags1, map_tags, by.x="V2.x", by.y="names")
new_tags_new_new = x[,c("V1","id","V3")]


tags2= merge(new_tagsmbid, mapping_LF_dbpedia_artists, by.x="artistMbid.", by.y="V4")


new_nome = data.frame( nomes = unique(tags1$V2.x[!(tags1$V2.x%in%map_tags$names)]) )
new_nome$id = c(251560:251709)

map_tags = rbind(map_tags, new_nome)
colnames(map_tags)
colnames(new_nome) = c("names","id")

unique(tags1$V2.x)

not_tag = data.frame(V1=not_tag)
not_tag = merge(not_tag, mapping_LF_dbpedia_artists, by.x="V1", by.y="V4")
